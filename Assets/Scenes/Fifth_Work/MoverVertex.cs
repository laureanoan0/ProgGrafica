using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MoverVertex : MonoBehaviour
{
    [SerializeField] private Material mat;
    [SerializeField] private Vector3 vertices;
    void Start()
    {
        
    }

    void Update()
    {
        mat.SetVector("_Vector0", vertices);
    }
}
