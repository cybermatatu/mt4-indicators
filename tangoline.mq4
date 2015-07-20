//+------------------------------------------------------------------+
//|                                                    tangoline.mq4 |
//|                                           Copyright 2015, fxborg |
//|                                  http://blog.livedoor.jp/fxborg/ |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, fxborg"
#property link      "http://blog.livedoor.jp/fxborg/"
#property version   "1.02"
#property strict
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_plots   1
//--- plot Label1
#property indicator_label1  "TangoLine"
#property indicator_width1  2
//--- input parameters
input  int InpPeriod=20;   // Period
input  double MinSpread = 5;     // Min Spread 
input  color LineColor=DeepPink; // Line Color
input  color BandColor=DarkViolet; // Band Color
//--- indicator buffers
double LineBuffer[];
//---- for calc 
double HighesBuffer[];
double LowesBuffer[];
double HighBuffer[];
double LowBuffer[];
//---
int CalcBarCount=2;     // Calc Bar Count
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   string short_name;
//--- indicator buffers mapping
   IndicatorBuffers(5);
   SetIndexBuffer(0,LineBuffer);
   SetIndexStyle(0,DRAW_LINE,STYLE_SOLID,EMPTY,LineColor);
//---
   SetIndexBuffer(1,HighBuffer);
   SetIndexStyle(1,DRAW_LINE,STYLE_DOT,EMPTY,BandColor);
//---
   SetIndexBuffer(2,LowBuffer);
   SetIndexStyle(2,DRAW_LINE,STYLE_DOT,EMPTY,BandColor);
//---
   SetIndexBuffer(3,HighesBuffer);
   SetIndexBuffer(4,LowesBuffer);
   if(InpPeriod<2)
     {
      Alert("InpPeriod is too small.");
      return(INIT_FAILED);
     }
//---
   short_name="Tango Line("+IntegerToString(InpPeriod)+")";
   IndicatorShortName(short_name);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| De-initialization                                                |
//+------------------------------------------------------------------+
int deinit()
  {
   string short_name="Tango Line("+IntegerToString(InpPeriod)+")";
   IndicatorShortName(short_name);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   int i,k,pos;
//--- check for bars count
   if(rates_total<=InpPeriod)
      return(0);
//--- counting from 0 to rates_total
   ArraySetAsSeries(HighesBuffer,false);
   ArraySetAsSeries(LowesBuffer,false);
   ArraySetAsSeries(HighBuffer,false);
   ArraySetAsSeries(LowBuffer,false);
   ArraySetAsSeries(LineBuffer,false);
//---
   ArraySetAsSeries(low,false);
   ArraySetAsSeries(high,false);
//---
   pos=InpPeriod-1;
   if(pos+1<prev_calculated)
      pos=prev_calculated-2;
   else
     {
      for(i=0; i<pos; i++)
        {
         LowesBuffer[i]=0.0;
         HighesBuffer[i]=0.0;
         HighBuffer[i]=0.0;
         LowBuffer[i]=0.0;
         LineBuffer[i]=0.0;
        }
     }
//--- calculate HighesBuffer[] and ExtHighesBuffer[]
   int btm_bar=pos-InpPeriod+1;
   int top_bar=pos-InpPeriod+1;
// i < rates_total - 1 
   for(i=pos; i<rates_total-1 && !IsStopped(); i++)
     {
      //--- calculate range spread
      double dmin=1000000.0;
      double dmax=-1000000.0;
      for(k=i-InpPeriod+1; k<=i; k++)
        {
         if(dmin>low[k]) dmin=low[k];
         if(dmax<high[k]) dmax=high[k];
        }
      //--- hook
      if((LowesBuffer[i-2]-MinSpread*Point)>LowesBuffer[i-1]
         && LowesBuffer[i-1]==dmin)
        {
         top_bar=i-1;
         btm_bar=i-1;
        }
      if((HighesBuffer[i-2]+MinSpread*Point)<HighesBuffer[i-1]
         && HighesBuffer[i-1]==dmax)
        {
         btm_bar=i-1;
         top_bar=i-1;
        }
      LowesBuffer[i]=dmin;
      HighesBuffer[i]=dmax;
      if(MathMax(top_bar,btm_bar)>i-InpPeriod+1)
        {
         //--- calculate range spread
         dmin=1000000.0;
         dmax=-1000000.0;
         //---
         for(k=i-InpPeriod+1; k<=i; k++)
           {
            //---
            if(k>=btm_bar)
               if(dmin>low[k]) dmin=low[k];
            if(k>=top_bar)
               if(dmax<high[k]) dmax=high[k];
           }
        }
      LowBuffer[i+1]=dmin;
      HighBuffer[i+1]=dmax;
      LineBuffer[i+1]=(dmax+dmin)/2;
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
