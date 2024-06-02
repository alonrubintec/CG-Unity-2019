Shader "My/Hologram"
{
        Properties
    {
        _FresnelColor ("Color", Color) = (0,1,1,0) 
        _Amount ("Fresnel Amount ", Range(-10,10)) = 1
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" }
        LOD 200
        Pass
        {
            Zwrite On
            ColorMask 0
        }
        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        struct Input {
            float3 viewDir;
        };

        fixed4 _FresnelColor;
        half _Amount;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float fresnel = 1 - saturate( dot(normalize(IN.viewDir), o.Normal));
            o.Albedo = saturate(_FresnelColor.rgb * pow(fresnel, 1- _Amount));
            o.Alpha = saturate(pow(fresnel, _Amount));
        }
        ENDCG
    }
    FallBack "Diffuse"
}