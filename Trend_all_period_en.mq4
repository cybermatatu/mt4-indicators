//+------------------------------------------------------------------+
//|                                             Trend_all_period.mq4 |
//|                               Copyright © 2009, Vladimir Hlystov |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, Vladimir Hlystov"
#property link      "cmillion@narod.ru"

#property indicator_chart_window
//-------------------------------------------------------------
extern int size_font=10;
extern int corner=3;//corner of the conclusion data
extern color color_UP = OrangeRed;
extern color color_DN = MediumBlue;
extern color color_0  = DimGray;
extern int period_TR=8;//period (only for "offset")
extern int offset_TR=5;//offset (only for "offset")
//-------------------------------------------------------------
string typetrend[4] = {"offset","offset2","5 13 34","MACD 5 34 5"};
string string_per[9] = {"M1","M5","M15","M30","H1","H4","D1","W1","MN1"};
int per[9] = {1,5,15,30,60,240,1440,10080,43200};
int trend[9],
    trendALL=0,
    sim,i,d;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   if (corner==1 || corner==2) {d = size_font*1.5;} else d = 0;
   int Х = size_font*9;
   double Y = 10*(size_font+2);
   ObjectCreate ("All Period", OBJ_LABEL, 0, 0, 0);
   ObjectSet    ("All Period", OBJPROP_CORNER, corner);
   ObjectSet    ("All Period", OBJPROP_XDISTANCE, 10 );
   ObjectSet    ("All Period", OBJPROP_YDISTANCE, 5);
   for (i=0; i<9; i++) 
   {
      ObjectCreate (string_per[i]+" Period", OBJ_LABEL, 0, 0, 0);
      ObjectSetText(string_per[i]+" Period",string_per[i]+" ",size_font,"Arial",color_0);
      ObjectSet    (string_per[i]+" Period", OBJPROP_CORNER, corner);
      ObjectSet    (string_per[i]+" Period", OBJPROP_XDISTANCE, Х );
      ObjectSet    (string_per[i]+" Period",  OBJPROP_YDISTANCE, Y-i*(size_font+2));

      ObjectCreate (string_per[i]+" MACD", OBJ_LABEL, 0, 0, 0);
      ObjectSet    (string_per[i]+" MACD", OBJPROP_CORNER, corner);
      ObjectSet    (string_per[i]+" MACD", OBJPROP_XDISTANCE, Х-size_font*2 );
      ObjectSet    (string_per[i]+" MACD",  OBJPROP_YDISTANCE, Y-i*(size_font+2));

      ObjectCreate (string_per[i]+" MA5/13/34", OBJ_LABEL, 0, 0, 0);
      ObjectSet    (string_per[i]+" MA5/13/34", OBJPROP_CORNER, corner);
      ObjectSet    (string_per[i]+" MA5/13/34", OBJPROP_XDISTANCE, Х-size_font*4 );
      ObjectSet    (string_per[i]+" MA5/13/34",  OBJPROP_YDISTANCE, Y-i*(size_font+2));

      ObjectCreate (string_per[i]+" offset2", OBJ_LABEL, 0, 0, 0);
      ObjectSet    (string_per[i]+" offset2", OBJPROP_CORNER, corner);
      ObjectSet    (string_per[i]+" offset2", OBJPROP_XDISTANCE, Х-size_font*6 );
      ObjectSet    (string_per[i]+" offset2",  OBJPROP_YDISTANCE, Y-i*(size_font+2));

      ObjectCreate (string_per[i]+" offset", OBJ_LABEL, 0, 0, 0);
      ObjectSet    (string_per[i]+" offset", OBJPROP_CORNER, corner);
      ObjectSet    (string_per[i]+" offset", OBJPROP_XDISTANCE, Х-size_font*8 );
      ObjectSet    (string_per[i]+" offset",  OBJPROP_YDISTANCE, Y-i*(size_font+2));
   }
   ObjectCreate (" MACD", OBJ_LABEL, 0, 0, 0);
   ObjectSet    (" MACD", OBJPROP_CORNER, corner);
   ObjectSet    (" MACD", OBJPROP_XDISTANCE, Х-size_font*2+d );
   ObjectSet    (" MACD", OBJPROP_YDISTANCE, Y+size_font*6-d*2);
   ObjectSet    (" MACD", OBJPROP_ANGLE, 90);
   ObjectSetText(" MACD", "MACD ",size_font,"Arial",color_0);

   ObjectCreate (" MA5/13/34", OBJ_LABEL, 0, 0, 0);
   ObjectSet    (" MA5/13/34", OBJPROP_CORNER, corner);
   ObjectSet    (" MA5/13/34", OBJPROP_XDISTANCE, Х-size_font*4+d );
   ObjectSet    (" MA5/13/34", OBJPROP_YDISTANCE, Y+size_font*6-d*2);
   ObjectSet    (" MA5/13/34", OBJPROP_ANGLE, 90);
   ObjectSetText(" MA5/13/34", "5/13/34",size_font,"Arial",color_0);

   ObjectCreate (" offset2", OBJ_LABEL, 0, 0, 0);
   ObjectSet    (" offset2", OBJPROP_CORNER, corner);
   ObjectSet    (" offset2", OBJPROP_XDISTANCE, Х-size_font*6+d );
   ObjectSet    (" offset2", OBJPROP_YDISTANCE, Y+size_font*6-d*2);
   ObjectSet    (" offset2", OBJPROP_ANGLE, 90);
   ObjectSetText(" offset2", "offset2 ",size_font,"Arial",color_0);

   ObjectCreate (" offset", OBJ_LABEL, 0, 0, 0);
   ObjectSet    (" offset", OBJPROP_CORNER, corner);
   ObjectSet    (" offset", OBJPROP_XDISTANCE, Х-size_font*8+d );
   ObjectSet    (" offset", OBJPROP_YDISTANCE, Y+size_font*6-d*2);
   ObjectSet    (" offset", OBJPROP_ANGLE, 90);
   ObjectSetText(" offset", "offset   ",size_font,"Arial",color_0);
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
   ObjectDelete("All Period");
   ObjectDelete(" MACD");
   ObjectDelete(" MA5/13/34");
   ObjectDelete(" offset");
   ObjectDelete(" offset2");
   for (i=0; i<9; i++) 
   {
      ObjectDelete(string_per[i]+" Period");
      ObjectDelete(string_per[i]+" MACD");
      ObjectDelete(string_per[i]+" MA5/13/34");
      ObjectDelete(string_per[i]+" offset");
      ObjectDelete(string_per[i]+" offset2");
   }
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   if (ObjectFind("All Period")!=0) 
   {
      init();
      //выбор типа
   }
   string str;
   color colortrend;
   //----------------------------------
   TR_R(0);//offset
   for (i=0; i<9; i++)
   {
      trendALL = trendALL + trend[i];
      if (trend[i]==0){colortrend=color_0;str="";} 
      if (trend[i]>0) {colortrend=color_UP;str="UP";}    
      if (trend[i]<0) {colortrend=color_DN;str="DN";}
      ObjectSetText(string_per[i]+" offset",str,size_font,"Arial",colortrend);
   }
   TR_R(1);//offset2
   for (i=0; i<9; i++)
   {
      trendALL = trendALL + trend[i];
      if (trend[i]==0){colortrend=color_0;str="";} 
      if (trend[i]>0) {colortrend=color_UP;str="UP";}    
      if (trend[i]<0) {colortrend=color_DN;str="DN";}
      ObjectSetText(string_per[i]+" offset2",str,size_font,"Arial",colortrend);
   }
   TR_R(2);//MA5/13/34
   for (i=0; i<9; i++)
   {
      trendALL = trendALL + trend[i];
      if (trend[i]==0){colortrend=color_0;str="";} 
      if (trend[i]>0) {colortrend=color_UP;str="UP";}    
      if (trend[i]<0) {colortrend=color_DN;str="DN";}
      ObjectSetText(string_per[i]+" MA5/13/34",str,size_font,"Arial",colortrend);
   }
   TR_R(3);//macd
   for (i=0; i<9; i++)
   {
      trendALL = trendALL + trend[i];
      if (trend[i]==0){colortrend=color_0;str="";} 
      if (trend[i]>0) {colortrend=color_UP;str="UP";}    
      if (trend[i]<0) {colortrend=color_DN;str="DN";}
      ObjectSetText(string_per[i]+" MACD",str,size_font,"Arial",colortrend);
   }
   if (trendALL==0){colortrend=color_0;str="";}     
   if (trendALL>0) {colortrend=Red;  str="UP ";}     
   if (trendALL<0) {colortrend=Green;str="DN ";}
   ObjectSetText("All Period","All "+str,size_font,"Arial",colortrend);
return(0);
}
//+------------------------------------------------------------------+
void TR_R(int t)
{
   switch(t)
   {  
      case 0 ://offset leading method
         for (i=0; i<9; i++) trend[i] = iCustom(NULL,0,"offset",period_TR,offset_TR,per[i],2,0);
      break; 
      case 1 ://offset устоявшийся trend
         for (i=0; i<9; i++)  trend[i] = iCustom(NULL,0,"offset",period_TR,offset_TR,per[i],2,0) + iCustom(NULL,0,"offset",period_TR,offset_TR,per[i],5,0);
      break; 
      case 2 : //way of the determination trend on method Ticket Williams on base MA 5 13 34
         double MA5,MA13,MA34;
         for (i=0; i<9; i++)
         {
            MA5  = iMA(NULL,per[i],5 ,0,MODE_SMA,PRICE_CLOSE,0);
            MA13 = iMA(NULL,per[i],13,0,MODE_SMA,PRICE_CLOSE,0);
            MA34 = iMA(NULL,per[i],34,0,MODE_SMA,PRICE_CLOSE,0);
            trend[i] = 0; if (MA5 > MA13 && MA5 > MA34) trend[i] = 1; if (MA5 < MA13 && MA5 < MA34) trend[i] = -1;
         }
      break; 
      case 3 ://way of the determination trend on MACD 5 34 5
         for (i=0; i<9; i++)
         {
            trend[i] = 0;
            if (iMACD(NULL,per[i],5,34,5,PRICE_CLOSE,MODE_MAIN,0) > iMACD(NULL,per[i],5,34,5,PRICE_CLOSE,MODE_MAIN,1)) trend[i] =  1;
            if (iMACD(NULL,per[i],5,34,5,PRICE_CLOSE,MODE_MAIN,0) < iMACD(NULL,per[i],5,34,5,PRICE_CLOSE,MODE_MAIN,1)) trend[i] = -1;
         }
      break; 
   }
}
//+------------------------------------------------------------------+

