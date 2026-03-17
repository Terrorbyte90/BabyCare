import SwiftUI

// MARK: - Story Category

enum StoryCategory: String, CaseIterable {
    case godnattssagor = "Godnattssagor"
    case aventyrssagor = "Aventyrssagor"
    case larosagor = "Larosagor"
    case naturssagor = "Naturssagor"
    case kanslosagor = "Kanslosagor"

    var displayName: String {
        switch self {
        case .godnattssagor: return "Godnattssagor"
        case .aventyrssagor: return "Aventyrssagor"
        case .larosagor: return "Larosagar"
        case .naturssagor: return "Naturssagor"
        case .kanslosagor: return "Kanslosagor"
        }
    }

    var icon: String {
        switch self {
        case .godnattssagor: return "moon.stars.fill"
        case .aventyrssagor: return "map.fill"
        case .larosagor: return "lightbulb.fill"
        case .naturssagor: return "leaf.fill"
        case .kanslosagor: return "heart.fill"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .godnattssagor:
            return LinearGradient(colors: [Color(hex: "2C1654"), Color(hex: "6B4FA2")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .aventyrssagor:
            return LinearGradient(colors: [Color(hex: "1B5E20"), Color(hex: "4CAF50")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .larosagor:
            return LinearGradient(colors: [Color(hex: "E65100"), Color(hex: "FF9800")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .naturssagor:
            return LinearGradient(colors: [Color(hex: "00695C"), Color(hex: "26A69A")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .kanslosagor:
            return LinearGradient(colors: [Color(hex: "AD1457"), Color(hex: "EC407A")], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var color: Color {
        switch self {
        case .godnattssagor: return Color(hex: "6B4FA2")
        case .aventyrssagor: return Color(hex: "4CAF50")
        case .larosagor: return Color(hex: "FF9800")
        case .naturssagor: return Color(hex: "26A69A")
        case .kanslosagor: return Color(hex: "EC407A")
        }
    }
}

// MARK: - Story Age Range

enum StoryAgeRange: String, CaseIterable {
    case baby = "0-1 ar"
    case toddler = "1-3 ar"
    case preschool = "3-5 ar"
    case allAges = "Alla aldrar"

    var displayName: String {
        switch self {
        case .baby: return "0-1 ar"
        case .toddler: return "1-3 ar"
        case .preschool: return "3-5 ar"
        case .allAges: return "Alla aldrar"
        }
    }
}

// MARK: - Story Length

enum StoryLength: String, CaseIterable {
    case short = "Kort"
    case medium = "Medel"
    case long = "Lang"

    var displayName: String {
        switch self {
        case .short: return "Kort (~2 min)"
        case .medium: return "Medel (~5 min)"
        case .long: return "Lang (~10 min)"
        }
    }

    var estimatedMinutes: Int {
        switch self {
        case .short: return 2
        case .medium: return 5
        case .long: return 10
        }
    }
}

// MARK: - Recurring Character

struct RecurringCharacter: Identifiable {
    let id: String
    let name: String
    let species: String
    let personality: String
    let visualDescription: String
    let backstory: String
    let catchphrase: String
    let relatedCharacterIDs: [String]
}

// MARK: - Children's Story

struct ChildrenStory: Identifiable {
    let id: String
    let title: String
    let synopsis: String
    let category: StoryCategory
    let ageRange: StoryAgeRange
    let length: StoryLength
    let readingTimeMinutes: Int
    let mainCharacters: String
    let moral: String
    let visualDescription: String
    let recurringCharacterIDs: [String]
    let keywords: [String]
}


// ============================================================================
// MARK: - RECURRING CHARACTERS
// ============================================================================
//
// Six original recurring characters designed to appear across multiple stories.
// They are inspired by Swedish children's storytelling archetypes but are
// entirely original creations. Together they form a rich social constellation
// with complementary personalities, relationship dynamics and visual identities.
//
// Design philosophy
// -----------------
// * Diverse species so every child can find a favourite
// * Balanced gender representation
// * Each character embodies a core value (courage, curiosity, kindness,
//   patience, creativity, empathy)
// * Visual designs use simple, bold silhouettes that work at small sizes
//   (app thumbnails) and large sizes (full-page illustrations)
// * Relationships mirror the social dynamics children navigate: best friends,
//   gentle mentors, shy newcomers, playful tricksters
//
// ============================================================================

extension RecurringCharacter {
    static let all: [RecurringCharacter] = [

        // 1. SOLVI -- THE BRAVE LITTLE HEDGEHOG
        RecurringCharacter(
            id: "solvi",
            name: "Solvi",
            species: "Iggelkott (hedgehog)",
            personality: """
Solvi ar en liten iggelkott med ett stort hjarta och en annu storre nyfikenhet. \
Hon ar alltid den forsta att valja den okanda stigen i skogen, den forsta att \
kliva in i en morkt grotta for att se vad som finns dar, och den forsta att \
racka ut en tass till nagon som behover hjalp. Trots att hon ar liten och taggig \
har hon en varme som gor att alla djur i Skogsangen kannar sig trygga bredvid \
henne. Hon kan ibland vara lite otaling och rusar ivag innan hon tankt fardigt, \
vilket leder till komiska situationer dar hennes vanner far hjalpa henne.
""",
            visualDescription: """
En liten brun iggelkott med mjuka, avrundade taggar i varma nyanser av guld \
och kastanjebrun. Har stora, runda, nyfikna ogon i barnstensfargen. Bar en \
liten rod halsduk som hon fatt av sin mormor. Hennes nos ar rund och lekfull. \
Illustrationsstil: Varm akvarell med mjuka kanter, inspirerad av skandinavisk \
barnboksestetik. Alltid tecknad i rorelse -- springande, klangande, tittande.
""",
            backstory: """
Solvi bor i en liten moss-klaedd hallighet under en gammal ek pa Skogsangen. \
Hennes mormor, Mormor Tagga, var den modigaste iggelkotten i hela skogen, \
och Solvis roda halsduk ar ett arv fran henne. Solvi drommer om att en dag \
vandra hela vagen till Norra Berget, dar det sags att norrsken dansar aven \
pa sommaren.
""",
            catchphrase: "Kom, vi tar reda pa det!",
            relatedCharacterIDs: ["bjork", "lille_mopp", "kvall_uglan", "rask", "droppa"]
        ),

        // 2. BJORK -- THE GENTLE MOOSE CALF
        RecurringCharacter(
            id: "bjork",
            name: "Bjork",
            species: "Algkalv (moose calf)",
            personality: """
Bjork ar en ung algkalv som ar storre an de flesta andra djuren pa Skogsangen \
men som anda ar forsiktig och snall. Han ar den tysta typen som hellre lyssnar \
an pratar, men nar han val sager nagot ar det alltid genomtankt och klokt. \
Han alskar att titta pa stjarnorna och drommer om att forstA varfor loven \
byter farg pa hosten. Bjork ar den som alltid ser till att alla far vara med \
i leken, och om nagon kannar sig utanfor ar det Bjork som sakta gar fram och \
satter sig bredvid. Hans storlek gor att han ibland ar klumpig och ravelar \
ner saker, vilket han sjalv brukar skratta at.
""",
            visualDescription: """
En ung alg med ljusbrun, mjuk pals och smA nubbar dar hornen snart ska vaxa. \
Har stora, milda ogon i morkt brun med langa ogonfransar. Overstor nos som \
ger ett komiskt, alskligt uttryck. Bar ibland en hemstickad bla mossa som \
hans mamma gjort. Illustrationsstil: Mjuka pasteller, stor och rund form \
som utstalar lugn och trygghet. Ofta tecknad sittande och tittande uppat.
""",
            backstory: """
Bjork bor med sin mamma Alma vid den stora sjon Spegelvatten. Hans pappa \
vandrar ibland langt bort i skogarna, men kommer alltid tillbaka. Bjork \
ar nyligen inflyttad till Skogsangen och haller fortfarande pa att lara \
kanna alla. Hans basta van ar Solvi, som var den forsta att halsA pa honom.
""",
            catchphrase: "Jag tror... vi kanske kan prova tillsamans?",
            relatedCharacterIDs: ["solvi", "lille_mopp", "kvall_uglan", "rask", "droppa"]
        ),

        // 3. LILLE MOPP -- THE CREATIVE SQUIRREL
        RecurringCharacter(
            id: "lille_mopp",
            name: "Lille Mopp",
            species: "Ekorre (squirrel)",
            personality: """
Lille Mopp ar en sprallig, kreativ ekorre som alltid har ett nytt projekt pa gang. \
Han bygger, malar, uppfinner, och gor musik av allt han hittar -- pinnar blir \
trumstockar, loven blir malarpenslar, stenar blir skulpturer. Han pratar snabbt \
och tanker annu snabbare, och det ar inte alltid hans vanner hanger med i alla \
hans tankesprAng. Men bakom allt bus och skapande finns ocksa en liten ekorre \
som ibland oroar sig for att inte vara tillrackligt bra. Nar han kannar sig \
orolig hittar han trost i att skapa nagot vackert.
""",
            visualDescription: """
En rostbrun ekorre med en enorm fluffig svans som nAstan ar storre an han \
sjalv. Har glittrande, livliga ogon i gront. Palsens farg skiftar fran \
rost till guld. Har alltid nagot i tassarna -- en pinne, ett lov, en sten. \
Bar en liten gron barett pa sne. Illustrationsstil: Energisk, med smA \
rorelsestrek runt figuren som visar att han aldrig star stilla. Ljusa, \
glada farger.
""",
            backstory: """
Lille Mopp bor hogst upp i den stora granen mitt pa Skogsangen, i ett \
litet bo som han lagt hela sin sjalv i att dekorera. Vaggarna ar \
tapetserade med torkade blommor, stenar i fina farger och sma konstverk \
han gjort av bark. Han har aldrig traffat sin pappa och bor med sin \
faster, Tant Noto, som ar bibliotekets vaktare.
""",
            catchphrase: "Vantar, vantar, jag har en ide!",
            relatedCharacterIDs: ["solvi", "bjork", "kvall_uglan", "rask", "droppa"]
        ),

        // 4. KVALL-UGLAN ODA -- THE WISE OLD OWL
        RecurringCharacter(
            id: "kvall_uglan",
            name: "Kvall-Uglan Oda",
            species: "Kattugla (tawny owl)",
            personality: """
Oda ar den aldsta och visaste varelsen pa Skogsangen. Hon ar nocturnal och \
vaknar nar solen gar ner, men pa speciella dagar -- nar nagon verkligen \
behover henne -- vaknar hon redan pa eftermiddagen, gnuggande sina stora \
ogon och gaspande overraskat. Hon talar i lugna, melodiska meningar och \
har en tendens att besvara fragor med andra fragor, sa att barnen (och \
djuren) far tanka sjalva. Hon ar aldrig dommande och har all talAmod i \
varlden. Hennes enda svaghet ar att hon alskar kakor och kan bli distrA \
av doften av nybakat.
""",
            visualDescription: """
En stOrre kattugla med fjaderdraktens varma brun- och guldtoner. Runda, \
enorma ogon i djupt ambra som lyser svagt i skymningen. Fjadrar som \
liknar ett sjal runt halsen. Sitter ofta pa sin favoritgren med en gammal \
bok under vingen. Illustrationsstil: Detaljerad men mjuk, med varma \
kvallstoner. En karaktaristisk mAnstjals-gloria runt henne.
""",
            backstory: """
Oda har levt pa Skogsangen langre an nagon kan minnas. Det sags att \
hon redan satt i den stora eken nar skogen var ung. Hon har sett \
generationer av djur vaxa upp och hon bAr pa alla skogens berattelser \
i sitt minne. Pa natten nar alla andra sover sjunger hon sakta for \
sig sjalv -- de gamla sangerna fran da skogen var tyst och ung.
""",
            catchphrase: "Hmm, vad tror du sjalv?",
            relatedCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa"]
        ),

        // 5. RASK -- THE PLAYFUL FOX KIT
        RecurringCharacter(
            id: "rask",
            name: "Rask",
            species: "Ravunge (fox kit)",
            personality: """
Rask ar en ung ravunge som alskar att springa, hoppa, och leka. Han ar \
den snabbaste pa Skogsangen och kan aldrig sitta stilla speciellt lange. \
Han ar ocksa lite av en busunge -- inte elak, men han testar grAnser \
och tycker om att gora odygda spratt. Det han behover lara sig ar att \
tanke pa hur hans upptag paverkar andra. Under all energi och allt bus \
gommer sig dock en lojalitet och vArme som ar orubblig -- nar nagon av \
hans vanner ar i trubbel ar det Rask som springer fortast for att hamta \
hjalp.
""",
            visualDescription: """
En liten rav med glansande rod-orange pals och en vit brOsttflack. Har \
sma, spetsiga oron som alltid ar resta och alerta. Busig blick med \
glittrande bernstensogon. En stor, fluffig svans med en vit spets. \
Illustrationsstil: Dynamisk, ofta tecknad i sprAng eller mitt i ett \
spratt. Kraftiga, energiska fArger. Ett litet, skevt leende.
""",
            backstory: """
Rask bor med sin mamma och sina tva smAsyskon i ett gryt under \
stenroset vid skogsbrynet. Hans pappa forsvann nar Rask var mycket \
liten, och Rask lat ar att han maste vara den som tar hand om de \
smA. Han springer mycket for att han kannar att han har sA mycket \
energi i kroppen att den maste ut -- men ibland springer han ocksa \
for att han inte vill kanna saker som ar sorgliga.
""",
            catchphrase: "Den som ar snabbast far bestamma stigen!",
            relatedCharacterIDs: ["solvi", "bjork", "lille_mopp", "kvall_uglan", "droppa"]
        ),

        // 6. DROPPA -- THE SHY LITTLE FROG
        RecurringCharacter(
            id: "droppa",
            name: "Droppa",
            species: "Liten groda (little frog)",
            personality: """
Droppa ar den yngsta och blyaste i gAnget. Hon ar en liten groda som \
helst sitter vid kanten av dammen och tittar pa de andra leka, men \
som innerst inne langtar efter att vara med. Nar hon val vagar delta \
visar hon sig vara overraskande modig och har en fantastisk sangrost \
som fAr hela skogen att lyssna. Droppa ar det empatiska hjartat i \
gruppen -- hon kannar alltid nar nagon ar ledsen eller orolig, aven \
om de inte sager nAgot. Hennes empati ar hennes superkraft.
""",
            visualDescription: """
En mycket liten, ljusgron groda med stora, uttrycksfulla ogon i \
klarblatt. Har smA rosa prickar pa kinderna (som rodnad). Sitter \
ofta pa ett nackrosblad eller tittar fram bakom en sten. Bar en \
liten krona av tusenskona i hAret. Illustrationsstil: Fin, \
detaljerad akvarell. Mjuka pastelltoner. Ofta halvdold, med \
bara ogonen synliga forst.
""",
            backstory: """
Droppa bor i Nasgoldammen i skogens hjarta. Hon ar den minsta i \
sin stora familj av grodor, och hennes storre syskon ar alla \
hoga och hogljudda medan Droppa ar tyst. Hon hittade sin sangrost \
en natt nar mAnljuset foll over dammen och allt var sa vackert \
att hon bara maste sjunga. Sedan dess sjunger hon ibland, men \
bara nar hon kannar sig trygg.
""",
            catchphrase: "Jag... jag kan forsoka, om ni vill?",
            relatedCharacterIDs: ["solvi", "bjork", "lille_mopp", "kvall_uglan", "rask"]
        )
    ]
}


// ============================================================================
// MARK: - ALL STORIES (55 Original Stories)
// ============================================================================
//
// These stories are entirely ORIGINAL creations inspired by the archetypes and
// themes found in beloved Swedish and international children's literature. They
// draw on the storytelling traditions of authors like Astrid Lindgren, Elsa
// Beskow, Sven Nordqvist, Jujja Wieslander, Rune Andreasson, and Tove Jansson,
// as well as classic fairy tale motifs -- but NO characters, settings, or plots
// are copied. Every name, scenario and narrative is unique to this collection.
//
// Stories are organized by category:
// 1. Godnattssagor (Bedtime stories) -- 12 stories
// 2. Aventyrssagor (Adventure stories) -- 12 stories
// 3. Larosagor (Teaching/learning stories) -- 10 stories
// 4. Naturssagor (Nature stories) -- 11 stories
// 5. Kanslosagor (Emotion/feelings stories) -- 10 stories
//
// Total: 55 stories
//
// ============================================================================

extension ChildrenStory {
    static let all: [ChildrenStory] = [

        // ====================================================================
        // MARK: GODNATTSSAGOR (Bedtime Stories) -- 12 stories
        // ====================================================================
        // Calm, soothing stories designed for winding down before sleep.
        // Feature gentle rhythms, soft imagery, and peaceful resolutions.

        // G1 -- Solvis Stjarnfilt
        ChildrenStory(
            id: "g01_solvis_stjarnfilt",
            title: "Solvis stjarnfilt",
            synopsis: """
Nar natten faller over Skogsangen kan inte lilla Solvi somna. Hon saknar \
sin mormors varma famn. Kvall-Uglan Oda berAttar for henne att stjarnorna \
ar den stora skogens nattfilt, sytt av mAnens ljus. Solvi gar ut i nattluften \
och samlar mjukt mAnljus i sina tassar -- och nar hon krupar ner i sin \
moss-sang kanns det som om hela himlen vaggar henne till somns.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Solvi (iggelkott), Kvall-Uglan Oda",
            moral: "Tryggheten finns runt dig, aven nar du saknar nagon du alskar.",
            visualDescription: """
Midnattsblaa toner med silvriga stjarnor. Solvi sitter pa en moss-kulle och \
tittar upp mot en enorm, gnistrande natthimmel. MAnljuset ar mjukt och varmt. \
Akvarellstil med morkbla och violetta toner, guldiga detaljer pa stjarnorna.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["godnatt", "stjarnor", "trygghet", "saknad", "mAnljus"]
        ),

        // G2 -- Bjorks Mjuka Moln
        ChildrenStory(
            id: "g02_bjorks_mjuka_moln",
            title: "Bjorks mjuka moln",
            synopsis: """
Bjork ar for stor for sin sang och hans lAnga ben sticker ut over kanten. \
Han kan inte hitta en bekvaem stallning. Hans mamma Alma foreslar att de \
gar ut och tittar pa kvallsmolnen. Tillsammans laser de formerna i molnen \
-- en kanin, en stjarna, en stor mjuk kudde. Bjork drommer sig bort till \
ett moln-land dar allt ar mjukt och stilla, och nar de gar hem har han \
glomt bort att sangen var for liten.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Bjork (algkalv), Alma (mamma alg)",
            moral: "Fantasin kan gora aven det obekvama till nagot fint.",
            visualDescription: """
Kvallshimmel i rosa, lila och ljusbla. Stora, fluffiga moln i fantastiska \
former. Bjork och hans mamma star pa en kulle och tittar uppAt. Mamma ar \
stor och trygg. Mjuk, dromlik akvarellstil med pastelltoner.
""",
            recurringCharacterIDs: ["bjork"],
            keywords: ["godnatt", "moln", "fantasi", "mamma", "trygghet"]
        ),

        // G3 -- Nasgoldammens Vaggvisa
        ChildrenStory(
            id: "g03_nasgoldammens_vaggvisa",
            title: "Nasgoldammens vaggvisa",
            synopsis: """
Det ar en varm sommarkvall och alla djuren pa Skogsangen har svart att somna \
for att det fortfarande ar ljust ute. Droppa sitter pa sitt nackrosblad och \
borjar tyst sjunga en vaggvisa som hennes mormor lart henne. Sangen sprider \
sig sakta over vattnet, in bland traden, forbi grasstrana -- och ett efter \
ett somnar alla djur till den mjuka melodin. Tillslut somnar aven Droppa \
sjalv, vaggad av vattnets sakta rorelser.
""",
            category: .godnattssagor,
            ageRange: .allAges,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Aven den minsta rosten kan ha den storsta kraften.",
            visualDescription: """
Sommarkvall med midnattssol i bakgrunden. En liten groda pa ett nackrosblad \
i en stilla damm. Mjuka ljusvAgor sprider sig fran henne. Runtom ser man \
djur som somnar: en ekorre i sin gren, en iggelkott i sin mossa. Drommande \
akvarelltoner i guld, gront och ljusblatt.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["godnatt", "sang", "vaggvisa", "sommar", "somna"]
        ),

        // G4 -- MAnskensjakten
        ChildrenStory(
            id: "g04_manskensjakten",
            title: "Manskensjakten",
            synopsis: """
En kvall nar Rask inte kan somna bestammer han sig for att fAnga mAnljuset \
som silar in genom springorna i hans gryt. Han springer genom skogen, \
hoppar over backar och klattrar pa stenar -- men varje gang han stracker \
ut tassarna rinner mAnljuset ur dem som vatten. Till slut hittar han Oda \
som forklarar att man inte behover fAnga ljuset -- man kan bara sitta \
stilla och lata det fylla en inifran. Rask satter sig ner, andar lugnt, \
och kanner hur mAnljuset varmer hela kroppen. Han somnar under klar himmel.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (ravunge), Kvall-Uglan Oda",
            moral: "Man behover inte jaga allt -- ibland racker det att vara stilla.",
            visualDescription: """
Silvrig manskensskog med lAnga, mjuka skuggor. Rask i rorelse genom bild \
efter bild -- springande, hoppande, stannande. Sista bilden: Rask sitter \
stilla, bAdat i mAnljus. Kontrastrik men mjuk palett: midnattsbla, silver, \
varmt orange (Rasks pals).
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["godnatt", "mAnljus", "stillhet", "lugn", "somna"]
        ),

        // G5 -- Tio Smaa Mossjunkar
        ChildrenStory(
            id: "g05_tio_smaa_mossjunkar",
            title: "Tio smA mossjunkar",
            synopsis: """
I den djupaste, gronaste delen av skogen bor tio pyttesmA mossjunkar -- \
sA smA att bara den som tittar riktigt noga kan se dem. Varje kvall nar \
solen gar ner tAnder de var sin liten lykta gjord av eldflugors ljus och \
vandrAr i en lAng rad genom mossAN. De sjunger en rAknesAng: 'Tio smA \
mossjunkar, nio gAr till ro...' och en efter en somnar de langs stigen, \
tills bara en ar kvar, som viskar 'godnatt' At vinden.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Tio mossjunkar (smA skogsvasen)",
            moral: "Att somna ar naturligt -- alla gor det, en efter en.",
            visualDescription: """
Miniaturvarld i naerbild: enorma mosstrAn som trad, daggdroppar som lyktor. \
Tio smA vasen i gron-bruna farger med smA spetsiga mossmossor. Varje sida \
visar en farre mossjunke. Detaljerad men dromlik stil, matt guldljus.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "rakning", "skogsvasen", "mossa", "stillhet"]
        ),

        // G6 -- Var Somnar Vinden?
        ChildrenStory(
            id: "g06_var_somnar_vinden",
            title: "Var somnar vinden?",
            synopsis: """
Lille Mopp undrar var vinden gar nar det blir stilla pa kvallen. Han \
frAgar tradet -- tradet sager att vinden somnar i dess krona. Han frAgar \
sjon -- sjon sager att vinden somnar pa ytan. Han frAgar berget -- berget \
sager att vinden somnar i dess hAlor. Till slut satter sig Lille Mopp i \
sin gran och kannar hur en sista bris smeker hans kind. 'Godnatt, vinden,' \
viskar han. Vinden viskar tillbaka.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Naturen vilar ocksa, precis som vi.",
            visualDescription: """
Kvallslandskap som rOr sig genom olika miljoer: tradkronor, sjon, berget. \
Vinden visualiseras som mjuka, genomskinliga vAgor i luften. Sista bilden: \
Lille Mopp i sin gren, omgiven av stilla luft. Pasteller i gront, blatt \
och ljusgult.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["godnatt", "vind", "natur", "undran", "tystnad"]
        ),

        // G7 -- Den Tysta Snon
        ChildrenStory(
            id: "g07_den_tysta_snon",
            title: "Den tysta snon",
            synopsis: """
Det ar Solvis forsta vinter och hon har aldrig sett sno forut. Nar de \
forsta flingorna faller stannar hela skogen -- alla ljud forsvinner. \
Solvi ar forst radd for tystnaden, men Bjork visar henne att snon ar \
som en stor, vit filt som skogen drar over sig for att sova. Tillsammans \
lyssnar de till den allra tystaste tystnaden, och Solvi upptacker att \
i tystnaden kan man hora sitt eget hjarta sla -- och det later tryggt.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), Bjork (algkalv)",
            moral: "Tystnad behover inte vara otack -- den kan vara trygg och vacker.",
            visualDescription: """
Snoflingor faller sakta over en stilla skog. Vitt, ljusbla och silver \
dominerar. Solvi star liten och rund i snon, Bjork stor och lugn bredvid. \
Inga skarpa kanter, allt ar mjukt och daempat. Sista bilden: bAda djuren \
nara varandra i snon, omgivna av tystnad.
""",
            recurringCharacterIDs: ["solvi", "bjork"],
            keywords: ["godnatt", "vinter", "sno", "tystnad", "trygghet"]
        ),

        // G8 -- Stjarnbrevet
        ChildrenStory(
            id: "g08_stjarnbrevet",
            title: "Stjarnbrevet",
            synopsis: """
Droppa hittar ett litet lysande blad som fallit fran natthimlen. Hon \
tror att det ar ett brev fran en stjarna. Forsiktigt viker hon upp det \
och laser ett meddelande: 'Du lyser ocksa.' Droppa forstAr inte forst \
-- hon ar ju bara en liten groda. Men nar hon tittar ner i vattnet ser \
hon att mAnljuset reflekteras i hennes ogon, och hon inser att alla har \
ett eget ljus inom sig, aven om man ibland glommer det.
""",
            category: .godnattssagor,
            ageRange: .preschool,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Alla har ett unikt ljus inombords, aven de som kanns smA.",
            visualDescription: """
Morkt vatten med mAnreflex. En liten groda hAller ett lysande blad som \
kastar varmt ljus over hennes ansikte. Ogonen glittrar. Morka, rika \
toner med kontrast av varmt guldljus. Sista bilden: Droppa ler -- for \
forsta gAngen riktigt brett.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["godnatt", "sjalvkansla", "stjarnor", "ljus", "sjalvbild"]
        ),

        // G9 -- Nattens Djur Gar Hem
        ChildrenStory(
            id: "g09_nattens_djur_gar_hem",
            title: "Nattens djur gAr hem",
            synopsis: """
En enkel, rytmisk berattelse som foljer nattens djur nar de gAr hem i \
gryningen. Uglan flyger till sitt trad. Ravarna springer till sitt gryt. \
Gravlingen kryper ner i sin hAla. Nattfjariln viker ihop sina vingar. \
Varje djur sager 'godnatt' pA sitt eget satt -- ett hoot, ett pip, en \
tyst suck. Och nar alla ar hemma borjar daggdjuren vakna, och en ny dag \
borjar. Men det ar en saga for en annan gang.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Diverse nattdjur (ugla, rav, gravling, nattfjaril)",
            moral: "Alla har en plats att ga hem till nar det ar dags att vila.",
            visualDescription: """
Gryningsljus med rOda och gyllene toner i horisonten. Sekvens av djur som \
gAr in i sina bon: ugla i trad, rav i gryt, gravling i hAla. Varje bild \
mjukare an den forra. Sista bilden: en stilla skog i tidigt morgonljus. \
Naturalistisk akvarellstil.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "djur", "gryning", "hem", "rutin"]
        ),

        // G10 -- Mollys Magiska Snorstrad
        ChildrenStory(
            id: "g10_mollys_snorstrad",
            title: "Mollys magiska snorstrad",
            synopsis: """
Lilla Molly ar en mAnstrale som bor i mAnens allra bortersta krater. \
Varje kvall spinner hon tunna, silvriga snoren som hon hangar fran \
himlen ner till Skogsangen. De ar sa tunna att man bara kan se dem om \
man blundar nAstan helt. NAr barnen och djuren lagger sig och blundar \
kan de kanna hur Mollys snoren vaggar dem sakta, sakta, fram och \
tillbaka tills de somnar. Och nar de sover klAttar Molly ner langs \
snorerna och viskar fina drommer i deras oron.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Molly (mAnstrale)",
            moral: "Nar du blundar och slappnar av kommer drommarna av sig sjalva.",
            visualDescription: """
MAnen stor och rund. En liten, silverglittrande varelse spinner tunna \
trAdar ner mot en sovande skog. NedanfOr ser man smA djur i sina bon \
med slutna ogon. Silverblatt, drommigt, med fina glittrande detaljer. \
Bokens mjukaste, mest drOmlika bilder.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "mAnen", "drommer", "slappna av", "vaggande"]
        ),

        // G11 -- Sista Sidan Idag
        ChildrenStory(
            id: "g11_sista_sidan_idag",
            title: "Sista sidan idag",
            synopsis: """
Det ar sent och Solvi, Bjork och Lille Mopp sitter i Odas trad och ber \
om 'en saga till.' Oda ler och sager att varje dag ar som en bok, och \
nu ar det dags att vanda sista sidan. Hon hjalper dem minnas alla fina \
saker som hant under dagen -- solen som varmde, maten som smakade gott, \
leken med vannerna. 'Se, vilken fin bok det blev idag,' sager Oda. \
'Imorgon borjar en ny.' Alla somnar med ett leende.
""",
            category: .godnattssagor,
            ageRange: .allAges,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi, Bjork, Lille Mopp, Kvall-Uglan Oda",
            moral: "Varje dag ar vard att minnas och vara tacksam for.",
            visualDescription: """
Varmt kvallsljus i en stor ek. Oda sitter pa en gren, de tre smA djuren \
nedanfor. Bilderna visar 'flashbacks' av deras dag i gyllene toner. Sista \
bilden: alla sover, Oda vakar stilla. Varma guldtoner som langtsamt \
overgAr till midnattsbla.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "kvall_uglan"],
            keywords: ["godnatt", "tacksamhet", "minnen", "dag", "natt"]
        ),

        // G12 -- Sovmorkt
        ChildrenStory(
            id: "g12_sovmorkt",
            title: "Sovmorkt",
            synopsis: """
Det ar vinter och det blir morkt tidigt. Droppa ar radd for morkret. Rask, \
som aldrig ar radd for nagot (pastAr han), erbjuder sig att sitta med henne. \
Men nar det blir riktigt morkt erkanner Rask att han ocksa tycker att det ar \
lite otackt. Tillsammans sitter de i morkret och upptacker att det inte ar \
tyst alls -- de hor vatten porla, ugglan sjunga, vinden andas. Morkret ar \
fullt av ljud, och ljuden ar vanner. De somnar sida vid sida, inte langre \
radda.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Rask (ravunge)",
            moral: "Det ar okej att vara radd, och morkret ar inte sa tomt som man tror.",
            visualDescription: """
Progressivt morkare bilder, men varje bild fylld med smA ljusd detaljer: \
en eldfluga, mAnreflex, ogon. De tvA djuren nara varandra. I borjan \
spanda, i slutet avslappnade. Morka bla och grana toner med varma prickar \
av ljus.
""",
            recurringCharacterIDs: ["droppa", "rask"],
            keywords: ["godnatt", "morker", "radsla", "vanskap", "mod"]
        ),


        // ====================================================================
        // MARK: AVENTYRSSAGOR (Adventure Stories) -- 12 stories
        // ====================================================================
        // Exciting, engaging stories with journeys, challenges, and triumphs.
        // Build suspense age-appropriately and always resolve positively.

        // A1 -- Stigen Till Norra Berget
        ChildrenStory(
            id: "a01_stigen_till_norra_berget",
            title: "Stigen till Norra Berget",
            synopsis: """
Solvi har alltid dromt om att se norrsken fran toppen av Norra Berget. En \
morgon bestammer hon sig -- idag gar hon! Men stigen ar lAng och full av \
hinder: en bred back att korsa, ett morkt skogsparti, en brant slutning. \
Vid varje hinder mots hon av en av sina vanner som hjalper henne pa sitt \
satt: Bjork bar henne over backen, Rask visar genvagen genom skogen, \
Lille Mopp bygger en liten trappa av pinnar. Pa toppen ser de norrsken \
tillsammans -- och det ar vackrare for att de delade det.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi, Bjork, Rask, Lille Mopp",
            moral: "Stora drOmmar nAr man lattare med hjalp av vanner.",
            visualDescription: """
Episk resa genom varierande landskap: Angmarker, morka barrskogar, branta \
klippstigar. Varje ny miljO har distinkt fargpalett. Sista bilden: alla \
fyra pa en bergstopp under dansande norrsken i gront och lila. Detaljrika \
landskapsillustrationer.
""",
            recurringCharacterIDs: ["solvi", "bjork", "rask", "lille_mopp"],
            keywords: ["aventyr", "norrsken", "vanskap", "resa", "berg"]
        ),

        // A2 -- Skatten I Spegelvatten
        ChildrenStory(
            id: "a02_skatten_i_spegelvatten",
            title: "Skatten i Spegelvatten",
            synopsis: """
Bjork hittar en gammal karta i sin mammas forrad som visar att det finns \
en 'skatt' gOmd pa botten av sjon Spegelvatten. Tillsammans med Solvi \
och Droppa (som ju kan dyka!) ger de sig ut pa en expedition. Droppa \
dyker och hittar inte guld -- utan en vacker, glittrande sten med ett \
meddelande ristat pa: 'Den stOrsta skatten ar den som soker med dig.' \
De forstAr att skatten var aventyret sjalvt och vAnskapen de delade.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Bjork (algkalv), Solvi (iggelkott), Droppa (groda)",
            moral: "Den verkliga skatten ar vanskap och delade upplevelser.",
            visualDescription: """
Undervattensvarld i turkos och gront. Droppa dyker genom vattenvAxter \
och fiskar. Ovan vattnet: Bjork och Solvi i en liten flotte. Kartan ar \
Aldre och gulnad. Stenen som hittas glittrar i regnbAgens fArger. \
Detaljrik akvarell med undervattenskaensla.
""",
            recurringCharacterIDs: ["bjork", "solvi", "droppa"],
            keywords: ["aventyr", "skatt", "sjo", "dyka", "vanskap"]
        ),

        // A3 -- NAr Granen Foell
        ChildrenStory(
            id: "a03_nar_granen_foell",
            title: "Nar granen foll",
            synopsis: """
En storm fAller den stora granen dar Lille Mopp bor. Hans hem ar forstort. \
Alla vanner samlas for att hjalpa. Solvi hittar en ny plats, Bjork bar \
tunga grenar, Rask springer och hamtar material, Droppa sjunger for att \
hAlla modet uppe, och Oda ger kloka rAd om byggteknik. Tillsammans bygger \
de det finaste boet Skogsangen nagonsin sett -- och Lille Mopp inser att \
hans hem inte var granen, utan gemensakpen med sina vanner.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Lille Mopp, Solvi, Bjork, Rask, Droppa, Oda",
            moral: "Nar nagot gAr sonder kan man bygga nagot nytt, tillsammans.",
            visualDescription: """
Dramatisk stormscen i borjan: morka moln, bOjda trad, regn. Sedan ljusnar \
det gradvis. Byggscenar med alla djur i arbete. Sista bilden: det nya boet, \
soligt, med blomsterdekorationer. FAfrgressionen fran morkt till ljust \
speglar kaenslo-resan.
""",
            recurringCharacterIDs: ["lille_mopp", "solvi", "bjork", "rask", "droppa", "kvall_uglan"],
            keywords: ["aventyr", "storm", "samarbete", "bygga", "gemenskap"]
        ),

        // A4 -- Skogsstafetten
        ChildrenStory(
            id: "a04_skogsstafetten",
            title: "Skogsstafetten",
            synopsis: """
Det ar dag for Skogsangens Arliga stafett! Alla djur deltar i lag. Solvis \
lag maste springa, simma, klAttra och flyga (med hjalp av Oda). Men Rasks \
lag ar snabbare vid varje kontroll. NAr Rasks lagkamrat snubblar och slAr \
sig valjer Rask att stanna och hjalpa -- aven om det betyder att han \
forlorar tavlingen. Alla jublar for Rask andA, och Oda sager: 'Den som \
hjalper ar alltid en vinnare.'
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (ravunge), Solvi (iggelkott), Oda (uggla)",
            moral: "Att vara snall ar viktigare an att vinna.",
            visualDescription: """
Farglatt och energiskt. Djur i rorelse genom en hinderbana i skogen: \
simstrack genom dammen, klAttring i trad, sprAng over Ang. Rask stannar \
mitt i rorelen for att hjalpa -- den kontrasten i bilden ar central. \
Kraftiga, glada farger.
""",
            recurringCharacterIDs: ["rask", "solvi", "kvall_uglan"],
            keywords: ["aventyr", "tavling", "hjalpsam", "fairplay", "sport"]
        ),

        // A5 -- Den Hemliga Grottan
        ChildrenStory(
            id: "a05_den_hemliga_grottan",
            title: "Den hemliga grottan",
            synopsis: """
Rask hittar en gOmd ingAng bakom en buske vid bergets fot. Inne i grottan \
ar det morkt, men vAggarna glittrar av kristaller. Solvi och Rask utforskar \
forsiktigt och hittar mAlningar pa vAggarna -- urgamla bilder av djur som \
levde i skogen for lange, lange sedan. De forstAr att andra djur vandrat \
dessa stigar fore dem, och att skogen bAr pa berAttelser som ar Aldre an \
de kan forestAlla sig.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (ravunge), Solvi (iggelkott)",
            moral: "Vi ar en del av en lAng historia, och vAr skog har berAttelser att berata.",
            visualDescription: """
MOrk grotta med glittrande kristaller i gront, blatt och lila. Fackelljus \
(eldflugors sken) belyser primitiva grottmAlningar av Algar, bjoernar, rAvar. \
Mystisk, magisk stAmning. DjupblA och glittrande detaljer.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["aventyr", "grotta", "historia", "upptAcka", "kristaller"]
        ),

        // A6 -- Flottfardens Dag
        ChildrenStory(
            id: "a06_flottfardens_dag",
            title: "FlottfArdens dag",
            synopsis: """
Lille Mopp har byggt en flotte av pinnar och blad. Men den sjunker. Han \
bygger en till -- den ocksa sjunker. FrustrErad nAstan ger han upp, men \
Oda frAgar: 'Har du frAgat vattnet vad det vill?' Lille Mopp tittar pa \
hur loven flyter och forstAr att formen mAste vara platt, inte hog. \
Tredje forsOket lyckas! Han och Droppa segler lAngs backen hela vAgen \
till Spegelvatten. Det bAsta med att misslyckas var att han lArde sig \
hur det fungerar.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kvall-Uglan Oda, Droppa (groda)",
            moral: "Att misslyckas ar inte slutet -- det ar en del av att lAra sig.",
            visualDescription: """
Backmiljo med rinnande vatten. Tre olika flottar: en som sjunker komiskt, \
en som vAlter, en som flyter perfekt. Lille Mopp fran ledsen till glad. \
Droppa sitter stolt pa den sista flotten. Ljusa, varma farger. \
Vattnet glittrar.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan", "droppa"],
            keywords: ["aventyr", "bygga", "misslyckas", "lAra", "flotte"]
        ),

        // A7 -- Vargens Ekon
        ChildrenStory(
            id: "a07_vargens_ekon",
            title: "Vargens ekon",
            synopsis: """
Solvi och Bjork hor ett lAgt ylande i skogen och blir oroliga -- ar det \
en varg? De foljer ljudet forsiktigt och hittar... ingenting. Det ar bara \
ekot av vinden genom en ihAlig stock. Oda forklarar att skogen ar full av \
ljud som kan lAta otAcka men som har naturliga forklaringar. De gAr runt \
i skogen och 'avtAcker' alla mystiska ljud: trAdets knArrande, bAckens \
porlande, ugglans rop. Det som var otAckt blir fascinerande.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), Bjork (algkalv), Kvall-Uglan Oda",
            moral: "MAngA saker som kanns skrAmmande har en enkel forklaring.",
            visualDescription: """
Skog med dramatiska ljus- och skuggspel. Ljudvagar visualiseras som mOnster \
i luften. IhAlig stock med mystiskt utseende som visar sig vara ofarlig. \
Djuren gAr fran lAnga skuggor till ljust, vAnskapligt sken. GAr fran kyliga \
till varma toner.
""",
            recurringCharacterIDs: ["solvi", "bjork", "kvall_uglan"],
            keywords: ["aventyr", "radsla", "ljud", "natur", "utforska"]
        ),

        // A8 -- Det Flygande Frot
        ChildrenStory(
            id: "a08_det_flygande_frot",
            title: "Det flygande frot",
            synopsis: """
Lille Mopp drommer om att flyga. Han bygger vingar av lOv -- de hAller inte. \
Han prOvar en katapult -- den gAr at fel hAll. Till slut bygger han en stor \
drake (leksak) av tunna kvistar och mjuka mossblad. Nar vinden fAngar den \
lyfter den -- och Lille Mopp hAnger pA! Han flyger over Skogsangen, over \
dammen, over berget. Han ser sina vanners bon uppifrAn och fOrstAr hur \
stort och vackert deras hem ar. NAr han landar har han sett vArlden pA \
ett nytt sAtt.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Med kreativitet och envishEt kan man nA sina drOmmar.",
            visualDescription: """
Dynamiska flygscener over ett fAgelperspektiv av Skogsangen. Lille Mopp \
pa en stor, vacker drake mot blA himmel. Under honom: sjOn, skogen, Angen, \
berget -- allt i miniatyr. Uppslaget med fAgelperspektivet ar bokens mest \
imponerande bild. Ljusa, luftiga fArger.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["aventyr", "flyga", "drommar", "kreativitet", "uppfinning"]
        ),

        // A9 -- Isvaegen
        ChildrenStory(
            id: "a09_isvaegen",
            title: "IsvAgen",
            synopsis: """
Det ar vinter och sjOn Spegelvatten har frusit. Bjork har aldrig gAtt pA \
is fOrut och ar nervos -- han ar sA stor och tung, tAnk om isen brister! \
Rask visar honom att man kan testa isen fOrsiktigt, steg fOr steg. \
Tillsammans -- Rask lAtt och snabb fOst, Bjork tung och fOrsiktig efter \
-- tar de sig over sjOn till den andra sidan dAr de hittar en undangOmd \
Ang med vinterjasmin som blommar mitt i snOn. SkOnheten var vArd risken.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Bjork (algkalv), Rask (ravunge)",
            moral: "Med fOrsiktighet och en vAn vid sin sida kan man vAga nya saker.",
            visualDescription: """
Frusen sjO med spegelblank is. BjOrk stOr och tveksam vid kanten, Rask \
smA och fOrviAnningsfull framfor. Svagt violett vinterljus. PA andra \
sidan: explosion av gul vinterjasmin mot vit snO. Kontrasten mellan \
kallt och varmt.
""",
            recurringCharacterIDs: ["bjork", "rask"],
            keywords: ["aventyr", "vinter", "mod", "forsiktighet", "vanskap"]
        ),

        // A10 -- Regndagens Karta
        ChildrenStory(
            id: "a10_regndagens_karta",
            title: "Regndagens karta",
            synopsis: """
Det regnar och alla ar uttrakade hemma i sina bon. Solvi bestammer sig for \
att rita en karta over Skogsangen -- men hennes karta visar aven platser \
som inte finns An: 'HAr kan vi bygga en bro,' 'HAr kan vi plantera en \
trAdgArd.' Inspirerade ger sig alla djur ut i regnet och borjar bygga det \
som kartan visar. NAr regnet slutar har Skogsangen fAtt en ny bro, en \
liten trAdgArd och ett utsiktstorn av pinnar. Regndagen blev deras bAsta.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), alla vAnner",
            moral: "TrAkiga dagar kan bli de bAsta om man anvAnder fantasin.",
            visualDescription: """
Regnigt skogslandskap som gradvis fOrAndras: nya strukturer dyker upp \
bland trAden. Djur i regnrock-liknande lOv. Kartan som Solvi ritar ar \
barnligt charmig och detaljrik. Regn som glittrar. Blatt, gront och \
gyllene toner.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["aventyr", "kreativitet", "regn", "fantasi", "bygga"]
        ),

        // A11 -- Bortom Skogsbrynet
        ChildrenStory(
            id: "a11_bortom_skogsbrynet",
            title: "Bortom skogsbrynet",
            synopsis: """
Rask har alltid undrat vad som finns bortom skogsbrynet, dAr Angen slutar \
och nAgot nytt borjar. En dag springer han hela vAgen dit och ser -- en \
annan skog! Och i den skogen bor andra djur: en blyg rAddjurskid, en \
pratsam nOtkrAka, en gammal grAvling. De ar olika, pratar lite annorlunda, \
och leker andra lekar. Rask ar fOrst osAker, men snart spelar de tillsammans. \
Han gAr hem med nya vAnner och berAttar: 'DAr borta ar det ocksa fint, \
bara pA ett annat sAtt.'
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Rask (ravunge), nya djurvAnner",
            moral: "Varlden ar stor och full av olika vAnner att trAffa.",
            visualDescription: """
TvA olika skogar med distinkt karaktAr: den bekanta (varm, grOn) och den \
nya (mer blA-grOn med andra blommor). Nya djur med distinkt design. Rask \
mitt emellan tvA vArldar. Rikt detaljeRAde landskAPsillustrationer. \
Ljusa, inbjudande fArger.
""",
            recurringCharacterIDs: ["rask"],
            keywords: ["aventyr", "nya vAnner", "utforska", "mAngfald", "olikheter"]
        ),

        // A12 -- MidsommarfArdens Hemlighet
        ChildrenStory(
            id: "a12_midsommarfardens_hemlighet",
            title: "MidsommarfArdens hemlighet",
            synopsis: """
PA midsommarafton berAttar Oda att det nAgonstans i skogen finns en blomma \
som bara blommar en enda natt om Aret -- MidsommarljusEt. Det sAgs att den \
som hittar den fAr gOra en Onskan. Alla sex vAnnerna ger sig ut pA jakt. \
De vandrar genom sommarkvAllen, forbi alvar, Angar med smultron, och \
glittrande bAckar. NAr de till slut hittar blomman -- en lysande, vit \
blomma i en gOmd glAnta -- Onskar de alla samma sak: att de fAr vara \
vAnner fOr alltid.
""",
            category: .aventyrssagor,
            ageRange: .allAges,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi, Bjork, Lille Mopp, Rask, Droppa, Kvall-Uglan Oda",
            moral: "Den finaste Onskan ar den man delar med sina vAnner.",
            visualDescription: """
Ljus midsommarnatt med lAng solnedgAng i guld och rosa. Svenska sommarAngar \
med smultron, prAstkragar, blAklockor. Den magiska blomman lyser i mitten \
av en mOrk glAnta som ett vitt ljus. Alla sex djuren i cirkel runt blomman. \
SwEnsk sommariDyll pA sitt vackraste.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["aventyr", "midsommar", "Onskan", "vanskap", "sommar"]
        ),


        // ====================================================================
        // MARK: LAROSAGOR (Teaching/Learning Stories) -- 10 stories
        // ====================================================================
        // Stories that gently teach concepts: numbers, colors, days, sharing,
        // manners, words, shapes, and basic life skills.

        // L1 -- Bjorks Stora Rakning
        ChildrenStory(
            id: "l01_bjorks_stora_rakning",
            title: "Bjorks stora rAkning",
            synopsis: """
Bjork ska hjalpa sin mamma rAkna alla Applen i deras trAdgArd. Men han \
kan bara rAkna till fem! For varje nytt Apple han hittar ber han en vAn \
om hjAlp. Solvi lAr honom sex, Rask lAr honom sju, Lille Mopp lAr honom \
Atta, Droppa lAr honom nio, och Oda lAr honom tio. NAr alla Applen ar \
rAknade har Bjork lArt sig rAkna till tio -- och har tio Applen att dela \
med sina tio favoritvAnner.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Bjork (algkalv), alla vAnner",
            moral: "Att lAra sig gAr lAttare nar man gor det tillsammans.",
            visualDescription: """
FArgglada Applen i rOtt, grOnt, gult. Varje uppslag visar ett nytt nummer \
med stort, tydligt siffra-format. Djuren pekar och rAknar. Pedagogiskt \
upplagd med repetition. Ljusa, glAdda fArger. Tydlig visuell rAkning.
""",
            recurringCharacterIDs: ["bjork", "solvi", "rask", "lille_mopp", "droppa", "kvall_uglan"],
            keywords: ["lArande", "siffror", "rAkna", "Applen", "matematik"]
        ),

        // L2 -- FArglAdan I Skogen
        ChildrenStory(
            id: "l02_fargladan_i_skogen",
            title: "FArglAdan i skogen",
            synopsis: """
Lille Mopp vill mAla ett portrAtt av skogen men har inga fArger. Oda \
fOreslAr att han letar i skogen sjalv. Han hittar rOtt i smultronen, \
grOnt i mossan, blAtt i himlen, gult i smOrblommorna, brunt i barken, \
och vitt i nAckrosorna. For varje fArg han hittar berAttas en liten \
vers. NAr tavlan ar klar ar den den vackraste tavlan nAgon sett -- for \
den ar gjord av skogen sjalv.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kvall-Uglan Oda",
            moral: "FArgerna finns overallt i naturen om man tittar noga.",
            visualDescription: """
Varje sida domineras av en fArg: helrOd sida med smultron, helgrOn sida \
med mossa, etc. Sista sidan visar alla fArger tillsammans i Lille Mopps \
tavla. MAttad, rik akvarell. Pedagogisk men vacker.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan"],
            keywords: ["lArande", "fArger", "natur", "konst", "mAla"]
        ),

        // L3 -- Veckans Sju Dagar
        ChildrenStory(
            id: "l03_veckans_sju_dagar",
            title: "Veckans sju dagar",
            synopsis: """
Varje dag i veckan gOr djuren pA SkogsAngen nAgot speciellt. PA mAndag \
Ar det mAndag -- de tittar pA mAnen. PA tisdag planterar de TI frOn. \
PA onsdag Onskar de sig fina saker. PA torsdag dundrAr de som Tor. PA \
fredag firar de (Freja). PA lOrdag vilar de. PA sOndag sOver de lAnge. \
En rytmisk, rolig saga som lAr ut veckodagarna pA ett lekfullt sAtt.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Alla SkogsAngens djur",
            moral: "Varje dag har sitt eget vArde och sin egen aktivitet.",
            visualDescription: """
Sju tydliga uppslag, ett per dag. Varje dag har sin egen fAr och \
aktivitet. MAndag: mAnljus, blAtt. Tisdag: grOna plantor. Onsdag: \
gyllene stjArnor. Torsdag: dramatisk Aska. Fredag: fest med blommor. \
LOrdag: hAngmatta. SOndag: sOta sovande djur.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["lArande", "veckodagar", "rutin", "tid", "dagar"]
        ),

        // L4 -- Tack Och FOrlAt
        ChildrenStory(
            id: "l04_tack_och_forlat",
            title: "Tack och fOrlAt",
            synopsis: """
Rask tar Lille Mopps favorit-pinne utan att frAga. Lille Mopp blir ledsen. \
Rask fOrstAr inte fOrst vad han gjort fel -- det var ju bara en pinne! \
Men Oda fOrklarar att det inte handlar om pinnen, utan om kAnslan. Rask \
lAr sig att sAga 'fOrlAt, jag borde ha frAgat fOrst.' Och Lille Mopp \
lAr sig att sAga 'tack for att du sa fOrlAt.' Sedan hittar de en Annu \
finare pinne som de kan dela.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Rask (ravunge), Lille Mopp (ekorre), Kvall-Uglan Oda",
            moral: "Att sAga 'fOrlAt' och 'tack' ar smA ord med stor kraft.",
            visualDescription: """
Fokus pa ansiktsuttryck: Rask busig, Lille Mopp ledsen, Oda lugn och vis. \
Pinnen ar illustrerad som viktig och vacker -- inte trivial. Sista bilden: \
bAda djuren leende med en gemensam aktivitet. NAra, intima bildutsnitt.
""",
            recurringCharacterIDs: ["rask", "lille_mopp", "kvall_uglan"],
            keywords: ["lArande", "fOrlAt", "tack", "kAnslor", "empati"]
        ),

        // L5 -- Dela Lika
        ChildrenStory(
            id: "l05_dela_lika",
            title: "Dela lika",
            synopsis: """
Solvi hittar sex bAr men har fem vAnner. Om hon Ater ett sjalv och ger \
ett till varje vAn rAcker det precis! Men tAnk om hon vill ha tvA? DA \
rAcker det inte. Solvi stAr infOr ett val och bestAmmer sig fOr att dela \
lika -- ett var. NAr alla Ater sina bAr tillsammans smakar de godare An \
om hon Atit alla ensam. 'DelAd glAdje Ar dubbel glAdje,' sAger Oda.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Solvi (iggelkott), alla vAnner",
            moral: "Att dela med sig gOr att glAdjen vAxer.",
            visualDescription: """
Stora, saftiga, fArgglada bAr mot grOn bakgrund. Solvi med bAren framfOr \
sig, tankbubbla med dilemmat. Sedan: alla djur i ring, var och en med sitt \
bAr, alla glada. Enkel, tydlig komposition. Varma sommarfArger.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["lArande", "dela", "generositet", "matematik", "rAttvisa"]
        ),

        // L6 -- Var Bor Ljudetn?
        ChildrenStory(
            id: "l06_var_bor_ljuden",
            title: "VAr bor ljuden?",
            synopsis: """
Droppa hOr ett konstigt ljud: 'Ssssss.' Hon gAr fOr att leta efter det \
och hittar bAcken. Hon hOr 'Brrrrr' -- det Ar vinden i trAden. 'Kvaaak' \
-- det Ar hennes kusin i dammen. 'Knock-knock' -- det Ar hackspetten. \
FOr varje ljud hon hittar Ovar hon att sAga det sjalv. I slutet kan \
Droppa gOra alla ljud -- och hon fOrstAr att hela vArlden pratar, man \
mAste bara lyssna.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Att lyssna Ar fOrsta steget till att lAra sig prata.",
            visualDescription: """
Varje ljud illustreras med ljudmAlande typografi: stort 'SSSSS' i blAtt \
vid bAcken, 'BRRR' i grOnt vid trAden. Droppa stAr liten bredvid varje \
kAlla. Ljudvagar visualiseras som mjuka vAgor i luften. Lekfull, \
pedagogisk bildvArld.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["lArande", "ljud", "sprAk", "lyssnA", "natur"]
        ),

        // L7 -- Stora Och SmA
        ChildrenStory(
            id: "l07_stora_och_sma",
            title: "Stora och smA",
            synopsis: """
BjOrk Ar stOrst och Droppa Ar minst. Men vem Ar medelstor? Solvi? Rask? \
Lille Mopp? Djuren stAller sig i storleksordning och upptAcker att alla \
Ar olika stora. Sedan vAnder de pA det: vem har stOrst hjArta? Vem har \
stOrst mod? Vem har stOrst fantasi? DArmed fOrstAr de att storlek handlar \
om mer An hur lAng man Ar.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Alla SkogsAngens djur",
            moral: "Storlek handlar inte bara om hur lAng man Ar.",
            visualDescription: """
Djuren i rad frAn stOrst till minst, sedan tyvArtom. Sedan abstraktare: \
hjArtan i olika storlekar, mod-symboler, fantasibubblor. Enkel, tydlig \
grafik som aven de allra minsta kan fOrstA. Lekfulla fArger.
""",
            recurringCharacterIDs: ["bjork", "solvi", "rask", "lille_mopp", "droppa"],
            keywords: ["lArande", "storlek", "jAmfOrelse", "sjAlvkAnsla", "olikheter"]
        ),

        // L8 -- Solvi LAr Sig VAnta
        ChildrenStory(
            id: "l08_solvi_lar_sig_vanta",
            title: "Solvi lAr sig vAnta",
            synopsis: """
Solvi planterar ett frO och vill att det ska bli en blomma GENAST. Hon \
vattnar det, pratar med det, till och med sjunger fOr det -- men inget \
hAnder. Hon ar frustrerad. Oda fOrklarar att vAxande tar tid, precis \
som att lAra sig springa eller att tAnderna ska komma. Varje dag gAr \
Solvi och tittar -- och en dag, NAr hon nAstan gett upp, sticker en \
liten grOn spira upp ur jorden. TAlAmod belOnas!
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), Kvall-Uglan Oda",
            moral: "Det som Ar vArt att vAnta pA tar tid att vAxa.",
            visualDescription: """
Sekvens av jord med ett litet frO: dag 1, dag 2, dag 3... Solvi allt \
mer otAlig. Sedan: en liten grOn spira i nArbild, magisk och vacker. \
Solvi stOr och stor. Jordiga, bruna toner som brister ut i grOnt \
pA sista bilden.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["lArande", "tAlamod", "vAxa", "natur", "vAnta"]
        ),

        // L9 -- Rasks Dagar och NAtter
        ChildrenStory(
            id: "l09_rasks_dagar_och_natter",
            title: "Rasks dagar och nAtter",
            synopsis: """
Rask vill vara uppe hela natten som Oda. Men nar han forsOker vakar han \
nAstan inte och somnar stAnde! Oda skrattar vAnligt och fOrklarar att \
olika djur Ar vakna vid olika tider: ugglor pA natten, ekorrar pA dagen, \
rAvar i skymningen. Hon berAttar om dygnet som ett stort hjul som snurrar \
-- och att alla har sin tid. NAr Rask gAr hem och lAgger sig i sin gryt \
just vid gryningen kAnner han att hans tid Ar skymningen, och det Ar \
precis rAtt.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (ravunge), Kvall-Uglan Oda",
            moral: "Alla har sin egen tid och rytm, och alla Ar lika viktiga.",
            visualDescription: """
Ett stort dygnshjul som visar 24 timmar med olika djur aktiva vid olika \
tider. Solen och mAnen rOr sig. Rask fOrsOker hAlla sig vaken med komiskt \
gAspande. Cirkulaer komposition. Blatt, guld och rOtt (skymning).
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["lArande", "dygn", "tid", "natt", "dag"]
        ),

        // L10 -- ArstidsbOckerna
        ChildrenStory(
            id: "l10_arstidsrockerna",
            title: "ArstidsbOckerna",
            synopsis: """
VAren har en grOn rock, sommaren en gul, hOsten en rOd och vintern en vit. \
Solvi och BjOrk vandrar genom Aret och mOter varje Arstid som en person: \
VArfrun med fAglar i hAret, Sommarkungen med sol pA brOstet, HOstbarnet \
med fickor fulla av nOtter, och VinterbestemOr med en mjuk snOfilt. Varje \
Arstid ger dem en gAva: ett frO, ett bAr, ett lOv och en istapp. \
Tillsammans blir gAvorna en ArsGirland.
""",
            category: .larosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi (iggelkott), BjOrk (algkalv), fyra Arstidspersoner",
            moral: "Varje Arstid Ar speciell och har sin skOnhet.",
            visualDescription: """
Fyra distinkta fArgvArldar: grOnt, gult, rOtt, vitt. Arstidspersonerna \
Ar stora, magiska figurer -- tAnk Elsa Beskow-inspirerade men helt \
egna. ArsGirlanden glittrar i fyra fArger pA sista sidan. Rikt \
dekorerat, nAra naturen.
""",
            recurringCharacterIDs: ["solvi", "bjork"],
            keywords: ["lArande", "Arstider", "natur", "fArger", "Ar"]
        ),


        // ====================================================================
        // MARK: NATURSSAGOR (Nature Stories) -- 11 stories
        // ====================================================================
        // Stories about animals, forests, seasons, weather, and the natural
        // world. Teach respect for nature and ecological awareness.

        // N1 -- Solvins Sista Dag FOrE Vintervilan
        ChildrenStory(
            id: "n01_solvis_sista_dag",
            title: "Solvis sista dag fOre vintervilan",
            synopsis: """
HOsten Ar hAr och Solvi mAste snart gA i ide. Hon har en enda dag kvar \
och vill hinna med allt: sAga hejdA till BjOrk, samla de sista bAren, \
krama Oda (som inte sover pA vintern), och lyssna pA Droppas sista sAng \
fOre vintern. Varje adjO Ar lite sorgligt men ocksa varmt. NAr hon \
krupar ner i sin hAla bAr hon med sig alla kArlek-fyllda minnen -- \
och vet att vAren kommer.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), alla vAnner",
            moral: "AdjO behOver inte vara fOr alltid -- ibland Ar det bara fOr en stund.",
            visualDescription: """
HOstlandskap i guld, rOtt och brunt. LOv faller. Sekvens av avskedsscener, \
var och en varm och kArleksfull. Sista bilden: Solvi ihoprullad i sin \
hAla, omgiven av torkade lOv, med ett litet leende. Varma, rika hOstfArger.
""",
            recurringCharacterIDs: ["solvi", "bjork", "kvall_uglan", "droppa"],
            keywords: ["natur", "hOst", "vintervila", "avsked", "Arstider"]
        ),

        // N2 -- Algen Och Storken
        ChildrenStory(
            id: "n02_algen_och_storken",
            title: "Algen och storken",
            synopsis: """
BjOrk mOter en stork som landat pA Skogsangen fOr att vila pA sin lAnga \
resa sOderut. De Ar sA olika: BjOrk stAnnar alltid, storken flyger alltid. \
Men bAda Alskar sjOn, himlen, och att stA tyst i vassen. De tillbringar \
en dag tillsammans och delar sina berAttelser: BjOrk om vinterns tystnad, \
storken om Afrikas vArme. NAr storken flyger vidare viftar BjOrk hejdA \
och viskar: 'Berata om mig dar nere.'
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "BjOrk (algkalv), en stork",
            moral: "Man kan vara vAnner Aven om man lever helt olika liv.",
            visualDescription: """
Stor alg och elegant stork sida vid sida i en sjOkant med vass. Stor \
kontrast i storlek och form. HOstlandskap. NAr storken flyger ivAg: \
BjOrk liten pA marken, storken hOgt i luften. Naturalistiska toner, \
mjukt ljus.
""",
            recurringCharacterIDs: ["bjork"],
            keywords: ["natur", "fAglar", "migration", "vanskap", "olikheter"]
        ),

        // N3 -- Regnbagens Hemlighet
        ChildrenStory(
            id: "n03_regnbagens_hemlighet",
            title: "RegnbAgens hemlighet",
            synopsis: """
Efter ett sommarregn ser Droppa en regnbAge fOr fOrsta gAngen och tror \
att det Ar en bro till en magisk plats. Hon vill klAttra upp pA den! \
Rask fOrsOker hjAlpa henne nA den, men den fOrsvinner varje gAng de \
kommer nAra. Oda fOrklarar att regnbAgen Ar ljus och vatten som dansar \
tillsammans -- man kan inte rOra den, men man kan njuta av den. Droppa \
fOrstAr: 'Vissa vackra saker behOver man inte fAnga.'
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Rask (ravunge), Kvall-Uglan Oda",
            moral: "Man behOver inte Aga det vackra -- det rAcker att se det.",
            visualDescription: """
StOr, strAlande regnbAge Over Skogsangen. Droppa och Rask springer mot \
den. Ljus bryts i daggdroppar. Sista bilden: alla tre ser pA regnbAgen \
tillfreds, utan att jaga den. Lysande vAta fArger, ljust och glittrande.
""",
            recurringCharacterIDs: ["droppa", "rask", "kvall_uglan"],
            keywords: ["natur", "regnbAge", "ljus", "undran", "njutning"]
        ),

        // N4 -- TraDet Som Visste Allt
        ChildrenStory(
            id: "n04_tradet_som_visste_allt",
            title: "TrAdet som visste allt",
            synopsis: """
Mitt pA SkogsAngen stAr en urgammal ek. Alle djuren vet att den Ar speciell, \
men ingen vet exakt varfOr. En dag sAtter sig Solvi vid dess rOtter och \
borjar lyssna. TrAdet 'berAttar' -- inte med ord, utan med ljud: vinden \
i lOven Ar dess sAng, fAglarna i grenarna Ar dess vAnner, rOtterna i \
jorden Ar dess minnen. Solvi fOrstAr att trAdet vet allt om skogen fOr \
att det har stAtt dAr i hundra Ar och lyssnat.
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), det gamla trAdet",
            moral: "Naturen har sin egen visdom -- man mAste bara lyssna.",
            visualDescription: """
Enorm ek som fyller hela bilden. Solvi pytteliten vid rOtterna. \
Detaljerade rOtter, grenar, lOv. DjurlIv i varje hOrn: fAglar, \
insekter, svampar. Rik, detaljerad illustration i naturliga toner. \
TrAdets 'berAttelser' som visuella vAgor.
""",
            recurringCharacterIDs: ["solvi"],
            keywords: ["natur", "trad", "visdom", "lysSna", "ekologi"]
        ),

        // N5 -- SommarAngens SmAfOlk
        ChildrenStory(
            id: "n05_sommarangens_smafolk",
            title: "SommarAngens smAfolk",
            synopsis: """
Lille Mopp upptAcker att Angen Ar full av smA varelser han aldrig mArkt \
fOrut: nyckelpigor, myror, fjArilar, humler. Han tillbringar en hel \
dag pA magen i grAset och observerar deras vArld. Myrorna bygger stAder, \
fjArilarna dansar, humlorna sjunger. Han inser att det finns en hel \
vArld under hans fOtter som han aldrig sett -- och att de smA djuren \
Ar precis lika viktiga som de stora.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Alla levande varelser Ar viktiga, Aven de allra minsta.",
            visualDescription: """
Makro-perspektiv: grAstrAn som skyskrapor, daggdroppar som spegelklot. \
Insekter i fantastisk detalj. Lille Mopp liggande pA mage med nAsan i \
grAset. Lysande grOnt, somrigt, detaljrikt. FOrstarade proportioner \
som gOr det lilla stort.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["natur", "insekter", "sommar", "observation", "smAkryp"]
        ),

        // N6 -- Molnens Former
        ChildrenStory(
            id: "n06_molnens_former",
            title: "Molnens former",
            synopsis: """
Bjork och Solvi ligger pA en kulle och tittar pA molnen. 'Det dAr Ar en \
kanin!' sAger Solvi. 'Nej, det Ar en Al,' sAger BjOrk. De inser att \
molnen ser olika ut beroende pA vem som tittar. Droppa ser en nAckros, \
Rask ser en rav, Lille Mopp ser en pensel. Oda fOrklarar att det heter \
fantasi -- och att fantasi Ar den finaste gAvan man har.
""",
            category: .naturssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "BjOrk, Solvi, alla vAnner",
            moral: "Alla ser vArlden pA sitt eget sAtt, och alla sAtt Ar rAtt.",
            visualDescription: """
Himmel med fantastiska moln som subtilt liknar olika djur beroende pA \
vinkel. Djuren liggande i grAs pA en kulle. Varje djurs perspektiv \
visas i en tankbubbla. Ljus, luftig akvarell med dominerande blAtt \
och vitt.
""",
            recurringCharacterIDs: ["bjork", "solvi", "droppa", "rask", "lille_mopp", "kvall_uglan"],
            keywords: ["natur", "moln", "fantasi", "perspektiv", "himmel"]
        ),

        // N7 -- Den FOrsta VArdagen
        ChildrenStory(
            id: "n07_den_forsta_vardagen",
            title: "Den fOrsta vArdagen",
            synopsis: """
Hela vintern har Solvi sovit. NAr hon vaknar Ar allt fOrandrat: snOn smAlter, \
bAckar rinner, fAglar sjunger, och de fOrsta blommorna tittar fram. Hon \
kAnner inte igen sin skog! Men snart mOter hon BjOrk (som fAtt riktiga \
horn nu!), och han visar henne allt nytt. Det bAsta Ar att dammen Ar \
isfri och Droppa sitter pA sitt nAckrosblad igen. VAnner Aterforenas \
och fIrar vAren.
""",
            category: .naturssagor,
            ageRange: .allAges,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), BjOrk (algkalv), Droppa (groda)",
            moral: "FOrAndringar kan vara skrAmmande men ocksa underbara.",
            visualDescription: """
VArlandskap med smAltande snO, krokus, bAckar, grOnskande trAd. Solvi \
gAr Osaker ut ur sin hAla -- ljuset Ar starkt. Sista bilden: alla tre \
vAnner vid dammen i fult vArljus. FArglAdan exploderar: grOnt, lila, \
gult, ljusblAtt.
""",
            recurringCharacterIDs: ["solvi", "bjork", "droppa"],
            keywords: ["natur", "vAr", "uppvaknande", "fOrAndring", "Arstider"]
        ),

        // N8 -- BlABArsstigen
        ChildrenStory(
            id: "n08_blAbarsstigen",
            title: "BlAbArsstigen",
            synopsis: """
Det Ar blAbArstid och Rask fOreslAr en tavling: vem kan plocka flest? \
Men nAr Rask springer ivAg och plockar snabbt trampar han ner buskar \
och stOr andra djur. Solvi, som plockar lAngsamt och fOrsiktigt, fAr \
fArre bAr -- men hennes buskar mAr bra och kan ge bAr nAsta Ar ocksa. \
Rask fOrstAr att man mAste ta hand om naturen sA att den kan ge mer.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Rask (ravunge), Solvi (iggelkott)",
            moral: "Om vi tar hand om naturen tar naturen hand om oss.",
            visualDescription: """
SvEnsk sommarskog med blAbArsris. Rask rusande genom buskarna, bAr \
flygande. Solvi fOrsiktigt plockande, buskarna intakta. Tvedelad bild \
som visar kontrasten. Sommargrnt med blAa bAraccenter.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["natur", "blAbAr", "hallbarhet", "fOrsiktighet", "skog"]
        ),

        // N9 -- Stormen
        ChildrenStory(
            id: "n09_stormen",
            title: "Stormen",
            synopsis: """
En hOststorm drar in Over SkogsAngen. Vinden tjuter, regnet piskar, och \
trAden bOjer sig. Alla djur gOmmer sig i sina bon och Ar rAdda. Men \
Oda, som sett hundratals stormar, sjunger en lugn sAng frAn sitt trAd. \
Hennes rOst nAr alla bon: 'Stormar gAr Alltid Over. HAll i varandra.' \
NAr stormen passerat Ar skogen fOrAndrad: en del grenar har fallit, men \
Aven nya platser har Oppnats. FOrAndring Ar nAturens sAtt att skapa nytt.
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Kvall-Uglan Oda, alla SkogsAngens djur",
            moral: "Stormar Ar skrAmmande men gAr alltid Over, och efterAt vAntar nAgot nytt.",
            visualDescription: """
Dramatisk stormscen: mOrka moln, bOjda trAd, regn i diagonala streck. \
Djur i sina bon, Oda lugn i sin gren. EfterAt: solljus genom moln, \
regnbAge, nytt ljus Over skogen. Kontrastrik: stormscen i mOrkt, \
efterAt i guld.
""",
            recurringCharacterIDs: ["kvall_uglan", "solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["natur", "storm", "mod", "fOrAndring", "trygghet"]
        ),

        // N10 -- FiskEn Som VAnde Om
        ChildrenStory(
            id: "n10_fisken_som_vande_om",
            title: "Fisken som vAnde om",
            synopsis: """
Droppa har en vAn i dammen: en liten fisk vid namn Blick. En dag \
bestAmmer Blick att han vill simma Anda ut i stora sjOn. Droppa Ar \
orolig -- sjOn Ar stor och okAnd! Men hon fOljer med Anda till \
dammens utlopp. Blick simmar ut... och efter en stund vAnder han om \
och kommer tillbaka. 'Det var spAnnande dAr ute,' sAger han, 'men \
mitt hem Ar hAr.' Ibland mAste man resa ivAg fOr att fOrstA vad man \
redan har.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda), Blick (fisk)",
            moral: "Ibland behOver man Aka ivAg fOr att fOrstA hur fint man har det hemma.",
            visualDescription: """
Klar, genomskinlig damm med fisk under ytan. Droppa ovanpA. Vattnet \
vidgas till en stOrre sjO. Fisken som en liten silverprick som simmar \
ut och tillbaka. Undervattenspalett: turkos, silver, grOnt. Stilla, \
frEdfullt.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["natur", "vatten", "hem", "resa", "tillhOrighet"]
        ),

        // N11 -- Svampskogen
        ChildrenStory(
            id: "n11_svampskogen",
            title: "Svampskogen",
            synopsis: """
PA hOsten tar Oda med sig alla djur pA en svampvandring. Hon lAr dem \
skilja de goda frAn de giftiGa: 'Kantarellens gyllene form, karl-johanns \
bruna hAtt, men rOr aldrig den rOda med vita prickar!' Varje djur hittar \
sin favorit, och de lagar en gemensam svampsoppa Over en liten eld. \
Rask vill fuskA och smaka rA svamp, men Oda stoppar honom: 'Naturen \
Ar generOs, men krAver respekt.'
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Kvall-Uglan Oda, alla vAnner",
            moral: "Naturen ger oss mycket, men vi mAste lAra oss vad som Ar sAkert.",
            visualDescription: """
HOstskog med fantastiska svampar i alla fOrmer och fArger. Detaljrika \
illustrationer av kantareller, karl-johan, flugsvamp. Djuren med smA \
korgar. Kvallseld med Angande soppa. Varma hOstfArger: guld, brunt, \
rOtt, grOnt.
""",
            recurringCharacterIDs: ["kvall_uglan", "solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["natur", "svamp", "hOst", "sAkerhet", "kunskap"]
        ),


        // ====================================================================
        // MARK: KANSLOSAGOR (Emotion/Feeling Stories) -- 10 stories
        // ====================================================================
        // Stories that help children identify, process, and express emotions.
        // Each focuses on a specific feeling with healthy coping strategies.

        // K1 -- NAr BjOrk Blev Arg
        ChildrenStory(
            id: "k01_nar_bjork_blev_arg",
            title: "NAr BjOrk blev arg",
            synopsis: """
BjOrk Ar nAstan aldrig arg. Men en dag trampar Rask pA hans favoritblomma \
av misstag, och BjOrk kAnner en het, rOd kAnsla stiga i brOstet. Han \
stampar, han snOrvlar, han vill skrika. Oda kommer fram och sAger: 'Det \
Ar okej att vara arg. Ilskan Ar som en storm inuti -- den gAr Over.' \
Hon visar honom att andas djupt, stAmpa i marken, och sedan prAta om \
vad han kAnner. NAr ilskan gAtt berAttAr BjOrk fOr Rask att blomman \
var viktig, och Rask hjAlper honom plantera en ny.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "BjOrk (algkalv), Rask (ravunge), Kvall-Uglan Oda",
            moral: "Ilska Ar en naturlig kAnsla -- det viktiga Ar vad man gOr med den.",
            visualDescription: """
BjOrks ilska visualiseras som rOda vAgor runt hans kropp. Ansiktsuttrycken \
gAr frAn mild via arg via ledsen till lugn. Rask ser liten och AngerFull \
ut. Sista bilden: de planterar tillsamans. Kontrast mellan rOda ilska-bilder \
och lugna grOna slut-bilder.
""",
            recurringCharacterIDs: ["bjork", "rask", "kvall_uglan"],
            keywords: ["kAnslor", "ilska", "hantering", "andning", "fOrlAtelse"]
        ),

        // K2 -- Droppas Hemliga TArAr
        ChildrenStory(
            id: "k02_droppas_hemliga_tarar",
            title: "Droppas hemliga tArar",
            synopsis: """
Droppa grAter ibland, men ingen vet om det fOr att hennes tArar faller \
rakt ner i dammen och fOrsvinner. En dag ser Solvi att vattnet runt Droppa \
krusas konstigt och frAgar vad som hAnder. Droppa berAttar att hon ibland \
kAnner sig ledsen utan att veta varfOr. Solvi sAger: 'Det Ar okej att grAta. \
Mina taggar gOr ont ibland ocksa -- inuti.' De sitter tysta tillsammans \
vid dammen, och Droppa mArker att bara det att nAgon VET att hon Ar ledsen \
gOr att det kAnns bAttre.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Solvi (iggelkott)",
            moral: "Man behOver inte vara ensam med sin ledsamhet.",
            visualDescription: """
TArAr som faller i vatten, krusningar som sprider sig. Droppas uttryck: \
fOrst dOljande, sedan sArbart, sedan lAttat. Solvi nAra, inte inkrAktande \
men nArvarande. Blaa och grOna toner, mjukt vatten-ljus. Stilla, \
intima bilder.
""",
            recurringCharacterIDs: ["droppa", "solvi"],
            keywords: ["kAnslor", "ledsamhet", "grAta", "vAnskap", "trost"]
        ),

        // K3 -- Rask Vill Inte Vara Ensam
        ChildrenStory(
            id: "k03_rask_vill_inte_vara_ensam",
            title: "Rask vill inte vara ensam",
            synopsis: """
Rask mArker att hans vAnner ibland vill vara ifred -- Solvi sover, BjOrk \
tittar pA stjArnor, Lille Mopp mAlar. Rask kAnner sig avvisad och tror \
att ingen tycker om honom. Han springer runt och stOr alla fOr att fA \
uppmArksamhet. Till slut sAtter sig Oda ner och fOrklarar: 'NAr dina \
vAnner behOver tid ensamma betyder det inte att de inte tycker om dig. \
Alla behOver lugn ibland.' Rask lAr sig att vara ensam en stund -- och \
upptAcker att han ocksa kan gilla det.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (ravunge), Kvall-Uglan Oda",
            moral: "Att vara ensam ibland Ar inte samma sak som att vara ensam fOr alltid.",
            visualDescription: """
Rask i rOrelse fOrbi bon dAr vAnner Ar upptagna. Varje vAn i sin bubbla \
av lugn. Rask stOr och ensam. Sedan: Rask ensam men lugn, med en fin \
vy. Kontrast: hektisk bOrjan, stilla slut. Orangea och blAa toner.
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["kAnslor", "ensamhet", "uppmArksamhet", "sjAlvstandighet", "grAnser"]
        ),

        // K4 -- Lille Mopps Oro
        ChildrenStory(
            id: "k04_lille_mopps_oro",
            title: "Lille Mopps oro",
            synopsis: """
Lille Mopp kan inte somna fOr att han oroar sig fOr imorgon. TAnk om \
det regnar? TAnk om han inte hittar nOtter? TAnk om hans vAnner inte \
vill leka? Oron fOrestAlls som en liten mOrk boll i hans mage som vAxer. \
Oda lAr honom att ta ut Oron ur magen och titta pA den: 'Vad Ar det \
vArsta som kan hAnda?' Ofta Ar svaret: 'Ingenting farligt.' Och om det \
hAnder? 'DA lOser vi det.' Bollen krymper. Lille Mopp andas ut och \
somnar.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kvall-Uglan Oda",
            moral: "Oron Ar ofta stOrre i huvudet An i verkligheten.",
            visualDescription: """
Lille Mopp i sin gren, vAkande, med en liten svart boll i magen som syns \
genom pAlsen. Bollen visualiseras med oroliga mOnster. Oda lugn. \
Bollen krymper steg fOr steg. Sista bilden: Lille Mopp sover, bollen \
borta. MOrka toner som ljusnar.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan"],
            keywords: ["kAnslor", "oro", "Angest", "sOmn", "hantering"]
        ),

        // K5 -- Den Nya VAn
        ChildrenStory(
            id: "k05_den_nya_van",
            title: "Den nya vAnnen",
            synopsis: """
En ny djurfamilj flyttar till SkogsAngen: en liten bAver vid namn TindRA. \
Hon pratar annorlunda, bygger annorlunda, och Ater annan mat. FOrst Ar \
Rask tveksam -- varfOr gOr hon saker sA konstigt? Men NAr TindrA bygger \
den finaste dammen nAgon nAgonsin sett, och lAr Solvi simma pA ett nytt \
sAtt, och gOr de roligaste lekarna, fOrstAr alla att 'annorlunda' inte \
betyder 'konstig' -- det betyder 'spAnnande.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "TindrA (bAver), Rask (ravunge), Solvi (iggelkott)",
            moral: "Olikheter Ar inte nAgot att vara rAdd fOr -- de gOr livet rikare.",
            visualDescription: """
TindrA: brun bAver med glittrande Ogon och en platt svans. Ny fArg- och \
formvArld nAr hon bygger. FOrst: djuren pA avstAnd. Sedan: alla nAra, \
lekande, lArande. TindrAs bAverdamm som konstverk. Varma, inkluderande \
bilder.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["kAnslor", "inkludering", "mAngfald", "fOrdom", "vAnskap"]
        ),

        // K6 -- Solvi HAller Sig Modig
        ChildrenStory(
            id: "k06_solvi_haller_sig_modig",
            title: "Solvi hAller sig modig",
            synopsis: """
Solvi mAste gA till andra sidan av skogen fOr att hAmta medicin-Ort till \
sin mormor. VAgen Ar lAng och hon Ar rAdd. Men fOr varje steg hon tar \
sAger hon till sig sjalv: 'Jag Ar modig, jag Ar modig.' NAr hon hOr ett \
ljud stAnnar hon, andas, och gAr vidare. NAr hon nAr fram kAnner hon sig \
starkare An nAgonsin. Oda sAger: 'Mod Ar inte att inte vara rAdd. Mod \
Ar att vara rAdd och gOra det andA.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), Kvall-Uglan Oda",
            moral: "Mod handlar inte om att aldrig vara rAdd, utan om att vAga AndA.",
            visualDescription: """
LAngs stig genom varierad skog: ljusa partier, mOrka partier. Solvi liten \
men bestAmd. Hennes rOda halsduk som en flagga. Varje 'skrAmmande' element \
visar sig vara ofarligt i nAsta bild. ReSAn fOrn ljust till mOrkt till \
ljust igen.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["kAnslor", "mod", "rAdsla", "styrka", "sjAlvtillit"]
        ),

        // K7 -- AvundsjukeAvunden
        ChildrenStory(
            id: "k07_avundsjukeavunden",
            title: "AvundsjukeAvunden",
            synopsis: """
Lille Mopp Ar avundsjuk pA Rask fOr att Rask Ar snabbare. Rask Ar avundsjuk \
pA BjOrk fOr att BjOrk Ar starkare. BjOrk Ar avundsjuk pA Lille Mopp fOr \
att Lille Mopp Ar kreativare. De gAr runt och Ar missnOjda -- tills Oda \
stAller dem i en ring och ber var och en berata vad de beundrar hos den \
andra. PlOtsligt fOrstAr de: alla vill vara nAgon annan, men alla Ar \
beundrade fOr det de redan Ar.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp, Rask, BjOrk, Kvall-Uglan Oda",
            moral: "Alla har unika gAvor -- att vara sig sjAlv Ar det bAsta man kan vara.",
            visualDescription: """
Djuren med 'grOna' avundsjuka-moln Over huvudena. NAr de pratar skingras \
molnen och ersAtts av gyllene stjArnor. Ring-formation runt Oda. \
Kontrast: grOna, mOrka avundstoner vs. gyllene, varma uppskattnings-toner.
""",
            recurringCharacterIDs: ["lille_mopp", "rask", "bjork", "kvall_uglan"],
            keywords: ["kAnslor", "avundsjuka", "sjAlvkAnsla", "uppskattning", "identitet"]
        ),

        // K8 -- Den Tunga Ryggsacken
        ChildrenStory(
            id: "k08_den_tunga_ryggsacken",
            title: "Den tunga ryggsAcken",
            synopsis: """
BjOrk bAr pA en osynlig ryggsAck som kAnns tyngre fOr varje dag. I den \
ligger saker han inte sagt: att han saknar sin pappa, att han tycker det \
Ar jobbigt att vara ny, att han ibland kAnner sig dum fOr att han Ar sA \
tyst. NAr ryggsAcken blir fOr tung att bAra sAtter han sig ner och grAter. \
Solvi sAtter sig bredvid och sAger: 'BerAttA.' FOr varje sak han sAger \
hOgt blir ryggsAcken lAttare, tills han till slut kan resa sig igen.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "BjOrk (algkalv), Solvi (iggelkott)",
            moral: "Att bAra pA kAnslor i tysthet gOr dem tyngre -- att berata gOr dem lAttare.",
            visualDescription: """
En osynlig ryggsAck visualiserad som en halvgenomskinlig bOrda pA BjOrks \
rygg, fylld med mOrka moln. FOr varje 'berAttelse' lyfter ett moln bort \
och blir till en fAgel som flyger ivAg. Sista bilden: BjOrk stAr rak, \
himlen full av fAglar, ryggsAcken borta. Djupa, kAnsliga bilder.
""",
            recurringCharacterIDs: ["bjork", "solvi"],
            keywords: ["kAnslor", "saknad", "prata", "tyngd", "befrielse"]
        ),

        // K9 -- NisseMissar Mamma
        ChildrenStory(
            id: "k09_nisse_missar_mamma",
            title: "Nisse missar mamma",
            synopsis: """
Nisse Ar en liten mus som bOrjar pA dagis (SkogsAngens Forsta FOrskola) \
fOr fOrsta gAngen. Hans mamma lAmnar honom och han kAnner en stor klump \
i halsen. Allt Ar nytt och alla Ar frAmmande. Men nAr han sakta bOrjar \
utforska hittar han en rolig lAda med pinnar, en vAnlig lArare (en gammal \
hare), och en annan mus som ocksa Ar ny. NAr mamma hAmtar honom pA \
eftermiddagen skiner Nisse: 'Mamma, imorgon vill jag komma tillbaka!'
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Nisse (mus), mammamusen, lArarHaren",
            moral: "Det som kAnns lAskigt fOrst kan bli nAgot man Alskar.",
            visualDescription: """
Liten mus i en stOr, ny miljO. FOrskolan Ar en varm, mysig plats i en \
urgammal stubbe. MammaMusen vinkar i dOrren. Nisse fOrst liten och \
osAker, sedan stOrre och modigare. Varma, inbjudande fArger. Avslutande \
stor kram-scen.
""",
            recurringCharacterIDs: [],
            keywords: ["kAnslor", "separation", "dagis", "ny", "mod"]
        ),

        // K10 -- Alla Kan Inte Allt
        ChildrenStory(
            id: "k10_alla_kan_inte_allt",
            title: "Alla kan inte allt",
            synopsis: """
Det Ar talangshow pA SkogsAngen! Rask kan springa snabbast. Droppa kan \
sjunga vackrast. Lille Mopp kan bygga finast. Men Solvi kan inte hitta \
sin talent. Hon kan inte springa fort, sjunga bra, eller bygga fint. \
Hon Ar ledsen -- tills hon mArker att det Ar HON som trOstar alla som \
fOrlorar, HON som hejar pA alla, HON som fAr alla att kAnna sig sedda. \
Oda sAger: 'Din talang Ar att se andra, Solvi. Det Ar den viktigaste \
talangen av alla.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (iggelkott), alla vAnner, Kvall-Uglan Oda",
            moral: "Att vara snAll och se andra Ar en lika viktig talang som alla andra.",
            visualDescription: """
Skogsscen med en improvised scen. Djuren upptrAder: Rask springer, \
Droppa sjunger, Lille Mopp bygger. Solvi i publiken, hejar, trOstar, \
ler. Sista bilden: alla lyfter Solvi pA sina axlar. Festliga, varma, \
glada fArger.
""",
            recurringCharacterIDs: ["solvi", "rask", "droppa", "lille_mopp", "kvall_uglan"],
            keywords: ["kAnslor", "talang", "sjAlvkAnsla", "empati", "uppskattning"]
        )
    ]
}
