using UnityEngine;

public sealed class Lab10 : MonoBehaviour
{
    [SerializeField] private Material _postprocessMaterial;
 
    void OnRenderImage(RenderTexture sourse, RenderTexture destination)
    {
        Graphics.Blit(sourse, destination, _postprocessMaterial);
    }
}
