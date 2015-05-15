// Simplified Alpha Blended Particle shader. Differences from regular Alpha Blended Particle one:
// - no Tint color
// - no Smooth particle support
// - no AlphaTest
// - no ColorMask

Shader "Particles/SimpleBlendAdd" {
Properties {
	_MainTex ("Particle Texture", 2D) = "white" {}
	_AltTex ("Particle Texture 2", 2D) = "white" {}
	_ThirdTex ("Particle Texture 3", 2D) = "white" {}
}

Category {
	Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
	Blend SrcAlpha One
	Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
	
	BindChannels {
		Bind "Color", color
		Bind "Vertex", vertex
		Bind "TexCoord", texcoord
	}
	
	SubShader {
		Pass {
		
	
			SetTexture [_MainTex] {
				combine texture * primary
			}
			
			SetTexture[_AltTex] {
                Combine previous * texture
            }
            
            SetTexture[_ThirdTex] {
                Combine previous + texture
            }
		}
	}
}
}
