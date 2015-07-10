//+------------------------------------------------------------------+
//|                                               Pivot Points.mq4 |
//|                        Copyright 2015, Pluspoint Kenya Limited. |
//|                                             https://www.figcloud.com |
//+------------------------------------------------------------------+
#property copyright "Pluspoint Kenya Limited"
#property link      "https://www.figcloud.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

// Pivot Points Colours
extern color Pivot_Colour = Yellow;
extern color Resistance_Colour = Red;
extern color Support_Colour = Aqua;
extern color Trend_Colour = Yellow;

//color Label_AppName = Yellow;

/******* Trend Indicators Colours *****/
//extern color SMA_Colour = Magenta;
//extern color EMA_Colour = Lime;
//extern color SMMA_Colour = LightCyan;

//#property indicator_buffers 0

int MA_Period=13;
extern int MA_Shift=-2;
int MA_Method=0;

//---- indicator buffers
double ExtMapBuffer[];
//double ExtBuffer[];
//----
int ExtCountedBars=0;
int draw_begin;
string short_name;

/*******************************/
extern int Pivot_Colour_Thickness = 1;
extern int Text_Shift = 30;
extern int Text_size = 8;

#define  OLine "PPLLine"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
extern bool Show_Info = true;
//extern bool Show_SMA_Trend_Curve = false;
//extern bool Show_EMA_Trend_Curve = false;
extern bool Show_Trend_Curve = false;
extern string Trend_Curve_Type = "EMA";
extern bool Show_Pivot_Point = false;
extern bool Show_Resistance_Labels = false;
extern bool Show_Support_Labels = false;

int Period;
string str;
double high;
double low;
double open;
double close;
double pivot;
double resistance1;
double resistance2;
double resistance3;
double support1;
double support2;
double support3;
//double  AccountBalance();
//void OnTick() 


int init() {

return(0);

}


int start() {
   
   MA_Period = Period();
   
   if(Show_Trend_Curve == true) {

         if(Trend_Curve_Type == "SMA") {
         
            drawTrendCurves(0,Trend_Colour,"Simple Moving Average",1);
            sma();
            
         } else if(Trend_Curve_Type == "EMA") {
         
            drawTrendCurves(0,Trend_Colour,"Exponential Moving Average",1);
            ema();
            
         }  else if(Trend_Curve_Type == "SMMA") {
         
            drawTrendCurves(0,Trend_Colour,"Smoothed Moving Average",1);
            smma();
            
         } else if(Trend_Curve_Type == "LWMA") {
         
            drawTrendCurves(0,Trend_Colour,"Linear Weighted Moving Average",1);
            lwma();
            
         } else {
         
            drawTrendCurves(0,Trend_Colour,"Exponential Moving Average",1);
            ema();
         }
     }
   
   //showInfoChart();
   str = "Server Name : " + AccountServer() + "\n";
   //str = "Account Name: " + AccountName() + "\n";
   str += "Spread:" + (string)MarketInfo(Symbol(), MODE_SPREAD) + "\n";
  // str+=  "Company: " + AccountCompany() + "\n";
   //str+= "Expert Name: " + WindowExpertName() +"\n";
   //ObjectCreate("Label_AppName", OBJ_LABEL, 0, 0, 0);
   //ObjectSet("Label_AppName", OBJPROP_XDISTANCE, 542.5);// X coordinate
   //ObjectSet("Label_AppName", OBJPROP_YDISTANCE, 0);// Y coordinate
   //ObjectSetText("Label_AppName","Pluspoint Simple Pivot Points",14,"Arial",Aqua);
   
   //drawLabel("Label_AppName", 542.5, 0, "Pluspoint Simple Pivot Points", 14, "Tahoma", Label_AppName);
   //drawLabel("Label_Open", OBJPROP_CORNER, 25, "0.0014", 10, "Tahoma", Aqua);
   
   
    if(Period() == PERIOD_M1){
      
      /************ Period M1 *******************/
      
      open = (double)(iOpen(Symbol(),PERIOD_M1,1));
      high = (double)(iHigh(Symbol(),PERIOD_M1,1));
      low = (double)(iLow(Symbol(),PERIOD_M1,1));
      close = (double)(iClose(Symbol(),PERIOD_M1,1));
      
      str += "Period is 1 Minute (M1)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
        
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
    
      
   } else if(Period() == PERIOD_M5) {
      
      /*************** Period M5 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_M5,1));
      high = (double)(iHigh(Symbol(),PERIOD_M5,1));
      low = (double)(iLow(Symbol(),PERIOD_M5,1));
      close = (double)(iClose(Symbol(),PERIOD_M5,1));
      
      str += "Period is 5 Minutes (M5)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
      
   } else if(Period() == PERIOD_M15) {
      
      /*************** Period M15 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_M15,1));
      high = (double)(iHigh(Symbol(),PERIOD_M15,1));
      low = (double)(iLow(Symbol(),PERIOD_M15,1));
      close = (double)(iClose(Symbol(),PERIOD_M15,1));
      
      str += "Period is 15 Minutes (M15)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
      
   } else if(Period() == PERIOD_M30) {
      
      /*************** Period M30 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_M30,1));
      high = (double)(iHigh(Symbol(),PERIOD_M30,1));
      low = (double)(iLow(Symbol(),PERIOD_M30,1));
      close = (double)(iClose(Symbol(),PERIOD_M30,1));
      
      str += "Period is 30 Minutes (M30)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
   } else if(Period() == PERIOD_H1) {
     
     
     /*************** Period H1 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_H1,1));
      high = (double)(iHigh(Symbol(),PERIOD_H1,1));
      low = (double)(iLow(Symbol(),PERIOD_H1,1));
      close = (double)(iClose(Symbol(),PERIOD_H1,1));
      
      str += "Period is 1 Hour (H1)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
     
     
   } else if(Period() == PERIOD_H4) {
      
      /*************** Period H4 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_H4,1));
      high = (double)(iHigh(Symbol(),PERIOD_H4,1));
      low = (double)(iLow(Symbol(),PERIOD_H4,1));
      close = (double)(iClose(Symbol(),PERIOD_H4,1));
      
      str += "Period is 4 Hours (H4)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
   } else if(Period() == PERIOD_D1) {
      
      /*************** Period D1 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_D1,1));
      high = (double)(iHigh(Symbol(),PERIOD_D1,1));
      low = (double)(iLow(Symbol(),PERIOD_D1,1));
      close = (double)(iClose(Symbol(),PERIOD_D1,1));
      
      str += "Period Daily (D1)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
   } else if(Period() == PERIOD_W1) {
      
      /*************** Period W1 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_W1,1));
      high = (double)(iHigh(Symbol(),PERIOD_W1,1));
      low = (double)(iLow(Symbol(),PERIOD_W1,1));
      close = (double)(iClose(Symbol(),PERIOD_W1,1));
      
      str += "Period Weekly (W)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
       /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
   } else if(Period() == PERIOD_MN1) {
      
      
      /*************** Period MN1 ****************************/
      open = (double)(iOpen(Symbol(),PERIOD_MN1,1));
      high = (double)(iHigh(Symbol(),PERIOD_MN1,1));
      low = (double)(iLow(Symbol(),PERIOD_MN1,1));
      close = (double)(iClose(Symbol(),PERIOD_MN1,1));
      
      str += "Period Monthly (MN)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = (high + low + close) / 3;
      resistance1 = 2 * pivot - low ;
      support1 = 2 * pivot - high ;
      resistance2 = pivot + (resistance1 - support1);
      resistance3 = high + 2 * (pivot - low);
      support2 = pivot - (resistance1 - support1);
      support3 = low - 2 * (high - pivot);
      
      
      
      str += "Pivot (P): " + pivot + "\n" + "\n";
      str += "Resistance 1 (R1): " + resistance1 + "\n";
      str += "Resistance 2 (R2): " + resistance2 + "\n";
      str += "Resistance 3 (R3): " + resistance3 + "\n" + "\n";
      
      str += "Support 1 (S1): " + support1 + "\n";
      str += "Support 2 (S2): " + support2 + "\n";
      str += "Support 3 (S3): " + support3 + "\n";
      
      /********* Toggle Pivot Point *********/
      if(Show_Pivot_Point == true) {
         drawLine(pivot,"Pivot",Pivot_Colour,1,Pivot_Colour_Thickness);
         drawLabel("Pivot (P)",pivot,Pivot_Colour);
      }
      
      drawLine(resistance1, "Resistance 1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3",Resistance_Colour,1);
      
      //ChartRedraw();
      
      drawLine(support1,"Support 1",Support_Colour,1);
      drawLine(support2,"Support 2",Support_Colour,1);
      drawLine(support3,"Support 3",Support_Colour,1);
      
      /******** Draw Chart Labels **********/
      if(Show_Resistance_Labels == true) {
         drawLabel("Resistance 1",resistance1,Resistance_Colour);
         drawLabel("Resistance 2",resistance2,Resistance_Colour);
         drawLabel("Resistance 3",resistance3,Resistance_Colour);
      }
      
      if(Show_Support_Labels == true) {
         drawLabel("Support 1",support1,Support_Colour);
         drawLabel("Support 2",support2,Support_Colour);
         drawLabel("Support 3",support3,Support_Colour);
      }
      
      /*******************************************************************/
      
   }
   
         if(Show_Info == true) {
               //ChartRedraw();
               Comment(str);
           }
   
   //drawLine(pivot,"PIVOT M1",Pivot_Colour,0);
   
   return(0);
}

int deinit() {

   DeleteObjects();
   Comment("");
   ObjectDelete("Label_AppName");
   ObjectDelete("Pivot (P)");
   ObjectDelete("Resistance 1");
   ObjectDelete("Resistance 2");
   ObjectDelete("Resistance 3");
   ObjectDelete("Support 1");
   ObjectDelete("Support 2");
   ObjectDelete("Support 3");
   return(0);
}


//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int DeleteObjects()
{
   int obj_total=ObjectsTotal();
   for(int i = obj_total - 1; i >= 0; i--)
   {
       string line = ObjectName(i);
       if(StringFind(line, OLine) == -1) continue;
       ObjectDelete(line); 
   }     
   return(0);
}

/********* Draw Lines *********/
//----
void drawLine(double lvl,string nome, color Col,int type,int thickness=1) {
         
         string line = OLine +"-"+ nome;

         if(ObjectFind(line) != 0)
         {
            ObjectCreate(line, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);           
            if(type == 1)
            ObjectSet(line, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(line, OBJPROP_STYLE, STYLE_DOT);
            ObjectSet(line, OBJPROP_COLOR, Col);
            ObjectSet(line,OBJPROP_WIDTH,thickness);  
         }
         else
         {
            ObjectDelete(line);
            ObjectCreate(line, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);  
            if(type == 1)
            ObjectSet(line, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(line, OBJPROP_STYLE, STYLE_DOT);
            ObjectSet(line, OBJPROP_COLOR, Col);        
            ObjectSet(line,OBJPROP_WIDTH,thickness);         
         }
}

/********* Draw Labels **********/
/*
void drawLabel(string labelname, double xdistance, double ydistance, string labeltxt, int fontsize, string fontname, color fontcolor) {

   ObjectCreate(labelname, OBJ_LABEL, 0, 0, 0);
   ObjectSet(labelname, OBJPROP_XDISTANCE, xdistance);// X coordinate
   ObjectSet(labelname, OBJPROP_YDISTANCE, ydistance);// Y coordinate
   ObjectSetText(labelname,labeltxt,fontsize,fontname,fontcolor);

}
*/

void drawLabel(string nome,double lvl,color Color)
{
    if(ObjectFind(nome) != 0)
    {
        ObjectCreate(nome, OBJ_TEXT, 0, Time[Text_Shift], lvl);
        ObjectSetText(nome, nome, Text_size, "Tahoma", EMPTY);
        ObjectSet(nome, OBJPROP_COLOR, Color);
    }
    else
    {
        ObjectMove(nome, 0, Time[Text_Shift], lvl);
    }
}


/********* Draw Trend Curves **********/
  int drawTrendCurves(int index, color trendColor, string MAname, int MAThickness=1) {
  
      if(Bars<=MA_Period) return(0);
      ExtCountedBars=IndicatorCounted();
   //---- check for possible errors
      if (ExtCountedBars<0) return(-1);
   //---- last counted bar will be recounted
      if (ExtCountedBars>0) ExtCountedBars--;
   
      SetIndexStyle(index,DRAW_LINE,EMPTY,MAThickness,trendColor);
      SetIndexShift(index,MA_Shift);
      IndicatorDigits(MarketInfo(Symbol(),MODE_DIGITS));
      
      if(MA_Period<2) MA_Period=13;
      draw_begin=MA_Period-1;
      
      MA_Method=0;
      
      short_name="" + MAname;
      
      IndicatorShortName(short_name);
      SetIndexDrawBegin(index,draw_begin);
   //---- indicator buffers mapping
      SetIndexBuffer(index,ExtMapBuffer);
      SetIndexLabel(index,"MA Period: " + MA_Period);
   //---- initialization done
   return(0);
}


//+------------------------------------------------------------------+
//| Simple Moving Average                                            |
//+------------------------------------------------------------------+
void sma() {

   double sum=0;
   int    i,pos=Bars-ExtCountedBars-1;
//---- initial accumulation
   if(pos<MA_Period) pos=MA_Period;
   for(i=1;i<MA_Period;i++,pos--)
      sum+=Close[pos];
//---- main calculation loop
   while(pos>=0){
   
      sum+=Close[pos];
      ExtMapBuffer[pos]=sum/MA_Period;
	   sum-=Close[pos+MA_Period-1];
 	   pos--;
 	   
     }
//---- zero initial bars
   if(ExtCountedBars<1)
      for(i=1;i<MA_Period;i++) ExtMapBuffer[Bars-i]=0;
}

//+------------------------------------------------------------------+
//| Exponential Moving Average                                       |
//+------------------------------------------------------------------+
void ema()
  {
   double pr=2.0/(MA_Period+1);
   int    pos=Bars-2;
   if(ExtCountedBars>2) pos=Bars-ExtCountedBars-1;
//---- main calculation loop
   while(pos>=0)
     {
      if(pos==Bars-2) ExtMapBuffer[pos+1]=Close[pos+1];
      ExtMapBuffer[pos]=Close[pos]*pr+ExtMapBuffer[pos+1]*(1-pr);
 	   pos--;
     }
}

//+------------------------------------------------------------------+
//| Smoothed Moving Average                                          |
//+------------------------------------------------------------------+
void smma()
  {
   double sum=0;
   int    i,k,pos=Bars-ExtCountedBars+1;
//---- main calculation loop
   pos=Bars-MA_Period;
   if(pos>Bars-ExtCountedBars) pos=Bars-ExtCountedBars;
   while(pos>=0)
     {
      if(pos==Bars-MA_Period)
        {
         //---- initial accumulation
         for(i=0,k=pos;i<MA_Period;i++,k++)
           {
            sum+=Close[k];
            //---- zero initial bars
            ExtMapBuffer[k]=0;
           }
        }
      else sum=ExtMapBuffer[pos+1]*(MA_Period-1)+Close[pos];
      ExtMapBuffer[pos]=sum/MA_Period;
 	   pos--;
     }
  }
  
 //+------------------------------------------------------------------+
//| Linear Weighted Moving Average                                   |
//+------------------------------------------------------------------+
void lwma()
  {
   double sum=0.0,lsum=0.0;
   double price;
   int    i,weight=0,pos=Bars-ExtCountedBars-1;
//---- initial accumulation
   if(pos<MA_Period) pos=MA_Period;
   for(i=1;i<=MA_Period;i++,pos--)
     {
      price=Close[pos];
      sum+=price*i;
      lsum+=price;
      weight+=i;
     }
//---- main calculation loop
   pos++;
   i=pos+MA_Period;
   while(pos>=0)
     {
      ExtMapBuffer[pos]=sum/weight;
      if(pos==0) break;
      pos--;
      i--;
      price=Close[pos];
      sum=sum-lsum+price*MA_Period;
      lsum-=Close[i];
      lsum+=price;
     }
//---- zero initial bars
   if(ExtCountedBars<1)
      for(i=1;i<MA_Period;i++) ExtMapBuffer[Bars-i]=0;
  }
//+------------------------------------------------------------------+