package Erreferentziak is

   subtype Erreferentzia is Positive;

   procedure Kopiatu (P1: in Erreferentzia; P2: out Erreferentzia);
   --Post: P2-n P1en edukia kopiatzen du
   function Txikiago (P1,P2: in Erreferentzia) return Boolean;
   function Handiago (P1,P2: in Erreferentzia) return Boolean;
   function Berdin (P1,P2: in Erreferentzia) return Boolean;
   function Esan_Erreferentzia (P:in Erreferentzia) return Erreferentzia;
end Erreferentziak;