Shader "ParticleTextureChooser" {

Properties {
 _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)  
 _MainTex ("Particle Texture", 2D) = "white" {}  
 _InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0  
}

Category {

 Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" } 
 Blend SrcAlpha One
 AlphaTest Greater .01  
  ColorMask RGB  
  Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }  
 
 BindChannels {  
      Bind "Color", color  
      Bind "Vertex", vertex  
      Bind "TexCoord", texcoord  
  }  
 
  // ---- Fragment program cards
 SubShader {
     Pass {
     
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag
         #pragma fragmentoption ARB_precision_hint_fastest
         #pragma multi_compile_particles
 
         #include "UnityCG.cginc"
 
         sampler2D _MainTex;
         fixed4 _TintColor;
         uniform float4 _MainTex_ST;
         
         struct appdata_t {
             float4 vertex : POSITION;
             fixed4 color : COLOR;
             float2 texcoord : TEXCOORD0;
             float2 texcoord1 : TEXCOORD1;
         };
 
         struct v2f {
             float4 vertex : POSITION;
             fixed4 color : COLOR;
             float2 texcoord : TEXCOORD0;
             #ifdef SOFTPARTICLES_ON
             float4 projPos : TEXCOORD1;
             #endif
         };
 
         //Custom method to set color based on colorFlag
         float4 setColor(float colorCode)
         {
             float4 outputColor;
             if(colorCode  <= 0.01)
             {
                 outputColor = float4(0.0, 1.0, 1.0, 0.6);
             }
             else if (colorCode  <= 1.1) //"O"
             {
                 outputColor = float4(0.0/255.0, 0.0/255.0, 255.0/255.0, 0.6);
             }

             return outputColor;
 
 
             } 
  
         //Custom method to set uv offset based on valueFlag  
 
         float2 updateTexCoord(float2 tcIn, float index)
         {
             //out of bounds check
             clamp(index, 0.01, 9.0);
 
             //This logic is based on a 3x3 texture with 9 circles each containing a number from 1-9
             // (1)(2)(3)
             // (4)(5)(6)
             // (7)(8)(9)
             float colNumber = 2.0-(floor((round(index)-1)/3.0));
             float rowNumber = fmod(round(index)-1, 3.0);    
 
             return  tcIn + float2((rowNumber), (colNumber) );
         }
         v2f vert (appdata_t v)
         {
             v2f o;
             o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
             #ifdef SOFTPARTICLES_ON
             o.projPos = ComputeScreenPos (o.vertex);
             COMPUTE_EYEDEPTH(o.projPos.z);
             #endif
 
             //The next 3 lines calculate and set the color and uv offset for the texture atlas
             float2 textureOffset = updateTexCoord(v.texcoord, v.color.g*255.0); //multiply by 255 to get valueFlag 1-9
             o.color = setColor(v.color.r * 255.0); //multiply by 255 to get colorFlag 1-n
             o.texcoord = TRANSFORM_TEX(v.texcoord,_MainTex); //This sets the UV offset choosing the location in the texture atlas
             return o;
         }
         //The rest of the shader is unchanged from particle/additive
         sampler2D _CameraDepthTexture;
         float _InvFade;
         
         fixed4 frag (v2f i) : COLOR
         {
             #ifdef SOFTPARTICLES_ON
             float sceneZ = LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos))));
             float partZ = i.projPos.z;
             float fade = saturate (_InvFade * (sceneZ-partZ));
             i.color.a *= fade;
             #endif
             
             return 2.0f * i.color * _TintColor * tex2D(_MainTex, i.texcoord);
         }
         ENDCG 
     }
 }     
 
 // ---- Dual texture cards
 SubShader {
     Pass {
         SetTexture [_MainTex] {
             constantColor [_TintColor]
             combine constant * primary
         }
         SetTexture [_MainTex] {
             combine texture * previous DOUBLE
         }
     }
 }
 
 // ---- Single texture cards (does not do color tint)
 SubShader {
     Pass {
         SetTexture [_MainTex] {
             combine texture * primary
         }
     }
 }
 
 }
 
 }