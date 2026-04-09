// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/Texture_04"
{
	Properties
	{
		_Dirty_Floor("Dirty_Floor", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_Ston_Strenght("Ston_Strenght", Float) = 0.1
		_Ratio("Ratio", Float) = 0.5
		_Floor_Scale("Floor_Scale", Float) = 1
		_Floor_Strength("Floor_Strength", Float) = 0.5
		_Stoen_Height("Stoen_Height", Float) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Floor_Scale;
		uniform float _Floor_Strength;
		uniform float _Stoen_Height;
		uniform float _Ston_Strenght;
		uniform float _Ratio;
		uniform sampler2D _Dirty_Floor;
		uniform float4 _Dirty_Floor_ST;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float2 voronoihash14( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi14( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash14( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, 0.0);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float simplePerlin2D29 = snoise( ( v.texcoord.xy * _Floor_Scale ) );
			simplePerlin2D29 = simplePerlin2D29*0.5 + 0.5;
			float time14 = 0.0;
			float2 coords14 = ( v.texcoord.xy * float2( 10,6 ) ) * 1.0;
			float2 id14 = 0;
			float2 uv14 = 0;
			float voroi14 = voronoi14( coords14, time14, id14, uv14, 0 );
			float simplePerlin2D18 = snoise( ( v.texcoord.xy * float2( 15,8 ) ) );
			simplePerlin2D18 = simplePerlin2D18*0.5 + 0.5;
			float temp_output_22_0 = step( ( voroi14 + ( simplePerlin2D18 * _Ston_Strenght ) ) , _Ratio );
			float lerpResult32 = lerp( ( simplePerlin2D29 * _Floor_Strength ) , _Stoen_Height , temp_output_22_0);
			float3 clampResult36 = clamp( ( lerpResult32 * float3(0,1,0) ) , float3( 0,0,0 ) , float3( 1,0,0 ) );
			v.vertex.xyz += clampResult36;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Dirty_Floor = i.uv_texcoord * _Dirty_Floor_ST.xy + _Dirty_Floor_ST.zw;
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float time14 = 0.0;
			float2 coords14 = ( i.uv_texcoord * float2( 10,6 ) ) * 1.0;
			float2 id14 = 0;
			float2 uv14 = 0;
			float voroi14 = voronoi14( coords14, time14, id14, uv14, 0 );
			float simplePerlin2D18 = snoise( ( i.uv_texcoord * float2( 15,8 ) ) );
			simplePerlin2D18 = simplePerlin2D18*0.5 + 0.5;
			float temp_output_22_0 = step( ( voroi14 + ( simplePerlin2D18 * _Ston_Strenght ) ) , _Ratio );
			float4 lerpResult5 = lerp( tex2D( _Dirty_Floor, uv_Dirty_Floor ) , tex2D( _Texture0, uv_Texture0 ) , temp_output_22_0);
			o.Albedo = lerpResult5.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;0;1920;1019;1509.976;-417.455;1;True;False
Node;AmplifyShaderEditor.Vector2Node;17;-1221.306,764.3334;Inherit;False;Constant;_Vector0;Vector 0;2;0;Create;True;0;0;0;False;0;False;15,8;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1305.599,622.2876;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1268.943,321.5578;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;13;-1184.649,463.6036;Inherit;False;Constant;_Vector1;Vector 1;2;0;Create;True;0;0;0;False;0;False;10,6;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-968.305,697.3334;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-931.6493,396.6036;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;26;-571.4626,882.4493;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;18;-799.9666,692.2756;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-344.3438,980.4836;Inherit;False;Property;_Floor_Scale;Floor_Scale;4;0;Create;True;0;0;0;False;0;False;1;0.81;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-764.9667,808.2756;Inherit;False;Property;_Ston_Strenght;Ston_Strenght;2;0;Create;True;0;0;0;False;0;False;0.1;4.09;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-571.967,701.2756;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;14;-756.6493,397.6036;Inherit;False;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-340.9523,882.9484;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;29;-138.6015,876.7098;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;82.3985,1004.71;Inherit;False;Property;_Floor_Strength;Floor_Strength;5;0;Create;True;0;0;0;False;0;False;0.5;10.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-502.5601,520.0623;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-282.2681,624.7944;Inherit;False;Property;_Ratio;Ratio;3;0;Create;True;0;0;0;False;0;False;0.5;2.54;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;22;-272.2681,518.7944;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-7.31159,640.272;Inherit;False;Property;_Stoen_Height;Stoen_Height;6;0;Create;True;0;0;0;False;0;False;0.1;10.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;85.3985,908.7098;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-603.6755,58.33617;Inherit;True;Property;_Texture0;Texture 0;1;0;Create;True;0;0;0;False;0;False;None;ceb1bacd3e5dc9b4cb4b85eb1a74cfb6;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.Vector3Node;35;273.6574,622.7117;Inherit;False;Constant;_Vector2;Vector 2;7;0;Create;True;0;0;0;False;0;False;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;32;274.3984,490.7098;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;1;-606.6754,-149.6638;Inherit;True;Property;_Dirty_Floor;Dirty_Floor;0;0;Create;True;0;0;0;False;0;False;None;b97db8acddac10d4c867939fcd38e487;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;4;-371.0762,56.63616;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-374.0761,-151.3638;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;486.451,491.5228;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;5;12.62416,-38.51382;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.EdgeLengthTessNode;37;916.0098,508.1369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ClampOpNode;36;659.9913,490.4896;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;1,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;38;-1091.91,1105.377;Inherit;True;Property;_Texture1;Texture 1;7;0;Create;True;0;0;0;False;0;False;None;9f8d9d9e60979574ea22974d2e2c08d4;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;852.1862,-36.36076;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Custom/Texture_04;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;0
WireConnection;16;1;17;0
WireConnection;11;0;9;0
WireConnection;11;1;13;0
WireConnection;18;0;16;0
WireConnection;19;0;18;0
WireConnection;19;1;20;0
WireConnection;14;0;11;0
WireConnection;24;0;26;0
WireConnection;24;1;28;0
WireConnection;29;0;24;0
WireConnection;21;0;14;0
WireConnection;21;1;19;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;32;0;30;0
WireConnection;32;1;33;0
WireConnection;32;2;22;0
WireConnection;4;0;3;0
WireConnection;2;0;1;0
WireConnection;34;0;32;0
WireConnection;34;1;35;0
WireConnection;5;0;2;0
WireConnection;5;1;4;0
WireConnection;5;2;22;0
WireConnection;36;0;34;0
WireConnection;0;0;5;0
WireConnection;0;11;36;0
WireConnection;0;14;37;0
ASEEND*/
//CHKSM=9AED8CE18B49B1ED17B33AEB437C2EDE960F66B6