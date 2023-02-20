Shader "CG Labs/Lab 7"
{
	Properties
	{
		_ColorA("Color A", Color) = (0, 0, 0, 1)
		_ColorB("Color B", Color) = (1, 1, 1, 1)
		_ColorStart("Color Start", Range(0, 1)) = 0
		_ColorEnd("Color End", Range(0, 1)) = 1
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			#define INTERPOLATION

			float4 _ColorA;
			float4 _ColorB;
			float _ColorStart;
			float _ColorEnd;

			struct MeshData
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 uv0 : TEXCOORD0;
			};

			struct Interpolator
			{
				float4 vertex : SV_POSITION;
				float3 normal : TEXCOORD0;
				float2 uv : TEXCOORD1;
			};

			Interpolator vert(MeshData v)
			{
				Interpolator o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.normal);
				o.uv = v.uv0;
				return o;
			}

			float InverseLerp(
				float4 a,
				float4 b,
				float v)
			{
				return(v - a) / (b - a);
			}


			fixed4 frag(Interpolator i) : SV_Target
			{
				float t = InverseLerp(_ColorStart, _ColorEnd, i.uv.x);
				float4 col = lerp(_ColorA, _ColorB, t);
				return col;
			}
			ENDCG
		}
	}
}
