Shader "My/BillPhong"
{
        Properties
    {
        _Colour ("Colour", Color) = (1,1,1,1)
        _SpecColour ("Spec Colour", Color) = (1,1,1,1)
        _Spec ("Spec Range", Range(0,1)) = 0.5
        _Gloss ("Gloss Range", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags{
            "Queue" = "Geometry"
        }
        CGPROGRAM
        #pragma surface surf BlinnPhong
        #pragma target 3.0

        struct Input {
            float3 uv_MainText;

        };

        float4 _Colour;
        half _Spec;
        fixed _Gloss;

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Colour.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }

        ENDCG
    }
    FallBack "Diffuse"
}

