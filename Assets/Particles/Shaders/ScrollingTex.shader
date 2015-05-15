Shader "Particles/ScrollingTex" {
Properties {
	_MainTex ("Particle Texture", 2D) = "white" {}
	_AltTex2 ("Particle Texture 2", 2D) = "white" {}
	_AltTex3 ("Particle Texture 3", 2D) = "white" {}
	_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend One OneMinusSrcAlpha
	ColorMask RGB
	Cull Off Lighting Off ZWrite Off

	SubShader {
	
		Pass {
		
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_particles

			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			sampler2D _AltTex2;
			sampler2D _AltTex3;
			
			struct appdata_t {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
				float2 texcoord2 : TEXCOORD2;
				float2 texcoord3 : TEXCOORD3;
				#ifdef SOFTPARTICLES_ON
				float4 projPos : TEXCOORD1;
				#endif
			};
			
			float4 _MainTex_ST;
			float4 _AltTex2_ST;
			float4 _AltTex3_ST;

			float2 updateTexCoord(float2 tcIn, float2 animRate)
         	{
             return  (tcIn + animRate);
       		}

			v2f vert (appdata_t v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				#ifdef SOFTPARTICLES_ON
				o.projPos = ComputeScreenPos (o.vertex);
				COMPUTE_EYEDEPTH(o.projPos.z);
				#endif
				//o.texcoord2 = TRANSFORM_TEX(v.texcoord+1, _MainTex);
				//float textureOffset2 = updateTexCoord(v.texcoord, v.texcoord);
				
				o.color = v.color;
				o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex);
				o.texcoord2 = TRANSFORM_TEX((v.texcoord +1),_AltTex2);
				o.texcoord3 = TRANSFORM_TEX(v.texcoord,_AltTex3);
				return o;
			}
			
			sampler2D_float _CameraDepthTexture;
			float _InvFade;
			
			fixed4 frag (v2f i) : SV_Target
			{
				#ifdef SOFTPARTICLES_ON
				float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
				float partZ = i.projPos.z;
				float fade = saturate (_InvFade * (sceneZ-partZ));
				i.color.a *= fade;
				#endif

				
				return i.color * tex2D(_MainTex, i.texcoord) * (tex2D(_AltTex2, i.texcoord2) * tex2D(_AltTex3, i.texcoord3) *2) * i.color.a;
			}
	
			ENDCG 
		}



	}
}
}
















































