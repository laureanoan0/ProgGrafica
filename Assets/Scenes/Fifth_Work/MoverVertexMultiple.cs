using UnityEngine;

public class MoverVertexMultiple : MonoBehaviour
{
    [SerializeField] private Material mat;
    [SerializeField] private Renderer rend;
    private MaterialPropertyBlock propBlock;
    [SerializeField] private Vector3 vertices;
    void Start()
    {
    }

    void Update()
    {
        rend.GetPropertyBlock(propBlock);
        propBlock.SetVector("_Vector0", vertices);
    }
}
