Shader "Custom/UnlitPartialAnimated" 
     {
         Properties 
         {
             //_MainTex   ("Base", 2D) = "white" {}
             _SecondTex ("scrolling", 2D) = "white" {}
             _SecondTexA("scrollingA", 2D) = "white" {}
         }
     
         SubShader 
         {
             Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
             LOD 100
         
             ZWrite On
             Blend SrcAlpha OneMinusSrcAlpha 
     
             Pass 
             {
                 Lighting On
                 
                 //SetTexture [_MainTex]
                 //{
                 //Combine texture 
                 //}
                 
                 SetTexture [_SecondTex] 
                 { 
                     Combine texture
                 }
                 SetTexture [_SecondTexA]
                 {
                     Combine texture * previous
                 
                 }
             }
         }
     }

