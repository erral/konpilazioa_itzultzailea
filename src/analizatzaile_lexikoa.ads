with Motak;
package Analizatzaile_Lexikoa is

   -- Identifikadore baten karaktere kopuruaren muga
   Id_Luz_Max : constant Integer := 30;  


   subtype T_St_Token is String (1..Id_Luz_Max);

   --Analizatzailearen aldagai globalak
   Lookahead  : Motak.Lookahead_M;  
   Karakterea : Character;  
   Lerroa     : Integer           := 1;  

   function Mota (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_M; 


   function Atributua (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_Str; 

   function Stringa (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_Str; 


   procedure Next_Token; 

   function Hurrengo_Karakterea return Character; 

   procedure Match (
         Tok : in     Motak.Token_M ); 



end Analizatzaile_Lexikoa ;
