﻿Shader "Custom/Toon"
{
    Properties
    {
        _MainTex("Main Textures", 2D) = "white" {}
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        _RampTex("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {
       CGPROGRAM
       #pragma surface surf ToonRamp

       float4 _Albedo;
       sampler2D _MainTex;
       sampler2D _RampTex;
       float4 LightingToonRamp(SurfaceOutput s, fixed2 lightDir, fixed atten)
       {
           half diff = dot(s.Normal, lightDir);
           float uv = (diff * 0.5) + 0.5;
           float3 ramp = tex2D(_RampTex, uv).rgb;
           float4 c;
           c.rgb = s.Albedo * _LightColor0.rgb * ramp;
           c.a = s.Alpha;
           return c;
       }
       struct Input
       {
           float2 uv_MainTex;
       };
       void surf(Input IN, inout SurfaceOutput o)
       {
           o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Albedo.rgb;

       }
       ENDCG
    }
}