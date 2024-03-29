; CASE SENSITIVE

;gestione apostrofo
"([A-Z])([A-Z])(['’´])([sS])"  =  "\1 \2es"
;{"([A-Za-z])(['’´])\{er\}"  =  "\1-er"
;{"([A-Za-z])(['’´])\{ers\}"  =  "\1-ers"
;{"([A-Za-z])(['’´])\{je\}"  =  "\1-je"
;{"([A-Za-z])(['’´])\{jes\}"  =  "\1 \fj-HEh-s "

;parole che terminano con "-o's" --> "-oos"
"([A-Za-z])([o])(['’´])([sS])"  =  "\1oos"
;parole che terminano con "-a's" --> "-aas"
"([A-Za-z])([a])(['’´])([sS])"  =  "\1aas"
;parole che terminano con "-u's" --> "-uus"
"([A-Za-z])([u])(['’´])([sS])"  =  "\1uus"
;parole che terminano con "-i's" --> "-ies"
"([A-Za-z])([i])(['’´])([sS])"  =  "\1ies"
;parole che terminano con "-e's" --> "-ees"
"([A-Za-z])([e])(['’´])([sS])"  =  "\1ees"

"([A-Za-z])([A-Za-z])(['’´])([sS])"  =  "\1\2s"

;{"([A-Za-z])(['’´])\{en\}"  =  "\spell=yes \1en"

;Gestione trattino
; sequenza "parola"- en --> non fa la pausa sospensiva sul trattino!!
;{"([A-Za-z])-[ \t](en)"  =  "\1 \2"
"([A-Za-z])-[ \t]\{en\}[ \t]"  =  "\1 en "

; Gestione dell'apice singolo, quando non significa apostrofo!!
"([^a-zA-Z]*)([^a-zA-Z]+)'([ |,|\.|$])"  =  "\1\2 \3"


; Lettura numeri ordinali
"([0-9]?[0-9])\{ste\}"  =  "\{number=ordinalM \1"
"([0-9]?[0-9])\{e\}"  =  "\{number=ordinalM \1"
"([0-9]?[0-9])\{de\}"  =  "\{number=ordinalM \1"
"([0-9]?[0-9][0-9])\{ste\}"  =  "\{number=ordinalM \1"
"([0-9]?[0-9][0-9])\{e\}"  =  "\{number=ordinalM \1"
"([0-9]?[0-9][0-9])\{de\}"  =  "\{number=ordinalM \1"


; Lettura anni con "-"
"([0-9]?[0-9])-*\{jarige\}"  =  "\1jarige"


; Lettura giorni della settimana
;{"(\{ma|di|wo|do|vr|za|zo\})[ \t]([0-9]?[0-9])"  =  "\1. \2"

; Lettura numeri decimali:

; Lettura ora :

"([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])[ \t]*\{uur\}"  =  "\1\2\3"


; Formato 12:00-17:00 uur
"([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])-([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])[ \t]*\{uur\}"  =  "\1\2\3 tot \4\5\6"

; Formato 12-17 uur
"([0-2]?[0-9])-([0-2]?[0-9])[ \t]*\{uur\}"  =  "\1 uur tot \2 uur"

; Formato 12-17:00 uur
"([0-2]?[0-9])-([0-2]?[0-9])(\.|:|,)([0-5]?[0-9])[ \t]*\{uur\}"  =  "\1 uur tot \2 uur"


; Lettura moneta:

;lettura currency del tipo: $22,-
"(\$|£|EUR|¥|DM|FF|US\$|USD)([0-9]?[0-9]?[0-9]),-[ \t]+([A-Za-z]*)"  =  "\1\2 \3"

; Lettura date:

; CASE INSENSITIVE
; Lettura numeri romani:
;Numeri romani non ambigui
"\{([A-Z][a-zA-Z]*)[ \t]+(II|III|IV|VI|VII|VIII|IX|X|XI|XII|XIII|XIV|XV|XVI)\}"  =  "\1 \{number=cardinal \2"}


"([0-9]+)[ \t]*Bq\}"  =  "\1 becquerel"
"([0-9]+)[ \t]*cg\}"  =  "\1 centigram"
"\{cl\}"  =  "centiliter"
"\{cm\}"  =  "centimeter"
"\{cm²\}"  =  "vierkante centimeter"
"([0-9]+)[ \t]*dg\}"  =  "\1 decigram"
"([0-9]+)[ \t]*dl\}"  =  "\1 deciliter"
"([0-9]+)[ \t]*dm\}"  =  "\1 decimeter"
"([0-9]+)[ \t]*GHz\}"  =  "\1 gigahertz"
"([0-9]+)[ \t]*°\}"  =  "\1 graad"
"\{gr.\}"  =  "gram"
"\{grs.\}"  =  "grams"
"([0-9]+)[ \t]*Gy\}"  =  "\1 gray"
"([0-9]+)[ \t]*ha\}"  =  "\1 hectare"
"([0-9]+)[ \t]*hg\}"  =  "\1 hectogram"
"([0-9]+)[ \t]*hl\}"  =  "\1 hectoliter"
"([0-9]+)[ \t]*hm\}"  =  "\1 hectometer"
"([0-9]+)[ \t]*Hz\}"  =  "\1 hertz"

"([0-9]+)[ \t]*kB\}"  =  "\1 kilobyte"
"([0-9]+)[ \t]*kCal\}"  =  "\1 kilocalorie"
"([0-9]+)[ \t]*kg\}"  =  "\1 kilogram"
"([0-9]+)[ \t]*kHz\}"  =  "\1 kilohertz"
"\{km\}"  =  "kilometer"
"([0-9]+)[ \t]*kW\}"  =  "\1 kilowatt"
"([0-9]+)[ \t]*kWh\}"  =  "\1 kilowattuur"
"\{km²\}"  =  "vierkante kilometer"
"\{km/h\}"  =  "kilometer per uur"
"\{km/uur\}"  =  "kilometer per uur"
"\{km/u\}"  =  "kilometer per uur"
"([0-9]+)[ \t]*lm\}"  =  "\1 lumen"
"([0-9]+)[ \t]*lx\}"  =  "\1 lux"
"([0-9]+)[ \t]*MB\}"  =  "\1 megabyte"
"([0-9]+)[ \t]*m/s\}"  =  "\1 meter per seconde"
"\{m²\}"  =  "vierkante meter"
"\{m³\}"  =  "kubieke meter"
"\{MHz\}"  =  "megahertz"
"([0-9]+)[ \t]*mg\}"  =  "\1 milligram"
"([0-9]+)[ \t]*ml\}"  =  "\1 milliliter"
"\{mm\}"  =  "millimeter"
"([0-9]+)[ \t]*m/min\}"  =  "\1 meter per minuut"
"([0-9]+)[ \t]*Pa\}"  =  "\1 pascal"
"([0-9]+)[ \t]*rad/s\}"  =  "\1 radialen per seconde"
"([0-9]+)[ \t]*Sv\}"  =  "\1 sievert"
"([0-9]+)[ \t]*TB\}"  =  "\1 terabyte"
"([0-9]+)[ \t]*THz\}"  =  "\1 terahertz"
"([0-9]+)[ \t]*tpm\}"  =  "\1 toeren per minuut"
"([0-9]+)[ \t]*Wb\}"  =  "\1 weber"
"([0-9]+)[ \t]*µHz\}"  =  "\1 microhertz"
"([0-9]+)[ \t]*µs\}"  =  "\1 microseconde"
"([0-9]+)[ \t]*Ω\}"  =  "\1 ohm"


