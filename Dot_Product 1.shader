Shader "My/Dot_Product"
{
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float dotp = 1-dot(IN.viewDir, o.Normal);
            o.Albedo = float3(1,dotp,dotp);
        }

        ENDCG
    }
    FallBack "Diffuse"
}