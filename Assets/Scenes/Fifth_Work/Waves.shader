// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Waves"
{
	Properties
	{
		_LineSpeed("LineSpeed", Float) = 1
		_Frequency("Frequency", Float) = 1
		_Round("Round", Float) = 0
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_low("low", Color) = (0,1,0.04445076,0)
		_high("high", Color) = (1,0.5423229,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _LineSpeed;
		uniform float3 _Vector0;
		uniform float _Frequency;
		uniform float4 _low;
		uniform float4 _high;
		uniform float _Round;

		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _Round);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float mulTime36 = _Time.y * _LineSpeed;
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_21_0 = sin( ( mulTime36 + ( distance( ase_vertex3Pos , _Vector0 ) * _Frequency ) ) );
			v.vertex.xyz += ( temp_output_21_0 * float3(0,1,0) );
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime36 = _Time.y * _LineSpeed;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_21_0 = sin( ( mulTime36 + ( distance( ase_vertex3Pos , _Vector0 ) * _Frequency ) ) );
			float4 lerpResult50 = lerp( _low , _high , temp_output_21_0);
			o.Albedo = lerpResult50.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
155;73;1309;546;1021.44;483.7448;1.7421;True;True
Node;AmplifyShaderEditor.Vector3Node;39;-1109.017,-25.94592;Inherit;False;Property;_Vector0;Vector 0;3;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PosVertexDataNode;49;-1156.969,-189.5639;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;41;-924.678,-121.6236;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-817.8849,366.7759;Inherit;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;0;False;0;False;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-749.1643,-238.6804;Inherit;False;Property;_LineSpeed;LineSpeed;0;0;Create;True;0;0;0;False;0;False;1;-0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-671.9681,42.2906;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;36;-592.1572,-224.9019;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-490.2676,-21.50936;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;-120.7747,-424.5133;Inherit;False;Property;_low;low;4;0;Create;True;0;0;0;False;0;False;0,1,0.04445076,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;46;-241.2119,528.3593;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;48;42.52759,662.8165;Inherit;False;Property;_Round;Round;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;21;-278.7246,-18.60015;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;51;-134.7116,-250.3036;Inherit;False;Property;_high;high;5;0;Create;True;0;0;0;False;0;False;1,0.5423229,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;15.07017,351.0869;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;47;172.0448,507.7362;Inherit;False;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;50;259.003,-265.9825;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;399.9602,-13.48072;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Waves;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;41;0;49;0
WireConnection;41;1;39;0
WireConnection;31;0;41;0
WireConnection;31;1;32;0
WireConnection;36;0;35;0
WireConnection;37;0;36;0
WireConnection;37;1;31;0
WireConnection;21;0;37;0
WireConnection;44;0;21;0
WireConnection;44;1;46;0
WireConnection;47;0;48;0
WireConnection;50;0;52;0
WireConnection;50;1;51;0
WireConnection;50;2;21;0
WireConnection;0;0;50;0
WireConnection;0;11;44;0
WireConnection;0;14;47;0
ASEEND*/
//CHKSM=44744EE7C70F646B940ED32257C58FF4CF170015