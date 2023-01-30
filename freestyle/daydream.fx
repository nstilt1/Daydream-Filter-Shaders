////////////////////////////////////////////////////
// Daydream Shader                                //
// Author: Altered Brain Chemistry                //
////////////////////////////////////////////////////

#include "ReShade.fxh"

// UI ELEMENTS /////////////////////////////////////
////////////////////////////////////////////////////

#include "ReShadeUI.fxh"

  uniform float speed < __UNIFORM_SLIDER_FLOAT1
	ui_min = 0.0; ui_max = 2.0;
	ui_tooltip = "Speed";
	ui_step = 0.01;
> = 0.4;

uniform float uTime;

// SETUP & FUNCTIONS ///////////////////////////////
////////////////////////////////////////////////////
  float3 RGB_to_HSL(float3 color)
  {
      float3 HSL   = 0.0f;
      float  M     = max(color.r, max(color.g, color.b));
      float  C     = M - min(color.r, min(color.g, color.b));
             HSL.z = M - 0.5 * C;

      if (C != 0.0f)
      {
          float3 Delta  = (color.brg - color.rgb) / C + float3(2.0f, 4.0f, 6.0f);
                 Delta *= step(M, color.gbr); //if max = rgb
          HSL.x = frac(max(Delta.r, max(Delta.g, Delta.b)) / 6.0);
          HSL.y = (HSL.z == 1)? 0.0: C/ (1 - abs( 2 * HSL.z - 1));
      }

      return HSL;
  }

  float3 Hue_to_RGB( float h)
  {
      return saturate(float3( abs(h * 6.0f - 3.0f) - 1.0f,
                              2.0f - abs(h * 6.0f - 2.0f),
                              2.0f - abs(h * 6.0f - 4.0f)));
  }

  float3 HSL_to_RGB( float3 HSL )
  {
      return (Hue_to_RGB(HSL.x) - 0.5) * (1.0 - abs(2.0 * HSL.z - 1)) * HSL.y + HSL.z;
  }



  float3 DaydreamAnimation(float3 color)
  {
      float3 hsl = RGB_to_HSL(color);

      hsl.x += speed * uTime;
      while(hsl.x > 1){
        hsl.x -= 1;
      }
      while(hsl.x < 0){
        hsl.x += 1;
      }

      return HSL_to_RGB(hsl);
  }

// PIXEL SHADER ////////////////////////////////////
////////////////////////////////////////////////////
  float4	PS_Daydream(float4 position : SV_Position, float2 txcoord : TexCoord) : SV_Target
  {
      return float4(DaydreamAnimation(tex2D(ReShade::BackBuffer, txcoord).rgb), 1.0);
  }


// TECHNIQUE ///////////////////////////////////////
////////////////////////////////////////////////////
  technique Daydream
  {
      pass
      {
          VertexShader = PostProcessVS;
          PixelShader = PS_Daydream;
      }
  }
