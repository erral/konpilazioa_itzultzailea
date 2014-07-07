with Analizatzaile_Lexikoa;
with Motak;
use Motak;
with Ada.Text_Io,Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;

package body Errore_Tratamendua is

   procedure Errorea_Tratatu (
         Egoera   : in     Egoerak; 
         Jarraitu :    out Boolean  ) is 

   begin
      case Egoera is
         when Programa =>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Program then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("PROGRAM behar da programaren hasieran izena baino lehen");

               while  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
           

         when Erazagupenak=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren identifikadorea ez da zuzena");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Procedure and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ir_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;

         when Erazagupenak_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Procedure or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Giltza then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren identifikadorea ez da zuzena");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Program and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ir_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Ident_Zerrenda=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren identifikadorea ez da zuzena");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Bi_Puntu and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Ident_Zerrendaren_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Koma then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Bi_Puntu then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren identifikadorea ez da zuzena");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Bi_Puntu and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Mota=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Integer or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Float then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren mota ez da zuzena");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Azpiprogramen_Erazagupena=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Procedure then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Giltza then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Azpiprogramak 'PROCEDURE IZENA IS' egituraren bidez adierazten dira.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ir_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Procedure and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Is        and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Is  or
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Procedure then
                  Put_Line("Azpiprograma analizatzen.");
                  Analizatzaile_Lexikoa.Next_Token;
                  Jarraitu:=True;
               end if;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Azpiprogramaren_Erazagupena=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Procedure then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Azpiprogramak PROCEDURE bidez hasi behar dira");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ir_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Procedure and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;


         when Goiburukoa=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Procedure then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Azpiprogramak PROCEDURE hitzarekin hasi behar dira");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ident and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Argumentuak=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Parent then
               Jarraitu:=True;
            elsif  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Is then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Argumentuak parentesi artean sartu behar dira.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Is and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Parametro_Zerrenda=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Parametroaren identifikadorea ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Par_Mota=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_In or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Out then

               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Parametroaren mota ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Integer and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Float and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Par_Mota_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Out or Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Integer or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Float then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Parametroaren mota ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Integer and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Float and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Parametro_Zerrendaren_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_It_Parent then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Parametroak ';' bidez banandu behar dira.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Sententzia_Zerrenda =>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_If or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Do or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Exit or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Get or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Put_Line then

               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_It_Giltza then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Sententzia ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Sententzia=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_If or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Do or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Exit or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Get or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Put_Line then

               Jarraitu:=True;

            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Sententzia ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Giltza and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ident and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_If and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Do and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Exit and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Get and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Put_Line and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Exit_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_If then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Exit-aren baldintza ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Aldagaia=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aldagaiaren identifikadorea ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Bi_Puntu_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Adierazpena=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Osoko or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Erreal or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Not or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Parent then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpena ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Adierazpen_Bakuna_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki_Berdin then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_It_Parent or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Then then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Baldintzazko adierazpena ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Baldintza=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki_Berdin then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Baldintza zeinua ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ident and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Osoko and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Erreal and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ir_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Not and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Adierazpen_Bakuna=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Osoko or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Erreal or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Parent or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Not then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpena ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Adierazpena_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Gehi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ken or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Or then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Then or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_It_Parent or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki_Berdin then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpena ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Gaia=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Osoko or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Erreal or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Not or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Parent then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpenaren faktorea ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Or and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ken and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Gehi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Gaia_Bestea=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Bider or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Zati or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_And then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Then or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_It_Parent or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Handi_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Txiki_Berdin or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Or or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ken or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Gehi or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpena ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Or and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ken and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Gehi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Faktore=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Osoko or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Erreal or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Not or
                  Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ir_Parent then
               Jarraitu:=True;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Adierazpenaren faktorea ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Then and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_It_Parent and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Handi_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Txiki_Berdin and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Or and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Ken and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Gehi and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_And and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Zati and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Bider and
                     Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Fitx_Buk loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
         when Aukerazko_Id=>
            if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Ident then
               Jarraitu:=True;
            elsif Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Puntu_Koma then
               Jarraitu:=False;
            else
               Errorea_Egon_Da:=True;
               Jarraitu:=False;
               Put("Akatsa : ");
               Put(Analizatzaile_Lexikoa.Lerroa);
               Put(". lerroan");
               New_Line;
               Put_Line("Aukerazko identifikadorea ez da zuzena.");
               while Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) /= Motak.T_Puntu_Koma loop
                  Analizatzaile_Lexikoa.Next_Token;
               end loop;
               if Analizatzaile_Lexikoa.Mota(Analizatzaile_Lexikoa.Lookahead) = Motak.T_Fitx_Buk then
                  raise Konpilazioa_Bukatu;
               end if;
            end if;
      end case;

   end Errorea_Tratatu;


end Errore_Tratamendua;