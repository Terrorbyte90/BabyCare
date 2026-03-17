import SwiftUI

// MARK: - Pregnancy Week Content

struct PregnancyWeekContent: Identifiable {
    let id: Int
    let week: Int
    let trimester: Int
    let fetalSizeComparison: String
    let fetalWeightGrams: String
    let fetalLengthCM: String
    let sfSymbol: String
    let motherChanges: [String]
    let fetalDevelopment: [String]
    let tips: [String]
    let commonSymptoms: [String]
    let prenatalVisit: String?
    let forumSection: PregnancyForumSection
}

struct PregnancyForumSection {
    let intro: String
    let consensus: String
    let quotes: [String]
    let source: String
}

// MARK: - Compatibility Properties (used by HomeView, PregnancyDashboard)

extension PregnancyWeekContent {
    var sizeEmoji: String { sfSymbol }
    var sizeComparison: String { fetalSizeComparison }
    var highlight: String { fetalDevelopment.first ?? "" }
    var tip: String { tips.first ?? "" }

    static var all: [PregnancyWeekContent] { allWeeks }

    static func forWeek(_ week: Int) -> PregnancyWeekContent {
        let clamped = min(max(week, 4), 42)
        return allWeeks.first { $0.week == clamped } ?? allWeeks[0]
    }
}

// MARK: - All Weeks Data

extension PregnancyWeekContent {
    static let allWeeks: [PregnancyWeekContent] = [

        // MARK: - Vecka 4
        PregnancyWeekContent(
            id: 4,
            week: 4,
            trimester: 1,
            fetalSizeComparison: "Ett vallmofrö",
            fetalWeightGrams: "< 1 g",
            fetalLengthCM: "0,1 cm",
            sfSymbol: "leaf.fill",
            motherChanges: [
                "Ägget har precis implanterat i livmoderväggen och din kropp börjar producera hormonet hCG.",
                "Du kan känna en lätt dragning i underlivet, liknande menssmärtor, när embryot fäster.",
                "Brösten kan börja kännas ömma och lite svullna redan nu på grund av hormonförändringarna.",
                "Vissa upplever en liten implantationsblödning – en svag rosa eller brun fläck."
            ],
            fetalDevelopment: [
                "Embryot är nu en liten cellklump som kallas blastocyst och har precis fäst i livmoderväggen.",
                "Moderkakan (placenta) börjar bildas för att kunna försörja embryot med näring och syre.",
                "Fosterhinnan och fostervattnet börjar utvecklas för att skydda det lilla embryot.",
                "Cellerna har börjat dela upp sig i olika lager som senare ska bilda alla organ och vävnader."
            ],
            tips: [
                "Börja ta folsyra (400 mikrogram dagligen) om du inte redan gör det – det minskar risken för neuralrörsdefekter.",
                "Undvik alkohol, rökning och passiv rökning helt under hela graviditeten.",
                "Boka tid hos barnmorska för ett inskrivningsbesök – det brukar ske runt vecka 8-10."
            ],
            commonSymptoms: [
                "Utebliven mens – ofta det första tecknet på graviditet.",
                "Trötthet och sömnighet, kroppen arbetar hårt med de tidiga förändringarna.",
                "Svullna och ömma bröst."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Många nyblivna gravida delar sin spänning och oro i vecka 4.",
                consensus: "De flesta är nervösa inför att testa och diskuterar hur tidigt ett graviditetstest kan visa positivt.",
                quotes: [
                    "\"Fick en svag linje på testet idag! Är det verkligen positivt? Vågar knappt tro det!\"",
                    "\"Har haft lätta mensliknande kramper i några dagar men ingen mens. Testade idag och det var positivt!\"",
                    "\"Någon annan som testat jättetidigt? Strecket var supersvagt men det var där!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 5
        PregnancyWeekContent(
            id: 5,
            week: 5,
            trimester: 1,
            fetalSizeComparison: "Ett sesamfrö",
            fetalWeightGrams: "< 1 g",
            fetalLengthCM: "0,2 cm",
            sfSymbol: "heart.fill",
            motherChanges: [
                "Hormonerna ökar kraftigt och du kan börja märka illamående, särskilt på morgonen.",
                "Livmodern börjar växa och du kan känna tyngd i underlivet.",
                "Blodvolymen börjar öka för att stödja graviditeten, vilket kan göra dig yr.",
                "Luktsinnet kan bli extremt känsligt – dofter du normalt gillar kan plötsligt kännas obehagliga."
            ],
            fetalDevelopment: [
                "Hjärtat börjar bildas och kommer snart att börja slå – det är ett av de första organen som utvecklas.",
                "Neuralröret, som ska bli hjärnan och ryggmärgen, börjar formas.",
                "De tre cellagren (ektoderm, mesoderm, endoderm) differentieras och ska bilda alla kroppens vävnader.",
                "Små knoppar som ska bli armar och ben börjar synas."
            ],
            tips: [
                "Ät små måltider ofta istället för stora – det kan hjälpa mot illamåendet.",
                "Drick mycket vatten och ha alltid kex eller knäckebröd nära sängen för morgnarna.",
                "Vila när du kan – tröttheten i första trimestern är helt normal och viktig att lyssna på."
            ],
            commonSymptoms: [
                "Illamående som kan komma när som helst på dygnet, inte bara på morgonen.",
                "Extrem trötthet – du kan behöva sova mycket mer än vanligt.",
                "Humörsvängningar orsakade av de snabbt ökande hormonnivåerna."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 5 handlar det mycket om illamående och tidiga symtom.",
                consensus: "Forumet fylls av frågor om vad som är normalt och tips mot illamående.",
                quotes: [
                    "\"Illamåendet slog till som en vägg idag. Kan knappt äta något utan att det vänder sig.\"",
                    "\"Är det normalt att vara SÅ trött? Somnar vid åttatiden varje kväll.\"",
                    "\"Har någon tips mot illamåendet? Har testat ingefära men det hjälper bara lite.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 6
        PregnancyWeekContent(
            id: 6,
            week: 6,
            trimester: 1,
            fetalSizeComparison: "En linsfrukt",
            fetalWeightGrams: "< 1 g",
            fetalLengthCM: "0,4 cm",
            sfSymbol: "waveform.path.ecg",
            motherChanges: [
                "Illamåendet kan bli mer uttalat nu och pågå hela dagen hos vissa.",
                "Brösten fortsätter växa och bröstvårtorna kan bli mörkare.",
                "Du kan behöva kissa oftare eftersom livmodern trycker mot urinblåsan.",
                "Många upplever förstoppning på grund av det ökade progesteronhormonet."
            ],
            fetalDevelopment: [
                "Hjärtat börjar slå med en regelbunden rytm, cirka 110 slag per minut!",
                "Ansiktet börjar ta form med gropar där ögonen ska sitta och öppningar för näsa och mun.",
                "De inre organen som lever, njurar och lungor börjar utvecklas.",
                "Embryot har en liten svans som kommer att försvinna under de kommande veckorna."
            ],
            tips: [
                "Undvik starka dofter och maträtter som triggar illamåendet.",
                "Börja dokumentera din graviditet – det blir en fin minnesbok att se tillbaka på.",
                "Tala med din partner om känslor och förväntningar kring graviditeten."
            ],
            commonSymptoms: [
                "Illamående och eventuellt kräkningar – det kallas hyperemesis om det blir extremt.",
                "Ökad salivproduktion som kan kännas obehaglig.",
                "Kramper och dragningar i underlivet när livmodern växer."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 6 präglas ofta av illamående och längtan efter det första ultraljudet.",
                consensus: "Många diskuterar hur de ska orka jobba med alla symtom och om de borde berätta för arbetsgivaren.",
                quotes: [
                    "\"Spydde tre gånger på jobbet idag. Hur ska jag hålla det hemligt i flera veckor till?\"",
                    "\"Längtar så efter första ultraljudet. Känns overkligt att det faktiskt finns en liten bebis därinne.\"",
                    "\"Brösten gör så ont att jag inte ens kan sova på magen längre.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 7
        PregnancyWeekContent(
            id: 7,
            week: 7,
            trimester: 1,
            fetalSizeComparison: "Ett blåbär",
            fetalWeightGrams: "< 1 g",
            fetalLengthCM: "1,0 cm",
            sfSymbol: "figure.stand",
            motherChanges: [
                "Livmodern har nu fördubblats i storlek, även om det inte syns utanpå ännu.",
                "Du kan uppleva mer svettningar och bli varmare än vanligt.",
                "Flytningarna kan öka – det är normalt så länge de är vita eller klara och utan lukt.",
                "Emotionellt kan du svänga mellan glädje och oro, vilket är helt normalt."
            ],
            fetalDevelopment: [
                "Embryot utvecklar sina första riktiga ansiktsdrag – läppar och en liten näsa syns.",
                "Hjärnan växer snabbt och de två hjärnhalvorna börjar bildas.",
                "Armarna och benen förlängs och man kan se anlag till armbågar.",
                "Levern börjar producera röda blodkroppar."
            ],
            tips: [
                "Var noga med handhygienen – immunförsvaret är nedsatt under graviditeten.",
                "Undvik opastöriserade ostar, rått kött och viss fisk med höga kvicksilverhalter.",
                "Försök att röra på dig regelbundet – promenader är utmärkt under hela graviditeten."
            ],
            commonSymptoms: [
                "Fortsatt illamående och matäckel – du kan plötsligt avsky mat du älskade.",
                "Huvudvärk orsakad av hormonförändringar och ökad blodvolym.",
                "Förstoppning och gaser – progesteronhormonet saktar ner matsmältningen."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 7 delar många sina matäckel och konstiga smaker.",
                consensus: "Många är förvånade över hur starka matäckel och cravings kan vara redan så tidigt.",
                quotes: [
                    "\"Kan inte ens tänka på kyckling utan att må illa. Levde typ på kyckling innan!\"",
                    "\"Vill bara äta salt potatis och surkål. Min man tittar konstigt på mig.\"",
                    "\"Någon annan som har ont i huvudet hela tiden? Vågar inte ta tabletter.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 8
        PregnancyWeekContent(
            id: 8,
            week: 8,
            trimester: 1,
            fetalSizeComparison: "Ett hallon",
            fetalWeightGrams: "1 g",
            fetalLengthCM: "1,6 cm",
            sfSymbol: "stethoscope.circle.fill",
            motherChanges: [
                "Livmodern är nu ungefär lika stor som en apelsin och trycker alltmer på urinblåsan.",
                "Blodvolymen har ökat med cirka 50 % redan, vilket kan ge yrsel vid snabba rörelser.",
                "Midjan kan börja kännas lite tjockare, även om magen inte syns så mycket ännu.",
                "Du kan uppleva levande och ibland konstiga drömmar på grund av hormonerna."
            ],
            fetalDevelopment: [
                "Embryot börjar nu officiellt kallas foster. Alla viktiga organ är på plats i grundform.",
                "Fingrar och tår börjar bildas, men de sitter ännu ihop med en hinna.",
                "Öronen och ögonlocken börjar ta form och syns som små upphöjningar.",
                "Fostret rör sig redan – små ryckningar – men du kan inte känna det ännu."
            ],
            tips: [
                "Det är dags att boka ditt inskrivningsbesök hos barnmorskan om du inte redan gjort det.",
                "Börja fundera på vilken förlossningsklinik du vill vara kopplad till.",
                "Läs på om dina rättigheter kring föräldraledighet och graviditetspenning."
            ],
            commonSymptoms: [
                "Frekvent urinering – särskilt på natten.",
                "Illamåendet kan vara som värst just nu – håll ut, det brukar lätta runt vecka 12.",
                "Humörsvängningar och gråtmildhet."
            ],
            prenatalVisit: "Inskrivningsbesök hos barnmorska (vecka 8-10): Ni går igenom din hälsohistorik, livsstil, ärftlighet och tar blodprover. Du får information om graviditeten och vad som väntar framöver.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 8 diskuteras inskrivningsbesöket och hur det gick.",
                consensus: "Många delar sina upplevelser från första barnmorskebesöket och tipsar varandra om vilka frågor man bör ställa.",
                quotes: [
                    "\"Hade mitt inskrivningsbesök idag. Barnmorskan var så snäll och lugn – kände mig mycket tryggare efteråt.\"",
                    "\"De tog en massa blodprover. Avsvimmade nästan men allt gick bra!\"",
                    "\"Någon som vet om man får höra hjärtljuden redan vid inskrivningen?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 9
        PregnancyWeekContent(
            id: 9,
            week: 9,
            trimester: 1,
            fetalSizeComparison: "En oliv",
            fetalWeightGrams: "2 g",
            fetalLengthCM: "2,3 cm",
            sfSymbol: "person.fill",
            motherChanges: [
                "Midjan börjar tjockna och byxorna kan kännas lite tajta – det är livmodern som växer.",
                "Huden kan förändras: vissa får finnar medan andra får en vacker glöd.",
                "Hårväxten kan öka på grund av hormoner – håret kan kännas tjockare och glansigare.",
                "Blödande tandkött kan förekomma – graviditetshormoner påverkar tandköttet."
            ],
            fetalDevelopment: [
                "Svansen har nu försvunnit helt och fostret ser allt mer mänskligt ut.",
                "Musklerna börjar utvecklas och fostret kan göra små rörelser.",
                "Hjärtat har fyra kamrar och slår med cirka 170 slag per minut.",
                "Könsorganen börjar bildas internt, men det syns inte på ultraljud ännu."
            ],
            tips: [
                "Gå till tandläkaren för en kontroll – gratis tandvård ingår under graviditeten i Sverige.",
                "Börja använda graviditetsbälte om du har besvär med bäckenet.",
                "Ät kalciumrika livsmedel som mejeriprodukter, broccoli och mandlar."
            ],
            commonSymptoms: [
                "Illamående kan fortfarande vara intensivt – pröva akupressurmband eller B6-vitamin.",
                "Överdriven salivproduktion (ptyalism) kan förekomma.",
                "Trötthet som gör att du vill sova hela tiden."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 9 börjar många fundera på KUB-test och ultraljud.",
                consensus: "Diskussionen kretsar ofta kring att välja eller inte välja fosterdiagnostik och vad det innebär.",
                quotes: [
                    "\"Funderar på om vi ska ta KUB-test. Någon som har erfarenhet? Var det värt oron?\"",
                    "\"Började blöda lite tandkött när jag borstade tänderna. Blev livrädd men barnmorskan sa att det är vanligt!\"",
                    "\"Är så trött att jag somnar i soffan varje kväll klockan sju. Min man skrattar åt mig.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 10
        PregnancyWeekContent(
            id: 10,
            week: 10,
            trimester: 1,
            fetalSizeComparison: "En jordgubbe",
            fetalWeightGrams: "4 g",
            fetalLengthCM: "3,1 cm",
            sfSymbol: "hand.raised.fingers.spread.fill",
            motherChanges: [
                "Blodvolymen fortsätter öka och du kan märka att venerna syns mer genom huden.",
                "Magen kan se lite uppblåst ut, särskilt på kvällen efter måltider.",
                "Du kan få näsblod lättare på grund av ökad blodtillförsel till slemhinnorna.",
                "Vikten kan ha börjat öka med något kilo, men alla är olika."
            ],
            fetalDevelopment: [
                "Alla vitala organ är nu på plats och den mest kritiska utvecklingsfasen är snart avslutad.",
                "Fingrarna och tårna har separerat och har nu små nagelbäddar.",
                "Tänderna börjar bildas under tandköttet – mjölktänderna tar form redan nu.",
                "Fostret kan nu böja armar och ben och har börjat svälja fostervatten."
            ],
            tips: [
                "Om du erbjuds KUB-test görs det vanligtvis vecka 11-14 – prata med din barnmorska.",
                "Börja planera för att berätta om graviditeten för familj och vänner om du vill.",
                "Investera i bekväma underkläder och en bra BH utan bygel."
            ],
            commonSymptoms: [
                "Uppblåsthet och gaser – en av de mindre glamorösa bieffekterna.",
                "Svullna bröst som kan ha vuxit en hel storlek redan.",
                "Tilltagande hunger – kroppen behöver extra energi nu."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 10 börjar många planera hur de ska berätta om graviditeten.",
                consensus: "Forumet fylls av kreativa avslöjningsidéer och diskussioner om när det är 'säkert' att berätta.",
                quotes: [
                    "\"Vi avslöjade för våra föräldrar i helgen. Mamma grät av glädje!\"",
                    "\"Har så svårt att hålla hemligheten på jobbet. Min kollega har börjat misstänka saker.\"",
                    "\"Ska vi vänta till efter KUB-testet innan vi berättar? Vad tycker ni?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 11
        PregnancyWeekContent(
            id: 11,
            week: 11,
            trimester: 1,
            fetalSizeComparison: "Ett fikon",
            fetalWeightGrams: "7 g",
            fetalLengthCM: "4,1 cm",
            sfSymbol: "figure.arms.open",
            motherChanges: [
                "Livmodern har nu vuxit ur bäckenet och du kan börja känna den ovanför blygdbenet.",
                "Illamåendet kan börja lätta lite – ljuset i tunneln närmar sig!",
                "Du kan uppleva halsbränna och sura uppstötningar, särskilt efter att ha ätit.",
                "Håret kan se fantastiskt ut tack vare hormonerna – njut av det!"
            ],
            fetalDevelopment: [
                "Fostret kallas nu officiellt foster (fetus) istället för embryo.",
                "Huvudet är fortfarande oproportionerligt stort – ungefär hälften av kroppslängden.",
                "Öronens yttre form börjar synas och ögonen rör sig mot sin rätta position.",
                "Benmärgen börjar producera vita blodkroppar – immunförsvaret tar form."
            ],
            tips: [
                "Börja fundera på olika fosterdiagnostiska alternativ – KUB, NIPT eller amniocenters.",
                "Ät mindre portioner men oftare för att hantera halsbränna.",
                "Försök att promenera minst 30 minuter om dagen – det ger energi och förbättrar humöret."
            ],
            commonSymptoms: [
                "Halsbränna och sura uppstötningar.",
                "Lite bättre med illamåendet hos vissa – men inte alla.",
                "Svimningskänsla vid snabba positionsbyten."
            ],
            prenatalVisit: "KUB-test kan erbjudas (vecka 11-14): Ett kombinerat ultraljud och blodprov som undersöker risken för kromosomavvikelser. Helt frivilligt.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 11 handlar det ofta om KUB-test och fosterdiagnostik.",
                consensus: "Diskussionerna pendlar mellan att vilja veta allt och rädslan för vad testen kan visa.",
                quotes: [
                    "\"Gjorde KUB idag och fick se bebisen röra sig! Helt magiskt – grät som en skvätt.\"",
                    "\"Fick låg risk på KUB – så lättad! Nu kan jag slappna av lite.\"",
                    "\"Vi valde att inte göra KUB. Kände att det inte skulle ändra något för oss.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 12
        PregnancyWeekContent(
            id: 12,
            week: 12,
            trimester: 1,
            fetalSizeComparison: "En lime",
            fetalWeightGrams: "14 g",
            fetalLengthCM: "5,4 cm",
            sfSymbol: "sparkles",
            motherChanges: [
                "Illamåendet börjar ofta avta runt nu – äntligen!",
                "Risken för missfall har minskat avsevärt, vilket ger många en lättnadskänsla.",
                "En mörk linje (linea nigra) kan börja synas på magen.",
                "Energin börjar komma tillbaka gradvis – andra trimestern närmar sig!"
            ],
            fetalDevelopment: [
                "Alla organ och strukturer är på plats och fostret ska nu huvudsakligen växa och mogna.",
                "Reflexer utvecklas – fostret kan böja fingrarna om man rör handflatan.",
                "Urinproduktionen har startat och fostret kissar ut fostervatten.",
                "Skelettet börjar förbenas – från brosk till riktigt ben."
            ],
            tips: [
                "Många väljer att berätta om graviditeten nu när risken för missfall har minskat.",
                "Börja fundera på mammaträning eller gravidyoga – det stärker kroppen inför förlossningen.",
                "Ta bilder av magen varje vecka – det blir en fin dokumentation av resan."
            ],
            commonSymptoms: [
                "Minskande illamående – hurra!",
                "Ökad aptit när illamåendet avtar.",
                "Pigmentförändringar i huden, särskilt i ansiktet (kloasma)."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 12 är ofta en milstolpe – många vågar äntligen andas ut.",
                consensus: "Stor lättnad och glädje delas när den kritiska perioden anses vara över.",
                quotes: [
                    "\"Berättade för alla idag! Vecka 12 – nu känns det verkligt!\"",
                    "\"Illamåendet har äntligen börjat lätta. Kan äta normalt igen – vilken befrielse!\"",
                    "\"Lade upp vår ultraljudsbild på sociala medier. Så många fina kommentarer!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 13
        PregnancyWeekContent(
            id: 13,
            week: 13,
            trimester: 2,
            fetalSizeComparison: "En kiwi",
            fetalWeightGrams: "23 g",
            fetalLengthCM: "7,4 cm",
            sfSymbol: "sun.max.fill",
            motherChanges: [
                "Välkommen till andra trimestern! Ofta kallad 'smekmånaden' i graviditeten.",
                "Energin börjar komma tillbaka och du kan känna dig mer som dig själv igen.",
                "Magen börjar synas som en liten rundning, särskilt om det inte är din första graviditet.",
                "Sexlusten kan öka tack vare bättre mående och ökad blodgenomströmning."
            ],
            fetalDevelopment: [
                "Fostret kan nu göra ansiktsuttryck – rynka pannan och grimasera.",
                "Stämbanden utvecklas, även om fostret inte kan använda dem ännu.",
                "Fingeravtrycken har börjat bildas – helt unika redan nu.",
                "Fostret börjar producera mekonium (det första bajset) i tarmarna."
            ],
            tips: [
                "Njut av den ökade energin – det är ett bra tillfälle att fixa praktiska saker hemma.",
                "Börja smörja magen med olja eller kräm för att minska risken för bristningar.",
                "Planera en babymoon-resa om möjligt – andra trimestern är bäst att resa under."
            ],
            commonSymptoms: [
                "Ökad energi och bättre humör – den gyllene trimestern!",
                "Nästäppa och snarkningar – ökad blodvolym svullnar slemhinnorna.",
                "Lättare att bli andfådd vid ansträngning."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 13 – andra trimestern! Lättnad och ny energi präglar forumen.",
                consensus: "De flesta uppskattar att illamåendet äntligen ger med sig och njuter av ny energi.",
                quotes: [
                    "\"Andra trimestern – äntligen! Mår som en ny människa idag.\"",
                    "\"Har börjat vispa runt hemma och städa allt. Var kommer all denna energi ifrån?\"",
                    "\"Min mage har poppat! En liten söt rundning syns nu i tighta kläder.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 14
        PregnancyWeekContent(
            id: 14,
            week: 14,
            trimester: 2,
            fetalSizeComparison: "En citron",
            fetalWeightGrams: "43 g",
            fetalLengthCM: "8,7 cm",
            sfSymbol: "face.smiling.inverse",
            motherChanges: [
                "Livmodern är nu ungefär lika stor som en grapefrukt.",
                "Du kan börja känna att magmusklerna sträcks ut och separeras (rektusdiastas kan börja).",
                "Aptiten är ofta tillbaka med besked – njut av att äta igen!",
                "Huden kan bli torrare eller oljigare beroende på hormoner."
            ],
            fetalDevelopment: [
                "Fostret har nu lanugohår – ett fint ludd som täcker hela kroppen för att hålla värmen.",
                "Sköldkörteln har börjat producera hormoner.",
                "Fostret övar på att andas genom att röra bröstkorgen upp och ner.",
                "Könsorganen är mer utvecklade – snart kan man ibland se könet på ultraljud."
            ],
            tips: [
                "Det är ett bra tillfälle att börja med bäckenbottenträning – gör Kegelövningar dagligen.",
                "Fundera på vilken typ av förlossning du önskar dig och börja läsa på.",
                "Ät järnrik mat som rött kött, bönor, linser och spenat för att förebygga blodbrist."
            ],
            commonSymptoms: [
                "Ökad aptit och ibland starka cravings.",
                "Stickningar eller domningar i händerna – karpaltunnelsyndrom är vanligt under graviditet.",
                "Rundligamentsmärta – ett hugg i ljumsken när du rör dig snabbt."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 14 börjar många fundera på könet och shoppa babykläder.",
                consensus: "Spänningen kring att ta reda på könet eller vänta präglar många diskussioner.",
                quotes: [
                    "\"Vi ska ta reda på könet vid rutinultraljudet. Kan inte vänta!\"",
                    "\"Vi vill ha det som en överraskning. Blev alla förvånade men jag tycker det är spännande!\"",
                    "\"Började titta på barnvagnar idag. Vilken djungel! Några tips på bra modeller?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 15
        PregnancyWeekContent(
            id: 15,
            week: 15,
            trimester: 2,
            fetalSizeComparison: "En nektarin",
            fetalWeightGrams: "70 g",
            fetalLengthCM: "10,1 cm",
            sfSymbol: "ear.fill",
            motherChanges: [
                "Magen blir alltmer synlig och du behöver troligen börja med gravidkläder.",
                "Navelsträngens fäste kan börja synas som en liten hård knöl på magen.",
                "Gingival (tandkötts) svullnad kan bli märkbar – var extra noga med tandvård.",
                "Energinivåerna är ofta goda nu – passa på att njuta!"
            ],
            fetalDevelopment: [
                "Hörseln börjar utvecklas – fostret kan uppfatta vibrationer och dova ljud.",
                "Skelettet förbenas alltmer, även om benen fortfarande är mjuka och flexibla.",
                "Fostret rör sig mycket aktivt – rullar, vänder sig och sparkar.",
                "Ögonbrynen och huvudhår börjar växa."
            ],
            tips: [
                "Prata och sjung för din bebis – hen börjar kunna uppfatta ljud nu.",
                "Investera i några bra gravidplagg som du kan använda under hela graviditeten.",
                "Boka en tid hos tandläkaren om du har besvär med tandköttet."
            ],
            commonSymptoms: [
                "Nästäppa (graviditetsrinit) som kan göra det svårt att sova.",
                "Ökad pigmentering – fräknar och födelsemärken kan bli mörkare.",
                "Lättare svettningar och värmekänslor."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 15 handlar ofta om att äntligen behöva gravidkläder.",
                consensus: "Klädtips och rekommendationer dominerar, liksom längtan efter att känna bebisen röra sig.",
                quotes: [
                    "\"Köpte mina första gravidbyxor idag. Vilken lyx – varför bär inte alla dessa?\"",
                    "\"Har andra-gångs-mammor känt sparkar redan nu? Jag tror jag kände en liten bubbla!\"",
                    "\"Min man sjöng för magen i kväll. Så gulligt att tänka att bebisen faktiskt kan höra!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 16
        PregnancyWeekContent(
            id: 16,
            week: 16,
            trimester: 2,
            fetalSizeComparison: "Ett avokado",
            fetalWeightGrams: "100 g",
            fetalLengthCM: "11,6 cm",
            sfSymbol: "figure.walk",
            motherChanges: [
                "Magen är nu tydligt synlig och omgivningen börjar märka graviditeten.",
                "Du kan känna de första fosterrörelserna – som små bubblor eller fjärilar i magen.",
                "Näsblod kan förekomma oftare på grund av ökad blodvolym.",
                "Ryggen kan börja värka när magen växer och tyngdpunkten förskjuts."
            ],
            fetalDevelopment: [
                "Fostret kan nu gäspa, suga på tummen och göra greppövningar.",
                "Nervsystemet kopplar ihop hjärnan med musklerna – rörelserna blir mer koordinerade.",
                "Navelsträngen är nu fullt utvecklad med två artärer och en ven.",
                "Ögonen kan uppfatta ljus genom mammas mage, även om ögonlocken fortfarande är slutna."
            ],
            tips: [
                "Sov på sidan (helst vänster) – det förbättrar blodcirkulationen till fostret.",
                "Använd en gravidkudde för att stötta magen och ryggen under natten.",
                "Fundera på att gå en föräldrautbildning – kommunen och sjukhuset erbjuder ofta dessa."
            ],
            commonSymptoms: [
                "Möjliga första fosterrörelser (vanligare hos omföderskor).",
                "Ryggsmärta, särskilt i nedre delen av ryggen.",
                "Förstoppning – drick mer vatten och ät fiberrik mat."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 16 – många undrar om de känt bebisen röra sig.",
                consensus: "Det är stor variation i när man först känner fosterrörelser och det leder till många diskussioner.",
                quotes: [
                    "\"Tror jag kände bebisen för första gången idag! Som små bubblor. Eller var det bara gaser?\"",
                    "\"Andra graviditeten och kände sparkar redan i vecka 15! Underbara känslan.\"",
                    "\"Alla verkar känna rörelser redan men jag känner ingenting. Är det normalt?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 17
        PregnancyWeekContent(
            id: 17,
            week: 17,
            trimester: 2,
            fetalSizeComparison: "En päron",
            fetalWeightGrams: "140 g",
            fetalLengthCM: "13 cm",
            sfSymbol: "arrow.up.heart.fill",
            motherChanges: [
                "Magen fortsätter växa stadigt och du kan märka att din balans förändras.",
                "Brösten kan börja producera råmjölk (kolostrum) redan nu.",
                "Du kan uppleva mer svettning och behöva dricka extra mycket vatten.",
                "Blodtrycket kan vara lägre än normalt, vilket ger yrsel vid snabba rörelser."
            ],
            fetalDevelopment: [
                "Fettlagren börjar bildas under huden – de ger energi och håller fostret varmt.",
                "Fostret utvecklar sitt eget immunförsvar med antikroppar.",
                "Hjärnan styr nu regelbundna sov- och vakencykler.",
                "Naglar växer på fingrar och tår."
            ],
            tips: [
                "Drick minst 2 liter vatten om dagen – ännu mer om det är varmt eller du tränar.",
                "Börja planera bebisens rum om ni har möjlighet – det tar tid att hitta rätt.",
                "Prata med din arbetsgivare om graviditeten och planera för din frånvaro."
            ],
            commonSymptoms: [
                "Ökad svettning och värmekänslor.",
                "Bäckensmärta (symfyseolys) kan börja – prata med barnmorskan om det gör ont.",
                "Sömnsvårigheter trots trötthet."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 17 börjar många planera och inreda bebisrummet.",
                consensus: "Diskussioner om barnvagnar, bilbarnstolar och grundläggande utrustning tar fart.",
                quotes: [
                    "\"Började titta på babyutrustning. Behöver man verkligen allt som alla säger? Vad är must-have?\"",
                    "\"Beställde barnvagn idag – Bugaboo Fox. Dyr men vi älskar den!\"",
                    "\"Har berättat på jobbet nu. Alla var jätteglada! Chefen var lite mer... praktisk.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 18
        PregnancyWeekContent(
            id: 18,
            week: 18,
            trimester: 2,
            fetalSizeComparison: "En paprika",
            fetalWeightGrams: "190 g",
            fetalLengthCM: "14,2 cm",
            sfSymbol: "waveform.badge.magnifyingglass",
            motherChanges: [
                "Livmodern är nu ungefär i höjd med naveln.",
                "Du kan känna Braxton Hicks-sammandragningar – övningsvärkar som förbereder livmodern.",
                "Blodtrycket stabiliseras och du kan känna dig piggare.",
                "Vikten ökar mer stadigt nu – ungefär 0,5 kg per vecka är normalt."
            ],
            fetalDevelopment: [
                "Fostret kan nu höra ljud utifrån – din röst, musik och omgivningens ljud.",
                "Myelinisering av nerverna pågår – nervimpulser kan nu färdas snabbare.",
                "Om det är en flicka bildas ägg i äggstockarna – hon har redan alla ägg hon kommer att ha!",
                "Fostret rör sig mycket och du kan börja känna tydliga sparkar."
            ],
            tips: [
                "Rutinultraljudet görs vanligtvis runt vecka 18-20 – se till att det är bokat.",
                "Spela musik för bebisen – forskning visar att foster reagerar på musik.",
                "Börja gå en föräldrautbildning om du inte redan gjort det."
            ],
            commonSymptoms: [
                "Tydligare fosterrörelser – nu brukar de flesta förstagångsmammor känna dem.",
                "Svullna fötter och ben, särskilt på eftermiddagen.",
                "Yrsel om du reser dig upp snabbt."
            ],
            prenatalVisit: "Rutinultraljud erbjuds (vecka 18-20): Ett detaljerat ultraljud där man kontrollerar fostrets anatomi, tillväxt, moderkakans läge och mängden fostervatten. Många tar reda på könet vid detta tillfälle.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 18 – rutinultraljudet närmar sig och spänningen stiger.",
                consensus: "Alla firar att ultraljudet visar att bebisen är frisk. Könsavslöjanden delas frikostigt.",
                quotes: [
                    "\"Rutinultraljud på torsdag! Så nervös men mest spänd. Vi vill veta könet!\"",
                    "\"Såg vår lilla pojke på ultraljudet idag. Helt perfekt! Alla organ såg bra ut.\"",
                    "\"Vi valde att inte ta reda på könet. Ultraljudssköterskan lade kuvertet i ett kuvert ifall vi ändrar oss.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 19
        PregnancyWeekContent(
            id: 19,
            week: 19,
            trimester: 2,
            fetalSizeComparison: "En mango",
            fetalWeightGrams: "240 g",
            fetalLengthCM: "15,3 cm",
            sfSymbol: "paintbrush.fill",
            motherChanges: [
                "Magen är nu tydligt gravid och svår att dölja.",
                "Huden kan kännas stretchig och börja klia – smörj flitigt!",
                "Du kan uppleva att du glömmer saker lättare – det kallas gravidhjärna och är helt normalt.",
                "Bäckensmärta kan bli mer märkbar i takt med att hormonet relaxin ökar."
            ],
            fetalDevelopment: [
                "Vernix caseosa – ett vitt, vaxliknande skyddande lager – täcker nu fostrets hud.",
                "Sinnena utvecklas snabbt: smak, lukt, syn, hörsel och känsel.",
                "Hjärnan bildar miljontals nya nervceller varje dag.",
                "Fostret har etablerat ett sömnmönster och sover i perioder om 40-50 minuter."
            ],
            tips: [
                "Smörj magen med en bra oljeblandning (mandelolja fungerar utmärkt) för att lindra klåda.",
                "Skriv listor och använd påminnelser för att kompensera för gravidhjärnan.",
                "Gå en barnhjärt-lungräddningskurs (HLR) – det ger trygghet inför föräldraskapet."
            ],
            commonSymptoms: [
                "Kliande mage när huden sträcks ut.",
                "Gravidhjärna – glömska och förvirring.",
                "Ryggvärk som kan stråla ut i benen."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 19 pratas det mycket om ultraljudsresultat och bebisens kön.",
                consensus: "Glädje över friska ultraljudsresultat och debatter om könsavslöjanden dominerar.",
                quotes: [
                    "\"Allt såg perfekt ut på ultraljudet! Så otroligt lättad och lycklig.\"",
                    "\"Hade min 'gender reveal' i helgen. Det blir en FLICKA! Rosa konfetti överallt!\"",
                    "\"Gravidhjärnan har slagit till på riktigt. Glömde var jag parkerat bilen igår.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 20
        PregnancyWeekContent(
            id: 20,
            week: 20,
            trimester: 2,
            fetalSizeComparison: "En banan",
            fetalWeightGrams: "300 g",
            fetalLengthCM: "16,4 cm",
            sfSymbol: "flag.checkered",
            motherChanges: [
                "Halvvägs! Livmodern är nu i nivå med naveln.",
                "Naveln kan börja sticka ut – helt normalt och den går tillbaka efter förlossningen.",
                "Vikten har troligen ökat med 4-6 kg hittills.",
                "Du kan känna dig andfådd lättare eftersom livmodern trycker uppåt mot diafragman."
            ],
            fetalDevelopment: [
                "Fostret mäts nu från huvud till häl istället för huvud till rumpa.",
                "Huden utvecklar flera lager men är fortfarande genomskinlig.",
                "Fostret har nu utvecklade smaklökar och kan smaka på fostervattnet.",
                "Rörelserna är tydliga och regelbundna – du kan ibland se magen röra sig."
            ],
            tips: [
                "Fira halvvägs-milstolpen! Ta en fin magbild och unna dig något.",
                "Börja öva avslappnings- och andningstekniker inför förlossningen.",
                "Se till att du får tillräckligt med omega-3 – viktigt för bebisens hjärnutveckling."
            ],
            commonSymptoms: [
                "Andfåddhet vid fysisk ansträngning.",
                "Svullna anklar och fötter, särskilt i varmt väder.",
                "Kramper i vaderna, ofta på natten."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 20 – halvvägs! Det firas stort på forumen.",
                consensus: "Alla uppmärksammar milstolpen och delar magbilder. Många börjar planera förlossningen.",
                quotes: [
                    "\"HALVVÄGS! Känns som igår jag fick positivt test och ändå som en evighet sedan.\"",
                    "\"Kan se bebisen sparka genom magen nu! Min man blev helt mållös.\"",
                    "\"Började skriva förlossningsbrev idag. Vad är viktigt att ha med?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 21
        PregnancyWeekContent(
            id: 21,
            week: 21,
            trimester: 2,
            fetalSizeComparison: "En morot",
            fetalWeightGrams: "360 g",
            fetalLengthCM: "26,7 cm",
            sfSymbol: "hand.thumbsup.fill",
            motherChanges: [
                "Magen fortsätter växa och du kan behöva anpassa din sovställning.",
                "Stretchmärken kan börja synas på magen, brösten och höfterna.",
                "Libido kan vara högre än vanligt under andra trimestern.",
                "Du kan uppleva att dina fötter växer – de kan bli upp till en storlek större."
            ],
            fetalDevelopment: [
                "Fostret sväljer fostervatten regelbundet – detta tränar matsmältningssystemet.",
                "Benmärgen producerar nu tillräckligt med blodkroppar på egen hand.",
                "Fostret kan reagera på beröring – om du trycker på magen kan hen röra sig bort.",
                "Smaksinnet är så utvecklat att fostret kan reagera på vad du äter."
            ],
            tips: [
                "Börja med regelbundna bäckenbottenövningar om du inte redan gör det.",
                "Investera i sköna, stödjande skor – dina fötter bär extra vikt nu.",
                "Ät varierat och färgrikt – fostrets smaksinne påverkas av vad du äter."
            ],
            commonSymptoms: [
                "Stretchmärken som kliar och syns som rosa/lila ränder.",
                "Vadkramper, ofta nattetid.",
                "Lättare andnöd vid trappgång."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 21 handlar det mycket om kroppen och dess förändringar.",
                consensus: "Diskussioner om stretchmärken, viktuppgång och kroppsbild är vanliga.",
                quotes: [
                    "\"Fick mina första bristningar idag. Grät lite. Men de bleknar tydligen!\"",
                    "\"Mina skor passar inte längre! Har gått upp en hel skostorlek. Blir det permanent?\"",
                    "\"Bebisen reagerar varje gång jag äter glass. Tror hen gillar det lika mycket som jag!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 22
        PregnancyWeekContent(
            id: 22,
            week: 22,
            trimester: 2,
            fetalSizeComparison: "En papaya",
            fetalWeightGrams: "430 g",
            fetalLengthCM: "27,8 cm",
            sfSymbol: "eye.fill",
            motherChanges: [
                "Livmodern sträcker sig nu ovanför naveln.",
                "Du kan märka att håret och naglarna växer snabbare än vanligt.",
                "Flytningarna kan öka ytterligare – använd trosskydd om det behövs.",
                "Aptiten kan vara stor – kroppen behöver cirka 300 extra kalorier per dag."
            ],
            fetalDevelopment: [
                "Ögonen är fullt utvecklade men iris saknar fortfarande pigment.",
                "Öronen är tillräckligt utvecklade för att fostret ska höra din röst tydligt.",
                "Lungorna utvecklas snabbt men är ännu inte mogna nog för andning utanför livmodern.",
                "Fostret kan nu gripa med händerna och håller ibland i navelsträngen."
            ],
            tips: [
                "Börja räkna fosterrörelser dagligen – det ger trygghet och hjälper dig lära känna bebisens mönster.",
                "Planera praktiska saker som föräldraförsäkring och VAB med Försäkringskassan.",
                "Ät kalciumrik mat – fostrets ben förbenas och kräver mycket kalcium."
            ],
            commonSymptoms: [
                "Ökade flytningar – normalt så länge de är klara/vita och luktfria.",
                "Halsbränna efter måltider.",
                "Hevelser i händer och fötter."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "I vecka 22 börjar fosterrörelserna bli en viktig del av vardagen.",
                consensus: "Många delar sina upplevelser av att känna bebisen röra sig och frågar om vad som är normalt.",
                quotes: [
                    "\"Bebisen är jätteaktiv mellan 21 och 23 varje kväll. Som en liten dansare!\"",
                    "\"Min partner kände sparken för första gången igår kväll. Vi grät båda!\"",
                    "\"Hur ofta ska man känna rörelser i vecka 22? Ibland går det timmar utan att jag känner något.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 23
        PregnancyWeekContent(
            id: 23,
            week: 23,
            trimester: 2,
            fetalSizeComparison: "En stor mango",
            fetalWeightGrams: "500 g",
            fetalLengthCM: "28,9 cm",
            sfSymbol: "music.note",
            motherChanges: [
                "Vikten ökar stadigt och du bär nu med dig cirka 5-7 extra kilo.",
                "Ischiasnerven kan bli irriterad av den växande livmodern – ger smärta i skinkan och benet.",
                "Huden på magen kan bli torr och kliande – fortsätt smörja regelbundet.",
                "Braxton Hicks-sammandragningar kan bli vanligare."
            ],
            fetalDevelopment: [
                "Lungorna utvecklar surfaktant – ett ämne som gör att lungorna kan expandera vid andning.",
                "Fostret reagerar på ljud och kan hoppa till av plötsliga ljud.",
                "Proportionerna börjar likna en nyfödd, men fostret är fortfarande mager.",
                "Snabba ögonrörelser (REM-sömn) kan observeras – fostret drömmer!"
            ],
            tips: [
                "Stretcha regelbundet för att lindra ischiassmärta – yoga för gravida är utmärkt.",
                "Läs eller lyssna på poddar om förlossning och amning för att förbereda dig mentalt.",
                "Se till att barnets bilbarnstol är köpt och testad i bilen."
            ],
            commonSymptoms: [
                "Ischiassmärta – en stickande/brännande smärta i ryggslutet, skinkan eller benet.",
                "Svullna och värkande ben och fötter.",
                "Sömnproblem – svårt att hitta en bekväm sovställning."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 23 – ischias och sömnproblem diskuteras flitigt.",
                consensus: "Många söker tips för att hantera kroppssmärtor och sovsvårigheter.",
                quotes: [
                    "\"Ischias är det värsta med hela graviditeten! Kan knappt gå vissa dagar.\"",
                    "\"Har köpt en gravidkudde (C-formad) och det har förändrat mitt liv. Bästa köpet!\"",
                    "\"Bebisen dansar hela natten och jag kan inte sova. Men jag älskar att känna hen röra sig.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 24
        PregnancyWeekContent(
            id: 24,
            week: 24,
            trimester: 2,
            fetalSizeComparison: "En majskolv",
            fetalWeightGrams: "600 g",
            fetalLengthCM: "30 cm",
            sfSymbol: "lungs.fill",
            motherChanges: [
                "Din livmoder är nu stor som en fotboll och syns tydligt.",
                "Linea nigra (den mörka linjen på magen) kan bli mer framträdande.",
                "Du kan uppleva en klåda som inte har med torr hud att göra – kontakta barnmorskan om den är besvärlig.",
                "Andfåddhet kan öka när livmodern trycker uppåt mot lungorna."
            ],
            fetalDevelopment: [
                "Detta är en viktig milstolpe: fostret har nu en chans att överleva vid för tidig födsel med intensivvård.",
                "Lungorna mognar snabbt men behöver fortfarande flera veckor till av utveckling.",
                "Innerörat är nu fullt utvecklat – fostret har balanssinne och kan känna om det är uppochner.",
                "Hjärnan växer snabbt och nya kopplingar bildas hela tiden."
            ],
            tips: [
                "Lär dig känna igen tecken på förtidigt värkarbete: regelbundna sammandragningar, tryck nedåt, blödning.",
                "Se till att du vilar tillräckligt – lägg gärna upp benen under dagen.",
                "Ät lite och ofta för att undvika halsbränna och minska trycket på magen."
            ],
            commonSymptoms: [
                "Halsbränna och sura uppstötningar – undvik kryddstark mat nära sänggåendet.",
                "Klåda på magen som kan bli ganska besvärlig.",
                "Korta stunder av andnöd."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 24 kallas ibland 'livskraftighetsveckan' och det diskuteras mycket.",
                consensus: "Många känner sig tryggare nu och börjar tänka mer konkret på förlossningen.",
                quotes: [
                    "\"Vecka 24! Bebisen anses nu livskraftig. Det ger en enorm trygghet.\"",
                    "\"Har börjat packa sjukhusväskan redan nu. Är jag för tidig? Vill bara vara förberedd!\"",
                    "\"Klådan på magen driver mig galen. Har testat allt – någon som vet vad som hjälper?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 25
        PregnancyWeekContent(
            id: 25,
            week: 25,
            trimester: 2,
            fetalSizeComparison: "En kålrot",
            fetalWeightGrams: "660 g",
            fetalLengthCM: "34,6 cm",
            sfSymbol: "brain.head.profile.fill",
            motherChanges: [
                "Magen växer snabbt nu och du kan känna dig klumpig och otymplig.",
                "Hemorrhojder kan uppstå på grund av ökat tryck i bäckenet och förstoppning.",
                "Svullnaden i händer och fötter kan öka – ta av ringar om de börjar sitta tajt.",
                "Du kan uppleva att sömnen blir sämre – det är svårt att hitta en bekväm position."
            ],
            fetalDevelopment: [
                "Hjärnan utvecklas i rasande takt – hjärnbarken bildas med alla sina veck.",
                "Fostret kan nu öppna och stänga ögonen för första gången.",
                "Lungorna fortsätter mogna och producerar allt mer surfaktant.",
                "Fettlagren under huden ökar – fostret börjar runda av sig."
            ],
            tips: [
                "Mot hemorrhojder: ät fiberrik mat, drick mycket vatten och undvik att sitta still länge.",
                "Börja fundera på förlossningsplan – men var öppen för att planer kan ändras.",
                "Prata med din partner om hur ni vill fördela föräldraledigheten."
            ],
            commonSymptoms: [
                "Hemorrhojder – smärtsamma men vanliga och behandlingsbara.",
                "Restless legs – rastlösa ben, särskilt på kvällen.",
                "Andnöd vid lätt ansträngning."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 25 – kroppen jobbar hårt och det märks på forumen.",
                consensus: "Hemorrhojder och sömnproblem är vanliga ämnen, liksom föräldraledighetplanering.",
                quotes: [
                    "\"Ingen sa till mig att hemorrhojder var en del av paketet. Tack graviditet.\"",
                    "\"Mina ben vill inte vara stilla på kvällarna. Restless legs är hemskt! Magnesium hjälper lite.\"",
                    "\"Hur fördelar ni föräldraledigheten? Vi tänker ta 6+6 månader.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 26
        PregnancyWeekContent(
            id: 26,
            week: 26,
            trimester: 2,
            fetalSizeComparison: "En salladshuvud",
            fetalWeightGrams: "760 g",
            fetalLengthCM: "35,6 cm",
            sfSymbol: "eye.trianglebadge.exclamationmark.fill",
            motherChanges: [
                "Du kan börja märka att magen hardnar ibland – det är Braxton Hicks-sammandragningar.",
                "Ögonen kan kännas torra och irriterade – det är hormonellt betingat.",
                "Svullnaden kan öka mot kvällen – vila med benen upplagda.",
                "Du kan få hicka oftare, liksom din bebis!"
            ],
            fetalDevelopment: [
                "Ögonen öppnas helt och fostret kan se ljus som filtreras genom magväggen.",
                "Hörseln är välutvecklad och fostret reagerar tydligt på din röst.",
                "Hjärnan visar mönster av aktivitet som liknar en nyfödds.",
                "Fostret övar andningsrörelser med fostervatten – det stärker lungmusklerna."
            ],
            tips: [
                "Börja öva andningstekniker inför förlossningen – djupandning och avslappning.",
                "Packa en sjukhusväska – det ger trygghet att vara förberedd.",
                "Skriv ner frågor till dina barnmorskebesök – det är lätt att glömma dem annars."
            ],
            commonSymptoms: [
                "Braxton Hicks – oregelbundna sammandragningar som känns som en åtstramning.",
                "Torra ögon och synförändringar.",
                "Svullna fötter och ben, särskilt mot kvällen."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 26 – Braxton Hicks och sjukhusväskan diskuteras flitigt.",
                consensus: "Många frågar om skillnaden mellan övningsvärkar och riktiga värkar.",
                quotes: [
                    "\"Fick panik av Braxton Hicks igår! Trodde det var riktiga sammandragningar. Barnmorskan lugnade mig.\"",
                    "\"Började packa sjukhusväskan. Vad ska man ha med? Behöver man verkligen så mycket?\"",
                    "\"Bebisen har hicka flera gånger om dagen. Det är så gulligt att känna de små ryckningarna!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 27
        PregnancyWeekContent(
            id: 27,
            week: 27,
            trimester: 2,
            fetalSizeComparison: "En blomkål",
            fetalWeightGrams: "875 g",
            fetalLengthCM: "36,6 cm",
            sfSymbol: "moon.zzz.fill",
            motherChanges: [
                "Sista veckan av andra trimestern! Magen har vuxit ordentligt.",
                "Sömnkvaliteten kan försämras ytterligare – vakna flera gånger per natt.",
                "Du kan uppleva karpaltunnelsyndrom med domningar i händerna.",
                "Kramper i benen kan komma oftare, särskilt nattetid."
            ],
            fetalDevelopment: [
                "Hjärnan är nu väldigt aktiv och fostret har perioder av vakenhet och sömn.",
                "Lungorna är bättre utvecklade men behöver fortfarande mogna.",
                "Fostret har nu regelbundna sömncykler och vaknar av ljud.",
                "Smaksinnet är välutvecklat – fostret föredrar söta smaker i fostervattnet."
            ],
            tips: [
                "Sov med kuddar mellan knäna och under magen för bättre sovkomfort.",
                "Gör handledsstretchningar om du har karpaltunnelsymtom.",
                "Börja fundera på amning – läs på och prata med din barnmorska om förberedelser."
            ],
            commonSymptoms: [
                "Sömnsvårigheter och frekvent uppvaknande.",
                "Karpaltunnelsyndrom – domningar och stickningar i händer och fingrar.",
                "Ökad ryggsmärta."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 27 – sista veckan i andra trimestern. Blandade känslor!",
                consensus: "Nervositet inför tredje trimestern blandas med glädje över att det närmar sig.",
                quotes: [
                    "\"Sista veckan i andra trimestern! Har gått så fort och samtidigt känns det som en evighet.\"",
                    "\"Vaknar typ fem gånger per natt. Är det kroppens sätt att förbereda mig på att ha nyfödd?\"",
                    "\"Händerna domnar av varje morgon. Karpaltunnelsyndrom tydligen. När går det över?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 28
        PregnancyWeekContent(
            id: 28,
            week: 28,
            trimester: 3,
            fetalSizeComparison: "En stor aubergine",
            fetalWeightGrams: "1000 g",
            fetalLengthCM: "37,6 cm",
            sfSymbol: "figure.dress.line.vertical.figure",
            motherChanges: [
                "Välkommen till tredje trimestern! De sista 12 veckorna har börjat.",
                "Livmodern trycker alltmer uppåt mot revbenen, vilket kan ge smärta.",
                "Du kan uppleva att du snubblar lättare – tyngdpunkten har förskjutits ordentligt.",
                "Magen kan kännas hård och spänd, särskilt efter aktivitet."
            ],
            fetalDevelopment: [
                "Fostret väger nu ungefär ett kilo och är livskraftigt vid prematur födsel.",
                "Ögonen kan fokusera och följa ljuskällor.",
                "Hjärnan utvecklar mer komplexa veck (gyri) som ökar dess kapacitet.",
                "Fostret kan drömma – REM-sömn har observerats med regelbundna mönster."
            ],
            tips: [
                "Glukosbelastningstestet brukar göras runt nu – det testar för graviditetsdiabetes.",
                "Börja räkna fosterrörelser mer noggrant – 10 rörelser inom 2 timmar är normalt.",
                "Ta hand om ryggen – undvik att lyfta tungt och använd korrekt lyftteknik."
            ],
            commonSymptoms: [
                "Andfåddhet – livmodern trycker på lungorna.",
                "Revbenssmärta från livmoderns tryck uppåt.",
                "Trötthet som påminner om första trimestern."
            ],
            prenatalVisit: "Glukosbelastningstest (vecka 28): Ett test för att kontrollera om du har utvecklat graviditetsdiabetes. Du dricker en sockerlösning och tar blodprover. Barnmorskan tar även blodprover för att kontrollera blodvärdet.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 28 – tredje trimestern! Glukostestet och den sista sprinten diskuteras.",
                consensus: "Många delar sina upplevelser av glukostestet och börjar känna att det närmar sig.",
                quotes: [
                    "\"Tredje trimestern – det börjar bli verkligt nu! 12 veckor kvar (eller mindre!).\"",
                    "\"Glukostestet var äckligt men gick snabbt. Sockerdrickan smakade som platt Fanta. Allt var normalt!\"",
                    "\"Började bli nervös inför förlossningen nu. Ska gå förlossningsförberedande kurs nästa vecka.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 29
        PregnancyWeekContent(
            id: 29,
            week: 29,
            trimester: 3,
            fetalSizeComparison: "En butternutpumpa",
            fetalWeightGrams: "1150 g",
            fetalLengthCM: "38,6 cm",
            sfSymbol: "heart.text.clipboard.fill",
            motherChanges: [
                "Du kan uppleva att bebisen sparkar hårdare och mer märkbart nu.",
                "Sömnpositionen är viktig – sov på sidan för bästa blodflöde.",
                "Läckage från brösten (kolostrum) kan förekomma – det är kroppens förberedelse.",
                "Bäckenbotten kan kännas tung – använd stödgördel om det behövs."
            ],
            fetalDevelopment: [
                "Fostret lägger på sig fett snabbt nu – ungefär 200 gram per vecka.",
                "Hjärnan kontrollerar nu kroppstemperaturen.",
                "Benen förstärks med kalcium och andra mineraler.",
                "Fostret är tillräckligt stort för att du kan känna vilken kroppsdel som trycker mot magen."
            ],
            tips: [
                "Börja med perineal massage (mellangårdsmassage) – det kan minska risken för bristningar vid förlossningen.",
                "Anmäl dig till föräldrautbildning om du inte redan gjort det.",
                "Planera vem som ska ta hand om eventuella husdjur eller äldre barn under förlossningen."
            ],
            commonSymptoms: [
                "Svårt att sova bekvämt – magen är i vägen oavsett position.",
                "Frekventa toalettbesök, dag som natt.",
                "Värk i ryggslutet och bäckenet."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 29 – förlossningsförberedelser tar fart på forumen.",
                consensus: "Diskussioner om förlossningsrädsla, smärtlindring och förlossningsplaner dominerar.",
                quotes: [
                    "\"Har blivit lite förlossningsrädd. Hur hanterade ni det? Tips mottages tacksamt!\"",
                    "\"Kolostrum läcker genom tröjan på jobbet! Måste köpa amningsinlägg redan nu.\"",
                    "\"Min bebis sparkar som en fotbollsspelare. Det gör faktiskt ont ibland!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 30
        PregnancyWeekContent(
            id: 30,
            week: 30,
            trimester: 3,
            fetalSizeComparison: "En stor gurka",
            fetalWeightGrams: "1320 g",
            fetalLengthCM: "39,9 cm",
            sfSymbol: "bag.fill",
            motherChanges: [
                "Magen är nu stor och du kan ha svårt att böja dig nedåt.",
                "Matsmältningen saktas ner ytterligare – ät ofta men lite.",
                "Du kan uppleva att du behöver kissa väldigt ofta, även på natten.",
                "Åderbråck i benen kan förvärras – stödstrumpor kan hjälpa."
            ],
            fetalDevelopment: [
                "Fostret börjar vanligtvis vända sig med huvudet nedåt inför förlossningen.",
                "Lanugohåret börjar försvinna gradvis.",
                "Hjärnan kan nu reglera kroppstemperaturen bättre.",
                "Fostrets syn förbättras – hen kan skilja mellan ljus och mörker."
            ],
            tips: [
                "Packa sjukhusväskan om du inte redan gjort det – den bör vara redo nu.",
                "Börja planera för de första veckorna med bebisen – handla in blöjor, kläder och det som behövs.",
                "Diskutera med din partner om förlossningens gång och hur hen kan stötta dig."
            ],
            commonSymptoms: [
                "Frekventa toalettbesök – fostret trycker på blåsan.",
                "Andfåddhet och trötthet.",
                "Svårighet att äta stora portioner – magen trycks ihop."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 30 – 10 veckor kvar! Förberedelser och nervositet.",
                consensus: "Sjukhusväskan och praktiska förberedelser dominerar diskussionerna.",
                quotes: [
                    "\"10 veckor kvar! Har packat sjukhusväskan och köpt allt vi behöver. Redo att möta dig, lilla du!\"",
                    "\"Bebisen har vänt sig med huvudet nedåt! Barnmorskan sa att det ser bra ut.\"",
                    "\"Kan knappt äta en hel tallrik mat utan att det trycker. Äter som en fågel men 6 gånger om dagen.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 31
        PregnancyWeekContent(
            id: 31,
            week: 31,
            trimester: 3,
            fetalSizeComparison: "En kokosnöt",
            fetalWeightGrams: "1500 g",
            fetalLengthCM: "41,1 cm",
            sfSymbol: "bed.double.fill",
            motherChanges: [
                "Du kan känna dig mer otymplig och trög – det är helt normalt i slutet av graviditeten.",
                "Sammandragningarna (Braxton Hicks) kan bli mer frekventa och starkare.",
                "Brösten kan vara laddade med kolostrum och kännas tunga.",
                "Sömnproblem är vanliga – pröva avslappningsövningar före sänggåendet."
            ],
            fetalDevelopment: [
                "Hjärnan utvecklas explosionsartat – miljarder nervceller kopplas ihop.",
                "Fostret övar andning mer regelbundet – bröstkorgen rör sig rytmiskt.",
                "Pupillerna kan nu vidgas och dra ihop sig som respons på ljus.",
                "Immunsystemet utvecklas och tar emot antikroppar via moderkakan."
            ],
            tips: [
                "Lägg dig i vila om du känner många sammandragningar – de ska avta vid vila.",
                "Ta hand om dig själv: en massage, ett varmt bad eller en stund med en bra bok.",
                "Se till att bilbarnstolen är korrekt monterad i bilen."
            ],
            commonSymptoms: [
                "Tätare Braxton Hicks-sammandragningar.",
                "Sömnlöshet och orolig sömn.",
                "Svullnad i händer, fötter och ansikte."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 31 – trötthet och förväntan blandas.",
                consensus: "Sömntips och klagomål över tredje trimesterns besvär delas generöst.",
                quotes: [
                    "\"Kan inte sova, kan inte gå, kan inte böja mig. Men jag ÄLSKAR min mage och allt det innebär.\"",
                    "\"Braxton Hicks hela kvällen. Ringde förlossningen men de sa att det var övningsvärkar. Puh!\"",
                    "\"Har monterat bilbarnstolen. Det tog en timme och mycket svordomar men nu sitter den!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 32
        PregnancyWeekContent(
            id: 32,
            week: 32,
            trimester: 3,
            fetalSizeComparison: "En ananas",
            fetalWeightGrams: "1700 g",
            fetalLengthCM: "42,4 cm",
            sfSymbol: "tray.full.fill",
            motherChanges: [
                "Magen är stor och du kan märka att bebisen tar upp allt mer plats.",
                "Revbenssmärta kan uppstå när fostret sparkar uppåt.",
                "Du kan uppleva att du läcker urin vid hosta, nysning eller skratt.",
                "Trötthet och tunghet i kroppen – det är helt okej att ta det lugnt."
            ],
            fetalDevelopment: [
                "Tånaglar och fingernaglar är fullt utvecklade.",
                "Fostret övar suga och svälja i förberedelse för amning.",
                "Skelettet är nästan helt utvecklat men skallbenen är fortfarande mjuka för att underlätta förlossningen.",
                "Fostret har sitt eget sömnschema som kanske inte matchar ditt!"
            ],
            tips: [
                "Gör bäckenbottenövningar dagligen – det hjälper mot urinläckage.",
                "Börja förbereda frysen med matportioner för de första veckorna efter förlossningen.",
                "Ta kontakt med BB och ta reda på när du ska åka in."
            ],
            commonSymptoms: [
                "Urininkontinens vid ansträngning – helt normalt men pinsamt.",
                "Hävelser och vattenretention.",
                "Trötthet som blir allt mer påtaglig."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 32 – åtta veckor kvar! Nestinginstinkten slår till.",
                consensus: "Nestinginstinkten diskuteras livligt – alla vill städa, organisera och förbereda.",
                quotes: [
                    "\"Nestinginstinkten har slagit till med full kraft! Har tvättat alla babykläder och organiserat byrån.\"",
                    "\"Läcker kiss varje gång jag nyser. Bäckenbottenträning är inte ett skämt – börja tidigt!\"",
                    "\"Har lagat mat och fryst in 30 portioner. Min partner tror jag blivit galen men vi kommer tacka oss själva.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 33
        PregnancyWeekContent(
            id: 33,
            week: 33,
            trimester: 3,
            fetalSizeComparison: "En ananas",
            fetalWeightGrams: "1920 g",
            fetalLengthCM: "43,7 cm",
            sfSymbol: "clock.badge.checkmark.fill",
            motherChanges: [
                "Magen kan börja 'sjunka' – bebisen börjar söka sig neråt i bäckenet.",
                "Andningen kan bli lättare om bebisen sjunker ner, men trycket mot blåsan ökar.",
                "Du kan uppleva att huden på magen är så utsträckt att naveln helt har planat ut.",
                "Bensvullnad kan vara mer uttalad, särskilt i värme."
            ],
            fetalDevelopment: [
                "Fostret lägger på sig ungefär 200-250 gram per vecka nu.",
                "Immunsystemet är bättre utvecklat men fortfarande omogen.",
                "De flesta foster ligger nu med huvudet neråt (huvudbjudning).",
                "Lungorna är nästan fullt utvecklade – baby born nu klarar sig ofta bra."
            ],
            tips: [
                "Om bebisen ligger i säte, fråga barnmorskan om yttre vändning.",
                "Gå en amningskurs – att vara förberedd ger trygghet.",
                "Se till att alla dokument är i ordning: förlossningsplan, sjukhusväska, kontaktuppgifter."
            ],
            commonSymptoms: [
                "Bäckentryck och tyngdkänsla.",
                "Tätare kissbehov om bebisen har sjunkit ner.",
                "Trötthet och behov av extra vila."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 33 – bebisens position och amningsfrågor diskuteras.",
                consensus: "Många oroar sig för att bebisen inte har vänt sig och delar erfarenheter av vändningsförsök.",
                quotes: [
                    "\"Min bebis ligger fortfarande i säte! Barnmorskan sa att det finns tid kvar att vända sig.\"",
                    "\"Gick amningskurs i helgen. Så mycket man inte vet! Glad att jag gick.\"",
                    "\"Har blivit så tungfotad att jag puffar och stönar varje gång jag reser mig från soffan.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 34
        PregnancyWeekContent(
            id: 34,
            week: 34,
            trimester: 3,
            fetalSizeComparison: "En cantaloupe-melon",
            fetalWeightGrams: "2150 g",
            fetalLengthCM: "45 cm",
            sfSymbol: "shield.checkered",
            motherChanges: [
                "Du kan känna ett ökat tryck mot bäckenet och ryggslutet.",
                "Braxton Hicks kan komma oftare och ibland kännas ganska starka.",
                "Vikten har ökat med cirka 10-13 kg totalt – helt normalt.",
                "Du kan uppleva att du andas tungt även i vila."
            ],
            fetalDevelopment: [
                "Vernixlagret som skyddar fostrets hud tjocknar – det hjälper vid förlossningen.",
                "Centralnervsystemet och lungorna mognar de sista kritiska stegen.",
                "Fostret kan blinka, fokusera, vända huvudet och reagera på ljus.",
                "Skelettet är nu ordentligt förbent, förutom skallens fontaneller som förblir mjuka."
            ],
            tips: [
                "Tala med din barnmorska om din förlossningsplan och eventuella önskemål.",
                "Gör en lista med telefonnummer: barnmorska, förlossning, partner, närstående.",
                "Vila så mycket du kan – kroppen förbereder sig för förlossningen."
            ],
            commonSymptoms: [
                "Bäckensmärta och svårighet att gå.",
                "Trötthet som inte går att vila bort.",
                "Svullna händer och fötter."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 34 – det börjar bli verkligt att det snart är dags.",
                consensus: "Många känner blandade känslor av längtan och nervositet inför förlossningen.",
                quotes: [
                    "\"Sex veckor kvar och jag är SÅ redo. Vill bara hålla i min bebis nu.\"",
                    "\"Barnmorskan mätte magen och allt ser bra ut. Bebisen väger uppskattningsvis 2,2 kg.\"",
                    "\"Var på sjukhuset och tittade på förlossningsavdelningen. Det gjorde det mycket mer verkligt!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 35
        PregnancyWeekContent(
            id: 35,
            week: 35,
            trimester: 3,
            fetalSizeComparison: "En honungsmelon",
            fetalWeightGrams: "2380 g",
            fetalLengthCM: "46,2 cm",
            sfSymbol: "testtube.2",
            motherChanges: [
                "Fostret tar nu upp det mesta av utrymmet i livmodern – du kan känna dig extremt full.",
                "Livmodern trycker på magen och du kan uppleva halsbränna och sura uppstötningar.",
                "Sömnen är ofta fragmenterad – du vaknar av kissbehov, smärta eller baby som sparkar.",
                "Du kan börja uppleva att bäckenet känns instabilt – relaxinet har lösgjort lederna."
            ],
            fetalDevelopment: [
                "Fostret har nu tillräckligt med fett för att kunna reglera sin kroppstemperatur.",
                "Njurarna är fullt utvecklade och levererar sin slutgiltiga funktion.",
                "Fostret vänder sig vanligtvis till förlossningsläge (huvudet nedåt) om det inte redan gjort det.",
                "Rörelserna kan kännas annorlunda – mer tryck och rulling istället för sparkar."
            ],
            tips: [
                "GBS-test (grupp B-streptokocker) görs vanligtvis vecka 35-37 – fråga din barnmorska.",
                "Börja förbereda hemmet för bebisens ankomst – alla nödvändigheter på plats?",
                "Vila, vila, vila – kroppen behöver samla krafter inför förlossningen."
            ],
            commonSymptoms: [
                "Extremt trång i magen – svårt att äta normala portioner.",
                "Bäckeninstabilitet och svårighet att gå längre sträckor.",
                "Sömnlöshet och rastlöshet."
            ],
            prenatalVisit: "GBS-test (vecka 35-37): Ett prov tas från slidan för att kontrollera om du bär på Grupp B-streptokocker. Om testet är positivt får du antibiotika under förlossningen för att skydda bebisen.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 35 – GBS-test och förlossningsförberedelser diskuteras.",
                consensus: "Frågor om GBS-test och vad det innebär om det är positivt är vanliga.",
                quotes: [
                    "\"Fick positivt GBS-test. Barnmorskan sa att det inte är farligt men att jag får dropp under förlossningen.\"",
                    "\"Fem veckor kvar! Allt är redo hemma. Nu väntar vi bara på dig, lilla skatten.\"",
                    "\"Kan inte äta mer än tre tuggor utan att magen trycker. Längtar efter att kunna äta normalt igen!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 36
        PregnancyWeekContent(
            id: 36,
            week: 36,
            trimester: 3,
            fetalSizeComparison: "En romansallad",
            fetalWeightGrams: "2620 g",
            fetalLengthCM: "47,4 cm",
            sfSymbol: "arrow.down.circle.fill",
            motherChanges: [
                "Bebisen kan sjunka ner i bäckenet ('lightening') – det underlättar andningen men ökar kisbehovet.",
                "Du kanske börjar tappa slemproppen – en tjock, geléliknande flytning.",
                "Brösten kan läcka kolostrum mer frekvent.",
                "Kroppen börjar förbereda sig för förlossningen – livmoderhalsen kan börja mogna."
            ],
            fetalDevelopment: [
                "Fostret anses nu vara 'early term' – nästintill fullgånget.",
                "Skallen är mjuk och formbar för att kunna passera förlossningskanalen.",
                "Alla organ är utvecklade och redo att fungera utanför livmodern.",
                "Fostret övar sugrörelsen intensivt – det behövs vid amning."
            ],
            tips: [
                "Dubbelkolla sjukhusväskan – allt på plats för både dig och bebis?",
                "Känn efter fosterrörelser dagligen – kontakta vården om de minskar.",
                "Vila och samla krafter – du kommer behöva dem snart!"
            ],
            commonSymptoms: [
                "Ökat tryck nedåt i bäckenet.",
                "Lättare att andas om bebisen har sjunkit ner.",
                "Ökad flytning, ibland med lite blod (slemproppen)."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 36 – nu är det snart dags! Spänningen är påtaglig.",
                consensus: "Diskussioner om tecken på att förlossningen närmar sig och nervositet inför den stora dagen.",
                quotes: [
                    "\"Tappade slemproppen idag! Betyder det att förlossningen är nära?\"",
                    "\"Bebisen har sjunkit ner – kan andas igen men måste kissa varje halvtimme.\"",
                    "\"Fyra veckor kvar. Är livrädd och superexalterad samtidigt. Någon annan som känner så?\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 37
        PregnancyWeekContent(
            id: 37,
            week: 37,
            trimester: 3,
            fetalSizeComparison: "En mangold",
            fetalWeightGrams: "2860 g",
            fetalLengthCM: "48,6 cm",
            sfSymbol: "checkmark.seal.fill",
            motherChanges: [
                "Bebisen räknas nu som fullgången! Du kan föda när som helst.",
                "Livmoderhalsen kan börja vidga sig – barnmorskan kan kontrollera detta.",
                "Du kan uppleva att du har mer energi plötsligt – nestinginstinkten kan slå till på nytt.",
                "Sömnen kan vara mycket svår – blanda av kissbehov, smärta och spänning."
            ],
            fetalDevelopment: [
                "Fostret är nu fullgånget och redo att födas!",
                "Lungorna är mogna och producerar tillräckligt med surfaktant.",
                "Hjärnan och nervsystemet fortsätter utvecklas men alla livsviktiga funktioner är på plats.",
                "Fostret väger i genomsnitt 2,8-3 kg och är cirka 48-49 cm långt."
            ],
            tips: [
                "Ha telefonen laddad och nära till hands – det kan vara dags när som helst.",
                "Känn efter skillnaden mellan Braxton Hicks och riktiga värkar: riktiga värkar blir starkare och mer regelbundna.",
                "Njut av de sista stunderna som gravid – snart ändras livet för alltid!"
            ],
            commonSymptoms: [
                "Tätare sammandragningar som kan kännas mer intensiva.",
                "Ökad flytning och möjlig blodtillblandad slem.",
                "Oro och spänning inför förlossningen."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 37 – fullgången! Forumet bubblar av förväntan.",
                consensus: "Alla diskuterar tecken på förlossningsstart och delar sina sista graviditetserfarenheter.",
                quotes: [
                    "\"Fullgången! Nu kan bebisen komma när som helst. Varje gång jag känner en sammandragning tänker jag 'är det nu?'\"",
                    "\"Barnmorskan sa att livmoderhalsen börjat mjukna. Det närmar sig!\"",
                    "\"Nestinginstinkten slog till igen – städade hela huset klockan tre på natten.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 38
        PregnancyWeekContent(
            id: 38,
            week: 38,
            trimester: 3,
            fetalSizeComparison: "En purjolök",
            fetalWeightGrams: "3080 g",
            fetalLengthCM: "49,8 cm",
            sfSymbol: "timer.circle.fill",
            motherChanges: [
                "Du kan känna dig övermätt av att vara gravid – det är helt normalt att längta nu.",
                "Sammandragningarna kan bli mer regelbundna – var uppmärksam på mönstret.",
                "Bäckenet kan kännas väldigt löst och instabilt.",
                "Du kan uppleva diarré som ett tecken på att kroppen förbereder sig."
            ],
            fetalDevelopment: [
                "Fostret fortsätter bygga upp fettreserver – ungefär 30 gram fett per dag.",
                "Mekonium (det första bajset) har samlats i tarmarna och kan vara mörkt grönt/svart.",
                "Fostrets immunsystem får antikroppar via moderkakan som skyddar de första månaderna.",
                "Allt är redo – fostret väntar bara på rätt ögonblick att komma ut."
            ],
            tips: [
                "Tidsbestäm sammandragningarna: när de kommer regelbundet var 5:e minut i minst en timme, ring förlossningen.",
                "Gå promenader – det kan hjälpa att få igång förlossningen naturligt.",
                "Njut av stillheten innan stormen – det blir fantastiskt men också omvälvande."
            ],
            commonSymptoms: [
                "Oregelbundna sammandragningar som kan vara både Braxton Hicks och förvärkar.",
                "Diarré och lös mage – kroppens sätt att 'rensa'.",
                "Extrem trötthet blandad med plötsliga energikickar."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 38 – otåligheten stiger och alla vill att bebisen ska komma.",
                consensus: "Naturliga igångsättningstips delas frikostigt – allt från långa promenader till kryddstark mat.",
                quotes: [
                    "\"Två veckor kvar till BF men jag är SÅ redo. Kom nu, lilla bebis!\"",
                    "\"Gick en lång promenad, åt starkcurry och tog ett varmt bad. Inget hände. Bebisen bestämmer tydligen själv.\"",
                    "\"Hade sammandragningar hela natten men de försvann på morgonen. Så frustrerande!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 39
        PregnancyWeekContent(
            id: 39,
            week: 39,
            trimester: 3,
            fetalSizeComparison: "En liten vattenmelon",
            fetalWeightGrams: "3290 g",
            fetalLengthCM: "50,7 cm",
            sfSymbol: "hourglass.bottomhalf.filled",
            motherChanges: [
                "Kroppen är fullt förberedd för förlossningen – livmoderhalsen kan ha börjat öppna sig.",
                "Du kan uppleva en burst av energi (nesting) eller djup trötthet.",
                "Slemproppen kan lossna om den inte redan gjort det.",
                "Varje värk analyseras: är det nu? Spänningen är enorm."
            ],
            fetalDevelopment: [
                "Fostret är fullt utvecklat och redo för livet utanför livmodern.",
                "Hjärnan har utvecklats enormt men fortsätter växa långt efter födseln.",
                "Lungorna är redo att ta sitt första andetag.",
                "Fostrets binjurar producerar cortisol som hjälper lungorna att förbereda sig."
            ],
            tips: [
                "Vila så mycket du kan – du kommer behöva all energi under förlossningen.",
                "Ha sjukhusväskan vid dörren och tanken full på bilen.",
                "Kontakta BB om du får vattenavgång, regelbundna sammandragningar eller färsk blödning."
            ],
            commonSymptoms: [
                "Tryck nedåt i bäckenet som om bebisen pressar sig ut.",
                "Sammandragningar som kan vara förväxlande lika riktiga värkar.",
                "Emotionell berg-och-dalbana – du kan gå från upprymd till tårfylld på minuter."
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 39 – förlossningen kan starta vilken stund som helst.",
                consensus: "Alla delar tecken på förlossningsstart och stöttar varandra i den sista väntan.",
                quotes: [
                    "\"BF om en vecka. Sover med telefonen i handen och väskan i hallen. REDO!\"",
                    "\"Hade sammandragningar var 7:e minut i två timmar. Sen slutade de. Min kropp retar mig.\"",
                    "\"Kan inte sluta gråta av lycka och nervositet. Snart är vi en familj!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 40
        PregnancyWeekContent(
            id: 40,
            week: 40,
            trimester: 3,
            fetalSizeComparison: "En vattenmelon",
            fetalWeightGrams: "3460 g",
            fetalLengthCM: "51,2 cm",
            sfSymbol: "star.circle.fill",
            motherChanges: [
                "Beräknat förlossningsdatum (BF) är här! Bara 5% av bebisar föds exakt på BF.",
                "Du kan känna starka sammandragningar som kan vara starten på förlossningen.",
                "Kroppen producerar prostaglandiner som mjukar upp livmoderhalsen.",
                "Du kan uppleva att vattenavgång sker – ring BB direkt om det händer."
            ],
            fetalDevelopment: [
                "Bebisen är helt redo att födas och är i genomsnitt 3,3-3,5 kg och 50-52 cm.",
                "Alla reflexer är på plats: gripreflex, sugreflex, mororeflex.",
                "Bebisen har hunnit bygga upp tillräckliga fettreserver.",
                "Lungorna producerar surfaktant i tillräcklig mängd för andning i rumsluften."
            ],
            tips: [
                "Om förlossningen inte startar spontant, diskuterar barnmorskan eventuell igångsättning efter vecka 41.",
                "Försök att vara så avslappnad som möjligt – stress kan hämma värkarbete.",
                "Ring förlossningen om: vattenavgång, sammandragningar var 5:e minut, färsk blödning eller om du känner dig orolig."
            ],
            commonSymptoms: [
                "Starka, regelbundna sammandragningar om förlossningen startar.",
                "Vattenavgång – kan vara en skvätt eller ett flöde.",
                "Oro och iver – nu är det dags!"
            ],
            prenatalVisit: nil,
            forumSection: PregnancyForumSection(
                intro: "Vecka 40 – BF-veckan! Forumet exploderar av förlossningsberättelser.",
                consensus: "De som fött delar sina förlossningsberättelser och inspirerar de som väntar.",
                quotes: [
                    "\"BF idag och INGENTING händer. Bebisen trivs tydligen där inne. Heeelp!\"",
                    "\"Vattenavgång klockan 03 inatt! Vi är på väg till sjukhuset! Nästa gång jag skriver har vi en bebis!\"",
                    "\"Vår dotter föddes igår kväll. Det mest magiska ögonblicket i mitt liv. Värt varje sekund av väntan.\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 41
        PregnancyWeekContent(
            id: 41,
            week: 41,
            trimester: 3,
            fetalSizeComparison: "En stor vattenmelon",
            fetalWeightGrams: "3600 g",
            fetalLengthCM: "51,7 cm",
            sfSymbol: "calendar.badge.clock",
            motherChanges: [
                "Du har passerat BF – det är helt normalt och inget att oroa sig för.",
                "Barnmorskan följer dig tätare nu med CTG-kontroller av bebisens hjärtljud.",
                "Kroppen kan försöka starta förlossningen med starkare övningsvärkar.",
                "Emotionellt kan det vara tufft att vänta – omgivningens frågor slutar aldrig."
            ],
            fetalDevelopment: [
                "Bebisen fortsätter växa sakta men säkert – en överburen bebis kan vara lite större.",
                "Huden kan vara lite torrare och mer skrynklig nu när vernixet absorberats.",
                "Naglarna kan vara långa – vissa bebisar har repor i ansiktet redan vid födseln.",
                "Bebisen mår bra – moderkakan fungerar fortfarande väl."
            ],
            tips: [
                "Gå på alla inbokade kontroller – övervakning är viktig efter BF.",
                "Försök att inte stressa – de flesta förlossningar startar spontant före vecka 42.",
                "Diskutera igångsättning med din barnmorska – det erbjuds ofta från vecka 41+3 till 42."
            ],
            commonSymptoms: [
                "Frustration och otålighet – helt begripligt!",
                "Starka Braxton Hicks som kan förväxlas med riktiga värkar.",
                "Trötthet och tyngdkänsla i hela kroppen."
            ],
            prenatalVisit: "Överburenhetskontroll (vecka 41+): Tätare kontroller med CTG (hjärtljudsövervakning) och eventuellt ultraljud för att kontrollera fostervattenmängden. Igångsättning diskuteras och planeras vanligtvis vid vecka 41+3 till 42.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 41 – att vänta efter BF kan vara den svåraste väntan.",
                consensus: "Solidaritet och stöd mellan de överblivna – alla förstår frustrationen.",
                quotes: [
                    "\"41+2 och jag har slutat svara på 'har det hänt något?' från alla jag känner.\"",
                    "\"Blev inbokad för igångsättning på tisdag om inget händer innan dess. Lättad att det finns en deadline.\"",
                    "\"Gick igång spontant i 41+1! Värda hela väntan. Vår son är perfekt!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        ),

        // MARK: - Vecka 42
        PregnancyWeekContent(
            id: 42,
            week: 42,
            trimester: 3,
            fetalSizeComparison: "En jackfrukt",
            fetalWeightGrams: "3700 g",
            fetalLengthCM: "52 cm",
            sfSymbol: "heart.circle.fill",
            motherChanges: [
                "De flesta har blivit igångsatta eller fött innan vecka 42 – du är i trygga händer.",
                "Om du inte redan fött, sker igångsättning med medicinsk hjälp denna vecka.",
                "Kroppen är maximalt förberedd – livmoderhalsen är troligen mjuk och redo.",
                "Emotionellt kan du känna allt från frustration till stor förväntan."
            ],
            fetalDevelopment: [
                "Bebisen är fullt mogen och redo att möta världen.",
                "Huden kan vara torr och flagnande eftersom vernixet har absorberats helt.",
                "Naglarna kan vara långa och behöva klippas strax efter födseln.",
                "Bebisen är alert och redo – alla sinnen fungerar fullt ut."
            ],
            tips: [
                "Lita på vårdteamet – de har stor erfarenhet av överburen graviditet.",
                "Igångsättning kan ta tid – var förberedd på att det kan ta 1-3 dagar.",
                "Snart möter du din bebis – det blir det mest fantastiska ögonblicket i ditt liv!"
            ],
            commonSymptoms: [
                "Trötthet och emotionell utmattning av väntan.",
                "Starka sammandragningar om förlossningen har startat.",
                "Längtan och iver – det är äntligen dags."
            ],
            prenatalVisit: "Igångsättning (vecka 42): Om förlossningen inte startat spontant, sätts den igång med hinnsprängning, prostaglandingel eller oxytocindropp. Du övervakas noggrant under hela processen.",
            forumSection: PregnancyForumSection(
                intro: "Vecka 42 – de allra sista dagarna av graviditeten.",
                consensus: "Stöd och empati från de som varit i samma situation – alla hejar på de sista väntande.",
                quotes: [
                    "\"42+0 idag. Blev igångsatt imorse. Hormongel och nu väntar vi på att det ska ta fart!\"",
                    "\"Vår dotter ville inte komma frivilligt men efter igångsättning kom hon efter 8 timmar. Underbar!\"",
                    "\"Till alla som väntar: det tar slut, jag lovar. Och det är värt varenda minut av väntan. Ni kommer klara det!\""
                ],
                source: "Familjeliv.se – Graviditet"
            )
        )
    ]
}
