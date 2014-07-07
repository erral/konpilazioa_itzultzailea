package body Aginduak is

   procedure Hutsuneak_Kendu (
         S    : in     String; 
         Sout :    out String  ) is 

      Egoera       : Boolean          := False;  
      Hutsune_Gabe : String (S'range) := (others => ' ');  
      Indizea      : Integer          := 1;  

   begin

      for I in S'range loop
         if S(I) = ' ' then
            if not Egoera then
               Egoera:= True;
               Indizea:= Indizea + 1;
            end if;
         else
            if Egoera then
               Egoera:= False;
            end if;
            Hutsune_Gabe(Indizea):= S(I);
            Indizea:= Indizea + 1;
         end if;
      end loop;

      Sout := Hutsune_Gabe;

   end Hutsuneak_Kendu;

   procedure Sortu (
         S : in     String; 
         A :    out Agindu  ) is 
      Sout : String (S'range);  
   begin
      Hutsuneak_Kendu(S,Sout);
      A:=new String'(Sout);
   exception
      when Storage_Error =>
         raise Lekurik_Ez;
   end Sortu;

   procedure Kopiatu (
         A  : in     Agindu; 
         A1 :    out Agindu  ) is 
   begin
      A1:=new String'(A.All);
   exception
      when Storage_Error =>
         raise Lekurik_Ez;
   end Kopiatu;

   function Berdin (
         A1,                
         A2 : in     Agindu ) 
     return Boolean is 
   begin
      return A1.All=A2.All;
   end Berdin;

   function Balioa (
         A : in     Agindu ) 
     return String is 
   begin
      return A.All;
   end Balioa;

   function Luzera (
         A : in     Agindu ) 
     return Natural is 
   begin
      return A.All'Length;
   end Luzera;

   function "<" (
         A1,                
         A2 : in     Agindu ) 
     return Boolean is 
   begin
      return A1.All < A2.All;
   end "<";

end Aginduak;