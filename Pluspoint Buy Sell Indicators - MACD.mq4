//+------------------------------------------------------------------+
//|                                      MACD BuySell Indicators.mq4 |
//|                 Copyright © 2015, Pluspoint Kenya Ltd            |
//|                                        http://www.figcloud.com   |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2015, Pluspoint Kenya Ltd"
#property link      "http://www.figcloud.com"
#property version   "1.00"
#property description "Uses MACD and RSVI to determine when to buy or sell"
//#property description "It is possible to embed a large number of other indicators showing the highs and"
//#property description "lows and automatically build from these highs and lows various graphical tools"
 
#property indicator_chart_window
#property indicator_buffers 6
//#property indicator_color1 Yellow
//#property indicator_color2 Aqua
//#property indicator_color3 Yellow
//#property indicator_color4 Aqua
//#property indicator_color5 Yellow
//#property indicator_color6 Aqua

extern color RVI_Buy_Colour = Yellow;
extern color RVI_Sell_Colour = Aqua;

extern color MACD_Buy_Colour = Yellow;
extern color MACD_Sell_Colour = Aqua;

extern color Strong_Buy_Colour = Yellow;
extern color Strong_Sell_Colour = Aqua;

extern int Arrow_Size = 1;
//---- input parameters
 
//---- buffers
double dUpRviBuffer[];
double dDownRviBuffer[];
double dUpMacdBuffer[];
double dDownMacdBuffer[];
double dUpBothBuffer[];
double dDownBothBuffer[];
 
 
int RowNum = 0;
int LastTrend = -1;
int UP_IND    = 1;
int DOWN_IND  = 0;
 
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicator buffers mapping  
    SetIndexBuffer(0,dUpRviBuffer);
    SetIndexBuffer(1,dDownRviBuffer);   
    SetIndexBuffer(2,dUpMacdBuffer);
    SetIndexBuffer(3,dDownMacdBuffer);   
    SetIndexBuffer(4,dUpBothBuffer);
    SetIndexBuffer(5,dDownBothBuffer);   
//---- drawing settings
    SetIndexStyle(0,DRAW_ARROW,EMPTY,Arrow_Size,RVI_Buy_Colour);
    SetIndexArrow(0,233);
    SetIndexStyle(1,DRAW_ARROW,EMPTY,Arrow_Size,RVI_Sell_Colour);
    SetIndexArrow(1,234);
 
    SetIndexStyle(2,DRAW_ARROW,EMPTY,Arrow_Size,MACD_Buy_Colour);
    SetIndexArrow(2,241);
    SetIndexStyle(3,DRAW_ARROW,EMPTY,Arrow_Size,MACD_Sell_Colour);
    SetIndexArrow(3,242);
 
    SetIndexStyle(4,DRAW_ARROW,EMPTY,Arrow_Size,Strong_Buy_Colour);
    SetIndexArrow(4,252);
    SetIndexStyle(5,DRAW_ARROW,EMPTY,Arrow_Size,Strong_Sell_Colour);
    SetIndexArrow(5,252);
    //SetIndexArrow(5,SYMBOL_THUMBSUP);
 
//----
    SetIndexEmptyValue(0,0.0);
    SetIndexEmptyValue(1,0.0);
    SetIndexEmptyValue(2,0.0);
    SetIndexEmptyValue(3,0.0);
    SetIndexEmptyValue(4,0.0);
    SetIndexEmptyValue(5,0.0);
//---- name for DataWindow
    SetIndexLabel(0,"RVI Buy");
    SetIndexLabel(1,"RVI Sell");
    SetIndexLabel(2,"MACD Buy");
    SetIndexLabel(3,"MACD Sell");
    SetIndexLabel(4,"Strong Buy");
    SetIndexLabel(5,"Strong Sell");
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//---- 
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
    int nBars,nCountedBars;
    nCountedBars=IndicatorCounted();
//---- check for possible errors
    if(nCountedBars<0) return(-1);
//---- last counted bar will be recounted    
    if(nCountedBars<=2)
       nBars=Bars-nCountedBars-3;
    if(nCountedBars>2)
      {
       nCountedBars--;
       nBars=Bars-nCountedBars-1;
      }
 
   for (int ii=0; ii<nBars; ii++)
   {
      dUpMacdBuffer[ii]=0;
      dDownMacdBuffer[ii] = 0;
      dUpRviBuffer[ii]=0;
      dDownRviBuffer[ii] = 0;
      dUpBothBuffer[ii] = 0;
      dDownBothBuffer[ii] = 0;
 
      // Check if RVI has been changed
      double val0=iRVI(NULL, 0, 10,MODE_MAIN,ii);
      double sig0=iRVI(NULL, 0, 10,MODE_SIGNAL,ii);
      
      double val1=iRVI(NULL, 0, 10,MODE_MAIN,ii+1);
      double sig1=iRVI(NULL, 0, 10,MODE_SIGNAL,ii+1);
      
      if ((val0 > sig0) && (val1 < sig1))
      {
         dUpRviBuffer[ii] = Low[ii] - 2 * MarketInfo(Symbol(),MODE_POINT);
      }
      if ((val0 < sig0) && (val1 > sig1))
      {
         dDownRviBuffer[ii] = High[ii] + 2 * MarketInfo(Symbol(),MODE_POINT);
     }   
 
      // Check if MACD has been changed
      double valm0=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,ii);
      double sigm0=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,ii);
      
      double valm1=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,ii+1);
      double sigm1=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,ii+1);
      
      if ((valm0 > sigm0) && (valm1 < sigm1))
      {
         dUpMacdBuffer[ii] = Low[ii] - 0.0004;
         
      }
      if ((valm0 < sigm0) && (valm1 > sigm1))
      {
         dDownMacdBuffer[ii] = High[ii] + 2 * MarketInfo(Symbol(),MODE_POINT);
      }
      
      if ((dUpRviBuffer[ii] != 0) && (dUpMacdBuffer[ii]))
      {
	    dUpMacdBuffer[ii] = 0;
	    dUpRviBuffer[ii] = 0;
            dUpBothBuffer[ii] = Low[ii] - 2 * MarketInfo(Symbol(),MODE_POINT);
            if ((Period() >= 60) && (ii == 0))
            {
               Print("Buy alert");
               PlaySound("alert2.wav");
               //nBuy();
               //Alert ("BUY");
            }
      }
      if ((dDownRviBuffer[ii] != 0) && (dDownMacdBuffer[ii]))
      {
	 dDownMacdBuffer[ii] = 0;
	 dDownRviBuffer[ii] = 0;
         dDownBothBuffer[ii] = High[ii] + 2 * MarketInfo(Symbol(),MODE_POINT);
         if ((Period() >= 60) && (ii == 0))
         {
            Print("Sell alert");
            PlaySound("alert2.wav");
            //Alert ("SELL");
         }
      }
   }
}

/****** BUY *********/
int nBuy() {
   if(OrderSend(Symbol(),OP_BUY,0.1,Ask,3,Bid-15*Point,Bid+15*Point)) {
      Alert (GetLastError()); 
      return(0);
   }
   Alert (GetLastError()); 
 }

