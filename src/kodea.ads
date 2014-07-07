with Aginduak, Erreferentziak, Erreferentzia_Listak, Motak;

package Kodea is

   procedure Hasieratu; 

   procedure Agindua_Gehitu (
         Agindua : Aginduak.Agindu ); 


   procedure Kodea_Idatzi(
         f_izena : String ); 

     

   procedure Agindua_Osatu (
         Erreferentzia : Erreferentzia_Listak.Lista_Ordenatua; 
         Etiketa       : Erreferentziak.Erreferentzia          ); 

   function Lortu_Erreferentzia return Erreferentziak.Erreferentzia; 

   function Ident_Berria return Motak.Token_Str; 

end Kodea;

