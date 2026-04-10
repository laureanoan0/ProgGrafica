using UnityEngine;

public class TP_Hologram : MonoBehaviour
{
    bool show = false;
    public Renderer Renderer;
   

    void Awake()
    {
        show = false;
    }

    private void Update()
    {
        Renderer.enabled = show;
        if (Input.GetKeyDown(KeyCode.Space))
        {
            show = !show;
        }
    }
}