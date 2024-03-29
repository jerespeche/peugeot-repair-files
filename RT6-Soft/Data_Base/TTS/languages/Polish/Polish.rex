﻿"\{([a-zA-ZáąäéęëíóöúüýćłńśýźżÁĄÄÉĘËÍÓÖÚÜÝĆŁŃŚŹŻ]*)[ \t]+(II|III|IV|VI|VII|VIII|IX)\}"  =  "\1 \{number=ordinalM \2"
"\{([a-zA-ZáąäéęëíóöúüýćłńśýźżÁĄÄÉĘËÍÓÖÚÜÝĆŁŃŚŹŻ]*)[ \t]+(XX|XI|XII|XIII|XIV|XV|XVI|XVII|XVIII|XIX|XXI|XXII|XXIII|XXIV|XXV|XXVI|XXVII|XXVIII|XXIX)\}"  =  "\1 \{number=ordinalM \2"

"\{([A-ZáąäéęëíóöúüýćłńśýźżÁĄÄÉĘËÍÓÖÚÜÝĆŁŃŚŹŻ][a-zA-ZáąäéęëíóöúüýćłńśýźżÁĄÄÉĘËÍÓÖÚÜÝĆŁŃŚŹŻ][a-zA-ZáąäéęëíóöúüýćłńśýźżÁĄÄÉĘËÍÓÖÚÜÝĆŁŃŚŹŻ]+)[ \t]+(I|X|V)\}"  =  "\1 \{number=ordinalM \2"


;"(^|[^0-9\,\.])0[ \t]*A\}" = "\10 ampere"
;"(^|[^0-9\,\.])1[ \t]*A\}" = "\11 amper"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*A\}" = "\1\2\3 ampery"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*A\}" = "\1\2\3 ampery"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*A\}" = "\1\2\3 amperów"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*A\}" = "\1\2\3\4\5 ampere"

"(^|[^0-9\,\.])0[ \t]*cl\}" = "\10 centylitra"
"(^|[^0-9\,\.])1[ \t]*cl\}" = "\11 centylitr"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*cl\}" = "\1\2\3 centylitry"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*cl\}" = "\1\2\3 centylitry"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*cl\}" = "\1\2\3 centylitrów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*cl\}" = "\1\2\3\4\5 centylitra"

"(^|[^0-9\,\.])0[ \t]*cm\}" = "\10 centymetra"
"(^|[^0-9\,\.])1[ \t]*cm\}" = "\11 centymetr"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*cm\}" = "\1\2\3 centymetry"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*cm\}" = "\1\2\3 centymetry"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*cm\}" = "\1\2\3 centymetrów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*cm\}" = "\1\2\3\4\5 centymetra"

"(^|[^0-9\,\.])0[ \t]*dg\}" = "\10 decygrama"
"(^|[^0-9\,\.])1[ \t]*dg\}" = "\11 decygram"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*dg\}" = "\1\2\3 decygramy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*dg\}" = "\1\2\3 decygramy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*dg\}" = "\1\2\3 decygramów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*dg\}" = "\1\2\3\4\5 decygrama"

"(^|[^0-9\,\.])0[ \t]*GHz\}" = "\10 gigaherca"
"(^|[^0-9\,\.])1[ \t]*GHz\}" = "\11 gigagaherc"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*GHz\}" = "\1\2\3 gigaherce"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*GHz\}" = "\1\2\3 gigaherce"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*GHz\}" = "\1\2\3 gigaherców"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*GHz\}" = "\1\2\3\4\5 gigaherca"

"(^|[^0-9\,\.])0[ \t]*godz\}" = "\10 godzin"
"(^|[^0-9\,\.])1[ \t]*godz\}" = "\11 godzina"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*godz\}" = "\1\2\3 godziny"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*godz\}" = "\1\2\3 godziny"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*godz\}" = "\1\2\3 godzin"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*godz\}" = "\1\2\3\4\5 godziny"

;"(^|[^0-9\,\.])0[ \t]*g\}" = "\10 grama"
;"(^|[^0-9\,\.])1[ \t]*g\}" = "\11 gram"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*g\}" = "\1\2\3 gramy"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*g\}" = "\1\2\3 gramy"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*g\}" = "\1\2\3 gram"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*g\}" = "\1\2\3\4\5 grama"

"(^|[^0-9\,\.])0[ \t]*gr\}" = "\10 groszy"
"(^|[^0-9\,\.])1[ \t]*gr\}" = "\11 grosz"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*gr\}" = "\1\2\3 grosze"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*gr\}" = "\1\2\3 grosze"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*gr\}" = "\1\2\3 groszy"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*gr\}" = "\1\2\3\4\5 grosze"

"(^|[^0-9\,\.])0[ \t]*Hz\}" = "\10 herca"
"(^|[^0-9\,\.])1[ \t]*Hz\}" = "\11 herc"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*Hz\}" = "\1\2\3 herce"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*Hz\}" = "\1\2\3 herce"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*Hz\}" = "\1\2\3 herców"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*Hz\}" = "\1\2\3\4\5 herca"

;"(^|[^0-9\,\.])0[ \t]*cd\}" = "\10 kandeli"
;"(^|[^0-9\,\.])1[ \t]*cd\}" = "\11 kandela"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*cd\}" = "\1\2\3 kandele"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*cd\}" = "\1\2\3 kandele"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*cd\}" = "\1\2\3 kandeli"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*cd\}" = "\1\2\3\4\5 kandeli"

;"(^|[^0-9\,\.])0[ \t]*K\}" = "\10 kelvina"
;"(^|[^0-9\,\.])1[ \t]*K\}" = "\11 kelvin"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*K\}" = "\1\2\3 kelviny"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*K\}" = "\1\2\3 kelviny"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*K\}" = "\1\2\3 kelvinów"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*K\}" = "\1\2\3\4\5 kelvina"

"(^|[^0-9\,\.])0[ \t]*kHz\}" = "\10 kiloherca"
"(^|[^0-9\,\.])1[ \t]*kHz\}" = "\11 kiloherc"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*kHz\}" = "\1\2\3 kiloherce"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*kHz\}" = "\1\2\3 kiloherce"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*kHz\}" = "\1\2\3 kiloherców"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*kHz\}" = "\1\2\3\4\5 kiloherca"

"(^|[^0-9\,\.])0[ \t]*kg\}" = "\10 kilograma"
"(^|[^0-9\,\.])1[ \t]*kg\}" = "\11 kilogram"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*kg\}" = "\1\2\3 kilogramy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*kg\}" = "\1\2\3 kilogramy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*kg\}" = "\1\2\3 kilogramów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*kg\}" = "\1\2\3\4\5 kilograma"

"(^|[^0-9\,\.])0[ \t]*km\}" = "\10 kilometra"
"(^|[^0-9\,\.])1[ \t]*km\}" = "\11 kilometr"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*km\}" = "\1\2\3 kilometry"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*km\}" = "\1\2\3 kilometry"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*km\}" = "\1\2\3 kilometrów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*km\}" = "\1\2\3\4\5 kilometra"

;"(^|[^0-9\,\.])0[ \t]*l\}" = "\10 litra"
;"(^|[^0-9\,\.])1[ \t]*l\}" = "\11 litr"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*l\}" = "\1\2\3 litry"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*l\}" = "\1\2\3 litry"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*l\}" = "\1\2\3 litrów"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*l\}" = "\1\2\3\4\5 litra"

"(^|[^0-9\,\.])0[ \t]*lm\}" = "\10 lumena"
"(^|[^0-9\,\.])1[ \t]*lm\}" = "\11 lumen"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*lm\}" = "\1\2\3 lumeny"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*lm\}" = "\1\2\3 lumeny"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*lm\}" = "\1\2\3 lumenów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*lm\}" = "\1\2\3\4\5 lumena"

"(^|[^0-9\,\.])0[ \t]*lx\}" = "\10 luksa"
"(^|[^0-9\,\.])1[ \t]*lx\}" = "\11 luks"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*lx\}" = "\1\2\3 luksy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*lx\}" = "\1\2\3 luksy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*lx\}" = "\1\2\3 luksów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*lx\}" = "\1\2\3\4\5 luksa"

"(^|[^0-9\,\.])0[ \t]*MHz\}" = "\10 megaherca"
"(^|[^0-9\,\.])1[ \t]*MHz\}" = "\11 megaherc"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*MHz\}" = "\1\2\3 megaherce"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*MHz\}" = "\1\2\3 megaherce"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*MHz\}" = "\1\2\3 megaherców"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*MHz\}" = "\1\2\3\4\5 megaherca"

;"(^|[^0-9\,\.])0[ \t]*m\}" = "\10 metra"
;"(^|[^0-9\,\.])1[ \t]*m\}" = "\11 metr"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*m\}" = "\1\2\3 metry"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*m\}" = "\1\2\3 metry"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*m\}" = "\1\2\3 metrów"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*m\}" = "\1\2\3\4\5 metra"

"(^|[^0-9\,\.])0[ \t]*mld\}" = "\10 miliardów"
"(^|[^0-9\,\.])1[ \t]*mld\}" = "\11 miliard"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*mld\}" = "\1\2\3 miliardy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*mld\}" = "\1\2\3 miliardy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*mld\}" = "\1\2\3 miliardów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*mld\}" = "\1\2\3\4\5 miliarda"
"\{mld\}"  =  "miliardów"

"(^|[^0-9\,\.])0[ \t]*mg\}" = "\10 miligrama"
"(^|[^0-9\,\.])1[ \t]*mg\}" = "\11 miligram"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*mg\}" = "\1\2\3 miligramy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*mg\}" = "\1\2\3 miligramy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*mg\}" = "\1\2\3 miligramów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*mg\}" = "\1\2\3\4\5 miligrama"

"(^|[^0-9\,\.])0[ \t]*mm\}" = "\10 milimetra"
"(^|[^0-9\,\.])1[ \t]*mm\}" = "\11 milimetr"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*mm\}" = "\1\2\3 milimetry"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*mm\}" = "\1\2\3 milimetry"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*mm\}" = "\1\2\3 milimetrów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*mm\}" = "\1\2\3\4\5 milimetra"

"(^|[^0-9\,\.])0[ \t]*ml\}" = "\10 mililitra"
"(^|[^0-9\,\.])1[ \t]*ml\}" = "\11 mililitr"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*ml\}" = "\1\2\3 mililitry"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*ml\}" = "\1\2\3 mililitry"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*ml\}" = "\1\2\3 mililitrów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*ml\}" = "\1\2\3\4\5 mililitra"

"(^|[^0-9\,\.])0[ \t]*mln\}" = "\10 milionów"
"(^|[^0-9\,\.])1[ \t]*mln\}" = "\11 milion"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*mln\}" = "\1\2\3 miliony"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*mln\}" = "\1\2\3 miliony"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*mln\}" = "\1\2\3 milionów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*mln\}" = "\1\2\3\4\5 miliona"
"\{mln\}"  =  "milionów"

"(^|[^0-9\,\.])0[ \t]*min\}" = "\10 minut"
"(^|[^0-9\,\.])1[ \t]*min\}" = "\11 minuta"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*min\}" = "\1\2\3 minuty"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*min\}" = "\1\2\3 minuty"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*min\}" = "\1\2\3 minut"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*min\}" = "\1\2\3\4\5 minuty"

"(^|[^0-9\,\.])0[ \t]*mol\}" = "\10 mola"
"(^|[^0-9\,\.])1[ \t]*mol\}" = "\11 mol"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*mol\}" = "\1\2\3 mole"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*mol\}" = "\1\2\3 mole"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*mol\}" = "\1\2\3 moli"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*mol\}" = "\1\2\3\4\5 mola"

"(^|[^0-9\,\.])0[ \t]*[p|P]k\}" = "\10 punktów"
"(^|[^0-9\,\.])1[ \t]*[p|P]k\}" = "\11 punkt"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*[p|P]k\}" = "\1\2\3 punkty"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*[p|P]k\}" = "\1\2\3 punkty"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*[p|P]k\}" = "\1\2\3 punktów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*[p|P]k\}" = "\1\2\3\4\5 punkta"
"\{[p|P]k\}"  =  "punktów"

;"(^|[^0-9\,\.])0[ \t]*rad\}" = "\10 radiana"
;"(^|[^0-9\,\.])1[ \t]*rad\}" = "\11 radian"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*rad\}" = "\1\2\3 radiany"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*rad\}" = "\1\2\3 radiany"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*rad\}" = "\1\2\3 radianów"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*rad\}" = "\1\2\3\4\5 radiana"

"([0-9]*)([0-9])[ \t]*r[.| ]\}" = "\1\2 rok"

;"(^|[^0-9\,\.])0[ \t]*s\}" = "\10 sekundy"
;"(^|[^0-9\,\.])1[ \t]*s\}" = "\11 sekunda"
;"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*s\}" = "\1\2\3 sekundy"
;"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*s\}" = "\1\2\3 sekundy"
;"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*s\}" = "\1\2\3 sekund"
;"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*s\}" = "\1\2\3\4\5 sekundy"

"(^|[^0-9\,\.])0[ \t]*°C\}" = "\10 stopni"
"(^|[^0-9\,\.])1[ \t]*°C\}" = "\11 stopień"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*°C\}" = "\1\2\3 stopnie"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*°C\}" = "\1\2\3 stopnie"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*°C\}" = "\1\2\3 stopni"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*°C\}" = "\1\2\3\4\5 stopnia"

"(^|[^0-9\,\.])0[ \t]*tys\}" = "\10 tysięcy"
"(^|[^0-9\,\.])1[ \t]*tys\}" = "\11 tysiąc"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*tys\}" = "\1\2\3 tysiące"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*tys\}" = "\1\2\3 tysiące"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*tys\}" = "\1\2\3 tysięcy"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*tys\}" = "\1\2\3\4\5 tysiąca"
"\{tys\}"  =  "tysięcy"

"(^|[^0-9\,\.])0[ \t]*[z|Z]ł\}" = "\10 złoty"
"(^|[^0-9\,\.])1[ \t]*[z|Z]ł\}" = "\11 złoty"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*[z|Z]ł\}" = "\1\2\3 złote"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*[z|Z]ł\}" = "\1\2\3 złote"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*[z|Z]ł\}" = "\1\2\3 złotych"
"\{[z|Z]ł\}"  =  "złotych"

"(^|[^0-9\,\.])0[ \t]*PLN\}" = "\10 złoty"
"(^|[^0-9\,\.])1[ \t]*PLN\}" = "\11 złoty"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*PLN\}" = "\1\2\3 złote"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*PLN\}" = "\1\2\3 złote"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*PLN\}" = "\1\2\3 złotych"
"\{PLN\}"  =  "złotych"

"(^|[^0-9\,\.])0[ \t]*Wb\}" = "\10 webera"
"(^|[^0-9\,\.])1[ \t]*Wb\}" = "\11 weber"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*Wb\}" = "\1\2\3 webery"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*Wb\}" = "\1\2\3 webery"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*Wb\}" = "\1\2\3 weberów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*Wb\}" = "\1\2\3\4\5 webera"

"(^|[^0-9\,\.])0[ \t]*Ω\}" = "\10 oma"
"(^|[^0-9\,\.])1[ \t]*Ω\}" = "\11 om"
"(^|[^0-9\,\.])([2-9]?)([2-4])[ \t]*Ω\}" = "\1\2\3 omy"
"(^|[^0-9\,\.])([0-9]*[2-9])([2-4])[ \t]*Ω\}" = "\1\2\3 omy"
"(^|[^0-9\,\.])([0-9]*)([0-9])[ \t]*Ω\}" = "\1\2\3 omów"
"([0-9]*)([0-9])([\,|\.])([0-9]*)([0-9])[ \t]*Ω\}" = "\1\2\3\4\5 oma"

