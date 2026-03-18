import SwiftUI

// MARK: - Story Category

enum StoryCategory: String, CaseIterable {
    case godnattssagor = "Godnattssagor"
    case aventyrssagor = "Äventyrssagor"
    case larosagor = "Lärosågor"
    case naturssagor = "Naturssagor"
    case kanslosagor = "Känslosagor"

    var displayName: String {
        switch self {
        case .godnattssagor: return "Godnattssagor"
        case .aventyrssagor: return "Äventyrssagor"
        case .larosagor: return "Lärosågor"
        case .naturssagor: return "Naturssagor"
        case .kanslosagor: return "Känslosagor"
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
    case baby = "0-1 år"
    case toddler = "1-3 år"
    case preschool = "3-5 år"
    case allAges = "Alla åldrar"

    var displayName: String {
        switch self {
        case .baby: return "0-1 år"
        case .toddler: return "1-3 år"
        case .preschool: return "3-5 år"
        case .allAges: return "Alla åldrar"
        }
    }
}

// MARK: - Story Length

enum StoryLength: String, CaseIterable {
    case short = "Kort"
    case medium = "Medel"
    case long = "Lång"

    var displayName: String {
        switch self {
        case .short: return "Kort (~2 min)"
        case .medium: return "Medel (~5 min)"
        case .long: return "Lång (~10 min)"
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
            species: "Igelkott (hedgehog)",
            personality: """
Solvi är en liten igelkott med ett stort hjärta och en ännu större nyfikenhet. \
Hon är alltid den första att välja den okända stigen i skogen, den första att \
kliva in i en mörk grotta för att se vad som finns där, och den första att \
räcka ut en tass till någon som behöver hjälp. Trots att hon är liten och taggig \
har hon en värme som gör att alla djur i Skogängen känner sig trygga bredvid \
henne. Hon kan ibland vara lite otålig och rusar iväg innan hon tänkt färdigt, \
vilket leder till komiska situationer där hennes vänner får hjälpa henne.
""",
            visualDescription: """
En liten brun igelkott med mjuka, avrundade taggar i varma nyanser av guld \
och kastanjebrun. Har stora, runda, nyfikna ögon i bärnstensfärgen. Bär en \
liten röd halsduk som hon fått av sin mormor. Hennes nos är rund och lekfull. \
Illustrationsstil: Varm akvarell med mjuka kanter, inspirerad av skandinavisk \
barnboksestetik. Alltid tecknad i rörelse -- springande, klängande, tittande.
""",
            backstory: """
Solvi bor i en liten moss-klädd hålighet under en gammal ek på Skogängen. \
Hennes mormor, Mormor Tagga, var den modigaste igelkotten i hela skogen, \
och Solvis röda halsduk är ett arv från henne. Solvi drömmer om att en dag \
vandra hela vägen till Norra Berget, där det sägs att norrsken dansar även \
på sommaren.
""",
            catchphrase: "Kom, vi tar reda på det!",
            relatedCharacterIDs: ["bjork", "lille_mopp", "kvall_uglan", "rask", "droppa"]
        ),

        // 2. BJORK -- THE GENTLE MOOSE CALF
        RecurringCharacter(
            id: "bjork",
            name: "Björk",
            species: "Älgkalv (moose calf)",
            personality: """
Björk är en ung älgkalv som är större än de flesta andra djuren på Skogängen \
men som ändå är försiktig och snäll. Han är den tysta typen som hellre lyssnar \
än pratar, men när han väl säger något är det alltid genomtänkt och klokt. \
Han älskar att titta på stjärnorna och drömmer om att förstå varför löven \
byter färg på hösten. Björk är den som alltid ser till att alla får vara med \
i leken, och om någon känner sig utanför är det Björk som sakta går fram och \
sätter sig bredvid. Hans storlek gör att han ibland är klumpig och välter \
ner saker, vilket han själv brukar skratta åt.
""",
            visualDescription: """
En ung älg med ljusbrun, mjuk päls och små knubbar där hornen snart ska växa. \
Har stora, milda ögon i mörkt brun med långa ögonfransar. Överstor nos som \
ger ett komiskt, älskligt uttryck. Bär ibland en hemstickad blå mössa som \
hans mamma gjort. Illustrationsstil: Mjuka pasteller, stor och rund form \
som utstrålar lugn och trygghet. Ofta tecknad sittande och tittande uppåt.
""",
            backstory: """
Björk bor med sin mamma Alma vid den stora sjön Spegelvatten. Hans pappa \
vandrar ibland långt bort i skogarna, men kommer alltid tillbaka. Björk \
är nyligen inflyttad till Skogängen och håller fortfarande på att lära \
känna alla. Hans bästa vän är Solvi, som var den första att hälsa på honom.
""",
            catchphrase: "Jag tror... vi kanske kan prova tillsammans?",
            relatedCharacterIDs: ["solvi", "lille_mopp", "kvall_uglan", "rask", "droppa"]
        ),

        // 3. LILLE MOPP -- THE CREATIVE SQUIRREL
        RecurringCharacter(
            id: "lille_mopp",
            name: "Lille Mopp",
            species: "Ekorre (squirrel)",
            personality: """
Lille Mopp är en sprallig, kreativ ekorre som alltid har ett nytt projekt på gång. \
Han bygger, målar, uppfinner, och gör musik av allt han hittar -- pinnar blir \
trumstockar, löven blir målarpenslar, stenar blir skulpturer. Han pratar snabbt \
och tänker ännu snabbare, och det är inte alltid hans vänner hänger med i alla \
hans tankesprang. Men bakom allt bus och skapande finns också en liten ekorre \
som ibland oroar sig för att inte vara tillräckligt bra. När han känner sig \
orolig hittar han tröst i att skapa något vackert.
""",
            visualDescription: """
En rostbrun ekorre med en enorm fluffig svans som nästan är större än han \
själv. Har glittrande, livliga ögon i grönt. Pätsens färg skiftar från \
rost till guld. Har alltid något i tassarna -- en pinne, ett löv, en sten. \
Bär en liten grön barett på sne. Illustrationsstil: Energisk, med små \
rörelsestrek runt figuren som visar att han aldrig står stilla. Ljusa, \
glada färger.
""",
            backstory: """
Lille Mopp bor högst upp i den stora granen mitt på Skogängen, i ett \
litet bo som han lagt hela sin själ i att dekorera. Väggarna är \
tapetserade med torkade blommor, stenar i fina färger och små konstverk \
han gjort av bark. Han har aldrig träffat sin pappa och bor med sin \
faster, Tant Noto, som är bibliotekets väktare.
""",
            catchphrase: "Vänta, vänta, jag har en idé!",
            relatedCharacterIDs: ["solvi", "bjork", "kvall_uglan", "rask", "droppa"]
        ),

        // 4. KVALL-UGLAN ODA -- THE WISE OLD OWL
        RecurringCharacter(
            id: "kvall_uglan",
            name: "Kväll-Uglan Oda",
            species: "Kattuggla (tawny owl)",
            personality: """
Oda är den äldsta och visaste varelsen på Skogängen. Hon är nocturnal och \
vaknar när solen går ner, men på speciella dagar -- när någon verkligen \
behöver henne -- vaknar hon redan på eftermiddagen, gnuggande sina stora \
ögon och gäspande överraskat. Hon talar i lugna, melodiska meningar och \
har en tendens att besvara frågor med andra frågor, så att barnen (och \
djuren) får tänka själva. Hon är aldrig dömande och har all tålamod i \
världen. Hennes enda svaghet är att hon älskar kakor och kan bli distraherad \
av doften av nybakat.
""",
            visualDescription: """
En större kattuggla med fjäderdräktens varma brun- och guldtoner. Runda, \
enorma ögon i djupt bärnsten som lyser svagt i skymningen. Fjädrar som \
liknar ett sjal runt halsen. Sitter ofta på sin favoritgren med en gammal \
bok under vingen. Illustrationsstil: Detaljerad men mjuk, med varma \
kvällstoner. En karaktäristisk månstjäls-gloria runt henne.
""",
            backstory: """
Oda har levt på Skogängen längre än någon kan minnas. Det sägs att \
hon redan satt i den stora eken när skogen var ung. Hon har sett \
generationer av djur växa upp och hon bär på alla skogens berättelser \
i sitt minne. På natten när alla andra sover sjunger hon sakta för \
sig själv -- de gamla sångerna från då skogen var tyst och ung.
""",
            catchphrase: "Hmm, vad tror du själv?",
            relatedCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa"]
        ),

        // 5. RASK -- THE PLAYFUL FOX KIT
        RecurringCharacter(
            id: "rask",
            name: "Rask",
            species: "Rävunge (fox kit)",
            personality: """
Rask är en ung rävunge som älskar att springa, hoppa, och leka. Han är \
den snabbaste på Skogängen och kan aldrig sitta stilla särskilt länge. \
Han är också lite av en busunge -- inte elak, men han testar gränser \
och tycker om att göra odygda spratt. Det han behöver lära sig är att \
tänka på hur hans upptåg påverkar andra. Under all energi och allt bus \
gömmer sig dock en lojalitet och värme som är orubblig -- när någon av \
hans vänner är i trubbel är det Rask som springer fortast för att hämta \
hjälp.
""",
            visualDescription: """
En liten räv med glänsande röd-orange päls och en vit brösttfläck. Har \
små, spetsiga öron som alltid är resta och alerta. Busig blick med \
glittrande bärnstenögon. En stor, fluffig svans med en vit spets. \
Illustrationsstil: Dynamisk, ofta tecknad i språng eller mitt i ett \
spratt. Kraftiga, energiska färger. Ett litet, skevt leende.
""",
            backstory: """
Rask bor med sin mamma och sina två småsyskon i ett gryt under \
stenbröset vid skogsbrynet. Hans pappa försvann när Rask var mycket \
liten, och Rask låter som att han måste vara den som tar hand om de \
små. Han springer mycket för att han känner att han har så mycket \
energi i kroppen att den måste ut -- men ibland springer han också \
för att han inte vill känna saker som är sorgliga.
""",
            catchphrase: "Den som är snabbast får bestämma stigen!",
            relatedCharacterIDs: ["solvi", "bjork", "lille_mopp", "kvall_uglan", "droppa"]
        ),

        // 6. DROPPA -- THE SHY LITTLE FROG
        RecurringCharacter(
            id: "droppa",
            name: "Droppa",
            species: "Liten groda (little frog)",
            personality: """
Droppa är den yngsta och blygaste i gänget. Hon är en liten groda som \
helst sitter vid kanten av dammen och tittar på de andra leka, men \
som innerst inne längtar efter att vara med. När hon väl vågar delta \
visar hon sig vara överraskande modig och har en fantastisk sångröst \
som får hela skogen att lyssna. Droppa är det empatiska hjärtat i \
gruppen -- hon känner alltid när någon är ledsen eller orolig, även \
om de inte säger något. Hennes empati är hennes superkraft.
""",
            visualDescription: """
En mycket liten, ljusgrön groda med stora, uttrycksfulla ögon i \
klarblått. Har små rosa prickar på kinderna (som rodnad). Sitter \
ofta på ett näckrosblad eller tittar fram bakom en sten. Bär en \
liten krona av tusensköna i håret. Illustrationsstil: Fin, \
detaljerad akvarell. Mjuka pastelltoner. Ofta halvdold, med \
bara ögonen synliga först.
""",
            backstory: """
Droppa bor i Näsgöldammen i skogens hjärta. Hon är den minsta i \
sin stora familj av grodor, och hennes större syskon är alla \
höga och högljudda medan Droppa är tyst. Hon hittade sin sångröst \
en natt när månljuset föll över dammen och allt var så vackert \
att hon bara måste sjunga. Sedan dess sjunger hon ibland, men \
bara när hon känner sig trygg.
""",
            catchphrase: "Jag... jag kan försöka, om ni vill?",
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
// 2. Äventyrssagor (Adventure stories) -- 12 stories
// 3. Lärosågor (Teaching/learning stories) -- 10 stories
// 4. Naturssagor (Nature stories) -- 11 stories
// 5. Känslosagor (Emotion/feelings stories) -- 10 stories
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

        // G1 -- Solvis Stjärnfilt
        ChildrenStory(
            id: "g01_solvis_stjarnfilt",
            title: "Solvis stjärnfilt",
            synopsis: """
När natten faller över Skogängen kan inte lilla Solvi somna. Hon saknar \
sin mormors varma famn. Kväll-Uglan Oda berättar för henne att stjärnorna \
är den stora skogens nattfilt, sytt av månens ljus. Solvi går ut i nattluften \
och samlar mjukt månljus i sina tassar -- och när hon kryper ner i sin \
moss-säng känns det som om hela himlen vaggar henne till sömns.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Solvi (igelkott), Kväll-Uglan Oda",
            moral: "Tryggheten finns runt dig, även när du saknar någon du älskar.",
            visualDescription: """
Midnattsblå toner med silvriga stjärnor. Solvi sitter på en moss-kulle och \
tittar upp mot en enorm, gnistrande natthimmel. Månljuset är mjukt och varmt. \
Akvarellstil med mörkblå och violetta toner, guldiga detaljer på stjärnorna.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["godnatt", "stjärnor", "trygghet", "saknad", "månljus"]
        ),

        // G2 -- Björks Mjuka Moln
        ChildrenStory(
            id: "g02_bjorks_mjuka_moln",
            title: "Björks mjuka moln",
            synopsis: """
Björk är för stor för sin säng och hans långa ben sticker ut över kanten. \
Han kan inte hitta en bekväm ställning. Hans mamma Alma föreslår att de \
går ut och tittar på kvällsmolnen. Tillsammans läser de formerna i molnen \
-- en kanin, en stjärna, en stor mjuk kudde. Björk drömmer sig bort till \
ett moln-land där allt är mjukt och stilla, och när de går hem har han \
glömt bort att sängen var för liten.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Björk (älgkalv), Alma (mamma älg)",
            moral: "Fantasin kan göra även det obekväma till något fint.",
            visualDescription: """
Kvällshimmel i rosa, lila och ljusblå. Stora, fluffiga moln i fantastiska \
former. Björk och hans mamma står på en kulle och tittar uppåt. Mamma är \
stor och trygg. Mjuk, drömlikt akvarellstil med pastelltoner.
""",
            recurringCharacterIDs: ["bjork"],
            keywords: ["godnatt", "moln", "fantasi", "mamma", "trygghet"]
        ),

        // G3 -- Näsgöldammens Vaggvisa
        ChildrenStory(
            id: "g03_nasgoldammens_vaggvisa",
            title: "Näsgöldammens vaggvisa",
            synopsis: """
Det är en varm sommarkvälll och alla djuren på Skogängen har svårt att somna \
för att det fortfarande är ljust ute. Droppa sitter på sitt näckrosblad och \
börjar tyst sjunga en vaggvisa som hennes mormor lärt henne. Sången sprider \
sig sakta över vattnet, in bland träden, förbi grässtråna -- och ett efter \
ett somnar alla djur till den mjuka melodin. Till slut somnar även Droppa \
själv, vaggad av vattnets sakta rörelser.
""",
            category: .godnattssagor,
            ageRange: .allAges,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Även den minsta rösten kan ha den största kraften.",
            visualDescription: """
Sommarkvälll med midnattssol i bakgrunden. En liten groda på ett näckrosblad \
i en stilla damm. Mjuka ljusvågor sprider sig från henne. Runtom ser man \
djur som somnar: en ekorre i sin gren, en igelkott i sin mossa. Drömmande \
akvarelltoner i guld, grönt och ljusblått.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["godnatt", "sång", "vaggvisa", "sommar", "somna"]
        ),

        // G4 -- Månstjälsjakten
        ChildrenStory(
            id: "g04_manskensjakten",
            title: "Månstjälsjakten",
            synopsis: """
En kväll när Rask inte kan somna bestämmer han sig för att fånga månljuset \
som silar in genom springorna i hans gryt. Han springer genom skogen, \
hoppar över bäckar och klättrar på stenar -- men varje gång han sträcker \
ut tassarna rinner månljuset ur dem som vatten. Till slut hittar han Oda \
som förklarar att man inte behöver fånga ljuset -- man kan bara sitta \
stilla och låta det fylla en inifrån. Rask sätter sig ner, andas lugnt, \
och känner hur månljuset värmer hela kroppen. Han somnar under klar himmel.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (rävunge), Kväll-Uglan Oda",
            moral: "Man behöver inte jaga allt -- ibland räcker det att vara stilla.",
            visualDescription: """
Silvrig månljusskog med långa, mjuka skuggor. Rask i rörelse genom bild \
efter bild -- springande, hoppande, stannande. Sista bilden: Rask sitter \
stilla, baddad i månljus. Kontrastrik men mjuk palett: midnattsblå, silver, \
varmt orange (Rasks päls).
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["godnatt", "månljus", "stillhet", "lugn", "somna"]
        ),

        // G5 -- Tio Små Mossjunkar
        ChildrenStory(
            id: "g05_tio_smaa_mossjunkar",
            title: "Tio små mossjunkar",
            synopsis: """
I den djupaste, grönaste delen av skogen bor tio pyttesmå mossjunkar -- \
så små att bara den som tittar riktigt noga kan se dem. Varje kväll när \
solen går ner tänder de var sin liten lykta gjord av eldflugors ljus och \
vandrar i en lång rad genom mossan. De sjunger en räknesång: 'Tio små \
mossjunkar, nio går till ro...' och en efter en somnar de längs stigen, \
tills bara en är kvar, som viskar 'godnatt' åt vinden.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Tio mossjunkar (små skogsväsen)",
            moral: "Att somna är naturligt -- alla gör det, en efter en.",
            visualDescription: """
Miniaturvärld i närbild: enorma mosstrån som träd, daggdroppar som lyktor. \
Tio små väsen i grön-bruna färger med små spetsiga mössor. Varje sida \
visar en färre mossjunke. Detaljerad men drömlikt stil, matt guldljus.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "räkning", "skogsväsen", "mossa", "stillhet"]
        ),

        // G6 -- Var Somnar Vinden?
        ChildrenStory(
            id: "g06_var_somnar_vinden",
            title: "Var somnar vinden?",
            synopsis: """
Lille Mopp undrar var vinden går när det blir stilla på kvällen. Han \
frågar trädet -- trädet säger att vinden somnar i dess krona. Han frågar \
sjön -- sjön säger att vinden somnar på ytan. Han frågar berget -- berget \
säger att vinden somnar i dess hålor. Till slut sätter sig Lille Mopp i \
sin gran och känner hur en sista bris smeker hans kind. 'Godnatt, vinden,' \
viskar han. Vinden viskar tillbaka.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Naturen vilar också, precis som vi.",
            visualDescription: """
Kvällslandskap som rör sig genom olika miljöer: trädkronor, sjön, berget. \
Vinden visualiseras som mjuka, genomskinliga vågor i luften. Sista bilden: \
Lille Mopp i sin gren, omgiven av stilla luft. Pasteller i grönt, blått \
och ljusgult.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["godnatt", "vind", "natur", "undran", "tystnad"]
        ),

        // G7 -- Den Tysta Snön
        ChildrenStory(
            id: "g07_den_tysta_snon",
            title: "Den tysta snön",
            synopsis: """
Det är Solvis första vinter och hon har aldrig sett snö förut. När de \
första flingorna faller stannar hela skogen -- alla ljud försvinner. \
Solvi är först rädd för tystnaden, men Björk visar henne att snön är \
som en stor, vit filt som skogen drar över sig för att sova. Tillsammans \
lyssnar de till den allra tystaste tystnaden, och Solvi upptäcker att \
i tystnaden kan man höra sitt eget hjärta slå -- och det låter tryggt.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), Björk (älgkalv)",
            moral: "Tystnad behöver inte vara otäck -- den kan vara trygg och vacker.",
            visualDescription: """
Snöflingor faller sakta över en stilla skog. Vitt, ljusblå och silver \
dominerar. Solvi står liten och rund i snön, Björk stor och lugn bredvid. \
Inga skarpa kanter, allt är mjukt och dämpat. Sista bilden: båda djuren \
nära varandra i snön, omgivna av tystnad.
""",
            recurringCharacterIDs: ["solvi", "bjork"],
            keywords: ["godnatt", "vinter", "snö", "tystnad", "trygghet"]
        ),

        // G8 -- Stjärnbrevet
        ChildrenStory(
            id: "g08_stjarnbrevet",
            title: "Stjärnbrevet",
            synopsis: """
Droppa hittar ett litet lysande blad som fallit från natthimlen. Hon \
tror att det är ett brev från en stjärna. Försiktigt viker hon upp det \
och läser ett meddelande: 'Du lyser också.' Droppa förstår inte först \
-- hon är ju bara en liten groda. Men när hon tittar ner i vattnet ser \
hon att månljuset reflekteras i hennes ögon, och hon inser att alla har \
ett eget ljus inom sig, även om man ibland glömmer det.
""",
            category: .godnattssagor,
            ageRange: .preschool,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Alla har ett unikt ljus inombords, även de som känns små.",
            visualDescription: """
Mörkt vatten med månreflex. En liten groda håller ett lysande blad som \
kastar varmt ljus över hennes ansikte. Ögonen glittrar. Mörka, rika \
toner med kontrast av varmt guldljus. Sista bilden: Droppa ler -- för \
första gången riktigt brett.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["godnatt", "självkänsla", "stjärnor", "ljus", "självbild"]
        ),

        // G9 -- Nattens Djur Går Hem
        ChildrenStory(
            id: "g09_nattens_djur_gar_hem",
            title: "Nattens djur går hem",
            synopsis: """
En enkel, rytmisk berättelse som följer nattens djur när de går hem i \
gryningen. Uglan flyger till sitt träd. Rävarna springer till sitt gryt. \
Grävlingen kryper ner i sin håla. Nattfjärilen viker ihop sina vingar. \
Varje djur säger 'godnatt' på sitt eget sätt -- ett hoot, ett pip, en \
tyst suck. Och när alla är hemma börjar daggdjuren vakna, och en ny dag \
börjar. Men det är en saga för en annan gång.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Diverse nattdjur (ugla, räv, grävling, nattfjäril)",
            moral: "Alla har en plats att gå hem till när det är dags att vila.",
            visualDescription: """
Gryningsljus med röda och gyllene toner i horisonten. Sekvens av djur som \
går in i sina bon: ugla i träd, räv i gryt, grävling i håla. Varje bild \
mjukare än den förra. Sista bilden: en stilla skog i tidigt morgonljus. \
Naturalistisk akvarellstil.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "djur", "gryning", "hem", "rutin"]
        ),

        // G10 -- Mollys Magiska Snörstråd
        ChildrenStory(
            id: "g10_mollys_snorstrad",
            title: "Mollys magiska snörstråd",
            synopsis: """
Lilla Molly är en månstråle som bor i månens allra bortersta krater. \
Varje kväll spinner hon tunna, silvriga snören som hon hänger från \
himlen ner till Skogängen. De är så tunna att man bara kan se dem om \
man blundar nästan helt. När barnen och djuren lägger sig och blundar \
kan de känna hur Mollys snören vaggar dem sakta, sakta, fram och \
tillbaka tills de somnar. Och när de sover klättrar Molly ner längs \
snörena och viskar fina drömmar i deras öron.
""",
            category: .godnattssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Molly (månstråle)",
            moral: "När du blundar och slappnar av kommer drömmarna av sig själva.",
            visualDescription: """
Månen stor och rund. En liten, silverglittrande varelse spinner tunna \
trådar ner mot en sovande skog. Nedanför ser man små djur i sina bon \
med slutna ögon. Silverblått, drömligt, med fina glittrande detaljer. \
Bokens mjukaste, mest drömliga bilder.
""",
            recurringCharacterIDs: [],
            keywords: ["godnatt", "månen", "drömmar", "slappna av", "vaggande"]
        ),

        // G11 -- Sista Sidan Idag
        ChildrenStory(
            id: "g11_sista_sidan_idag",
            title: "Sista sidan idag",
            synopsis: """
Det är sent och Solvi, Björk och Lille Mopp sitter i Odas träd och ber \
om 'en saga till.' Oda ler och säger att varje dag är som en bok, och \
nu är det dags att vända sista sidan. Hon hjälper dem minnas alla fina \
saker som hänt under dagen -- solen som värmde, maten som smakade gott, \
leken med vännerna. 'Se, vilken fin bok det blev idag,' säger Oda. \
'Imorgon börjar en ny.' Alla somnar med ett leende.
""",
            category: .godnattssagor,
            ageRange: .allAges,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi, Björk, Lille Mopp, Kväll-Uglan Oda",
            moral: "Varje dag är värd att minnas och vara tacksam för.",
            visualDescription: """
Varmt kvällsljus i en stor ek. Oda sitter på en gren, de tre små djuren \
nedanför. Bilderna visar 'flashbacks' av deras dag i gyllene toner. Sista \
bilden: alla sover, Oda vakar stilla. Varma guldtoner som långsamt \
övergår till midnattsblå.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "kvall_uglan"],
            keywords: ["godnatt", "tacksamhet", "minnen", "dag", "natt"]
        ),

        // G12 -- Sovmörkt
        ChildrenStory(
            id: "g12_sovmorkt",
            title: "Sovmörkt",
            synopsis: """
Det är vinter och det blir mörkt tidigt. Droppa är rädd för mörkret. Rask, \
som aldrig är rädd för något (påstår han), erbjuder sig att sitta med henne. \
Men när det blir riktigt mörkt erkänner Rask att han också tycker att det är \
lite otäckt. Tillsammans sitter de i mörkret och upptäcker att det inte är \
tyst alls -- de hör vatten porla, ugglan sjunga, vinden andas. Mörkret är \
fullt av ljud, och ljuden är vänner. De somnar sida vid sida, inte längre \
rädda.
""",
            category: .godnattssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Rask (rävunge)",
            moral: "Det är okej att vara rädd, och mörkret är inte så tomt som man tror.",
            visualDescription: """
Progressivt mörkare bilder, men varje bild fylld med små ljusdetaljer: \
en eldfluga, månreflex, ögon. De två djuren nära varandra. I början \
spända, i slutet avslappnade. Mörka blå och gröna toner med varma prickar \
av ljus.
""",
            recurringCharacterIDs: ["droppa", "rask"],
            keywords: ["godnatt", "mörker", "rädsla", "vänskap", "mod"]
        ),


        // ====================================================================
        // MARK: ÄVENTYRSSAGOR (Adventure Stories) -- 12 stories
        // ====================================================================
        // Exciting, engaging stories with journeys, challenges, and triumphs.
        // Build suspense age-appropriately and always resolve positively.

        // A1 -- Stigen Till Norra Berget
        ChildrenStory(
            id: "a01_stigen_till_norra_berget",
            title: "Stigen till Norra Berget",
            synopsis: """
Solvi har alltid drömt om att se norrsken från toppen av Norra Berget. En \
morgon bestämmer hon sig -- idag går hon! Men stigen är lång och full av \
hinder: en bred bäck att korsa, ett mörkt skogsparti, en brant slutning. \
Vid varje hinder möts hon av en av sina vänner som hjälper henne på sitt \
sätt: Björk bär henne över bäcken, Rask visar genvägen genom skogen, \
Lille Mopp bygger en liten trappa av pinnar. På toppen ser de norrsken \
tillsammans -- och det är vackrare för att de delade det.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi, Björk, Rask, Lille Mopp",
            moral: "Stora drömmar når man lättare med hjälp av vänner.",
            visualDescription: """
Episk resa genom varierande landskap: ängmarker, mörka barrskogar, branta \
klippstigar. Varje ny miljö har distinkt färgpalett. Sista bilden: alla \
fyra på en bergstopp under dansande norrsken i grönt och lila. Detaljrika \
landskapsillustrationer.
""",
            recurringCharacterIDs: ["solvi", "bjork", "rask", "lille_mopp"],
            keywords: ["äventyr", "norrsken", "vänskap", "resa", "berg"]
        ),

        // A2 -- Skatten I Spegelvatten
        ChildrenStory(
            id: "a02_skatten_i_spegelvatten",
            title: "Skatten i Spegelvatten",
            synopsis: """
Björk hittar en gammal karta i sin mammas förråd som visar att det finns \
en 'skatt' gömd på botten av sjön Spegelvatten. Tillsammans med Solvi \
och Droppa (som ju kan dyka!) ger de sig ut på en expedition. Droppa \
dyker och hittar inte guld -- utan en vacker, glittrande sten med ett \
meddelande ristat på: 'Den största skatten är den som söker med dig.' \
De förstår att skatten var äventyret självt och vänskapen de delade.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Björk (älgkalv), Solvi (igelkott), Droppa (groda)",
            moral: "Den verkliga skatten är vänskap och delade upplevelser.",
            visualDescription: """
Undervattensvärd i turkos och grönt. Droppa dyker genom vattenväxter \
och fiskar. Ovan vattnet: Björk och Solvi i en liten flotte. Kartan är \
äldre och gulnad. Stenen som hittas glittrar i regnbågens färger. \
Detaljrik akvarell med undervattenskänsla.
""",
            recurringCharacterIDs: ["bjork", "solvi", "droppa"],
            keywords: ["äventyr", "skatt", "sjö", "dyka", "vänskap"]
        ),

        // A3 -- När Granen Föll
        ChildrenStory(
            id: "a03_nar_granen_foell",
            title: "När granen föll",
            synopsis: """
En storm fäller den stora granen där Lille Mopp bor. Hans hem är förstört. \
Alla vänner samlas för att hjälpa. Solvi hittar en ny plats, Björk bär \
tunga grenar, Rask springer och hämtar material, Droppa sjunger för att \
hålla modet uppe, och Oda ger kloka råd om byggteknik. Tillsammans bygger \
de det finaste boet Skogängen någonsin sett -- och Lille Mopp inser att \
hans hem inte var granen, utan gemenskapen med sina vänner.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Lille Mopp, Solvi, Björk, Rask, Droppa, Oda",
            moral: "När något går sönder kan man bygga något nytt, tillsammans.",
            visualDescription: """
Dramatisk stormscen i början: mörka moln, böjda träd, regn. Sedan ljusnar \
det gradvis. Byggscener med alla djur i arbete. Sista bilden: det nya boet, \
soligt, med blomsterdekorationer. Progressionen från mörkt till ljust \
speglar känslo-resan.
""",
            recurringCharacterIDs: ["lille_mopp", "solvi", "bjork", "rask", "droppa", "kvall_uglan"],
            keywords: ["äventyr", "storm", "samarbete", "bygga", "gemenskap"]
        ),

        // A4 -- Skogsstafetten
        ChildrenStory(
            id: "a04_skogsstafetten",
            title: "Skogsstafetten",
            synopsis: """
Det är dag för Skogängens årliga stafett! Alla djur deltar i lag. Solvis \
lag måste springa, simma, klättra och flyga (med hjälp av Oda). Men Rasks \
lag är snabbare vid varje kontroll. När Rasks lagkamrat snubblar och slår \
sig väljer Rask att stanna och hjälpa -- även om det betyder att han \
förlorar tävlingen. Alla jublar för Rask ändå, och Oda säger: 'Den som \
hjälper är alltid en vinnare.'
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (rävunge), Solvi (igelkott), Oda (uggla)",
            moral: "Att vara snäll är viktigare än att vinna.",
            visualDescription: """
Färglatt och energiskt. Djur i rörelse genom en hinderbana i skogen: \
simstäck genom dammen, klättring i träd, språng över äng. Rask stannar \
mitt i rörelesen för att hjälpa -- den kontrasten i bilden är central. \
Kraftiga, glada färger.
""",
            recurringCharacterIDs: ["rask", "solvi", "kvall_uglan"],
            keywords: ["äventyr", "tävling", "hjälpsam", "fairplay", "sport"]
        ),

        // A5 -- Den Hemliga Grottan
        ChildrenStory(
            id: "a05_den_hemliga_grottan",
            title: "Den hemliga grottan",
            synopsis: """
Rask hittar en gömd ingång bakom en buske vid bergets fot. Inne i grottan \
är det mörkt, men väggarna glittrar av kristaller. Solvi och Rask utforskar \
försiktigt och hittar målningar på väggarna -- urgamla bilder av djur som \
levde i skogen för länge, länge sedan. De förstår att andra djur vandrat \
dessa stigar före dem, och att skogen bär på berättelser som är äldre än \
de kan föreställa sig.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (rävunge), Solvi (igelkott)",
            moral: "Vi är en del av en lång historia, och vår skog har berättelser att berätta.",
            visualDescription: """
Mörk grotta med glittrande kristaller i grönt, blått och lila. Fackelljus \
(eldflugors sken) belyser primitiva grottmålningar av älgar, björnar, rävar. \
Mystisk, magisk stämning. Djupblå och glittrande detaljer.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["äventyr", "grotta", "historia", "upptäcka", "kristaller"]
        ),

        // A6 -- Flottfärdens Dag
        ChildrenStory(
            id: "a06_flottfardens_dag",
            title: "Flottfärdens dag",
            synopsis: """
Lille Mopp har byggt en flotte av pinnar och blad. Men den sjunker. Han \
bygger en till -- den också sjunker. Frustrerad nästan ger han upp, men \
Oda frågar: 'Har du frågat vattnet vad det vill?' Lille Mopp tittar på \
hur löven flyter och förstår att formen måste vara platt, inte hög. \
Tredje försöket lyckas! Han och Droppa seglar längs bäcken hela vägen \
till Spegelvatten. Det bästa med att misslyckas var att han lärde sig \
hur det fungerar.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kväll-Uglan Oda, Droppa (groda)",
            moral: "Att misslyckas är inte slutet -- det är en del av att lära sig.",
            visualDescription: """
Bäckmiljö med rinnande vatten. Tre olika flottar: en som sjunker komiskt, \
en som välter, en som flyter perfekt. Lille Mopp från ledsen till glad. \
Droppa sitter stolt på den sista flotten. Ljusa, varma färger. \
Vattnet glittrar.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan", "droppa"],
            keywords: ["äventyr", "bygga", "misslyckas", "lära", "flotte"]
        ),

        // A7 -- Vargens Ekon
        ChildrenStory(
            id: "a07_vargens_ekon",
            title: "Vargens ekon",
            synopsis: """
Solvi och Björk hör ett lågt ylande i skogen och blir oroliga -- är det \
en varg? De följer ljudet försiktigt och hittar... ingenting. Det är bara \
ekot av vinden genom en ihålig stock. Oda förklarar att skogen är full av \
ljud som kan låta otäcka men som har naturliga förklaringar. De går runt \
i skogen och 'avtäcker' alla mystiska ljud: trädets knärrande, bäckens \
porlande, ugglans rop. Det som var otäckt blir fascinerande.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), Björk (älgkalv), Kväll-Uglan Oda",
            moral: "Många saker som känns skrämmande har en enkel förklaring.",
            visualDescription: """
Skog med dramatiska ljus- och skuggspel. Ljudvågor visualiseras som mönster \
i luften. Ihålig stock med mystiskt utseende som visar sig vara ofarlig. \
Djuren går från långa skuggor till ljust, vänskapligt sken. Går från kyla \
till varma toner.
""",
            recurringCharacterIDs: ["solvi", "bjork", "kvall_uglan"],
            keywords: ["äventyr", "rädsla", "ljud", "natur", "utforska"]
        ),

        // A8 -- Det Flygande Fröet
        ChildrenStory(
            id: "a08_det_flygande_frot",
            title: "Det flygande fröet",
            synopsis: """
Lille Mopp drömmer om att flyga. Han bygger vingar av löv -- de håller inte. \
Han prövar en katapult -- den går åt fel håll. Till slut bygger han en stor \
drake (leksak) av tunna kvistar och mjuka mossblad. När vinden fångar den \
lyfter den -- och Lille Mopp hänger på! Han flyger över Skogängen, över \
dammen, över berget. Han ser sina vänners bon uppifrån och förstår hur \
stort och vackert deras hem är. När han landar har han sett världen på \
ett nytt sätt.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Med kreativitet och envishet kan man nå sina drömmar.",
            visualDescription: """
Dynamiska flygscener över ett fågelperspektiv av Skogängen. Lille Mopp \
på en stor, vacker drake mot blå himmel. Under honom: sjön, skogen, ängen, \
berget -- allt i miniatyr. Uppslaget med fågelperspektivet är bokens mest \
imponerande bild. Ljusa, luftiga färger.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["äventyr", "flyga", "drömmar", "kreativitet", "uppfinning"]
        ),

        // A9 -- Isvägen
        ChildrenStory(
            id: "a09_isvaegen",
            title: "Isvägen",
            synopsis: """
Det är vinter och sjön Spegelvatten har frusit. Björk har aldrig gått på \
is förut och är nervös -- han är så stor och tung, tänk om isen brister! \
Rask visar honom att man kan testa isen försiktigt, steg för steg. \
Tillsammans -- Rask lätt och snabb framst, Björk tung och försiktig efter \
-- tar de sig över sjön till den andra sidan där de hittar en undangömd \
äng med vinterjasmin som blommar mitt i snön. Skönheten var värd risken.
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Björk (älgkalv), Rask (rävunge)",
            moral: "Med försiktighet och en vän vid sin sida kan man våga nya saker.",
            visualDescription: """
Frusen sjö med spegelblank is. Björk stor och tveksam vid kanten, Rask \
liten och förväntansfull framför. Svagt violett vinterljus. På andra \
sidan: explosion av gul vinterjasmin mot vit snö. Kontrasten mellan \
kallt och varmt.
""",
            recurringCharacterIDs: ["bjork", "rask"],
            keywords: ["äventyr", "vinter", "mod", "försiktighet", "vänskap"]
        ),

        // A10 -- Regndagens Karta
        ChildrenStory(
            id: "a10_regndagens_karta",
            title: "Regndagens karta",
            synopsis: """
Det regnar och alla är uttråkade hemma i sina bon. Solvi bestämmer sig för \
att rita en karta över Skogängen -- men hennes karta visar även platser \
som inte finns än: 'Här kan vi bygga en bro,' 'Här kan vi plantera en \
trädgård.' Inspirerade ger sig alla djur ut i regnet och börjar bygga det \
som kartan visar. När regnet slutar har Skogängen fått en ny bro, en \
liten trädgård och ett utsiktstorn av pinnar. Regndagen blev deras bästa.
""",
            category: .aventyrssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), alla vänner",
            moral: "Tråkiga dagar kan bli de bästa om man använder fantasin.",
            visualDescription: """
Regnigt skogslandskap som gradvis förändras: nya strukturer dyker upp \
bland träden. Djur i regnrock-liknande löv. Kartan som Solvi ritar är \
barnligt charmig och detaljrik. Regn som glittrar. Blått, grönt och \
gyllene toner.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["äventyr", "kreativitet", "regn", "fantasi", "bygga"]
        ),

        // A11 -- Bortom Skogsbrynet
        ChildrenStory(
            id: "a11_bortom_skogsbrynet",
            title: "Bortom skogsbrynet",
            synopsis: """
Rask har alltid undrat vad som finns bortom skogsbrynet, där ängen slutar \
och något nytt börjar. En dag springer han hela vägen dit och ser -- en \
annan skog! Och i den skogen bor andra djur: en blyg rådjurskid, en \
pratsam nötkråka, en gammal grävling. De är olika, pratar lite annorlunda, \
och leker andra lekar. Rask är först osäker, men snart spelar de tillsammans. \
Han går hem med nya vänner och berättar: 'Där borta är det också fint, \
bara på ett annat sätt.'
""",
            category: .aventyrssagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Rask (rävunge), nya djurvänner",
            moral: "Världen är stor och full av olika vänner att träffa.",
            visualDescription: """
Två olika skogar med distinkt karaktär: den bekanta (varm, grön) och den \
nya (mer blå-grön med andra blommor). Nya djur med distinkt design. Rask \
mitt emellan två världar. Rikt detaljerade landskapsillustrationer. \
Ljusa, inbjudande färger.
""",
            recurringCharacterIDs: ["rask"],
            keywords: ["äventyr", "nya vänner", "utforska", "mångfald", "olikheter"]
        ),

        // A12 -- Midsommarfärdens Hemlighet
        ChildrenStory(
            id: "a12_midsommarfardens_hemlighet",
            title: "Midsommarfärdens hemlighet",
            synopsis: """
På midsommarafton berättar Oda att det någonstans i skogen finns en blomma \
som bara blommar en enda natt om året -- Midsommarljuset. Det sägs att den \
som hittar den får göra en önskan. Alla sex vännerna ger sig ut på jakt. \
De vandrar genom sommarkvällen, förbi alvar, ängar med smultron, och \
glittrande bäckar. När de till slut hittar blomman -- en lysande, vit \
blomma i en gömd glänta -- önskar de alla samma sak: att de får vara \
vänner för alltid.
""",
            category: .aventyrssagor,
            ageRange: .allAges,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi, Björk, Lille Mopp, Rask, Droppa, Kväll-Uglan Oda",
            moral: "Den finaste önskan är den man delar med sina vänner.",
            visualDescription: """
Ljus midsommarnatt med lång solnedgång i guld och rosa. Svenska sommarängar \
med smultron, prästkragar, blåklockor. Den magiska blomman lyser i mitten \
av en mörk glänta som ett vitt ljus. Alla sex djuren i cirkel runt blomman. \
Svensk sommardyll på sitt vackraste.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["äventyr", "midsommar", "önskan", "vänskap", "sommar"]
        ),


        // ====================================================================
        // MARK: LÄROSÅGOR (Teaching/Learning Stories) -- 10 stories
        // ====================================================================
        // Stories that gently teach concepts: numbers, colors, days, sharing,
        // manners, words, shapes, and basic life skills.

        // L1 -- Björks Stora Räkning
        ChildrenStory(
            id: "l01_bjorks_stora_rakning",
            title: "Björks stora räkning",
            synopsis: """
Björk ska hjälpa sin mamma räkna alla äpplena i deras trädgård. Men han \
kan bara räkna till fem! För varje nytt äpple han hittar ber han en vän \
om hjälp. Solvi lär honom sex, Rask lär honom sju, Lille Mopp lär honom \
åtta, Droppa lär honom nio, och Oda lär honom tio. När alla äpplena är \
räknade har Björk lärt sig räkna till tio -- och har tio äpplena att dela \
med sina tio favoritvänner.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Björk (älgkalv), alla vänner",
            moral: "Att lära sig går lättare när man gör det tillsammans.",
            visualDescription: """
Färgglada äpplen i rött, grönt, gult. Varje uppslag visar ett nytt nummer \
med stort, tydligt siffra-format. Djuren pekar och räknar. Pedagogiskt \
upplagd med repetition. Ljusa, glada färger. Tydlig visuell räkning.
""",
            recurringCharacterIDs: ["bjork", "solvi", "rask", "lille_mopp", "droppa", "kvall_uglan"],
            keywords: ["lärande", "siffror", "räkna", "äpplen", "matematik"]
        ),

        // L2 -- Färglådan I Skogen
        ChildrenStory(
            id: "l02_fargladan_i_skogen",
            title: "Färglådan i skogen",
            synopsis: """
Lille Mopp vill måla ett porträtt av skogen men har inga färger. Oda \
föreslår att han letar i skogen själv. Han hittar rött i smultronen, \
grönt i mossan, blått i himlen, gult i smörblommorna, brunt i barken, \
och vitt i näckrosorna. För varje färg han hittar berättas en liten \
vers. När tavlan är klar är den den vackraste tavlan någon sett -- för \
den är gjord av skogen själv.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kväll-Uglan Oda",
            moral: "Färgerna finns överallt i naturen om man tittar noga.",
            visualDescription: """
Varje sida domineras av en färg: helröd sida med smultron, helgrön sida \
med mossa, etc. Sista sidan visar alla färger tillsammans i Lille Mopps \
tavla. Mättad, rik akvarell. Pedagogisk men vacker.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan"],
            keywords: ["lärande", "färger", "natur", "konst", "måla"]
        ),

        // L3 -- Veckans Sju Dagar
        ChildrenStory(
            id: "l03_veckans_sju_dagar",
            title: "Veckans sju dagar",
            synopsis: """
Varje dag i veckan gör djuren på Skogängen något speciellt. På måndag \
är det måndag -- de tittar på månen. På tisdag planterar de TI frön. \
På onsdag önskar de sig fina saker. På torsdag dundrar de som Tor. På \
fredag firar de (Freja). På lördag vilar de. På söndag sover de länge. \
En rytmisk, rolig saga som lär ut veckodagarna på ett lekfullt sätt.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Alla Skogängens djur",
            moral: "Varje dag har sitt eget värde och sin egen aktivitet.",
            visualDescription: """
Sju tydliga uppslag, ett per dag. Varje dag har sin egen färg och \
aktivitet. Måndag: månljus, blått. Tisdag: gröna plantor. Onsdag: \
gyllene stjärnor. Torsdag: dramatisk åska. Fredag: fest med blommor. \
Lördag: hängmatta. Söndag: söta sovande djur.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["lärande", "veckodagar", "rutin", "tid", "dagar"]
        ),

        // L4 -- Tack Och Förlåt
        ChildrenStory(
            id: "l04_tack_och_forlat",
            title: "Tack och förlåt",
            synopsis: """
Rask tar Lille Mopps favorit-pinne utan att fråga. Lille Mopp blir ledsen. \
Rask förstår inte först vad han gjort fel -- det var ju bara en pinne! \
Men Oda förklarar att det inte handlar om pinnen, utan om känslan. Rask \
lär sig att säga 'förlåt, jag borde ha frågat först.' Och Lille Mopp \
lär sig att säga 'tack för att du sa förlåt.' Sedan hittar de en ännu \
finare pinne som de kan dela.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Rask (rävunge), Lille Mopp (ekorre), Kväll-Uglan Oda",
            moral: "Att säga 'förlåt' och 'tack' är små ord med stor kraft.",
            visualDescription: """
Fokus på ansiktsuttryck: Rask busig, Lille Mopp ledsen, Oda lugn och vis. \
Pinnen är illustrerad som viktig och vacker -- inte trivial. Sista bilden: \
båda djuren leende med en gemensam aktivitet. Nära, intima bildutsnitt.
""",
            recurringCharacterIDs: ["rask", "lille_mopp", "kvall_uglan"],
            keywords: ["lärande", "förlåt", "tack", "känslor", "empati"]
        ),

        // L5 -- Dela Lika
        ChildrenStory(
            id: "l05_dela_lika",
            title: "Dela lika",
            synopsis: """
Solvi hittar sex bär men har fem vänner. Om hon äter ett själv och ger \
ett till varje vän räcker det precis! Men tänk om hon vill ha två? Då \
räcker det inte. Solvi står inför ett val och bestämmer sig för att dela \
lika -- ett var. När alla äter sina bär tillsammans smakar de godare än \
om hon ätit alla ensam. 'Delad glädje är dubbel glädje,' säger Oda.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Solvi (igelkott), alla vänner",
            moral: "Att dela med sig gör att glädjen växer.",
            visualDescription: """
Stora, saftiga, färgglada bär mot grön bakgrund. Solvi med bären framför \
sig, tankbubbla med dilemmat. Sedan: alla djur i ring, var och en med sitt \
bär, alla glada. Enkel, tydlig komposition. Varma sommarfärger.
""",
            recurringCharacterIDs: ["solvi", "bjork", "lille_mopp", "rask", "droppa", "kvall_uglan"],
            keywords: ["lärande", "dela", "generositet", "matematik", "rättvisa"]
        ),

        // L6 -- Var Bor Ljuden?
        ChildrenStory(
            id: "l06_var_bor_ljuden",
            title: "Var bor ljuden?",
            synopsis: """
Droppa hör ett konstigt ljud: 'Ssssss.' Hon går för att leta efter det \
och hittar bäcken. Hon hör 'Brrrrr' -- det är vinden i träden. 'Kvaaak' \
-- det är hennes kusin i dammen. 'Knock-knock' -- det är hackspetten. \
För varje ljud hon hittar övar hon att säga det själv. I slutet kan \
Droppa göra alla ljud -- och hon förstår att hela världen pratar, man \
måste bara lyssna.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda)",
            moral: "Att lyssna är första steget till att lära sig prata.",
            visualDescription: """
Varje ljud illustreras med ljudmålande typografi: stort 'SSSSS' i blått \
vid bäcken, 'BRRR' i grönt vid träden. Droppa står liten bredvid varje \
källa. Ljudvågor visualiseras som mjuka vågor i luften. Lekfull, \
pedagogisk bildvärld.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["lärande", "ljud", "språk", "lyssna", "natur"]
        ),

        // L7 -- Stora Och Små
        ChildrenStory(
            id: "l07_stora_och_sma",
            title: "Stora och små",
            synopsis: """
Björk är störst och Droppa är minst. Men vem är medelstor? Solvi? Rask? \
Lille Mopp? Djuren ställer sig i storleksordning och upptäcker att alla \
är olika stora. Sedan vänder de på det: vem har störst hjärta? Vem har \
störst mod? Vem har störst fantasi? Därmed förstår de att storlek handlar \
om mer än hur lång man är.
""",
            category: .larosagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Alla Skogängens djur",
            moral: "Storlek handlar inte bara om hur lång man är.",
            visualDescription: """
Djuren i rad från störst till minst, sedan tvärtom. Sedan abstraktare: \
hjärtan i olika storlekar, mod-symboler, fantasibubblor. Enkel, tydlig \
grafik som även de allra minsta kan förstå. Lekfulla färger.
""",
            recurringCharacterIDs: ["bjork", "solvi", "rask", "lille_mopp", "droppa"],
            keywords: ["lärande", "storlek", "jämförelse", "självkänsla", "olikheter"]
        ),

        // L8 -- Solvi Lär Sig Vänta
        ChildrenStory(
            id: "l08_solvi_lar_sig_vanta",
            title: "Solvi lär sig vänta",
            synopsis: """
Solvi planterar ett frö och vill att det ska bli en blomma GENAST. Hon \
vattnar det, pratar med det, till och med sjunger för det -- men inget \
händer. Hon är frustrerad. Oda förklarar att växande tar tid, precis \
som att lära sig springa eller att tänderna ska komma. Varje dag går \
Solvi och tittar -- och en dag, när hon nästan gett upp, sticker en \
liten grön spira upp ur jorden. Tålamod belönas!
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), Kväll-Uglan Oda",
            moral: "Det som är värt att vänta på tar tid att växa.",
            visualDescription: """
Sekvens av jord med ett litet frö: dag 1, dag 2, dag 3... Solvi alltmer \
otålig. Sedan: en liten grön spira i närbild, magisk och vacker. \
Solvi stor och stolt. Jordiga, bruna toner som brister ut i grönt \
på sista bilden.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["lärande", "tålamod", "växa", "natur", "vänta"]
        ),

        // L9 -- Rasks Dagar och Nätter
        ChildrenStory(
            id: "l09_rasks_dagar_och_natter",
            title: "Rasks dagar och nätter",
            synopsis: """
Rask vill vara uppe hela natten som Oda. Men när han försöker vaknar han \
nästan inte och somnar stående! Oda skrattar vänligt och förklarar att \
olika djur är vakna vid olika tider: ugglor på natten, ekorrar på dagen, \
rävar i skymningen. Hon berättar om dygnet som ett stort hjul som snurrar \
-- och att alla har sin tid. När Rask går hem och lägger sig i sitt gryt \
just vid gryningen känner han att hans tid är skymningen, och det är \
precis rätt.
""",
            category: .larosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (rävunge), Kväll-Uglan Oda",
            moral: "Alla har sin egen tid och rytm, och alla är lika viktiga.",
            visualDescription: """
Ett stort dygnshjul som visar 24 timmar med olika djur aktiva vid olika \
tider. Solen och månen rör sig. Rask försöker hålla sig vaken med komiskt \
gäspande. Cirkulär komposition. Blått, guld och rött (skymning).
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["lärande", "dygn", "tid", "natt", "dag"]
        ),

        // L10 -- Årstidsrockarna
        ChildrenStory(
            id: "l10_arstidsrockerna",
            title: "Årstidsrockarna",
            synopsis: """
Våren har en grön rock, sommaren en gul, hösten en röd och vintern en vit. \
Solvi och Björk vandrar genom året och möter varje årstid som en person: \
Vårfrun med fåglar i håret, Sommarkungen med sol på bröstet, Höstbarnet \
med fickor fulla av nötter, och Vinterbestemor med en mjuk snöfilt. Varje \
årstid ger dem en gåva: ett frö, ett bär, ett löv och en istapp. \
Tillsammans blir gåvorna enårsgirland.
""",
            category: .larosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Solvi (igelkott), Björk (älgkalv), fyra årstidspersoner",
            moral: "Varje årstid är speciell och har sin skönhet.",
            visualDescription: """
Fyra distinkta färgvärldar: grönt, gult, rött, vitt. Årstidspersonerna \
är stora, magiska figurer -- tänk Elsa Beskow-inspirerade men helt \
egna. Årsgirlanderna glittrar i fyra färger på sista sidan. Rikt \
dekorerat, nära naturen.
""",
            recurringCharacterIDs: ["solvi", "bjork"],
            keywords: ["lärande", "årstider", "natur", "färger", "år"]
        ),


        // ====================================================================
        // MARK: NATURSSAGOR (Nature Stories) -- 11 stories
        // ====================================================================
        // Stories about animals, forests, seasons, weather, and the natural
        // world. Teach respect for nature and ecological awareness.

        // N1 -- Solvis Sista Dag Före Vintervilan
        ChildrenStory(
            id: "n01_solvis_sista_dag",
            title: "Solvis sista dag före vintervilan",
            synopsis: """
Hösten är här och Solvi måste snart gå i ide. Hon har en enda dag kvar \
och vill hinna med allt: säga hejdå till Björk, samla de sista bären, \
krama Oda (som inte sover på vintern), och lyssna på Droppas sista sång \
före vintern. Varje adjö är lite sorgligt men också varmt. När hon \
kryper ner i sin håla bär hon med sig alla kärleksfyllda minnen -- \
och vet att våren kommer.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), alla vänner",
            moral: "Adjö behöver inte vara för alltid -- ibland är det bara för en stund.",
            visualDescription: """
Höstlandskap i guld, rött och brunt. Löv faller. Sekvens av avskedsscener, \
var och en varm och kärleksfull. Sista bilden: Solvi ihoprullad i sin \
håla, omgiven av torkade löv, med ett litet leende. Varma, rika höstfärger.
""",
            recurringCharacterIDs: ["solvi", "bjork", "kvall_uglan", "droppa"],
            keywords: ["natur", "höst", "vintervila", "avsked", "årstider"]
        ),

        // N2 -- Älgen Och Storken
        ChildrenStory(
            id: "n02_algen_och_storken",
            title: "Älgen och storken",
            synopsis: """
Björk möter en stork som landat på Skogängen för att vila på sin långa \
resa söderut. De är så olika: Björk stannar alltid, storken flyger alltid. \
Men båda älskar sjön, himlen, och att stå tyst i vassen. De tillbringar \
en dag tillsammans och delar sina berättelser: Björk om vinterns tystnad, \
storken om Afrikas värme. När storken flyger vidare vinkar Björk hejdå \
och viskar: 'Berätta om mig där nere.'
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Björk (älgkalv), en stork",
            moral: "Man kan vara vänner även om man lever helt olika liv.",
            visualDescription: """
Stor älg och elegant stork sida vid sida i en sjökant med vass. Stor \
kontrast i storlek och form. Höstlandskap. När storken flyger iväg: \
Björk liten på marken, storken högt i luften. Naturalistiska toner, \
mjukt ljus.
""",
            recurringCharacterIDs: ["bjork"],
            keywords: ["natur", "fåglar", "migration", "vänskap", "olikheter"]
        ),

        // N3 -- Regnbågens Hemlighet
        ChildrenStory(
            id: "n03_regnbagens_hemlighet",
            title: "Regnbågens hemlighet",
            synopsis: """
Efter ett sommarregn ser Droppa en regnbåge för första gången och tror \
att det är en bro till en magisk plats. Hon vill klättra upp på den! \
Rask försöker hjälpa henne nå den, men den försvinner varje gång de \
kommer nära. Oda förklarar att regnbågen är ljus och vatten som dansar \
tillsammans -- man kan inte röra den, men man kan njuta av den. Droppa \
förstår: 'Vissa vackra saker behöver man inte fånga.'
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Rask (rävunge), Kväll-Uglan Oda",
            moral: "Man behöver inte äga det vackra -- det räcker att se det.",
            visualDescription: """
Stor, strålande regnbåge över Skogängen. Droppa och Rask springer mot \
den. Ljus bryts i daggdroppar. Sista bilden: alla tre ser på regnbågen \
tillfreds, utan att jaga den. Lysande våta färger, ljust och glittrande.
""",
            recurringCharacterIDs: ["droppa", "rask", "kvall_uglan"],
            keywords: ["natur", "regnbåge", "ljus", "undran", "njutning"]
        ),

        // N4 -- Trädet Som Visste Allt
        ChildrenStory(
            id: "n04_tradet_som_visste_allt",
            title: "Trädet som visste allt",
            synopsis: """
Mitt på Skogängen står en urgammal ek. Alla djuren vet att den är speciell, \
men ingen vet exakt varför. En dag sätter sig Solvi vid dess rötter och \
börjar lyssna. Trädet 'berättar' -- inte med ord, utan med ljud: vinden \
i löven är dess sång, fåglarna i grenarna är dess vänner, rötterna i \
jorden är dess minnen. Solvi förstår att trädet vet allt om skogen för \
att det har stått där i hundra år och lyssnat.
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), det gamla trädet",
            moral: "Naturen har sin egen visdom -- man måste bara lyssna.",
            visualDescription: """
Enorm ek som fyller hela bilden. Solvi pytteliten vid rötterna. \
Detaljerade rötter, grenar, löv. Djurliv i varje hörn: fåglar, \
insekter, svampar. Rik, detaljerad illustration i naturliga toner. \
Trädets 'berättelser' som visuella vågor.
""",
            recurringCharacterIDs: ["solvi"],
            keywords: ["natur", "träd", "visdom", "lyssna", "ekologi"]
        ),

        // N5 -- Sommarängens Småfolk
        ChildrenStory(
            id: "n05_sommarangens_smafolk",
            title: "Sommarängens småfolk",
            synopsis: """
Lille Mopp upptäcker att ängen är full av små varelser han aldrig märkt \
förut: nyckelpigor, myror, fjärilar, humlar. Han tillbringar en hel \
dag på magen i gräset och observerar deras värld. Myrorna bygger städer, \
fjärilarna dansar, humlorna sjunger. Han inser att det finns en hel \
värld under hans fötter som han aldrig sett -- och att de små djuren \
är precis lika viktiga som de stora.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre)",
            moral: "Alla levande varelser är viktiga, även de allra minsta.",
            visualDescription: """
Makro-perspektiv: grässtrånar som skyskrapor, daggdroppar som spegelklot. \
Insekter i fantastisk detalj. Lille Mopp liggande på mage med näsan i \
gräset. Lysande grönt, somrigt, detaljrikt. Förstorade proportioner \
som gör det lilla stort.
""",
            recurringCharacterIDs: ["lille_mopp"],
            keywords: ["natur", "insekter", "sommar", "observation", "småkryp"]
        ),

        // N6 -- Molnens Former
        ChildrenStory(
            id: "n06_molnens_former",
            title: "Molnens former",
            synopsis: """
Björk och Solvi ligger på en kulle och tittar på molnen. 'Det där är en \
kanin!' säger Solvi. 'Nej, det är en älg,' säger Björk. De inser att \
molnen ser olika ut beroende på vem som tittar. Droppa ser en näckros, \
Rask ser en räv, Lille Mopp ser en pensel. Oda förklarar att det heter \
fantasi -- och att fantasi är den finaste gåvan man har.
""",
            category: .naturssagor,
            ageRange: .baby,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Björk, Solvi, alla vänner",
            moral: "Alla ser världen på sitt eget sätt, och alla sätt är rätt.",
            visualDescription: """
Himmel med fantastiska moln som subtilt liknar olika djur beroende på \
vinkel. Djuren liggande i gräs på en kulle. Varje djurs perspektiv \
visas i en tankbubbla. Ljus, luftig akvarell med dominerande blått \
och vitt.
""",
            recurringCharacterIDs: ["bjork", "solvi", "droppa", "rask", "lille_mopp", "kvall_uglan"],
            keywords: ["natur", "moln", "fantasi", "perspektiv", "himmel"]
        ),

        // N7 -- Den Första Vårdagen
        ChildrenStory(
            id: "n07_den_forsta_vardagen",
            title: "Den första vårdagen",
            synopsis: """
Hela vintern har Solvi sovit. När hon vaknar är allt förändrat: snön smälter, \
bäckar rinner, fåglar sjunger, och de första blommorna tittar fram. Hon \
känner inte igen sin skog! Men snart möter hon Björk (som fått riktiga \
horn nu!), och han visar henne allt nytt. Det bästa är att dammen är \
isfri och Droppa sitter på sitt näckrosblad igen. Vänner återförenas \
och firar våren.
""",
            category: .naturssagor,
            ageRange: .allAges,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), Björk (älgkalv), Droppa (groda)",
            moral: "Förändringar kan vara skrämmande men också underbara.",
            visualDescription: """
Vårlandskap med smältande snö, krokus, bäckar, grönska. Solvi \
går osäker ut ur sin håla -- ljuset är starkt. Sista bilden: alla tre \
vänner vid dammen i fullt vårljus. Färglådan exploderar: grönt, lila, \
gult, ljusblått.
""",
            recurringCharacterIDs: ["solvi", "bjork", "droppa"],
            keywords: ["natur", "vår", "uppvaknande", "förändring", "årstider"]
        ),

        // N8 -- Blåbärsstigen
        ChildrenStory(
            id: "n08_blAbarsstigen",
            title: "Blåbärsstigen",
            synopsis: """
Det är blåbärstid och Rask föreslår en tävling: vem kan plocka flest? \
Men när Rask springer iväg och plockar snabbt trampar han ner buskar \
och stör andra djur. Solvi, som plockar långsamt och försiktigt, får \
färre bär -- men hennes buskar mår bra och kan ge bär nästa år också. \
Rask förstår att man måste ta hand om naturen så att den kan ge mer.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Rask (rävunge), Solvi (igelkott)",
            moral: "Om vi tar hand om naturen tar naturen hand om oss.",
            visualDescription: """
Svensk sommarskog med blåbärsris. Rask rusande genom buskarna, bär \
flygande. Solvi försiktigt plockande, buskarna intakta. Tvedelad bild \
som visar kontrasten. Sommargrön med blåa bäraccenter.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["natur", "blåbär", "hållbarhet", "försiktighet", "skog"]
        ),

        // N9 -- Stormen
        ChildrenStory(
            id: "n09_stormen",
            title: "Stormen",
            synopsis: """
En höststorm drar in över Skogängen. Vinden tjuter, regnet piskar, och \
träden böjer sig. Alla djur gömmer sig i sina bon och är rädda. Men \
Oda, som sett hundratals stormar, sjunger en lugn sång från sitt träd. \
Hennes röst når alla bon: 'Stormar går alltid över. Håll i varandra.' \
När stormen passerat är skogen förändrad: en del grenar har fallit, men \
även nya platser har öppnats. Förändring är naturens sätt att skapa nytt.
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Kväll-Uglan Oda, alla Skogängens djur",
            moral: "Stormar är skrämmande men går alltid över, och efteråt väntar något nytt.",
            visualDescription: """
Dramatisk stormscen: mörka moln, böjda träd, regn i diagonala streck. \
Djur i sina bon, Oda lugn i sin gren. Efteråt: solljus genom moln, \
regnbåge, nytt ljus över skogen. Kontrastrik: stormscen i mörkt, \
efteråt i guld.
""",
            recurringCharacterIDs: ["kvall_uglan", "solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["natur", "storm", "mod", "förändring", "trygghet"]
        ),

        // N10 -- Fisken Som Vände Om
        ChildrenStory(
            id: "n10_fisken_som_vande_om",
            title: "Fisken som vände om",
            synopsis: """
Droppa har en vän i dammen: en liten fisk vid namn Blick. En dag \
bestämmer Blick att han vill simma ända ut i stora sjön. Droppa är \
orolig -- sjön är stor och okänd! Men hon följer med ända till \
dammens utlopp. Blick simmar ut... och efter en stund vänder han om \
och kommer tillbaka. 'Det var spännande där ute,' säger han, 'men \
mitt hem är här.' Ibland måste man resa iväg för att förstå vad man \
redan har.
""",
            category: .naturssagor,
            ageRange: .toddler,
            length: .short,
            readingTimeMinutes: 2,
            mainCharacters: "Droppa (groda), Blick (fisk)",
            moral: "Ibland behöver man åka iväg för att förstå hur fint man har det hemma.",
            visualDescription: """
Klar, genomskinlig damm med fisk under ytan. Droppa ovanpå. Vattnet \
vidgas till en större sjö. Fisken som en liten silverprick som simmar \
ut och tillbaka. Undervattenspalett: turkos, silver, grönt. Stilla, \
fridfull.
""",
            recurringCharacterIDs: ["droppa"],
            keywords: ["natur", "vatten", "hem", "resa", "tillhörighet"]
        ),

        // N11 -- Svampskogen
        ChildrenStory(
            id: "n11_svampskogen",
            title: "Svampskogen",
            synopsis: """
På hösten tar Oda med sig alla djur på en svampvandring. Hon lär dem \
skilja de goda från de giftiga: 'Kantarellens gyllene form, karl-johans \
bruna hatt, men rör aldrig den röda med vita prickar!' Varje djur hittar \
sin favorit, och de lagar en gemensam svampsoppa över en liten eld. \
Rask vill fuska och smaka rå svamp, men Oda stoppar honom: 'Naturen \
är generös, men kräver respekt.'
""",
            category: .naturssagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Kväll-Uglan Oda, alla vänner",
            moral: "Naturen ger oss mycket, men vi måste lära oss vad som är säkert.",
            visualDescription: """
Höstskog med fantastiska svampar i alla former och färger. Detaljrika \
illustrationer av kantareller, karl-johan, flugsvamp. Djuren med små \
korgar. Kvällseld med ångande soppa. Varma höstfärger: guld, brunt, \
rött, grönt.
""",
            recurringCharacterIDs: ["kvall_uglan", "solvi", "bjork", "lille_mopp", "rask", "droppa"],
            keywords: ["natur", "svamp", "höst", "säkerhet", "kunskap"]
        ),


        // ====================================================================
        // MARK: KÄNSLOSAGOR (Emotion/Feeling Stories) -- 10 stories
        // ====================================================================
        // Stories that help children identify, process, and express emotions.
        // Each focuses on a specific feeling with healthy coping strategies.

        // K1 -- När Björk Blev Arg
        ChildrenStory(
            id: "k01_nar_bjork_blev_arg",
            title: "När Björk blev arg",
            synopsis: """
Björk är nästan aldrig arg. Men en dag trampar Rask på hans favoritblomma \
av misstag, och Björk känner en het, röd känsla stiga i bröstet. Han \
stampar, han snörvlar, han vill skrika. Oda kommer fram och säger: 'Det \
är okej att vara arg. Ilskan är som en storm inuti -- den går över.' \
Hon visar honom att andas djupt, stampa i marken, och sedan prata om \
vad han känner. När ilskan gått berättar Björk för Rask att blomman \
var viktig, och Rask hjälper honom plantera en ny.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Björk (älgkalv), Rask (rävunge), Kväll-Uglan Oda",
            moral: "Ilska är en naturlig känsla -- det viktiga är vad man gör med den.",
            visualDescription: """
Björks ilska visualiseras som röda vågor runt hans kropp. Ansiktsuttrycken \
går från mild via arg via ledsen till lugn. Rask ser liten och ångerfullt \
ut. Sista bilden: de planterar tillsammans. Kontrast mellan röda ilska-bilder \
och lugna gröna slut-bilder.
""",
            recurringCharacterIDs: ["bjork", "rask", "kvall_uglan"],
            keywords: ["känslor", "ilska", "hantering", "andning", "förlåtelse"]
        ),

        // K2 -- Droppas Hemliga Tårar
        ChildrenStory(
            id: "k02_droppas_hemliga_tarar",
            title: "Droppas hemliga tårar",
            synopsis: """
Droppa gråter ibland, men ingen vet om det för att hennes tårar faller \
rakt ner i dammen och försvinner. En dag ser Solvi att vattnet runt Droppa \
krusas konstigt och frågar vad som händer. Droppa berättar att hon ibland \
känner sig ledsen utan att veta varför. Solvi säger: 'Det är okej att gråta. \
Mina taggar gör ont ibland också -- inuti.' De sitter tysta tillsammans \
vid dammen, och Droppa märker att bara det att någon VET att hon är ledsen \
gör att det känns bättre.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Droppa (groda), Solvi (igelkott)",
            moral: "Man behöver inte vara ensam med sin ledsamhet.",
            visualDescription: """
Tårar som faller i vatten, krusningar som sprider sig. Droppas uttryck: \
först döljande, sedan sårbart, sedan lättat. Solvi nära, inte inkräktande \
men närvarande. Blå och gröna toner, mjukt vatten-ljus. Stilla, \
intima bilder.
""",
            recurringCharacterIDs: ["droppa", "solvi"],
            keywords: ["känslor", "ledsamhet", "gråta", "vänskap", "tröst"]
        ),

        // K3 -- Rask Vill Inte Vara Ensam
        ChildrenStory(
            id: "k03_rask_vill_inte_vara_ensam",
            title: "Rask vill inte vara ensam",
            synopsis: """
Rask märker att hans vänner ibland vill vara ifred -- Solvi sover, Björk \
tittar på stjärnor, Lille Mopp målar. Rask känner sig avvisad och tror \
att ingen tycker om honom. Han springer runt och stör alla för att få \
uppmärksamhet. Till slut sätter sig Oda ner och förklarar: 'När dina \
vänner behöver tid ensamma betyder det inte att de inte tycker om dig. \
Alla behöver lugn ibland.' Rask lär sig att vara ensam en stund -- och \
upptäcker att han också kan gilla det.
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Rask (rävunge), Kväll-Uglan Oda",
            moral: "Att vara ensam ibland är inte samma sak som att vara ensam för alltid.",
            visualDescription: """
Rask i rörelse förbi bon där vänner är upptagna. Varje vän i sin bubbla \
av lugn. Rask störig och ensam. Sedan: Rask ensam men lugn, med en fin \
vy. Kontrast: hektisk början, stilla slut. Orangea och blåa toner.
""",
            recurringCharacterIDs: ["rask", "kvall_uglan"],
            keywords: ["känslor", "ensamhet", "uppmärksamhet", "självständighet", "gränser"]
        ),

        // K4 -- Lille Mopps Oro
        ChildrenStory(
            id: "k04_lille_mopps_oro",
            title: "Lille Mopps oro",
            synopsis: """
Lille Mopp kan inte somna för att han oroar sig för imorgon. Tänk om \
det regnar? Tänk om han inte hittar nötter? Tänk om hans vänner inte \
vill leka? Oron föreställs som en liten mörk boll i hans mage som växer. \
Oda lär honom att ta ut oron ur magen och titta på den: 'Vad är det \
värsta som kan hända?' Ofta är svaret: 'Ingenting farligt.' Och om det \
händer? 'Då löser vi det.' Bollen krymper. Lille Mopp andas ut och \
somnar.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp (ekorre), Kväll-Uglan Oda",
            moral: "Oron är ofta större i huvudet än i verkligheten.",
            visualDescription: """
Lille Mopp i sin gren, vaken, med en liten svart boll i magen som syns \
genom pälsen. Bollen visualiseras med oroliga mönster. Oda lugn. \
Bollen krymper steg för steg. Sista bilden: Lille Mopp sover, bollen \
borta. Mörka toner som ljusnar.
""",
            recurringCharacterIDs: ["lille_mopp", "kvall_uglan"],
            keywords: ["känslor", "oro", "ångest", "sömn", "hantering"]
        ),

        // K5 -- Den Nya Vännen
        ChildrenStory(
            id: "k05_den_nya_van",
            title: "Den nya vännen",
            synopsis: """
En ny djurfamilj flyttar till Skogängen: en liten bäver vid namn Tindra. \
Hon pratar annorlunda, bygger annorlunda, och äter annan mat. Först är \
Rask tveksam -- varför gör hon saker så konstigt? Men när Tindra bygger \
den finaste dammen någon någonsin sett, och lär Solvi simma på ett nytt \
sätt, och gör de roligaste lekarna, förstår alla att 'annorlunda' inte \
betyder 'konstig' -- det betyder 'spännande.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Tindra (bäver), Rask (rävunge), Solvi (igelkott)",
            moral: "Olikheter är inte något att vara rädd för -- de gör livet rikare.",
            visualDescription: """
Tindra: brun bäver med glittrande ögon och en platt svans. Ny färg- och \
formvärld när hon bygger. Först: djuren på avstånd. Sedan: alla nära, \
lekande, lärande. Tindras bäverdamm som konstverk. Varma, inkluderande \
bilder.
""",
            recurringCharacterIDs: ["rask", "solvi"],
            keywords: ["känslor", "inkludering", "mångfald", "fördomar", "vänskap"]
        ),

        // K6 -- Solvi Håller Sig Modig
        ChildrenStory(
            id: "k06_solvi_haller_sig_modig",
            title: "Solvi håller sig modig",
            synopsis: """
Solvi måste gå till andra sidan av skogen för att hämta medicin-ört till \
sin mormor. Vägen är lång och hon är rädd. Men för varje steg hon tar \
säger hon till sig själv: 'Jag är modig, jag är modig.' När hon hör ett \
ljud stannar hon, andas, och går vidare. När hon når fram känner hon sig \
starkare än någonsin. Oda säger: 'Mod är inte att inte vara rädd. Mod \
är att vara rädd och göra det ändå.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), Kväll-Uglan Oda",
            moral: "Mod handlar inte om att aldrig vara rädd, utan om att våga ändå.",
            visualDescription: """
Lång stig genom varierad skog: ljusa partier, mörka partier. Solvi liten \
men bestämd. Hennes röda halsduk som en flagga. Varje 'skrämmande' element \
visar sig vara ofarligt i nästa bild. Resan från ljust till mörkt till \
ljust igen.
""",
            recurringCharacterIDs: ["solvi", "kvall_uglan"],
            keywords: ["känslor", "mod", "rädsla", "styrka", "självtillit"]
        ),

        // K7 -- Avundsjukeavunden
        ChildrenStory(
            id: "k07_avundsjukeavunden",
            title: "Avundsjukeavunden",
            synopsis: """
Lille Mopp är avundsjuk på Rask för att Rask är snabbare. Rask är avundsjuk \
på Björk för att Björk är starkare. Björk är avundsjuk på Lille Mopp för \
att Lille Mopp är kreativare. De går runt och är missnöjda -- tills Oda \
ställer dem i en ring och ber var och en berätta vad de beundrar hos den \
andra. Plötsligt förstår de: alla vill vara någon annan, men alla är \
beundrade för det de redan är.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Lille Mopp, Rask, Björk, Kväll-Uglan Oda",
            moral: "Alla har unika gåvor -- att vara sig själv är det bästa man kan vara.",
            visualDescription: """
Djuren med 'gröna' avundsjuka-moln över huvudena. När de pratar skingras \
molnen och ersätts av gyllene stjärnor. Ring-formation runt Oda. \
Kontrast: gröna, mörka avundstoner vs. gyllene, varma uppskattnings-toner.
""",
            recurringCharacterIDs: ["lille_mopp", "rask", "bjork", "kvall_uglan"],
            keywords: ["känslor", "avundsjuka", "självkänsla", "uppskattning", "identitet"]
        ),

        // K8 -- Den Tunga Ryggsäcken
        ChildrenStory(
            id: "k08_den_tunga_ryggsacken",
            title: "Den tunga ryggsäcken",
            synopsis: """
Björk bär på en osynlig ryggsäck som känns tyngre för varje dag. I den \
ligger saker han inte sagt: att han saknar sin pappa, att han tycker det \
är jobbigt att vara ny, att han ibland känner sig dum för att han är så \
tyst. När ryggsäcken blir för tung att bära sätter han sig ner och gråter. \
Solvi sätter sig bredvid och säger: 'Berätta.' För varje sak han säger \
högt blir ryggsäcken lättare, tills han till slut kan resa sig igen.
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .long,
            readingTimeMinutes: 10,
            mainCharacters: "Björk (älgkalv), Solvi (igelkott)",
            moral: "Att bära på känslor i tysthet gör dem tyngre -- att berätta gör dem lättare.",
            visualDescription: """
En osynlig ryggsäck visualiserad som en halvgenomskinlig börda på Björks \
rygg, fylld med mörka moln. För varje 'berättelse' lyfter ett moln bort \
och blir till en fågel som flyger iväg. Sista bilden: Björk står rak, \
himlen full av fåglar, ryggsäcken borta. Djupa, känsliga bilder.
""",
            recurringCharacterIDs: ["bjork", "solvi"],
            keywords: ["känslor", "saknad", "prata", "tyngd", "befrielse"]
        ),

        // K9 -- Nisse Missar Mamma
        ChildrenStory(
            id: "k09_nisse_missar_mamma",
            title: "Nisse missar mamma",
            synopsis: """
Nisse är en liten mus som börjar på dagis (Skogängens Första Förskola) \
för första gången. Hans mamma lämnar honom och han känner en stor klump \
i halsen. Allt är nytt och alla är främmande. Men när han sakta börjar \
utforska hittar han en rolig låda med pinnar, en vänlig lärare (en gammal \
hare), och en annan mus som också är ny. När mamma hämtar honom på \
eftermiddagen skiner Nisse: 'Mamma, imorgon vill jag komma tillbaka!'
""",
            category: .kanslosagor,
            ageRange: .toddler,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Nisse (mus), mammamusen, lärarHaren",
            moral: "Det som känns läskigt först kan bli något man älskar.",
            visualDescription: """
Liten mus i en stor, ny miljö. Förskolan är en varm, mysig plats i en \
urgammal stubbe. MammaMusen vinkar i dörren. Nisse först liten och \
osäker, sedan större och modigare. Varma, inbjudande färger. Avslutande \
stor kram-scen.
""",
            recurringCharacterIDs: [],
            keywords: ["känslor", "separation", "dagis", "ny", "mod"]
        ),

        // K10 -- Alla Kan Inte Allt
        ChildrenStory(
            id: "k10_alla_kan_inte_allt",
            title: "Alla kan inte allt",
            synopsis: """
Det är talangshow på Skogängen! Rask kan springa snabbast. Droppa kan \
sjunga vackrast. Lille Mopp kan bygga finast. Men Solvi kan inte hitta \
sin talang. Hon kan inte springa fort, sjunga bra, eller bygga fint. \
Hon är ledsen -- tills hon märker att det är HON som tröstar alla som \
förlorar, HON som hejar på alla, HON som får alla att känna sig sedda. \
Oda säger: 'Din talang är att se andra, Solvi. Det är den viktigaste \
talangen av alla.'
""",
            category: .kanslosagor,
            ageRange: .preschool,
            length: .medium,
            readingTimeMinutes: 5,
            mainCharacters: "Solvi (igelkott), alla vänner, Kväll-Uglan Oda",
            moral: "Att vara snäll och se andra är en lika viktig talang som alla andra.",
            visualDescription: """
Skogsscen med en improviserad scen. Djuren uppträder: Rask springer, \
Droppa sjunger, Lille Mopp bygger. Solvi i publiken, hejar, tröstar, \
ler. Sista bilden: alla lyfter Solvi på sina axlar. Festliga, varma, \
glada färger.
""",
            recurringCharacterIDs: ["solvi", "rask", "droppa", "lille_mopp", "kvall_uglan"],
            keywords: ["känslor", "talang", "självkänsla", "empati", "uppskattning"]
        )
    ]
}
