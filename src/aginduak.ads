package Aginduak is

   type Agindu is private; --Datu mota abstraktua pribatu egitea
   Lekurik_Ez: exception; 

   procedure Sortu (S: in String; A:out Agindu);
   --Aurrebaldintza: string ez huts bat
   --Postbaldintza: stringak osatzen duen Agindua itzultzen du
   procedure Kopiatu (A: in Agindu; A1:out Agindu);
   --Aurrebaldintza: Agindu ez huts bat
   --Postbaldintza: Emandako Aginduaren kopia bat egiten du
   function Berdin (A1,A2: in Agindu) return Boolean;
   --Aurrebaldintza: Bi Agindu
   --Postbaldintza: Bi Aginduak berdinak badira 'true' itzuliko du, 'false' bestela
   function Balioa (A: in Agindu) return String;
   --Aurrebaldintza: Agindu bat
   --Postbaldintza: Agindu bat osatzen duen stringa itzultzen du
   function Luzera (A: in Agindu) return Natural;
   --Aurrebaldintza: Agindu bat
   --Postbaldintza: Agindu horren luzera itzultzen du
   function "<" (A1, A2: in Agindu) return Boolean;
   --Aurrebaldintza: Bi Agindu
   --Postbaldintza: 'true' itzuliko du A1en balioa, ordena lexikografikoaren arabera, A2renaren
   --                aurretik badago, eta 'false' bestela

private
   type Agindu is access String; --Aginduaren definizioa string baten erakuslea erabiliz
end Aginduak;