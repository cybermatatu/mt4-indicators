//+------------------------------------------------------------------+
//|                                               Hybrid Scalper.mq4 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Pluspoint Kenya Limited"
#property link      "https://www.figcloud.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
#property indicator_buffers 7

// Color1 is for the Pivot Point Line
#property indicator_color1 Yellow 
extern color Pivot_Colour = Yellow;
extern color Resistance_Colour = Blue;
extern color Support_Colour = Aqua;

// Colors 1 through 4 are for the Resistance Lines
#property indicator_color2 Red
#property indicator_color3 Red
#property indicator_color4 Red

// Colors 5 through 8 are for the Support Lines
#property indicator_color5 Aqua
#property indicator_color6 Aqua
#property indicator_color7 Aqua
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
extern bool  showinfo=true;

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
double  AccountBalance();
//void OnTick() 
void OnInit() {

   //Comment("Period is ",Period());

  
   
}


int start() {

   //showInfoChart();
   str = "Account Name: " + AccountName() + "\n";
   
    if(Period() == PERIOD_M1){
      
      open = (double)(iOpen(Symbol(),PERIOD_M1,1));
      high = (double)(iHigh(Symbol(),PERIOD_M1,1));
      low = (double)(iLow(Symbol(),PERIOD_M1,1));
      close = (double)(iClose(Symbol(),PERIOD_M1,1));
      
      str += "Period is 1 Minute (M1)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = ((double)(iHigh(Symbol(),PERIOD_M1,1)) + (double)(iLow(Symbol(),PERIOD_M1,1)) + (double)(iClose(Symbol(),PERIOD_M1,1)))/3;
      
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
      
      drawLine(pivot,"Pivot M1",Pivot_Colour,1);
      
      drawLine(resistance1, "Resistance 1 M1",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2 M1",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3 M1",Resistance_Colour,1);
      
      drawLine(support1,"Support 1 M1",Support_Colour,1);
      drawLine(support2,"Support 2 M1",Support_Colour,1);
      drawLine(support3,"Support 3 M1",Support_Colour,1);
      
      
      
   } else if(Period() == PERIOD_M5) {
      str += "Period is 5 Minutes (M5)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M5,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M5,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M5,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M5,1)) + "\n";
      
      pivot = ((double)(iHigh(Symbol(),PERIOD_M5,1)) + (double)(iLow(Symbol(),PERIOD_M5,1)) + (double)(iClose(Symbol(),PERIOD_M5,1)))/3;
      
      str += "Pivot (P): " + pivot + "\n";
      
      drawLine(pivot,"PIVOT M5",Pivot_Colour,1);
      
      /*************************************************************/
      open = (double)(iOpen(Symbol(),PERIOD_M5,1));
      high = (double)(iHigh(Symbol(),PERIOD_M5,1));
      low = (double)(iLow(Symbol(),PERIOD_M5,1));
      close = (double)(iClose(Symbol(),PERIOD_M5,1));
      
      str += "Period is 5 Minutes (M5)" + "\n";
      str += "Open (O): " + open + "\n";
      str += "High (H): " + high + "\n";
      str += "Low (L): " + low + "\n";
      str += "Close (C): " + close + "\n";
      
      pivot = ((double)(iHigh(Symbol(),PERIOD_M5,1)) + (double)(iLow(Symbol(),PERIOD_M5,1)) + (double)(iClose(Symbol(),PERIOD_M5,1)))/3;
      
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
      
      drawLine(pivot,"Pivot M5",Pivot_Colour,1);
      
      drawLine(resistance1, "Resistance 1 M5",Resistance_Colour,1);
      drawLine(resistance2,"Resistance 2 M5",Resistance_Colour,1);
      drawLine(resistance3,"Resistance 3 M5",Resistance_Colour,1);
      
      drawLine(support1,"Support 1 M5",Support_Colour,1);
      drawLine(support2,"Support 2 M5",Support_Colour,1);
      drawLine(support3,"Support 3 M5",Support_Colour,1);
      
      /*******************************************************************/
      
      
   } else if(Period() == PERIOD_M15) {
      //Comment("Period is 15 Minutes (M15)");
      str += "Period is 15 Minutes (M15)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M15,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M15,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M15,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M15,1)) + "\n";
      
      pivot = ((double)(iHigh(Symbol(),PERIOD_M15,1)) + (double)(iLow(Symbol(),PERIOD_M15,1)) + (double)(iClose(Symbol(),PERIOD_M15,1)))/3;
      
      str += "Pivot (P): " + pivot + "\n";
      
   } else if(Period() == PERIOD_M30) {
      //Comment("Period is 30 Minutes (M30)");
      str += "Period is 30 Minutes (M30)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M30,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M30,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M30,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M30,1)) + "\n";
   } else if(Period() == PERIOD_H1) {
      //Comment("Period is 1 Hour (H1)");
      str += "Period is 1 Hour (H1" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_H1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_H1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_H1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_H1,1)) + "\n";
   } else if(Period() == PERIOD_H4) {
      //Comment("Period is 4 Hours (H4)");
      str += "Period is 4 Hours (H4" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_H4,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_H4,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_H4,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_H4,1)) + "\n";
   } else if(Period() == PERIOD_D1) {
      //Comment("Period is Daily (D1)");
      str += "Period is Daily (D1)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_D1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_D1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_D1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_D1,1)) + "\n";
   } else if(Period() == PERIOD_W1) {
      //Comment("Period is Weekly (W1)");
      str += "Period is Weekly (W1)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_W1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_W1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_W1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_W1,1)) + "\n";
   } else if(Period() == PERIOD_MN1) {
      //Comment("Period is Monthly (MN)");
      str += "Period is Monthly (MN)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_MN1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_MN1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_MN1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_MN1,1)) + "\n";
   }
   
         if(showinfo == true) {
               //ChartRedraw();
               Comment(str);
           }
   
   //drawLine(pivot,"PIVOT M1",Pivot_Colour,0);
   
   return(0);
}

int deinit() {

   //DeleteObjects();
   return(0);
}


/****** Set Comments on Chart *******/
int showInfoChart() {

   if(showinfo ==  true){
   }

   return(0);

}

/********* Draw Lines *********/
//----
void drawLine(double lvl,string nome, color Col,int type)
{
         if(ObjectFind(nome) != 0)
         {
            ObjectCreate(nome, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);           
            if(type == 1)
            ObjectSet(nome, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(nome, OBJPROP_STYLE, STYLE_DOT);
            ObjectSet(nome, OBJPROP_COLOR, Col);
            ObjectSet(nome,OBJPROP_WIDTH,1);  
         }
         else
         {
            ObjectDelete(nome);
            ObjectCreate(nome, OBJ_HLINE, 0, Time[0], lvl,Time[0],lvl);  
            if(type == 1)
            ObjectSet(nome, OBJPROP_STYLE, STYLE_SOLID);
            else
            ObjectSet(nome, OBJPROP_STYLE, STYLE_DOT);
            ObjectSet(nome, OBJPROP_COLOR, Col);        
            ObjectSet(nome,OBJPROP_WIDTH,1);         
         }
}