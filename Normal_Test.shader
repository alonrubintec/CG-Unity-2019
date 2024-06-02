Shader "My/Normal_Test"
{
    Properties
    {
        _myColor ("Color Map", 2D) = "white" {}
        _NormalMap  ("Normal Map", 2D) = "bump" {}
        _Flatness  ("Normal Flatness", Range(-10,10)) = 0.5
        _Size  ("Texture Size", Range(-10,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myColor;
        sampler2D _NormalMap ;
        float _Flatness;
        float _Size;
        samplerCUBE _MyCube;

        struct Input {
            float2 uv_myColor;
            float2 uv_NormalMap;
            float3 worldRefl;
        };



        void surf (Input IN, inout SurfaceOutput o)
        {

            // Ensuring that _Size is never exactly zero to prevent texture disappearance
            float effectiveSize = _Size == 0 ? 0.05 : _Size;

            o.Albedo = tex2D(_myColor, (IN.uv_myColor*effectiveSize)).rgb;

            fixed3 normalTex = UnpackNormal(tex2D(_NormalMap, (IN.uv_NormalMap*_Size)));
            fixed3 flatNormal = fixed3(0, 0, 1);

            // Lerp between the original normal and the 
            o.Normal = lerp(normalTex, flatNormal, _Flatness);

        }
        ENDCG
    }
    FallBack "Diffuse"
}
