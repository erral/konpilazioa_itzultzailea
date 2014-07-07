with Aginduak;

package Nodo is

   type Nodo is 
      record 
         Zkia : Integer;  
         Agin : Aginduak.Agindu;  
      end record; 


   procedure Asignatu (
         N1 : in     Nodo; 
         N2 :    out Nodo  ); 

   function Berdin (
         N1,              
         N2 : in     Nodo ) 
     return Boolean; 


end Nodo;
   