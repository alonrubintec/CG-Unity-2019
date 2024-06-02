Shader "My/Height_Cutoff"
{
        Properties
    {
        _FresnelColour ("Colour", Color) = (0,1,1,0) 
        _Height ("Height ", Range(-10,10)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 viewDir;
            float3 worldPos;
        };

        fixed4 _FresnelColour;
        half _Height;

        void surf (Input IN, inout SurfaceOutput o)
        {

            float timePulse = sin(_Time.y); 
            timePulse = saturate((timePulse + 1) * 0.2);

            float fresnel = 1 - saturate( dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y *10 *(_Height + timePulse)) > 0.4  ? float3(0,1,0) * fresnel: float3(1,0,0) * fresnel;
        }

        ENDCG
    }
    FallBack "Diffuse"
}