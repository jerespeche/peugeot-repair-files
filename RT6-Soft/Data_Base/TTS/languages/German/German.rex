;Case Sensitive
; Lettura numeri ordinali*/
"(^|[^0-9\.,;:])([1-9][0-9]*)(\.)[ \t](.*)[ \t]([1-9][0-9]*)(\.)[ \t]" = "\1 \{number=ordinalM \2 \4 \{number=ordinalM \5 "
"(^|[^0-9\.,;:])([1-9][0-9]*)(\.)[ \t]+" = "\1 \{number=ordinalM \2 "


; Lettura numeri del tipo: (nnn nnn), (nn nnn), (n nnn) oppure (nnn nnn nnn),(nn nnn nnn),(n nnn nnn), migliaia 
"([^0-9]*)([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"
"([^0-9]*)([0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"
"([^0-9]*)([0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"
; milioni
"([^0-9]*)([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
"([^0-9]*)([0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
"([^0-9]*)([0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
; miliardi
"([^0-9]*)([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
"([^0-9]*)([0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
"([^0-9]*)([0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])[ ]([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4\5"
    ; Lettura numeri del tipo: (nnn'nnn), (nn'nnn), (n'nnn). Migliaia
"([^0-9]*)([0-9][0-9][0-9])[']([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"
"([^0-9]*)([0-9][0-9])[']([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"
"([^0-9]*)([0-9])[']([0-9][0-9][0-9])([^0-9]*)" = "\1\{number=cardinal \2\3\4"

"\{(Ludwig|Alexander|Karl|George|Edward|Wilhelm|Friedrich)[ \t]*([IXV]+)\}" = "\1 der \{number=ordinalM \2"
"\{(Elizabeth|Marie|Mary|Maria|Therese)[ \t]*([IXV]+)\}" = "\1 die \{number=ordinalF \2"

;False insensitive
;Lettura moneta
"[0]?[0](,|\.)([0])([1])[ \t]*\{DM\}" = "\3 pfennig "
"[0]?[0](,|\.)([0])([2-9])[ \t]*\{DM\}" = "\3 pfennige "
"[0]?[0](,|\.)([1-9][0-9])[ \t]*\{DM\}" = "\2 pfennige "
"[0]?[1](,|\.)[0][0][ \t]*\{DM\}" = "eine mark "
"[0]?[1](,|\.)[0]([1-9])[ \t]*\{DM\}" = "eine mark \2 "
"[0]?[1](,|\.)([1-9][0-9])[ \t]*\{DM\}" = "eine mark \2 "
"[0]?([2-9])(,|\.)[0][0][ \t]*\{DM\}" = "\1 mark "
"[0]?([2-9])(,|\.)[0]([1-9])[ \t]*\{DM\}" = "\1 mark \3 "
"[0]?([2-9])(,|\.)([1-9][0-9])[ \t]*\{DM\}" = "\1 mark \3 "
"([1-9][0-9]+)(,|\.)[0][0][ \t]*\{DM\}" = "\1 mark "
"([1-9][0-9]+)(,|\.)[0]([1-9])[ \t]*\{DM\}" = "\1 mark \3 "
"([1-9][0-9]+)(,|\.)([1-9][0-9])[ \t]*\{DM\}" = "\1 mark \3 "

;Convertite
; Lettura ora
; "([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])[ \t]*\{(Uhr|uhr|UHR)\}" = "\1\2\3"
"([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])[ \t]*(Uhr|uhr|UHR)([^A-Za-z0-9]|$)" = "\1\2\3"

; Lettura date
;"([0-3]?[0-9])\.[ \t]*(Januar|JANUAR|januar|Februar|FEBRUAR|februar|März|MÄRZ|märz|April|APRIL|april|Mai|MAI|mai|Juni|JUNI|juni|Juli|JULI|juli|August|AUGUST|august|September|SEPTEMBER|september|Oktober|OKTOBER|oktober|November|NOVEMBER|november|Dezember|DEZEMBER|dezember|Jahrestag|JAHRESTAG|jahrestag|Jahrhundert|JAHRHUNDERT|jahrhundert|Quartal|QUARTAL|quartal)" = " \{number=ordinalM \1 \2"
; Lettura numeri romani
"\{([ixvIXV]+)[ \t]+(Januar|JANUAR|januar|Februar|FEBRUAR|februar|März|MÄRZ|märz|April|APRIL|april|Mai|MAI|mai|Juni|JUNI|juni|Juli|JULI|juli|August|AUGUST|august|September|SEPTEMBER|september|Oktober|OKTOBER|oktober|November|NOVEMBER|november|Dezember|DEZEMBER|dezember|Jahrhundert|JAHRHUNDERT|jahrhundert)" = " \{number=ordinalM \1 \2"
; Espansione del suffisso "str" seguito da punto in "straße"
"(str|STR|Str)\." = " straße"
; Lettura corretta di proporzioni (es. maßstab 1:10)
"(maßstab|Maßstab|MAßSTAB|massstab|MASSSTAB|Massstab)[ \t][ \t]?[ \t]?(1)[ \t]?(:)([0-9]+)" = "\1 \2 zu \4"
; Gestione trattino. Sequenza "parola"- und --> non fa la pausa sospensiva sul trattino!!
"([A-Za-z])-[ \t]\{(und|UND|Und)\}[ \t]" = "\1 und "
; Gestione trattino. Sequenza "numero"-"numero"--> espande "bis"
"([0-9][0-9]*)-([0-9][0-9]*)[ \t]+" = "\1 bis \2 "
