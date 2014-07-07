with Motak;

package Funtzio_Laguntzaileak is
   
   -- Token_Str motako objektuen gainean egin daitezkeen funtzioak
   -- Gero Token_str motako objektuak dituzten listen instantziazioan
   -- erabili ahal izateko
   procedure Asignatu(L1: in Motak.Token_Str; L2: out Motak.Token_Str);
   function Berdin (L1,L2: in Motak.Token_Str) return Boolean ;

end Funtzio_Laguntzaileak;