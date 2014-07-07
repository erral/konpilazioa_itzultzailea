package body Erreferentziak is


   procedure Kopiatu (P1: in Erreferentzia; P2: out Erreferentzia) is
   begin
      P2:=P1;
   end Kopiatu;   

   function Txikiago (P1,P2: in Erreferentzia) return Boolean is
   begin
       return P1<P2;
   end Txikiago;
   
   function Handiago (P1,P2: in Erreferentzia) return Boolean is
   begin
      return P1>P2;
   end Handiago;
   
   function Berdin (P1,P2: in Erreferentzia) return Boolean is
   begin
      return P1=P2;
   end Berdin;
   
   function Esan_Erreferentzia (P:in Erreferentzia) return Erreferentzia is
   begin 
      return P;
   end Esan_Erreferentzia;
end Erreferentziak;