import Foundation

// MARK: - Forum Category

enum ForumCategory: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    case fertilitetTTC      = "Fertilitet & TTC"
    case graviditet         = "Graviditet"
    case forlossning        = "Förlossning & BB"
    case nyfodda            = "Nyfödda 0–3 mån"
    case somnRutiner        = "Sömn & rutiner"
    case matAmning          = "Mat & amning"
    case utvecklingMilstolpar = "Utveckling & milstolpar"
    case relationForaldraskap = "Relation & föräldraskap"

    var icon: String {
        switch self {
        case .fertilitetTTC:        return "heart.circle.fill"
        case .graviditet:           return "figure.pregnant"
        case .forlossning:          return "staroflife.fill"
        case .nyfodda:              return "figure.infant"
        case .somnRutiner:          return "moon.stars.fill"
        case .matAmning:            return "drop.fill"
        case .utvecklingMilstolpar: return "star.fill"
        case .relationForaldraskap: return "person.2.fill"
        }
    }
}

// MARK: - Forum Thread Model

struct ForumThread: Identifiable {
    let id: String
    let title: String
    let summary: String
    let category: ForumCategory
    let reactionsCount: Int
    let sourceURL: String?
}

// MARK: - Forum Data

struct ForumData {
    static let threads: [ForumThread] = [

        // MARK: Fertilitet & TTC
        ForumThread(
            id: "ttc-001",
            title: "När slutar man försöka? Vi är på månad 18 nu",
            summary: "Vi har försökt i ett och ett halvt år och jag börjar tveka på om vi ska fortsätta. Remissen till specialist är skickad men väntetiden är lång. Hur klarade ni av att hålla hoppet uppe när det drog ut på tiden?",
            category: .fertilitetTTC,
            reactionsCount: 187,
            sourceURL: "https://www.familjeliv.se/forum/thread/ttc-forsok"
        ),
        ForumThread(
            id: "ttc-002",
            title: "LH-tester — positiv men ingen temp-stigning, vad händer?",
            summary: "Jag fick positiv LH-peak på måndag men basaltemperaturen har inte stigit ett dugg. Tredje cykeln i rad med samma mönster. Har någon upplevt detta och vet vad det kan bedeuta — ägglossning utan ägg, eller?",
            category: .fertilitetTTC,
            reactionsCount: 94,
            sourceURL: nil
        ),
        ForumThread(
            id: "ttc-003",
            title: "PCOS-diagnos nyligen — behöver råd om nästa steg",
            summary: "Fick diagnosen förra månaden och läkaren nämnde både metformin och letrozol som alternativ. Jag är 29 år och vi har försökt i åtta månader. Någon som gått igenom liknande och kan dela med sig av sina erfarenheter?",
            category: .fertilitetTTC,
            reactionsCount: 213,
            sourceURL: nil
        ),
        ForumThread(
            id: "ttc-004",
            title: "Andra kliniker efter misslyckad IVF — var söker ni?",
            summary: "Första IVF-omgången gick inte alls som vi hoppats. Nu funderar vi på att byta klinik och höra oss för om privata alternativ. Har någon bytt klinik och märkt skillnad i bemötande eller resultat?",
            category: .fertilitetTTC,
            reactionsCount: 142,
            sourceURL: nil
        ),
        ForumThread(
            id: "ttc-005",
            title: "Äggcellsfrysning vid 34 — dags att agera eller vänta?",
            summary: "Jag är singel och 34 år och funderar allvarligt på att frysa ägg som en försäkring. Hur upplevde ni processen rent fysiskt och psykiskt? Kostnaderna är höga, men oron för att vänta för länge är större.",
            category: .fertilitetTTC,
            reactionsCount: 118,
            sourceURL: nil
        ),
        ForumThread(
            id: "ttc-006",
            title: "Äntligen BFP efter 22 månader — min berättelse",
            summary: "Jag ville dela med mig eftersom jag läste så många hopplösa trådar under de mörka perioderna. Det händer faktiskt, även om det tar lång tid. Hormonstimulering plus timing-protokoll var det som till slut fungerade för oss.",
            category: .fertilitetTTC,
            reactionsCount: 347,
            sourceURL: nil
        ),
        ForumThread(
            id: "ttc-007",
            title: "Manlig faktor — låg motilitet, vilken behandling?",
            summary: "Spermaanalys visade 8% motilitet och vi är lite rådvilla. Urologen sa att förbättring är möjlig men svår. IUI eller direkt IVF-ICSI — hur resonerade ni när ni stod inför det här valet?",
            category: .fertilitetTTC,
            reactionsCount: 76,
            sourceURL: nil
        ),

        // MARK: Graviditet
        ForumThread(
            id: "grav-001",
            title: "Illamående vecka 6 — vad hjälper ER?",
            summary: "Jag kräks i princip hela dagen och kan inte äta mer än kex och vatten. Jobbet vet inte att jag är gravid ännu men det börjar synas att något är fel. Vilka hemmaråd eller läkemedel har faktiskt hjälpt er?",
            category: .graviditet,
            reactionsCount: 264,
            sourceURL: "https://www.familjeliv.se/forum/thread/graviditet-illamaende"
        ),
        ForumThread(
            id: "grav-002",
            title: "Anatomiultraljud nästa vecka — hur förberedde ni er?",
            summary: "Vecka 18 är äntligen här och jag är en blandning av upprymdhet och nervositet. Vi har inte velat veta könet men nu undrar vi om vi missar något viktigt om vi säger att ultraljudsläkaren ska hålla det hemligt. Hur tänkte ni?",
            category: .graviditet,
            reactionsCount: 89,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-003",
            title: "Vad innebär 'välmående foster' egentligen?",
            summary: "Barnmorskan sa det igen på besöket idag och jag nickar men förstår egentligen inte vad de kollar på. Hjärtljud, rörelser, och vad mer? Borde jag begära mer detaljer eller är det ett standard-lugnande?",
            category: .graviditet,
            reactionsCount: 57,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-004",
            title: "KUB-test visade förhöjd risk — vad händer nu?",
            summary: "Fick besked om 1:180 för trisomi 21 och är i total chock. NIPT är bokat för nästa vecka men väntan är fruktansvärd. Har någon gått igenom detta och kan berätta hur vägen framåt såg ut?",
            category: .graviditet,
            reactionsCount: 156,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-005",
            title: "Bäckensmärtor i vecka 24 — fick ni sjukskrivning?",
            summary: "Jag jobbar stående hela dagen och smärtan blir allt värre. Barnmorskan tycktes inte ta det på allvar men jag kan knappt gå. Fick ni sjukskrivning och i så fall hur — via barnmorska eller husläkare?",
            category: .graviditet,
            reactionsCount: 193,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-006",
            title: "Fosterrörelser — hur många räknas som normalt?",
            summary: "Jag är i vecka 28 och har hört att man ska räkna sparkar men olika källor säger helt olika saker. Barnmorskan sa tio rörelser om tio timmar, appen säger något annat. Hur tänkte ni kring detta?",
            category: .graviditet,
            reactionsCount: 134,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-007",
            title: "Graviditetsdiabetes — kostombyte dag 1",
            summary: "Fick diagnosen idag vid vecka 29 och är överväldigad av all information om blodsockerkontroll och kostförändringar. Hur snabbt märkte ni skillnad när ni ändrade kosten, och klarade ni er utan insulin?",
            category: .graviditet,
            reactionsCount: 178,
            sourceURL: nil
        ),

        // MARK: Förlossning & BB
        ForumThread(
            id: "forl-001",
            title: "Förlossningsrädsla — det hjälpte mig faktiskt",
            summary: "Jag hade så svår tokofobigat att jag övervägde att inte bli gravid alls. Kursen på BB-kliniken och EMDR-terapi förändrade allt. Nu har jag en sexmånaders bebis och en förlossning som jag faktiskt kan titta tillbaka på utan panik.",
            category: .forlossning,
            reactionsCount: 312,
            sourceURL: nil
        ),
        ForumThread(
            id: "forl-002",
            title: "Epidural eller inte — hur bestämde ni er?",
            summary: "Jag vill hålla dörrarna öppna men min partner tycker jag borde bestämma mig i förväg för att slippa pressa in beslutet under värkarna. Hur detaljerad var er förlossningsplan och följde personalen den?",
            category: .forlossning,
            reactionsCount: 247,
            sourceURL: nil
        ),
        ForumThread(
            id: "forl-003",
            title: "Kejsarsnitt utan medicinsk orsak — fick ni det beviljat?",
            summary: "Jag bad om planerat kejsarsnitt av psykologiska skäl och mötte ett starkt motstånd från gynekologen. Fick till slut ja efter att ha anlitat ett ombud. Har fler gjort liknande och vad var ert argument?",
            category: .forlossning,
            reactionsCount: 189,
            sourceURL: nil
        ),
        ForumThread(
            id: "forl-004",
            title: "BB-vistelsen — hur länge fick ni stanna?",
            summary: "Vi åkte hem sex timmar efter förlossningen för att vi inte fick rum. Amningen fungerade dåligt och vi kände oss oförberedda. Andra fick stanna två dygn på samma sjukhus. Hur gick det till för er och hur påverkade det starten?",
            category: .forlossning,
            reactionsCount: 221,
            sourceURL: nil
        ),
        ForumThread(
            id: "forl-005",
            title: "Bristningsskada grad 3 — återhämtning och sex",
            summary: "Fick grad 3-bristning och är nu tre månader post partum. Fysioterapeuten hjälper men det tar tid. Hur lång tid tog det för er att känna er normala igen, och hur pratar man med sin partner om intimitet under den här perioden?",
            category: .forlossning,
            reactionsCount: 287,
            sourceURL: nil
        ),

        // MARK: Nyfödda 0–3 mån
        ForumThread(
            id: "nyf-001",
            title: "Tre veckors bebis skriker hela kvällarna — normalt?",
            summary: "Från 17 till 22 på kvällen är det fullständigt kaos. Ingenting hjälper — varken matning, bärande, sugplugg eller körning i bil. Vi är utmattade och lite rädda att något är fel. Är det kvällskolik och går det verkligen över?",
            category: .nyfodda,
            reactionsCount: 298,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-002",
            title: "Gulsot kvarstår vecka tre — är det normalt?",
            summary: "BVC sa att det är bröstmjölksgulsot och att vi ska vänta ut det. Men bebisen ser fortfarande gul ut och äter lite sämre. Hur länge varade det för er och när sökte ni akut?",
            category: .nyfodda,
            reactionsCount: 83,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-003",
            title: "Naveln stinker lite — ska vi på BVC eller vänta?",
            summary: "Det är åtta dagar sedan navelstumpen lossade men det luktar lite konstigt runt naveln. Ingen rodnad och bebisen verkar opåverkad. Lite paranoid förstagångsmamma här — när är det läge att söka?",
            category: .nyfodda,
            reactionsCount: 47,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-004",
            title: "Tillväxttopparna — vecka 3, 6 och 12, stämmer det?",
            summary: "Bebisen äter hela tiden den här veckan och jag förstår att det är tillväxttopp, men det är ändå svårt att inte undra om mjölken räcker. Hur länge brukar en tillväxttopp hålla och märkte ni faktisk förändring efteråt?",
            category: .nyfodda,
            reactionsCount: 162,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-005",
            title: "Magproblem och uppspändhet — vilket tips faktiskt hjälpte?",
            summary: "Vi har provat magmassage, cykelövningar, dimethicon och bytt till långsammare dinapp utan att det hjälper nämnvärt. Bebisen drar upp knäna och skriker av smärta. Vad var det som faktiskt funkade för er bebis?",
            category: .nyfodda,
            reactionsCount: 234,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-006",
            title: "Pappan är mer lugn med bebisen än jag — ska jag vara orolig?",
            summary: "Min partner verkar naturligt trygg med att bära och lugna vår tre veckor gamla dotter, medan jag känner mig klumpig och osäker. Är det normalt att anknytningen tar längre tid för mammor ibland, eller missar jag något?",
            category: .nyfodda,
            reactionsCount: 176,
            sourceURL: nil
        ),

        // MARK: Sömn & rutiner
        ForumThread(
            id: "somn-001",
            title: "4-månaders regressionen — vi har inga nätter längre",
            summary: "Från att ha sovit fyra–fem timmar i sträck vaknar bebisen nu varje timme. Det är som att klockorna nollställdes. Hur lång tid tog regressionen för er och hjälpte det att börja jobba på självinsomning under den här perioden?",
            category: .somnRutiner,
            reactionsCount: 341,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-002",
            title: "Nattavvänjning utan CIO — fungerar det?",
            summary: "Vi vill inte låta bebisen gråta utan närvaro men har läst om gradvis metod och 'no cry'-alternativ. Vår sjumånaders vaknar fortfarande fyra–fem gånger per natt. Har någon lyckats utan kontrollerad gråt och i så fall hur länge tog det?",
            category: .somnRutiner,
            reactionsCount: 287,
            sourceURL: "https://www.familjeliv.se/forum/thread/somn-nattavvanjning"
        ),
        ForumThread(
            id: "somn-003",
            title: "Vår bebis sover bara på oss — hur bryter man mönstret?",
            summary: "Fem månader gammal och somnar bara på bröstet eller i famnen. Så fort vi lägger ner vaknar hon. Vi har försökt med värmt underlag och att lägga ner under djupsömnen men inget håller. Är det ett kontaktsömnsbehov som man måste vänta ut?",
            category: .somnRutiner,
            reactionsCount: 319,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-004",
            title: "Sover vi för mycket med bebisen i sängen?",
            summary: "Vi har hamnat i samsovning av nödvändighet och alla sover faktiskt bättre nu. Men vi undrar om vi skapar ett beroende och läser motstridiga råd om säkerhet. Hur tänker ni kring samsovning och när och hur slutar man?",
            category: .somnRutiner,
            reactionsCount: 245,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-005",
            title: "Dagssömn — hur länge och hur många gånger vid fem månader?",
            summary: "BVC sa att behoven varierar men gav inga konkreta ramar. Vi har prövat med tre korta tupplurer och två längre, ingen av rutinerna håller. Hur hittade ni en dagssömnsrutin som faktiskt funkade för just er bebis?",
            category: .somnRutiner,
            reactionsCount: 197,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-006",
            title: "Åtta månader och fortfarande ingen hel natt — acceptera eller agera?",
            summary: "Jag är tillbaka på jobbet och klara inte av att fungera med tre nattuppvaknanden. Alla säger 'det löser sig' men det har det inte gjort. Hur visste ni när det var dags att aktivt jobba med sömnen snarare än att vänta ut det?",
            category: .somnRutiner,
            reactionsCount: 278,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-007",
            title: "Läggningsrutin för nyfödda — för tidigt att börja?",
            summary: "Bebisen är tre veckor gammal och min partner tycker det är för tidigt med någon form av rutin, men jag vill sätta igång direkt. Hur tidigt börjar man med bad-bok-mat-sömn-mönster och märks det faktiskt?",
            category: .somnRutiner,
            reactionsCount: 143,
            sourceURL: nil
        ),

        // MARK: Mat & amning
        ForumThread(
            id: "mat-001",
            title: "Övergångsmaten dag 1 — hjälp!",
            summary: "Bebisen är sex månader och jag vet inte var jag ska börja. Purée eller BLW? Gröt eller grönsaker? Alla råder oss olika och BVC-sköterskan gav broschyren utan att egentligen svara på mina frågor. Hur lade ni upp starten?",
            category: .matAmning,
            reactionsCount: 321,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-002",
            title: "Allergiprotokoll för komjölk — erfarenheter?",
            summary: "Bebisen reagerar med utslag och gaser efter att jag åtit mjölkprodukter och vi misstänker komjölksallergi. Barnläkaren rekommenderade Neocate men det är smakdåligt och dyrt. Hur hanterade ni transitionen och hur länge var ni på hydrolyserat?",
            category: .matAmning,
            reactionsCount: 208,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-003",
            title: "Slutade amma vid sex månader — dåligt samvete",
            summary: "Jag orkade inte mer och valde att sluta amma vid sex månader. Intellektuellt vet jag att det är okej men jag bär på mycket skuldkänslor, särskilt när folk frågar. Hur hanterade ni andras kommentarer och era egna tankar?",
            category: .matAmning,
            reactionsCount: 389,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-004",
            title: "Amningsproblem vecka ett — mjölkstockning eller mjölkstop?",
            summary: "Bröstet är hårt och ömt och jag vet inte om jag ska försöka pumpa ur det eller vila. Febern är 38,1. Barnmorskan på telefon sa olika saker vid olika samtal. Hur skiljer man mjölkstockning från mastit och vad söker man för?",
            category: .matAmning,
            reactionsCount: 174,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-005",
            title: "BLW — chokade nästan, nu är vi hängivna anhängare",
            summary: "Vi var skeptiska och lite rädda i början men efter tre månader med barnledd avvänjning vill vi inte ha det på annat sätt. Bebisen äter fantastiskt varierat vid nio månader. Tips för nybörjare och de viktigaste säkerhetstipsen.",
            category: .matAmning,
            reactionsCount: 256,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-006",
            title: "Vegansk kost för bebisen — vad säger ni?",
            summary: "Vi är veganer och vill ge bebisen vegansk kompletteringskost från sex månader. Dietisten vi träffade var osäker och lite avvisande. Har någon veganfamilj i Sverige gjort detta med stöd från vården och fungerade det bra?",
            category: .matAmning,
            reactionsCount: 134,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-007",
            title: "Bebisen vägrar flaskan helt — vad gör man?",
            summary: "Ska börja jobba om tre veckor och bebisen tar absolut inte flaska oavsett napp-typ, temperatur eller vem som håller i den. Vi har provat allt i sex veckor. Finns det verkligen bebis som aldrig lär sig och hur löste det sig för er?",
            category: .matAmning,
            reactionsCount: 267,
            sourceURL: nil
        ),

        // MARK: Utveckling & milstolpar
        ForumThread(
            id: "utv-001",
            title: "Sitter inte vid nio månader — ska vi oroa oss?",
            summary: "Alla kompisar bebisar sitter stabilt men vår son kräver fortfarande stöd. BVC-sköterskan sa att det är normalt upp till tio månader men jag oroar mig. Hur sent satte era barn sig och vad fick er att sluta oroa er?",
            category: .utvecklingMilstolpar,
            reactionsCount: 198,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-002",
            title: "Pratar inte ett ord vid 18 månader — remiss eller vänta?",
            summary: "Vår dotter har inga ord vid 18 månader men babblades och har bra ögonkontakt. BVC skickade remiss till logoped men väntetiden är sex månader. Ska vi söka privat och vad kan vi göra hemma under tiden?",
            category: .utvecklingMilstolpar,
            reactionsCount: 312,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-003",
            title: "Separation anxiety vid åtta månader — är det toppen nu?",
            summary: "Bebisen skriker hystériskt varje gång jag lämnar rummet. Det är som att ett nytt barn uppstod på en vecka. Jag förstår att det är en kognitiv milstolpe men det är fysiskt slitsamt. Hur länge varade det för er och vad hjälpte?",
            category: .utvecklingMilstolpar,
            reactionsCount: 223,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-004",
            title: "Kryper bakåt istället för framåt — normalt?",
            summary: "Tioåringen kryper konsekvent bakåt och verkar frustrerad när han inte kommer dit han vill. BVC sa att det är ett känt stadium men vi undrar hur länge det brukar hålla och om det finns sätt att uppmuntra framåtrörelse.",
            category: .utvecklingMilstolpar,
            reactionsCount: 87,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-005",
            title: "Tidiga tecken på autism — vad fick er att agera?",
            summary: "Vi ser en del saker hos vår 15-månaders son som gör oss fundersamma — begränsat ögonkontakt, ingen pekningsgester och väldigt specifika intressen. Ni som fått en diagnos, vad var de första tecknen ni reagerade på och hur snabb var processen?",
            category: .utvecklingMilstolpar,
            reactionsCount: 445,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-006",
            title: "Första ord på teckenspråk — varför vi började med TAKK",
            summary: "Vi började med tecken för mat, mer, klart och sova vid sex månader och bebisen använde sina första tecken vid åtta månader, fyra månader innan de verbala orden kom. Det minskade frustrationen enormt. Tänkte dela erfarenheten.",
            category: .utvecklingMilstolpar,
            reactionsCount: 276,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-007",
            title: "Inte intresserad av leksaker — ska man oroa sig?",
            summary: "Vår dotter på elva månader föredrar kablar, lådor och kylskåpsmagneter framför alla leksaker vi köpt. Är det normalt att barn i den här åldern inte leker med saker avsedda för dem, eller är det ett tecken på något?",
            category: .utvecklingMilstolpar,
            reactionsCount: 143,
            sourceURL: nil
        ),

        // MARK: Relation & föräldraskap
        ForumThread(
            id: "rel-001",
            title: "Relationen lider — hur hittade ni varandra igen efter bebisen?",
            summary: "Vi är kär i varandra men vi är bara föräldrar nu, inte ett par. Tröttheten och ansvarsfördelningsbråken har tagit över. Hur tog ni tillbaka den vuxna relationen och när vände det för er? Söker verkliga erfarenheter, inte broschyrråd.",
            category: .relationForaldraskap,
            reactionsCount: 427,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-002",
            title: "Postnatal depression som pappa — det finns",
            summary: "Jag kände mig inte glad utan överväldigad och tom de första månaderna. Sökte slutligen hjälp och fick diagnosen postnatal depression. Vill normalisera att det inte bara är mammor som drabbas — har fler pappor sökt hjälp?",
            category: .relationForaldraskap,
            reactionsCount: 356,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-003",
            title: "Svärmor vill vara med på BB — hur satte ni gränser?",
            summary: "Hennes hjärta är på rätt ställe men vi vill vara ensamma de första dagarna. Hur formulerade ni er på ett sätt som inte skapade konflikt men var tydligt? Jag är inte redo för det samtalet och förlossningen är om fem veckor.",
            category: .relationForaldraskap,
            reactionsCount: 289,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-004",
            title: "Ojämn ansvarsfördelning — hur pratade ni om det?",
            summary: "Jag gör 80% av allt men min partner ser det inte som ett problem. Statistiken är klar men det hjälper inte i vardagen. Hur förde ni det här samtalet utan att det eskalerade till bråk, och vad förändrades faktiskt?",
            category: .relationForaldraskap,
            reactionsCount: 398,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-005",
            title: "Ensamstående mamma sedan sex månader — ni ger mig styrka",
            summary: "Min man och jag separerade när bebisen var tre månader. Det har varit det svåraste i mitt liv men också det mest klargörande. Vill dela att det faktiskt går, och fråga om det finns ensamstående föräldrar som vill byta erfarenheter.",
            category: .relationForaldraskap,
            reactionsCount: 312,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-006",
            title: "Rädda för att bli en dålig förälder — har ni känt så?",
            summary: "Jag har känt ett diffust hat mot mig själv som förälder sedan bebisen kom. Inte mot henne, men mot mig — en rädsla att jag inte räcker till. Är det vanligt och vad hjälpte er att börja se er egna insats mer nyanserat?",
            category: .relationForaldraskap,
            reactionsCount: 367,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-007",
            title: "Andra barnet — hur förberedde ni syskonet?",
            summary: "Vi är gravida med nummer två och storebror är tre år. Jag oroar mig för svartsjuka och hur övergången kommer att bli. Vilka böcker, samtal eller strategier hjälpte er att förbereda det äldre syskonet?",
            category: .relationForaldraskap,
            reactionsCount: 234,
            sourceURL: nil
        ),

        // MARK: Extra threads to pass 50 total
        ForumThread(
            id: "ttc-008",
            title: "Dubbla streck på testet — vi är i chock (den goda sorten)",
            summary: "Efter sexton månaders försök och ett avbrutet IUI-försök fick vi positiv test idag. Jag darrar fortfarande. Vill dela glädjen med er som förstår hur lång den vägen kan vara.",
            category: .fertilitetTTC,
            reactionsCount: 512,
            sourceURL: nil
        ),
        ForumThread(
            id: "grav-008",
            title: "Missfall i vecka åtta — processen och efteråt",
            summary: "Vi hade missfall förra veckan och jag är fortfarande i den akuta sorgebearbetningen. Vill förstå vad som händer i kroppen och hur lång tid det tar innan man kan försöka igen. Har ni erfarenhet och vad hjälpte er psykiskt?",
            category: .graviditet,
            reactionsCount: 478,
            sourceURL: nil
        ),
        ForumThread(
            id: "somn-008",
            title: "Vit brus — fungerar det verkligen?",
            summary: "Vi har börjat använda vit brus via en liten högtalare och bebisen verkar sova djupare. Men nu undrar vi om vi skapar ett beroende och om det finns hörselrisker med för hög volym. Vad har ni läst och erfarit?",
            category: .somnRutiner,
            reactionsCount: 187,
            sourceURL: nil
        ),
        ForumThread(
            id: "mat-008",
            title: "Ammar fortfarande vid tolv månader — omgivningens reaktioner",
            summary: "Bebisen är ett år och vi ammar fortfarande på hennes initiativ. Familjen frågar när vi ska sluta och jag orkar inte längre förklara. Hur hanterade ni trycket utifrån och hur fattade ni beslutet om när det var dags?",
            category: .matAmning,
            reactionsCount: 298,
            sourceURL: nil
        ),
        ForumThread(
            id: "utv-008",
            title: "Tänderna bryter igenom — febern och gnället",
            summary: "Vår åttamånaders har 38,5 i feber och är gnällig sedan tre dagar. Vi ser en liten knöl i underkäken. Barnmorskan sa att tänder inte ger feber, men det verkar uppenbart att något händer. Vad är er erfarenhet?",
            category: .utvecklingMilstolpar,
            reactionsCount: 167,
            sourceURL: nil
        ),
        ForumThread(
            id: "rel-008",
            title: "Tillbaka till jobbet — skulden och lättnaden",
            summary: "Jag kände mig skyldig över att vara lättad när föräldraledigheten tog slut. Nu har jag jobbat en månad och märker att jag är en bättre förälder på kvällarna när jag haft en dag för mig själv. Är det acceptabelt att känna så?",
            category: .relationForaldraskap,
            reactionsCount: 356,
            sourceURL: nil
        ),
        ForumThread(
            id: "forl-006",
            title: "Förlossningstrauma — hur och när sökte ni hjälp?",
            summary: "Min förlossning var tekniskt sett okej men jag mår inte bra. Mardrömmar, undviker att tala om det, panik när någon berättar om sin förlossning. Är det PTSD och var vänder man sig i Sverige för detta specifikt?",
            category: .forlossning,
            reactionsCount: 423,
            sourceURL: nil
        ),
        ForumThread(
            id: "nyf-007",
            title: "Varför gråter hen — har ni hittat ett system för att förstå?",
            summary: "Tre veckors bebis och vi försöker fortfarande lista ut hungergråt kontra trötthetsgråt kontra magont. Dunstan babys metod — funkar den verkligen eller är det önsketänkande? Hur lärde ni er att förstå just ert barn?",
            category: .nyfodda,
            reactionsCount: 276,
            sourceURL: nil
        ),
    ]

    static func threads(for category: ForumCategory) -> [ForumThread] {
        threads.filter { $0.category == category }
    }
}
