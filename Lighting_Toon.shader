Shader "My/Lighting_Toon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Example Texture", 2D) = "white" {}

    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Toon

        sampler2D _RampTex;
        float4 _Color;

        float4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
        {

            float diff = dot(s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;

            float rh = h;
            float ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {

            o.Albedo = _Color.rgb;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
