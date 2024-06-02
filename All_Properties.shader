Shader "My/All_Properties"
{
    Properties
    {
        _MyColour ("Example Colour", Color) = (1,1,1,1)
        _MyRange ("Example Range", Range(0,5)) = 1
        _MyOffset ("Example Offset", Range(-10,10)) = 1
        _MyTex ("Example Texture", 2D) = "white" {}
        _MyCube ("Example Cube", CUBE) = "" {}
        _MyFloat ("Example Float", Float) = 0.0
        _MyVector ("Example Vector", Vector) = (1,1,1,1)
        [Toggle] _ShowDecal ("Decal on / off", Float) = 0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
            #pragma surface surf Lambert

            fixed4 _MyColour;
            half _MyRange;
            half _MyOffset;
            sampler2D _MyTex;
            samplerCUBE _MyCube;
            float _MyFloat;
            float4 _MyVector;
            float _ShowDecal;

            struct Input {
                float2 uv_MyTex;
                float3 worldRefl;
            };

            void surf (Input IN, inout SurfaceOutput o)
            {
                o.Albedo = _MyRange*(tex2D(_MyTex, IN.uv_MyTex).rgb) + _MyOffset; 
                o.Emission = texCUBE(_MyCube, IN.worldRefl).rgb * _ShowDecal;;
            }

        ENDCG
    }
    FallBack "Diffuse"
}