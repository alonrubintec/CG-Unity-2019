Shader "My/StandardPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Albedo (RGB)", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Smoothness ("Smoothness", Range(0,10)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        #pragma surface surf Standard
        #pragma target 3.0

        struct Input
        {
            float2 uv_MetallicTex;
        };

        sampler2D _MetallicTex;
        half _Metallic;
        half _Smoothness;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            //fixed4 c = tex2D (_MetallicTex, IN.uv_MetallicTex) * _Color;

            o.Albedo = _Color.rgb;
            o.Metallic = _Metallic;
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r * _Smoothness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
