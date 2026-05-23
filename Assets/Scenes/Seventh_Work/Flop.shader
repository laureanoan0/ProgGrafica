// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Flop"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_DistortionEffectTexture("DistortionEffectTexture", 2D) = "white" {}
		_Texture2("Texture 2", 2D) = "white" {}
		_Color0("Color 0", Color) = (1,0,0,0)
		_NormalsTexture("NormalsTexture", 2D) = "white" {}
		_RotateTexture("RotateTexture", 2D) = "white" {}
		_Ramp("Ramp", 2D) = "white" {}
		_Texture1("Texture 1", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_Vector1("Vector 1", Vector) = (0,0,0,0)
		_Float1("Float 1", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

	}

	SubShader
	{
		LOD 0

		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		
		
		Pass
		{
		CGPROGRAM
			
			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"


			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform sampler2D _Ramp;
			uniform sampler2D _Texture0;
			uniform float4 _Texture0_ST;
			uniform float4 _Color0;
			uniform sampler2D _RotateTexture;
			uniform float4 _Vector1;
			uniform sampler2D _Texture1;
			uniform sampler2D _Texture2;
			uniform float4 _Texture2_ST;
			uniform sampler2D _DistortionEffectTexture;
			uniform sampler2D _NormalsTexture;
			uniform float4 _DistortionEffectTexture_ST;
			uniform float _Float1;
			uniform sampler2D _Mask;

			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
				
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				float2 uv_Texture0 = IN.texcoord.xy * _Texture0_ST.xy + _Texture0_ST.zw;
				float4 tex2DNode14_g3 = tex2D( _Texture0, uv_Texture0 );
				float2 appendResult20_g3 = (float2(tex2DNode14_g3.r , tex2DNode14_g3.g));
				float TimeVar197_g3 = _Time.y;
				float2 temp_cast_0 = (TimeVar197_g3).xx;
				float2 temp_output_18_0_g3 = ( appendResult20_g3 - temp_cast_0 );
				float4 tex2DNode72_g3 = tex2D( _Ramp, temp_output_18_0_g3 );
				float4 temp_output_57_0_g3 = _Vector1;
				float2 temp_output_2_0_g3 = (temp_output_57_0_g3).zw;
				float2 temp_cast_1 = (1.0).xx;
				float2 temp_output_13_0_g3 = ( ( ( IN.texcoord.xy + (temp_output_57_0_g3).xy ) * temp_output_2_0_g3 ) + -( ( temp_output_2_0_g3 - temp_cast_1 ) * 0.5 ) );
				float cos17_g3 = cos( TimeVar197_g3 );
				float sin17_g3 = sin( TimeVar197_g3 );
				float2 rotator17_g3 = mul( temp_output_13_0_g3 - float2( 0.5,0.5 ) , float2x2( cos17_g3 , -sin17_g3 , sin17_g3 , cos17_g3 )) + float2( 0.5,0.5 );
				float4 tex2DNode97_g3 = tex2D( _RotateTexture, rotator17_g3 );
				float temp_output_115_0_g3 = step( ( (temp_output_13_0_g3).y + -0.5 ) , 0.0 );
				float lerpResult125_g3 = lerp( 1.0 , tex2D( _Texture1, IN.texcoord.xy ).g , ( 1.0 - temp_output_115_0_g3 ));
				float4 color22 = IsGammaSpace() ? float4(1,0,0,0) : float4(1,0,0,0);
				float2 uv_Texture2 = IN.texcoord.xy * _Texture2_ST.xy + _Texture2_ST.zw;
				float4 temp_output_192_0_g3 = tex2D( _Texture2, uv_Texture2 );
				float2 uv_DistortionEffectTexture = IN.texcoord.xy * _DistortionEffectTexture_ST.xy + _DistortionEffectTexture_ST.zw;
				float2 MainUvs222_g1 = uv_DistortionEffectTexture;
				float4 tex2DNode65_g1 = tex2D( _NormalsTexture, MainUvs222_g1 );
				float4 appendResult82_g1 = (float4(0.0 , tex2DNode65_g1.g , 0.0 , tex2DNode65_g1.r));
				float2 temp_output_84_0_g1 = (UnpackScaleNormal( appendResult82_g1, _Float1 )).xy;
				float2 panner179_g1 = ( 1.0 * _Time.y * float2( 0,0 ) + MainUvs222_g1);
				float2 temp_output_71_0_g1 = ( ( temp_output_84_0_g1 * tex2D( _Mask, MainUvs222_g1 ).g ) + panner179_g1 );
				float4 tex2DNode96_g1 = tex2D( _DistortionEffectTexture, temp_output_71_0_g1 );
				
				fixed4 c = ( ( ( tex2DNode72_g3 * tex2DNode14_g3.a ) * _Color0 ) + ( ( ( tex2DNode97_g3 * lerpResult125_g3 * tex2DNode97_g3.a ) * color22 ) + temp_output_192_0_g3 ) + tex2DNode96_g1 );
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=18900
163;73;1374;593;1149.221;-122.9895;1.454414;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;21;-892.6491,1391.064;Inherit;True;Property;_Texture2;Texture 2;9;0;Create;True;0;0;0;False;0;False;None;80ab37a9e4f49c842903bb43bdd7bcd2;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;6;-801.7544,330.024;Inherit;True;Property;_Mask;Mask;7;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;3;-755,-206.5;Inherit;True;Property;_DistortionEffectTexture;DistortionEffectTexture;8;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;2;-749.0027,226.9293;Inherit;False;Property;_Float1;Float 1;17;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-748.2853,-1.785324;Inherit;True;Property;_NormalsTexture;NormalsTexture;11;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;14;-512.9667,985.4115;Inherit;True;Property;_Texture0;Texture 0;15;0;Create;True;0;0;0;False;0;False;None;7b0842e3d0da6bf468f08b4a0ad9db9b;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.ColorNode;15;-454.0941,599.6935;Inherit;False;Property;_Color0;Color 0;10;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;26;-180.3916,1817.594;Inherit;False;Property;_Vector1;Vector 1;16;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,1,3;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;-643.8928,1582.075;Inherit;False;Constant;_Color1;Color 1;11;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;24;-653.151,1729.638;Inherit;True;Property;_RotateTexture;RotateTexture;12;0;Create;True;0;0;0;False;0;False;None;a99649a3ac7df724eb781c969383e632;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;25;-669.1915,1920.294;Inherit;True;Property;_Texture1;Texture 1;14;0;Create;True;0;0;0;False;0;False;None;596678c53fd54a640bf95ba7dfafd092;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;13;-492.4791,796.3589;Inherit;True;Property;_Ramp;Ramp;13;0;Create;True;0;0;0;False;0;False;None;131633c45b26caa4f9673a16077a1970;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SamplerNode;18;-668.4655,1393.534;Inherit;True;Property;_TextureSample0;Texture Sample 0;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1;-347.9107,5.111982;Inherit;False;UI-Sprite Effect Layer;0;;1;789bf62641c5cfe4ab7126850acc22b8;18,74,0,204,0,191,0,225,0,242,0,237,0,249,0,186,1,177,1,182,0,229,0,92,0,98,0,234,0,126,0,129,1,130,0,31,0;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.FunctionNode;17;-141.7551,1369.962;Inherit;False;UI-Sprite Effect Layer;0;;3;789bf62641c5cfe4ab7126850acc22b8;18,74,2,204,2,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,1,234,0,126,0,129,1,130,1,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.FunctionNode;16;-80.78741,742.7078;Inherit;False;UI-Sprite Effect Layer;0;;3;789bf62641c5cfe4ab7126850acc22b8;18,74,1,204,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,0,234,0,126,0,129,1,130,0,31,0;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0;False;231;FLOAT;1;False;30;FLOAT;1;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.SimpleAddOpNode;27;282.7373,748.6238;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;504.7697,788.8981;Float;False;True;-1;2;ASEMaterialInspector;0;6;Flop;0f8ba0101102bb14ebf021ddadce9b49;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;2;False;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent=Queue=0;IgnoreProjector=True;RenderType=Transparent=RenderType;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;;False;0
WireConnection;18;0;21;0
WireConnection;1;37;3;0
WireConnection;1;75;5;0
WireConnection;1;80;2;0
WireConnection;1;188;6;0
WireConnection;17;192;18;0
WireConnection;17;39;22;0
WireConnection;17;37;24;0
WireConnection;17;101;25;0
WireConnection;17;57;26;0
WireConnection;16;39;15;0
WireConnection;16;37;13;0
WireConnection;16;33;14;0
WireConnection;27;0;16;0
WireConnection;27;1;17;0
WireConnection;27;2;1;0
WireConnection;0;0;27;0
ASEEND*/
//CHKSM=0C7B04595F09898CB6FC8EE49D473835A5A641D9