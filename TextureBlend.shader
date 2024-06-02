Shader "My/TextureBlend"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DecalTex ("ADecal (RGB)", 2D) = "white" {}
        _DecalAmount ("Decal Amount", Float) = 0.8
        [Toggle] _ShowDecal ("Decal on / off", Float) = 0
    }
    SubShader
    {
        Tags { "Queue"="Geometry" }

        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _DecalTex;
        float _ShowDecal;
        float _DecalAmount;

        struct Input
        {
            float2 uv_MainTex;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {

            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 b = tex2D (_DecalTex, IN.uv_MainTex) * _ShowDecal;
            o.Albedo = b.r > _DecalAmount ? b.rgb : c.rgb;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
