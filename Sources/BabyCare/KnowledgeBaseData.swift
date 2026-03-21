import SwiftUI

// MARK: - Article Category
enum ArticleCategory: String, CaseIterable {
    case fertility = "Fertilitet"
    case pregnancy = "Graviditet"
    case sleep = "Sömn"
    case feeding = "Matning"
    case growth = "Tillväxt"
    case health = "Hälsa"
    case development = "Utveckling"
    case parentHealth = "Föräldrahälsa"

    var icon: String {
        switch self {
        case .fertility: return "heart.circle.fill"
        case .pregnancy: return "heart.fill"
        case .sleep: return "moon.stars.fill"
        case .feeding: return "drop.fill"
        case .growth: return "chart.line.uptrend.xyaxis"
        case .health: return "cross.case.fill"
        case .development: return "star.fill"
        case .parentHealth: return "figure.2.arms.open"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .fertility:
            return LinearGradient(colors: [Color(hex: "D81B60"), Color(hex: "F06292")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .pregnancy:
            return LinearGradient(colors: [Color(hex: "C2185B"), Color(hex: "E91E8C")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sleep:
            return LinearGradient(colors: [Color(hex: "4A3F8F"), Color(hex: "7B6FBF")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .feeding:
            return LinearGradient(colors: [Color(hex: "2E7D9F"), Color(hex: "5BACC8")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .growth:
            return LinearGradient(colors: [Color(hex: "2E7D32"), Color(hex: "66BB6A")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .health:
            return LinearGradient(colors: [Color(hex: "E65100"), Color(hex: "FF8A50")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .development:
            return LinearGradient(colors: [Color(hex: "7B1FA2"), Color(hex: "CE93D8")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .parentHealth:
            return LinearGradient(colors: [Color(hex: "00695C"), Color(hex: "4DB6AC")], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var color: Color {
        switch self {
        case .fertility: return Color(hex: "D81B60")
        case .pregnancy: return Color(hex: "C2185B")
        case .sleep: return Color(hex: "4A3F8F")
        case .feeding: return Color(hex: "2E7D9F")
        case .growth: return Color(hex: "2E7D32")
        case .health: return Color(hex: "E65100")
        case .development: return Color(hex: "7B1FA2")
        case .parentHealth: return Color(hex: "00695C")
        }
    }
}

// MARK: - Article Models
struct Article: Identifiable {
    let id: String
    let category: ArticleCategory
    let title: String
    let subtitle: String
    let icon: String
    let readTimeMinutes: Int
    let intro: String
    let sections: [ArticleSection]
    let forumSection: ArticleForumSection
    let sources: [String]

    var forumSections: [ArticleForumSection] {
        [forumSection]
    }
}

struct ArticleSection {
    let heading: String
    let body: String
}

struct ArticleForumSection {
    let intro: String
    let consensus: String
    let quotes: [String]
    let source: String
}


// MARK: - All Articles
extension Article {
    static let _allOriginal: [Article] = [

        // =====================================================================
        // MARK: FERTILITET (5 articles)
        // =====================================================================

        // MARK: Article 1 – Menscykeln och fertilitet
        Article(
            id: "fertility_cycle",
            category: .fertility,
            title: "Menscykeln och fertilitet",
            subtitle: "Förstå din kropp och dina fertila dagar",
            icon: "calendar.circle.fill",
            readTimeMinutes: 7,
            intro: "Att förstå menscykeln är grunden för att kunna planera en graviditet. Trots att de flesta kvinnor har haft mens i decennier finns det förvånansvärt mycket som aldrig lärs ut om hur cykeln faktiskt fungerar, vilka hormoner som styr den och hur du kan använda den kunskapen för att maximera dina chanser att bli gravid. Den här guiden ger dig en evidensbaserad genomgång av menscykelns faser och hur de påverkar din fertilitet.",
            sections: [
                ArticleSection(
                    heading: "Menscykelns fyra faser",
                    body: """
Menscykeln delas in i fyra huvudfaser: menstruationsfasen, follikelfasen, ägglossningsfasen och lutealfasen. En genomsnittlig cykel är 28 dagar, men normala cykler kan variera mellan 21 och 35 dagar. Variationen sitter nästan uteslutande i follikelfasen, den period som leder fram till ägglossningen. Lutealfasen, tiden efter ägglossningen, är däremot relativt konstant och varar typiskt 12-16 dagar.

Under menstruationsfasen (dag 1-5) stöts livmoderslemhinnan ut som mensblödning. Samtidigt börjar hypofysen utsöndra follikelstimulerande hormon (FSH), som signalerar till äggstockarna att börja mogna nya äggfolliklar. Vanligtvis mognar 15-20 folliklar, men bara en blir dominant och släpper ett ägg.

Follikelfasen (dag 1-13) överlappar med menstruationen och är den fas då östrogennivåerna stiger gradvis. Östrogen tjocknar livmoderslemhinnan och förbereder den för en eventuell implantation. Cervixslemmet förändras under denna fas, från tjockt och klibbigt till allt mer genomskinligt och töjbart, vilket underlättar spermiernas transport.

Lutealfasen (dag 15-28) domineras av progesteron, som produceras av gulkroppen (corpus luteum) efter ägglossningen. Progesteron förbereder livmoderslemhinnan för implantation och höjer kroppstemperaturen med 0,2-0,5 grader. Om befruktning inte sker bryts gulkroppen ner, progesteronnivån sjunker, och en ny mens börjar.
"""
                ),
                ArticleSection(
                    heading: "Det fertila fönstret",
                    body: """
Det fertila fönstret är den period under menscykeln då samlag kan leda till graviditet. Det omfattar ungefär 6 dagar: de 5 dagarna före ägglossningen plus ägglossningsdagen. Anledningen till detta tidsspann är att spermier kan överleva i livmodern och äggledarna i upp till 5 dagar under gynnsamma förhållanden, medan ägget bara är befruktningsbart i 12-24 timmar efter ägglossningen.

Forskning visar att den högsta befruktningschansen uppstår vid samlag 1-2 dagar före ägglossningen, inte på själva ägglossningsdagen. Det beror på att spermierna behöver tid att nå äggledaren och genomgå kapacitation, en mognadsprocess som gör dem redo att befrukta ägget.

Vid en typisk 28-dagarscykel inträffar ägglossningen runt dag 14, vilket innebär att det fertila fönstret sträcker sig från ungefär dag 9 till dag 14. Men eftersom många kvinnor har oregelbundna cykler är det viktigt att lära sig känna igen de fysiska tecknen på ägglossning snarare än att förlita sig enbart på kalendern.

Studier från Wilcox et al. (1995) visar att sannolikheten för befruktning vid ett enda samlag under det fertila fönstret är ungefär 25-30 % per cykel hos friska par. Det innebär att det är helt normalt att det tar flera månader att bli gravid, även om allt fungerar som det ska.
"""
                ),
                ArticleSection(
                    heading: "Faktorer som påverkar cykeln och fertiliteten",
                    body: """
Stress är en av de vanligaste orsakerna till oregelbundna cykler. Kronisk stress höjer kortisolnivåerna, vilket kan störa hypotalamus-hypofys-gonad-axeln och förskjuta eller helt undertrycka ägglossningen. Det innebär att en stressig period kan leda till en längre cykel eller utebliven ägglossning, utan att det finns en bakomliggande medicinsk orsak.

Kroppsvikt spelar en viktig roll. Både undervikt (BMI under 18,5) och kraftig övervikt (BMI över 35) kan påverka ägglossningen negativt. Fettvävnad producerar östrogen, och för lite eller för mycket kan störa den hormonella balansen. En viktnedgång på bara 5-10 % hos överviktiga kvinnor med anovulation kan återställa ägglossningen i många fall.

Ålder är den enskilt starkaste faktorn för kvinnlig fertilitet. Vid 30 års ålder är den månatliga befruktningschansen ungefär 20 %, vid 35 sjunker den till 15 % och vid 40 till 5 %. Det beror dels på att antalet ägg minskar (en kvinna föds med alla ägg hon kommer ha), dels på att äggkvaliteten sjunker med åldern, vilket ökar risken för kromosomavvikelser.

Hormonella preventivmedel påverkar inte fertiliteten långsiktigt. Forskning visar att de flesta kvinnor återfår normal ägglossning inom 1-3 månader efter att ha slutat med p-piller, och att det inte finns någon ökad risk för infertilitet efter långvarig användning.
"""
                ),
                ArticleSection(
                    heading: "Polycystiskt ovariesyndrom och endometrios",
                    body: """
Polycystiskt ovariesyndrom (PCOS) är den vanligaste orsaken till anovulation och drabbar uppskattningsvis 8-13 % av kvinnor i fertil ålder. PCOS kännetecknas av oregelbundna eller uteblivna menstruationer, förhöjda androgennivåer (som kan ge akne och ökad behåring) och polycystiska äggstockar på ultraljud. Diagnos ställs när minst två av tre kriterier är uppfyllda (Rotterdam-kriterierna).

PCOS innebär inte att du inte kan bli gravid, men det kan ta längre tid. Behandling inkluderar livsstilsförändringar (viktnedgång vid övervikt, motion), läkemedel som stimulerar ägglossning (letrozol eller klomifen), och i mer komplicerade fall IVF. Metformin används ibland som komplement, särskilt vid insulinresistens.

Endometrios drabbar ungefär 10 % av kvinnor i fertil ålder och innebär att vävnad som liknar livmoderslemhinnan växer utanför livmodern, ofta på äggstockar, äggledare och bukhinnan. Det kan orsaka svår menssmärta, kronisk bäckensmärta och nedsatt fertilitet. Ungefär 30-50 % av kvinnor med endometrios har svårare att bli gravida.

Vid endometrios beror fertilitetsnedsättningen på flera faktorer: inflammation i bäckenet stör äggets transport, endometrioscystor på äggstockarna kan påverka äggkvaliteten, och sammanväxningar kan blockera äggledarna. Kirurgisk behandling (laparoskopi) kan i vissa fall förbättra fertiliteten, och IVF är ett effektivt alternativ.
"""
                ),
                ArticleSection(
                    heading: "När ska du söka hjälp?",
                    body: """
Allmänna riktlinjer för när du bör kontakta vården för fertilitetsutredning: om du är under 35 år och har försökt bli gravid i 12 månader utan resultat, eller om du är 35 år eller äldre och har försökt i 6 månader. Det finns dock skäl att söka tidigare om du har oregelbundna eller uteblivna menstruationer, känd endometrios eller PCOS, genomgått behandling för cancer, eller har en partner med kända fertilitetsproblem.

I Sverige kan du börja med att kontakta din barnmorska eller gynekolog. En grundläggande utredning inkluderar hormonprover (FSH, LH, AMH, prolaktin, sköldkörtelhormoner), ultraljud av äggstockar och livmoder, samt spermaanalys för partnern. AMH (anti-Mullerskt hormon) ger en uppskattning av äggstocksreserven men säger inget om äggkvaliteten.

Det är viktigt att komma ihåg att fertilitetsutredning inte är ett misslyckande. Ungefär 15 % av alla par upplever svårigheter att bli gravida, och i de flesta fall finns behandlingsalternativ som ger goda chanser till graviditet.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Kvinnor i svenska forum delar om menscykeln och fertilitet:",
                consensus: "De flesta som delar erfarenheter betonar att det tar längre tid än man tror att bli gravid, och att stress kring försöken paradoxalt nog kan försvåra det ytterligare. Att lära sig sin cykel beskrivs som både empowerande och ibland stressande.",
                quotes: [
                    "– Hade aldrig tänkt på att ägglossningen inte alltid sker dag 14. Min cykel var 32 dagar, så jag missade mitt fertila fönster i månader innan jag förstod det. Började spåra med app och OPK och blev gravid tredje cykeln.",
                    "– Det ingen berättar: att det är helt normalt att det tar 6-12 månader. Vi trodde något var fel efter 3 månader. Läkaren sa 'fortsätt försöka' och efter 8 månader var testet positivt.",
                    "– PCOS-diagnosen var tuff att få men också en lättnad. Äntligen en förklaring till varför mensen var så oregelbunden. Med letrozol fick jag ägglossning och blev gravid inom fyra cykler."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Wilcox AJ et al. (1995). Timing of sexual intercourse in relation to ovulation. NEJM, 333(23):1517-1521.",
                "ESHRE: Recommendations for the management of women with PCOS (2018).",
                "1177 Vårdguiden: Menscykeln och fertilitet (2023).",
                "Practice Committee of ASRM: Optimizing natural fertility (2022)."
            ]
        ),

        // MARK: Article 2 – Ägglossning
        Article(
            id: "fertility_ovulation",
            category: .fertility,
            title: "Ägglossning – tecken och spårning",
            subtitle: "Lär dig känna igen din ägglossning",
            icon: "waveform.path.ecg.rectangle",
            readTimeMinutes: 6,
            intro: "Att identifiera sin ägglossning är det mest effektiva sättet att öka chanserna att bli gravid. Det finns flera pålitliga metoder för att spåra ägglossningen, från enkla observationer av kroppens signaler till digitala verktyg och tester. Här går vi igenom de vetenskapligt stödda metoderna och hur du kombinerar dem för bäst resultat.",
            sections: [
                ArticleSection(
                    heading: "Cervixslem – kroppens tydligaste signal",
                    body: """
Cervixslemmet genomgår förutsägbara förändringar under menscykeln som speglar östrogennivåerna. Direkt efter mens är slemmet ofta sparsamt och klibbigt. I takt med att östrogennivåerna stiger under follikelfasen blir slemmet gradvis mer genomskinligt, fuktigt och töjbart. Strax före och under ägglossningen liknar det äggvita: klart, elastiskt och kan dras ut i långa trådar mellan fingrarna.

Detta äggvitelika slem har en specifik funktion: det skapar kanaler som hjälper spermierna att simma genom livmoderhalsen och upp i äggledarna. Utan detta slem har spermierna mycket svårt att ta sig igenom. Forskning visar att samlag under dagar med äggvitelikt slem ger den högsta befruktningschansen, oavsett vad ägglossningstest visar.

Efter ägglossningen, under progesterondominansen, blir slemmet åter tjockt, grumligt och klibbigt, eller försvinner helt. Denna övergång bekräftar att ägglossningen har skett. Att lära sig observera sitt cervixslem tar vanligtvis 2-3 cykler men ger sedan en pålitlig och kostnadsfri metod för att identifiera det fertila fönstret.

Billings-metoden, som bygger på cervixslemsobservation, har i studier visat en effektivitet på 97-99 % för att identifiera det fertila fönstret. Men det kräver konsekvent daglig observation och viss övning att tolka.
"""
                ),
                ArticleSection(
                    heading: "Basaltemperaturmätning",
                    body: """
Basaltemperaturen (BBT) är din kroppstemperatur vid vila, mätt direkt vid uppvaknande innan du stiger ur sängen. Efter ägglossningen producerar gulkroppen progesteron, som höjer basaltemperaturen med 0,2-0,5 grader Celsius. Denna höjning kvarstår under hela lutealfasen och sjunker igen när mens börjar, eller förblir förhöjd vid graviditet.

Metoden kräver att du mäter vid samma tid varje morgon, helst efter minst 3 timmars sammanhängande sömn, med en termometer som visar minst en decimal (gärna en specialdesignad BBT-termometer). Du för in temperaturerna i en kurva, antingen manuellt eller via en app.

Begränsningen med BBT är att den bara bekräftar att ägglossning redan har skett, inte att den snart ska ske. Det innebär att du använder BBT för att lära dig ditt mönster över flera cykler och sedan planera framåt baserat på det. I kombination med cervixslemsobservation eller OPK-tester blir metoden mycket mer användbar.

Moderna BBT-apparater och bärbara sensorer som mäter temperaturen kontinuerligt under natten ger mer exakta data än enstaka morgonmätningar och kan förutsäga ägglossningen med högre precision. Studier visar att sensorbaserad BBT har en noggrannhet på över 90 % för att detektera ägglossningsdagen.
"""
                ),
                ArticleSection(
                    heading: "Ägglossningstest (OPK)",
                    body: """
Ägglossningstest, eller OPK (Ovulation Predictor Kit), mäter nivån av luteiniserande hormon (LH) i urinen. LH stiger kraftigt 24-36 timmar före ägglossningen i den så kallade LH-toppen. När testet visar positivt resultat vet du att ägglossningen sannolikt kommer ske inom 1-2 dagar.

Standardtester visar ett positivt resultat som en testlinje som är lika mörk eller mörkare än kontrolllinjen. Digitala test visar en smiley eller liknande symbol och eliminerar tolkningsproblematiken. Det finns även avancerade digitala tester som mäter både östrogen och LH, och kan identifiera fler fertila dagar.

Bästa tiden att testa är på eftermiddagen (14-18), eftersom LH-toppen ofta inträffar tidigt på morgonen och inte alltid hunnit nå urinen vid morgonmiktionen. Undvik att dricka stora mängder vätska 2 timmar innan testet för att inte späda ut urinen.

OPK fungerar bäst i kombination med andra metoder. En kvinna med PCOS kan ha förhöjda LH-nivåer basalt, vilket kan ge falskt positiva resultat. I dessa fall kan cervixslemsobservation vara en mer tillförlitlig metod.
"""
                ),
                ArticleSection(
                    heading: "Appar och digital spårning",
                    body: """
Fertilitetsappar som Natural Cycles, Clue och Flo använder algoritmer baserade på basaltemperatur, cervixslemsobservation och/eller hormondata för att förutsäga ägglossningen. Natural Cycles är den enda appen som är CE-märkt som preventivmedel (och därmed också som fertilitetshjälpmedel) i EU.

Forskning visar att appar som enbart baseras på kalenderprediktioner, utan temperatur eller hormondata, har dålig precision. Ägglossningen kan variera med flera dagar från cykel till cykel, och en app som bara räknar dagar kan missa det fertila fönstret.

De mest effektiva apparna kombinerar flera datakällor: temperatur, slem, OPK-resultat och cykelhistorik. Ju fler cykler med data du matar in, desto bättre blir prediktionerna. Men det är viktigt att komma ihåg att ingen app kan garantera exakt ägglossningsdag.

Fertilitetskliniker och barnmorskor i Sverige rekommenderar ofta att patienter börjar med cervixslemsobservation och OPK-tester som grundmetoder och lägger till appar som ett komplement, inte en ersättning.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Kvinnor som spårar sin ägglossning delar i forum:",
                consensus: "Kombinationen av cervixslem och ägglossningstest ger bäst resultat. Många beskriver att de lärde sig mer om sin kropp under graviditetsförsöken än under hela sin uppväxt, och att kunskapen var värdefull oavsett utfall.",
                quotes: [
                    "– Billiga OPK-stickor från nätet plus att lära mig se skillnad på cervixslem. Blev gravid andra cykeln efter att jag börjat spåra ordentligt. Hade försökt i 6 månader innan utan spårning.",
                    "– Natural Cycles var perfekt för mig som vill ha allt i en app. Men det tog 3 cykler innan algoritmen blev pålitlig.",
                    "– Lärde mig att min ägglossning var dag 18, inte dag 14 som alla appar antog. Cervixslemmet avslöjade det direkt."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Stanford JB et al. (2002). Timing intercourse to achieve pregnancy. Obstetrics & Gynecology, 100(6):1333-1341.",
                "Su HW et al. (2017). Detection of ovulation, a review of currently available methods. Bioeng Transl Med, 2(3):238-246.",
                "Berglund Scherwitzl E et al. (2017). Identification and prediction of the fertile window with Natural Cycles. Eur J Contracept Reprod Health Care."
            ]
        ),

        // MARK: Article 3 – Tips för att bli gravid
        Article(
            id: "fertility_tips",
            category: .fertility,
            title: "Tips för att öka chansen att bli gravid",
            subtitle: "Evidensbaserade råd för båda parter",
            icon: "sparkles",
            readTimeMinutes: 6,
            intro: "När du bestämt dig för att försöka bli gravid finns det flera evidensbaserade steg du kan ta för att maximera dina chanser. Det handlar inte bara om timing, utan också om livsstilsfaktorer som påverkar både ägg- och spermiekvalitet. Den här guiden fokuserar på vad forskningen faktiskt visar, bortom alla myter och anekdoter.",
            sections: [
                ArticleSection(
                    heading: "Timing och frekvens",
                    body: """
Den mest effektiva strategin för timing är att ha samlag varannan dag under det fertila fönstret, det vill säga ungefär dag 10-16 vid en 28-dagars cykel. Forskning visar att dagligt samlag bara ger en marginellt högre befruktningschans jämfört med varannan dag, men kan leda till onödig press och stress.

Det finns ingen vetenskaplig grund för att specifika positioner ökar chansen att bli gravid. Så länge ejakulationen sker i vaginan har positionen ingen dokumenterad betydelse. Att ligga kvar efter samlaget i 15-20 minuter kan möjligtvis vara till nytta, men evidensen är svag.

Glidmedel kan påverka spermiernas rörlighet negativt. Standardglidmedel innehåller ämnen som är toxiska för spermier. Om glidmedel behövs, välj fertilitetsvänliga alternativ som Pre-Seed eller liknande produkter som har testats och godkänts för att inte skada spermier.

Att försöka bli gravid ska helst inte bli ett stressigt projekt. Forskning visar att par som upplever hög stress under fertilitetsförsöken har lägre befruktningschanser. Att ha samlag för nöjets skull, inte bara för reproduktion, kan paradoxalt nog öka chanserna.
"""
                ),
                ArticleSection(
                    heading: "Kost och kosttillskott",
                    body: """
Folsyra (400 mikrogram dagligen) bör påbörjas minst en månad före planerad befruktning och fortsätta under hela första trimestern. Folsyra minskar risken för neuralrörsdefekter med upp till 70 %. Det är det enda kosttillskottet med stark evidens för alla som försöker bli gravida.

En Medelhavsinspirerad kost med rikligt av grönsaker, frukt, fullkorn, baljväxter, fisk och olivolja har i studier kopplats till bättre fertilitet hos både män och kvinnor. Forskare tror att det beror på den höga halten antioxidanter och antiinflammatoriska ämnen som skyddar ägg och spermier från oxidativ stress.

D-vitamin bör supplementeras, särskilt i Sverige med begränsad solexponering. Studier visar att D-vitaminbrist kan vara kopplat till sämre IVF-resultat och längre tid till befruktning. Rekommenderad dos är 10-20 mikrogram dagligen.

Koenzym Q10 (CoQ10) har lovande men begränsad evidens för att förbättra äggkvaliteten, särskilt hos kvinnor över 35. Dosen i studier är vanligtvis 400-600 mg dagligen. Det är ett antioxidativt tillskott som är säkert men dyrt, och bör ses som ett komplement, inte ett undermedel.
"""
                ),
                ArticleSection(
                    heading: "Livsstilsfaktorer som påverkar",
                    body: """
Rökning minskar fertiliteten dramatiskt hos både män och kvinnor. Hos kvinnor påverkar rökning äggkvaliteten, äggstocksreserven och livmoderslemhinnans mottaglighet. Hos män sänker rökning spermakoncentrationen med 20-30 % och ökar DNA-skador i spermierna. Att sluta röka är den enskilt viktigaste livsstilsförändringen för fertilitet.

Alkohol bör begränsas. Forskning visar att mer än 7 enheter per vecka hos kvinnor och mer än 14 enheter hos män kan försämra fertiliteten. Många fertilitetsexperter rekommenderar nolltolerans för alkohol under aktiva försök, men evidensen för att total avhållsamhet behövs är inte lika stark.

Koffein i måttliga mängder (under 200 mg per dag, motsvarande 2 koppar kaffe) har inte visats påverka fertiliteten negativt. Men högt koffeinintag (över 500 mg dagligen) kan vara kopplat till sämre befruktningschanser.

Fysisk aktivitet i måttlig mängd förbättrar fertiliteten. Däremot kan extremt intensiv träning (som maratonlöpning eller tung styrketräning) störa ägglossningen hos kvinnor genom att sänka östrogenproduktionen. En balanserad träningsrutin med 150-300 minuter måttlig aktivitet per vecka är optimalt.

Testikeltemperatur påverkar spermieproduktionen. Täta underkläder, långvarigt sittande, varma bad och datoranvändning i knäet höjer testikeltemperaturen och kan temporärt minska spermieproduktionen. Spermier tar 72 dagar att produceras, så förändringar idag ger effekt först efter 2-3 månader.
"""
                ),
                ArticleSection(
                    heading: "Manlig fertilitet – den bortglömda halvan",
                    body: """
I ungefär 40-50 % av alla fall av infertilitet bidrar manlig faktor helt eller delvis. Trots detta fokuserar samhället och vården oproportionerligt på kvinnans kropp. En spermaanalys bör göras tidigt i utredningen, inte som sista utväg.

En spermaanalys mäter volym, koncentration, rörlighet och morfologi. Normala WHO-referensvärden: koncentration minst 15 miljoner/ml, total rörlighet minst 40 %, progressiv rörlighet minst 32 %, och normal morfologi minst 4 %. Men dessa är minimivärden, inte optimala värden.

Livsstilsförändringar som förbättrar spermiekvaliteten inkluderar viktnedgång vid övervikt, rökstopp, reducerat alkoholintag, zink- och selentillskott (studier visar positiva effekter), regelbunden men inte excessiv motion, och stressreduktion.

Läkemedel som kan påverka spermiekvaliteten: testosteron (paradoxalt nog stänger det ner egen produktion och kan orsaka azoospermi), anabola steroider, vissa antidepressiva (SSRI), och långvarig NSAID-användning. Om din partner tar dessa, kontakta läkare för diskussion.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Par som försöker bli gravida delar i forum:",
                consensus: "De flesta vittnar om att de första tre månaderna ofta är fyllda av optimism, medan det efter 6 månader kan börja gnaga. Att inte göra graviditetsförsöken till hela ens identitet, och att behålla glädje i relationen, framhålls som avgörande.",
                quotes: [
                    "– Vi försökte i 9 månader. Det som till slut funkade: sluta stressa, ha sex för att det är kul, och OPK-stickor. Inte mer komplicerat än så.",
                    "– Min man vägrade göra spermaanalys i 8 månader. 'Det är säkert inte jag.' Jo, det var delvis det. Dålig rörlighet. Tillskott och livsstilsförändringar i 3 månader och sedan blev vi gravida.",
                    "– Folsyra, D-vitamin, sluta röka, börja promenera. Det var allt min barnmorska sa. Ibland är de enkla sakerna de viktigaste."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Practice Committee of ASRM (2022). Optimizing natural fertility: a committee opinion. Fertility and Sterility.",
                "Gaskins AJ et al. (2019). Diet and fertility: a review. Am J Obstet Gynecol.",
                "Sharma R et al. (2013). Lifestyle factors and reproductive health. Reproductive Biology and Endocrinology, 11:66.",
                "WHO Laboratory Manual for the Examination of Human Semen (6th ed., 2021)."
            ]
        ),

        // MARK: Article 4 – Fertilitetsutredning
        Article(
            id: "fertility_investigation",
            category: .fertility,
            title: "När ska man söka hjälp?",
            subtitle: "Fertilitetsutredning i Sverige – steg för steg",
            icon: "stethoscope",
            readTimeMinutes: 6,
            intro: "Att ta steget från att försöka på egen hand till att söka medicinsk hjälp för att bli gravid kan kännas stort. Men fertilitetsutredning är ett väldefinierat, stegvist förlopp som i Sverige är tillgängligt inom den offentliga vården. Här går vi igenom vad du kan förvänta dig, vilka undersökningar som görs och vad resultaten innebär.",
            sections: [
                ArticleSection(
                    heading: "När är det dags att söka?",
                    body: """
De generella riktlinjerna i Sverige är tydliga: om du är under 35 år och har haft regelbundna samlag utan preventivmedel i 12 månader utan att bli gravid, bör du söka utredning. Om du är 35 år eller äldre kortas gränsen till 6 månader. Dessa gränser är inte absoluta och det finns situationer där du bör söka tidigare.

Sök tidigare om du har oregelbundna eller uteblivna menstruationer (kan tyda på anovulation), känd endometrios eller PCOS, genomgått kemoterapi eller strålning mot bäckenområdet, haft upprepade missfall (2 eller fler), har en partner med kända problem som obehandlat kryptorkism, eller om du har haft könssjukdomar som kan ha orsakat skada på äggledarna (till exempel klamydia).

Första steget är att kontakta din barnmorska på barnmorskemottagningen eller din gynekolog. De gör en initial bedömning och kan starta grundläggande undersökningar innan eventuell remiss till fertilitetsklinik. I en del regioner kan du som patient även kontakta fertilitetskliniken direkt.

Det är viktigt att komma ihåg att utredningen gäller båda parter. Manlig infertilitet bidrar i ungefär hälften av fallen, och en spermaanalys bör göras tidigt i processen. Tyvärr upplever många par att mannens utredning prioriteras ned, vilket fördröjer diagnos och behandling.
"""
                ),
                ArticleSection(
                    heading: "Undersökningar för kvinnan",
                    body: """
Hormonprover utgör grunden i den kvinnliga utredningen. Dessa inkluderar FSH och LH (mäts dag 2-5 i cykeln och ger information om äggstocksfunktionen), AMH (anti-Müllerskt hormon, kan tas vilken dag som helst och ger en uppskattning av äggstocksreserven), progesteron (mäts i mitten av lutealfasen för att bekräfta ägglossning), TSH (sköldkörtelhormoner, då avvikande sköldkörtelfunktion kan påverka fertiliteten), och prolaktin (förhöjda nivåer kan störa ägglossningen).

Vaginalt ultraljud ger en bild av livmoderns form och storlek, eventuella myom eller polyper, samt äggstockarnas utseende, inklusive antalet antrala folliklar (AFC). AFC och AMH tillsammans ger den bästa uppskattningen av äggstocksreserven.

HSG (hysterosalpingografi) eller HyCoSy (ultraljudsbaserad kontrastundersökning av äggledarna) bedömer om äggledarna är öppna. Blockerade äggledare hindrar spermier och ägg från att mötas och är en vanlig orsak till infertilitet, särskilt hos kvinnor med tidigare könssjukdomar eller bäckeninfektioner.

Diagnostisk laparoskopi (titthålskirurgi) görs ibland vid misstanke om endometrios eller sammanväxningar som inte syns på ultraljud. Det är en dagkirurgisk åtgärd under narkos.
"""
                ),
                ArticleSection(
                    heading: "Undersökningar för mannen",
                    body: """
Spermaanalys är det centrala provet i den manliga utredningen. Den analyserar volym, koncentration, rörlighet och morfologi (form). Provet bör lämnas efter 2-5 dagars avhållsamhet och analyseras inom en timme efter provtagning. Om det första provet är avvikande görs alltid ett uppföljande prov efter minst 6-8 veckor, eftersom spermiekvaliteten kan variera.

Hormonprover (testosteron, FSH, LH, prolaktin) kan tas om spermaanalysen visar avvikelser. Lågt FSH i kombination med låg spermiekoncentration kan tyda på hypogonadotrop hypogonadism, medan högt FSH tyder på primär testikeldysfunktion.

Ultraljud av testiklarna kan avslöja varicocele (åderbråck i pungen), som är den vanligaste korrigerbara orsaken till manlig infertilitet och förekommer hos 15-20 % av alla män men hos 40 % av infertila män.

Genetisk utredning kan bli aktuell vid svårt nedsatt spermieproduktion. Y-kromosomsdeletioner och Klinefelters syndrom (47,XXY) är bland de vanligaste genetiska orsakerna till manlig infertilitet.
"""
                ),
                ArticleSection(
                    heading: "Resultat och nästa steg",
                    body: """
Utredningsresultaten delas vanligtvis in i förklarad och oförklarad infertilitet. Oförklarad infertilitet, där inga avvikelser hittas, utgör ungefär 25-30 % av fallen. Det innebär inte att det inte finns en orsak, utan att den inte kan identifieras med nuvarande metoder.

Behandlingsalternativen beror på diagnosen. Anovulation behandlas ofta med ägglossningsstimulerande läkemedel (letrozol eller klomifen). Blockerade äggledare kräver vanligtvis IVF. Lätt nedsatt spermiekvalitet kan ibland behandlas med insemination (IUI), medan svårt nedsatt spermiekvalitet kräver IVF med ICSI (intracytoplasmatisk spermieinjektion).

I Sverige har alla kvinnor under 40 år rätt till offentligt finansierade IVF-behandlingar om de uppfyller regionens kriterier. Antalet subventionerade cykler varierar mellan regioner, men vanligtvis erbjuds 3 fulla cykler. BMI-gränser kan gälla, och behandlingen förutsätter att kvinnan inte röker.

Väntetiderna till fertilitetskliniker varierar kraftigt i Sverige, från veckor till över ett år beroende på region. Det kan vara värt att ställa sig i kö tidigt, även parallellt med egna försök.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Par som genomgått fertilitetsutredning delar i forum:",
                consensus: "Det råd som återkommer oftast är att inte vänta för länge med att söka hjälp, särskilt om man är över 30. Många önskar att de hade sökt tidigare och betonar att utredningen i sig inte behöver vara stressig eller smärtsam.",
                quotes: [
                    "– Tuffaste var väntetiden till kliniken. 7 månader i vår region. Hade jag vetat det hade jag sökt remiss direkt efter 6 månaders försök.",
                    "– HSG-undersökningen avslöjade att min ena äggledarvar blockserad. Utan den undersökningen hade vi kunnat fortsätta försöka i år utan resultat.",
                    "– Min man var rädd för spermaanalysen men sa efteråt att det var enklare än att lämna blodprov. Det visade sig att han hade varicocele. Operation och 6 månader senare var jag gravid."
                ],
                source: "Källa: Familjeliv.se, Fertilitetsguiden.se"
            ),
            sources: [
                "Socialstyrelsen: Nationella riktlinjer för ofrivillig barnlöshet (2018).",
                "NICE: Fertility problems – assessment and treatment (2017, updated 2023).",
                "ESHRE: Guideline on the management of infertile couples (2023).",
                "1177 Vårdguiden: Utredning vid svårt att bli gravid (2023)."
            ]
        ),

        // MARK: Article 5 – IVF och fertilitetsbehandling
        Article(
            id: "fertility_ivf",
            category: .fertility,
            title: "IVF och fertilitetsbehandling i Sverige",
            subtitle: "Vad du kan förvänta dig – från hormonbehandling till embryoåterföring",
            icon: "syringe.fill",
            readTimeMinutes: 7,
            intro: "IVF (in vitro-fertilisering) har hjälpt miljontals par världen över att bli föräldrar sedan Louise Brown, världens första IVF-barn, föddes 1978. I Sverige utförs ungefär 20 000 IVF-cykler per år och tekniken blir ständigt bättre. Här går vi igenom hela processen, vad forskningen säger om framgångsfaktorer och hur du förbereder dig.",
            sections: [
                ArticleSection(
                    heading: "Hur fungerar IVF?",
                    body: """
IVF innebär att befruktningen sker utanför kroppen. Processen har flera steg: först stimuleras äggstockarna med hormoner för att mogna flera ägg samtidigt, sedan hämtas äggen ut via ultraljudsledd vaginalpunktion, äggen befruktas med spermier i laboratoriet, de befruktade äggen (embryona) odlas i 2-5 dagar, och slutligen förs ett embryo in i livmodern.

Hormonstimuleringen varar typiskt 9-14 dagar. Du ger dig själv dagliga injektioner med FSH (follikelstimulerande hormon), antingen ensamt eller i kombination med LH. Parallellt tar du eventuellt en GnRH-antagonist för att förhindra spontan ägglossning. Läkaren övervakar folliklartillväxten med regelbundna ultraljud och blodprover.

Ägguthämtningen är ett kort ingrepp (15-20 minuter) under sedering. En tunn nål förs genom slidväggen under ultraljudsvägledning och folliklarna punkteras. Äggen aspireras och överförs omedelbart till embryologen i laboratoriet. Du kan uppleva kramper och lätt blödning efteråt men kan vanligtvis gå hem samma dag.

Embryoåterföring (ET) är okomplicerad och kräver ingen narkos. Embryot förs in i livmodern via en tunn kateter genom livmoderhalsen. Proceduren tar bara några minuter. Efteråt väntar du ungefär 12-14 dagar på graviditetstest.
"""
                ),
                ArticleSection(
                    heading: "ICSI och andra tekniker",
                    body: """
ICSI (intracytoplasmatisk spermieinjektion) innebär att en enda spermie injiceras direkt in i ägget, istället för att spermierna själva ska befrukta ägget i en skål. ICSI används vid svårt nedsatt spermiekvalitet, tidigare misslyckad befruktning vid konventionell IVF, eller vid användning av kirurgiskt utvunna spermier. I Sverige utförs ICSI i ungefär 60-70 % av alla IVF-behandlingar.

Frysning av embryon (vitrifikation) har blivit standard och innebär att överskottande embryon av god kvalitet fryses för framtida användning. Moderna vitrifikationstekniker ger överlevnadsrater på över 95 %, och studier visar att frysta embryoåterföringar ger lika goda eller till och med bättre resultat än färska överföringar, delvis för att livmodern hunnit återhämta sig från hormonstimuleringen.

Preimplantatorisk genetisk testning (PGT) innebär att en eller flera celler från embryot biopseras och analyseras genetiskt innan det förs in i livmodern. PGT-A testar för kromosomavvikelser och kan öka chansen per transfer hos kvinnor med upprepade misslyckade behandlingar eller hög ålder.

Äggdonation och spermiedonation är tillgängligt i Sverige och regleras av lag. Sedan 2019 kan ensamstående kvinnor behandlas med donerade spermier inom den offentliga vården.
"""
                ),
                ArticleSection(
                    heading: "Framgångsfaktorer och realistiska förväntningar",
                    body: """
Ålder är den starkaste prediktorn för IVF-framgång. Chansen per cykel för klinisk graviditet är ungefär 40-45 % för kvinnor under 35, 30-35 % vid 35-37, 20-25 % vid 38-40, och 10-15 % vid 41-42. Över 42 år sjunker chansen till under 5 % med egna ägg.

Kumulativ chans efter flera cykler är väsentligt högre. Studier visar att 65-70 % av kvinnor under 40 uppnår graviditet inom 3 fullständiga IVF-cykler (inklusive frysta embryoåterföringar från samma cykel). Det innebär att det är klokt att inte döma framgångschanserna efter en enda cykel.

Livsstilsfaktorer som påverkar resultatet: BMI i normalintervallet (18,5-30), rökstopp (rökare har 50 % lägre chans vid IVF), måttligt alkoholintag, regelbunden men inte excessiv motion, och stressreduktion. DHEA och CoQ10 har viss evidens för att förbättra resultatet hos kvinnor med låg äggstocksreserv, men evidensen är inte tillräcklig för generella rekommendationer.

Det är normalt och vanligt att känna en berg-och-dalbana av hopp, rädsla, besvikelse och sorg under IVF-behandlingen. Psykologiskt stöd bör erbjudas som en integrerad del av behandlingen, och de flesta fertilitetskliniker har tillgång till kurator eller psykolog.
"""
                ),
                ArticleSection(
                    heading: "Kostnader och rättigheter i Sverige",
                    body: """
I den offentliga vården i Sverige subventioneras vanligtvis 3 fullständiga IVF-cykler (stimulerade cykler inklusive frysta embryoåterföringar) om du uppfyller regionens kriterier. Kriterierna varierar men inkluderar typiskt åldersgräns (vanligtvis under 40 år vid behandlingsstart), BMI-krav (vanligtvis under 35), och att ingen av partnerna har barn sedan tidigare (varierar mellan regioner).

Egenavgifterna vid offentligt finansierad IVF är vanligtvis begränsade till högkostnadsskyddet. Privat IVF kostar ungefär 30 000-50 000 kr per cykel, beroende på klinik och eventuella tillägg som PGT.

Väntetider varierar kraftigt mellan regioner. I storstadsregioner kan väntetiden vara 6-18 månader, medan den kan vara kortare i andra delar av landet. Att kontakta flera kliniker och ställa sig i kö parallellt kan vara klokt.

Sedan 2019 har ensamstående kvinnor rätt till assisterad befruktning inom den offentliga vården i Sverige. Samkönade par har haft denna rätt sedan 2005. Lagstiftningen kräver att barn som tillkommit genom donation har rätt att vid mogen ålder få information om donatorns identitet.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Par som genomgått IVF delar i forum:",
                consensus: "IVF beskrivs som en fysisk och emotionell utmaning, men de flesta som gått igenom det tycker att det var värt det. Det vanligaste rådet är att vara realistisk om att det kan ta flera cykler, och att inte skämmas för att behöva hjälp.",
                quotes: [
                    "– Tre cykler, två misslyckade, tredje gången satt det. Nu sover hon i min famn och allt var värt det. Ge inte upp efter en cykel.",
                    "– Hormonstimuleringen var jobbig fysiskt och emotionellt. Men själva ägguthämtningen var inte lika dramatisk som jag trott. God sedering och proffsig personal.",
                    "– Vi frös 5 embryon första cykeln. Första FET misslyckades, andra lyckades. Vår dotter föddes från ett fryst embryo och det känns fortfarande som ett mirakel."
                ],
                source: "Källa: Familjeliv.se, IVF-grupper Facebook"
            ),
            sources: [
                "Nationellt kvalitetsregister för assisterad befruktning (Q-IVF), Årsrapport 2023.",
                "ESHRE: ART fact sheet (2023). eshre.eu",
                "Riksdagen: Lag (2018:1283) om ändring i lagen om genetisk integritet m.m.",
                "Sundström P, Saldeen P. (2009). Cumulative delivery rates in IVF. Acta Obstetricia et Gynecologica Scandinavica."
            ]
        ),

        // =====================================================================
        // MARK: GRAVIDITET (5 articles)
        // =====================================================================

        // MARK: Article 6 – Graviditetsillamående
        Article(
            id: "pregnancy_nausea",
            category: .pregnancy,
            title: "Graviditetsillamående",
            subtitle: "Orsaker, lindring och när du bör söka vård",
            icon: "leaf.fill",
            readTimeMinutes: 7,
            intro: "Graviditetsillamående, ofta kallat morgonillamående trots att det kan pågå hela dagen, drabbar upp till 80 % av alla gravida. Det debuterar vanligtvis runt vecka 6 och avtar för de flesta runt vecka 12-14. Även om det sällan är farligt kan det kraftigt påverka livskvaliteten. I sällsynta fall utvecklas hyperemesis gravidarum, ett tillstånd som kräver medicinsk behandling. Här går vi igenom vad forskningen säger om orsaker och evidensbaserad lindring.",
            sections: [
                ArticleSection(
                    heading: "Varför blir man illamående under graviditeten?",
                    body: """
Den exakta orsaken till graviditetsillamående är inte helt klarlagd, men den mest vedertagna teorin pekar på hormonet hCG (humant koriongonadotropin). hCG-nivåerna stiger snabbt under första trimestern och kulminerar runt vecka 10-12, vilket sammanfaller med den period då illamåendet är som värst. Studier visar att kvinnor med högre hCG-nivåer, som vid tvillinggraviditeter, tenderar att ha svårare illamående.

Östrogen spelar sannolikt också en roll. De kraftigt stigande östrogennivåerna under tidig graviditet påverkar mag-tarmkanalen och det centrala nervsystemets kräkcentrum. Dessutom ökar luktsinnet dramatiskt under graviditeten, vilket kan trigga illamående vid lukter som tidigare inte var besvärande.

Evolutionära teorier föreslår att graviditetsillamående är en skyddsmekanism som utvecklats för att skydda embryot under den känsligaste perioden av organbildningen. Studier har visat att kvinnor med illamående har lägre risk för missfall, vilket stödjer denna teori. Illamåendet tenderar att riktas mot livsmedel som historiskt sett burit högre risk för toxiner och patogener, som kött och starka smaker.

Riskfaktorer för svårare illamående inkluderar tidigare graviditetsillamående, migrän, åksjuka, tvillinggraviditet, kvinnligt kön hos fostret, och genetisk predisposition. Om din mamma hade svårt illamående är sannolikheten högre att du också drabbas.
"""
                ),
                ArticleSection(
                    heading: "Evidensbaserade metoder för lindring",
                    body: """
Ingefära har det starkaste vetenskapliga stödet bland icke-farmakologiska behandlingar. En metaanalys av 12 randomiserade kontrollerade studier visade att ingefära signifikant minskar illamående under graviditeten. Rekommenderad dos är 1-1,5 gram per dag, fördelat på 3-4 doser, i form av ingefärskapsel, ingefärste eller kristalliserad ingefära.

Vitamin B6 (pyridoxin) i dosen 25 mg tre gånger dagligen har i studier visat sig minska illamående, men inte kräkningar. Det rekommenderas ofta som första behandling i internationella riktlinjer. I Sverige finns det receptfritt och kan kombineras med antihistaminer för bättre effekt.

Akupressur på P6-punkten (Nei-Guan), belägen tre fingerbredder ovanför handledsvecket på insidan av underarmen, har visat blandade resultat i studier men upplevs hjälpa av många gravida. Akupressurband (Sea-Band) finns att köpa på apotek och är helt riskfria att använda.

Kostrelaterade strategier med bra evidens: ät små, frekventa måltider (varannan till var tredje timme), undvik tom mage, ha kex vid sängen att äta innan du stiger upp, välj kalla rätter framför varma (ger mindre doftpåverkan), och undvik feta, kryddiga och starkt doftande livsmedel. Vätskeintaget bör fördelas jämnt över dagen, gärna i form av iskallt vatten eller is att suga på.
"""
                ),
                ArticleSection(
                    heading: "Läkemedelsbehandling",
                    body: """
Om icke-farmakologiska metoder inte räcker finns flera säkra läkemedelsalternativ. I Sverige rekommenderas i första hand meklozin (Postafen), ett antihistamin som är receptfritt och har en lång säkerhetsprofil under graviditet. Det kan orsaka dåsighet men är effektivt mot både illamående och kräkningar.

Metoklopramid (Primperan) och ondansetron (Zofran) kan förskrivas vid svårare besvär. Ondansetron är mycket effektivt men bör användas med viss försiktighet under första trimestern, då enstaka studier har antytt en marginellt ökad risk för läpp-käk-gomspalt. Trots detta bedöms nyttan oftast överväga risken vid svårt illamående.

Prometazin (Lergigan) är ett annat antihistamin som kan användas och som har fördelen att ge sömnighet, vilket kan vara välkommet om illamåendet stör nattsömnen. Kortisonbehandling (metylprednisolon) reserveras för de svåraste fallen av hyperemesis gravidarum och bör bara användas under kort tid.

Det är viktigt att inte lida i onödan. Många gravida undviker läkemedel av rädsla för fosterskador, men de rekommenderade preparaten har stor säkerhetsdokumentation. Att inte behandla svårt illamående kan i sig vara riskfullt på grund av uttorkning och näringsbrist.
"""
                ),
                ArticleSection(
                    heading: "Hyperemesis gravidarum – när det blir allvarligt",
                    body: """
Hyperemesis gravidarum (HG) drabbar 0,3-3 % av alla gravida och definieras som svåra, ihållande kräkningar som leder till viktnedgång (mer än 5 % av kroppsvikten), uttorkning och elektrolytrubbningar. Det är den vanligaste orsaken till sjukhusinläggning under första trimestern och kan vara extremt påfrestande fysiskt och psykiskt.

Symtom som bör föranleda kontakt med vården: oförmåga att behålla vätska i mer än 24 timmar, mörk och illaluktande urin, yrsel eller svimningskänsla, viktminskning, hjärtklappning, och blod i kräkningarna. Behandlingen på sjukhus inkluderar intravenös vätsketillförsel, elektrolytkorrektion, antiemetika intravenöst, och ibland parenteral nutrition.

HG har en stark genetisk komponent. Forskning publicerad i Nature Communications har identifierat specifika gener (GDF15 och IGFBP7) som är kopplade till risken att utveckla HG. Dessa gener kodar för proteiner som produceras av placentan och som verkar påverka hjärnans kräkcentrum.

Den psykologiska påverkan av HG underskattas ofta. Många drabbade beskriver känslan av att vara fångade i sin egen kropp, och depression under eller efter HG är vanligt. Det finns evidens för att tidig och aggressiv behandling av illamåendet minskar risken att utveckla HG, vilket understryker vikten av att inte vänta för länge med att söka hjälp.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Gravida delar om illamående i svenska forum:",
                consensus: "De flesta betonar att illamåendet var värre än väntat och att de önskat att de sökt hjälp tidigare. Ingefära och små måltider nämns ofta som hjälpsamt, men vid svårare besvär var det läkemedel som gjorde skillnad.",
                quotes: [
                    "– Mitt illamående varade 24/7 i 16 veckor. Ingefärste och kex hjälpte inte alls. Postafen var min räddning. Våga ta läkemedel – de är säkra!",
                    "– Hyperemesis med tre sjukhusinläggningar. Ingen förstod hur sjuk jag var. 'Det är ju normalt att må illa.' Nej, det här var inte normalt. Sök vård om du inte kan dricka.",
                    "– Bästa tipset jag fick: ät INNAN du blir hungrig. Jag hade timer på 2 timmar och åt något litet varje gång. Gjorde enorm skillnad."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Fejzo MS et al. (2018). Placenta and appetite genes GDF15 and IGFBP7 are associated with hyperemesis gravidarum. Nature Communications, 9:1178.",
                "Matthews A et al. (2015). Interventions for nausea and vomiting in early pregnancy. Cochrane Database of Systematic Reviews.",
                "Viljoen E et al. (2014). A systematic review and meta-analysis of the effect and safety of ginger in the treatment of pregnancy-associated nausea and vomiting. Nutrition Journal, 13:20.",
                "ACOG Practice Bulletin No. 189: Nausea and Vomiting of Pregnancy (2018)."
            ]
        ),

        // MARK: Article 7 – Förlossningsförberedelse
        Article(
            id: "pregnancy_birth_prep",
            category: .pregnancy,
            title: "Förlossningsförberedelse",
            subtitle: "Förbered dig mentalt och fysiskt för förlossningen",
            icon: "figure.walk",
            readTimeMinutes: 8,
            intro: "Att förbereda sig inför förlossningen handlar om både kunskap och mental förberedelse. Forskning visar att kvinnor som är väl förberedda upplever mindre ångest, har kortare förlossningar och är mer nöjda med sin förlossningsupplevelse. Den här artikeln går igenom evidensbaserade metoder för att förbereda kropp och sinne inför den stora dagen.",
            sections: [
                ArticleSection(
                    heading: "Förlossningens faser",
                    body: """
En vaginal förlossning delas in i tre stadier. Det första stadiet omfattar öppningsskedet, där livmodermunnen öppnar sig från 0 till 10 cm. Denna fas delas ytterligare in i en latensfas (0-4 cm) som kan ta många timmar eller till och med dagar med oregelbundna sammandragningar, och en aktiv fas (4-10 cm) med regelbundna, starkare värkarbete. I den aktiva fasen öppnar sig livmodermunnen typiskt med ungefär 1 cm per timme hos förstföderskor.

Det andra stadiet är utdrivningsskedet, från full öppning till barnets födelse. Denna fas varar vanligtvis 30 minuter till 2 timmar hos förstföderskor. Krystvärkar kommer nu och du kan aktivt krysta med. Barnmorskan vägleder dig genom att andas och krysta i rätt takt för att minska risken för bristningar.

Det tredje stadiet är efterbördsskedet, då moderkakan föds fram. Det sker vanligtvis inom 30 minuter efter barnets födelse och kräver sällan aktiv insats. I Sverige ges rutinmässigt oxytocin intravenöst för att minska blödningsrisken.

Att veta vad som händer i varje fas kan minska rädsla och ge en känsla av kontroll. Många beskriver att den teoretiska kunskapen om förlossningens förlopp hjälpte dem att vara närvarande istället för överväldigade.
"""
                ),
                ArticleSection(
                    heading: "Smärtlindring – dina alternativ",
                    body: """
I Sverige erbjuds ett brett spektrum av smärtlindring under förlossningen. Lustgas (kvävgas och syre-blandning) är den vanligaste metoden och används av cirka 60 % av alla födande. Den verkar snabbt, du kontrollerar själv intaget via en mask, och den lämnar kroppen inom minuter. Lustgas kan kombineras med alla andra smärtlindringsmetoder.

Ryggbedövning (epidural) ger den mest effektiva smärtlindringen och används av cirka 50 % av förstföderskor i Sverige. En tunn kateter placeras i epiduralrummet i ryggen och lokalbedövning tillförs kontinuerligt eller i doser. Modern epiduralteknik (walking epidural) tillåter viss rörlighet. Epidural kan sättas när som helst under aktiv förlossning och tar 15-20 minuter att få full effekt.

Vattenimmersion (bad eller pool) har i studier visat sig minska smärta och behovet av annan smärtlindring under öppningsskedet. Vattnet ger avslappning och viktlöshet som underlättar rörelse och positionsbyten. Många förlossningsavdelningar erbjuder badkar, och på vissa enheter kan du även föda i vatten.

Andra metoder inkluderar TENS (transkutan elektrisk nervstimulering), akupunktur, sterilvattenspapler (injektioner av sterilt vatten i ländryggen som ger effektiv lindring av ryggsmärta), massage, och andningstekniker. Forskningen stödjer att en individuell smärtlindringsplan, där du är förberedd på flera alternativ, ger bäst resultat.
"""
                ),
                ArticleSection(
                    heading: "Mental förberedelse och förlossningsrädsla",
                    body: """
Förlossningsrädsla (tokofobi) drabbar uppskattningsvis 10-15 % av gravida i Sverige. Det kan vara primär tokofobi (hos kvinnor som aldrig fött) eller sekundär (efter en tidigare traumatisk förlossningsupplevelse). Svår förlossningsrädsla är en vanlig orsak till önskemål om kejsarsnitt och bör tas på allvar av vården.

Aurora-mottagningar finns på de flesta sjukhus i Sverige och erbjuder extra stöd till gravida med förlossningsrädsla. Här träffar du barnmorskor med specialkompetens som arbetar med samtal, avslappningsövningar och förlossningsplanering. Studier visar att stöd via Aurora signifikant minskar ångestnivåerna och ökar sannolikheten för en positiv förlossningsupplevelse.

Hypnoförlossning (HypnoBirthing) och mindfulness-baserad förlossningsförberedelse har vuxit i popularitet och har visst vetenskapligt stöd. En Cochrane-analys visade att hypnos under förlossningen kan minska behovet av farmakologisk smärtlindring. Metoderna bygger på djup avslappning, positiva visualiseringar och andningstekniker som minskar stressresponsen.

Att skriva en förlossningsplan kan vara värdefullt, inte som ett kontrakt utan som ett kommunikationsverktyg. Planen bör beskriva dina önskemål kring smärtlindring, förlossningsposition, hud-mot-hud-kontakt, och eventuella kulturella eller personliga önskemål. Men den bör vara flexibel: förlossningar är oförutsägbara och planer kan behöva ändras.
"""
                ),
                ArticleSection(
                    heading: "Fysisk förberedelse de sista veckorna",
                    body: """
Perinealmassage från graviditetsvecka 34 har visat sig minska risken för bristningar och behovet av klipp. Tekniken innebär att man försiktigt masserar och töjer perineum (mellangården) med olja under 5-10 minuter, 3-4 gånger per vecka. En Cochrane-analys visar att perineal massage minskar risken för grad 3-4 bristningar hos förstföderskor.

Bäckenbottenträning under hela graviditeten stärker musklerna som stödjer livmodern, urinblåsan och tarmen. Starka bäckenbottenmuskler kan underlätta krystfasen och snabba på återhämtningen efter förlossningen. Dessutom minskar det risken för urininkontinens som drabbar upp till 30 % av kvinnor efter vaginal förlossning.

Förlossningspositioner att öva: upprätt positioner (stående, knästående, fyrbent) utnyttjar gravitationen och kan öppna bäckenet med upp till 30 % jämfört med ryggläge. Att öva dessa positioner i förväg gör det lättare att använda dem under förlossningen. Särskilt gunga på gymnastikboll och göra höftcirklar är populärt och kan underlätta barnets nedträngning.

Dadelkonsumtion i sista månadens graviditet har i flera randomiserade studier visat sig minska behovet av igångsättning och korta den latenta fasen av förlossningen. Rekommenderad dos är 6 dadlar per dag från vecka 36. Mekanismen tros vara att dadlar innehåller ämnen som liknar oxytocin och som kan mogna livmoderhalsen.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Blivande mammor delar om förlossningsförberedelse:",
                consensus: "De flesta betonar vikten av att vara informerad men flexibel. Förlossningskurser nämns som värdefulla, och Aurora-mottagningen rekommenderas varmt till dem med förlossningsrädsla.",
                quotes: [
                    "– Gick hos Aurora i 5 veckor och det förändrade allt. Från panikkänsla till att faktiskt kunna se fram emot förlossningen. Rekommenderar alla med rädsla att söka dit.",
                    "– Perinealmassage var obekvämt men jag fick noll bristningar som förstföderska. Min barnmorska var imponerad. Börja vecka 34!",
                    "– Bästa rådet jag fick: skriv en förlossningsplan men skriv den med blyerts, inte med bläck. Allt kan ändras och det är okej."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Beckmann MM, Stock OM (2013). Antenatal perineal massage for reducing perineal trauma. Cochrane Database of Systematic Reviews.",
                "Madden K et al. (2016). Hypnosis for pain management during labour and childbirth. Cochrane Database of Systematic Reviews.",
                "Al-Kuran O et al. (2011). The effect of late pregnancy consumption of date fruit on labour and delivery. J Obstet Gynaecol, 31(1):29-31.",
                "SBU: Förlossningsrädsla – en systematisk översikt (2019)."
            ]
        ),

        // MARK: Article 8 – Kejsarsnitt
        Article(
            id: "pregnancy_csection",
            category: .pregnancy,
            title: "Kejsarsnitt – planerat och akut",
            subtitle: "Allt du behöver veta om kejsarsnitt i Sverige",
            icon: "heart.text.square.fill",
            readTimeMinutes: 7,
            intro: "Ungefär 17-20 % av alla förlossningar i Sverige sker med kejsarsnitt. Det kan vara planerat (elektivt) på grund av medicinska skäl eller mammans önskemål, eller akut vid komplikationer under vaginal förlossning. Oavsett orsak är det viktigt att vara förberedd på vad ingreppet innebär, hur återhämtningen ser ut och vad forskningen säger.",
            sections: [
                ArticleSection(
                    heading: "Indikationer för kejsarsnitt",
                    body: """
Planerade kejsarsnitt görs av flera medicinska skäl. Sätesbjudning (barnet ligger med stjärten nedåt) efter graviditetsvecka 36 är en vanlig indikation, även om yttre vändning kan försökas först. Föreliggande moderkaka (placenta previa), där moderkakan helt täcker livmodermunnen, kräver kejsarsnitt. Tidigare kejsarsnitt kan vara en indikation, men VBAC (vaginal förlossning efter kejsarsnitt) är möjligt och säkert för de flesta.

Akut kejsarsnitt görs när komplikationer uppstår under vaginal förlossning. Det kan vara hotande fosterasfyxi (avvikande CTG-mönster), utebliven progress trots adekvat värkarbete, navelsträngsprolaps, eller placentaavlossning. Akuta kejsarsnitt klassificeras i grader: grad 1 (omedelbart livräddande, barnet ska vara ute inom 15 minuter) till grad 4 (inga akuta risker men vaginal förlossning bedöms inte möjlig).

I Sverige har du som gravid rätt att diskutera kejsarsnitt som alternativ med din läkare, även utan strikt medicinsk indikation. Svår förlossningsrädsla (tokofobi) accepteras av de flesta kliniker som skäl för planerat kejsarsnitt, efter att samtal och stöd erbjudits. Forskningen visar att tvinga en kvinna med svår rädsla att föda vaginalt kan ge sämre utfall.

Det är viktigt att förstå att kejsarsnitt inte är den enkla vägen ut. Det är bukkirurgi med reella risker och en längre återhämtningsperiod. Beslutet bör fattas informerat, i samråd med vården, baserat på individuella omständigheter.
"""
                ),
                ArticleSection(
                    heading: "Hur går ett kejsarsnitt till?",
                    body: """
Vid planerat kejsarsnitt kommer du fastande till sjukhuset på operationsdagen. Du får spinalbedövning, som ger fullständig smärtfrihet nedanför bröstkorgen medan du är vaken. Partnern kan vanligtvis vara med i operationssalen. Ett skynke sätts upp i brösthöjd så att du inte ser operationsområdet.

Operationen tar vanligtvis 30-45 minuter. Barnet föds inom de första 5-10 minuterna genom ett horisontellt snitt strax ovanför blygdbenet (bikinisnitt). Resterande tid används för att sy livmodern och bukväggen i lager. Du kan ofta höra barnet skrika kort efter framtagningen och få hud-mot-hud-kontakt direkt, antingen på ditt eller partnerns bröst.

Så kallat naturligt kejsarsnitt eller familjevänligt kejsarsnitt har blivit vanligare i Sverige. Det innebär att skynket sänks så att föräldrarna kan se barnet födas, att framtagningen sker långsamt för att ge barnet tid att anpassa sig, och att hud-mot-hud-kontakt prioriteras omedelbart. Forskning visar att detta förbättrar amningsstarten och den tidiga anknytningen.

Vid akut kejsarsnitt kan förloppet vara snabbare och mer stressigt. Om det är extremt akut kan narkos behöva ges istället för spinalbedövning, och partnern kan inte alltid vara med. Det är normalt att känna besvikelse eller trauma efter ett akut kejsarsnitt, och psykologiskt stöd bör erbjudas.
"""
                ),
                ArticleSection(
                    heading: "Återhämtning efter kejsarsnitt",
                    body: """
De första dagarna efter kejsarsnitt stannar du vanligtvis 2-3 dagar på sjukhuset. Smärtan hanteras med paracetamol och NSAID i första hand, med opioider som tillägg vid behov. Tidig mobilisering (att börja gå redan samma dag eller dagen efter) minskar risken för blodpropp och snabbar på återhämtningen.

De första 2 veckorna hemma bör du undvika tunga lyft (inget tyngre än ditt barn), trappgång i onödan, och bilkörning. Smärtan minskar gradvis och de flesta känner sig betydligt bättre efter 2-3 veckor. Full fysisk återhämtning tar dock 6-8 veckor, och ärret fortsätter att mogna i upp till ett år.

Sårläkning: snittet sys med upplösbara stygn eller häftas med agraffer som tas bort efter 5-7 dagar. Håll såret rent och torrt. Kontakta vården om du ser ökad rodnad, svullnad, vätskande eller illaluktande sekretion, eller om du får feber, då det kan tyda på infektion.

Psykisk återhämtning kan ta längre tid än den fysiska. Många kvinnor upplever blandade känslor efter kejsarsnitt: lättnad över att barnet är friskt blandat med sorg över att inte ha fött vaginalt, eller frustration över den begränsade rörligheten. Dessa känslor är normala och giltiga. Förlossningssamtal (som erbjuds av barnmorskan) kan vara värdefullt för att bearbeta upplevelsen.
"""
                ),
                ArticleSection(
                    heading: "Framtida graviditeter efter kejsarsnitt",
                    body: """
VBAC (vaginal birth after cesarean) är säkert för de flesta kvinnor efter ett tidigare kejsarsnitt. Ungefär 60-80 % av kvinnor som försöker VBAC lyckas föda vaginalt. Den största risken är uterusruptur (bristning av livmoderärret), som inträffar i 0,5-0,7 % av VBAC-försök. Risken är lägre om det tidigare snittet var ett lågt tvärsnitt och om det gått minst 18 månader mellan graviditeterna.

Upprepade kejsarsnitt ökar risken för komplikationer progressivt. Sammanväxningar blir vanligare efter varje ingrepp, och risken för placenta accreta (där moderkakan växer in i livmoderväggen) ökar markant. Efter 3 eller fler kejsarsnitt bör framtida graviditeter noggrant diskuteras med specialist.

Rekommenderad väntetid mellan kejsarsnitt och ny graviditet är minst 12-18 månader för att ärret ska läka ordentligt. Kortare intervall ökar risken för uterusruptur och prematur födsel.

I Sverige uppmuntras VBAC aktivt, och de flesta kliniker har riktlinjer för att stödja kvinnor som vill försöka vaginal förlossning efter kejsarsnitt. Beslutet bör dock alltid vara individualiserat, baserat på den specifika kvinnans situation, orsaken till det tidigare kejsarsnittet, och hennes egna önskemål.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Mammor som fött med kejsarsnitt delar i forum:",
                consensus: "De flesta betonar att kejsarsnitt är en riktig förlossning och att ingen behöver känna skuld. Återhämtningen beskrivs som tuffare än förväntat, men med rätt stöd hanterbar.",
                quotes: [
                    "– Planerat kejsarsnitt pga sätesläge. Det var lugnt, fint och vi fick hud-mot-hud direkt. Sluta be om ursäkt för att du inte födde 'naturligt'. Mitt barn är lika född.",
                    "– Akut kejsarsnitt efter 20 timmars värkarbete. Tog lång tid att bearbeta men förlossningssamtalet hjälpte enormt. Sök hjälp om det känns tungt.",
                    "– VBAC lyckades efter kejsarsnitt! Var nervös men personalen var fantastisk och stöttande. Det går att föda vaginalt efter snitt."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Socialstyrelsen: Statistik om graviditeter, förlossningar och nyfödda barn (2023).",
                "ACOG Practice Bulletin No. 205: Vaginal Birth After Cesarean Delivery (2019).",
                "NICE Guideline CG132: Caesarean birth (2021, updated 2023).",
                "Guise JM et al. (2010). Vaginal birth after cesarean: new insights. AHRQ Evidence Report."
            ]
        ),

        // MARK: Article 9 – Amning första dagarna
        Article(
            id: "pregnancy_early_breastfeeding",
            category: .pregnancy,
            title: "Amning de första dagarna",
            subtitle: "Kom igång med amningen direkt efter förlossningen",
            icon: "drop.circle.fill",
            readTimeMinutes: 6,
            intro: "De första dagarna efter förlossningen lägger grunden för en fungerande amning. Kolostrum, den första mjölken, börjar produceras redan under graviditeten och är allt ditt nyfödda barn behöver de första dagarna. Mjölken skiftar sedan från kolostrum till övergångsmjölk och slutligen mogen bröstmjölk. Att förstå processen och veta vad som är normalt kan göra enorm skillnad.",
            sections: [
                ArticleSection(
                    heading: "Kolostrum – flytande guld",
                    body: """
Kolostrum är den första mjölken som produceras och finns i brösten redan från mitten av graviditeten. Det produceras i små mängder, vanligtvis 2-20 ml per amningstillfälle under de första dygnen, vilket är perfekt anpassat till den nyföddes minimala magsäck som bara rymmer 5-7 ml vid födseln. Många nyblivna mammor oroar sig för att det inte räcker, men det gör det.

Kolostrum är tjockt, gulaktigt och extremt näringsrikt. Det innehåller höga koncentrationer av antikroppar (särskilt IgA), vita blodkroppar, tillväxtfaktorer och proteiner som skyddar barnets outvecklade tarmslemhinna. Det fungerar som barnets första vaccination och hjälper till att kolonisera tarmen med nyttiga bakterier.

WHO rekommenderar hud-mot-hud-kontakt omedelbart efter födseln och att barnet erbjuds bröstet inom den första timmen. Under denna period är barnet i ett naturligt alert tillstånd och har starka sug- och rotningsreflexer. Studier visar att tidig hud-mot-hud och amningsstart ökar sannolikheten för lyckad amning på lång sikt.

Att handmjölka kolostrum före förlossningen (antenatal mjölkning från vecka 36-37) har blivit vanligare och rekommenderas särskilt till kvinnor med diabetes, då deras barn kan ha lägre blodsockernivåer efter födseln. Det insamlade kolostrumet fryses in och kan ges till barnet om det behövs.
"""
                ),
                ArticleSection(
                    heading: "Mjölkproduktionens igångsättning",
                    body: """
Mjölkproduktionen styrs av två huvudmekanismer. Under graviditeten hålls den fullskaliga produktionen tillbaka av höga progesteron- och östrogennivåer. När moderkakan föds ut sjunker dessa hormoner dramatiskt, och prolaktin, som redan är förhöjt, kan börja stimulera mjölkproduktionen. Denna process kallas laktogenes II och inträffar vanligtvis 2-5 dagar efter förlossningen.

Du vet att mjölken kommer in (mjölkrusning) när brösten blir tyngre, varmare och fyllda. Barnet börjar svälja hörbart under amningen och bajset övergår gradvis från svart mekonium till grönbrunt och sedan gult. Blöjbytena ökar markant. Det är normalt att brösten känns obehagligt spända under 1-2 dagar, och regelbunden amning eller urmjölkning lindrar.

Fördröjd mjölkrusning (mer än 72 timmar) kan uppstå vid kejsarsnitt, prematur förlossning, diabetes, PCOS, kraftig blödning efter förlossningen, eller stress. Om mjölkrusningen dröjer är det extra viktigt att amma eller pumpa ofta, minst 8-12 gånger per dygn, för att stimulera produktionen maximalt.

Efterfrågan styr tillgången. Ju oftare och effektivare barnet suger, eller ju oftare du pumpar, desto mer mjölk produceras. Denna princip, som kallas autokrin kontroll, innebär att varje amning eller pumpning signalerar till kroppen att producera mer mjölk. Att hoppa över amningstillfällen minskar produktionen.
"""
                ),
                ArticleSection(
                    heading: "Amningspositioner och sugteknik",
                    body: """
En korrekt sugteknik är avgörande för att förebygga smärta, sår på bröstvårtorna och otillräckligt mjölkintag. Barnet ska ta en stor del av vårtgården i munnen, inte bara bröstvårtan. Underkäken ska vara brett öppen, läpparna utåtflänsta, och hakan ska trycka mot bröstet medan näsan är fri.

Tecken på bra tag: amningen gör inte ont (en kort smärta de första sekunderna de första dagarna kan vara normalt), barnet har rytmiska sugningar med hörbara sväljar, hakan rör sig djupt, och kinderna är runda, inte indragna. Efter amningen ska bröstvårtan se rund ut, inte tillplattad eller sned.

Vanliga amningspositioner: vaggställning (barnet ligger längs din underarm), korsvaggställning (du stödjer barnets huvud med motsatt hand, ger bra kontroll för nybörjare), rugby-tag (barnet under din arm, bra efter kejsarsnitt), och liggande (praktiskt för nattamning). Alla positioner ska följa principen mage-mot-mage med barnets öra, axel och höft i linje.

Om du upplever smärta vid amning ska du inte härda ut. Avbryt försiktigt sugningen genom att föra in lillfingret i barnets mungipa, och försök igen med bättre tag. Kontakta en amningsmottagning eller IBCLC-certifierad amningsrådgivare om smärtan kvarstår, då det kan finnas underliggande orsaker som tungband.
"""
                ),
                ArticleSection(
                    heading: "Vanliga utmaningar de första dagarna",
                    body: """
Ömma bröstvårtor de första dagarna är vanligt men ska inte ignoreras. Mild ömhet som avtar under amningen kan vara normalt under den första veckan. Men ihållande smärta, sprickor eller blödning tyder på felaktigt tag och bör åtgärdas. Lanolinbaserad salva kan smörjas på efter amning utan att torkas av före nästa tillfälle.

Bröstsvullnad (engorgement) vid mjölkrusningen kan göra det svårt för barnet att fästa. Mjölka ur lite för hand före amningen för att mjuka upp vårtgården. Kalla kompresser mellan amningarna och varma kompresser strax innan kan hjälpa. Amning ska ske ofta, minst 8-12 gånger per dygn.

Viktnedgång hos den nyfödda: en viktnedgång på upp till 7 % under de första dagarna är normalt. Över 10 % bör utredas. Barnet bör ha återhämtat sin födelsevikt senast vid 10-14 dagars ålder. Regelbunden vägning på BVC under de första veckorna bekräftar att barnet får tillräckligt med mjölk.

Klustermatning, där barnet vill amma extremt ofta under perioder, är normalt och vanligt särskilt kvällstid under de första veckorna. Det är inte ett tecken på att mjölken inte räcker utan barnets sätt att bygga upp mjölkproduktionen. Det avtar vanligtvis efter de första 6 veckorna.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Nyblivna mammor delar om de första amningsdagarna:",
                consensus: "Amningsstart beskrivs som oväntat svårt av många, men de som fick tidig professionell hjälp hade bättre upplevelse. Tålamod och kunskap om att kolostrum räcker betonas ofta.",
                quotes: [
                    "– Ingen berättade att amning kan vara så svårt i början. Dag 3 grät vi båda. Dag 7, efter hjälp av amningsmottagningen, fungerade det. Sök hjälp tidigt!",
                    "– Mitt barn gick ner 8 % och jag var livrädd. Barnmorskan lugnade mig, vi började tillfälligt tillmata med spruta, och efter en vecka var vi på spåret igen.",
                    "– Klustermatning kvällarna nästan knäckte mig. Men det gick över efter 3 veckor och sedan var amningen det lättaste och finaste jag gjort."
                ],
                source: "Källa: Familjeliv.se, Amningshjälpen.se"
            ),
            sources: [
                "WHO: Guideline: protecting, promoting and supporting breastfeeding in facilities providing maternity and newborn services (2017).",
                "Nommsen-Rivers LA et al. (2010). Delayed onset of lactogenesis among first-time mothers is related to maternal obesity. Am J Clin Nutr.",
                "Forster DA et al. (2017). Advising women with diabetes in pregnancy to express breastmilk in late pregnancy (Diabetes and Antenatal Milk Expressing [DAME]). Lancet.",
                "Socialstyrelsen: Amning och bröstmjölk – kunskapsunderlag (2016)."
            ]
        ),

        // MARK: Article 10 – Återhämtning efter förlossning
        Article(
            id: "pregnancy_recovery",
            category: .pregnancy,
            title: "Återhämtning efter förlossning",
            subtitle: "Vad som händer med kroppen de första veckorna och månaderna",
            icon: "figure.cooldown",
            readTimeMinutes: 7,
            intro: "Kroppen genomgår enorma förändringar under graviditeten, och återhämtningen efter förlossningen är en process som tar tid. Livmodern, som vid slutet av graviditeten väger omkring 1 kg, ska krympa tillbaka till sin normala storlek på 60 gram. Bäckenbotten, hormoner, blodvolym och psykiskt välmående behöver alla tid att återhämta sig. Den här artikeln ger en realistisk bild av vad du kan förvänta dig.",
            sections: [
                ArticleSection(
                    heading: "De första dagarna och veckorna",
                    body: """
Eftervärkarna, som beror på att livmodern drar ihop sig, kan vara överraskande smärtsamma, särskilt vid andra eller tredje barnet och vid amning (då oxytocin frigörs). De är starkast de första 2-3 dagarna och avtar sedan. Värktabletter (paracetamol och ibuprofen) hjälper och är säkra vid amning.

Avslag (lochia) är den blödning som följer efter förlossningen och varar typiskt 4-6 veckor. Den är först riklig och röd, övergår efter en vecka till brunaktig och blir sedan gulvit. Kraftig blödning som ökar istället för minskar, stora klumpar, eller illaluktande avslag ska föranleda kontakt med vården, då det kan tyda på kvarbliven placenta eller infektion.

Bristningar och stygn: de flesta vaginala bristningar läker inom 2-4 veckor. Håll området rent genom att skölja med vatten efter toalettbesök. Sittbad kan lindra. Klipp eller mer omfattande bristningar kan vara ömma längre. Grad 3-4 bristningar (som involverar ändtarmssfinktern) kräver särskild uppföljning och bäckenbottenrehabilitering.

Svullnad och vätskeansamling som byggts upp under graviditeten försvinner gradvis under de första 1-2 veckorna. Du kan uppleva kraftig svettning, särskilt nattetid, när kroppen gör sig av med överflödig vätska. Det är helt normalt.
"""
                ),
                ArticleSection(
                    heading: "Bäckenbotten och underlivsrehabilitering",
                    body: """
Bäckenbotten har utsatts för enorm påfrestning under graviditeten och förlossningen. Även utan bristningar töjs musklerna avsevärt vid vaginal förlossning. Upp till 30 % av kvinnor upplever urininkontinens efter förlossningen, och 5-10 % har avföringsinkontinens. De flesta fallen förbättras spontant inom 6 månader, men bäckenbottenträning påskyndar återhämtningen.

Bäckenbottenträning bör påbörjas så snart du kan efter förlossningen, ofta redan dagen efter. Knipövningar (att spänna musklerna som om du stoppar en kiss) i omgångar om 10 repetitioner, 3 gånger dagligen, är grundriktlinjen. Gradvis öka till längre uthållningsperioder. Det kan vara svårt att känna musklerna i början, men känslan återkommer.

Om du har kvarstående inkontinens efter 3 månader bör du kontakta en fysioterapeut med specialisering i bäckenbottenrehabilitering. Biofeedback-träning och elektrisk stimulering kan vara effektiva tillägg. I Sverige har du rätt till fysioterapibehandling via vårdcentralen.

Samlag efter förlossningen rekommenderas inte förrän avslaget har upphört och eventuella bristningar har läkt, vanligtvis 4-6 veckor. Men det finns ingen fast tidsgräns: du bestämmer själv när du känner dig redo. Många kvinnor upplever torrhet och ömhet de första gångerna, och östrogenbrist vid amning kan bidra. Glidmedel och tålamod rekommenderas.
"""
                ),
                ArticleSection(
                    heading: "Fysisk aktivitet och träning",
                    body: """
Promenader kan påbörjas redan de första dagarna efter en okomplicerad vaginal förlossning. Lyssna på kroppen och öka gradvis. Undvik löpning och hoppande rörelser de första 3 månaderna, då bäckenbotten och ledband inte har läkt tillräckligt.

Efter 6-8 veckor kan de flesta börja med lätt styrketräning och konditionsträning. Undvik tunga magövningar (sit-ups, crunches) om du har rektusdiastas (delning av de raka bukmusklerna), vilket drabbar upp till 60 % av alla efter förlossning. Kontrollera genom att ligga på rygg, böja knäna, lyfta huvudet och känna efter om det finns en glipa mellan bukmusklerna ovanför och under naveln.

Riktad rehabiliteringsträning för rektusdiastas fokuserar på djup bukmuskelaktivering (transversus abdominis), bäckenbotten och andningstekniker. Många fysioterapeuter erbjuder mammaträning eller efterförlossningsgrupper. Studier visar att specifik rehabilitering minskar diastas-bredden signifikant.

Realistiska förväntningar: det tog 9 månader för kroppen att bygga upp graviditeten, och det tar minst lika lång tid att återhämta sig. Det sociala trycket att snabbt komma tillbaka i form är skadligt och ovetenskapligt. De flesta kvinnor behöver 12-18 månader för att känna sig fysiskt som sig själva igen.
"""
                ),
                ArticleSection(
                    heading: "Hormonell omställning och psykiskt mående",
                    body: """
Efter förlossningen sker en dramatisk hormonell omställning. Östrogen och progesteron sjunker till premenopausal nivå inom dagar, medan prolaktin och oxytocin tar över vid amning. Denna omställning kan orsaka humörsvängningar, trötthet, svettningar, håravfall (telogen effluvium, vanligtvis 3-6 månader efter förlossning), och torrhet i slemhinnor.

Baby blues drabbar upp till 80 % av nyblivna mammor och innebär några dagars gråtmildhet, humörsvängningar och ångest runt dag 3-5 efter förlossningen, ofta sammanfallande med mjölkrusningen. Det är övergående och kräver ingen behandling, men stöd och förståelse från omgivningen.

Postpartum depression (PPD) drabbar 10-15 % och skiljer sig från baby blues genom att symtomen är allvarligare, varar längre (mer än 2 veckor) och påverkar funktionsnivån. Screening sker via Edinburgh Postnatal Depression Scale (EPDS) på BVC vid 6-8 veckor och 6 månader. Var ärlig i screeningen: tidig upptäckt ger bättre behandlingsresultat.

Schildkörtelproblem kan uppstå eller förvärras efter förlossning (postpartumtyreoidit) och kan ge symtom som liknar depression. Det drabbar 5-10 % av nyblivna mammor och bör utredas med blodprover om depressionsbehandling inte ger effekt.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Nyblivna mammor delar om återhämtning:",
                consensus: "De flesta önskar att de fått mer realistisk information om hur lång och krävande återhämtningen är. Bäckenbottenträning och att acceptera att det tar tid framhålls som de viktigaste råden.",
                quotes: [
                    "– Ingen berättade att eftervärkarna vid barn nummer 2 skulle vara VÄRRE än förlossningen. Jag var helt oförberedd. Ha värktabletter hemma!",
                    "– Rektusdiastas på 4 cm. Gjorde inget åt det i ett år och det blev bara värre. Gå till fysioterapeut TIDIGT.",
                    "– Det tog mig 14 månader att känna mig som mig själv igen. 14 månader. Och det är okej. Ge dig själv tid och nåd."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Boyle R et al. (2020). Pelvic floor muscle training for prevention and treatment of urinary and faecal incontinence in antenatal and postnatal women. Cochrane Database of Systematic Reviews.",
                "Sperstad JB et al. (2016). Diastasis recti abdominis during pregnancy and 12 months after childbirth. British Journal of Sports Medicine, 50(17):1092-1096.",
                "SBU: Postpartumdepression – screening och behandling (2014).",
                "1177 Vårdguiden: Kroppen efter förlossningen (2023)."
            ]
        ),

        // =====================================================================
        // MARK: SÖMN (5 articles)
        // =====================================================================

        // MARK: Article 11 – Nyfödd sömn 0-3 månader
        Article(
            id: "sleep_newborn",
            category: .sleep,
            title: "Nyfödd sömn 0-3 månader",
            subtitle: "Förstå din nyföddes sömnmönster och skapa goda vanor",
            icon: "moon.fill",
            readTimeMinutes: 7,
            intro: "Nyfödda sover mycket, upp till 16-18 timmar per dygn, men sällan mer än 2-4 timmar i sträck. Det beror på att deras dygnsrytm inte är utvecklad och att de behöver äta ofta. Att förstå varför nyfödda sover som de gör, och vad som är normalt, kan minska stress och hjälpa dig lägga grunden för goda sömnvanor längre fram.",
            sections: [
                ArticleSection(
                    heading: "Nyfödda sömnfysiologi",
                    body: """
Nyfödda saknar en etablerad dygnsrytm (cirkadisk rytm). Melatoninproduktionen, som reglerar sömn-vakencykeln, börjar inte utvecklas förrän vid 2-3 månaders ålder och är inte fullt etablerad förrän vid 4-5 månader. Det innebär att nyfödda sover lika mycket dag som natt och inte har något begrepp om dag och natt.

Nyfödda tillbringar ungefär 50 % av sin sömntid i aktiv sömn (REM-liknande), jämfört med 20-25 % hos vuxna. Under aktiv sömn rör sig barnet, gör grimaser, kan jämra sig och andas oregelbundet. Denna sömnfas är viktig för hjärnans utveckling och bör inte avbrytas. Många föräldrar tolkar den aktiva sömnen som att barnet är vaket eller obekvämt, och plockar upp barnet i onödan.

Sömnperioderna hos nyfödda är korta, vanligtvis 45 minuter till 3 timmar. Varje sömnperiod innehåller en cykel av aktiv och lugn sömn. Mellan cyklerna finns ett kort uppvaknande, och barnet behöver ofta hjälp att somna om. Det är helt normalt och utvecklingsmässigt förväntat att nyfödda inte kan somna om på egen hand.

Under de första 6-8 veckorna kan sömnen vara kaotisk och oförutsägbar. Runt 6-8 veckors ålder börjar de flesta barn visa tecken på en framväxande dygnsrytm, med längre vakna perioder på dagen och längre sömnperioder på natten.
"""
                ),
                ArticleSection(
                    heading: "Trygg sömn – evidensbaserade riktlinjer",
                    body: """
Plötslig spädbarnsdöd (SIDS) är den vanligaste dödsorsaken hos barn mellan 1 och 12 månaders ålder. Risken minskar dramatiskt med enkla åtgärder. Ryggläge är den viktigaste: sedan kampanjen för ryggläge introducerades i Sverige på 1990-talet har SIDS-dödsfallen minskat med över 80 %. Barnet ska alltid läggas på rygg, aldrig på magen eller sidan.

Sov i samma rum men inte i samma säng de första 6 månaderna, enligt rekommendationer från Socialstyrelsen och American Academy of Pediatrics. Samsovning i samma säng ökar risken för SIDS, särskilt om föräldern röker, har druckit alkohol, tagit droger eller sömnmedel, eller är extremt trött. En bedside-crib som fästs vid föräldrasängen ger närhet och trygghet utan riskerna.

Sovrummet ska vara svalt (16-20 grader), rökfritt, och sängen fri från kuddar, filtar, stötskydd och gosedjur. Barnet bör sova i sovpåse anpassad för temperaturen, inte under lösa täcken. Överhettning är en riskfaktor för SIDS: känn på barnets nacke eller mage för att bedöma om det är lagom varmt.

Napp har i studier visat sig minska risken för SIDS med 50-90 %. Mekanismen är inte helt klarlagd men kan bero på att nappsugning håller luftvägen öppen. Erbjud nappen vid sömn men tvinga inte om barnet inte vill ha den, och vänta med att introducera nappen tills amningen fungerar väl (vanligtvis efter 3-4 veckor).
"""
                ),
                ArticleSection(
                    heading: "Strategier för bättre sömn under nyföddsperioden",
                    body: """
Dag-natt-skillnad: redan från första veckan kan du börja signalera skillnaden mellan dag och natt. På dagen: ljust, normalt ljud, aktiv interaktion vid matning. På natten: dimmat ljus, tyst omgivning, minimal interaktion vid blöjbyte och matning. Barnet förstår inte skillnaden ännu men du grundlägger en association som hjälper när dygnsrytmen mognar.

Vakenfönster hos nyfödda är mycket korta: 45-90 minuter de första veckorna, gradvis ökande till 90-120 minuter vid 3 månaders ålder. Att hålla barnet vaket för länge leder till överstimulering och paradoxalt nog svårare att somna. Sömnledtrådar inkluderar gäspning, gnugga ögonen, bli kinkig och vända bort blicken.

Lindning (swaddling) kan hjälpa nyfödda att sova bättre genom att dämpa Moro-reflexen, den ofrivilliga startreaktionen som ofta väcker barnet. Lindning ska dock göras korrekt: tillräckligt löst kring höfterna för att inte störa höftledsutvecklingen, och barnet ska aldrig lindas om det kan rulla.

Vit brus (white noise) simulerar ljudet i livmodern och kan ha en lugnande effekt på nyfödda. Studier visar att vitt brus kan minska tiden till insomning och öka den totala sömntiden. Ljudet bör vara kontinuerligt, på lagom volym (under 50 dB, ungefär som ett diskret duschljud) och placerat minst en meter från barnets huvud.
"""
                ),
                ArticleSection(
                    heading: "Nattamning och sömn",
                    body: """
Nattmatning är biologiskt nödvändigt under de första månaderna. Nyfödda behöver äta var 2-3:e timme, inklusive nattetid, för att växa och hålla blodsockret stabilt. Att försöka få en nyfödd att sova genom natten utan mat är varken realistiskt eller säkert. De flesta barn börjar sova en längre period (4-6 timmar) runt 2-3 månaders ålder.

Amning på natten har flera fördelar: bröstmjölk som produceras på natten innehåller mer melatonin och tryptofan (aminosyra som främjar sömn) än dagmjölk, och nattkortisolen hos barnet hålls lägre vid amning. Dessutom är prolaktinnivåerna högst på natten, och nattamning är viktig för att upprätthålla mjölkproduktionen.

Praktiska tips för att göra nätterna hanterbar: ha allt redo vid sängen (vatten, snacks, amningskudde), turas om med partnern när det är möjligt, och sov när barnet sover på dagen utan att skämmas. Den gyllene regeln under nyföddsperioden är att sänka alla andra krav och prioritera sömn.

Sömn i skift kan vara en effektiv strategi: en förälder tar ansvar för barnets behov under kvällen (exempelvis 20-01), medan den andra sover, och sedan byter man. På så sätt får varje förälder en garanterad period med sammanhängande sömn, vilket är viktigare för återhämtningen än det totala antalet sömntimmar.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Nyblivna föräldrar delar om nyfödd sömn:",
                consensus: "Det vanligaste rådet är att sänka förväntningarna och acceptera att sömnen kommer att vara fragmenterad. Att inte jämföra med andras barn framhålls som viktigt.",
                quotes: [
                    "– Ingen förberedde mig på att 'sover som en bebis' är en LÖG. Min sov aldrig mer än 2 timmar i sträck. Det blev bättre vid 8 veckor.",
                    "– Sömn i skift räddade vårt förstånd och vår relation. Jag tog 20-01, han 01-06. Vi överlevde.",
                    "– Vitt brus var magiskt. Från att ta 40 minuter att få honom att somna till att somna på 5 minuter. Prova!"
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Mindell JA et al. (2016). Development of infant and toddler sleep patterns. Sleep Medicine Reviews, 26:31-36.",
                "Moon RY et al. (2022). Sleep-related infant deaths: updated 2022 recommendations. Pediatrics, 150(1).",
                "Socialstyrelsen: Säker sömn för spädbarn (2023).",
                "Spencer JA et al. (1990). White noise and sleep induction. Archives of Disease in Childhood, 65(1):135-137."
            ]
        ),

        // MARK: Article 12 – 4-månaders sömnregression
        Article(
            id: "sleep_4month_regression",
            category: .sleep,
            title: "4-månaders sömnregression",
            subtitle: "Varför sömnen plötsligt försämras och vad du kan göra",
            icon: "arrow.counterclockwise.circle.fill",
            readTimeMinutes: 6,
            intro: "Runt 3-5 månaders ålder upplever många föräldrar en drastisk försämring av barnets sömn. Barnet som kanske börjat sova längre perioder vaknar plötsligt flera gånger per natt. Det kallas 4-månaders sömnregression, men det är egentligen en permanent mognad av sömnarkitekturen. Att förstå vad som händer neurologiskt kan göra perioden mindre stressande.",
            sections: [
                ArticleSection(
                    heading: "Vad händer neurologiskt?",
                    body: """
Vid 3-4 månaders ålder genomgår barnets sömn en permanent förändring. Sömnarkitekturen mognar från nyföddsperiodens enkla tvåfasiga mönster (aktiv och lugn sömn) till det vuxna sömnmönstret med fyra stadier: N1 (lätt sömn), N2 (stabil sömn), N3 (djupsömn) och REM-sömn. Denna mognad är permanent och inte en tillfällig regression.

Den praktiska konsekvensen är att barnet nu genomgår tydligare sömnövergångar mellan stadier, och vid varje övergång finns ett kort partiellt uppvaknande. Vuxna hanterar dessa uppvaknanden automatiskt och somnar om utan att minnas dem. Men ett spädbarn som alltid somnat med hjälp av amning, vagga eller bärande kanske inte kan somna om utan samma hjälp.

Resultatet: barnet vaknar inte oftare rent neurologiskt, men det har svårare att somna om vid de naturliga uppvaknandena. Om barnet behöver en specifik insomningsassociation (bröst, napp, gunga) för att somna, behöver det samma sak vid varje uppvaknande, som kan vara 4-6 gånger per natt.

Denna insikt är avgörande: problemet är inte att barnet vaknar, utan att det inte kan somna om självständigt. Det innebär att lösningen, om man önskar, handlar om att hjälpa barnet lära sig att somna utan extern hjälp, inte om att förhindra uppvaknandena.
"""
                ),
                ArticleSection(
                    heading: "Tecken och duration",
                    body: """
Typiska tecken på 4-månaders sömnregressionen: plötslig ökning av nattuppvaknanden (från kanske 1-2 till 4-6 eller fler), kortare tupplurer, svårare att lägga barnet, ökad gråt vid insomning, och ett barn som verkar trött men vägrar sova. Barnet kan också vara mer distragerbart vid matning och ha ett ökat sug- och tröstbehov.

Sömnregressionen sammanfaller ofta med andra utvecklingssprång: barnet börjar rulla, blir mer medvetet om sin omgivning, och kan ha separationsångest. Dessa faktorer bidrar till den allmänna oron och sömnstörningen.

Durationen varierar: den akuta fasen varar vanligtvis 2-4 veckor, men sömnförsämringen kan kvarstå längre om inga förändringar görs i sömnrutinerna. Till skillnad från andra sömnregressioner senare under barnets utveckling är 4-månaders förändringen permanent i den meningen att sömnarkitekturen inte går tillbaka.

En del barn påverkas knappt alls. Det beror ofta på att de redan utvecklat en viss förmåga att somna självständigt, eller att deras temperament gör dem mer anpassningsbara. Det finns ingen anledning till oro om ditt barn inte verkar genomgå en tydlig regression.
"""
                ),
                ArticleSection(
                    heading: "Strategier för att hantera regressionen",
                    body: """
Konsistens i sömnrutinen: etablera en tydlig kvällsrutin om du inte redan har det. Bad, pyjamas, bok, sång, sova. Rutinen signalerar till barnet att det är dags att varva ner och aktiverar parasympatiska nervsystemet. Forskning visar att en konsekvent kvällsrutin förbättrar sömnen signifikant redan efter 3 dagar.

Tidigarelägg kvällen om barnet verkar övertrött. Paradoxalt nog kan en tidigare läggning ge längre nattsömn. De flesta barn i denna ålder mår bäst av att somna mellan 18.30 och 19.30, beroende på sista tupplurans sluttid.

Lär barnet att somna i sin egen säng. Om du tidigare alltid ammat eller vagga barnet till djup sömn och sedan lagt ner det, kan du nu börja lägga barnet sömnigt men vaket. Det innebär inte att du lämnar barnet att skrika ensamt, utan att du närmar dig stegvis: tröstsugning, sedan bröst men ta bort före djup sömn, sedan hand på bröstet, sedan närvarande men utan beröring.

Realistiska förväntningar: att det tar flera veckor att etablera nya vanor. Var konsekvent men tålmodig, och ge dig själv nåd. Det finns ingen quick fix, men det blir bättre.
"""
                ),
                ArticleSection(
                    heading: "Vanliga frågor och myter",
                    body: """
Myt: Att börja ge gröt eller fast föda löser sömnproblemen. Forskning visar att tidig matintroduktion (innan 4 månader) inte förbättrar sömnen och kan öka risken för allergier. Sömnregressionen är neurologisk, inte hungersrelaterad.

Myt: Att hålla barnet vaket längre under dagen gör att det sover bättre på natten. Överstimulering och övertrötthet leder tvärtom till sämre nattsömn. Barn som sovit väl under dagen sover oftast bättre på natten.

Vanlig fråga: Ska jag börja med sömnträning nu? De flesta sömnexperter rekommenderar att vänta tills barnet är minst 4, helst 6 månader innan formell sömnträning övervägs. Under själva regressionsfasen är det bättre att fokusera på att hjälpa barnet genom perioden med tröst och sedan arbeta med sömnvanor efteråt.

Vanlig fråga: Är det farligt att barnet vaknar så ofta? Nej. Frekventa uppvaknanden är utvecklingsmässigt normala och har inga negativa effekter på barnets hälsa. Det är föräldrarna som påverkas mest av sömnbristen, och det är viktigt att söka stöd om det blir ohållbart.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar om 4-månaders sömnregressionen:",
                consensus: "De flesta beskriver det som den tuffaste perioden hittills, men att det blir bättre. Att förstå att det är neurologisk mognad och inte något de gjort fel var en lättnad.",
                quotes: [
                    "– Vecka 16. Från att sova 6 timmar i sträck till att vakna VARJE TIMME. Jag trodde jag skulle dö. Men det gick över efter 3 veckor.",
                    "– Det som hjälpte oss: kvällsrutin klockan 18.00 sharp, sovpåse, vitt brus. Och att sluta googla mitt i natten.",
                    "– Alla sa 'det är bara en fas'. Jo, men den varade i 6 veckor och jag behövde HJÄLP, inte platityder. Be om hjälp av familj och vänner."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Henderson JM et al. (2010). Sleeping through the night: the consolidation of self-regulated sleep across the first year of life. Pediatrics, 126(5):e1081-e1087.",
                "Mindell JA et al. (2009). A nightly bedtime routine: impact on sleep in young children and maternal mood. Sleep, 32(5):599-606.",
                "Galland BC et al. (2012). Normal sleep patterns in infants and children: a systematic review. Sleep Medicine Reviews, 16(3):213-222."
            ]
        ),

        // MARK: Article 13 – Sömnträning metoder
        Article(
            id: "sleep_training",
            category: .sleep,
            title: "Sömnträning – metoder och evidens",
            subtitle: "Olika metoder för att hjälpa ditt barn sova bättre",
            icon: "bed.double.fill",
            readTimeMinutes: 8,
            intro: "Sömnträning är ett kontroversiellt ämne som väcker starka känslor. Men forskningen är tydlig: sömnträning, oavsett metod, är säker och effektiv för barn från 6 månaders ålder. Den påverkar inte anknytningen negativt och ger varaktiga resultat. Samtidigt är sömnträning inte nödvändigt eller önskvärt för alla familjer. Här presenterar vi de vetenskapligt studerade metoderna så att du kan göra ett informerat val.",
            sections: [
                ArticleSection(
                    heading: "Vad säger forskningen?",
                    body: """
Den mest omfattande studien om sömnträningens säkerhet är den australiska Infant Sleep Study, som följde barn i 5 år efter sömnträning. Studien, publicerad i Pediatrics 2012, fann inga skillnader i kortisolnivåer, anknytningskvalitet, emotionella problem eller beteendeproblem mellan barn som sömntränade och kontrollgruppen. Föräldrarna till sömntränade barn hade däremot signifikant lägre depressionsrisk.

En Cochrane-analys (2006, uppdaterad 2020) av randomiserade kontrollerade studier bekräftar att beteendebaserade sömninterventioner är effektiva och att förbättringarna kvarstår. Studien fann att alla metoder fungerar: det finns ingen enskild metod som är överlägsen, utan det handlar om konsistens och anpassning till familjens behov.

Kritikerna hänvisar ofta till studier om barns stressnivåer, men dessa studier har metodologiska brister och har inte kunnat reproduceras i större, välkontrollerade studier. Den samlade vetenskapliga evidensen stödjer att sömnträning från 6 månaders ålder är säker.

Det är dock viktigt att betona att sömnträning inte är nödvändigt. Många barn lär sig sova igenom natten utan formell träning. Om din familj fungerar bra och du inte upplever sömnen som ett problem finns ingen anledning att sömnträna. Det är ett verktyg för familjer som behöver det, inte ett krav.
"""
                ),
                ArticleSection(
                    heading: "Gradvis utfasning (Gentle methods)",
                    body: """
Närvarumetoden, ofta kallad camping out, innebär att du sitter bredvid barnets säng medan det somnar. Varje kväll flyttar du stolen lite längre från sängen tills du sitter utanför rummet. Processen tar vanligtvis 2-3 veckor. Fördelen är att barnet aldrig lämnas ensamt; nackdelen är att det tar längre tid och att din närvaro ibland kan stimulera barnet mer än om du lämnat.

Pick up/put down-metoden innebär att du lägger barnet i sängen vaket, och om det gråter plockar du upp det och tröstar tills det är lugnt (men inte sovande), och lägger ner det igen. Du upprepar detta tills barnet somnar i sängen. Metoden kan vara tröttsam (du kanske plockar upp barnet 30-50 gånger första kvällen) men de flesta barn sover bättre inom en vecka.

PUPD-varianter (Pat-Shush): istället för att plocka upp barnet klappar du det rytmiskt på stjärten och sussar. Många upplever detta som en bra kompromiss: barnet lämnas inte ensamt men behöver inte lyftas ur sängen.

Alla gradvisa metoder bygger på principen att du är närvarande och tröstar, men inte utför den sista insomningsassociationen (ammar, vaggar, bär). Barnet lär sig gradvis att somna i sin säng med minskande hjälp. Forskning visar att dessa metoder tar längre tid men ger likvärdiga resultat jämfört med snabbare metoder.
"""
                ),
                ArticleSection(
                    heading: "Kontrollerad tröst och utsläckning",
                    body: """
Kontrollerad tröst (Ferber-metoden eller graduated extinction) innebär att du lägger barnet vaket, lämnar rummet och återvänder med jämna mellanrum för korta tröstbesök. Intervallerna ökar gradvis: först 3 minuter, sedan 5, sedan 10. Vid besöket tröstar du kort verbalt eller med en klapp men plockar inte upp barnet. De flesta barn sover bättre redan efter 3-5 nätter.

Utsläckning (extinction eller CIO, cry it out) innebär att du lägger barnet vaket, säger godnatt och lämnar rummet utan att återvända förrän det bestämda uppvaknandedags. Det är den snabbaste metoden: de flesta barn sover igenom natten inom 3 nätter. Men det är också den metod som är svårast emotionellt för föräldrarna.

Ingen av dessa metoder innebär att du ignorerar ett sjukt, hungrigt eller rätt barn. Förutsättningarna för sömnträning: barnet är friskt, mätt, torrt och i en trygg miljö. Om du misstänker sjukdom, hunger eller annat avbryter du och försöker igen en annan kväll.

En modifierad version av Ferber, där man börjar med längre intervaller (5, 10, 15 minuter) och lägger till ett tröstord utifrån dörren, är den mest använda metoden i Sverige och kombinerar effektivitet med föräldrars behov av att vara nära.
"""
                ),
                ArticleSection(
                    heading: "Praktiska tips för sömnträning",
                    body: """
Timing: börja aldrig sömnträning under en pågående sömnregression, sjukdom, tandframbrott, stor förändring (flytt, dagisstart), eller semester. Välj en lugn period när båda föräldrarna kan vara närvarande och konsekventa. En lördagskväll är bra startdag: du har söndagen att återhämta dig.

Var enig med din partner. Sömnträning kräver konsistens, och om en förälder underminierar processen förlängs gråtperioden. Diskutera och enas om metod, gränser och signaler innan ni börjar.

Förvänta dig att natt 2-3 kan vara värre än natt 1 (extinction burst: barnet intensifierar beteendet innan det ger upp). Det är normalt och ett tecken på att processen fungerar, inte att den misslyckas. Ge inte upp vid denna punkt.

Dokumentera processen: skriv ner gråtens längd och antal uppvaknanden varje natt. Det ger perspektiv och motivation. De flesta ser tydlig förbättring inom 5-7 dagar, oavsett metod, givet att man varit konsekvent.

Sömnträning gäller insomning, inte nattamning. Om ditt barn fortfarande behöver äta på natten (vanligt upp till 8-12 månader) fortsätter du mata, men hjälper barnet somna om efter matningen utan att amma eller vagga till djup sömn.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar om sömnträning:",
                consensus: "Starkt polariserade åsikter men de som genomfört sömnträning är nästan alltid nöjda i efterhand. Konsistens framhålls som nyckeln. Många önskar att de börjat tidigare.",
                quotes: [
                    "– Kontrollerad tröst. Natt 1: 45 min gråt. Natt 2: 20 min. Natt 3: 5 min. Natt 4: hon somnade själv utan ett ljud. Jag grät av lättnad.",
                    "– Vi valde närvarumetoden. Tog 3 veckor men ingen gråt. Passade vår familj perfekt. Det finns inget 'rätt' sätt.",
                    "– Alla dömer tills de själva har ett barn som vaknar 8 gånger per natt i 6 månader. Sömnträning räddade min psykiska hälsa."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Price AM et al. (2012). Five-year follow-up of harms and benefits of behavioral infant sleep intervention. Pediatrics, 130(4):643-651.",
                "Mindell JA et al. (2006). Behavioral treatment of bedtime problems and night wakings in infants and young children. Sleep, 29(10):1263-1276.",
                "Gradisar M et al. (2016). Behavioral interventions for infant sleep problems. Pediatrics, 137(6):e20151486.",
                "Hiscock H et al. (2007). Improving infant sleep and maternal mental health: a cluster randomised trial. Archives of Disease in Childhood, 92(11):952-958."
            ]
        ),

        // MARK: Article 14 – Tupplurer
        Article(
            id: "sleep_naps",
            category: .sleep,
            title: "Tupplurer – guide efter ålder",
            subtitle: "Hur många tupplurer behöver ditt barn och hur länge?",
            icon: "sun.haze.fill",
            readTimeMinutes: 6,
            intro: "Tupplurer är avgörande för barns utveckling och påverkar nattsömnen mer än de flesta föräldrar tror. Ett barn som inte sovit tillräckligt på dagen sover paradoxalt nog sämre på natten. Att veta hur många tupplurer ditt barn behöver och hur länge vakenfönstren bör vara kan transformera sömnsituationen i hemmet.",
            sections: [
                ArticleSection(
                    heading: "Tupplurer efter ålder",
                    body: """
0-3 månader: Nyfödda sover utan tydligt mönster och tar 4-6 tupplurer om dagen. Vakenfönstren är korta, 45-90 minuter, och ökar gradvis. Försök inte tvinga ett schema: följ barnets signaler och erbjud sömn så snart det visar tecken på trötthet.

3-5 månader: De flesta barn konsoliderar till 3-4 tupplurer per dag: morgon, middag, eftermiddag och ibland en kort kvällslur. Vakenfönstren är 1,5-2 timmar. Den sista tuppluren bör sluta senast 17.00-17.30 för att inte inkräkta på nattsömnen.

5-8 månader: Övergång till 3 tupplurer, sedan 2. Vakenfönstren ökar till 2-3 timmar. Den tredje tuppluren (sen eftermiddagslur) brukar försvinna först. Många barn gör denna övergång runt 6-7 månaders ålder.

8-15 månader: 2 tupplurer per dag, en på förmiddagen och en efter lunch. Vakenfönster 2,5-3,5 timmar. Övergången till 1 tupplur sker vanligtvis runt 12-18 månaders ålder. Denna övergång är en av de mest utmanande och kan ta 2-4 veckor med oregelbundenhet.

15 månader-3 år: 1 tupplur per dag, vanligtvis efter lunch, som varar 1-2,5 timmar. Vakenfönster 5-6 timmar. De flesta barn slutar med tupplur helt mellan 2,5 och 4 års ålder, men det varierar stort individuellt.
"""
                ),
                ArticleSection(
                    heading: "Vakenfönster – nyckeln till bra tupplurer",
                    body: """
Vakenfönster (wake windows) är tiden barnet är vaket mellan sömnperioder. Det är det mest användbara verktyget för att tajma tupplurer: för korta vakenfönster leder till att barnet inte är tillräckligt sömnigt, medan för långa leder till överstimulering, kortisolfrisättning och sämre sömn.

Tecken på att vakenfönstret är rätt: barnet somnar inom 15 minuter, sover minst 45 minuter (gärna 1-2 timmar), och vaknar på gott humör. Om barnet konsekvent tar lång tid att somna kan vakenfönstret vara för kort. Om det vaknar efter 20-30 minuter eller gråter sig igenom läggningen kan det vara för långt.

Vakenfönster är inte exakta siffror utan riktlinjer. De påverkas av individen, sömnkvaliteten natten innan, stimuleringsnivån under dagen och hälsan. Använd tabeller som utgångspunkt men justera efter ditt barns signaler.

Det första vakenfönstret på dagen (från uppvaknande till första tupplur) är ofta kortast, medan det sista (från sista tupplurans slut till nattens läggning) är längst. Den principen gäller under hela spädbarnsåret och är bra att komma ihåg vid planering.
"""
                ),
                ArticleSection(
                    heading: "Korta tupplurer – orsaker och lösningar",
                    body: """
En tupplur under 45 minuter (en sömnscykel) kallas ofta kattnap och ger inte den djupsömn som barnet behöver för återhämtning. Korta tupplurer är vanliga under 5 månaders ålder och är ofta utvecklingsmässigt normala. Efter 5-6 månader kan de tyda på sömnproblem som kan åtgärdas.

Vanliga orsaker till korta tupplurer: felaktigt vakenfönster (för kort eller för långt), bristande insomningsförmåga (barnet behöver hjälp att somna om efter en sömnscykel), för ljust rum, störande ljud, hunger, obehag, eller en sömnmiljö som skiljer sig från nattens.

Lösningar: optimera vakenfönstret (prova 15-30 minuters justering), säkerställ ett helt mörkt rum (mörkläggningsgardin), använd vitt brus, skapa en kort tupplurerrutin (miniversion av kvällsrutinen, 5 minuter), och ge barnet tid att somna om på egen hand vid uppvaknande (vänta 5-10 minuter innan du går in).

Kontaktlurer (att barnet sover på dig eller i bärsele) ger ofta längre tupplurer eftersom barnets sömnhormoner stimuleras av din värme och närvaro. Det är inget fel med kontaktlurer, men om du vill att barnet ska kunna sova i sin säng behöver övergången ske gradvis.
"""
                ),
                ArticleSection(
                    heading: "Övergångar mellan antal tupplurer",
                    body: """
Tecken på att barnet är redo att minska en tupplur: konsekvent motstånd mot en av tuplurerna i mer än 2 veckor, tupplurer blir kortare, nattsömnen påverkas negativt (sent insomning eller tidigt uppvaknande), och barnet verkar energiskt och glad trots utebliven tupplur.

Övergången 3→2 tupplurer (runt 6-8 månader): Drop den sista tuppluren och förläng vakenfönstren. Flytta nattsömnen 15-30 minuter tidigare tillfälligt. De flesta barn anpassar sig inom 1-2 veckor.

Övergången 2→1 tupplur (runt 12-18 månader): Den mest utmanande övergången. Börja med att korta förmiddagstuppluren och flytta lunchtuppluren tidigare. Så småningom försvinner förmiddagstuppluren helt. Under övergången kan du behöva alternera mellan 1 och 2 tupplurer beroende på dag.

Övergången 1→0 tupplurer (runt 2,5-4 år): Ersätt tuppluren med en lugn stund (vilostund med böcker eller lugn aktivitet). Barnet behöver fortfarande pausen även om det inte sover. Förläng nattsömnen genom tidigare läggning. Vissa barn behöver tupplur varannan dag under övergångsperioden.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar om tupplurer:",
                consensus: "Vakenfönster nämns som den enskilt viktigaste insikten. Många beskriver att de haft barnet vaket för länge utan att veta det, och att kortare vakenfönster löste både tupplure- och nattproblem.",
                quotes: [
                    "– Mina tvillingars sömn förbättrades dramatiskt när jag lärde mig om vakenfönster. De var överstimulerade hela tiden!",
                    "– Övergången till en tupplur vid 13 månader var brutal. 3 veckor av kaos. Sedan: paradisisk 2-timmars lunch-lur varje dag.",
                    "– Mörkläggningsgardin var den bästa investering vi gjort. 20-minuterslurarna blev 1,5 timmar över en natt."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Mindell JA et al. (2016). Development of infant and toddler sleep patterns. Sleep Medicine Reviews, 26:31-36.",
                "Weissbluth M (2015). Healthy Sleep Habits, Happy Child. Ballantine Books.",
                "Galland BC et al. (2012). Normal sleep patterns in infants and children. Sleep Medicine Reviews, 16(3):213-222.",
                "Staton S et al. (2020). Napping behaviour in children: a systematic review. Sleep Medicine Reviews, 50:101247."
            ]
        ),

        // MARK: Article 15 – Sömn 1-5 år
        Article(
            id: "sleep_toddler",
            category: .sleep,
            title: "Sömn 1-5 år",
            subtitle: "Sömnbehov, utmaningar och strategier för småbarn",
            icon: "star.and.crescent",
            readTimeMinutes: 7,
            intro: "Småbarnsåren medför nya sömnutomaingar: övergång från spjälsäng till juniorsäng, mörkerrädsla, mardrömmar, motstånd mot läggning och tidigt morgonuppvaknande. Sömnbehovet minskar gradvis men förblir betydande. Att förstå utvecklingsfaserna och ha strategier redo kan göra kvällarna lugnare och nätterna längre.",
            sections: [
                ArticleSection(
                    heading: "Sömnbehov efter ålder",
                    body: """
Vid 1 år behöver de flesta barn 12-14 timmars sömn per dygn, inklusive 2-3 timmars tupplur. Vid 2 år minskar behovet till 11-14 timmar, med 1-2 timmars tupplur. Vid 3 år: 10-13 timmar, med eller utan tupplur. Vid 4-5 år: 10-12 timmar, nästan alltid utan tupplur. Dessa är riktlinjer och individuell variation är stor.

Konsekvent läggdags och uppvakningstid är viktigare än den exakta sömntiden. En regelbunden sömnrytm synkroniserar den inre klockan (cirkadisk rytm) och gör insomningen lättare. Försök hålla samma tider även på helger, med maximalt 30-60 minuters avvikelse.

Sömnbehovet minskar gradvis, men den biologiska drivkraften för sömn förändras också. Småbarn har starkare drivkraft att utforska och interagera, vilket kan överskugga tröttheten. Ett barn som springer runt och verkar pigg klockan 20 kan vara grovt övertrött, och stimulansens adrenalineffekt maskerar tröttheten.

En viktig förändring sker runt 2 års ålder: barnet börjar kunna hålla sig vaket medvetet, till skillnad från spädbarn som somnar när de är tillräckligt trötta oavsett. Det innebär att kampen om läggningen, som är sällsynt hos spädbarn, kan bli ett vardagsfenomen hos småbarn.
"""
                ),
                ArticleSection(
                    heading: "Vanliga sömnproblem hos småbarn",
                    body: """
Läggmotstånd är det vanligaste sömnproblemet hos barn 2-5 år. Barnet vill ha vatten, ännu en bok, behöver kissa, är rädd, vill ha mamma/pappa. Gränssättning med empati är nyckeln: validera känslor men håll rutinen. Ett verktyg som fungerar väl är sömnpass eller biljetter: barnet får 1-2 pass per kväll att använda för extra behov, och när de är slut är de slut.

Tidigt morgonuppvaknande (före 06.00) kan bero på för sen läggning (intuitivt nog), för lång eller för sen tupplur, ljus i rummet tidigt på morgonen, eller hunger. En okej-att-kliva-upp-klocka (Gro Clock eller liknande) som visar barnet visuellt om det är natt eller dag kan vara effektivt från 2,5 års ålder.

Mörkerrädsla utvecklas vanligtvis runt 2-3 års ålder, parallellt med barnets ökande fantasi. Det är en normal utvecklingsfas. Validera rädslan utan att förstärka den. En nattlampa med svagt, varmt ljus, ett skyddsdjur och en monstercheck som rutin kan hjälpa. Undvik att låta barnet se skrämmande innehåll på skärmar.

Mardrömmar och nattskräck: mardrömmar sker under REM-sömn och barnet minns dem och kan tröstas. Nattskräck (pavor nocturnus) sker under djupsömn: barnet skriker, verkar vaket men är inte kontaktbart, och minns inget. Vid nattskräck: stör inte barnet, säkerställ att det inte skadar sig, och vänta. Det går vanligtvis över inom 5-15 minuter.
"""
                ),
                ArticleSection(
                    heading: "Övergång till juniorsäng",
                    body: """
De flesta barn byter från spjälsäng till juniorsäng mellan 2 och 3 års ålder. Vanliga skäl: barnet klättrar ur spjälsängen (säkerhetsrisk), ett syskon behöver spjälsängen, eller barnet är fysiskt för stort. Byt inte för tidigt: barn under 2,5 år saknar ofta den kognitiva mognaden att förstå att de ska stanna i sängen.

Förbered barnet: prata om det i förväg, låt barnet vara delaktig i att välja sängkläder, och gör det till en positiv upplevelse. Behåll alla andra sömnrutiner identiska: samma kvällsrutin, samma gosedjur, samma sovpåse eller täcke.

Testningsperioden: det är nästan oundvikligt att barnet testar sin nyfunna frihet och kommer ut ur sängen. Hantera det lugnt och konsekvent: säg kort och neutralt att det är sovdags och led barnet tillbaka till sängen. Upprepa. De flesta barn ger upp efter några dagar till en vecka om du är konsekvent.

Säkerhet: när barnet kan lämna sängen kan det också röra sig fritt i rummet. Säkra möbler mot väggen, täck eluttag, och överväg en grind i dörröppningen. Vissa familjer sätter en dörrlarm som signalerar om barnet lämnar rummet nattetid.
"""
                ),
                ArticleSection(
                    heading: "Skärmar och sömn",
                    body: """
Forskning är entydig: skärmanvändning nära sänggåendet försämrar sömnen hos barn. Det blå ljuset från skärmar hämmar melatoninproduktionen med 23-58 % enligt studier. Dessutom stimulerar innehållet (även lugnt innehåll) hjärnan och försvårar nedvarvning.

Rekommendationer: inga skärmar minst 1 timme före sänggåendet. Inga skärmar i sovrummet. Ersätt kvällens skärmtid med läsning, pussel, lugn lek eller samtal. Dessa aktiviteter aktiverar parasympatiska nervsystemet och förbereder kroppen för sömn.

Studier visar att barn som har en TV eller surfplatta i sovrummet sover i genomsnitt 30 minuter mindre per natt och har sämre sömnkvalitet. Effekten är dosberoende: ju mer skärmtid, desto sämre sömn. Det gäller även passiv TV i bakgrunden.

Var en förebild: barn lär sig av vad vi gör, inte vad vi säger. Om du själv scrollar telefonen vid läggningen skickar det en signal. Familjeregeln bör gälla alla: efter en viss tid parkeras alla skärmar utanför sovrummet.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar till småbarn delar om sömn:",
                consensus: "Konsistens och gränssättning med värme är de mest återkommande råden. Många understryker att varje barn är unikt och att jämförelse med andra barn är onödig stress.",
                quotes: [
                    "– Okej-att-kliva-upp-klockan förändrade våra morgnar. Sonen förstod vid 2,5 år att gul sol = kan gå upp. Före det väckte han oss 05.15 varje dag.",
                    "– Nattskräck skrämde oss mer än honom. Barnläkaren sa: han minns inget, bara vänta. Stämde. Gick över efter 3 månader.",
                    "– Tog bort iPad:en 2 timmar före läggning. Skillnaden var enorm. Från 45 min insomning till 10 min. Vi borde gjort det för länge sedan."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Mindell JA, Owens JA (2015). A Clinical Guide to Pediatric Sleep. Lippincott Williams & Wilkins.",
                "Hale L, Guan S (2015). Screen time and sleep among school-aged children. Sleep Medicine Reviews, 21:50-58.",
                "American Academy of Pediatrics (2016). Media and Young Minds. Pediatrics, 138(5):e20162591.",
                "Brambilla P et al. (2017). Sleep habits and patterns in adolescents. Sleep Medicine Reviews, 35:51-60."
            ]
        ),

        // =====================================================================
        // MARK: MATNING (5 articles)
        // =====================================================================

        // MARK: Article 16 – Amning grunderna
        Article(
            id: "feeding_breastfeeding",
            category: .feeding,
            title: "Amning – den kompletta guiden",
            subtitle: "Allt du behöver veta för en fungerande amning",
            icon: "drop.fill",
            readTimeMinutes: 8,
            intro: "Amning rekommenderas av WHO som exklusiv näringskälla under barnets första 6 månader och som komplement till fast föda upp till 2 års ålder eller längre. I Sverige helammar cirka 63 % vid 4 månader och 15 % vid 6 månader. Amning är naturligt men inte alltid enkelt. Den här guiden ger dig kunskapen för att lyckas och verktygen för att hantera vanliga utmaningar.",
            sections: [
                ArticleSection(
                    heading: "Bröstmjölkens sammansättning och fördelar",
                    body: """
Bröstmjölk är en levande vätska som ständigt anpassar sig efter barnets behov. Den innehåller över 200 unika komponenter: proteiner, fetter, kolhydrater, vitaminer, mineraler, enzymer, hormoner, tillväxtfaktorer, stamceller och immunceller. Sammansättningen förändras under amningen (förmjölk är vattnig och törstsläckande, bakmjölk är fetare och mättande), under dygnet (nattmjölk innehåller mer melatonin) och under barnets utveckling.

Immunfördelarna är betydande: bröstmjölk innehåller sekretoriskt IgA som skyddar barnets tarmslemhinna, laktoferrin som binder järn och hindrar patogeners tillväxt, lysozym som bryter ner bakterieväggar, och oligosackarider (HMO) som fungerar som prebiotika och främjar nyttiga tarmbakterier. Ammade barn har lägre risk för öroninflammationer, gastroenterit, nedre luftvägsinfektioner och nekrotiserande enterokolit.

Långsiktiga hälsoeffekter för barnet inkluderar minskad risk för övervikt, typ 1- och typ 2-diabetes, plötslig spädbarnsdöd, och vissa barndomscancrar (leukemi). För mamman minskar amning risken för bröstcancer, äggstockscancer, typ 2-diabetes och hjärt-kärlsjukdom. Effekterna är dosberoende: ju längre total amningstid, desto starkare skydd.

Det är dock viktigt att inte använda dessa fakta för att skuldbelägga mammor som inte kan eller vill amma. Modersmjölksersättning ger fullgod näring och barn som inte ammas utvecklas normalt. Det bästa valet är det som fungerar för hela familjen.
"""
                ),
                ArticleSection(
                    heading: "Vanliga amningsproblem och lösningar",
                    body: """
Mjölkstockning (engorgement) uppstår när brösten blir överfulla och kan leda till smärta, rodnad och ibland feber. Behandling: amma ofta, använd varma kompresser före och kalla efter amning, handmjölka för att lätta på trycket. Vibrationshjälpmedel kan lösa upp stockningen. Om symtomen inte förbättras inom 24 timmar eller du får hög feber kan det ha utvecklats till mastit.

Mastit (bröstinflammation) drabbar 10-20 % av ammande kvinnor. Symtom: smärta, rodnad, svullnad i en avgränsad del av bröstet, feber över 38,5 grader, influensakänsla. Behandling: fortsätt amma (det är säkert och viktigt), vila, värktabletter, och om symtomen inte förbättras inom 24 timmar eller är svåra bör antibiotika påbörjas. Utebliven behandling kan leda till bröstabscess.

Svampinfektion (candida) kan ge brännande, stickande smärta i bröstvårtorna och djupare in i bröstet, ofta efter en period med smärtfri amning. Barnets mun kan visa vita beläggningar (torsk). Behandling: antimykotisk kräm till bröstvårtorna och oral gel till barnet, behandla alltid båda samtidigt för att undvika pingpong-effekt.

Tungband (ankyloglossi) hos barnet kan orsaka dåligt tag, smärta vid amning, dålig viktuppgång och minskad mjölkproduktion. Det drabbar 4-10 % av nyfödda. Diagnos ställs av van barnmorska, amningsrådgivare eller barnläkare. Klippning av tungband (frenotomi) är ett enkelt ingrepp som kan ge omedelbar förbättring, men evidensen för rutinmässig klippning är omdiskuterad.
"""
                ),
                ArticleSection(
                    heading: "Mjölkproduktion – för lite eller för mycket",
                    body: """
Upplevd låg mjölkproduktion är den vanligaste orsaken till att mammor slutar amma. Men studier visar att 90-95 % av alla kvinnor har fysiologisk kapacitet att producera tillräckligt med mjölk. Den vanligaste orsaken till faktisk låg produktion är otillräcklig stimulering: för sällan amning, dåligt sugtag, eller tidig introduktion av ersättning som minskar barnets behov av bröstet.

Tecken på att barnet får tillräckligt: minst 6 tunga blöjor per dygn efter dag 5, regelbunden avföring (kan variera från flera gånger per dag till en gång per vecka hos ammade barn efter 6 veckor), god viktuppgång (20-30 gram per dag de första månaderna), och barnet verkar nöjt efter amning.

Att öka mjölkproduktionen: amma eller pumpa oftare (minst 8-12 gånger per dygn), säkerställ bra tag, erbjud båda brösten vid varje amning, power pumping (20 min pumpa, 10 min paus, 10 min pumpa, 10 min paus, 10 min pumpa), hud-mot-hud-kontakt, och tillräckligt vätskeintag. Galaktagoga (örter och läkemedel som ökar mjölkproduktionen, som bockhornsklöver) har begränsad evidens.

Överproduktion kan vara lika besvärligt: barnet hostar, sprutar, är oroligt vid bröstet, och mamman har återkommande mjölkstockningar. Blockamning (att amma från samma bröst under 3-4 timmar) kan reglera ner produktionen. Undvik att pumpa i onödan, då det stimulerar ytterligare produktion.
"""
                ),
                ArticleSection(
                    heading: "Amning och återgång till arbete",
                    body: """
I Sverige underlättar den generösa föräldraledigheten amning betydligt. Men vid återgång till arbete behöver amningen anpassas. Alternativen inkluderar: fortsätta helamma genom att pumpa på jobbet, kombinera amning hemma med ersättning på förskolan, eller gradvis avvänjning.

Om du vill pumpa på jobbet: du har rätt till pauser för detta. Investera i en bra dubbelpump, idealt en hands-free-modell. Pumpa lika ofta som barnet skulle ha ammat, vanligtvis 2-3 gånger under en arbetsdag. Förvara mjölken i kylskåp (hållbar 4 dagar) eller frys (hållbar 6 månader).

Gradvis avvänjning rekommenderas framför abrupt slut. Minska med ett amningstillfälle i taget, med några dagars mellanrum, för att undvika mjölkstockning och ge hormonsystemet tid att anpassa sig. Kvällsamningen och morgonamningen brukar vara de sista att avvecklas och de som många mammor vill behålla längst.

Det finns ingen övre gräns för hur länge du kan amma. WHO rekommenderar minst 2 år, och globalt sett ammar de flesta mammor längre. I Sverige kan det finnas socialt tryck att sluta amma efter 1 år, men det finns inga medicinska skäl för det. Barnet och mammans önskemål avgör.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Ammande mammor delar i forum:",
                consensus: "Amning beskrivs som svårare än förväntat i början men enklare efter de första 6 veckorna. Professionell hjälp tidigt framhålls som avgörande vid problem.",
                quotes: [
                    "– De första 6 veckorna var de svåraste i mitt liv. Sedan klickade det och amning blev det enklaste. Håll ut förbi de första veckorna!",
                    "– Amningsrådgivaren såg direkt att min son hade tungband. Klippning och 24 timmar senare ammade han som en dröm. Sök IBCLC-hjälp!",
                    "– Jag ammar fortfarande vid 2 år och är trött på kommentarer. Det passar OSS och det är det enda som spelar roll."
                ],
                source: "Källa: Familjeliv.se, Amningshjälpen.se"
            ),
            sources: [
                "WHO: Breastfeeding recommendations (2023). who.int",
                "Victora CG et al. (2016). Breastfeeding in the 21st century. Lancet, 387(10017):475-490.",
                "Socialstyrelsen: Amning och bröstmjölk – kunskapsunderlag (2016).",
                "Academy of Breastfeeding Medicine: ABM Clinical Protocol #36: The Mastitis Spectrum (2022)."
            ]
        ),

        // MARK: Article 17 – Flaskmatning
        Article(
            id: "feeding_bottle",
            category: .feeding,
            title: "Flaskmatning med ersättning",
            subtitle: "En trygg och komplett guide till flaskmatning",
            icon: "cup.and.saucer.fill",
            readTimeMinutes: 6,
            intro: "Oavsett om du valt att flaskmata från start, kombinerar med amning eller har behövt sluta amma finns det ingen anledning till skuld. Modern modersmjölksersättning är noggrant reglerad och ger barnet all näring det behöver. Det här handlar om att göra flaskmatningen så bra som möjligt: rätt ersättning, rätt teknik och rätt mängder.",
            sections: [
                ArticleSection(
                    heading: "Att välja rätt ersättning",
                    body: """
I Sverige är all modersmjölksersättning reglerad enligt EU-direktiv och uppfyller strikta krav på näringsinnehåll. Det innebär att alla godkända ersättningar är säkra och fullvärdiga. Skillnaderna mellan märken är marginella, och den dyraste är inte nödvändigtvis bättre. Välj en som barnet tolererar väl.

Det finns två huvudtyper: modersmjölksersättning (1-ersättning, från 0 månader) som kan användas som enda näringskälla, och tillskottsnäring (2-ersättning, från 6 månader) som komplement till fast föda. I praktiken kan man fortsätta med 1-ersättning hela första året om man föredrar det.

Specialersättningar finns för specifika behov: hydrolyserad ersättning (HA) vid komjölksallergi i familjen, laktosreducerad vid laktosintolerans, och AR-ersättning (anti-reflux) vid spottiga barn. Byt inte ersättning utan att diskutera med BVC-sköterskan: magbesvär hos spädbarn är ofta normalt och beror sällan på ersättningen.

Sojbaserad ersättning rekommenderas inte i första hand i Sverige på grund av dess fytoöstrogen-innehåll. Vid bekräftad komjölksproteinallergi rekommenderas istället extensivt hydrolyserad ersättning, förskriven av barnläkare.
"""
                ),
                ArticleSection(
                    heading: "Hur mycket och hur ofta?",
                    body: """
Nyfödda börjar med små mängder: 30-60 ml per matning, 8-12 gånger per dygn. Mängden ökar gradvis: vid 1 månad ungefär 90-120 ml per matning, vid 3 månader 120-180 ml, vid 6 månader 180-240 ml. Totalt intag per dygn är ungefär 150-200 ml per kg kroppsvikt, men det varierar och individuella behov ska styra.

Mata efter behov, precis som vid amning. Tecken på hunger: sökande rörelser, suger på händerna, gnäller, rör sig aktivt. Gråt är ett sent hungertecken. Tvinga aldrig barnet att tömma flaskan: barn har en god förmåga att reglera sitt intag, och att tvinga riskerar att störa de naturliga hunger- och mättnadssignalerna.

Paced bottle feeding är en teknik som rekommenderas för att efterlikna ammandets rytm och hastighet. Håll barnet halvt upprätt (inte liggande), håll flaskan horisontellt så att barnet aktivt måste suga, och ta pauser var 30:e sekund genom att tippa flaskan nedåt. Det minskar risken för överkonsumtion och gasbesvär.

Tecken på att barnet är mätt: släpper flaskan, vänder bort huvudet, somnar, minskar sugfrekvensen. Respektera dessa signaler. Att ett barn inte tömmer flaskan är inte ett problem: häll bort resten och gör en ny nästa gång.
"""
                ),
                ArticleSection(
                    heading: "Hygien och beredning",
                    body: """
Korrekt beredning av ersättning är avgörande för säkerheten. Använd alltid nykokat vatten som svalnat till 70 grader (detta dödar eventuella bakterier i pulvret, inklusive Cronobacter sakazakii). Mät vatten och pulver enligt förpackningens anvisningar: för utspädd ersättning ger inte tillräckligt med näring, för koncentrerad belastar njurarna.

Bered helst en flaska i taget, direkt före matning. Om du behöver förbereda i förväg, kyl snabbt ner under rinnande kallt vatten och förvara i kylskåpets kallaste del (max 24 timmar). Värm aldrig i mikrovågsugn: det ger ojämn uppvärmning och risk för brännskador. Använd flaskvärmare eller varmvattenbad.

Rengöring: i Sverige med bra vattenkvalitet räcker det att diska flaskor och nappar noggrant med diskmedel och flaskborste, och sedan skölja ordentligt. Sterilisering rekommenderas under de första 3 månaderna, eller om barnet är prematurt eller immunförsvagat. Diskmaskin på minst 60 grader fungerar som sterilisering.

Utanför hemmet: ta med färdigblandat vatten i termos och pulver separat, blanda vid matning. Alternativt finns färdigblandad flytande ersättning (UHT-behandlad) som är steril och behöver ingen kylning förrän den öppnas. Den är dyrare men praktisk på resor och utflykter.
"""
                ),
                ArticleSection(
                    heading: "Kombinationsmatning",
                    body: """
Kombinationsmatning, att blanda amning och flaskmatning, är vanligare än de flesta tror. Det kan vara nödvändigt om mjölkproduktionen inte räcker, om mamman återgår till arbete, eller om partnern vill delta i matningen. Det behöver inte vara allt eller inget.

Tips för lyckad kombination: etablera amningen först (idealt 4-6 veckor) innan flaska introduceras, välj en napp med långsamt flöde, använd paced bottle feeding, och fortsätt amma så ofta du kan för att upprätthålla produktionen. Mjölkproduktionen styrs av efterfrågan: varje amning som ersätts med flaska minskar produktionen något.

Så kallad nipple confusion (att barnet vägrar bröstet efter att ha fått flaska) diskuteras ofta men är sannolikt inte lika vanligt som man trott. Det handlar oftare om flödespreferens: flaskan ger snabbare och enklare flöde, och barnet föredrar det. Paced bottle feeding och napp med långsamt flöde minskar denna risk.

Om du vill avvänja gradvis: ersätt en amning i taget med flaska, med 3-5 dagars mellanrum. Börja med den amning som barnet verkar minst intresserat av. Behåll morgon- och kvällsamningen sist. Din kropp anpassar sig gradvis och risken för mjölkstockning minimeras.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar som flaskmatar delar i forum:",
                consensus: "De flesta betonar att skulden över att inte amma var det värsta, inte flaskmatningen i sig. Att flaskmatning ger partnern möjlighet att delta och ger mamman mer frihet lyfts som stora fördelar.",
                quotes: [
                    "– Jag kunde inte amma. Grät i en vecka. Sedan: min dotter mår fantastiskt bra på ersättning, min man kunde mata, och jag fick sova. Det blev bra.",
                    "– Paced bottle feeding var nyckeln. Vår dotter fick mindre gasbesvär och åt långsammare. Alla borde lära sig tekniken!",
                    "– Kombinationsmatning fungerade perfekt för oss. Amning morgon och kväll, ersättning på dagis. Bästa av två världar."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "WHO/FAO: Safe preparation, storage and handling of powdered infant formula (2007).",
                "EFSA Scientific Opinion on infant and follow-on formulae (2014).",
                "1177 Vårdguiden: Modersmjölksersättning (2023).",
                "Li R et al. (2012). Bottle-feeding practices during early infancy and eating behaviors at 6 years of age. Pediatrics, 129(2):e302-e308."
            ]
        ),

        // MARK: Article 18 – Matintroduktion BLW
        Article(
            id: "feeding_blw",
            category: .feeding,
            title: "Matintroduktion och BLW",
            subtitle: "Börja med fast föda – traditionellt eller barnledd",
            icon: "fork.knife",
            readTimeMinutes: 7,
            intro: "Runt 6 månaders ålder är de flesta barn redo att börja med fast föda. I Sverige rekommenderas smakportioner från 6 månader, men vissa barn kan vara redo redan vid 4 månader. Baby-led weaning (BLW), där barnet äter fingervänlig mat istället för puréer, har blivit alltmer populärt. Här går vi igenom både traditionell matintroduktion och BLW med fokus på vad forskningen visar.",
            sections: [
                ArticleSection(
                    heading: "När är barnet redo?",
                    body: """
Tecken på mognad för fast föda: barnet kan sitta med stöd och hålla huvudet stadigt, har tappat tungans framstötningsreflex (reflexen att skjuta ut mat ur munnen), visar intresse för andras mat, och kan gripa och föra föremål till munnen. Alla dessa tecken bör vara uppfyllda, inte bara ett eller två.

WHO rekommenderar exklusiv amning i 6 månader, medan Livsmedelsverket i Sverige säger att smakportioner kan introduceras från 4 månaders ålder, men att merparten av näringen bör komma från bröstmjölk eller ersättning till 6 månader. I praktiken passar det de flesta barn att börja vid 5-6 månader.

Det finns ingen fördel med att vänta längre än 6 månader. Tvärtom: järnlagren som barnet fått med sig från fostertiden börjar sina vid 4-6 månaders ålder, och bröstmjölk innehåller relativt lite järn. Fördröjd matintroduktion ökar risken för järnbrist, som kan påverka den kognitiva utvecklingen.

Tidpunkten för matintroduktion påverkar inte allergirisken. Tidigare trodde man att fördröjning minskade risken, men modern forskning visar tvärtom: tidig introduktion av allergena livsmedel (jordnötter, ägg, fisk, sesam) kan minska allergirisken. Ingen mat behöver undvikas på grund av allergirädsla, med undantag av honung (botulismrisk) under första året.
"""
                ),
                ArticleSection(
                    heading: "Traditionell matintroduktion med puréer",
                    body: """
Den traditionella metoden börjar med slät gröt och puréer och ökar gradvis i textur. Livsmedelsverket rekommenderar att börja med järnrik mat: järnberikad gröt, köttmos, bönpuré eller tofu. Sedan introduceras grönsaker, frukt, rotfrukter och fisk.

Introduktionstakten: börja med en ny smak i taget, 1-2 teskedar, och öka gradvis. Erbjud samma mat flera gånger: barn kan behöva smaka en ny mat 10-15 gånger innan de accepterar den. Tidpunkten på dagen spelar mindre roll, men många väljer lunchtid.

Texturprogression: slät purée vid start, sedan grovt mosad mat vid 6-7 månader, hackad mat med bitar vid 8-9 månader, och familjemat i lagom storlek vid 10-12 månader. Att stanna vid puréer för länge (efter 9 månader) kan fördröja tuggfärdighetsutvecklingen och öka risken för matvägrande hos småbarn.

Dryck: vatten i mugg erbjuds vid måltider från 6 månader. Ingen juice behövs. Bröstmjölk eller ersättning förblir huvuddryck under hela första året. Komjölk som dryck rekommenderas inte före 12 månaders ålder men kan användas i matlagning.
"""
                ),
                ArticleSection(
                    heading: "Baby-led weaning (BLW)",
                    body: """
BLW innebär att barnet serveras fingervänlig mat från start, utan puréfas. Barnet äter själv med händerna och bestämmer vad och hur mycket det äter från det som erbjuds. Maten skärs i långa strimlor (större än barnets knytnäve) som barnet kan greppa. Mjuka livsmedel som kokt broccoli, avokadostrimlor, banan och ångad morot är vanliga startlivsmedel.

Forskning (BLISS-studien, 2016) visar att BLW, med fokus på järnrika livsmedel, inte medför ökad kvävningsrisk jämfört med traditionell matintroduktion, och att barn som gör BLW inte har lägre viktutveckling. BLW-barn visar bättre självreglering av matintaget och kan ha mindre kräsenhet som småbarn.

Säkerhet vid BLW: lär dig skillnaden mellan gag (en skyddande reflex där barnet hostar fram mat som kommit för långt bak i munnen, vanligt och ofarligt) och kvävning (tyst, barnet kan inte andas, kräver ingripande). Gag-reflexen sitter längre fram på tungan hos spädbarn, vilket ger extra skydd. Undvik högrisklivsmedel: hela druvor, hela nötter, rund korv, hela vindruvor, popcorn.

Barnet ska alltid sitta upprätt vid matning, aldrig i bilbarnstol eller liggande. Lämna aldrig barnet ensamt med mat. Det kan vara klokt att gå en HLR-kurs (hjärt-lungräddning) för barn innan du börjar med BLW, för tryggheten.
"""
                ),
                ArticleSection(
                    heading: "Järn och andra viktiga näringsämnen",
                    body: """
Järn är det mest kritiska näringsämnet vid matintroduktion. Järnbrist är den vanligaste näringsbristsjukdomen globalt och kan påverka barnets kognitiva utveckling, motorik och immunförsvar. Fullgångna barn har järnlager som räcker till ungefär 6 månaders ålder, därefter behöver järn komma via kosten.

Järnrika livsmedel att prioritera: rött kött (bästa källan, hemjärn som absorberas effektivt), kyckling, fisk, bönor, linser, kikärter, tofu, järnberikad gröt, och spenat. C-vitamin (frukt och grönsaker) ökar järnupptaget, medan mejeriprodukter och te minskar det. Kombinera järnrik mat med C-vitaminkälla.

D-vitamin: alla barn i Sverige rekommenderas D-vitamindroppar (10 mikrogram dagligen) från 1 veckas ålder till 2 års ålder, oavsett om de ammas eller flaskmatas. Svensk vinter ger otillräcklig solexponering för egen D-vitaminproduktion.

Omega-3-fettsyror (DHA) är viktiga för hjärnans och ögats utveckling. Fisk 2-3 gånger per vecka rekommenderas från 6 månaders ålder. Undvik dock viss rovfisk (svärdfisk, haj, storögd tonfisk) på grund av kvicksilver. Lax, torsk, sej och sill är utmärkta val.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar om matintroduktion:",
                consensus: "BLW har många entusiastiska anhängare men kombinationsmetoden (puré plus fingervänlig mat) beskrivs av många som den mest praktiska. Att slappna av och inte stressa kring mängden framhålls ofta.",
                quotes: [
                    "– BLW var fantastiskt men stökigt. Min dotter älskade att äta själv från dag 1. Plasta in köket och slappna av!",
                    "– Vi blandade: gröt och purée till lunch, BLW-mat till middag. Det passade oss perfekt och han fick det bästa av båda.",
                    "– Järnbrist vid 9-månaders kontrollen trots amning. Visade sig att vi glömt fokusera på järnrik mat. Nu äter hon köttfärs och bönor dagligen."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Daniels L et al. (2015). Baby-Led Introduction to SolidS (BLISS) study. BMC Pediatrics, 15:179.",
                "Livsmedelsverket: Bra mat för barn 0-5 år (2023).",
                "Du Toit G et al. (2015). Randomized trial of peanut consumption in infants at risk for peanut allergy (LEAP). NEJM, 372(9):803-813.",
                "Fewtrell M et al. (2017). Complementary feeding: a position paper by ESPGHAN. JPGN, 64(1):119-132."
            ]
        ),

        // MARK: Article 19 – Allergier och mat
        Article(
            id: "feeding_allergies",
            category: .feeding,
            title: "Allergier och mat hos barn",
            subtitle: "Förebygga, upptäcka och hantera matallergi",
            icon: "exclamationmark.triangle.fill",
            readTimeMinutes: 6,
            intro: "Matallergi drabbar uppskattningsvis 6-8 % av barn under 3 år i Sverige. De vanligaste allergenerna är komjölk, ägg, jordnötter, trädnötter, soja, vete, fisk och skaldjur. Forskningen har förändrats dramatiskt de senaste åren: vi vet nu att tidig introduktion av allergena livsmedel sannolikt minskar risken, inte ökar den. Här går vi igenom aktuell evidens.",
            sections: [
                ArticleSection(
                    heading: "Nya rön om allergiförebyggande",
                    body: """
LEAP-studien (Learning Early About Peanut Allergy, 2015) visade att tidig introduktion av jordnötter till högriskbarn (barn med svårt eksem eller äggallergi) minskade risken för jordnötsallergi med 80 % jämfört med att undvika jordnötter till 5 års ålder. Studien revolutionerade rekommendationerna världen över.

EAT-studien (Enquiring About Tolerance, 2016) undersökte tidig introduktion av sex allergena livsmedel (jordnötter, ägg, mjölk, sesam, fisk och vete) från 3 månaders ålder. Studien visade trend mot minskad allergiutveckling, särskilt för jordnötter och ägg, hos barn som åt tillräckliga mängder.

Svenska rekommendationer har anpassats: Livsmedelsverket rekommenderar att introducera alla vanliga livsmedel, inklusive allergena, gradvis från 4-6 månaders ålder. Det finns inget skäl att undvika specifika livsmedel eller introducera dem i en viss ordning. Undantaget är om barnet redan reagerat på ett livsmedel.

Det finns ingen evidens för att amning i sig förebygger allergi, men exklusiv amning under de första 4-6 månaderna rekommenderas av andra skäl. Hypoallergen (HA) ersättning har inte övertygande visat sig minska allergirisken hos högriskbarn, och rekommenderas inte längre rutinmässigt.
"""
                ),
                ArticleSection(
                    heading: "Symtom och diagnostik",
                    body: """
Matallergi kan vara IgE-medierad (snabb reaktion) eller icke-IgE-medierad (fördröjd reaktion). IgE-medierad allergi ger symtom inom minuter till 2 timmar: klåda i munnen, nässelutslag, svullnad i läppar/ansikte, kräkningar, andningsbesvär, och i allvarliga fall anafylaxi. Icke-IgE-medierad allergi ger symtom inom timmar till dagar: magbesvär, diarré, eksem, blod i avföringen.

Komjölksproteinintolerans (CMPA) är den vanligaste matallergin hos spädbarn och drabbar 2-3 %. Symtom kan vara kolik, spottighet, diarré, blod i avföringen, eksem och dålig viktuppgång. Diagnos ställs genom eliminations-provokationstest: ta bort komjölk ur kosten i 2-4 veckor och se om symtomen förbättras, sedan återintroducera och se om de återkommer.

Utredning: pricktest (skin prick test) och blodprov (specifikt IgE) kan stödja diagnosen vid IgE-medierad allergi, men ett positivt test bevisar inte allergi, och ett negativt utesluter inte det. Dubbelblindt placebokontrollerat provokationstest (DBPCFC) är golden standard men görs sällan i klinisk praxis.

Många barn växer ifrån sina allergier: 80 % av komjölks- och äggallergiker tolererar livsmedlet vid 5 års ålder. Jordnöts- och trädnötsallergi har lägre remissionsfrekvens (20-30 %). Regelbunden uppföljning med provokationer på klinik avgör när barnet kan börja äta livsmedlet igen.
"""
                ),
                ArticleSection(
                    heading: "Praktisk hantering av matallergi",
                    body: """
Elimination: vid bekräftad allergi ska livsmedlet undvikas helt. Läs ingrediensförteckningar noga: allergener ska deklareras enligt lag, men kontaminering under tillverkning deklareras inte alltid. Uttalanden som kan innehålla spår av är frivilliga och inte standardiserade.

Näring vid elimination: att ta bort komjölk kräver att kalciumbehovet täcks genom andra källor (berikade havredrycker, mandeldryck, tofu, broccoli, bönor) eller kalciumtillskott. En dietist bör vara involverad vid elimination av flera livsmedel. Tillväxtkontroll vid BVC är extra viktig.

Dagis och skola: informera personal skriftligt om allergin, symtom och åtgärdsplan. Barn med risk för anafylaxi ska ha en individuell handlingsplan och adrenalinpenna (EpiPen) lättillgänglig. Personalen ska vara utbildad i att ge den.

Psykologisk aspekt: matallergi påverkar hela familjen. Barnet kan känna sig annorlunda, utanför på kalas, och rädd för att äta. Normalisera och inkludera: ta med säker mat till kalas, involvera barnet i matlagning, och prata öppet men utan att skrämma.
"""
                ),
                ArticleSection(
                    heading: "Laktosintolerans vs komjölksallergi",
                    body: """
Det är viktigt att skilja mellan laktosintolerans och komjölksproteinalleri, som ofta blandas ihop. Laktosintolerans innebär brist på enzymet laktas som bryter ner mjölksocker (laktos). Symtomen är gasbildning, kramper och diarré, men inte farligt. Komjölksproteinallegi är en immunreaktion mot proteinet i mjölken och kan vara allvarlig.

Primär laktosintolerans (genetisk) är ovanlig hos barn under 5 år. De flesta européer har faktiskt laktos-tolerans som vuxna. Tillfällig laktosintolerans kan uppstå efter magsjuka, då tarmslemhinnan som producerar laktas är skadad. Den läker inom 1-2 veckor.

Hos spädbarn med symtom som tolkas som laktosintolerans är det nästan alltid komjölksproteinalleri som är den egentliga orsaken. Att byta till laktosfri mjölk hjälper sällan, eftersom proteinet kvarstår. Extensivt hydrolyserad ersättning, där proteinet är nedbrutet, är rätt behandling.

Utredningen bör alltid gå via barnläkare eller BVC-sköterska, inte via egna experiment med kosten. Felaktig elimination kan leda till näringsbrist, och self-diagnosis kan missa den verkliga orsaken till symtomen.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar till barn med allergier delar i forum:",
                consensus: "De flesta betonar att utredningen kan ta tid och att det krävs tålamod. Att barnet ofta växer ifrån allergin ger hopp. Stöd från andra allergifamiljer värderas högt.",
                quotes: [
                    "– Min son reagerade på ägg vid 7 månader. Nässelutslag överallt inom 10 minuter. Skrämmande men vi lärde oss hantera det. Nu vid 4 år äter han ägg utan problem!",
                    "– CMPA-resan var lång. Tre olika ersättningar innan vi hittade rätt. Men vid 2 år klarade hon provokation och nu dricker hon vanlig mjölk.",
                    "– Tidig introduktion av jordnötter (som smör på gröt) trots att vi hade allergi i familjen. Barnläkaren rekommenderade det. Inga problem alls."
                ],
                source: "Källa: Familjeliv.se, Astma- och Allergiförbundet"
            ),
            sources: [
                "Du Toit G et al. (2015). LEAP study. NEJM, 372(9):803-813.",
                "Perkin MR et al. (2016). EAT study. NEJM, 374(18):1733-1743.",
                "Livsmedelsverket: Allergi och mat för spädbarn (2023).",
                "Koletzko S et al. (2012). Diagnostic approach and management of cow's-milk protein allergy in infants and children. JPGN, 55(2):221-229."
            ]
        ),

        // MARK: Article 20 – Kräsna barn
        Article(
            id: "feeding_picky",
            category: .feeding,
            title: "Kräsna barn – strategier och perspektiv",
            subtitle: "Hantera matvägran utan konflikter vid matbordet",
            icon: "hand.raised.fill",
            readTimeMinutes: 6,
            intro: "Kräsenhet, eller selektiv matning, är extremt vanligt och drabbar 20-50 % av alla barn i förskoleåldern. Det brukar kulminera runt 2-3 års ålder och är i de allra flesta fall en normal utvecklingsfas som hänger samman med barnets ökande självständighet och en evolutionär försiktighet mot nya smaker. Att förstå mekanismerna bakom kräsenheten kan minska stressen vid matbordet.",
            sections: [
                ArticleSection(
                    heading: "Varför blir barn kräsna?",
                    body: """
Neofobi, rädsla för ny mat, är en evolutionärt utvecklad skyddsmekanism. Under människans tidiga historia var det farligt för små barn att äta okända växter och bär, och barn som var skeptiska överlevde i högre utsträckning. Neofobin aktiveras runt 18-24 månaders ålder, precis när barnet börjar röra sig mer självständigt, och avtar gradvis under skolåldern.

Smaksinnet förändras med åldern. Barn har fler smakreceptorer än vuxna, vilket innebär att starka smaker (bitter, syrligt) upplevs intensivare. Grönsaker, särskilt gröna bladgrönsaker, har naturligt bittra ämnen som barn är biologiskt programmerade att ogilla. Det är inte tjurighet utan fysiologi.

Kognitiv utveckling spelar också in. Vid 2-3 års ålder genomgår barnet en fas av ökad autonomi och kontrollbehov. Mat är ett av de få områden där barnet har verklig makt: du kan inte tvinga ett barn att äta. Matvägran kan vara ett uttryck för normal självständighetsutveckling, inte ett problem som behöver lösas.

Sensorisk överkänslighet kan göra vissa barn extra känsliga för textur, konsistens och utseende. Ett barn som vägrar mat med vissa texturer (till exempel grötig konsistens) kan ha sensoriska utmaningar som är mer än vanlig neofobi. Om extremt begränsat matintag påverkar tillväxten bör det utredas.
"""
                ),
                ArticleSection(
                    heading: "Division of Responsibility – Ellyn Satters modell",
                    body: """
Ellyn Satters Division of Responsibility (sDOR) är den mest evidensbaserade modellen för barns matning och rekommenderas av de flesta barnhälsoorganisationer. Principen är enkel: föräldern bestämmer vad, när och var maten serveras. Barnet bestämmer om det vill äta och hur mycket.

I praktiken innebär det: servera varierad, näringsrik mat vid regelbundna måltider och mellanmål (vanligtvis 3 huvudmål och 2-3 mellanmål). Inkludera alltid något du vet att barnet äter på tallriken. Sätt inga krav på att smaka, prova eller äta en viss mängd. Ingen belöning för att äta (inte heller glass som belöning för att äta grönsaker).

Forskning visar att press att äta, oavsett om det är uppmuntring, tjatande, lockande eller tvingande, har motsatt effekt på lång sikt. Barn som pressas att äta utvecklar mer negativa associationer till mat, äter mindre varierat och har högre risk för ätstörningar som vuxna.

Modellen kräver tillit: tillit till att barnet kan reglera sitt intag, och tillit till att exponering över tid leder till acceptans. Ett barn som aldrig pressas men konsekvent exponeras för ny mat vid måltiderna kommer gradvis att bredda sin repertoar. Det kan ta veckor eller månader, men det fungerar.
"""
                ),
                ArticleSection(
                    heading: "Praktiska strategier",
                    body: """
Upprepad exponering: forskning visar att barn kan behöva exponeras för en ny mat 10-15 gånger (se, lukta, röra, smaka) innan de accepterar den. Exponering betyder inte att barnet måste äta: bara att maten finns på tallriken. Ingen kommentar behövs. Servera samma grönsak på olika sätt: rå, kokt, stekt, i soppa, på pizza.

Involvera barnet i matlagning: barn som deltar i att laga maten äter mer varierat enligt studier. Låt barnet välja grönsaker i affären, tvätta sallad, röra i grytan. Känslan av delaktighet och kontroll minskar rädslan för okänd mat.

Ät tillsammans: barn är starka imitatörer. Om de ser föräldrar och syskon äta varierat och med glädje ökar sannolikheten att de gör detsamma. Familjemåltider med samma mat till alla (anpassad konsistens vid behov) skickar signalen att det här är vad vi äter.

Undvik att laga specialmat åt det kräsna barnet. Det förstärker beteendet och skapar en ond cirkel. Servera familjemat med minst en komponent du vet att barnet accepterar. Om barnet inte äter något, tillåt det utan dramatik. Det äter vid nästa måltid. Barn svälter inte frivilligt.
"""
                ),
                ArticleSection(
                    heading: "När bör du söka hjälp?",
                    body: """
Normal kräsenhet påverkar inte tillväxten, den allmänna hälsan eller den sociala funktionen. Barnet äter begränsat men tillräckligt. Om du är orolig, börja med att föra matdagbok i en vecka: föräldrar underskattar ofta vad barnet faktiskt äter under en hel dag, och mängden kan vara mer adekvat än det verkar.

Sök hjälp om: barnet äter färre än 20 olika livsmedel, barnet utesluter hela matgrupper (till exempel all frukt, alla proteinkällor), viktkurvan knäcker, barnet har kräkningsreflex vid synen av viss mat, måltiderna konsekvent tar mer än 30 minuter med strid, eller barnet verkar ha sensoriska problem med textur.

ARFID (Avoidant/Restrictive Food Intake Disorder) är en ätstörningsdiagnos som beskriver extremt selektiv matning som påverkar näringsstatus, tillväxt eller psykosocial funktion. Det skiljer sig från normal kräsenhet genom allvarlighetsgrad och påverkan. Utredning görs via barnläkare med remiss till ätstörningsenhet.

BVC-sköterskan är din första kontakt. Hon kan bedöma tillväxt, ge individanpassade råd och vid behov remittera till dietist eller barnläkare. Att prata om oron tidigt är alltid bättre än att vänta.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar till kräsna barn delar i forum:",
                consensus: "Att sluta kämpa vid matbordet beskrivs som det bästa beslutet av många. Division of Responsibility nämns ofta som en vändpunkt. Tålamod och långsiktighet är ledorden.",
                quotes: [
                    "– Sonen åt bara vit mat i 6 månader. Pasta, bröd, ris. Jag slutade tjata, fortsatte servera grönsaker, och vid 3,5 åt han broccoli frivilligt. Det tog tid men det gick.",
                    "– Ellyn Satters modell räddade våra måltider. Jag bestämmer vad, hon bestämmer om. Ingen gråt, inga strider, och hon äter faktiskt MER nu.",
                    "– Min kräsna dotter är nu 7 och äter det mesta. Alla som sa 'det går över' hade rätt. Men det var svårt att tro på det när hon var 2."
                ],
                source: "Källa: Familjeliv.se, Alltforforaldrar.se"
            ),
            sources: [
                "Satter E (2007). Eating Competence: definition and evidence for the Satter Eating Competence Model. Journal of Nutrition Education and Behavior.",
                "Dovey TM et al. (2008). Food neophobia and 'picky/fussy' eating in children: a review. Appetite, 50(2-3):181-193.",
                "Taylor CM et al. (2015). Picky/fussy eating in children: review of definitions, assessment, prevalence and dietary intakes. Appetite, 95:349-359.",
                "Livsmedelsverket: Bra mat för barn 0-5 år (2023)."
            ]
        ),

        // =====================================================================
        // MARK: FÖRÄLDRAHÄLSA (5 articles)
        // =====================================================================

        // MARK: Article 21 – Sömnbrist
        Article(
            id: "parenthealth_sleep_deprivation",
            category: .parentHealth,
            title: "Sömnbrist och hur du hanterar det",
            subtitle: "Praktiska strategier för utmattade föräldrar",
            icon: "moon.zzz.fill",
            readTimeMinutes: 5,
            intro: "Sömnbrist är en av de svåraste utmaningarna med ett litet barn. Att förstå vad som händer i kroppen och lära sig strategier för att hantera det kan göra stor skillnad för hela familjens välmående.",
            sections: [
                ArticleSection(
                    heading: "Vad händer i kroppen vid sömnbrist?",
                    body: """
Sömnbrist påverkar i stort sett alla kroppsfunktioner. Redan efter 17-19 timmars vakenhet försämras reaktionsförmåga, beslutsfattande och emotionell reglering lika mycket som vid en promille i blodet. Det här förklarar varför du kan bli omotiverat irriterad över bagateller eller gråta av att du spillt kaffe.

Kortisol, stresshormonet, stiger vid sömnbrist. Det ökar hunger – särskilt efter socker och kolhydrater – och försämrar immunförsvaret. Kronisk sömnbrist ökar risken för depression, ångest och hjärt-kärlsjukdom. Det är alltså inte "bara trötthet".

Minnet konsolideras under sömnen, vilket är varför allt känns suddigt och du glömmer saker hela tiden. Det är biologiskt, inte ett tecken på att du håller på att bli dement. Hjärnan sorterar och lagrar information under djupsömnen som du just nu inte får tillräckligt av.

Det positiva: hjärnan är anpassningsbar. Föräldrar lär sig att fungera med fragmenterad sömn. Och det tar slut – barnet kommer med tid att sova mer sammanhängande. Du klarar av det.
"""
                ),
                ArticleSection(
                    heading: "Strategier som faktiskt hjälper",
                    body: """
Sov när bebisen sover – det klassiska rådet låter enkelt men är svårt att följa när du vill ha lite tid för dig själv. Prioritera i alla fall ett tuppluret per dag, helst 20-30 minuter på förmiddagen när kortisol naturligt är högt och insomnandet är lättare.

Dela på natten med din partner. En person ansvarar fram till ett visst klockslag, den andra tar resten. Det ger var och en ett sammanhängande sömnblock. En "rak" natt varannan natt är bättre än halvdålig sömn varje natt.

Om du ammar: låt partnern lägga om och byta blöja – du kan sova medan. Om ni flaskmatar, ta tydliga skift. Dokumentera vem som var uppe sist – trötthetsminnet är opålitligt och kan skapa onödiga konflikter.

Avsäga vardagsuppgifter. Huset behöver inte vara perfekt. Mat kan beställas eller vara enkel. Be om och ta emot hjälp från familj och vänner. Många vill hjälpa men vet inte hur – ge dem konkreta uppgifter: "Kan du komma och hålla bebisen i två timmar på lördag?"

Koffein med omdöme. En kopp kaffe på morgonen hjälper. Koffein efter klockan 14 saboterar den sömn du faktiskt kan få på natten. Prioritera sömnkvaliteten när du väl sover.
"""
                ),
                ArticleSection(
                    heading: "Mental hälsa under sömnbrist",
                    body: """
Det är normalt att känna sig överväldigad, tom och irriterad under svåra sömnperioder. Det är viktigt att skilja på normal trötthet och depression. Baby blues (de första 2 veckorna) är hormonellt och går över. Förlossningsdepression håller i sig längre och kräver stöd.

Varningssignaler att ta på allvar: ihållande hopplöshetskänslor som varar mer än 2 veckor, oförmåga att bry sig om eller knyta an till barnet, tankar om att skada dig själv eller barnet, extrem ångest och oroliga tankar som inte går att kontrollera. Sök hjälp vid dessa symtom – prata med barnmorskan, BVC eller din läkare.

Ta hand om det grundläggande. Ät regelbundna måltider – hoppa inte över frukost. Rör på dig, även kort promenad med vagnen räknas och förbättrar humöret märkbart. Ha kontakt med andra vuxna – isolering förvärrar allt.

Prata med din partner om hur ni mår. Sömnbrist ökar konflikter i relationer. Schemalägg tid att prata, inte om logistik utan om hur ni faktiskt har det. Ni är ett lag, inte motståndare.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina erfarenheter av sömnbrist:",
                consensus: "Att ta hjälp och dela på natten lyfts som det viktigaste. Många önskar att de hade prioriterat sömn framför att hålla ordning.",
                quotes: [
                    "– Vi delade upp natten strikt. Jag till 02, han från 02. Det räddade oss och vår relation.",
                    "– Slutade städa. Lät maten vara enkel. Sov varje chans jag fick. Bebisen brydde sig inte om att disken stod.",
                    "– Tröttast jag någonsin känt men också starkast. Man klarar mer än man tror."
                ],
                source: "Källa: Familjeliv.se, Rikshandboken Barnhälsovård"
            ),
            sources: [
                "Harrison Y, Horne JA (2000). The impact of sleep deprivation on decision making: A review. Journal of Experimental Psychology Applied.",
                "Goyal D et al. (2009). Fragmented Maternal Sleep Is More Strongly Correlated With Depressive Symptoms Than Infant Temperament at Three Months Postpartum. Archives of Women's Mental Health."
            ]
        ),

        // MARK: Article 22 – Baby blues vs förlossningsdepression
        Article(
            id: "parenthealth_baby_blues_ppd",
            category: .parentHealth,
            title: "Baby blues vs. förlossningsdepression",
            subtitle: "Vad är skillnaden och när ska du söka hjälp?",
            icon: "heart.text.clipboard.fill",
            readTimeMinutes: 6,
            intro: "Upp till 80 procent av alla nyblivna mammor upplever baby blues. Förlossningsdepression är vanligare än de flesta tror och drabbar 10-15 procent av mammor och 5-10 procent av pappor. Att kunna skilja på dem är viktigt.",
            sections: [
                ArticleSection(
                    heading: "Baby blues – den hormonella dipp",
                    body: """
Baby blues är en hormonell reaktion som uppstår dagarna efter förlossningen. Under graviditeten är östrogen och progesteron kraftigt förhöjda. Dagen efter förlossningen rasar nivåerna dramatiskt – det är en av de kraftigaste hormonella förändringarna en människa kan uppleva. Resultatet är en period av tårar, känslosvängningar, irritabilitet och känslighet som kan verka oproportionerlig.

Baby blues börjar vanligtvis dag 2-5 efter förlossningen och kulminerar runt dag 3-4. Det är inte ovanligt att gråta av att solen lyser, att vara överväldigad av kärlek och sedan sekunden efter överväldigad av rädsla, att sova dåligt trots trötthet och att känna sig inkompetent trots att du gör ett fantastiskt jobb.

Baby blues kräver ingen behandling. Det löser sig inom 10-14 dagar i takt med att hormonerna stabiliseras. Det hjälper med sömn, näring, stöd från partner och familj, och vetskapen om att det är normalt och tillfälligt.

Gränsen mot förlossningsdepression är om symtomen inte avtar efter 2 veckor, utan snarare förvärras.
"""
                ),
                ArticleSection(
                    heading: "Förlossningsdepression – vad det är och inte är",
                    body: """
Förlossningsdepression (PPD, postpartum depression) är en klinisk depression som uppstår inom ett år efter förlossningen, vanligast de första 3 månaderna. Det är inte ett tecken på svaghet, dålig föräldraförmåga eller att du inte älskar ditt barn. Det är en sjukdom med neurologiska och hormonella orsaker som svarar väl på behandling.

Symtom på förlossningsdepression: nedstämdhet som varar mer än 2 veckor, ointresse för barnet eller svårt att knyta an, intensiv oro och ångest (ibland mer framträdande än nedstämdheten), sömnproblem som inte enbart beror på barnets vakennätter, irritabilitet och ilska utöver det vanliga, skuld- och skamkänslor, känsla av att vara en dålig förälder eller att barnet vore bättre utan dig.

Risken ökar vid: tidigare depression eller ångest, sömnbrist, relationskonflikter, socioekonomisk stress, svår förlossning eller komplikationer, brist på socialt stöd, och amningsproblem kombinerat med höga förväntningar på sig själv.

Förlossningsdepression hos pappor och icke-bärande partners är lika verklig men ofta oupptäckt eftersom symtomen kan se annorlunda ut: irritabilitet, aggressivitet, ökat alkoholintag, undvikande av familjen, eller att begrava sig i jobb.
"""
                ),
                ArticleSection(
                    heading: "Behandling och var du söker hjälp",
                    body: """
Förlossningsdepression är behandlingsbar. Det fungerar inte att "kämpa sig igenom" utan stöd. Ju tidigare du söker hjälp, desto snabbare mår du bättre.

Behandlingsalternativ inkluderar: samtalsterapi, framför allt KBT och interpersonell terapi, antidepressiva läkemedel (flera är säkra vid amning), stödgrupper för nyblivna föräldrar, och kombinationer av dessa.

Var söker du hjälp? BVC-sköterskan screenar för PPD med Edinburgh-formuläret (EPDS) vid 6-8 veckors besöket. Du kan ta upp symtom vid vilket BVC-besök som helst. Din barnmorska under graviditet och de första veckorna. Vårdcentralen – boka tid med läkare och berätta hur du mår. Du ska inte behöva motivera att du behöver hjälp. Akutmottagningen om du har tankar på att skada dig själv eller barnet.

EPDS-formuläret (Edinburgh Postnatal Depression Scale) kan du fylla i hemma. Om du poängar högt, sök hjälp omgående. Det är ett screeningverktyg, inte en diagnos, men ett viktigt verktyg för att fånga upp dem som mår dåligt.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar erfarenheter av PPD:",
                consensus: "Att söka hjälp tidigt och att inte skämmas beskrivs som avgörande. Att veta att man inte är ensam hjälper.",
                quotes: [
                    "– Jag trodde jag var den enda som inte kände den där kärleken direkt. Det tog 3 veckor för mig. Det är OK.",
                    "– Sökte hjälp vid 8 veckor. KBT och antidepressiva. Kände mig som mig själv igen vid 4 månader. Önskar att jag sökt tidigare.",
                    "– Min man fick PPD. Han grät aldrig men var borta mentalt. Terapi hjälpte enormt. Pappor glöms bort i det här samtalet."
                ],
                source: "Källa: Mind.se, 1177.se, Rikshandboken Barnhälsovård"
            ),
            sources: [
                "Cox JL et al. (1987). Detection of postnatal depression. Development of the 10-item Edinburgh Postnatal Depression Scale. British Journal of Psychiatry.",
                "Paulson JF, Bazemore SD (2010). Prenatal and Postpartum Depression in Fathers and Its Association With Maternal Depression. JAMA.",
                "SBU (2014). Behandling av depression och ångest hos gravida och ammande."
            ]
        ),

        // MARK: Article 23 – Partnerstöd
        Article(
            id: "parenthealth_partner_support",
            category: .parentHealth,
            title: "Partnerstöd under graviditet och efter förlossning",
            subtitle: "Hur du som partner kan göra verklig skillnad",
            icon: "figure.2.arms.open",
            readTimeMinutes: 5,
            intro: "Den gravida eller just förlösta personens välmående påverkas starkt av partnerns stöd. Forskning visar att aktivt, konkret partnerstöd minskar risken för förlossningsdepression, stärker anknytningstrygghet och förbättrar relationskvaliteten. Det handlar inte om att göra allt rätt – utan om att vara genuint närvarande.",
            sections: [
                ArticleSection(
                    heading: "Under graviditeten",
                    body: """
Att vara partner under en graviditet innebär att gå bredvid en stor fysisk och emotionell förändring du inte själv upplever inifrån. Det kan kännas svårt att veta vad du ska göra. Det viktigaste är att fråga – inte anta.

Praktiskt stöd: ta över uppgifter som blivit svåra att utföra, som att bära tunga saker, stå länge vid spisen eller sova bekvämt. Följ med på läkarbesök och ultraljud när det är möjligt. Det visar engagemang och ger dig inblick i vad som händer.

Emotionellt stöd: lyssna utan att lösa. Graviditet innebär oro, ambivalens och hormonella humörsvängningar. Din roll är att lyssna, validera och inte avfärda. "Jag förstår att det känns svårt" räcker långt. Undvik att jämföra med hur andras graviditeter ser ut.

Informera dig: läs på om graviditet, förlossning och nyfödda. Ju mer du kan, desto mer kompetent och involverad kan du vara. Gå föräldraförberedelsekursen. Delta aktivt, inte som observatör.

Prata om förväntningar: hur ska ni dela på ansvaret efter förlossningen? Vem tar föräldraledighet och när? Diskutera detta i god tid. Oenighet om rollfördelning är en av de vanligaste orsakerna till relationsstress det första året.
"""
                ),
                ArticleSection(
                    heading: "Under förlossningen",
                    body: """
Din närvaro under förlossningen spelar stor roll. Studier visar att kontinuerligt stöd under förlossning – vare sig från partner, doula eller barnmorska – minskar behovet av smärtlindring, förkortar förlossningen och ökar upplevelsen av kontroll.

Du behöver inte göra något speciellt. Var där. Håll handen. Ge massage om det önskas. Håll vatten och is. Hecka inte – finnas.

Om förlossningen inte går som planerat, stötta beslutsfattandet. Var hennes röst om hon inte kan tala för sig själv. Fråga barnmorskan och läkaren om du inte förstår vad som sker. Det är din rätt och ditt ansvar.

Ta hand om dig själv också – förlossningar kan vara långa och traumatiska. Ät, drick, rör på dig om det finns möjlighet. Om du mår dåligt efter förlossningen är det okej att sätta ord på det.
"""
                ),
                ArticleSection(
                    heading: "De första veckorna hemma",
                    body: """
Det första som händer hemma är att den icke-bärande partnern ofta återgår till arbete inom en till två veckor – medan den som fött är hemma med ett nyfödd barn under hormonell och fysisk återhämtning. Den här perioden kan vara extremt ensam och överväldigande.

Om du är hemma: ta ansvar för hushållet så att den som fött kan fokusera på att återhämta sig och mata barnet. Laga mat. Städa. Ta emot besök och skydda vilobehov. Ha aldrig förväntningar på att hemmet ska vara i ordning.

Om du jobbar: när du kommer hem, avlasta genast. Ta barnet. Fråga "vad behöver du?" – inte "hur ser det ut här?" Aktiv föräldraledighet tidigt bygger kompetens och tillit som håller i sig hela barnets uppväxt.

Tala om din partners psychiska mående. Fråga regelbundet hur hon verkligen mår. Om du märker tecken på förlossningsdepression – uppmuntra och hjälp henne att söka hjälp. Gör det konkret: boka tid, följ med.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Partners delar sina erfarenheter:",
                consensus: "Att vara aktiv och praktiskt involverad – inte bara stödjande i ord – lyfts som det som gör störst skillnad. Det räcker inte att finnas i bakgrunden.",
                quotes: [
                    "– Jag tog en extra veckas tjänstledighet för att vara hemma. Det bästa beslutet jag fattat. Jag lärde mig bebisen och min fru fick sova.",
                    "– Visste inte vad jag skulle göra i förlossningsrummet. Höll hennes hand hela tiden. Efteråt sa hon att det var det viktigaste.",
                    "– Vi hade inte pratat om rollfördelning. Det ledde till konflikter. Gör det INNAN. Seriöst."
                ],
                source: "Källa: Familjeliv.se, Föräldramötet, forskning av John Gottman"
            ),
            sources: [
                "Hodnett ED et al. (2013). Continuous support for women during childbirth. Cochrane Database Syst Rev.",
                "Gottman JM (2011). Bringing Baby Home. The Gottman Institute.",
                "Parfitt Y, Ayers S (2014). Transition to parenthood and mental health in first-time parents. Infant Mental Health Journal."
            ]
        ),

        // MARK: Article 24 – Föräldraidentitet
        Article(
            id: "parenthealth_identity",
            category: .parentHealth,
            title: "Din identitet som förälder",
            subtitle: "Att hitta dig själv i den nya rollen",
            icon: "person.fill.checkmark",
            readTimeMinutes: 5,
            intro: "Att bli förälder är en av livets mest djupgående identitetstransformationer. Psykologer kallar det matrescence (för mammor) och patrescence (för pappor) – en parallellprocess till ungdomens identitetsutveckling. Det är normalt att känna sig vilsen, förändrad och inte igen sig i spegeln.",
            sections: [
                ArticleSection(
                    heading: "Vad är matrescence och patrescence?",
                    body: """
Matrescence, ett begrepp myntat av antropologen Dana Raphael på 1970-talet och populariserat av psykologen Aurélie Athan, beskriver den djupa biopsykosociala förändringen en person genomgår när de blir förälder. Precis som tonåringen förändrar kropp och identitet, förändrar den nya föräldern sitt neurala nätverk, sin hjärnas struktur och sin plats i världen.

Hjärnan förändras faktiskt strukturellt under graviditet och föräldraskap. Grå substans minskar i specifika regioner kopplade till social kognition – inte för att hjärnan "minskar" utan för att den specialiseras. Resultatet är ökad förmåga att läsa barnets signaler och stärkt empatisk förmåga. Den populärt kallade "gravidhjärnan" är en hjärna under omstrukturering, inte en sämre hjärna.

Identitetskrockarna är verkliga: "Vem är jag nu? Är jag samma person jag var? Vad händer med min karriär, mina vänner, mitt förhållande, min kropp, mina drömmar?" Dessa frågor är normala och viktiga. Att ignorera dem leder till oanade spänningar. Att möta dem med nyfikenhet och öppenhet leder till tillväxt.

Det finns ingen rätt tid att "känna sig som förälder". Bonding kan ta tid. Kärlek till sitt barn kan växa gradvis. Det är normalt.
"""
                ),
                ArticleSection(
                    heading: "Att inte förlora sig själv",
                    body: """
En vanlig rädsla – och verklighet – hos nya föräldrar är att den egna personen "sugs upp" av föräldrarollen. Allt handlar om bebisen. Din tid, din kropp, dina tankar. Det är en period av radikal osjälviskhet som kroppen och psyket inte är byggda för att klara hur länge som helst.

Att ta hand om sig själv är inte själviskt. Det är nödvändigt. Ett gammalt uttryck: sätt på din egen syrgasmask först. Du kan inte ge från ett tomt kärl.

Vad hjälper: en aktivitet per vecka som är enbart din. Det behöver inte vara storslaget. En promenad utan barnvagn. En bok du faktiskt läser. En kaffestund med en vän. Något som påminner dig om vem du är utöver förälder.

Behåll eller återuppbygg vänskap. Det sociala nätverket tunnas ut kraftigt det första året. Håll i relationer som ger dig energi. Var ärlig om att du inte har mycket kapacitet just nu – äkta vänner förstår och anpassar sig.

Prata med din partner om hur ni bevarar "ni" i vardagen. Inte föräldrarna, utan partnerna. Schemalägg tid för varandra, även om det är 30 minuter på soffan utan telefon.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar tankar om identitetsförändringen:",
                consensus: "Att tillåta sig att sörja sin gamla tillvaro och välkomna den nya beskrivs som en nyckelerfarenhet. Det är inte antingen-eller, utan en gradvis integration.",
                quotes: [
                    "– Grät i månader för att jag saknade mitt gamla jag. Sedan insåg jag att mitt nya jag är rikare. Det tog tid att se.",
                    "– Föräldrarollen rev upp allt. Gamla sår, gamla mönster. Men det gav mig chansen att växa på ett sätt ingenting annat hade gjort.",
                    "– Jag höll på att tappa mig själv helt. Började springa igen vid 4 månader. Det räddade min hälsa och mitt humör."
                ],
                source: "Källa: Aurélie Athan, matrescence.com; Rikshandboken Barnhälsovård"
            ),
            sources: [
                "Athan AM (2016). Matrescence: Lifespan development in the transition to motherhood. In Selin H (Ed.), Parenting Across Cultures.",
                "Hoekzema E et al. (2017). Pregnancy leads to long-lasting changes in human brain structure. Nature Neuroscience.",
                "Coall DA, Hertwig R (2010). Grandparental investment. Behavioral and Brain Sciences."
            ]
        ),

        // MARK: Article 25 – Stress och återhämtning
        Article(
            id: "parenthealth_stress_recovery",
            category: .parentHealth,
            title: "Stress och återhämtning för föräldrar",
            subtitle: "Verktyg för att reglera nervsystemet i vardagen",
            icon: "leaf.fill",
            readTimeMinutes: 5,
            intro: "Föräldrastress är inte ett tecken på svaghet eller att du gör något fel. Det är ett naturligt svar på en krävande situation. Det som avgör hur du mår på lång sikt är inte om du stressar, utan hur väl du återhämtar dig.",
            sections: [
                ArticleSection(
                    heading: "Vad är stress och varför känns det så kroppsligt?",
                    body: """
Stress är nervsystemets alarmberedskap. Amygdala aktiverar det sympatiska nervsystemet – "fight or flight" – och cortisol och adrenalin flödar ut. Hjärtat slår snabbare, musklerna spänner sig, matsmältningen saktas ner. Det här systemet är designat för akut fara, inte för kronisk stress under månader och år.

Föräldrastress triggar samma system: ett skrikande spädbarn aktiverar amygdala precis som ett hot. Det är evolutionärt klokt – babyn behöver din uppmärksamhet. Men om "alarmet" aldrig stängs av, om det inte finns återhämtning, slits systemet ut.

Kronisk stress påverkar: koncentrationsförmåga och minne, humör och emotionell reglering (du blir "kortare"), immunförsvar, sömn, relation och sexliv, och i längden hjärthälsa och metabol hälsa.

Det parasympatiska nervsystemet – "rest and digest" – är din naturliga motreglering. Att aktivera det är återhämtning.
"""
                ),
                ArticleSection(
                    heading: "Praktiska återhämtningsverktyg",
                    body: """
Andning: det snabbaste sättet att aktivera det parasympatiska nervsystemet. Fysiologisk suck (dubbel inandning genom näsan + lång utandning genom munnen) sänker hjärtfrekvensen på sekunder. Box-andning (4 sekunder in, 4 håll, 4 ut, 4 håll) fungerar utmärkt i akut stress.

Rörelse: 20-30 minuters aerob träning minskar kortisol och ökar BDNF (hjärnans tillväxtfaktor) och serotonin. Det behöver inte vara gymträning. Promenad med barnvagnen räknas. Yoga med bebisen räknas. Det som räknas är att det sker regelbundet.

Natur: 20 minuter i natur utan telefon minskar kortisol med mätbara 21 procent (studie från Cornell). En promenad i parken är faktiskt medicinsk återhämtning.

Socialt stöd: att prata med någon du litar på aktiverar oxytocin och motverkar stressrespons. Isolering förstärker stress. Ring en vän. Gå till öppen förskola. Kontakta grannen med bebis.

Mindfulness och meditation: forskning visar att 8 veckor med mindfulness-based stress reduction (MBSR) förändrar hjärnans stressrespons mätbart. Appar som Headspace och Calm har guidade övningar för föräldrar.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina återhämtningsstrategier:",
                consensus: "Rörelse och utomhusvistelse nämns konsekvent som det mest effektiva. Att ha minst en stund per dag för sig själv lyfts som avgörande.",
                quotes: [
                    "– Varje dag, oavsett väder, 30 minuter promenad med vagnen. Det enda som faktiskt hjälpte mot stressen.",
                    "– Började meditera 10 minuter om dagen vid 6-veckorsbesöket. Låter banalt men förändrade verkligen mitt lugn.",
                    "– Öppen förskola räddade min psykiska hälsa. Att träffa andra i samma situation normaliserade allt."
                ],
                source: "Källa: Socialstyrelsen, Stress.se, 1177.se"
            ),
            sources: [
                "Hunter MR et al. (2019). Urban Nature Experiences Reduce Stress in the Context of Daily Life. Frontiers in Psychology.",
                "Hölzel BK et al. (2011). Mindfulness practice leads to increases in regional brain gray matter density. Psychiatry Research: Neuroimaging.",
                "Söderström M et al. (2012). Vilken roll spelar sömn och återhämtning? Stress och utmattning. Karolinska Institutet."
            ]
        ),

        // =====================================================================
        // MARK: EXTRA ARTIKLAR – ÖVRIGA KATEGORIER (5 articles)
        // =====================================================================

        // MARK: Article 26 – Skärmar och barn
        Article(
            id: "development_screens",
            category: .development,
            title: "Skärmar och barn under 3 år",
            subtitle: "Vad forskningen faktiskt säger",
            icon: "iphone.slash",
            readTimeMinutes: 5,
            intro: "Frågan om skärmar och spädbarn är laddad och full av dömande kommentarer i föräldraforum. Vad säger faktiskt forskningen – och hur hittar man en rimlig linje i en digital vardag?",
            sections: [
                ArticleSection(
                    heading: "Rekommendationerna",
                    body: """
WHO, American Academy of Pediatrics och svenska Socialstyrelsen rekommenderar: inga skärmar för barn under 2 år (undantag videochat med familj), och max 1 timme per dag för 2-5-åringar med vuxen tillsammans. Det handlar inte om att skärmar är farliga i sig, utan om möjlighetskostnaden: tid vid skärmen är tid som inte spenderas med aktiviteter som stärker utvecklingen mer.

Under de två första åren är hjärnan under intensiv utveckling. Inlärning sker framför allt genom ömsesidigt samspel: tur-tagning, ögonkontakt, imitation, fysisk utforskning. Skärmar är ett-vägs-kommunikation. Bebisen kan inte interagera med en skärm på det sätt hjärnan behöver.

Passiv skärmtid (bakgrundsteve) påverkar negativt. Studier visar att barn i hem med TV på i bakgrunden har kortare och mer fragmenterade samspelsstunder med sina föräldrar. Det gäller även om barnet inte tittar direkt på skärmen.

Videochat är ett undantag. Barn kan faktiskt lära sig av videosamtal med välbekanta vuxna (mor-och farföräldrar) för att kommunikationen är interaktiv och ömsesidig.
"""
                ),
                ArticleSection(
                    heading: "Praktiska riktlinjer för en digital familj",
                    body: """
Var realistisk. De allra flesta familjer håller inte rekommendationerna strikt. Det viktiga är riktningen, inte perfektion. Skillnaden mellan inga skärmar alls och passiv TV fyra timmar om dagen är enorm. Skillnaden mellan 15 och 30 minuter är liten.

Kvalitet framför kvantitet. Interaktiva appar (som barn-till-barn-samtal eller appar du använder tillsammans) är bättre än passivt tittande. Innehåll anpassat för ålder, utan reklam och med pedagogisk approach, är bättre än slumpmässig YouTube.

Inga skärmar vid måltider. Forskning är tydlig: skärmar vid bordet minskar samtal och samspel, som är avgörande för språkutveckling.

Föregå med gott exempel. Barn gör som du gör, inte som du säger. Om du scrollar i telefonen varje gång du är uttråkad, gör barnet det senare. Ditt eget skärmbeteende är den viktigaste variabeln.

Schemalägg skärmfri tid och skärmtid. Ge tydliga ramar som gäller konsekvent. Det minskar konflikter och skapar förutsägbarhet som barn behöver.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar erfarenheter av skärmregler:",
                consensus: "De flesta håller inte rekommendationerna strikt men uppskattar tydlighet om varför. Konsekvens och struktur lyfts som viktigare än noll-tolerans.",
                quotes: [
                    "– Vi försöker begränsa till 20 minuter per dag och alltid tillsammans. Fungerar hyfsat.",
                    "– Bakgrundsteve hade vi inte tänkt på. Stängde av. Märkte direkt att vi pratade mer.",
                    "– Mor-och farföräldrarna bor långt bort. Dagliga videosamtal är undantaget vi är tacksamma för."
                ],
                source: "Källa: WHO 2019 guidelines, SBU, American Academy of Pediatrics"
            ),
            sources: [
                "WHO (2019). Guidelines on Physical Activity, Sedentary Behaviour and Sleep for Children under 5 Years.",
                "Radesky JS et al. (2015). Patterns of Mobile Device Use by Caregivers and Children During Meals in Fast Food Restaurants. Pediatrics.",
                "Kirkorian HL et al. (2009). The impact of background television on parent-child interaction. Child Development."
            ]
        ),

        // MARK: Article 27 – Amningsproblem
        Article(
            id: "feeding_breastfeeding_challenges",
            category: .feeding,
            title: "Vanliga amningsproblem och lösningar",
            subtitle: "Praktisk guide för de tuffa första veckorna",
            icon: "drop.fill",
            readTimeMinutes: 6,
            intro: "Amning beskrivs ofta som naturligt och enkelt. I verkligheten är det en färdighet som behöver läras in – av både mamma och bebis. Upp till 80 procent av ammande mammor upplever problem de första veckorna. Du är inte misslyckad om det är svårt.",
            sections: [
                ArticleSection(
                    heading: "Ömma och sår bröstvårtor",
                    body: """
Det vanligaste amningsproblemet och ofta det första. Orsakas nästan alltid av felaktigt tag: bebisen tar inte tillräckligt stor del av areolan i munnen, utan suger direkt på bröstvårtan. Det ska inte göra ont vid ett korrekt tag.

Rätt tag: bebisens mun ska vara vidöppen, med läpparna utåtvikta (som en fisk), näsan och hakan mot bröstet, och stora delar av areolan (inte bara bröstvårtan) i munnen. Bebisens haka ska nudda bröstet. Om det gör ont när bebisen tar tag – avbryt suget med ett finger i mungipan och försök igen.

Behandling: låt bröstvårtorna lufttorka efter amning, applicera lite bröstmjölk på huden (har läkande egenskaper), och vid sår kan lansolin-salva (Lansinoh) hjälpa. Bröstvårtsplattor (nipple shields) kan vara ett tillfälligt hjälpmedel men bör användas med stöd från amningsrådgivare för att inte minska mjölkproduktionen.

Sök hjälp av amningsrådgivare (IBCLC) om smärtan kvarstår. Barnmorskor, BVC och amningshjälpen (amningshjälpen.se) kan hjälpa.
"""
                ),
                ArticleSection(
                    heading: "Mjölkstockning och mastit",
                    body: """
Mjölkstockning uppstår när ett mjölkgång blockeras. Symtom: hårt, ömt område i bröstet, eventuellt rödhet. Behandling: fortsätt amma eller pumpa ofta, värm bröstet före amning (varmt bad, varm kompress), massera varsamt mot bröstvårtan under amning.

Mastit är en inflammation i bröstvävnaden, ofta med infektion. Symtom: röd, het, öm bröstet, hård kula, kombinerat med feber, frossa och influensaliknande symtom. Mastit kräver läkarbehandling med antibiotika. Fortsätt amma under behandlingen – det är säkert för bebisen och hjälper bröstets läkning.

Om mastit inte behandlas kan bröstabscess utvecklas. Det är sällsynt men kräver dränering. Sök vård tidigt vid mastitsymtom.

Förebygg: se till att bröstet töms ordentligt, variera amningspositioner så att alla gångar töms, undvik tätta BH-er och press mot bröstet (sovposition).
"""
                ),
                ArticleSection(
                    heading: "Otillräcklig mjölkproduktion",
                    body: """
Uppfattad otillräcklig mjölkproduktion är den vanligaste orsaken till att mammor slutar amma i förtid. I de allra flesta fall är produktionen faktiskt tillräcklig – känslan av att "inte ha mjölk" stämmer inte med verkligheten.

Mjölkproduktionen styrs av tillgång och efterfrågan. Ju mer bebisen suger, desto mer mjölk produceras. Det tar 3-5 dagar efter förlossningen för mjölken att komma in. Dessförinnan produceras råmjölk (kolostrum) i liten men koncentrerad mängd. Bebisen behöver inte mer.

Tecken på att bebisen får tillräckligt: 6 eller fler blöta blöjor per dygn, vikten återgår till födslovikten vid 2 veckors ålder och sedan ökar stabilt, bebisen verkar nöjd efter amning (åtminstone ofta).

För att öka produktionen: amma ofta och länge, se till att bebisen tömer bröstet ordentligt, pumpning mellan amningstillfällen stimulerar produktionen, undvik att komplettera med bröstmjölksersättning tidigt om det inte är medicinskt nödvändigt.

Sök amningsrådgivare om oron kvarstår. Det finns faktisk otillräcklig mjölkproduktion (glandulär hypoplasi, hormonstörningar) som behöver professionell bedömning.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Mammor delar amningserfarenheter:",
                consensus: "Att få rätt stöd tidigt – framför allt av amningsrådgivare – lyfts som avgörande. Att sluta amma beskrivs sällan som ett enkelt beslut men ibland som rätt.",
                quotes: [
                    "– Vecka 2 grät vi båda vid varje amning. En amningsrådgivare fixade tagget på 20 minuter. Fick aldrig ont igen.",
                    "– Fick mastit tre gånger. Tredje gången slutade jag amma. Rätt beslut för oss. En nöjd mamma är viktigare.",
                    "– Alla sa att det skulle gå bra. Tog 6 veckor. Gå nu bra. Men de första veckorna – inget sa att det skulle vara SÅ svårt."
                ],
                source: "Källa: Amningshjälpen.se, WHO/UNICEF Baby-Friendly Hospital Initiative, 1177.se"
            ),
            sources: [
                "WHO (2009). Infant and Young Child Feeding: Model Chapter for Textbooks.",
                "Spencer JP (2008). Management of mastitis in breastfeeding women. American Family Physician.",
                "Gatti L (2008). Maternal perceptions of insufficient milk supply in breastfeeding. JOGNN."
            ]
        ),

        // MARK: Article 28 – Tandsprickning
        Article(
            id: "health_teething",
            category: .health,
            title: "Tandsprickning — vad är normalt och vad hjälper?",
            subtitle: "Fakta och praktiska råd om bebisens första tänder",
            icon: "cross.case.fill",
            readTimeMinutes: 4,
            intro: "Tandsprickning börjar vanligtvis vid 4-7 månaders ålder, men det är normalt att det sker så tidigt som vid 3 månader eller så sent som vid 12 månader. Processen kan vara smärtsam och stressig för hela familjen – här är vad du kan göra.",
            sections: [
                ArticleSection(
                    heading: "Symtom på tandsprickning",
                    body: """
Vanliga tecken: ökad salivering, gnuggning av tandköttet, kinder som rodnar, irritabilitet och gnällighet, suga och bita mer än vanligt.

Kontroversielle symtom: feber och diarré tillskrivs ofta tandsprickning men forskning är oklar. En lätt temperaturhöjning (upp till 38 grader) kan förekomma, men hög feber (över 38,5) beror inte på tandsprickning utan ska utredas. Detsamma gäller kraftig diarré.

Ordningen på tänderna varierar men vanligtvis: undre framtänder (6-10 mån), övre framtänder (8-12 mån), laterala incisiver (9-13 mån), första molarerna (13-19 mån), hörntänderna (16-22 mån), andra molarerna (23-33 mån). Alla 20 mjölktänder brukar ha kommit vid 2,5-3 år.
"""
                ),
                ArticleSection(
                    heading: "Vad hjälper?",
                    body: """
Kylda tandleksaker: en kyld (inte fryst) bitleksak kan lindra. Frys den inte – för kall kan skada tandköttet. Tygbitar i kylen, eller en kyld sked kan fungera lika bra.

Massage: massera tandköttet försiktigt med ett rent finger. Trycket kan tillfälligt lindra smärtan.

Bitring utan vätska inuti: undvik bitlitar med gel inuti – de kan läcka och innehåller ibland tveksamma ämnen.

Smärtstillande: paracetamol eller ibuprofen (åldersanpassad dos) vid kraftig smärta som stör sömn och välmående. Använd inte tandköttsgelér med bensokain (numera inte rekommenderat) eller homeopatiska medel utan vetenskaplig evidens.

Undvik: bernstensband och -halsband. De innebär kvävningsrisk och är inte verksamma.

Tandvård från första tanden: borsta med mjuk tandborste och mängd fluortandkräm som ett riskorn (0-2 år). Flortandkräm skyddar de nya tänderna.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar tandsprickningstips:",
                consensus: "Kylda bitleksaker och att bita på föräldrarnas finger nämns mest. Paracetamol vid nätterna är vanligt.",
                quotes: [
                    "– Kylt äppelmos i nätmatningspåse. Det hjälpte bättre än allt annat.",
                    "– De värsta nätterna var med molarerna. Inget annat än ibuprofen hjälpte.",
                    "– Vägrade bitleksaker men älskade att bita på min knoge. Fick ha det som reserv."
                ],
                source: "Källa: Tandvårdsupplysningen, 1177.se, American Academy of Pediatric Dentistry"
            ),
            sources: [
                "Massignan C et al. (2016). Signs and Symptoms of Primary Tooth Eruption: A Meta-analysis. Pediatrics.",
                "Marks MB (1982). Recognizing the allergic person. American Family Physician."
            ]
        ),

        // MARK: Article 29 – Kroppsutveckling 6–12 månader
        Article(
            id: "development_motor_612",
            category: .development,
            title: "Motorisk utveckling 6–12 månader",
            subtitle: "Från sittande till de första stegen",
            icon: "figure.walk",
            readTimeMinutes: 5,
            intro: "Det andra halvåret av bebisens första år är en explosionsartad period av motorisk utveckling. Från att ha legat still på ryggen lär sig de flesta barn att sitta, krypa och stå – och en del börjar gå. Variation är stor och det mesta är normalt.",
            sections: [
                ArticleSection(
                    heading: "Sittande, krypande och stående",
                    body: """
Sittande utan stöd: de flesta barn klarar detta vid 6-8 månaders ålder. Vissa sitter stabilt redan vid 5, andra vid 9. Det kräver balans och bålstyrka som byggs upp gradvis. Stötta bebisen med kuddar runt om och ge golvtid på hård yta (inte alltid i mjuka kuddhögar).

Förflyttning: krypning i alla dess varianter (klassisk krypning på alla fyra, maginbåtning, rullning, eller att glida på rumpan) kan börja när som helst från 6 månader. Barn som hoppar över krypstadiet och går direkt till gång är normala och behöver ingen utredning.

Stående: de flesta pull to stand (drar sig upp till stående) vid 8-10 månader. Börja gå längs möbler (cruising) strax efter. Det kräver benmuskelstyrka som byggs av daglig aktiv rörelse.

Gå: i genomsnitt vid 12 månader, men normalt intervall är 9-15 månader. Om barnet inte går vid 18 månader, prata med BVC.
"""
                ),
                ArticleSection(
                    heading: "Hur du stöttar motorisk utveckling",
                    body: """
Magläge varje dag: baby on tummy time är grundfundamentet för motorisk utveckling. Bygger rygg-, nacke- och skuldermuskulatur. Börja kort (1-2 min) och bygg upp. Gör det när bebisen är pigg och nöjd, inte trött eller after mat. Ligga ner och titta på bebisen ögon i ögon gör det roligare.

Fri golvrörighet: minimera tid i bouncers, sittlösningar och vagnar (mer än nödvändigt). Bebisen behöver oreglerad tid på golvet för att utforska rörelsemönster på egna villkor.

Barefoot learning: inga skor inomhus om det är varmt nog. Fötterna känner golvet och ger sensorisk feedback som hjälper balans och gångmönster.

Säker utforskningsmiljö: babyproofing som ger rörelsefriheten snarare än begränsar den. Säkra trappor men öppna övriga rum för utforskande.

Undvik walker (gåstol med hjul). De är farliga (fallrisk, trappor) och bevisligen försenar gångdebuten eftersom barnet inte tränar rätt muskelgrupper.
"""
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar erfarenheter av motorisk utveckling:",
                consensus: "Variation är regeln, inte undantaget. De flesta oroar sig i onödan. Tummy time nämns av alla som nyckeln.",
                quotes: [
                    "– Min son kröp aldrig. Gick vid 10 månader rakt upp. Barnläkaren sa att det är helt normalt.",
                    "– Tummy time hatade hon till att börja med. Vi la oss bredvid henne. Blev hennes favoritaktivitet vid 4 månader.",
                    "– Gick vid 14 månader. Alla andra i gruppen hade gått länge. Det gick bra, hon är nu 3 och springer som en vind."
                ],
                source: "Källa: Rikshandboken Barnhälsovård, BVC, American Academy of Pediatrics"
            ),
            sources: [
                "Adolph KE, Robinson SR (2015). Motor development. Handbook of Child Psychology and Developmental Science.",
                "Majnemer A, Barr RG (2005). Influence of supine sleep positioning on early motor milestone acquisition. Developmental Medicine & Child Neurology."
            ]
        ),

        // =====================================================================
        // MARK: EXTRA ARTICLES (15 nya)
        // =====================================================================

        Article(
            id: "diaper-rash-guide",
            category: .health,
            title: "Blöjeksem – orsaker och behandling",
            subtitle: "Vad gör du när barnets hud rodnar?",
            icon: "cross.case.fill",
            readTimeMinutes: 5,
            intro: "Blöjeksem är en av de vanligaste hudåkommorna hos bebisar. Det är smärtsamt för barnet men oftast ofarligt och kan behandlas hemma.",
            sections: [
                ArticleSection(heading: "Vad är blöjeksem?", body: "Blöjeksem är en inflammation i huden under blöjzonen. Det orsakas av friktion, fukt, avföringens enzymer och ibland svampinfektioner. Det ser ut som röd, irriterad hud – ibland med utslag eller sår i svåra fall."),
                ArticleSection(heading: "Förebygga blöjeksem", body: "Byt blöja ofta – varje 2–3 timme eller direkt efter avföring. Låt barnet vara utan blöja en stund dagligen. Torka alltid mjukt och noga. Använd oparfymerade produkter."),
                ArticleSection(heading: "Behandling hemma", body: "Smörj med zinkoxid-kräm (t.ex. Sudocrem, Bepanthen) vid varje blöjbyte. Undvik blöjservetter med alkohol. Låt huden lufta. De flesta eksem läker inom 2–3 dagar."),
                ArticleSection(heading: "När kontakta vården?", body: "Kontakta BVC om eksemmet inte läker inom 3 dagar, om huden blöder eller har sår, eller om barnet har feber. Det kan vara en svampinfektion som kräver läkemedelskräm.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om blöjeksem:",
                consensus: "Snabb behandling och luftning fungerar bäst. Många föräldrar är nöjda med Bepanthen.",
                quotes: ["\"Lufttid varje dag förebyggde eksem helt – vi la barnet på en handduk utan blöja 15 min per dag.\" – Mia, 28"],
                source: "Föräldraforum"
            ),
            sources: ["Rikshandboken Barnhälsovård 2024", "1177 Vårdguiden"]
        ),

        Article(
            id: "baby-solid-food-intro",
            category: .feeding,
            title: "Introduktion av fast föda",
            subtitle: "Så startar du BLW eller puréer på rätt sätt",
            icon: "fork.knife",
            readTimeMinutes: 7,
            intro: "Att starta fast föda är en spännande milstolpe – och det finns fler sätt att göra det på. Här går vi igenom tecken på mognad, BLW vs. puré, och vad du ska undvika.",
            sections: [
                ArticleSection(heading: "När är barnet redo?", body: "De flesta barn är redo vid 4–6 månaders ålder. Tecken: kan sitta upp med stöd, har tappat tungreflexen (skjuter inte automatiskt ut mat), visar intresse för mat och kan föra händer till munnen."),
                ArticleSection(heading: "Puré vs. BLW", body: "Puré: du matar barnet med sked med slät mat. Gradvis tjockare konsistens. Passar bra om barnet verkar hungrig tidigt. BLW (Baby-Led Weaning): barnet matar sig självt med mjuka bitar från ca 6 månader. Forskning visar att BLW leder till bättre förhållande till mat och färre matningsproblem."),
                ArticleSection(heading: "Vad ska du börja med?", body: "Börja med milda smaker: morot, potatis, äpple, päron, banan. Prova en ny matvara var 3:e dag för att se allergireaktioner. Undvik honung (botulism), hela nötter (kvävningsrisk), tillsatt salt och socker."),
                ArticleSection(heading: "Allergier och säkerhet", body: "Introduktion av allergena livsmedel (jordnötter, ägg, gluten, fisk) tidigt (4–6 månader) kan faktiskt minska allergirisken. Prata med BVC om du har familjehistoria av allergier.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om att börja med fast föda:",
                consensus: "BLW-föräldrar är generellt nöjda men stressade av röran. Puré-föräldrar stressar mer om mängden som äts.",
                quotes: ["\"BLW var ett kaos i köket men hon äter allt nu som 2-åring. Värt varenda fläck.\" – Lina, 31"],
                source: "Föräldraforum & Livsmedelsverket"
            ),
            sources: ["Livsmedelsverket 2024", "Rikshandboken BHV", "WHO Infant Feeding Guidelines"]
        ),

        Article(
            id: "postpartum-depression",
            category: .parentHealth,
            title: "Förlossningsdepression – du är inte ensam",
            subtitle: "Vad är normalt och när ska du söka hjälp?",
            icon: "heart.text.square.fill",
            readTimeMinutes: 8,
            intro: "Upp till 10–15% av alla nyblivna föräldrar upplever förlossningsdepression. Det är en sjukdom, inte svaghet – och det finns mycket hjälp att få.",
            sections: [
                ArticleSection(heading: "Baby blues vs. förlossningsdepression", body: "Baby blues drabbar upp till 80% av alla mammor och ger gråtattacker, humörsvängningar och oro de första 1–2 veckorna. Det beror på hormonkasket och går över. Förlossningsdepression är längre, djupare och kräver behandling."),
                ArticleSection(heading: "Symtom att känna igen", body: "Nedstämdhet under mer än 2 veckor, sömnproblem trots trötthet, känsla av att vara en dålig förälder, svårt att knyta an till barnet, ångest, tankegångar om att skada sig själv eller barnet. Ta dem på allvar."),
                ArticleSection(heading: "Söka hjälp", body: "Prata med din barnmorska, BVC-sköterska eller läkare. Det finns effektiv behandling: samtal, KBT och medicinering om det behövs. Skammen är det enda hindret – ta bort den."),
                ArticleSection(heading: "Drabbar inte bara mammor", body: "10% av pappor/partners drabbas också av förlossningsdepression. Symtomen kan visa sig som irritabilitet, ökad alkohol, tillbakadragenhet och känsla av inkompetens som förälder.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om förlossningsdepression:",
                consensus: "Att söka hjälp är det modiga valet. De flesta som söker hjälp mår mycket bättre.",
                quotes: ["\"Jag väntade 6 månader för att jag trodde det var normalt att känna sig ledsen. Det var det inte. Sök hjälp.\" – Anonym"],
                source: "Föräldraforum & 1177"
            ),
            sources: ["SBU – Behandling av depression hos nyblivna föräldrar 2021", "1177 Vårdguiden", "Karolinska Institutet"]
        ),

        Article(
            id: "safe-sleep-guidelines",
            category: .sleep,
            title: "Säker sömn – allt du behöver veta",
            subtitle: "Hur minskar du risken för SIDS och skapar trygg sömnmiljö",
            icon: "moon.stars.fill",
            readTimeMinutes: 6,
            intro: "Plötslig spädbarnsdöd (SIDS) är sällsynt men fruktad. Det finns konkreta åtgärder som dramatiskt minskar risken. Lär dig dem.",
            sections: [
                ArticleSection(heading: "Grundreglerna", body: "Lägg alltid barnet att sova på rygg. Håll sängen fri från kuddar, lösa filtar och leksaker. Använd en fast madrass. Barnet ska sova i sin egna säng i ditt rum de 6 första månaderna."),
                ArticleSection(heading: "Rätt temperatur", body: "Rummet ska hålla 18–20 grader. Undvik överhettning – känn på nacken (ska vara varm men ej svettig). En bodysock och en tunn pyjamas räcker normalt."),
                ArticleSection(heading: "Napp minskar risken", body: "Forskning visar att nappsugande minskar SIDS-risken med upp till 50%. Du behöver inte hålla nappen i – när barnet somnar och nappen ramlar ut är det okej."),
                ArticleSection(heading: "Rökning och alkohol", body: "Rökning i hemmet ökar SIDS-risken dramatiskt. Dela aldrig säng med barnet om du rökt, druckit alkohol eller tagit sömntabletter. Samsovning i soffa är extra farligt.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om säker sömn:",
                consensus: "De flesta föräldrar känner oro för SIDS. Att följa reglerna ger trygghet.",
                quotes: ["\"Vi köpte en barnrörelsemonitor och den gav oss ro. Kanske inte nödvändig men för vår skull.\" – Petra, 32"],
                source: "Föräldraforum & Rikshandboken BHV"
            ),
            sources: ["AAP Safe Sleep Guidelines 2022", "Rikshandboken Barnhälsovård", "SIDS-forskning Karolinska"]
        ),

        Article(
            id: "toddler-sleep-regression",
            category: .sleep,
            title: "Sömnregressioner – varför barnet vaknar igen",
            subtitle: "Orsaker och strategier vid 4, 8, 12, 18 och 24 månader",
            icon: "moon.zzz.fill",
            readTimeMinutes: 6,
            intro: "Sömnregressioner slår till precis när du trodde att ni hittat ett fungerande schema. Det är biologiskt normalt och beror på hjärnans snabba utveckling.",
            sections: [
                ArticleSection(heading: "Vad är en sömnregression?", body: "En period när ett barn som sovit bra plötsligt vaknar ofta, har svårt att somna eller vägrar sova. Det beror på neurologiska språng, nya färdigheter eller stora förändringar i barnets liv."),
                ArticleSection(heading: "Vanliga tider", body: "4 månader: hjärnan mognar, sömncykler förändras permanent. 8–10 månader: separation, rörlighet. 12 månader: gångmognad. 18 månader: språkexplosion. 24 månader: utökat medvetande."),
                ArticleSection(heading: "Vad du kan göra", body: "Håll rutinerna konsekvent – det är ditt viktigaste verktyg. Svara snabbt för att undvika ökad separation. Öka stödet (mer amning, mer bärande) tillfälligt om det hjälper. Det här är en fas – den går över."),
                ArticleSection(heading: "4-månadersregressionen är permanent", body: "Vid 4 månader ändras sömnarkitekturen permanent – barnet sover nu i cykler som vuxna. Det är inte en regression utan en mognad. Undervisning i självständig insomnande (sleep training) kan hjälpa vid denna ålder om ni väljer det.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om sömnregressioner:",
                consensus: "Alla konstaterar att 'det går över'. Tålamod och rutiner är nyckeln.",
                quotes: ["\"4-månaders-regressionen träffade oss som en truck. 3 veckor av kaos. Sedan somnade hon bättre än någonsin.\" – Sandra, 29"],
                source: "Föräldraforum & Huckleberry Sleep"
            ),
            sources: ["Mindell JA (2015). Sleep training and attachment. Sleep Med Reviews.", "NHS Sleep regression guidelines 2023"]
        ),

        Article(
            id: "attachment-theory-parent",
            category: .development,
            title: "Anknytningsteori i praktiken",
            subtitle: "Hur du bygger trygg anknytning de första åren",
            icon: "heart.fill",
            readTimeMinutes: 7,
            intro: "Trygg anknytning är grunden för barnets hela liv – emotionellt, socialt och kognitivt. Den byggs i tusentals små ögonblick varje dag.",
            sections: [
                ArticleSection(heading: "Vad är anknytning?", body: "Anknytning är det emotionella bandet mellan barn och omsorgsperson. Det är inte kärlek i sig – det är en biologisk trygghetsstrategi. Barnet söker dig vid stress och utforskar världen ifrån dig som trygg bas."),
                ArticleSection(heading: "Trygg vs. otrygg anknytning", body: "Trygg anknytning: barnet vet att du finns och svarar. Hen kan utforska tryggt. Otrygg: barnet lär sig antingen att klinga eller att inte lita på dig alls. Trygg anknytning skapar bättre impulskontroll, empati och akademisk framgång."),
                ArticleSection(heading: "Hur bygger du det?", body: "Svara på gråt konsekvent. Håll ögonkontakt och le. Spegla barnets känslor. Säg vad du gör: 'Nu tar vi på dig kläder.' Var förutsägbar – rutiner bygger trygghet. Reparera misstag – om du förlorar tålamodet, återkoppla med en omfamning."),
                ArticleSection(heading: "Skärmtid och anknytning", body: "Barnet behöver responsiva vuxna, inte perfekta. En studie visade att 'good enough parenting' räcker. Du behöver inte vara 100% responsiv – bara tillräckligt konsekvent.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om anknytning:",
                consensus: "Nästan alla föräldrar oroar sig att de 'gör det fel'. Forskning visar att kärlek och konsekvens räcker.",
                quotes: ["\"Jag läste om anknytningsteori och slutade skämmas för att jag bär honom hela tiden. Det är rätt.\" – Julia, 27"],
                source: "Föräldraforum"
            ),
            sources: ["Bowlby J (1969). Attachment and Loss.", "Ainsworth MDS (1978). Patterns of Attachment."]
        ),

        Article(
            id: "breastfeeding-challenges",
            category: .feeding,
            title: "Amningsutmaningar – lösningar och hjälp",
            subtitle: "Mjölkstockning, sprickor och låg produktion",
            icon: "figure.and.child.holdinghands",
            readTimeMinutes: 8,
            intro: "Amning är naturligt men inte alltid enkelt. Här är de vanligaste problemen och hur du löser dem – med stöd från experter och föräldrar.",
            sections: [
                ArticleSection(heading: "Sprickor och sår", body: "Vanligaste orsak: felaktigt tag. Bebisen ska ha en stor del av areoln i munnen, inte bara bröstvårtan. Gaping öppnar – vänta på brett gapande. Smörj med bröstmjölk efter amning. Kontakta amningshjälpen om smärtan är svår."),
                ArticleSection(heading: "Mjölkstockning", body: "Hårt, ömt område i bröstet. Ammning frekvent (bebisen töms bäst). Värme och massage innan amning. Kyla efteråt för svullnad. Kontakta läkare om du får feber – kan vara bröstinflammation (mastit)."),
                ArticleSection(heading: "Låg mjölkproduktion", body: "Amma ofta – produktion styrs av efterfrågan. Undvik tidiga tillskott av flaska om inte medicinskt nödvändigt. Pumpa mellan amningarna om du vill öka. Drick tillräckligt. Undvik bröstpump de 2 första veckorna om möjligt (förvirrar ettablering)."),
                ArticleSection(heading: "När sluta amma?", body: "WHO rekommenderar amning till 2 år och längre om båda vill. Socialstyrelsen rekommenderar bröstmjölk som enda föda till 6 månader. Det finns inget 'för länge' – det är ditt och barnets val.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om amning:",
                consensus: "Amningshjälpen och laktationskonsulter hyllas av så gott som alla föräldrar.",
                quotes: ["\"Ring amningshjälpen. Ring dem igen. De räddade oss.\" – Emma, 30"],
                source: "Amningshjälpen & Föräldraforum"
            ),
            sources: ["WHO Breastfeeding Guidelines", "Rikshandboken Barnhälsovård", "Amningshjälpen.se"]
        ),

        Article(
            id: "vitamin-d-babies",
            category: .health,
            title: "D-vitamin och järn till bebisen",
            subtitle: "Varför, hur mycket och hur länge?",
            icon: "sun.max.fill",
            readTimeMinutes: 4,
            intro: "Alla nyfödda bebisars i Sverige behöver D-vitaminftillskott. Järntillskott kan också behövas. Här är vad du behöver veta.",
            sections: [
                ArticleSection(heading: "D-vitamin", body: "I Sverige får bebisen inte tillräckligt med D-vitamin via mat eller sol, särskilt vintertid. BVC rekommenderar D-vitamin-droppar (10 mikrogram/dag) från 2 veckors ålder till 2 år. Fortsätt gärna längre."),
                ArticleSection(heading: "Järn", body: "Bebisar föds med järndepåer som räcker ca 4–6 månader. Bröstmjölk innehåller lite järn. Barnersättning är järnberikad. Vid tidig uppstart av fast föda, välj järnrika livsmedel: kött, bönor, bröd."),
                ArticleSection(heading: "Vem behöver extra järn?", body: "Prematurbebisar, tvillingar och barn vars mödrar hade järnbrist kan behöva järntillskott. BVC screenar för detta. Järnbrist kan ge trötthet och påverka kognitiv utveckling."),
                ArticleSection(heading: "Omega-3", body: "Bröstmjölk innehåller DHA (omega-3) om mamman äter fisk. Barnersättning är berikad. Fet fisk till barnet rekommenderas från 6 månader, 2x/vecka.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om D-vitamin:",
                consensus: "Alla BVC-sköterskor rekommenderar D-vitamin. De flesta föräldrar ger det regelbundet.",
                quotes: ["\"Glömde D-vitamin en månad och BVC-sköterskan märkte det direkt. Ge det konsekvent.\" – Kim, 33"],
                source: "Rikshandboken BHV & Livsmedelsverket"
            ),
            sources: ["Rikshandboken Barnhälsovård", "Livsmedelsverket 2023", "SBU D-vitamin rapport"]
        ),

        Article(
            id: "potty-training-guide",
            category: .development,
            title: "Potträningstips – när och hur",
            subtitle: "Tecken på mognad och metoderna som fungerar",
            icon: "drop.circle.fill",
            readTimeMinutes: 6,
            intro: "Potträningstid kan vara stressig – men det behöver inte vara det. De flesta barn är klara vid 2–3 år, men mognadstecken är viktigare än ålder.",
            sections: [
                ArticleSection(heading: "Tecken på redo", body: "Barnet visar intresse för toaletten. Berättar när blöjan är blöt eller smutsig. Kan sitta still. Förstår enkla instruktioner. Verkar förstå sambandet mellan 'vill kissa' och 'kissar'. Genomsnitt: 18–30 månader."),
                ArticleSection(heading: "Börja", body: "Starta under en lugn period (inte vid dagisststart eller nytt syskon). Köp potta och låt barnet bekanta sig med den. Sitta på potta fullt klädd några dagar. Sedan byxorna av. Var alltid positiv."),
                ArticleSection(heading: "Metoder", body: "3-dagarsmetoden: ta bort blöjorna helt under 3 dagar hemma. Intensivt men effektivt för moget barn. Gradvis metod: byt till träningsbyxor, ta pottastunder regelbundet. Tar längre tid men mindre stress."),
                ArticleSection(heading: "Olyckor är normala", body: "Förvänta dig olyckor i 2–4 veckor. Reagera lugnt: 'Olyckan hände – nästa gång säger du till.' Aldrig skälla eller skämma. Det förlänger processen och skapar toalettoro.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om pottränining:",
                consensus: "De föräldrar som väntade på barnets mognad hade lättast tid.",
                quotes: ["\"Vi startade vid 2 år och stoppade. Startade om vid 2,5 – klart på 4 dagar. Värt att vänta.\" – Martin, 36"],
                source: "Föräldraforum"
            ),
            sources: ["AAP Toilet Training Guidelines", "Rikshandboken BHV"]
        ),

        Article(
            id: "play-and-learning",
            category: .development,
            title: "Lek som lärande – 0 till 5 år",
            subtitle: "Vad barnet lär sig när hen leker och hur du stöttar det",
            icon: "gamecontroller.fill",
            readTimeMinutes: 7,
            intro: "Lek är inte bara underhållning – det är hjärnans viktigaste inlärningsverktyg. Forskning är tydlig: fri lek utan vuxenstyrning är ovärderlig.",
            sections: [
                ArticleSection(heading: "Varför lek är viktigt", body: "Under lek aktiveras prefrontalkortex (beslutsfattande), hippocampus (minne) och cerebellum (motorik) simultaneously. Lek lär barnet problemlösning, empati, kreativitet och impulskontroll bättre än strukturerad undervisning."),
                ArticleSection(heading: "Lek per ålder", body: "0–6 mån: sensorisk lek – texturer, ljud, ansikten. 6–18 mån: orsak-verkan, kasta saker, tittut. 18–36 mån: fantasilek börjar. 3–5 år: rollekar, spel med regler, konstruktion."),
                ArticleSection(heading: "Fri lek vs. strukturerad lek", body: "Barn idag har 40% mindre tid för fri lek än 1980-talsbarn (forskning Harvard). Det korrelerar med ökning i ångest och depression. Fri utomhuslek, med andra barn, utan vuxenstyrning är det viktigaste du kan ge."),
                ArticleSection(heading: "Hur du hjälper", body: "Följ barnets lead. Fråga 'Vad händer nu?' istället för att bestämma. Berömma processen: 'Jag ser att du verkligen tänkte på det!' Tillåt röra och kaos – det är inlärning på gång.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om lek:",
                consensus: "Föräldrar som minskar skärmtid och ökar utomhuslek rapporterar nöjdare, lugnare barn.",
                quotes: ["\"Vi slopade alla schemalagda aktiviteter en sommar. Det var den bästa sommaren hittills.\" – Anna, 34"],
                source: "Föräldraforum & Harvard Center on Developing Child"
            ),
            sources: ["Gray P (2013). Free to Learn.", "Harvard Center on Developing Child 2024"]
        ),

        Article(
            id: "first-aid-baby",
            category: .health,
            title: "Första hjälpen till bebis",
            subtitle: "Kvävning, feber och olyckor – vad du ska göra",
            icon: "cross.case.fill",
            readTimeMinutes: 8,
            intro: "Att veta vad man ska göra i en akut situation med ett litet barn är ovärderlig kunskap. Läs det, öva det, spara det.",
            sections: [
                ArticleSection(heading: "Kvävning (> 12 månader)", body: "Om barnet kan hosta: låt dem hosta, säg lugnande ord. Om barnet inte kan hosta, är blått eller tyst: 5 slag mot ryggen (handen platt, mellan skulderbladen). Sedan 5 bukstötar (Heimlich). Ringa 112 direkt."),
                ArticleSection(heading: "Kvävning (bebis < 12 månader)", body: "5 rygslag: lägg bebisen på magen längs din arm, huvudet neråt. 5 bröstkomprimer: 2 fingrar i mitten av bröstbenet. Växla ryggslag och brösttryck. Ring 112 omedelbart."),
                ArticleSection(heading: "Feber", body: "Feber < 3 månader: alltid kontakta 1177 eller sjukhus vid 38+ grader. Feber 3–12 månader: kontakta vid 39+ eller om barnet mår dåligt. Äldre barn: behandla med paracetamol om barnet lider. Feber är inte farlig i sig."),
                ArticleSection(heading: "Förgiftning", body: "Om barnet svalt något okänt – ring 112 eller Giftinformationen (08-33 12 31). Framkalla INTE kräkning. Ha medicinering och kemikalier utom räckhåll.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om barnolyckor:",
                consensus: "Alla föräldrar rekommenderar HLR-kurs med barnmodul. Det är 4 timmar som kan rädda liv.",
                quotes: ["\"Barnet satte en vindruva i halsen. Jag visste exakt vad jag skulle göra. Det gick bra. Gå en kurs.\" – Erik, 39"],
                source: "Föräldraforum & Röda Korset"
            ),
            sources: ["Röda Korset Barnolyckor 2024", "1177 Vårdguiden", "Svenska Rådet för Hjärt-Lungräddning"]
        ),

        Article(
            id: "screen-time-children",
            category: .development,
            title: "Skärmtid för barn – vad forskningen säger",
            subtitle: "Rekommendationer och hur du sätter gränser",
            icon: "ipad.and.iphone",
            readTimeMinutes: 5,
            intro: "Skärmtid är en av de hetaste föräldraskapsfrågorna. Här är vad forskningen faktiskt säger – utan moralpredikningar.",
            sections: [
                ArticleSection(heading: "Rekommendationer", body: "WHO & AAP: 0–2 år: ingen skärm (undantag videochat med far/morföräldrar). 2–5 år: max 1 timme/dag av kvalitetsinnehåll. 5+: gränser men ingen fast regel – kvalitet och kontext viktigare."),
                ArticleSection(heading: "Vad skärmar faktiskt gör", body: "Passivt tittande (YouTube) utan interaktion: ingen inlärning hos barn under 2 år – de kan inte överföra 2D-bilder till 3D-förståelse. Interaktivt + med vuxen: viss inlärning möjlig. Videochat: fungerar – det är social interaktion i realtid."),
                ArticleSection(heading: "Skärmtyp spelar roll", body: "Passivt tittande = sämst. Interaktiva appar med responsiv feedback = bättre. Pedagogiska program (Bolibompa, Sesame Street) = okej i måttlig dos. Snabbklipp och 'autoplay' = undvik."),
                ArticleSection(heading: "Hur sätter du gränser?", body: "Inga skärmar vid matbordet. Inget 1 timme innan sänggåendet. Skärm som belöning? Undvik – skapar överkonsumtion. Titta TILLSAMMANS och prata om innehållet.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om skärmtid:",
                consensus: "Föräldrar vet att gränserna är viktiga men kämpar med genomförandet. Konsekvens vinner.",
                quotes: ["\"Vi har skärmfria middagar och kvällar. Barnen protesterade en vecka. Nu leker de bara.\" – Cecilia, 37"],
                source: "Föräldraforum"
            ),
            sources: ["WHO Screen Time Guidelines 2019", "AAP 2023", "Common Sense Media Research 2023"]
        ),

        Article(
            id: "fertility-nutrition",
            category: .fertility,
            title: "Kost och fertilitet",
            subtitle: "Vad du äter påverkar dina chanser att bli gravid",
            icon: "leaf.fill",
            readTimeMinutes: 6,
            intro: "Forskning visar tydligt att kosten påverkar fertilitet – för både kvinnor och män. Här är vad du bör äta mer av och vad du bör undvika.",
            sections: [
                ArticleSection(heading: "Medelhavskost ökar fertilitet", body: "Flera studier visar att medelhavsdiet (olivolja, fisk, grönsaker, baljväxter, nötter) ökar chansen till graviditet med 40–65% vid IVF. Det beror troligen på antiinflammatorisk effekt och antioxidanter."),
                ArticleSection(heading: "Folsyra är kritisk", body: "400 mikrogram folsyra per dag minst 3 månader INNAN graviditet minskar risken för neuralrörsdefekter med 50–70%. Ta ett tillskott och ät gröna bladgrönsaker, linser och bröd."),
                ArticleSection(heading: "Undvika", body: "Alkohol: minskar äggkvalitet och spermiekvalitet. Rökning: minskar fertilitet med 30%. Transfetter: ökar risk för anovulation. Processad mat: inflammatorisk effekt."),
                ArticleSection(heading: "För mannen", body: "Zink och selen är viktiga för spermiekvalitet: skaldjur, nötter, fullkorn. Antioxidanter (C och E-vitamin, betakaroten) förbättrar spermiemobilitet. Undvik övervärme: laptops i knäet och bastu minskar spermieproduktion.")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om kost och fertilitet:",
                consensus: "Kostförändringar kombinerat med livsstilsförbättringar nämns av många som hjälpsamt.",
                quotes: ["\"Vi lade om kosten båda två. Tre månader senare var vi gravida. Samband? Vet inte. Men det skadar inte.\" – Emma, 31"],
                source: "Fertilitetsforum"
            ),
            sources: ["Chavarro JE, Willett WC (2008). The Fertility Diet.", "Karolinska Institutet Fertilitetsforskning 2023"]
        ),

        Article(
            id: "pregnancy-exercise",
            category: .pregnancy,
            title: "Träning under graviditet",
            subtitle: "Vad är säkert och vad gynnar förlossningen?",
            icon: "figure.run",
            readTimeMinutes: 6,
            intro: "Motion under graviditet är inte bara säkert – det är rekommenderat. Det ger bättre förlossning, snabbare återhämtning och bättre mående.",
            sections: [
                ArticleSection(heading: "Varför träna?", body: "Regelbunden träning under graviditet: minskar risk för graviditetsdiabetes med 40%, minskar ryggsmärtor, reducerar förstoppning, förbättrar sömn och förlossningsutfall, kortare förlossning och färre kejsarsnitt."),
                ArticleSection(heading: "Vad är säkert?", body: "Promenader, simning, yoga, pilates, cykling (stillacykel) och lättare styrketräning är säkert hela graviditeten. Undvik kontaktsporter, aktiviteter med fallrisk, och liggande på rygg från vecka 20+."),
                ArticleSection(heading: "Bäckenbottenövningar", body: "Knip! 3 set x 10 knip, 3 gånger per dag. Det förebygger inkontinens under och efter graviditet. Gör dem nu, gör dem för alltid. Ingen kan se dem. Inga ursäkter."),
                ArticleSection(heading: "Röda flaggor", body: "Sluta träna och kontakta barnmorska/läkare om du får: blödning, vätskeläcka, svår andfåddhet, bröstsmärta, smärta i vaden, svår huvudvärk.")
            ],
            forumSection: ArticleForumSection(
                intro: "Gravida om träning:",
                consensus: "De flesta gravida som tränat mår bättre och säger att de planerar att träna igen nästa gång.",
                quotes: ["\"Simning tredje trimestern var det bästa. Tyngdlöshet! Kom ihåg det!\" – Maria, 34"],
                source: "Föräldraforum & Barnmorskegruppen"
            ),
            sources: ["ACOG Exercise During Pregnancy 2023", "Rikshandboken Mödrahälsovård", "SBU Graviditet och motion 2022"]
        ),

        Article(
            id: "dad-parental-leave",
            category: .parentHealth,
            title: "Föräldraledighet – råd till pappan",
            subtitle: "Varför det är viktigt och hur du tar ut det rätt",
            icon: "person.2.fill",
            readTimeMinutes: 5,
            intro: "Forskning är klar: pappor/partners som tar ut lång föräldraledighet har djupare relation med barnet, bättre parrelation och barnet mår bättre.",
            sections: [
                ArticleSection(heading: "Forskning och fakta", body: "Barn vars pappor tog mer än 8 veckors föräldraledighet visar bättre emotionell reglering vid 3 år. Föräldrar som delar lika på föräldraledigheten anger högre relationskvalitet 5 år senare (Uppsala Universitetsstudie 2022)."),
                ArticleSection(heading: "Praktiska råd", body: "Ta 'pappadagarna' direkt vid födseln – det är ovärderligt. Planera en sammanhängande period hemma (helst 3+ månader). Välj perioden strategiskt: antingen tidigt (0-6 mån) för anknytning eller 10-14 månader för barnets språkutveckling."),
                ArticleSection(heading: "Ekonomin", body: "Föräldrapenningen ersätter 77,6% av inkomsten upp till taket (ca 46 000 kr/mån). Det lönar sig. Jämföra med hur mycket du faktiskt spenderar på jobb-relaterade kostnader (kläder, lunch, transport) – gapet är ofta litet."),
                ArticleSection(heading: "Utmaningen", body: "Pappor upplever ofta att de 'inte vet hur'. Lösning: hoppa in direkt från dag 1. Bebisen vet inte att du är ny. Du lär dig göra det barnet accepterar, inte av teori. Mamma vet inte per automatik heller.")
            ],
            forumSection: ArticleForumSection(
                intro: "Pappor om föräldraledighet:",
                consensus: "Nästan alla pappor säger att de borde tagit ut mer och tidigare.",
                quotes: ["\"Tog 5 månader. Det var det bästa beslutet jag tagit i hela mitt liv. Ingen deadline, inga möten – bara vi.\" – Thomas, 38"],
                source: "Föräldraforum & Pappaledighet.se"
            ),
            sources: ["Uppsala Universitets familjeforskning 2022", "Försäkringskassan Föräldrapenning 2024"]
        ),
    ]

    static let all: [Article] = _allOriginal + pregnancyWeekArticles
}
