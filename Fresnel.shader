Shader "My/Fresnel"
{
        Properties
    {
        _FresnelColour ("Colour", Color) = (0,1,1,0) 
        _Amount ("Fresenel Amount ", Range(-10,10)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 viewDir;
        };

        fixed4 _FresnelColour;
        half _Amount;

        void surf (Input IN, inout SurfaceOutput o)
        {
            float fresnel = 1 - saturate( dot(normalize(IN.viewDir), o.Normal));
            o.Emission = saturate(_FresnelColour.rgb * pow(fresnel, _Amount));
        }

        ENDCG
    }
    FallBack "Diffuse"
}