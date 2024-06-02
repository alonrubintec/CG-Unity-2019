Shader "My/StandardSpecPBR"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("Specular", Color) = (1,1,1,1)
        _MetallicTex ("Albedo (RGB)", 2D) = "white" {}
        _Smoothness ("Smoothness", Range(0,10)) = 0.0
    }
    SubShader
    {
        Tags { 
            "Queue"="Geometry" 
        }

        CGPROGRAM
        #pragma surface surf StandardSpecular
        #pragma target 3.0

        struct Input
        {
            float2 uv_MetallicTex;
        };

        sampler2D _MetallicTex;
        half _Smoothness;
        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutputStandardSpecular o)
        {
            // Albedo comes from a texture tinted by color
            //fixed4 c = tex2D (_MetallicTex, IN.uv_MetallicTex) * _Color;

            o.Albedo = _Color.rgb;
            o.Specular = _SpecColor.rgb;
            o.Smoothness = tex2D (_MetallicTex, IN.uv_MetallicTex).r * _Smoothness;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
