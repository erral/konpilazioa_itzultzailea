with Text_Io;
use  Text_Io;
with Motak;
use Motak;
with Ada.Text_Io,Ada.Integer_Text_Io;
use Ada.Text_Io, Ada.Integer_Text_Io;
package body Analizatzaile_Lexikoa is

   -- Token moten konparazioak, pantailarekatak, ... egiteko enumeration paketearen instantziazioa
   package T is new Enumeration_Io (Motak.Token_M);
   use T;

   -- Automatarentzako konstanteen erazagupena 
   Egoerak           : constant Integer := 34;  
   Ikurrak           : constant Integer := 127;  
   Sinb_Tau          : constant Integer := 21;  
   Hitz_Erreserb_Kop : constant Integer := 18;  

   -- Token okerra adierazteko salbuespena 
   Token_Okerra : exception;  

   -- Lookahead-en gainean aplikatu daitezkeen funtzioak bere atributuak lortzeko
   function Mota (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_M is 
   begin
      return Lok.Token_Mota;
   end Mota;


   function Atributua (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_Str is 
   begin
      return Lok.Token_Atr;
   end Atributua;


   function Stringa (
         Lok : Motak.Lookahead_M ) 
     return Motak.Token_Str is 
   begin
      return Lok.Token_Izena;
   end Stringa;

   -- Automatarentzako motak 
   subtype Egoera_Mota is Integer range -1..1;
   -- -1: egoera ez da existitzen
   --  0: hasiera egoera da
   --  1: egoera arrunt bat da

   type Egoera_Bektorea_M is array (0 .. Egoerak) of Egoera_Mota; 

   subtype Ikur_Mota is Integer range -1..Sinb_Tau;
   -- -1ekin ikurra ez da existitzen
   -- Beste kasu batean, automataren trantsizio taulan dagokion
   -- zutabearen posizioa da

   type Ikurren_Bektorea_M is array (0 .. Ikurrak) of Ikur_Mota; 

   subtype Taula_M is Integer range -1..Egoerak;
   -- -1: trantsizioa ez da existitzen
   -- Bestela, zein egoeratara iristen garen adierazten digu

   type Trantsizio_Taula_M is array (0 .. Egoerak, 0 .. Sinb_Tau) of Taula_M; 

   -- Token berezien erazagupena 
   subtype Bukaerako_Token_M is Motak.Token_M range T_Bi_Puntu..T_Berezi;

   type Bukaerako_Tokenen_Bektore_M is array (0 .. Egoerak) of Bukaerako_Token_M; 

   type Hitz_Erreserbatuen_Bektore_M is array (1 .. Hitz_Erreserb_Kop) of Motak.Token_Str; 

   ------------------------------------------------------------------------------------------------------
   -- BUKAERAKO EGOERAK: 1(:),2(:=),3(;),4(,)5((),6()),7(=),8(>),9(>=),10(<),11(<=)12(+),13(-),15(*),
   --                    16(/),17(IDENTIFIKADOREAK),19(OSOKOAK [0-9]+ ), 22(ERREALAK ([0-9]+ \. [0-9]+),
   --                    26(ERREALAK ([0-9]+ \. [0-9]+ ((E/e) (\+|\-)? [0-9]+)?) )
   --                    ,28(SPACE),29(FIN FICH),30({), 31(}),32({* xxx *}),
   ------------------------------------------------------------------------------------------------------

   -- Automataren erazagupena
   Egoera_Bektorea : constant Egoera_Bektorea_M := (
      0 | 14 | 18 | 20 | 21 | 23 .. 25 | 27 | 33 | 34 => 1,   -- Ez bukaerako egoerak     
      1 .. 13 | 15 .. 17 | 19 | 22 | 26| 28 .. 32  => - 1);   -- Bukaerako egoerak

   Ikurren_Bektorea : constant Ikurren_Bektorea_M := (
      9 | 32 => 0, --space, tab
      40 => 1,   --(
      41 => 2,   --)
      42 => 3,   --*
      43 => 4,   --+
      45 => 5,   -- -
      47 => 6,   --/
      48 .. 57 => 7, --0,1,2,3,4,5,6,7,8,9
      58 => 8,   --:
      59 => 9,   --;
      60 => 10,  --<
      61 => 11,  --=
      62 => 12,  -->
      95 => 13,  --_
      46 => 14,  --.
      44 => 15,  --,
      65 .. 68 | 70 .. 90 | 97 .. 122 => 16, -- A-tik Z-ra E ezik
      69 => 17,  --E
      63 => 18,  --?
      123 => 19, --{
      125 => 20, --}
      0 .. 8 | 10 .. 31 | 33 .. 39 | 64 | 91 .. 94 | 96 | 124 | 126 .. 127 => - 1);

   Trantsizio_Taula : constant Trantsizio_Taula_M := (
      0 => ( 8 => 1, --: 
             9 => 3, --; 
            15 => 4, --,   
             1 => 5, --(   
             2 => 6, --)   
            11 => 7, --=   
            12 => 8, -->   
            10 => 10, --<  
             4 => 12, --+  
             5 => 13, -- - 
             3 => 15, --*  
             6 => 16, --/  
            16 => 17, --A-Z
            17 => 17, --E
             7 => 19, --1-9
            21 => 19, --0
      ------------------------------------      
             0 => 28, --space,tab
            18 => 29, --?
            13 | 14 => - 1,
            19 => 30, --{
            20 => 31),--} 
     --------------------------------------
      1 => (11 => 2, --:=     
             0 .. 10 | 12 .. 21 => - 1),
      8 => (11 => 9, -->=     
             0 .. 10 | 12 .. 21 => - 1),
      10 => (11 => 11, --<=   
              0 .. 10 | 12 .. 21 => - 1),    

     ---------------------------------------------------------
      17 => (16 => 17, --AE  --17 >> [a-z A-Z] ((_)? [a-z A-Z 0-9])* IDENTIFIKADOREAK
             17 => 17, --AB
              7 => 17, --Ai
             21 => 17, --Ai
             13 => 18, --A_
             0 .. 6 | 8 .. 12 | 14 | 15 | 18 .. 20 => - 1),
      18 => (16 => 17, -- X_X
             17 => 17, -- X_E
              7 => 17, -- X_9
             21 => 17,
              0 .. 6 | 8 .. 15 | 18 ..20 => - 1),
     ---------------------------------------------------------
      19 => ( 7 => 19, --ij       --19 >> OSOKOAK ([0-9]+)
             21 => 19, --i0
             14 => 21, --i. 
             0 .. 6 | 8 .. 13 | 15 .. 20 => - 1),        
      21 => ( 7 => 22, --i.j
             21 => 22,
              0 .. 6 | 8 .. 20 => - 1),
      22 => (7 => 22,             --22 >> ERREALAK [0..9]+ \. [0..9]+
            21 => 22,
            17 => 24,
            0 .. 6 | 8 .. 16 | 18 .. 20 => - 1),       
      24 => ( 4 => 25, --i.jE+
              5 => 25, --i.jE-
              7 => 26, --i.jEk
             21 => 26, --1.jE0
              0 .. 3 | 6 | 8 .. 20 => - 1),
      25 => ( 7 => 26, -- i.jEP  
             21 => 26, -- i.jE0       
              0 .. 6 | 8 .. 20 => - 1),
      26 => ( 7 => 26,            --26 >> ERREALAK [0-9]+ \. [0-9]+ ((E/e (\+|\-)? [0-9]+)? 
             21 => 26,
              0 .. 6 | 8 .. 20 => - 1),

     ------------------------------------------------------------     

      28 => ( 0 => 28, --space space
             18 => 29, --space ? (?=Fitx_Buk)
              1 .. 17 | 19 .. 21=> - 1),
      --------------------------------------------------------------
      30 => ( 3 => 34, --{*                    
              0 .. 2 | 4 .. 21 => - 1),
      34 => ( 3 => 33, --{*X*
              0 .. 2 | 4 .. 21 => 34),
      33 => ( 3 => 33,
             20 => 32, --{*X*}
              0 .. 2 | 4 .. 19|21 => 34),
      --------------------------------------------------------------
      -- 32 >> {* xxxxxxxx *}
      --------------------------------------------------------------   
      -- BUKAERAKO EGOERAK: 1(:),2(:=),3(;),4(,)5((),6()),7(=),8(>),9(>=),10(<),11(<=)12(+),13(-),15(*),
      --                    16(/),17(IDENTIFIKADOREAK),19(OSOKOAK [0-9]+ ), 22(ERREALAK ([0-9]+ \. [0-9]+),
      --                    26(ERREALAK ([0-9]+ \. [0-9]+ ((E/e) (\+|\-)? [0-9]+)?) )
      --                    ,28(SPACE),29(FIN FICH),32({* xxx *}),
      -- TARTEKO EGOERAK: 0,1,8,10,12,13,17,18,19,21,22,24,25,26,28,30,33,34.37
      
      2 .. 7 | 9 | 11 .. 13 | 14 .. 16 | 20 | 23 | 27 | 29 | 31 | 32 => (0 .. 21 => - 1)); 
     

     Bukaera_Tokenen_Bektorea : constant Bukaerako_Tokenen_Bektore_M := (
      1 => T_Bi_Puntu,
      2 => T_Bi_Puntu_Berdin,
      3 => T_Puntu_Koma,
      4 => T_Koma,
      5 => T_Ir_Parent,
      6 => T_it_Parent,
      7 => T_berdin,
      8 => T_handi,
      9 => T_handi_berdin,
      10 => T_txiki,
      11 => T_txiki_berdin,
      12 => T_gehi,
      13 => T_ken,
      15 => T_bider,
      16 => T_zati,
      17 => T_Ident,
      19 => T_osoko,   
      22 => T_erreal,
      26 => T_erreal,    
      28 => T_zuri,
      29 => T_fitx_buk,
      30 => T_ir_giltza,
      31 => T_it_giltza,
      32 => T_iruzkin,
      0|14|18|20|21|23..25|27|33..34 => T_berezi);


   Hitz_Erreserbatuen_Bektorea : constant Hitz_Erreserbatuen_Bektore_M := (
      1 =>  "PROGRAM                       ",
      2 =>  "IS                            ",
      3 =>  "PROCEDURE                     ",
      4 =>  "INTEGER                       ",
      5 =>  "FLOAT                         ",
      6 =>  "IN                            ",
      7 =>  "OUT                           ",
      8 =>  "IF                            ",
      9 =>  "THEN                          ",
      10 => "ELSE                          ",
      11 => "DO                            ",
      12 => "WHILE                         ",
      13 => "EXIT                          ",
      14 => "GET                           ",
      15 => "PUT_LINE                      ",
      16 => "AND                           ",
      17 => "OR                            ",
      18 => "NOT                           ");


   -------------------------------------------------------------------------------
   ---------------- Automataren gaineko eragiketak--------------------------------
   -------------------------------------------------------------------------------
   function Hasierako_Egoera return Integer is 
      -- Automataren hasierako egoera zen den itzultzen du. 
      -- Egoera hori 0 konstantearekin identifikatzen da      
   begin
      return 0;
   end Hasierako_Egoera;

   -------------------------------------------------------------------------------
   function Trantsizioa_Dago (
         Egoera : Integer;  
         Ikurra : Character ) 
     return Boolean is 
      -- AURRE  : Uneko egoera eta ikur bat hartzen ditu
      -- POST   : Egoera horretan egokin, ikur horrekin trantsiziorik dagoen ala ez itzultzen du
      -- EKINTZA: Ikurra automatan dagoen ala ez begiratzen du, ez badago FALSE itzuliz.
      --          Baldin badago trantsizioarekin heltzen garen egoera existitzen denentz 
      --          egiaztatu eta TRUE edo FALSE itzultzen du.

      Posizioa : Integer := Character'Pos (Ikurra);  
   begin
      if Posizioa>127 then
         return False;
      else
         if Ikurren_Bektorea ( Posizioa) < 0 then
            return False;
         else
            return not ( Trantsizio_Taula ( Egoera, Ikurren_Bektorea ( Posizioa) ) < 0 ) ;
         end if;
      end if;
   end Trantsizioa_Dago;


   function Bukaera (
         Egoera : Integer ) 
     return Boolean is 
      -- AURRE  : Automataren egoera
      -- POST   : Bukaerako egoera bada TRUE itzuli, bestela FALSE
   begin
      return ( Egoera_Bektorea ( Egoera) < 0 ) ;
   end Bukaera;

   -------------------------------------------------------------------------------
   function Trantsizioa_Egin (
         Egoera : Integer;  
         Ikurra : Character ) 
     return Integer is 
      -- AURRE  : Uneko egoera eta uneko ikurra
      -- POST   : Egoera eta ikur horrekin trantsizioa egin ostean lortzen den egoera
      -- EKINTZA: Ikurrarekin sinbolo taulan, taulako posizioa lortzen du eta horrekin 
      --          eta egoerarekin, trantsizio taulan begiratu eta ondorengo egoera
      --          itzultzen du. 
      Posizioa : Integer := Character'Pos (Ikurra);  
   begin
      return  ( Trantsizio_Taula ( Egoera, Ikurren_Bektorea ( Posizioa) ) ) ;
   end Trantsizioa_Egin;


   function Hurrengo_Karakterea return Character is 
      Lag : Character;  

      procedure Maiuskulara (
            Kar : in out Character ) is 
      begin
         if Kar in 'a'..'z' then
            Kar:= Character'Val ( Character'Pos ( Kar) - 32 ) ;
         end if;
      end Maiuskulara;

   begin
      if End_Of_File then
         return '?'; -- Kasu Berezia: Fitxategi Bukaera
      elsif End_Of_Line then
         Skip_Line;
         Lerroa:=Lerroa+1;
         return ' '; -- Lerro bukaera badugu hutsune gisa tratatuko dugu
      else
         Get(Lag);
         Maiuskulara(Lag);
         if Lag = '?' then
            return '@';
         end if;
         return Lag ;
      end if;
   end Hurrengo_Karakterea;

   procedure Fitxategia_Itzuli is 
      -- Irakurtzeke dagoena pantailan ateratzen du
      S : String (1 .. 500);  
      I : Integer;  
   begin
      while not End_Of_File loop
         Get_Line(S,I) ;
         Put_Line(S(1..I)) ;
      end loop ;
   end Fitxategia_Itzuli ;

   procedure Next_Token is 
      -- POST   : Sarreran dagoen hurrengo tokena itzultzen du
      -- EKINTZA: Tokenak lortzen eta Lookahead-en uzten joaten da
      --          Prozeduratik irteten da baliozko token bat lortzen duen bakoitzean
      --          hau da, Iruzkinik eta Hutsuneak ez daudenean 
      Token : Motak.Token_M;  

      procedure Erreserbatua (
            Tok : in out Motak.Lookahead_M ) is 
         -- Sarrerako tokena hitz erreserbatua den ala ez begiratzen du, Tokenaren 
         -- atributuetan begiratuz. Hala balitz Motari dagokion eremua aldatzen du.
         -- is bada T_Is, Then bada T_Then, ... jarriz

      begin
         for I in 1..Hitz_Erreserb_Kop loop
            if Tok.Token_Izena = Hitz_Erreserbatuen_Bektorea (I) then
               Tok.Token_Mota:= Motak.Token_M'Val (I+23);
            end if;
         end loop;
      end Erreserbatua;

      procedure Tokena_Lortu (
            Tok :    out Motak.Token_M ) is 

         Egoera : Integer;  
         S_Lok  : T_St_Token := (others => ' ');  
         Pos    : Integer    := 1;  
         -- Automataren gainean egiten ditu eragiketak:
         -- 1. Automata hasieran kokatu
         -- 2. Uneko ikur eta egoerarekin trantsizioa badago 
         --    a. Trantsizioa egin
         --    b. Ikurra gorde
         -- 3. Trantsiziorik ez dagoenean bukaerako egoeran gaudenentz egiaztatu
         --    a. Hala bada: 
         --      i. Lookahead-en gorde
         --     ii. Hitz erreserbatua den egiaztatu
         --    b. Bestela: token okerrari dagokion salbuespena altxatu
      begin
         Egoera:= Hasierako_Egoera;
         while Trantsizioa_Dago ( Egoera, Karakterea) loop
            --Put("trantsizioa dago " & Karakterea & "-rekin ");Put(Estado);Put(" egoerara");
            --new_Line;
            Egoera:= Trantsizioa_Egin( Egoera, Karakterea );
            if Pos <=Id_Luz_Max then
               S_Lok ( Pos ):= Karakterea ;
               Pos:=Pos+1;
            end if;
            Karakterea:= Hurrengo_Karakterea ;
         end loop;
         if Bukaera( Egoera) then
            Lookahead.Token_Izena := S_Lok;
            Lookahead.Token_Mota:= Bukaera_Tokenen_Bektorea ( Egoera);
            Lookahead.Token_Atr := S_Lok;
            Erreserbatua( Lookahead ) ;
            Tok := Lookahead.Token_Mota;
         else
            raise Token_Okerra ;
         end if;
      end Tokena_Lortu;

   begin
      loop
         Tokena_Lortu ( Token ) ;
         if Token = T_Iruzkin then
            Match(T_Iruzkin);
         end if;
         if Token = T_Zuri then
            Tokena_Lortu(Token);
         end if;
         exit when ( ( Token /= T_Iruzkin) and ( Token /= T_Zuri) ) ;
      end loop;

   end Next_Token;


   procedure Match (
         Tok : in     Motak.Token_M ) is 
      -- Sarreran emandako tokena eta lookahead-en dagoean mota berekoak direnentz
      -- egiaztatzen du, berdinak ez badira salbuespena altxatuz eta berdinak badira
      -- hurrengo tokena eskatuz.
   begin
      if Mota (Lookahead) = Tok then
         Next_Token;
      else

--         Put("Akatsa : ");Put(Analizatzaile_Lexikoa.lerroa); Put(". lerroan");New_Line;
--         T.Put (Tok);
--         Put (" erako token bat nahi genuen eta  ");

--         T.Put( Mota(Lookahead)) ;
--         Put (" erakoa etorri da. ");New_Line;
         Next_Token;     

      end if;
   end Match;

end Analizatzaile_Lexikoa;