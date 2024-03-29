﻿;Case Sensitive
"([0-9]+)[ \t]*m\.?\}"  =  "\1 mètres"
"([0-9]+)[,.]+([0-9][0-9]+)[ \t]*m\.?\}"  =  "\1 mètres \2"
"([0-9]+)[,.]+([0-9][0-9]+)[ \t]*(km|Km)\.?\}"  =  "\1 kilomètres \2"
"([0-9]+)[,.]+([0-9]+)[ \t]*kg\.?\}"  =  "\1 kilogrammes \2"
;"([0-9]+)[ \t]*F\}"  =  "\1 francs"
;"([0-9]+)[ \t,]+([0-9][0-9][0-9])[ \t.]*F\}"  =  "\1\2 francs"
;"([0-9]+)[ \t,]+([0-9][0-9][0-9])[ \t,]+([0-9][0-9][0-9])[ \t.]*F\}"  =  "\1\2\3 francs"
;"([0-9]+)[.,]+([0-9][0-9])[ \t]*(F|francs|FF)\}"  =  "\1 francs \2"
;"([0-9]+)[.,]+([0-9])[ \t]*(F|francs( française)?|FF)\}"  =  "\1 francs \20"
"([0-9]+)[.,]+([0-9][0-9])[ \t]*(francs|FF)\}"  =  "\1 francs \2"
"([0-9]+)[.,]+([0-9])[ \t]*(francs( française)?|FF)\}"  =  "\1 francs \20"
"([cdhlmnrstvzjçCDHLMNRSTVZJÇ]['’´])([aeiouhyAEIOUYHàáèéìíòóùúýâãäåæœêëîïôõöøûüÿÀÁÈÉÌÍÒÓÙÚÝÂÃÄÅÆŒÊËÎÏÔÕÖØÛÜŸ])"  =  "\1 \2"
"([^a-zA-Z])([0-9]+)[ \t,]+(000)[ \t.]+"  =  "\1\2\3 "
"([^a-zA-Z])([0-9]+)[ \t,]+([0-9][0-9][0-9])[ \t,]+(000)[ \t.]+"  =  "\1\2\3\4 "
"\{([A-Z][a-zA-Z]*)[ \t]+(II|III|IV|VI|VII|VIII|IX|X|XI|XII|XIII|XIV|XV|XVI)\}"  =  "\1 \Nr \2"
"\{([IXV])+([IXV])+([IXV])+(e|è|ème)\}"  =  "\Nm \1\2\3"
"\{([IXV])+([IXV])+(e|è|ème)\}"  =  "\Nm \1\2"
"\{([IXV])+(e|è|ème)\}"  =  "\Nm \1"

;Convertiti
"([a-zA-Z]*[0-9]*)('')\.?\}"  =  "\1 \2"
"([aeiouAEIOU]['’´])([a-zA-Z])"  =  "\1 \2"
"(dix|DIX|Dix)[ ]?\-[ ]?(sept|SEPT|Sept)"  =  "\1\2"
"(dix|DIX|Dix)[ ]?\-[ ]?(huit|HUIT|Huit)"  =  "\1\2"
"(dix|DIX|Dix)[ ]?\-[ ]?(neuf|NEUF|Neuf)"  =  "\1\2"
"[1](èr|ère|ÈR|ÈRE)\}"  =  " premi\1"
"[1](er|ere|ER|ERE)\}"  =  " premi\1"
"([0-9])[ \t]*(g|gr|G|GR|Gr)\.?\}"  =  "\1 grammes "
"\{(no|NO|No)\.[ \t]*([0-9]+)"  =  "numéro \2"
"\{(n°|N°)\.?[ \t]*([0-9]+)"  =  "numéro \2"
; S.Q. 16/3/07 gestito via dbl {"\r(\-t)\-([aeiouhyAEIOUYHàáèéìíòóùúýâãäåæœêëîïôõöøûüÿÀÁÈÉÌÍÒÓÙÚÝÂÃÄÅÆŒÊËÎÏÔÕÖØÛÜŸ])"  =  "\1' \2"
