package Errore_Tratamendua is

   type Egoerak is 
         (Programa,                     
          Erazagupenak,                 
          Erazagupenak_Bestea,          
          Ident_Zerrenda,               
          Ident_Zerrendaren_Bestea,     
          Mota,                         
          Azpiprogramen_Erazagupena,    
          Azpiprogramaren_Erazagupena,  
          Goiburukoa,                   
          Argumentuak,                  
          Parametro_Zerrenda,           
          Par_Mota,                     
          Par_Mota_Bestea,              
          Parametro_Zerrendaren_Bestea, 
          Sententzia_Zerrenda,          
          Sententzia,                   
          Exit_Bestea,                  
          Aldagaia,                     
          Adierazpena,                  
          Adierazpen_Bakuna_Bestea,     
          Baldintza,                    
          Adierazpen_Bakuna,            
          Adierazpena_Bestea,           
          Gaia,                         
          Gaia_Bestea,                  
          Faktore,                      
          Aukerazko_Id); 

   Errorea_Egon_Da : Boolean := False;  

   Konpilazioa_Bukatu : exception;  

   procedure Errorea_Tratatu (
         Egoera   : in     Egoerak; 
         Jarraitu :    out Boolean  ); 

end  Errore_Tratamendua;