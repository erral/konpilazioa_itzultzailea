with Analizatzaile_Lexikoa, Motak, Erreferentziak, Erreferentzia_Listak,
   Token_Str_Listak,Kodea, Aginduak;
with Ada.Text_Io, Ada.Integer_Text_Io;
use  Ada.Text_Io, Ada.Integer_Text_Io;
with Motak;
use Motak;
with Errore_Tratamendua;
use Errore_Tratamendua;

package body Analizatzaile_Sintaktikoa is

   package T is new Enumeration_Io (Motak.Token_M);
   use T;

   Lekurik_Ez,  
   Mota_Okerra : exception;  


   procedure Idatzi (
         L : in     Token_Str_Listak.Lista_Ordenatua; 
         T : in     String                            ) is 
      -- aldagaien erazagupena idazteko
      Izena    : Motak.Token_Str;  
      Lag      : Token_Str_Listak.Lista_Ordenatua := L;  
      Lag_Agin : Aginduak.Agindu;  
   begin
      while not Token_Str_Listak.Hutsa_Da(Lag) loop
         Izena := Token_Str_Listak.Lehena(Lag);
         Aginduak.Sortu(T & Izena & ";",Lag_Agin);
         Kodea.Agindua_Gehitu(Lag_Agin);
         Token_Str_Listak.Hondarra(Lag);
      end loop;
   end Idatzi;

   Mezua_Emanda : Boolean := False;  

   procedure Egiaztatu_Motak (
         Mota1,                 
         Mota2 : in     Boolean ) is 
   begin
      if Mota1 /= Mota2 and not  Mezua_Emanda then
         Put("Akatsa : ");
         Put(Analizatzaile_Lexikoa.Lerroa);
         Put(". lerroan");
         New_Line;
         Put_Line("Adierazpen boolearrak eta aritmetikoak nahasten dira.");
         Errore_Tratamendua.Errorea_Egon_Da:= True;
         Mezua_Emanda:= True;
         --raise Konpilazioa_Bukatu;
      end if;
   end Egiaztatu_Motak;


   -- Definizio aurreratuak errorerik eman ez dezan
   procedure Erazagupenak; 
   procedure Erazagupenak_Bestea; 
   procedure Ident_Zerrenda (
         Iz_Izenak :    out Token_Str_Listak.Lista_Ordenatua ); 
   procedure Ident_Zerrendaren_Bestea (
         Izb_Izenak :    out Token_Str_Listak.Lista_Ordenatua ); 
   procedure Mota (
         Mota_Mota  :    out Motak.Ident_Mota; 
         Mota_Izena :    out Motak.Token_Str   ); 
   procedure Azpiprogramaren_Erazagupena; 
   procedure Azpiprogramen_Erazagupena; 
   procedure Goiburukoa; 
   procedure Argumentuak; 
   procedure Parametro_Zerrenda; 
   procedure Par_Mota (
         Pm_Mota  :    out Motak.Token_M;  
         Pm_Izena :    out Motak.Token_Str ); 

   procedure Par_Mota_Bestea (
         Pm_Mota  :    out Motak.Token_M;  
         Pm_Izena :    out Motak.Token_Str ); 
   procedure Parametro_Zerrendaren_Bestea; 

   procedure Sententzia_Zerrenda (
         Sz_Hdo  : in     Boolean;                             
         Sz_Exit,                                              
         Sz_Next :    out Erreferentzia_Listak.Lista_Ordenatua ); 

   procedure Sententzia (
         S_Hdo  : in     Boolean;                             
         S_Next,                                              
         S_Exit :    out Erreferentzia_Listak.Lista_Ordenatua ); 
   procedure M (
         M_Erref :    out Erreferentziak.Erreferentzia ); 

   procedure N (
         N_Hur :    out Erreferentziak.Erreferentzia ); 

   procedure Exit_Bestea (
         Eb_Exit :    out Erreferentzia_Listak.Lista_Ordenatua ); 

   procedure Aldagaia (
         A_Izena :    out Motak.Token_Str ); 

   procedure Adierazpena (
         A_Izena :    out Motak.Token_Str;                      
         A_True,                                                
         A_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         A_Mota  :    out Boolean                               ); 

   procedure Baldintza (
         B_Erl :    out Motak.Token_Str ); 

   procedure Adierazpen_Bakuna_Bestea (
         Abb_Hizena : in     Motak.Token_Str;                      
         Abb_Htrue,                                                
         Abb_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Abb_Hmota  :        Boolean;                              
         Abb_Izena  :    out Motak.Token_Str;                      
         Abb_True,                                                 
         Abb_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Abb_Mota   :    out Boolean                               ); 
   procedure Adierazpen_Bakuna (
         Adb_Izena :    out Motak.Token_Str;                      
         Adb_True,                                                
         Adb_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Adb_Mota  :    out Boolean                               ); 
   procedure Adierazpena_Bestea (
         Ab_Izena  :    out Motak.Token_Str;                      
         Ab_True,                                                 
         Ab_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Ab_Mota   :    out Boolean;                              
         Ab_Hizena : in     Motak.Token_Str;                      
         Ab_Htrue,                                                
         Ab_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Ab_Hmota  : in     Boolean                               ); 

   procedure Gaia (
         G_Izena :    out Motak.Token_Str;                      
         G_True,                                                
         G_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         G_Mota  :    out Boolean                               ); 

   procedure Gaia_Bestea (
         Gb_Izena  :    out Motak.Token_Str;                      
         Gb_True,                                                 
         Gb_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Gb_Mota   :    out Boolean;                              
         Gb_Hizena : in     Motak.Token_Str;                      
         Gb_Htrue,                                                
         Gb_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Gb_Hmota  : in     Boolean                               ); 

   procedure Faktore (
         F_Izena :    out Motak.Token_Str;                      
         F_True,                                                
         F_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         F_Mota  :    out Boolean                               ); 

   procedure Aukerazko_Id; 

   -- END OF DEFINIZIO AURRERATUAK


   -- Itzultzailearen sarrera puntua

   procedure Programa is 
      Ident    : Motak.Token_Str;  
      Sz_Hdo   : Boolean                              := False;  
      Ag_Lag   : Aginduak.Agindu;  
      Sz_Exit,  
      Sz_Next  : Erreferentzia_Listak.Lista_Ordenatua;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Programa;  
   begin
      Kodea.Hasieratu;
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Program);
         Ident := Analizatzaile_Lexikoa.Stringa(
            Analizatzaile_Lexikoa.Lookahead);
         Aginduak.Sortu("prog " & Ident & ";",Ag_Lag);
         Kodea.Agindua_Gehitu(Ag_Lag);
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
         Analizatzaile_Lexikoa.Match(Motak.T_Is);
         Erazagupenak;
         Azpiprogramen_Erazagupena;
         Analizatzaile_Lexikoa.Match(Motak.T_Ir_Giltza);
         Sententzia_Zerrenda(Sz_Hdo,Sz_Exit,Sz_Next);
         Kodea.Agindua_Osatu(Sz_Next,Kodea.Lortu_Erreferentzia);
         Analizatzaile_Lexikoa.Match(Motak.T_It_Giltza);
         Aukerazko_Id;
         Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
         Aginduak.Sortu("halt;",Ag_Lag);
         Kodea.Agindua_Gehitu(Ag_Lag);
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu   =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
      when Lekurik_Ez =>
         Put("Akatsa : ");
         Put(Analizatzaile_Lexikoa.Lerroa);
         Put(". lerroan");
         New_Line;
         Put_Line("Erazagupen_lista oso luzuea. Memoria falta.");
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Programa;

   procedure Erazagupenak is 
      Idzer_Izenak : Token_Str_Listak.Lista_Ordenatua;  
      Mota_Mota    : Motak.Ident_Mota;  
      Mota_Izena   : Motak.Token_Str;  
      Jarraitu     : Boolean                          := True;  
      Egoera       : Errore_Tratamendua.Egoerak       := Erazagupenak;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Ident_Zerrenda(Idzer_Izenak);
         Analizatzaile_Lexikoa.Match(Motak.T_Bi_Puntu);
         Mota(Mota_Mota, Mota_Izena);
         Idatzi(Idzer_Izenak, Mota_Izena);
         Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
         Erazagupenak_Bestea;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
      when Lekurik_Ez =>
         raise Lekurik_Ez;
   end Erazagupenak;

   procedure Erazagupenak_Bestea is 
      Idzer_Izenak : Token_Str_Listak.Lista_Ordenatua;  
      Mota_Mota    : Motak.Ident_Mota;  
      Mota_Izena   : Motak.Token_Str;  
      Jarraitu     : Boolean                          := True;  
      Egoera       : Errore_Tratamendua.Egoerak       := Erazagupenak_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Ident_Zerrenda(Idzer_Izenak);
         Analizatzaile_Lexikoa.Match(Motak.T_Bi_Puntu);
         Mota(Mota_Mota, Mota_Izena);
         Idatzi(Idzer_Izenak, Mota_Izena);
         Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
         Erazagupenak_Bestea;
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Erazagupenak_Bestea;

   procedure Ident_Zerrenda (
         Iz_Izenak :    out Token_Str_Listak.Lista_Ordenatua ) is 
      Ident      : Motak.Token_Str;  
      Izb_Izenak : Token_Str_Listak.Lista_Ordenatua;  
      Jarraitu   : Boolean                          := True;  
      Egoera     : Errore_Tratamendua.Egoerak       := Ident_Zerrenda;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Ident := Analizatzaile_Lexikoa.Stringa(
            Analizatzaile_Lexikoa.Lookahead);
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
         Ident_Zerrendaren_Bestea(Izb_Izenak);
         Token_Str_Listak.Erantsi_Hasieran( Izb_Izenak, Ident);
         Iz_Izenak := Izb_Izenak;
      else
         Token_Str_Listak.Sortu_Hutsa(Iz_Izenak);
      end if;
   exception
      when Storage_Error =>
         raise Lekurik_Ez;
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Ident_Zerrenda;

   procedure Ident_Zerrendaren_Bestea (
         Izb_Izenak :    out Token_Str_Listak.Lista_Ordenatua ) is 
      Ident       : Motak.Token_Str;  
      Izb1_Izenak : Token_Str_Listak.Lista_Ordenatua;  
      Jarraitu    : Boolean                          := True;  
      Egoera      : Errore_Tratamendua.Egoerak       := Ident_Zerrendaren_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Koma);
         Ident := Analizatzaile_Lexikoa.Stringa(
            Analizatzaile_Lexikoa.Lookahead);
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
         Ident_Zerrendaren_Bestea(Izb1_Izenak);
         Token_Str_Listak.Erantsi_Hasieran(Izb1_Izenak,Ident);
         Izb_Izenak := Izb1_Izenak;

      else
         Token_Str_Listak.Sortu_Hutsa(Izb_Izenak);
      end if;
   exception
      when Storage_Error =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Ident_Zerrendaren_Bestea;

   procedure Mota (
         Mota_Mota  :    out Motak.Ident_Mota; 
         Mota_Izena :    out Motak.Token_Str   ) is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Mota;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Integer then
            Analizatzaile_Lexikoa.Match(Motak.T_Integer);
            Mota_Mota := Motak.T_Osoko;
            Mota_Izena := "int                           " ;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Float then
            Analizatzaile_Lexikoa.Match(Motak.T_Float);
            Mota_Mota := Motak.T_Erreal;
            Mota_Izena := "real                          ";
         end if;
      else
         Mota_Mota := Motak.T_Erreal;
         Mota_Izena := "xxxxx                         ";
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Mota;

   procedure Azpiprogramen_Erazagupena is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Azpiprogramen_Erazagupena;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Azpiprogramaren_Erazagupena;
         Azpiprogramen_Erazagupena;
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Azpiprogramen_Erazagupena;

   procedure Azpiprogramaren_Erazagupena is 
      Sz_Hdo   : Boolean                              := False;  
      Sz_Exit,  
      Sz_Next  : Erreferentzia_Listak.Lista_Ordenatua;  
      Lag_Agin : Aginduak.Agindu;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Azpiprogramaren_Erazagupena;  
   begin
      Errore_Tratamendua.Errorea_Tratatu(Egoera, Jarraitu);
      if Jarraitu then

         Goiburukoa;
         Erazagupenak;
         Analizatzaile_Lexikoa.Match(Motak.T_Ir_Giltza);
         Sententzia_Zerrenda(Sz_Hdo,Sz_Exit,Sz_Next);
         Kodea.Agindua_Osatu(Sz_Next,Kodea.Lortu_Erreferentzia);
         Analizatzaile_Lexikoa.Match(Motak.T_It_Giltza);
         Aukerazko_Id;
         Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
         Aginduak.Sortu("endproc;",Lag_Agin);
         Kodea.Agindua_Gehitu(Lag_Agin);
      end if;

   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Azpiprogramaren_Erazagupena;

   procedure Goiburukoa is 
      Ident    : Motak.Token_Str;  
      Lag_Agin : Aginduak.Agindu;  
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Goiburukoa;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Procedure);
         Ident := Analizatzaile_Lexikoa.Stringa(
            Analizatzaile_Lexikoa.Lookahead);
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
         Aginduak.Sortu("proc " & Ident & ";", Lag_Agin);
         Kodea.Agindua_Gehitu(Lag_Agin);
         Argumentuak;
         Analizatzaile_Lexikoa.Match(Motak.T_Is);
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Goiburukoa;

   procedure Argumentuak is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Argumentuak;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Ir_Parent);
         Parametro_Zerrenda;
         Analizatzaile_Lexikoa.Match(Motak.T_It_Parent);
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Argumentuak;

   procedure Parametro_Zerrenda is 
      Iz_Izenak  : Token_Str_Listak.Lista_Ordenatua;  
      Mota_Mota  : Motak.Ident_Mota;  
      Mota_Izena,  
      Pm_Izena   : Motak.Token_Str;  
      Pm_Mota    : Motak.Token_M;  
      Jarraitu   : Boolean                          := True;  
      Egoera     : Errore_Tratamendua.Egoerak       := Parametro_Zerrenda;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Ident_Zerrenda(Iz_Izenak);
         Analizatzaile_Lexikoa.Match(Motak.T_Bi_Puntu);
         Par_Mota(Pm_Mota,Pm_Izena);
         Mota(Mota_Mota, Mota_Izena);
         Idatzi(Iz_Izenak, Pm_Izena & "_" & Mota_Izena );
         Parametro_Zerrendaren_Bestea;
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Parametro_Zerrenda;

   procedure Par_Mota (
         Pm_Mota  :    out Motak.Token_M;  
         Pm_Izena :    out Motak.Token_Str ) is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Par_Mota;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_In then
            Analizatzaile_Lexikoa.Match(Motak.T_In);
            Par_Mota_Bestea(Pm_Mota, Pm_Izena);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Out then
            Analizatzaile_Lexikoa.Match(Motak.T_Out);
            Pm_Mota := Motak.T_Out;
            Pm_Izena := "                           ald";
         end if;
      else
         Pm_Mota := Motak.T_Out;
         Pm_Izena := "                         _xxxx";
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Par_Mota;

   procedure Par_Mota_Bestea (
         Pm_Mota  :    out Motak.Token_M;  
         Pm_Izena :    out Motak.Token_Str ) is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Par_Mota_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Out then
            Analizatzaile_Lexikoa.Match(Motak.T_Out);
            -- Hau T_In_Out zen
            Pm_Mota := Motak.T_Out;
            Pm_Izena := "                           ald";
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Integer or
               Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Float then --hutsa bada
            Pm_Mota := Motak.T_In;
            Pm_Izena := "                           bal";
         end if;
      else
         Pm_Mota := Motak.T_Out;
         Pm_Izena := "                         _xxxx";
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Par_Mota_Bestea;

   procedure Parametro_Zerrendaren_Bestea is 
      Iz_Izenak  : Token_Str_Listak.Lista_Ordenatua;  
      Mota_Mota  : Motak.Ident_Mota;  
      Mota_Izena,  
      Pm_Izena   : Motak.Token_Str;  
      Pm_Mota    : Motak.Token_M;  
      Jarraitu   : Boolean                          := True;  
      Egoera     : Errore_Tratamendua.Egoerak       := Parametro_Zerrendaren_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
         Ident_Zerrenda(Iz_Izenak);
         Analizatzaile_Lexikoa.Match(Motak.T_Bi_Puntu);
         Par_Mota(Pm_Mota,Pm_Izena);
         Mota(Mota_Mota, Mota_Izena);
         Idatzi(Iz_Izenak, Pm_Izena & "_" & Mota_Izena ); -- ald_int, bal_real, ...
         Parametro_Zerrendaren_Bestea;
      end if;
   exception
      when Lekurik_Ez =>
         raise Lekurik_Ez;
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Parametro_Zerrendaren_Bestea;


   procedure Sententzia_Zerrenda (
         Sz_Hdo  : in     Boolean;                             
         Sz_Exit,                                              
         Sz_Next :    out Erreferentzia_Listak.Lista_Ordenatua ) is 
      S_Hdo,  
      Sz1_Hdo  : Boolean;  
      Sz1_Exit,  
      S_Next,  
      S_Exit,  
      Sz1_Next : Erreferentzia_Listak.Lista_Ordenatua;  
      M1_Erref,  
      M2_Erref : Erreferentziak.Erreferentzia;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Sententzia_Zerrenda;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         S_Hdo := Sz_Hdo;
         Sz1_Hdo := Sz_Hdo;
         Sententzia(S_Hdo,S_Next,S_Exit);
         M(M1_Erref);
         Sententzia_Zerrenda(Sz1_Hdo,Sz1_Exit,Sz1_Next);
         M(M2_Erref);
         Erreferentzia_Listak.Bildu(S_Exit, Sz1_Exit,Sz_Exit);
         if M1_Erref = M2_Erref then
            Erreferentzia_Listak.Kopiatu(S_Next,Sz_Next);
         else
            Kodea.Agindua_Osatu(S_Next, M1_Erref);
            Erreferentzia_Listak.Kopiatu(Sz1_Next,Sz_Next);
         end if;
      else
         Erreferentzia_Listak.Sortu_Hutsa(Sz_Exit);
         Erreferentzia_Listak.Sortu_Hutsa(Sz_Next);
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Sententzia_Zerrenda;

   procedure Sententzia (
         S_Hdo  : in     Boolean;                             
         S_Next,                                              
         S_Exit :    out Erreferentzia_Listak.Lista_Ordenatua ) is 
      A_Izena,  
      Ab_Izena : Motak.Token_Str;  
      Ab_Mota,  
      A_Mota   : Boolean;  

      Sz1_Hdo,  
      Sz2_Hdo  : Boolean                              := S_Hdo;  
      Sz_Hdo   : Boolean;  
      A_True,  
      A_False,  
      Ab_True,  
      Ab_False : Erreferentzia_Listak.Lista_Ordenatua;  
      M1_Erref,  
      M2_Erref,  
      N_Hur    : Erreferentziak.Erreferentzia;  
      Sz1_Exit,  
      Sz2_Exit,  
      Sz1_Next,  
      Sz2_Next : Erreferentzia_Listak.Lista_Ordenatua;  
      Sz_Exit,  
      Sz_Next,  
      Eb_Exit  : Erreferentzia_Listak.Lista_Ordenatua;  
      Lag_Agin : Aginduak.Agindu;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Sententzia;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Ident then -- aldagaia := ad_bakuna
            Aldagaia(A_Izena);
            Analizatzaile_Lexikoa.Match(Motak.T_Bi_Puntu_Berdin);
            Adierazpen_Bakuna(Ab_Izena,Ab_True,Ab_False,Ab_Mota);

            Egiaztatu_Motak(Ab_Mota,True);-----------------------------A:=adierazpen-bakuna (aritmetikoa soiiik)
            Mezua_Emanda:= False;-------------------------------------------------------------------------------

            Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
            Aginduak.Sortu(A_Izena & " := " & Ab_Izena & ";", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Erreferentzia_Listak.Sortu_Hutsa(S_Next);
            Erreferentzia_Listak.Sortu_Hutsa(S_Exit);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_If then
            Analizatzaile_Lexikoa.Match(Motak.T_If);
            Adierazpena(A_Izena,A_True,A_False,A_Mota);
            Analizatzaile_Lexikoa.Match(Motak.T_Then);
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Giltza);
            M(M1_Erref);
            Sententzia_Zerrenda(Sz1_Hdo,Sz1_Exit,Sz1_Next);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Giltza);
            Analizatzaile_Lexikoa.Match(Motak.T_Else);
            N(N_Hur);
            M(M2_Erref);
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Giltza);
            Sententzia_Zerrenda(Sz2_Hdo,Sz2_Exit,Sz2_Next);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Giltza);
            Kodea.Agindua_Osatu(A_True, M1_Erref);
            Kodea.Agindua_Osatu(A_False, M2_Erref);
            Erreferentzia_Listak.Bildu(Sz1_Next,Sz2_Next, S_Next);
            Erreferentzia_Listak.Erantsi_Bukaeran(S_Next,N_Hur);
            Erreferentzia_Listak.Bildu(Sz1_Exit,Sz2_Exit,S_Exit);

         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Do then
            M(M1_Erref);
            -- begizta baten gaudela esan sententzia zerrendari
            Sz_Hdo := True;
            Analizatzaile_Lexikoa.Match(Motak.T_Do);
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Giltza);
            Sententzia_Zerrenda(Sz_Hdo,Sz_Exit,Sz_Next);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Giltza);
            Analizatzaile_Lexikoa.Match(Motak.T_While);
            Adierazpena(A_Izena,A_True,A_False,A_Mota);
            Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
            Kodea.Agindua_Osatu(A_True,M1_Erref);
            Erreferentzia_Listak.Bildu(Sz_Exit, A_False,S_Next);
            Erreferentzia_Listak.Sortu_Hutsa(S_Exit);

         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Exit then
            Analizatzaile_Lexikoa.Match(Motak.T_Exit);
            Exit_Bestea(Eb_Exit);
            Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
            if S_Hdo then -- begizta baten barruan baldin bagaude
               Erreferentzia_Listak.Kopiatu(Eb_Exit, S_Exit);
               Erreferentzia_Listak.Sortu_Hutsa(S_Next);
            else
               Put_Line("exit-a ez dago begizta baten barruan");
            end if;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Get then
            Analizatzaile_Lexikoa.Match(Motak.T_Get);
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Parent);
            Aldagaia(A_Izena);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Parent);
            Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
            Aginduak.Sortu("read " & A_Izena & ";", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Erreferentzia_Listak.Sortu_Hutsa(S_Exit);
            Erreferentzia_Listak.Sortu_Hutsa(S_Next);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Put_Line then
            Analizatzaile_Lexikoa.Match(Motak.T_Put_Line);
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Parent);
            Adierazpen_Bakuna(Ab_Izena,Ab_True,Ab_False,Ab_Mota);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Parent);
            Analizatzaile_Lexikoa.Match(Motak.T_Puntu_Koma);
            Aginduak.Sortu("write " & Ab_Izena & ";", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Aginduak.Sortu("writeln;", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Erreferentzia_Listak.Sortu_Hutsa(S_Exit);
            Erreferentzia_Listak.Sortu_Hutsa(S_Next);
         end if;
      else
         Erreferentzia_Listak.Sortu_Hutsa(Sz_Exit);
         Erreferentzia_Listak.Sortu_Hutsa(Sz_Next);
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Sententzia;

   procedure M (
         M_Erref :    out Erreferentziak.Erreferentzia ) is 
   begin
      M_Erref := Kodea.Lortu_Erreferentzia;
   end M;

   procedure N (
         N_Hur :    out Erreferentziak.Erreferentzia ) is 
      Lag_Agin : Aginduak.Agindu;  
   begin
      N_Hur := Kodea.Lortu_Erreferentzia;
      Aginduak.Sortu("goto ",Lag_Agin);
      Kodea.Agindua_Gehitu(Lag_Agin);
   end N;

   procedure Exit_Bestea (
         Eb_Exit :    out Erreferentzia_Listak.Lista_Ordenatua ) is 
      A_Izena  : Motak.Token_Str;  
      A_True,  
      A_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      A_Mota   : Boolean;  
      Lag_Agin : Aginduak.Agindu;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Exit_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_If then
            Analizatzaile_Lexikoa.Match(Motak.T_If);
            Adierazpena(A_Izena,A_True,A_False,A_Mota);
            Kodea.Agindua_Osatu(A_False,Kodea.Lortu_Erreferentzia);
            Eb_Exit := A_True;

         else -- exit; baldintzarik gabe
            Erreferentzia_Listak.Sortu_Hutsa(Eb_Exit);
            Erreferentzia_Listak.Erantsi_Bukaeran(Eb_Exit,Kodea.Lortu_Erreferentzia);
            Aginduak.Sortu("goto ", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
         end if;
      else
         Erreferentzia_Listak.Sortu_Hutsa(Eb_Exit);
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Exit_Bestea;

   procedure Aldagaia (
         A_Izena :    out Motak.Token_Str ) is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Aldagaia;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         A_Izena := Analizatzaile_Lexikoa.Stringa(
            Analizatzaile_Lexikoa.Lookahead);
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
      else
         A_Izena := "xxxxx                         ";
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Aldagaia;

   procedure Adierazpena (
         A_Izena :    out Motak.Token_Str;                      
         A_True,                                                
         A_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         A_Mota  :    out Boolean                               ) is 

      Abb_Hizena : Motak.Token_Str;  
      Abb_Hmota  : Boolean;  
      Abb_Htrue,  
      Abb_Hfalse : Erreferentzia_Listak.Lista_Ordenatua;  

      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Adierazpena;  

   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Adierazpen_Bakuna(Abb_Hizena, Abb_Htrue, Abb_Hfalse, Abb_Hmota);
         Adierazpen_Bakuna_Bestea(Abb_Hizena,Abb_Htrue, Abb_Hfalse, Abb_Hmota, A_Izena, A_True, A_False, A_Mota);
      else
         A_Izena := "xxxxx                         ";
         Erreferentzia_Listak.Sortu_Hutsa(A_True);
         Erreferentzia_Listak.Sortu_Hutsa(A_False);
         A_Mota := True;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Adierazpena;

   procedure Baldintza (
         B_Erl :    out Motak.Token_Str ) is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Baldintza;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Berdin then
            B_Erl := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(T_Berdin);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Txiki then
            B_Erl := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(T_Txiki);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Handi_Berdin then
            B_Erl := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(T_Handi_Berdin);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Txiki_Berdin then
            B_Erl := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(T_Txiki_Berdin);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Handi then
            B_Erl := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(T_Handi);
         end if;
      else
         B_Erl := "xxxxx                         ";
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Baldintza;


   procedure Adierazpen_Bakuna_Bestea (
         Abb_Hizena : in     Motak.Token_Str;                      
         Abb_Htrue,                                                
         Abb_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Abb_Hmota  : in     Boolean;                              
         Abb_Izena  :    out Motak.Token_Str;                      
         Abb_True,                                                 
         Abb_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Abb_Mota   :    out Boolean                               ) is 
      Ab_True,  
      Ab_False,  
      Lag_True,  
      Lag_False,  
      Lag1_True,  
      Lag1_False : Erreferentzia_Listak.Lista_Ordenatua;  
      Ab_Izena,  
      B_Erl      : Motak.Token_Str;  
      Ab_Mota    : Boolean;  

      Lag_Agin : Aginduak.Agindu;  
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Adierazpen_Bakuna_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Baldintza(B_Erl);
         Adierazpen_Bakuna(Ab_Izena,Ab_True,Ab_False,Ab_Mota);
         Egiaztatu_Motak(Abb_Hmota,Ab_Mota);-------------------------------------------------------------------------
         Abb_Mota:= Abb_Hmota;--------------------------------------------------------------------------------------- 
         Erreferentzia_Listak.Sortu_Hutsa(Lag_True);
         Erreferentzia_Listak.Erantsi_Bukaeran(Lag_True,Kodea.Lortu_Erreferentzia);
         Erreferentzia_Listak.Bildu(Ab_True,Lag_True,Lag1_True);
         Erreferentzia_Listak.Bildu(Lag1_True,Abb_Htrue,Abb_True);
         Aginduak.Sortu("if " & Abb_Hizena & " " & B_Erl & " " & Ab_Izena &
            " goto ", Lag_Agin);
         Kodea.Agindua_Gehitu(Lag_Agin);
         Erreferentzia_Listak.Sortu_Hutsa(Lag_False);
         Erreferentzia_Listak.Erantsi_Bukaeran(Lag_False,Kodea.Lortu_Erreferentzia);
         Erreferentzia_Listak.Bildu(Ab_False,Lag_False,Lag1_False);
         Erreferentzia_Listak.Bildu(Lag1_False,Abb_Hfalse,Abb_False);
         Aginduak.Sortu("goto ",Lag_Agin);
         Kodea.Agindua_Gehitu(Lag_Agin);
         Abb_Mota := False; -- boolearra dela esateko
      else -- hutsa bada
         Abb_Izena := Abb_Hizena;
         Erreferentzia_Listak.Kopiatu(Abb_Htrue,Abb_True);
         Erreferentzia_Listak.Kopiatu(Abb_Hfalse,Abb_False);
         Abb_Mota := Abb_Hmota;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Adierazpen_Bakuna_Bestea;

   procedure Adierazpen_Bakuna (
         Adb_Izena :    out Motak.Token_Str;                      
         Adb_True,                                                
         Adb_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Adb_Mota  :    out Boolean                               ) is 
      G_Izena  : Motak.Token_Str;  
      G_Mota   : Boolean;  
      G_True,  
      G_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Adierazpen_Bakuna;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Gaia(G_Izena, G_True, G_False, G_Mota);
         Adierazpena_Bestea(Adb_Izena,Adb_True,Adb_False,Adb_Mota,G_Izena,
            G_True,G_False,G_Mota);
         Mezua_Emanda:= False;
      else
         Adb_Izena:="                         _xxxx";
         Erreferentzia_Listak.Sortu_Hutsa(Adb_True);
         Erreferentzia_Listak.Sortu_Hutsa(Adb_False);
         Adb_Mota := True;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Adierazpen_Bakuna;

   procedure Adierazpena_Bestea (
         Ab_Izena  :    out Motak.Token_Str;                      
         Ab_True,                                                 
         Ab_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Ab_Mota   :    out Boolean;                              
         Ab_Hizena : in     Motak.Token_Str;                      
         Ab_Htrue,                                                
         Ab_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Ab_Hmota  : in     Boolean                               ) is 

      G_Mota,  
      Ab1_Hmota,  
      Ab1_Mota   : Boolean;  
      G_Izena,  
      Ab1_Hizena,  

      Ab1_Izena  : Motak.Token_Str;  
      G_True,  
      G_False,  
      Ab1_Htrue,  
      Ab1_Hfalse,  
      Ab1_True,  
      Ab1_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      Lag_Agin   : Aginduak.Agindu;  
      M_Erref    : Erreferentziak.Erreferentzia;  
      Jarraitu   : Boolean                              := True;  
      Egoera     : Errore_Tratamendua.Egoerak           := Adierazpena_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Gehi then
            Analizatzaile_Lexikoa.Match(Motak.T_Gehi);
            Gaia(G_Izena, G_True,G_False,G_Mota);

            Egiaztatu_Motak(Ab_Hmota,G_Mota);-----------biak mota berekoak dira-----------------------------------
            Egiaztatu_Motak(G_Mota,True);----------------Aritmetikoa dela ziurtatzeko-----------------------------              

            Ab1_Hizena := Kodea.Ident_Berria;
            Erreferentzia_Listak.Sortu_Hutsa(Ab1_Htrue);
            Erreferentzia_Listak.Sortu_Hutsa(Ab1_Hfalse);
            Ab1_Hmota := G_Mota;
            Aginduak.Sortu(Ab1_Hizena & " := " & Ab_Hizena & " + " & G_Izena &
               ";", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Adierazpena_Bestea(Ab_Izena,Ab_True,Ab_False,Ab_Mota,Ab1_Hizena,
               Ab1_Htrue,Ab1_Hfalse,Ab1_Hmota);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Ken then
            Analizatzaile_Lexikoa.Match(Motak.T_Ken);
            Gaia(G_Izena, G_True,G_False,G_Mota);

            Egiaztatu_Motak(Ab_Hmota,G_Mota);-----------biak mota berekoak dira-----------------------------------
            Egiaztatu_Motak(G_Mota,True);----------------Aritmetikoa dela ziurtatzeko-----------------------------  

            Ab1_Hizena := Kodea.Ident_Berria;
            Erreferentzia_Listak.Sortu_Hutsa(Ab1_Htrue);
            Erreferentzia_Listak.Sortu_Hutsa(Ab1_Hfalse);
            Ab1_Hmota := G_Mota;
            Aginduak.Sortu(Ab1_Hizena & " := " & Ab_Hizena & " - " & G_Izena &
               ";", Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Adierazpena_Bestea(Ab_Izena,Ab_True,Ab_False,Ab_Mota,Ab1_Hizena,
               Ab1_Htrue,Ab1_Hfalse,Ab1_Hmota);
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Or then
            Analizatzaile_Lexikoa.Match(Motak.T_Or);
            M(M_Erref);
            Gaia(G_Izena, G_True,G_False,G_Mota);

            Egiaztatu_Motak(Ab_Hmota,G_Mota);-----------biak mota berekoak dira-----------------------------------
            Egiaztatu_Motak(G_Mota,True);----------------boolearra dela ziurtatzeko-----------------------------  

            Erreferentzia_Listak.Kopiatu(Ab_Htrue,Ab1_Htrue);
            Erreferentzia_Listak.Sortu_Hutsa(Ab1_Hfalse);
            Ab1_Hizena := G_Izena;
            Ab1_Hmota := G_Mota;
            Adierazpena_Bestea(Ab1_Izena,Ab1_True,Ab1_False,Ab1_Mota,
               Ab1_Hizena,Ab1_Htrue,Ab1_Hfalse, Ab1_Hmota);
            Erreferentzia_Listak.Bildu(G_True,Ab1_True,Ab_True);
            Kodea.Agindua_Osatu(Ab_Hfalse,M_Erref);
            Erreferentzia_Listak.Bildu(G_False,Ab1_False,Ab_False);
            Ab_Izena := Ab1_Izena;
            Ab_Mota := False;
         end if;
      else -- hitz hutsa
         Ab_Izena := Ab_Hizena;
         Ab_True:=Ab_Htrue;
         Ab_False:=Ab_Hfalse;
         Ab_Mota := Ab_Hmota;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Adierazpena_Bestea;

   procedure Gaia (
         G_Izena :    out Motak.Token_Str;                      
         G_True,                                                
         G_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         G_Mota  :    out Boolean                               ) is 
      F_Izena  : Motak.Token_Str;  
      F_Mota   : Boolean;  
      F_True,  
      F_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Gaia;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Faktore(F_Izena,F_True,F_False,F_Mota);
         Gaia_Bestea(G_Izena,G_True,G_False,G_Mota,F_Izena,F_True,F_False,
            F_Mota);
      else
         G_Izena:="xxxxx                         ";
         Erreferentzia_Listak.Sortu_Hutsa(G_True);
         Erreferentzia_Listak.Sortu_Hutsa(G_False);
         G_Mota := True;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Gaia;

   procedure Gaia_Bestea (
         Gb_Izena  :    out Motak.Token_Str;                      
         Gb_True,                                                 
         Gb_False  :    out Erreferentzia_Listak.Lista_Ordenatua; 
         Gb_Mota   :    out Boolean;                              
         Gb_Hizena : in     Motak.Token_Str;                      
         Gb_Htrue,                                                
         Gb_Hfalse : in     Erreferentzia_Listak.Lista_Ordenatua; 
         Gb_Hmota  : in     Boolean                               ) is 

      F_Mota,  
      Gb1_Hmota,  
      Gb1_Mota   : Boolean;  
      F_Izena,  
      Gb1_Hizena,  

      Gb1_Izena  : Motak.Token_Str;  
      F_True,  
      F_False,  
      Gb1_Htrue,  
      Gb1_Hfalse,  
      Gb1_True,  
      Gb1_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      Lag_Agin   : Aginduak.Agindu;  
      M_Erref    : Erreferentziak.Erreferentzia;  
      Jarraitu   : Boolean                              := True;  
      Egoera     : Errore_Tratamendua.Egoerak           := Gaia_Bestea;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Bider then
            Analizatzaile_Lexikoa.Match(Motak.T_Bider);
            Faktore(F_Izena, F_True,F_False,F_Mota);

            Egiaztatu_Motak(Gb_Hmota,F_Mota);--------------------faktorea eta gaia mota berekoak direla begiratu
            Egiaztatu_Motak(Gb_Hmota,True);----------------------eragiketa aritmetikoa dela 

            Gb1_Hizena := Kodea.Ident_Berria;
            Erreferentzia_Listak.Sortu_Hutsa(Gb1_Htrue);
            Erreferentzia_Listak.Sortu_Hutsa(Gb1_Hfalse);
            Gb1_Hmota :=F_Mota;

            Aginduak.Sortu(Gb1_Hizena & " := " & Gb_Hizena & " * " & F_Izena &
               ";",Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Gaia_Bestea(Gb_Izena,Gb_True,Gb_False,Gb_Mota,Gb1_Hizena,
               Gb1_Htrue,Gb1_Hfalse,Gb1_Hmota);

         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Zati then
            Analizatzaile_Lexikoa.Match(Motak.T_Zati);
            Faktore(F_Izena, F_True,F_False,F_Mota);

            Egiaztatu_Motak(Gb_Hmota,F_Mota);--------------------faktorea eta gaia mota berekoak direla begiratu
            Egiaztatu_Motak(Gb_Hmota,True);----------------------eragiketa boolearra dela 

            Gb1_Hizena := Kodea.Ident_Berria;
            Erreferentzia_Listak.Sortu_Hutsa(Gb1_Htrue);
            Erreferentzia_Listak.Sortu_Hutsa(Gb1_Hfalse);
            Gb1_Hmota := F_Mota;
            Aginduak.Sortu(Gb1_Hizena & " := " & Gb_Hizena & " / " & F_Izena &
               ";",Lag_Agin);
            Kodea.Agindua_Gehitu(Lag_Agin);
            Gaia_Bestea(Gb_Izena,Gb_True,Gb_False,Gb_Mota,Gb1_Hizena,
               Gb1_Htrue,Gb1_Hfalse,Gb1_Hmota);

         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_And then
            Analizatzaile_Lexikoa.Match(Motak.T_And);
            M(M_Erref);
            Faktore(F_Izena, F_True,F_False,F_Mota);

            Egiaztatu_Motak(Gb_Hmota,F_Mota);--------------------faktorea eta gaia mota berekoak direla begiratu
            Egiaztatu_Motak(Gb_Hmota,False);----------------------eragiketa aritmetikoa dela 

            Erreferentzia_Listak.Sortu_Hutsa(Gb1_Htrue);
            Erreferentzia_Listak.Kopiatu(Gb_Hfalse,Gb1_Hfalse);
            Gb1_Hizena := F_Izena;
            Gb1_Hmota := F_Mota;
            Gaia_Bestea(Gb1_Izena,Gb1_True,Gb1_False,Gb1_Mota, Gb1_Hizena,
               Gb1_Htrue,Gb1_Hfalse, Gb1_Hmota);
            Erreferentzia_Listak.Bildu(F_True,Gb1_True,Gb_True);
            Kodea.Agindua_Osatu(Gb_Htrue,M_Erref);
            Erreferentzia_Listak.Bildu(F_False,Gb1_False,Gb_False);
            Gb_Izena := Gb1_Izena;
            Gb_Mota := False;
         end if;
      else -- hitz hutsa
         Gb_Izena := Gb_Hizena;
         Gb_True:=Gb_Htrue;
         Gb_False:=Gb_Hfalse;
         Gb_Mota := Gb_Hmota;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Gaia_Bestea;

   procedure Faktore (
         F_Izena :    out Motak.Token_Str;                      
         F_True,                                                
         F_False :    out Erreferentzia_Listak.Lista_Ordenatua; 
         F_Mota  :    out Boolean                               ) is 
      F1_Mota  : Boolean;  
      F1_Izena,  

      A_Izena : Motak.Token_Str;  

      A_Mota   : Boolean;  
      F1_True,  
      F1_False,  
      A_True,  
      A_False  : Erreferentzia_Listak.Lista_Ordenatua;  
      Jarraitu : Boolean                              := True;  
      Egoera   : Errore_Tratamendua.Egoerak           := Faktore;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Ident then
            F_Izena := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(Motak.T_Ident);
            Erreferentzia_Listak.Sortu_Hutsa(F_True);
            Erreferentzia_Listak.Sortu_Hutsa(F_False);
            F_Mota := True;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Osoko then
            F_Izena := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(Motak.T_Osoko);
            Erreferentzia_Listak.Sortu_Hutsa(F_True);
            Erreferentzia_Listak.Sortu_Hutsa(F_False);
            F_Mota := True;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Erreal then
            F_Izena := Analizatzaile_Lexikoa.Stringa(
               Analizatzaile_Lexikoa.Lookahead);
            Analizatzaile_Lexikoa.Match(Motak.T_Erreal);
            Erreferentzia_Listak.Sortu_Hutsa(F_True);
            Erreferentzia_Listak.Sortu_Hutsa(F_False);
            F_Mota := True;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Not then
            Analizatzaile_Lexikoa.Match(Motak.T_Not);
            Faktore(F1_Izena, F1_True, F1_False, F1_Mota);
            F_Izena := F1_Izena;
            F_True := F1_False;
            F_False := F1_True;
            F_Mota := False;
         elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) =
               Motak.T_Ir_Parent then
            Analizatzaile_Lexikoa.Match(Motak.T_Ir_Parent);
            Adierazpena(A_Izena,A_True,A_False,A_Mota);
            Analizatzaile_Lexikoa.Match(Motak.T_It_Parent);
            F_Izena := A_Izena;
            Erreferentzia_Listak.Kopiatu(A_True,F_True);
            Erreferentzia_Listak.Kopiatu(A_False,F_False);
            F_Mota := A_Mota;
         else
            F_Izena:="                         _xxxx";
            Erreferentzia_Listak.Sortu_Hutsa(F_True);
            Erreferentzia_Listak.Sortu_Hutsa(F_False);
            F_Mota := True;
         end if;
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Faktore;

   procedure Aukerazko_Id is 
      Jarraitu : Boolean                    := True;  
      Egoera   : Errore_Tratamendua.Egoerak := Aukerazko_Id;  
   begin
      Errore_Tratamendua.Errorea_Tratatu (Egoera,Jarraitu);
      if Jarraitu then
         Analizatzaile_Lexikoa.Match(Motak.T_Ident);
      end if;
   exception
      when Errore_Tratamendua.Konpilazioa_Bukatu =>
         raise Errore_Tratamendua.Konpilazioa_Bukatu;
   end Aukerazko_Id;

end Analizatzaile_Sintaktikoa;