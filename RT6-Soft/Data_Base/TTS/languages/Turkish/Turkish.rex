
;#define RX_ANY_TURKISH_CHAR "['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]"

; TODO: Una volta sistemata nell'engine la gestione dei tag, bisogna
;       togliere la sequenza   \{$  dalla seguente espressione
;#define RX_BLANK "[ \t\{\$]"

;    /*Lettura numeri ordinali*/

"(^|[^0-9\.,;:])([1-9])(\.)[ \t]*(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)"  =  "\1 \{number=ordinalM \2 \4"
"(^|[^0-9\.,;:])([1-9][0-9])(\.)[ \t\{\$]*(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)"  =  "\1 \{number=ordinalM \2 \4"
"(^|[^0-9\.,;:])([1-9][0-9][0-9])(\.)[ \t\{\$]*(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)"  =  "\1 \{number=ordinalM \2 \4"
"(^|[^0-9\.,;:])([1-9][0-9][0-9][0-9])(\.)[ \t\{\$]*(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)"  =  "\1 \{number=ordinalM \2 \4"
;	/*** !!! Attenzione: probabilmente in assenza del parametro , smette di funzionare l'operatore ^ */
	


;	/* misure nella forma "1000x15" "640X480" */
"(^|[ \t\])([0-9]+)([xX])([0-9]+)"  =  "\1 \2 çarpı \4"


;        /* numeri romani */
;#define ROMAN_NUM_REGEXP "II|III|IV|VI|VII|VIII|IX|XI|XII|XIII|XIV|XV|XVI|XVII|XVIII|XIX|XX|XXI|XXII|XXIII|XXIV|XXV|XXVI|XXVII|XXVIII|XXIX|XXX|XXXI|XXXII|XXXIII|XXXIV|XXXV|XXXVI|XXXVII|XXXVIII|XXXIX"
; Il punto in coda al numero romano (ordinalita') deve essere rimosso se non e' un punto di fine frase.
"(^|[ \t\.,;:])(II|III|IV|VI|VII|VIII|IX|XI|XII|XIII|XIV|XV|XVI|XVII|XVIII|XIX|XX|XXI|XXII|XXIII|XXIV|XXV|XXVI|XXVII|XXVIII|XXIX|XXX|XXXI|XXXII|XXXIII|XXXIV|XXXV|XXXVI|XXXVII|XXXVIII|XXXIX)(\.)([ \t,;:'’])"  =  "\1 \{number=ordinalM \2 \4"
; se il punto era una fine frase, lo tiene
"(^|[ \t\.,;:])(II|III|IV|VI|VII|VIII|IX|XI|XII|XIII|XIV|XV|XVI|XVII|XVIII|XIX|XX|XXI|XXII|XXIII|XXIV|XXV|XXVI|XXVII|XXVIII|XXIX|XXX|XXXI|XXXII|XXXIII|XXXIV|XXXV|XXXVI|XXXVII|XXXVIII|XXXIX)(\.)($)"  =  "\1 \{number=ordinalM \2 \3 \4"

; Il numero romano puo'anche essere senza punto, ma si legge comunque come ordinale
"(^|[ \t\.,;:])(II|III|IV|VI|VII|VIII|IX|XI|XII|XIII|XIV|XV|XVI|XVII|XVIII|XIX|XX|XXI|XXII|XXIII|XXIV|XXV|XXVI|XXVII|XXVIII|XXIX|XXX|XXXI|XXXII|XXXIII|XXXIV|XXXV|XXXVI|XXXVII|XXXVIII|XXXIX)($|[ \t,;:'’])"  =  "\1 \{number=ordinalM \2 \3"



;	/* nel corpus accade spesso che siano utilizzati gli apostrofi, al posto delle doppie virgolette,
;	per racchiudere citazioni. Purtroppo in Turco l'apostrofo viene anche utilizzato, nei nomi propri,
;	per separare la radice dai suffissi; normalmente in questi casi l'apostrofo e' infisso nella parola,
;	senza blank (es. "radice'suff"). Purtroppo talvolta accade anche che l'apostrofo
;	infisso nei nomi propri sia in realta' seguito anche da un blank.
;	*/
;	// elimina gli apostrofi che sicuramente non sono separatori di suffissi
"([\t,;:])(['’´])"  =  "\1"
"(['’´])([\t\.,;:])"  =  "\2"


;	// 26/04/2007: in realta' pare che secondo le buone norme di ortografia, in un nome proprio
;	//              con suffissi deve esserci un blank tra il nome e l'apostrofo.
;	//  Si opera invece una normalizzazione, per eliminare i blank tra nome e apice, in modo da 
;	//  ottenere un solo token <nome'suffissi> senza blank infissi.
"( )?(['’´])( )?"  =  "'"
;"( )(['’´])"  =  "'"
;"(['’´])( )"  =  "'"
;"([’´])"  =  "'"



;/* apostrofo implicito, assimilato a doppi apici: esempio:
;   önceki "Uluslararası Atatürk Kongresi"nde Genelkurmay
;   in questo caso [Kongresi"nde] in realta' deve essere letto come [Kongresi'nde] anche se 
;   l'apice di separazione dei suffissi e' stato assimilato al doppio apice della citazione.
;   (in caso contrario, "nde" verrebbe riconosciuto come una sigla e ne verrebbe fatto lo spelling)

;   Con la seguente espressione regolare si tenta di aggiustare questo caso,
;   trasformando [Kongresi"nde] in [Kongresi'nde"]
;*/
    
"(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)(\")(['’a-zA-ZŸÿÇçĞğŞşıïöôüâîêû]+)"  =  "\1'\3\2"



;	// individua l'indicazione dei gradi centigradi. Operazione effettuata qui in quanto durante la tokenizzazione si perde il simbolo di grado.
"([ \t\.,;:0-9])(\°[Cc])([ \t\.,;:'’])"  =  "\1 derece\3"
	


; .com in indirizzi internet.
; TODO: implementare nelle normali procedure di gestione degli indirizzi internet.

"([\.])(com|COM)([ \t\.,;:'’])"  =  "\1kom\3"
;#define NONCHAR_REGEXP "(^|[ \t\.,;:'’\\"\-])"
"(^|[ \t\.,;:'’\"\-])([fF][tT][pP])(^|[ \t\.,;:'’\"\-])"  =  "\1eftipi\3"
"(^|[ \t\.,;:'’\"\-])([hH][tT][tT][pP])(^|[ \t\.,;:'’\"\-])"  =  "\1eyçtğitğipi\3"



; metri, centimetri.. etc. ma *senza* il punto di abbreviazione; espansi solo se preceduti da un numero 

"(^|[ \t])([0-9][0-9.,]*)[ \t\]*(m|M)([\.'’ \t\$])"  =  "\1\2metre\4"
"(^|[ \t])([0-9][0-9.,]*)[ \t\]*([cC][mM])([\.'’ \t\$])"  =  "\1\2santimetre\4"
"(^|[ \t])([0-9][0-9.,]*)[ \t\]*([mM][mM])([\.'’ \t\$])"  =  "\1\2milimetre\4"

; ... o seguiti da un numero, come per "no"
"(^|[ \t])([nN][oO])[ \t\]+([0-9\(\-])"  =  "\1numara \3"
	       

; Normalizza "vs..." (etc.)
"(^|[ \t])([vS][sS])(\.+)"  =  "\1vesaire ..."



; rasforma i simboli di frazione in frazioni per esteso
; NOTA: questi simboli vengono trasformati in modo da permettere l'applicazione
;       delle regole ai confini pctk. In caso di presenza di suffissi  (es. ¼'un)
;       l'espansione standard elimina l'apostrofo, impedendo il riconoscimento dei suffissi.
;       Per questo motivo si opera qui la trasformazione, in modo che eventuali apostrofo e suffissi
;       vengano conservati e le regole pctk applicate.

	       
"¼"  =  "1/4"
"¾"  =  "3/4"



