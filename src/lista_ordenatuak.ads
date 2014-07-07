generic
   type Osagai is limited private; 
   with procedure Asignatu (
         O1 : in     Osagai; 
         O2 :    out Osagai  ); 
   --O1-en edukia O2-n kopiatzen du
   with function Berdin (
         O1,                
         O2 : in     Osagai ) 
     return Boolean; 
   --O1 eta O2 berdinak direnentz itzultzen du
package Lista_Ordenatuak is


   type Lista_Ordenatua is private; 
   Hutsik_Dago, Lekurik_Ez: exception;

   procedure Sortu_Hutsa (
         Z :    out Lista_Ordenatua ); 
   --Aurrebaldintza:
   --Postabaldintza: Lista huts bat sortzen du
   generic
      type Gako is limited private; 
      with function Aurretik (
            G1,              
            G2 : in     Gako ) 
        return Boolean; 
      --Postbaldintza: G1 G2-ren aurretik badago true itzuliko du, False bestela
      with function Esan_Gakoa (
            O : in     Osagai ) 
        return Gako; 
      --Osagai bat emanik, bere gakoa zein den esango digu

      procedure Kokatu (
            L : in out Lista_Ordenatua; 
            Z : in     Osagai           ); 
   --Aurrebaldintza: Zenbaki lista bat eta osagai bat
   --Postbaldintza: Osagaia listan dagokion lekuan sartuko da

   procedure Erantsi_Hasieran (
         L : in out Lista_Ordenatua; 
         O : in     Osagai           ); 
   -- Aurre: lista bat eta osagai bat
   --Post:    osagaia listaren hasieran kokatzen du

   procedure Kopiatu (
         L  : in     Lista_Ordenatua; 
         L1 :    out Lista_Ordenatua  ); 
   --Aurrebaldintza: lista ordenatu bat
   --Postbaldintza: sarrerako listaren kopia bat egiten du
   function Berdin (
         L1,                         
         L2 : in     Lista_Ordenatua ) 
     return Boolean; 
   --Aurrebaldintza: Bi lista ordenatu
   --Postbaldintza: 'true' itzuliko du bi listak berdinak badira,'false' bestela
   function Lehena (
         L : in     Lista_Ordenatua ) 
     return Osagai; 
   --Aurrebaldintza: lista ordenatu EZ huts bat
   --Postbaldintza: Listaren lehenengo osagaia itzultzen du
   function Azkena (
         L : in     Lista_Ordenatua ) 
     return Osagai; 
   --Aurre: lista ordenatu ez huts bat
   --Post: listaren azkenengo osagaia itzultzen du
   procedure Hondarra (
         L : in out Lista_Ordenatua ); 
   --Aurrebaldintza: lista ordenatu bat
   --Postbaldintza: Sarrerako listari lehen elementua kenduta gelditzen 
   --               den lista berria itzultzen du
   function Hutsa_Da (
         L : in     Lista_Ordenatua ) 
     return Boolean; 
   --Aurrebaldintza: lista ordenatu bat
   --Postbaldintza: 'true' sarrerako lista hutsa bada, 'false' bestela
   procedure Lehena_Kendu (
         L : in out Lista_Ordenatua ); 
   --Aurrebaldintza: Lista ordenatu ez huts bat
   --Postbaldintza: Listatik lehen elementua kentzen du
   procedure Erantsi_Bukaeran (
         L : in out Lista_Ordenatua; 
         O : in     Osagai           ); 
   --Aurre: Lista ordenatu bat eta osagai bat
   --Post: osagaia listaren azken elementu gisa sartzen du
   procedure Bildu (
         L1,                          
         L2 : in     Lista_Ordenatua; 
         L3 :    out Lista_Ordenatua  ); 
   --Aurre: Bi lista hartzen ditu
   --Post: Lista biak batuta sortutako lista itzultzen du L3 parametroan
   generic
      type Gako is limited private; 
      with function Aurretik (
            G1,              
            G2 : in     Gako ) 
        return Boolean; 
      --Postbaldintza: G1 G2-ren aurretik badago true itzuliko du, False bestela
      with function Esan_Gakoa (
            O : in     Osagai ) 
        return Gako; 
      --Osagai bat emanik, bere gakoa zein den esango digu
      with function Berdin (
            G1,              
            G2 : in     Gako ) 
        return Boolean; 
      --Bi gakoak berdinak badira true itzultzen du, False bestela

      procedure Bilatu_Elementua_Ordenan (
            L        : in     Lista_Ordenatua; 
            K        : in     Gako;            
            O        :    out Osagai;          
            Aurkitua :    out Boolean          ); 
   --Aurre: Lista eta K gakoa
   --Post: Osagai aldagaian K gakoa duen L-ko osagaia itzultzen du eta Aurkituan True, K gakodun
   --      O osagaia L-n badago, bestela Aurkituan False itzultzen du
   private

   type Nodo; 
   type Lista_Ordenatua is access Nodo; 
   type Nodo is 
      record 
         Elem      : Osagai;  
         Hurrengoa : Lista_Ordenatua;  
      end record; 

end Lista_Ordenatuak;