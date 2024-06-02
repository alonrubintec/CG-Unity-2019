Shader "My/Normal_CUBE"
{
    Properties
    {
        _MyCube ("Example Cube", CUBE) = "" {}
        _myColor ("Color Map", 2D) = "white" {}
        _NormalMap  ("Normal Map", 2D) = "bump" {}
        _Flatness  ("Normal Flatness", Range(-10,10)) = 0.5
        _Size  ("Texture Size", Range(-10,10)) = 1
        _BlendAmount ("Blend Amount", Range(-100, 100)) = 0.5 // Slider to control the blend amount
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myColor;
        sampler2D _NormalMap;
        samplerCUBE _MyCube;
        float _Flatness;
        float _Size;
        float _BlendAmount;

        struct Input {
            float2 uv_myColor;
            float2 uv_NormalMap;
            float3 worldRefl; // Needed for cube map reflection
            INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            float effectiveSize = _Size == 0 ? 0.05 : _Size;

            fixed3 albedoColor = tex2D(_myColor, IN.uv_myColor * effectiveSize).rgb;
            fixed3 normalTex = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap * effectiveSize));
            fixed3 flatNormal = fixed3(0, 0, 1);
            fixed3 lerpNormal = lerp(normalTex, flatNormal, _Flatness);

            // Fetch reflection vector based on the interpolated normal
            fixed3 reflectionVector = WorldReflectionVector(IN, lerpNormal);

            // Sample cube map using the reflection vector to get a color
            fixed3 cubeMapColor = texCUBE(_MyCube, reflectionVector).rgb;

            // Use the cube map color to perturb the normal
            fixed3 perturbedNormal = normalize(lerpNormal + cubeMapColor * 0.1); // Scale perturbation for subtlety

            // Interpolate between the original normal and the perturbed normal based on _BlendAmount
            o.Normal = normalize(lerp(lerpNormal, perturbedNormal, _BlendAmount));
            o.Emission = cubeMapColor;
            o.Albedo = albedoColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
