Shader "CG Labs/Lab 8"
{
	Properties
	{
		_Color("Tint", Color) = (0, 0, 0, 1)
		_MainTex("Texture", 2D) = "white" {}
		_Smoothness("Smoothness", Range(0, 1)) = 0
		_Metallic("Metalness", Range(0, 1)) = 0
		[HDR] _Emission("Emission", color) = (0,0,0)
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
		}

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		float4 _MainTex_ST;
		half3 _Emission;
		half _Smoothness;
		half _Metallic;

		struct Input
		{
			float4 screenPos;
		};


		void surf(Input i, inout SurfaceOutputStandard o)
		{
			float2 textureCoordinate = i.screenPos.xy / i.screenPos.w;
			float aspect = _ScreenParams.x / _ScreenParams.y;
			textureCoordinate.x = textureCoordinate.x * aspect;
			textureCoordinate = TRANSFORM_TEX(textureCoordinate, _MainTex);
			fixed col = tex2D(_MainTex, textureCoordinate);
			col *= _Color;
			o.Albedo = col;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Emission = _Emission;
		}
		ENDCG
	}
	FallBack "Standard"
}
