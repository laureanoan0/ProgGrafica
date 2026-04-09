// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/NewSurfaceShader"
{
	Properties
	{
		_Dirty_Floor("Dirty_Floor", 2D) = "white" {}
		_Altura("Altura", Float) = 0
		_Luz("Luz", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Dirty_Floor;
		uniform float4 _Dirty_Floor_ST;
		uniform float _Altura;
		uniform float _Luz;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_Dirty_Floor = v.texcoord * _Dirty_Floor_ST.xy + _Dirty_Floor_ST.zw;
			float4 tex2DNode6 = tex2Dlod( _Dirty_Floor, float4( uv_Dirty_Floor, 0, 0.0) );
			v.vertex.xyz += ( tex2DNode6 * float4( float3(0,1,0) , 0.0 ) * _Altura ).rgb;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Dirty_Floor = i.uv_texcoord * _Dirty_Floor_ST.xy + _Dirty_Floor_ST.zw;
			float4 tex2DNode6 = tex2D( _Dirty_Floor, uv_Dirty_Floor );
			float4 clampResult13 = clamp( ( float4( float3(0,0.5,0) , 0.0 ) * tex2DNode6 * _Luz ) , float4( float3(-1,-1,-1) , 0.0 ) , float4( float3(1,0.5,1) , 0.0 ) );
			o.Albedo = clampResult13.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
367;73;1110;726;1284.666;291.6231;1;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;5;-855.9949,-3.325172;Inherit;True;Property;_Dirty_Floor;Dirty_Floor;0;0;Create;True;0;0;0;False;0;False;ceb1bacd3e5dc9b4cb4b85eb1a74cfb6;24631da459c605345ad590b3e0029366;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;6;-623.3954,-5.025186;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;11;-492.4501,-341.2617;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;0,0.5,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;12;-468.9033,-155.9902;Inherit;False;Property;_Luz;Luz;2;0;Create;True;0;0;0;False;0;False;0;6.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-203.9173,-200.9106;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;15;-217.1724,-68.62939;Inherit;False;Constant;_Vector3;Vector 3;3;0;Create;True;0;0;0;False;0;False;1,0.5,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;14;-219.0198,-356.5514;Inherit;False;Constant;_Vector2;Vector 2;3;0;Create;True;0;0;0;False;0;False;-1,-1,-1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;8;-480.3176,215.8114;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;9;-474.0862,376.1407;Inherit;False;Property;_Altura;Altura;1;0;Create;True;0;0;0;False;0;False;0;2.31;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-226.8098,205.3256;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;13;-4.831157,-199.1056;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;274.7308,-76.09914;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Custom/NewSurfaceShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;10;0;11;0
WireConnection;10;1;6;0
WireConnection;10;2;12;0
WireConnection;7;0;6;0
WireConnection;7;1;8;0
WireConnection;7;2;9;0
WireConnection;13;0;10;0
WireConnection;13;1;14;0
WireConnection;13;2;15;0
WireConnection;0;0;13;0
WireConnection;0;11;7;0
ASEEND*/
//CHKSM=5C81EAD45D8C16C31A1BCB5A1E4428DD531DA719