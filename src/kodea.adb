with Lista_Ordenatuak, Aginduak, Motak, Nodo, Ada.Text_Io,Ada.Integer_Text_Io;
use Ada.Text_Io,Ada.Integer_Text_Io;


package body Kodea is


   package Agindu_Zerrenda is new Lista_Ordenatuak (
      Osagai   => Nodo.Nodo,     
      Asignatu => Nodo.Asignatu, 
      Berdin   => Nodo.Berdin);

   Erreferentzia_Okerra : exception;  


   -- Egoera Makina Abstraktu moduan definituta
   Bitarteko_Kodea : Agindu_Zerrenda.Lista_Ordenatua;  
   Hurrengo_Ident  : Integer                         := - 1; -- Identifikadoreen izenak gordetzeko        



   ---------------- Funtzio laguntzaileak
   function Karakterera (
         Dig : Integer ) 
     return Character is 
   begin
      case Dig is
         when 0 =>
            return '0';
         when 1 =>
            return '1';
         when 2 =>
            return '2';
         when 3 =>
            return '3';
         when 4 =>
            return '4';
         when 5 =>
            return '5';
         when 6 =>
            return '6';
         when 7 =>
            return '7';
         when 8 =>
            return '8';
         when 9 =>
            return '9';
         when others =>
            return '?';
      end case;
   end Karakterera ;


   function Ida (
         Kont : in     Integer ) 
     return Motak.Token_Str is 
      -- ENTRADA: No toma nada como entrada pero necesita el valor  de  un  con
      --          tador de identificadores para no repetirlos.
      -- SALIDA : Obtiene un nuevo identificador diferente de los ya generados.
      -- PROCESO: Una vez tenemos el contador, se incrementa para no repetir  y
      --          se va dividiendo sucesivamente entre 10, tomando el resto  de 
      --          cada division como primer digito a partir de la derecha de el
      --          identificador.
      Dig        : Integer         := 0;  
      Id         : Motak.Token_Str := "T00000                        ";  
      Dig_Bestea : Integer;  
   begin
      Dig := Kont;
      Dig_Bestea:= Kont;
      for I in reverse 3..7 loop
         Dig_Bestea:= Dig mod 10 ;
         Dig   := Dig /10    ;
         Id ( I ):= Karakterera ( Dig_Bestea ) ;
      end loop;
      return Id;
   end Ida ;

   function Stringera (
         Erref : in     Erreferentziak.Erreferentzia ) 
     return String is 
      Ag          : String  := "   ";  
      Zkia,  
      Zkia_Bestea : Integer;  
   begin
      Zkia:= Erref   ;
      Zkia_Bestea:= Erref;
      for I in reverse 1..3 loop
         Zkia_Bestea:= Zkia mod 10 ;
         Zkia   := Zkia /10    ;
         Ag(I) := Karakterera ( Zkia_Bestea) ;
      end loop;
      return Ag;
   end Stringera;





   --------------------
   -- Agindua_Gehitu --
   --------------------
   procedure Agindua_Gehitu (
         Agindua : Aginduak.Agindu ) is 
      N : Nodo.Nodo;  

   begin
      if Agindu_Zerrenda.Hutsa_Da(Bitarteko_Kodea) then
         N.Zkia := 1;
      else
         N.Zkia := Agindu_Zerrenda.Azkena(Bitarteko_Kodea).Zkia + 1;
      end if;
      N.Agin := Agindua;
      Agindu_Zerrenda.Erantsi_Bukaeran(Bitarteko_Kodea,N);
      --Put("Agindua gehituta: ");
      --Put(N.Zkia);
      --New_Line;
   exception
      when Agindu_Zerrenda.Lekurik_Ez =>
         raise Storage_Error;
   end Agindua_Gehitu;

   -------------------
   -- Agindua_Osatu --
   -------------------

   procedure Agindua_Osatu (
         Erreferentzia : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Etiketa       : in     Erreferentziak.Erreferentzia          ) is 
      Bitartekoa          : Agindu_Zerrenda.Lista_Ordenatua;  
      Lag                 : Nodo.Nodo;  
      Erref               : Erreferentziak.Erreferentzia;  
      Erreferentzia_Lista : Erreferentzia_Listak.Lista_Ordenatua; -- := Erreferentzia;        
   begin
      Erreferentzia_Listak.Sortu_Hutsa(Erreferentzia_Lista);
      Erreferentzia_Listak.Kopiatu(Erreferentzia,Erreferentzia_Lista);
      while not Erreferentzia_Listak.Hutsa_Da(Erreferentzia_Lista) loop
         Agindu_Zerrenda.Sortu_Hutsa(Bitartekoa);
         Erref := Erreferentzia_Listak.Lehena(Erreferentzia_Lista);
         while not Agindu_Zerrenda.Hutsa_Da(Bitarteko_Kodea) and then Agindu_Zerrenda.Lehena(Bitarteko_Kodea).Zkia /= Erref loop
            Agindu_Zerrenda.Erantsi_Bukaeran(Bitartekoa,Agindu_Zerrenda.Lehena(Bitarteko_Kodea));
            Agindu_Zerrenda.Hondarra(Bitarteko_Kodea);
         end loop;
         if Agindu_Zerrenda.Hutsa_Da(Bitarteko_Kodea) then
            raise Erreferentzia_Okerra;
         else
            --Put_Line("Agindua osatzen:");
            Lag.Zkia := Erref;
            Aginduak.Sortu(Aginduak.Balioa(Agindu_Zerrenda.Lehena(Bitarteko_Kodea).Agin) & " " & Stringera(Etiketa) &";",Lag.Agin);
            --Put(Agindu_Zerrenda.Lehena(Bitarteko_Kodea).Zkia);Put(" agindua ");Put(Etiketa);Put("-ekin");
            --New_Line;
            Agindu_Zerrenda.Erantsi_Bukaeran(Bitartekoa, Lag);
            Agindu_Zerrenda.Hondarra(Bitarteko_Kodea);
            while not Agindu_Zerrenda.Hutsa_Da(Bitarteko_Kodea) loop
               --Put_line("Osatuta, bitarteko_kodea osatzen");
               Agindu_Zerrenda.Erantsi_Bukaeran(Bitartekoa,Agindu_Zerrenda.Lehena(Bitarteko_Kodea));
               Agindu_Zerrenda.Hondarra(Bitarteko_Kodea);
            end loop;
            --Bitarteko_Kodea := Bitartekoa;
            Agindu_Zerrenda.Sortu_Hutsa(Bitarteko_Kodea);
            Agindu_Zerrenda.Kopiatu(Bitartekoa,Bitarteko_Kodea);
         end if;
         Erreferentzia_Listak.Hondarra(Erreferentzia_Lista);
         --put_line("hurrengo erreferentzia");
      end loop;

   end Agindua_Osatu;

   ---------------
   -- Hasieratu --
   ---------------

   procedure Hasieratu is 
   begin
      Agindu_Zerrenda.Sortu_Hutsa(Bitarteko_Kodea);
   end Hasieratu;

   ------------------
   -- Ident_Berria --
   ------------------

   function Ident_Berria return Motak.Token_Str is 
   begin
      Hurrengo_Ident := Hurrengo_Ident + 1;
      return Ida(Hurrengo_Ident);
   end Ident_Berria;


   -------------------------
   -- Lortu_Erreferentzia --
   -------------------------

   function Lortu_Erreferentzia return Erreferentziak.Erreferentzia is 
   begin
      return Agindu_Zerrenda.Azkena(Bitarteko_Kodea).Zkia + 1;
   end Lortu_Erreferentzia;



   procedure Kodea_Idatzi (
         F_Izena : String ) is 
      F  : File_Type;  
      Bk : Agindu_Zerrenda.Lista_Ordenatua;  
   begin
      Agindu_Zerrenda.Kopiatu(Bitarteko_Kodea, Bk);
      Ada.Text_Io.Create(F,Out_File,F_Izena);
      while not Agindu_Zerrenda.Hutsa_Da(Bk) loop
         Put (F,Agindu_Zerrenda.Lehena(Bk).Zkia, Width => 3);
         Put(F,": " & Aginduak.Balioa(Agindu_Zerrenda.Lehena(Bk).Agin));
         New_Line(F);
         Agindu_Zerrenda.Hondarra(Bk);
      end loop;
      Ada.Text_Io.Close(F);
   end Kodea_Idatzi;

end Kodea;

