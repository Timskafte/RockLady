Shader "Custom/Hologram" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
_IlluminationPower ("Illumination Power", Range(0, 10)) = 1
_OffsetFactor ("Offset Factor", Range(0.0,1.0)) = 0.5
_OffsetU ("Animate Direction X", float) = 1
_OffsetV ("Animate Direction Y", float) = 1
}

SubShader {
Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
ZTest LEqual Cull Off ZWrite Off
Fog { Mode off }
LOD 400

CGPROGRAM
#pragma surface surf BlinnPhong alpha
#pragma fragmentoption ARB_precision_hint_fastest
#include "UnityCG.cginc"

sampler2D _MainTex;
fixed4 _Color;
fixed _IlluminationPower;
float _OffsetU;
float _OffsetV;
float _OffsetFactor;

struct Input {
float2 uv_MainTex;
};

void surf (Input IN, inout SurfaceOutput o) {
float2 t = IN.uv_MainTex;

float2 _OffsetUV = float2((_OffsetU + _OffsetFactor), _OffsetV);
_OffsetUV += (_OffsetUV * (_Time[1] ));

fixed4 c = tex2D(_MainTex, (t+_OffsetUV)) * _Color;

o.Albedo = c.rgb;
o.Alpha = c.a;
o.Emission = c.rgb * _IlluminationPower;
o.Gloss = c.a;
}
ENDCG
}

Fallback "Transparent/Diffuse"
}