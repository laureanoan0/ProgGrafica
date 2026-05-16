using UnityEngine;


[RequireComponent(typeof(Camera))]
public class PostProcess : MonoBehaviour 
{
    
    [SerializeField] private Shader shader;
    private Material material;

    private void Awake()
    {
        material = new Material(shader);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, material);
    }
}
