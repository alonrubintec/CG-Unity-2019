Shader "My/Hello_World"
{
    Properties
    {
        _MyColour ("Example Colour", Color) = (1,1,1,1) // Ensure property names match
        _MyFloatValue ("Example Float", Float) = 0.0
        _MyNormal ("Example Colour", Color) = (0,0,1,1)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float2 uvMainTex;
        };

        // Declare the uniform variables for color and float
        fixed4 _MyColour; // corrected case to match property
        fixed4 _MyNormal; // corrected case to match property
        float _MyFloatValue; // use float instead of fixed1 for clarity

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _MyColour.rgb; // Use the RGB components for the albedo
            o.Emission = abs(_MyColour.rgb * _MyFloatValue); // Multiply color RGB by float value for emission
            o.Normal = _MyNormal;
        }

        ENDCG
    }
    FallBack "Diffuse"
}