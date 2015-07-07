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
double  AccountBalance();
//void OnTick() 
void OnInit() {

   //Comment("Period is ",Period());

  
   
}


int start() {

   //showInfoChart();
   str = "Account Name: " + AccountName() + "\n";
   
    if(Period() == PERIOD_M1){
      str += "Period is 1 Minute (M1)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M1,1)) + "\n";
   } else if(Period() == PERIOD_M5) {
      str += "Period is 5 Minutes (M5)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M5,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M5,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M5,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M5,1)) + "\n";
   } else if(Period() == PERIOD_M15) {
      //Comment("Period is 15 Minutes (M15)");
      str += "Period is 15 Minutes (M15)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M15,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M15,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M15,1)) + "\n";
   } else if(Period() == PERIOD_M30) {
      //Comment("Period is 30 Minutes (M30)");
      str += "Period is 30 Minutes (M30)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M30,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_M30,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_M30,1)) + "\n";
   } else if(Period() == PERIOD_H1) {
      //Comment("Period is 1 Hour (H1)");
      str += "Period is 1 Hour (H1" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_H1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_H1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_H1,1)) + "\n";
   } else if(Period() == PERIOD_H4) {
      //Comment("Period is 4 Hours (H4)");
      str += "Period is 4 Hours (H4" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_H4,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_H4,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_H4,1)) + "\n";
   } else if(Period() == PERIOD_D1) {
      //Comment("Period is Daily (D1)");
      str += "Period is Daily (D1)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_D1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_D1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_D1,1)) + "\n";
   } else if(Period() == PERIOD_W1) {
      //Comment("Period is Weekly (W1)");
      str += "Period is Weekly (W1)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_W1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_W1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_W1,1)) + "\n";
   } else if(Period() == PERIOD_MN1) {
      //Comment("Period is Monthly (MN)");
      str += "Period is Monthly (MN)" + "\n";
      str += "Open (O): " + (double)(iOpen(Symbol(),PERIOD_M1,1)) + "\n";
      str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_MN1,1)) + "\n";
      str += "Low (L): " + (double)(iLow(Symbol(),PERIOD_MN1,1)) + "\n";
      str += "Close (C): " + (double)(iClose(Symbol(),PERIOD_MN1,1)) + "\n";
   }
   
   Comment(str);
   
   return(0);
}

int deinit() {

   //DeleteObjects();
   return(0);
}


/****** Set Comments on Chart *******/
int showInfoChart() {

   if(showinfo ==  true){

   //string str;
   //int Spread;
   
   str = "Account Name: " + AccountName() + "\n";
   
      if(IsDemo()){
            str+= "Account Type: Demo" + "\n";
         } else {
            str+= "Account Type: Real" + "\n";
         }
      
            //str += "Account balance: " + (double)AccountBalance() + "\n";
            //str += (double)(iHigh(Symbol(),PERIOD_D1,1) + iLow(Symbol(),PERIOD_D1,1) + iClose(Symbol(),PERIOD_D1,1))/3 + "\n";
            str += "High (H): " + (double)(iHigh(Symbol(),PERIOD_M1,1)) + "\n";
            str += "Spread: " + (string)MarketInfo(Symbol(), MODE_SPREAD) + "\n" + "\n";
            //str += "Resistance (R1): " + (string)Fhr_R1  + "\n";
            //str += "Resistance (R2): " + (string)Fhr_R2  + "\n";
            //str += "Resistance (R3): " + (string)Fhr_R3  + "\n" + "\n";
            //str += "Support (S1): " + (string)Fhr_S1  + "\n";
            //str += "Support (S1): " + (string)Fhr_S2  + "\n";
            //str += "Support (S1): " + (string)Fhr_S3  + "\n";
            
            Comment(str);
      
      //ObjectCreate("Hallo",OBJ_TEXT,0);
      
      }

   return(0);

}