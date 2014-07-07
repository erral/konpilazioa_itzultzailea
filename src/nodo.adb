with Aginduak;
package body Nodo is

   --------------
   -- Asignatu --
   --------------

   procedure Asignatu (
         N1 : in     Nodo; 
         N2 :    out Nodo  ) is 
   begin
      N2.Zkia := N1.Zkia;
      N2.Agin := N1.Agin;
   end Asignatu;

   ------------
   -- Berdin --
   ------------

   function Berdin (
         N1,              
         N2 : in     Nodo ) 
     return Boolean is 
   begin
      return N1.Zkia = N2.Zkia and Aginduak.Berdin(N1.Agin, N2.Agin);
   end Berdin;

end Nodo;

