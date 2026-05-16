// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Sobel"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Intensity("Intensity", Float) = 1

	}

	SubShader
	{
		LOD 0

		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			

			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _Intensity;


			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float4 color5 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
				float4 color7 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 localCenter138_g1 = uv_MainTex;
				float4 break12 = ( float4(1,1,1,1) * 0.002 );
				float temp_output_2_0_g1 = break12.x;
				float localNegStepX156_g1 = -temp_output_2_0_g1;
				float temp_output_3_0_g1 = break12.y;
				float localStepY164_g1 = temp_output_3_0_g1;
				float2 appendResult14_g85 = (float2(localNegStepX156_g1 , localStepY164_g1));
				float4 tex2DNode16_g85 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g85 ) );
				float temp_output_2_0_g85 = (tex2DNode16_g85).r;
				float temp_output_4_0_g85 = (tex2DNode16_g85).g;
				float temp_output_5_0_g85 = (tex2DNode16_g85).b;
				float localTopLeft172_g1 = ( sqrt( ( ( ( temp_output_2_0_g85 * temp_output_2_0_g85 ) + ( temp_output_4_0_g85 * temp_output_4_0_g85 ) ) + ( temp_output_5_0_g85 * temp_output_5_0_g85 ) ) ) * _Intensity );
				float2 appendResult14_g81 = (float2(localNegStepX156_g1 , 0.0));
				float4 tex2DNode16_g81 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g81 ) );
				float temp_output_2_0_g81 = (tex2DNode16_g81).r;
				float temp_output_4_0_g81 = (tex2DNode16_g81).g;
				float temp_output_5_0_g81 = (tex2DNode16_g81).b;
				float localLeft173_g1 = ( sqrt( ( ( ( temp_output_2_0_g81 * temp_output_2_0_g81 ) + ( temp_output_4_0_g81 * temp_output_4_0_g81 ) ) + ( temp_output_5_0_g81 * temp_output_5_0_g81 ) ) ) * _Intensity );
				float localNegStepY165_g1 = -temp_output_3_0_g1;
				float2 appendResult14_g84 = (float2(localNegStepX156_g1 , localNegStepY165_g1));
				float4 tex2DNode16_g84 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g84 ) );
				float temp_output_2_0_g84 = (tex2DNode16_g84).r;
				float temp_output_4_0_g84 = (tex2DNode16_g84).g;
				float temp_output_5_0_g84 = (tex2DNode16_g84).b;
				float localBottomLeft174_g1 = ( sqrt( ( ( ( temp_output_2_0_g84 * temp_output_2_0_g84 ) + ( temp_output_4_0_g84 * temp_output_4_0_g84 ) ) + ( temp_output_5_0_g84 * temp_output_5_0_g84 ) ) ) * _Intensity );
				float localStepX160_g1 = temp_output_2_0_g1;
				float2 appendResult14_g76 = (float2(localStepX160_g1 , localStepY164_g1));
				float4 tex2DNode16_g76 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g76 ) );
				float temp_output_2_0_g76 = (tex2DNode16_g76).r;
				float temp_output_4_0_g76 = (tex2DNode16_g76).g;
				float temp_output_5_0_g76 = (tex2DNode16_g76).b;
				float localTopRight177_g1 = ( sqrt( ( ( ( temp_output_2_0_g76 * temp_output_2_0_g76 ) + ( temp_output_4_0_g76 * temp_output_4_0_g76 ) ) + ( temp_output_5_0_g76 * temp_output_5_0_g76 ) ) ) * _Intensity );
				float2 appendResult14_g79 = (float2(localStepX160_g1 , 0.0));
				float4 tex2DNode16_g79 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g79 ) );
				float temp_output_2_0_g79 = (tex2DNode16_g79).r;
				float temp_output_4_0_g79 = (tex2DNode16_g79).g;
				float temp_output_5_0_g79 = (tex2DNode16_g79).b;
				float localRight178_g1 = ( sqrt( ( ( ( temp_output_2_0_g79 * temp_output_2_0_g79 ) + ( temp_output_4_0_g79 * temp_output_4_0_g79 ) ) + ( temp_output_5_0_g79 * temp_output_5_0_g79 ) ) ) * _Intensity );
				float2 appendResult14_g80 = (float2(localStepX160_g1 , localNegStepY165_g1));
				float4 tex2DNode16_g80 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g80 ) );
				float temp_output_2_0_g80 = (tex2DNode16_g80).r;
				float temp_output_4_0_g80 = (tex2DNode16_g80).g;
				float temp_output_5_0_g80 = (tex2DNode16_g80).b;
				float localBottomRight179_g1 = ( sqrt( ( ( ( temp_output_2_0_g80 * temp_output_2_0_g80 ) + ( temp_output_4_0_g80 * temp_output_4_0_g80 ) ) + ( temp_output_5_0_g80 * temp_output_5_0_g80 ) ) ) * _Intensity );
				float temp_output_133_0_g1 = ( ( localTopLeft172_g1 + ( localLeft173_g1 * 2 ) + localBottomLeft174_g1 + -localTopRight177_g1 + ( localRight178_g1 * -2 ) + -localBottomRight179_g1 ) / 6.0 );
				float2 appendResult14_g83 = (float2(0.0 , localStepY164_g1));
				float4 tex2DNode16_g83 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g83 ) );
				float temp_output_2_0_g83 = (tex2DNode16_g83).r;
				float temp_output_4_0_g83 = (tex2DNode16_g83).g;
				float temp_output_5_0_g83 = (tex2DNode16_g83).b;
				float localTop175_g1 = ( sqrt( ( ( ( temp_output_2_0_g83 * temp_output_2_0_g83 ) + ( temp_output_4_0_g83 * temp_output_4_0_g83 ) ) + ( temp_output_5_0_g83 * temp_output_5_0_g83 ) ) ) * _Intensity );
				float2 appendResult14_g82 = (float2(0.0 , localNegStepY165_g1));
				float4 tex2DNode16_g82 = tex2D( _MainTex, ( localCenter138_g1 + appendResult14_g82 ) );
				float temp_output_2_0_g82 = (tex2DNode16_g82).r;
				float temp_output_4_0_g82 = (tex2DNode16_g82).g;
				float temp_output_5_0_g82 = (tex2DNode16_g82).b;
				float localBottom176_g1 = ( sqrt( ( ( ( temp_output_2_0_g82 * temp_output_2_0_g82 ) + ( temp_output_4_0_g82 * temp_output_4_0_g82 ) ) + ( temp_output_5_0_g82 * temp_output_5_0_g82 ) ) ) * _Intensity );
				float temp_output_135_0_g1 = ( ( -localTopLeft172_g1 + ( localTop175_g1 * -2 ) + -localTopRight177_g1 + localBottomLeft174_g1 + ( localBottom176_g1 * 2 ) + localBottomRight179_g1 ) / 6.0 );
				float temp_output_111_0_g1 = sqrt( ( ( temp_output_133_0_g1 * temp_output_133_0_g1 ) + ( temp_output_135_0_g1 * temp_output_135_0_g1 ) ) );
				float3 appendResult113_g1 = (float3(temp_output_111_0_g1 , temp_output_111_0_g1 , temp_output_111_0_g1));
				float4 lerpResult4 = lerp( color5 , color7 , float4( appendResult113_g1 , 0.0 ));
				

				finalColor = lerpResult4;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
172;73;1292;674;2264.273;716.1945;2.26425;True;True
Node;AmplifyShaderEditor.Vector4Node;9;-1246.039,-217.3963;Inherit;False;Constant;_Vector0;Vector 0;9;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-1181.401,-18.50757;Inherit;False;Constant;_Float6;Float 6;9;0;Create;True;0;0;0;False;0;False;0.002;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1298.315,100.8807;Inherit;False;0;0;_MainTex;Shader;False;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1007.373,-141.1556;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1154.017,95.88354;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;12;-859.532,-127.5018;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;5;-764.0903,-542.767;Inherit;False;Constant;_Color0;Color 0;9;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;3;-693.3124,179.1467;Inherit;False;SobelMain;0;;1;481788033fe47cd4893d0d4673016cbc;0;4;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;SAMPLER2D;0.0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;7;-775.9753,-308.579;Inherit;False;Constant;_Color1;Color 1;9;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;4;-342.8467,56.23004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;2;Sobel;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;10;0;9;0
WireConnection;10;1;11;0
WireConnection;8;2;1;0
WireConnection;12;0;10;0
WireConnection;3;2;12;0
WireConnection;3;3;12;1
WireConnection;3;4;8;0
WireConnection;3;1;1;0
WireConnection;4;0;5;0
WireConnection;4;1;7;0
WireConnection;4;2;3;0
WireConnection;0;0;4;0
ASEEND*/
//CHKSM=94DBC0CF1416C5142996BAB0D875799B5D38B13C