with  Text_Io,Analizatzaile_Lexikoa, Analizatzaile_Sintaktikoa, Kodea,
   Motak;
use   Text_Io,Analizatzaile_Lexikoa, Analizatzaile_Sintaktikoa, Kodea,
   Motak;
with Errore_Tratamendua;

procedure Itzultzailea is

   Helburu_F,
   Iturburu_F     : String (1 .. 50);
   F              : File_Type;
   Helburu_F_Luz,
   Iturburu_F_Luz : Integer;

begin
   Put_Line("--------------------------------------------------------------------------------");
   New_Line;
   Put_Line("                          Konpilazioa I  - 2003/2004                            ");
   New_Line;
   Put_Line("                                                                                ");
   New_Line;
   New_Line;
   New_Line;
   Put_Line("       1996an eta 2002an hainbat ikaslek egindako lanetan oinarrituta           ");
   Put_Line("                                                                                ");
   New_Line;
   Put_Line("--------------------------------------------------------------------------------");
   New_Line;
   Put("Sartu iturburu fitxategiaren izena luzapen eta guzti: " ) ;
   Get_Line(Iturburu_F,Iturburu_F_Luz) ;
   Put("Sartu helburu fitxategiaren izena luzapen eta guzti: ");
   Get_Line(Helburu_F,Helburu_F_Luz) ;
   New_Line;
   Put_Line("================================================================================");
   New_Line;
   Open ( F , In_File , Iturburu_F(1..Iturburu_F_Luz) );
   -- Irakurketa guztiak iturburu fitxategitik egin daitezen *by default*
   Set_Input(F);
   -- Lehenengo karakterea irakurri
   Analizatzaile_Lexikoa.Karakterea :=
      Analizatzaile_Lexikoa.Hurrengo_Karakterea ;
   -- Hurrengo tokena eskatu
   Analizatzaile_Lexikoa.Next_Token;
   -- Itzultzailearen lana abiarazi, gramatikako lehen ez-bukaerakoari deituz
   Analizatzaile_Sintaktikoa.Programa;

   if not Errore_Tratamendua.Errorea_Egon_Da then
      -- Fitxategi bukaerako tokena ezkondu
      Analizatzaile_Lexikoa.Match ( T_Fitx_Buk ) ;
      Close     ( F ) ;
      Set_Input ( Standard_Input ) ;
      -- Helburu fitxategian bitarteko kodea idatzi
      Kodea.Kodea_Idatzi ( Helburu_F(1..Helburu_F_Luz) ) ;
      New_Line;
      Put_Line("=================================================================");
      Put_Line("      >>>>>>   Konpilazioa arazorik gabe bukatu da   <<<<<<      ");
      Put_Line("=================================================================");
      New_Line;
   else
      New_Line;
      Put_Line("=================================================================");
      Put_Line(
         "      XXXXXX  Konpilazioan erroreak aurkitu dira   XXXXXX        ");
      New_Line;
      Put_Line("         Ez dugu bitarteko kodearen fitxategirik sortu           ");
      Put_Line("=================================================================");
      New_Line;
   end if;

exception
   when Errore_Tratamendua.Konpilazioa_Bukatu=>
      Put_Line(">>>>>  Kodearen errorea ezin da tratatu  <<<<<<");
      Put_Line("Konpilazioa bukatu da.");

end Itzultzailea;