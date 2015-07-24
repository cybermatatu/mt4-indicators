//+------------------------------------------------------------------+
//|                                                 JJN-BigTrend.mq4 |
//|                                      Copyright © 2012, JJ Newark |
//|                                            http:/jjnewark.atw.hu |
//|                                             jjnewark@freemail.hu |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2012, JJ Newark"
#property link      "http:/jjnewark.atw.hu"
 
 
#property indicator_chart_window
 
 double     MainVal[];
 
double ValSum[];
 
 double     MainVal1[];
 
double ValSum1[]; 
 double     MainVal2[];
 
double ValSum2[];
 double     MainVal3[];
 
double ValSum3[];
double Vals[8];
double Vals1[8];
double Vals2[8];
double Vals3[8];
double Vals4[8];
double ValSumTemp;
double ValSumTemp1;
double ValSumTemp2;
double ValSumTemp3;
double ValSumTemp4;
extern int tf=0;
int per[]={5,8,13,21,34,55,89,144};
 extern color      BuyColor                    = YellowGreen;
extern color      SellColor                   = OrangeRed;
extern int        DisplayDecimals             = 4;
int limit;
//+------------------------------------------------------------------------------------------------------------------+
// YOU CAN CHANGE THESE PARAMETERS ACCORDING TO YOUR TASTE:
//+------------------------------------------------------------------------------------------------------------------+
int     tfnumber      = 5; // Number of the timeframes
int     tframe[]      = {1,5,15,60,240}; // Timeframes in minutes
double  IndVal[][5]; // Be the second array-index equal with tfnumber
int     NumberOfPairs = 9; // Number of the pairs
string  Pairs[]       = {"EURUSD","GBPUSD","AUDUSD","NZDUSD","USDJPY","GBPJPY","EURJPY","USDCHF","AUDJPY"}; // Requested pairs
//+------------------------------------------------------------------------------------------------------------------+
//+------------------------------------------------------------------------------------------------------------------+
 
 
 
 
extern int        TrendPeriod                 = 55;
extern int        Ma_Price                    = PRICE_CLOSE;
extern color      UpColor                     = Lime;
extern color      DownColor                   = Red;
extern color      FlatColor                   = Gold;
extern color      FontColor                   = Moccasin;
extern int        PosX                        = 10;
extern int        PosY                        = 250;
 
double val_0,val_1;
 
//********************************************************************************************************************************************************************************************************************************** 
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- 
   IndicatorBuffers(8);
   SetIndexStyle(0,DRAW_SECTION);
   SetIndexBuffer(0,MainVal);
   SetIndexBuffer(1,ValSum);
   
   SetIndexBuffer(2,MainVal1);
   SetIndexBuffer(3,ValSum1);
   SetIndexBuffer(4,MainVal2);
   SetIndexBuffer(5,ValSum2);
   
   SetIndexBuffer(6,MainVal3);
   SetIndexBuffer(7,ValSum3);
   
   
   for(int w=0;w<NumberOfPairs;w++)
      {
      for(int j=0;j<tfnumber;j++)
      {
         ObjectCreate("BigTrendInd"+w+j,OBJ_LABEL,0,0,0,0,0);
         ObjectSet("BigTrendInd"+w+j,OBJPROP_CORNER,0);
         ObjectSet("BigTrendInd"+w+j,OBJPROP_XDISTANCE,j*25+PosX+80);
         ObjectSet("BigTrendInd"+w+j,OBJPROP_YDISTANCE,w*16+PosY+10);
         ObjectSetText("BigTrendInd"+w+j,"l",15,"Wingdings",Silver);
      } 
      }
   
   for(w=0;w<NumberOfPairs;w++)
      {
         ObjectCreate("BigTrendPairs"+w,OBJ_LABEL,0,0,0,0,0);
         ObjectSet("BigTrendPairs"+w,OBJPROP_CORNER,0);
         ObjectSet("BigTrendPairs"+w,OBJPROP_XDISTANCE,PosX);
         ObjectSet("BigTrendPairs"+w,OBJPROP_YDISTANCE,w*16+PosY+12);
         ObjectSetText("BigTrendPairs"+w,Pairs[w],10,"Arial Black",FontColor);
        // jjn(Pairs[w]);
      }
   /*   
   ObjectCreate("BigTrendLine0",OBJ_LABEL,0,0,0,0,0);
   ObjectSet("BigTrendLine0",OBJPROP_CORNER,0);
   ObjectSet("BigTrendLine0",OBJPROP_XDISTANCE,PosX+10);
   ObjectSet("BigTrendLine0",OBJPROP_YDISTANCE,NumberOfPairs*16+PosY+6);
   ObjectSetText("BigTrendLine0","   ----------------------",8,"Tahoma",FontColor);
 
   ObjectCreate("BigTrendLine1",OBJ_LABEL,0,0,0,0,0);
   ObjectSet("BigTrendLine1",OBJPROP_CORNER,0);
   ObjectSet("BigTrendLine1",OBJPROP_XDISTANCE,PosX+10);
   ObjectSet("BigTrendLine1",OBJPROP_YDISTANCE,NumberOfPairs*16+PosY+8);
   ObjectSetText("BigTrendLine1","   ----------------------",8,"Tahoma",FontColor);
   ObjectCreate("BigTrendIndName",OBJ_LABEL,0,0,0,0,0);
   ObjectSet("BigTrendIndName",OBJPROP_CORNER,0);
   ObjectSet("BigTrendIndName",OBJPROP_XDISTANCE,PosX+20);
   ObjectSet("BigTrendIndName",OBJPROP_YDISTANCE,NumberOfPairs*16+PosY+16);
   ObjectSetText("BigTrendIndName","JJN-BigTrend ("+TrendPeriod+")",8,"Tahoma",FontColor);
   
   */
  
   ArrayResize(IndVal,NumberOfPairs);
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   for(int w=0;w<NumberOfPairs;w++)
      {
      for(int j=0;j<tfnumber;j++)
      {
      ObjectDelete("BigTrendInd"+w+j);
      }
      }   
      
   for(w=0;w<NumberOfPairs;w++)
      {
         ObjectDelete("BigTrendPairs"+w);
      }
      
   ObjectDelete("BigTrendLine0");
   ObjectDelete("BigTrendLine1");
   ObjectDelete("BigTrendIndName");
    ObjectsDeleteAll();  
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
   //int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;  
       // Print("limit =",limit); 
 
   int separat=0;
    jjn("EURUSD",0);
    jjn1("GBPJPY",81);
    jjn2("EURJPY",97);
    jjn3("NZDUSD",49);
   for(int z=0;z<NumberOfPairs;z++)
      {               
 
   for(int x=0;x<tfnumber;x++)
      {
      
      val_0=iMA(Pairs[z],tframe[x],TrendPeriod,0,MODE_EMA,Ma_Price,0);
      val_1=iMA(Pairs[z],tframe[x],TrendPeriod,1,MODE_EMA,Ma_Price,0);
      
            
        if (val_0 > val_1 && iLow(Pairs[z],tframe[x],0) > val_0) // UPTREND
        {
        IndVal[z][x]=1;
        }
        else if (val_0 < val_1 && iHigh(Pairs[z],tframe[x],0) < val_0) // DOWNTREND
        {
        IndVal[z][x]=-1;
        }
        else IndVal[z][x]=0; // RANGING
      }
      }
     
   
   for(int q=0;q<NumberOfPairs;q++)
      {
  //  jjn(Pairs[q],separat);
 //   separat+=16;
      for(int y=0;y<tfnumber;y++)
      {
         if(IndVal[q][y]==-1) ObjectSetText("BigTrendInd"+q+y,"l",15,"Wingdings",DownColor);
         if(IndVal[q][y]==0) ObjectSetText("BigTrendInd"+q+y,"l",15,"Wingdings",FlatColor);
         if(IndVal[q][y]==1) ObjectSetText("BigTrendInd"+q+y,"l",15,"Wingdings",UpColor);
      }
      }
     
   
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
void jjn(string paire,int x)
{
 int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- 
   for(int i=0; i<limit; i++)
   {
      for(int j=0; j<8; j++)
      {
      Vals[j]=iMA(paire,tf,per[j],0,MODE_EMA,PRICE_CLOSE,i);
      }
   
      ValSumTemp=0;
      for(int k=0; k<8; k++)
      {
      ValSumTemp+=Vals[k];
      }
      ValSum[i]=ValSumTemp/8;
   }
   
   
   for(i=0; i<limit; i++)
   {
   if(ValSum[i]>((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum[i+1]<((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
      { 
      MainVal[i]=iHigh(paire,tf,i); 
      }
      else  if(ValSum[i]<((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum[i+1]>((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
 
  // else if(ValSum[i]<((iHigh(paire,0,i)+iLow(paire,0,i))/2 && ValSum[i+1]>((iHigh(paire,0,i+1)+iLow(paire,0,i+1))/2) ) 
      {
      MainVal[i]=iLow(paire,tf,i);
      }
   else MainVal[i]=EMPTY_VALUE;
   }
   
   double lastprice=0;
        
   int found=0;
   int w=0;
      
      while(found<1)
      {
         if(MainVal[w]!=EMPTY_VALUE)
         {
            lastprice=MainVal[w];
            found++;
         }
         w++;
      }
    //ObjectDelete("paire1a"+x);
    //ObjectDelete("paire1"+x);
    if(ValSum[0]<(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    { 
  
    ObjectDelete("paire0a");
    ObjectDelete("paire0ab");
    ObjectDelete("paire0abc");
    drawLabel("paire0","HA"+"   "+DoubleToStr(lastprice,DisplayDecimals)+ "   ",10,"Arial Black",BuyColor,0,220,261+x);
    drawLabel("paire0b",DoubleToStr(iClose(paire,0,0),5),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire0bc","  "+DoubleToStr((iClose(paire,0,0)-lastprice)*10000,1),10,"Arial Black",Aqua,0,368,261+x);
    }
    else if(ValSum[0]>(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    {
 
    ObjectDelete("paire0");
    ObjectDelete("paire0b");
    ObjectDelete("paire0bc");
    drawLabel("paire0a"  ,"VT"+"   "+DoubleToStr(lastprice,DisplayDecimals)+ "   ",10,"Arial Black",SellColor,0,220,261+x);
    drawLabel("paire0ab"  ,DoubleToStr(iClose(paire,0,0),5),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire0abc"  ,"  "+ DoubleToStr((lastprice-iClose(paire,0,0))*10000,1),10,"Arial Black",Aqua,0,368,261+x);
    }
 
}
void drawLabel(string as_0, string as_8, int ai_16, string as_20, color ai_28, int ai_32, int ai_36, int ai_40)
{
    ObjectCreate(as_0, OBJ_LABEL, 0, 0, 0);
    ObjectSetText(as_0, as_8, ai_16, as_20, ai_28);
    ObjectSet(as_0, OBJPROP_CORNER, ai_32);
    ObjectSet(as_0, OBJPROP_XDISTANCE, ai_36);
    ObjectSet(as_0, OBJPROP_YDISTANCE, ai_40);
}
void jjn1(string paire,int x)
{
 int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- 
 //********************************************************************************
   for(int i=0; i<limit; i++)
   {
      for(int j=0; j<8; j++)
      {
      Vals1[j]=iMA(paire,tf,per[j],0,MODE_EMA,PRICE_CLOSE,i);
      }
   
      ValSumTemp1=0;
      for(int k=0; k<8; k++)
      {
      ValSumTemp1+=Vals1[k];
      }
      ValSum1[i]=ValSumTemp1/8;
   }
   
   
   for(i=0; i<limit; i++)
   {
   if(ValSum1[i]>((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum1[i+1]<((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
      { 
      MainVal1[i]=iHigh(paire,0,i); 
      }
      else  if(ValSum1[i]<((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum1[i+1]>((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
 
  // else if(ValSum[i]<((iHigh(paire,0,i)+iLow(paire,0,i))/2 && ValSum[i+1]>((iHigh(paire,0,i+1)+iLow(paire,0,i+1))/2) ) 
      {
      MainVal1[i]=iLow(paire,tf,i);
      }
   else MainVal1[i]=EMPTY_VALUE;
   }
   
   double lastprice1=0;
        
   int found=0;
   int w=0;
      
      while(found<1)
      {
         if(MainVal1[w]!=EMPTY_VALUE)
         {
            lastprice1=MainVal1[w];
            found++;
         }
         w++;
      }
    //ObjectDelete("paire1a"+x);
    //ObjectDelete("paire1"+x);
    if(ValSum1[0]<(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    { 
  
    ObjectDelete("paire1a");
    ObjectDelete("paire1ab");
    ObjectDelete("paire1abc");
    drawLabel("paire1","HA"+"   "+DoubleToStr(lastprice1,3)+ "   ",10,"Arial Black",BuyColor,0,220,261+x);
    drawLabel("paire1b",DoubleToStr(iClose(paire,0,0),3),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire1bc","  "+DoubleToStr((iClose(paire,0,0)-lastprice1)*100,1),10,"Arial Black",Aqua,0,368,261+x);
    }
    else if(ValSum1[0]>(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    {
 
    ObjectDelete("paire1");
    ObjectDelete("paire1b");
    ObjectDelete("paire1bc");
    drawLabel("paire1a"  ,"VT"+"   "+DoubleToStr(lastprice1,3)+ "   ",10,"Arial Black",SellColor,0,220,261+x);
    drawLabel("paire1ab"  ,DoubleToStr(iClose(paire,0,0),3),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire1abc"  ,"  "+ DoubleToStr((lastprice1-iClose(paire,0,0))*100,1),10,"Arial Black",Aqua,0,368,261+x);
    }
 
}
void jjn2(string paire,int x)
{
 int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- 
 
   for(int i=0; i<limit; i++)
   {
      for(int j=0; j<8; j++)
      {
      Vals2[j]=iMA(paire,tf,per[j],0,MODE_EMA,PRICE_CLOSE,i);
      }
   
      ValSumTemp2=0;
      for(int k=0; k<8; k++)
      {
      ValSumTemp2+=Vals2[k];
      }
      ValSum2[i]=ValSumTemp2/8;
   }
   
   
   for(i=0; i<limit; i++)
   {
   if(ValSum2[i]>((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum2[i+1]<((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
      { 
      MainVal2[i]=iHigh(paire,tf,i); 
      }
      else  if(ValSum2[i]<((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum2[i+1]>((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
 
  // else if(ValSum[i]<((iHigh(paire,0,i)+iLow(paire,0,i))/2 && ValSum[i+1]>((iHigh(paire,0,i+1)+iLow(paire,0,i+1))/2) ) 
      {
      MainVal2[i]=iLow(paire,tf,i);
      }
   else MainVal2[i]=EMPTY_VALUE;
   }
   
   double lastprice2=0;
        
   int found=0;
   int w=0;
      
      while(found<1)
      {
         if(MainVal2[w]!=EMPTY_VALUE)
         {
            lastprice2=MainVal2[w];
            found++;
         }
         w++;
      }
    //ObjectDelete("paire1a"+x);
    //ObjectDelete("paire1"+x);
    if(ValSum2[0]<(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    { 
  
    ObjectDelete("paire2a");
    ObjectDelete("paire2ab");
    ObjectDelete("paire2abc");
    drawLabel("paire2","HA"+"   "+DoubleToStr(lastprice2,3)+ "   ",10,"Arial Black",BuyColor,0,220,261+x);
    drawLabel("paire2b",DoubleToStr(iClose(paire,0,0),3),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire2bc","  "+DoubleToStr((iClose(paire,0,0)-lastprice2)*100,1),10,"Arial Black",Aqua,0,368,261+x);
    }
    else if(ValSum2[0]>(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    {
 
    ObjectDelete("paire2");
    ObjectDelete("paire2b");
    ObjectDelete("paire2bc");
    drawLabel("paire2a"  ,"VT"+"   "+DoubleToStr(lastprice2,3)+ "   ",10,"Arial Black",SellColor,0,220,261+x);
    drawLabel("paire2ab"  ,DoubleToStr(iClose(paire,0,0),3),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire2abc"  ,"  "+ DoubleToStr((lastprice2-iClose(paire,0,0))*100,1),10,"Arial Black",Aqua,0,368,261+x);
    }
 
}
void jjn3(string paire,int x)
{
 int limit;
   int counted_bars=IndicatorCounted();
//---- last counted bar will be recounted
   if(counted_bars>0) counted_bars--;
   limit=Bars-counted_bars;
//---- 
 
   for(int i=0; i<limit; i++)
   {
      for(int j=0; j<8; j++)
      {
      Vals3[j]=iMA(paire,tf,per[j],0,MODE_EMA,PRICE_CLOSE,i);
      }
   
      ValSumTemp3=0;
      for(int k=0; k<8; k++)
      {
      ValSumTemp3+=Vals3[k];
      }
      ValSum3[i]=ValSumTemp3/8;
   }
   
   
   for(i=0; i<limit; i++)
   {
   if(ValSum3[i]>((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum3[i+1]<((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
      { 
      MainVal3[i]=iHigh(paire,tf,i); 
      }
      else  if(ValSum3[i]<((iHigh(paire,tf,i)+iLow(paire,tf,i))/2) && ValSum3[i+1]>((iHigh(paire,tf,i+1)+iLow(paire,tf,i+1))/2) )
 
  // else if(ValSum[i]<((iHigh(paire,0,i)+iLow(paire,0,i))/2 && ValSum[i+1]>((iHigh(paire,0,i+1)+iLow(paire,0,i+1))/2) ) 
      {
      MainVal3[i]=iLow(paire,tf,i);
      }
   else MainVal3[i]=EMPTY_VALUE;
   }
   
   double lastprice3=0;
        
   int found=0;
   int w=0;
      
      while(found<1)
      {
         if(MainVal3[w]!=EMPTY_VALUE)
         {
            lastprice3=MainVal3[w];
            found++;
         }
         w++;
      }
   
    if(ValSum3[0]<(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    { 
  
    ObjectDelete("paire3a");
    ObjectDelete("paire3ab");
    ObjectDelete("paire3abc");
    drawLabel("paire3","HA"+"   "+DoubleToStr(lastprice3,DisplayDecimals)+ "   ",10,"Arial Black",BuyColor,0,220,261+x);
    drawLabel("paire3b",DoubleToStr(iClose(paire,0,0),5),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire3bc","  "+DoubleToStr((iClose(paire,0,0)-lastprice3)*10000,1),10,"Arial Black",Aqua,0,368,261+x);
    }
    else if(ValSum3[0]>(iHigh(paire,tf,0)+iLow(paire,tf,0))/2)
    {
 
    ObjectDelete("paire3");
    ObjectDelete("paire3b");
    ObjectDelete("paire3bc");
    drawLabel("paire3a"  ,"VT"+"   "+DoubleToStr(lastprice3,DisplayDecimals)+ "   ",10,"Arial Black",SellColor,0,220,261+x);
    drawLabel("paire3ab"  ,DoubleToStr(iClose(paire,0,0),5),10,"Arial Black",Yellow,0,310,261+x);
    drawLabel("paire3abc"  ,"  "+ DoubleToStr((lastprice3-iClose(paire,0,0))*10000,1),10,"Arial Black",Aqua,0,368,261+x);
    }
 
}