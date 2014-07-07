with Motak,Lista_Ordenatuak, Funtzio_Laguntzaileak;

package Token_Str_Listak is new Lista_Ordenatuak (
   Osagai   => Motak.Token_Str,                
   Asignatu => Funtzio_Laguntzaileak.Asignatu, 
   Berdin   => Funtzio_Laguntzaileak.Berdin);