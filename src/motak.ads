package Motak is

   -- Definicion del limite de caracteres de un identificador.
   Long_Id : constant Integer := 30;  

   -- Definicion de los tipos necesarios para definir LOOKAHEAD.
   subtype Token_Str is String (1..Long_Id);

   type Token_M is 
         (T_Bi_Puntu,        
          T_Bi_Puntu_Berdin, 
          T_Puntu_Koma,      
          T_Koma,            
          T_Ir_Parent,       
          T_It_Parent,       
          T_Berdin,          
          T_Handi,           
          T_Handi_Berdin,    
          T_Txiki,           
          T_Txiki_Berdin,    
          T_Gehi,            
          T_Ken,             
          T_Bider,           
          T_Zati,            
          T_Ident,           
          T_Osoko,           
          T_Erreal,          
          T_Zuri,            
          T_Fitx_Buk,        
          T_Ir_Giltza,       
          T_It_Giltza,       
          T_Iruzkin,         
          T_Berezi,          
          T_Program,         
          T_Is,              
          T_Procedure,       
          T_Integer,         
          T_Float,           
          T_In,              
          T_Out,             
          T_If,              
          T_Then,            
          T_Else,            
          T_Do,              
          T_While,           
          T_Exit,            
          T_Get,             
          T_Put_Line,        
          T_And,             
          T_Or,              
          T_Not); 

   type Ident_Mota is 
         (T_Osoko, 
      T_Erreal);
      
   -- Lookahead-en definizioa
   type Lookahead_M is 
      record 
         Token_Mota  : Token_M;  
         Token_Atr   : Token_Str;  
         Token_Izena : Token_Str;  
      end record; 

end Motak;