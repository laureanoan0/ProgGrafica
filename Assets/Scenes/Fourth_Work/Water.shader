// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Water"
{
	Properties
	{
		_flowmap("flowmap", 2D) = "white" {}
		_DistortionWeight("DistortionWeight", Range( 0 , 1)) = 0.3534118
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_PannerS("PannerS", Vector) = (1,0,0,0)
		_WaterTexture("WaterTexture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WaterTexture;
		uniform float2 _PannerS;
		uniform sampler2D _flowmap;
		uniform float4 _flowmap_ST;
		uniform float2 _Tiling;
		uniform float _DistortionWeight;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_flowmap = i.uv_texcoord * _flowmap_ST.xy + _flowmap_ST.zw;
			float4 tex2DNode9 = tex2D( _flowmap, uv_flowmap );
			float2 appendResult11 = (float2(tex2DNode9.r , tex2DNode9.g));
			float2 uv_TexCoord13 = i.uv_texcoord * _Tiling;
			float2 lerpResult14 = lerp( ( appendResult11 + uv_TexCoord13 ) , uv_TexCoord13 , _DistortionWeight);
			float2 panner17 = ( 1.0 * _Time.y * _PannerS + lerpResult14);
			o.Albedo = tex2D( _WaterTexture, panner17 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
157;73;1201;550;2840.158;-377.7554;1;True;False
Node;AmplifyShaderEditor.SamplerNode;9;-2096.189,-227.9915;Inherit;True;Property;_flowmap;flowmap;1;0;Create;True;0;0;0;False;0;False;-1;0268ed45060236046acfe284c6e03979;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;16;-2260.277,-9.28653;Inherit;False;Property;_Tiling;Tiling;3;0;Create;True;0;0;0;False;0;False;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;11;-1735.906,-168.3341;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-2057.442,-19.78276;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-1684.436,163.8752;Inherit;False;Property;_DistortionWeight;DistortionWeight;2;0;Create;True;0;0;0;False;0;False;0.3534118;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1560.443,-141.4301;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;14;-1375.622,-121.5442;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;19;-1242.903,75.72692;Inherit;False;Property;_PannerS;PannerS;4;0;Create;True;0;0;0;False;0;False;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;17;-1026.942,-141.2731;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;20;-1219.296,-471.9351;Inherit;True;Property;_WaterTexture;WaterTexture;5;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;21;-934.5667,-477.532;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-1963.511,331.9503;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-2370.512,204.9503;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;0,0.7357366,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;2;-2387.513,426.9502;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleTimeNode;5;-2673.513,419.9501;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2627.513,618.9503;Inherit;False;Property;_scale;scale;0;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;24;-2188.158,412.7554;Inherit;True;Sawtooth Wave;-1;;2;289adb816c3ac6d489f255fc3caf5016;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-362.8591,-415.851;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;9;1
WireConnection;11;1;9;2
WireConnection;13;0;16;0
WireConnection;12;0;11;0
WireConnection;12;1;13;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;14;2;15;0
WireConnection;17;0;14;0
WireConnection;17;2;19;0
WireConnection;21;0;20;0
WireConnection;21;1;17;0
WireConnection;3;0;1;0
WireConnection;3;1;24;0
WireConnection;2;1;5;0
WireConnection;2;2;6;0
WireConnection;24;1;2;0
WireConnection;0;0;21;0
ASEEND*/
//CHKSM=1A0D7999A66C4A92296F78F124AFE2AF1495B5A4