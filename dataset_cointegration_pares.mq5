
#include <Arrays\ArrayString.mqh>

int _periodos = 100;
ENUM_TIMEFRAMES _tempo_grafico = PERIOD_D1;

void OnStart() {
   
   CArrayString *ativos = new CArrayString;
   
   int h_file = FileOpen("ativos.txt", FILE_READ|FILE_ANSI|FILE_TXT);
   if(h_file == INVALID_HANDLE) PrintFormat("Código de erro: ", GetLastError());
  
   while(!FileIsEnding(h_file)){
      string str = FileReadString(h_file);
      ativos.Add(str);
   }
   FileClose(h_file);
  
   int h_ativos = 0;
   for(int i = 0; i < ativos.Total(); i++){
      
      h_ativos = FileOpen("Ativos/" + ativos[i] + ".csv", FILE_WRITE|FILE_ANSI|FILE_TXT);
      FileWrite(h_ativos, ativos[i]);
   
      for(int k = 0; k < _periodos; k++){
      
         double price = iClose(ativos[i], _tempo_grafico, k);
         
         FileWrite(h_ativos, DoubleToString(price));
      }
      FileClose(h_ativos);
   }
}