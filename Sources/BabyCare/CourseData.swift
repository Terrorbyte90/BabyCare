import SwiftUI

// MARK: - Course Models

struct CourseModule: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let icon: String
    let introduction: String
    let keyPoints: [String]
    let examples: [CourseExample]
    let exercise: CourseExercise
    let reflectionQuestions: [String]
    let forumSection: CourseForumSection
    let readingTimeMinutes: Int
}

struct CourseExample {
    let scenario: String
    let wrongApproach: String
    let rightApproach: String
    let explanation: String
}

struct CourseExercise {
    let title: String
    let description: String
    let steps: [String]
    let duration: String
}

struct CourseForumSection {
    let intro: String
    let consensus: String
    let quotes: [String]
    let source: String

    var asArticleForumSection: ArticleForumSection {
        ArticleForumSection(intro: intro, consensus: consensus, quotes: quotes, source: source)
    }
}

struct Course: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let description: String
    let icon: String
    let gradient: LinearGradient
    let modules: [CourseModule]
    let targetAudience: String
    let estimatedWeeks: Int
}

// MARK: - All Courses

extension Course {
    static let all: [Course] = [
        Course.merKarlek,
        Course.tryggaAnknytningen,
        Course.somnUtanTarar,
        Course.startenMedMat,
        Course.forstaAretsUtveckling,
        Course.amningGuide,
        Course.forlossningsForberedelse,
        Course.bebisenForstaAret,
        Course.fertilitetKropp,
        Course.babySomn,
        Course.livetSomNyForalder,
        Course.abcModellen,
        Course.cosTryggBas,
        Course.pmtoPrinciper,
        Course.cpsSamarbete,
        Course.emotionCoaching,
        Course.coreglering,
        Course.autonomistod,
        Course.temperamentGoodFit,
        Course.sprakbad,
        Course.lekOchScaffolding,
        Course.syskonRelationer,
        Course.skarmPlan,
        Course.satterDOR,
        Course.responsiveFeeding,
        Course.pottraningMognad,
        Course.kvallsrutin,
        Course.coParentingMentalLoad,
        Course.foraldraBurnout,
        Course.konfliktReparation,
        Course.aktivtFaderskap
    ]
    static var allCourses: [Course] { all }
}

// MARK: - Course 1: Mer Kärlek

extension Course {
    static let merKarlek = Course(
        id: "mer-karlek",
        title: "Mer Kärlek",
        subtitle: "Fem gånger mer kärlek i vardagen",
        description: "En evidensbaserad kurs inspirerad av Martin Forsters forskning om positiv föräldraskap. Lär dig att bygga en starkare relation med ditt barn genom att öka det positiva samspelet i vardagen.",
        icon: "heart.fill",
        gradient: LinearGradient(colors: [Color(hex: "FF375F"), Color(hex: "FF6B8A")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            // Module 1
            CourseModule(
                id: "mk-1",
                title: "Grundprincipen: 5:1-regeln",
                subtitle: "Fem positiva interaktioner för varje negativ",
                icon: "hand.thumbsup.fill",
                introduction: """
                Forskning visar att relationer som fungerar väl har en gemensam nämnare: det finns minst fem positiva interaktioner för varje negativ. Detta gäller i alla relationer, men är särskilt viktigt i relationen mellan förälder och barn. När barnet upplever att vardagen till största delen består av värme, uppmuntran och glädje, blir det lättare att hantera de stunder då konflikter uppstår.

                Martin Forster, psykolog och forskare, har visat att många föräldrar omedvetet hamnar i ett mönster där de framför allt reagerar på det som går fel. Det är mänskligt – vi är biologiskt programmerade att uppmärksamma hot och problem. Men resultatet blir att barnet får mest uppmärksamhet för negativa beteenden, medan det positiva tas för givet. 5:1-regeln handlar om att medvetet vända på detta mönster.

                I den här modulen får du lära dig hur du kan börja räkna och öka antalet positiva interaktioner i din vardag. Det handlar inte om att vara perfekt eller att aldrig säga nej, utan om att skapa en grundton av kärlek och uppskattning som bär genom hela dagen.
                """,
                keyPoints: [
                    "Relationer mår bäst med minst 5 positiva interaktioner för varje negativ",
                    "Positiva interaktioner kan vara små: ett leende, en klapp, ett vänligt ord",
                    "Barn som får mycket positiv uppmärksamhet blir mer samarbetsvilliga",
                    "Det handlar inte om att undvika gränssättning, utan om att öka det positiva",
                    "Förändringen börjar med att bli medveten om ditt nuvarande mönster"
                ],
                examples: [
                    CourseExample(
                        scenario: "Treåriga Ella ritar vid köksbordet medan du lagar mat. Hon har suttit lugnt i tio minuter.",
                        wrongApproach: "Du säger ingenting medan hon sitter lugnt, men reagerar direkt med 'Sluta!' när hon börjar rita på bordet.",
                        rightApproach: "Du kommenterar under tiden hon ritar: 'Åh, vilka fina färger du valt! Jag ser att du ritar riktigt koncentrerat.' När hon sedan ritar på bordet säger du lugnt: 'Vi ritar på pappret, inte bordet. Här, ta det här stora pappret.'",
                        explanation: "Genom att uppmärksamma det positiva beteendet först bygger du en bank av goda interaktioner. När du sedan behöver korrigera, gör du det i en kontext av värme."
                    ),
                    CourseExample(
                        scenario: "Fyraårige Oscar klär på sig på morgonen. Han lyckas ta på sig tröjan själv men sätter på sig skorna på fel fot.",
                        wrongApproach: "Du suckar och säger: 'Nej, skorna sitter fel igen. Kan du aldrig lära dig?'",
                        rightApproach: "Du säger: 'Wow, du tog på tröjan helt själv idag! Det var fantastiskt! Ska vi titta på skorna tillsammans? Det finns ett knep – de ska kramas med varandra på insidan.'",
                        explanation: "Genom att först lyfta det som gick bra (tröjan) innan du hjälper till med det som blev fel (skorna), behåller du en positiv atmosfär och stärker barnets självkänsla."
                    ),
                    CourseExample(
                        scenario: "Syskon leker tillsammans i vardagsrummet. De har lekt fint i tjugo minuter men börjar nu bråka om en leksak.",
                        wrongApproach: "Du har suttit med telefonen och reagerar först nu: 'Sluta bråka! Ni kan väl inte leka snällt en enda gång?'",
                        rightApproach: "Under tiden de lekte fint sa du vid flera tillfällen: 'Vad roligt att ni leker så bra ihop! Jag ser att ni turas om.' När bråket uppstår: 'Jag förstår att ni båda vill ha den. Ni lekte så fint nyss – kan vi hitta ett sätt att lösa det?'",
                        explanation: "När du redan har 'satt in' positiva kommentarer under leken, har du skapat en grund att stå på. Barnen vet att du ser dem när det går bra, inte bara när det går fel."
                    )
                ],
                exercise: CourseExercise(
                    title: "Räkna dina interaktioner",
                    description: "Under en dag ska du medvetet räkna hur många positiva respektive negativa interaktioner du har med ditt barn. Använd två enkla streck-listor – en för plus och en för minus.",
                    steps: [
                        "Välj en vanlig vardag att observera dig själv",
                        "Ha ett papper eller din telefon redo att notera",
                        "Varje gång du säger något positivt, ger en kram, ler mot barnet eller visar uppskattning – gör ett plus-streck",
                        "Varje gång du tillrättavisar, säger nej, suckar eller visar irritation – gör ett minus-streck",
                        "Räkna ihop i slutet av dagen och beräkna kvoten",
                        "Sikta på att nästa dag medvetet lägga till tre extra positiva interaktioner"
                    ],
                    duration: "En hel dag"
                ),
                reflectionQuestions: [
                    "Hur ser din 5:1-kvot ut just nu? Blev du förvånad över resultatet?",
                    "I vilka situationer är det lättast för dig att vara positiv med ditt barn?",
                    "Finns det tidpunkter på dagen då du märker att du är mer negativ?",
                    "Vad skulle hända om du medvetet valde att kommentera en positiv sak ditt barn gör varje morgon?"
                ],
                forumSection: CourseForumSection(
                    intro: "Många föräldrar som börjat räkna sina interaktioner har blivit förvånade – ofta åt båda hållen.",
                    consensus: "De flesta upplever att bara medvetenheten om 5:1-regeln gör skillnad. Att aktivt leta efter positiva saker att säga förändrar hela stämningen hemma.",
                    quotes: [
                        "\"Jag trodde jag var en positiv förälder, men när jag räknade låg jag på 2:1. Det var en ögonöppnare!\" – Sara, mamma till två",
                        "\"Första veckan var jag tvungen att nästan tvinga mig att kommentera det positiva. Nu kommer det naturligt.\" – Erik, pappa till Elias 4 år",
                        "\"Mitt barn frågade varför jag var så glad hela tiden. Det var lite sorgligt att hon lade märke till skillnaden.\" – Linda, mamma till Wilma 5 år"
                    ],
                    source: "Inspirerat av Martin Forsters forskning om positiva föräldrastrategier"
                ),
                readingTimeMinutes: 12
            ),
            // Module 2
            CourseModule(
                id: "mk-2",
                title: "Uppmärksamhet och närvaro",
                subtitle: "Konsten att verkligen se ditt barn",
                icon: "eye.fill",
                introduction: """
                Barn har ett grundläggande behov av att bli sedda. Inte bara fysiskt, utan känslomässigt. När vi verkligen riktar vår uppmärksamhet mot barnet – utan telefon, utan att tänka på annat – sänder vi ett kraftfullt budskap: du är viktig, du är värd min tid, jag bryr mig om dig. Denna typ av uppmärksamhet är som näring för barnets självkänsla.

                I dagens samhälle är det lätt att vara fysiskt närvarande men mentalt frånvarande. Telefonen pingar, tankarna vandrar till jobbmejl, middagsplaneringen tar över. Barn är otroligt känsliga för detta – de märker skillnaden mellan en förälder som nickar frånvarande och en som verkligen lyssnar och engagerar sig. Forskning visar att kvaliteten på uppmärksamheten är viktigare än kvantiteten.

                Att vara närvarande handlar inte om att ägna varje vaken minut åt barnet. Det handlar om att skapa stunder av äkta närvaro, där barnet har din fulla uppmärksamhet. Redan 10-15 minuter om dagen av helhjärtad närvaro kan göra en enorm skillnad.
                """,
                keyPoints: [
                    "Kvaliteten på uppmärksamheten är viktigare än mängden tid",
                    "Barn märker direkt om du är mentalt frånvarande",
                    "Ögonkontakt och fysisk närhet förstärker känslan av att bli sedd",
                    "Att beskriva vad barnet gör ('Jag ser att du bygger ett torn') är en form av uppmärksamhet",
                    "Redan 10-15 minuter av helhjärtad närvaro per dag gör stor skillnad"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn kommer hem från förskolan och vill berätta om sin dag.",
                        wrongApproach: "Du scrollar på telefonen och säger 'Mm, vad kul' utan att titta upp.",
                        rightApproach: "Du lägger ner telefonen, sätter dig på huk så ni får ögonkontakt och säger: 'Berätta! Jag vill höra allt om din dag.' Du ställer följdfrågor: 'Vad lekte du? Hur kände du dig då?'",
                        explanation: "Genom att fysiskt visa att du lyssnar – lägga ner telefonen, söka ögonkontakt, ställa frågor – visar du barnet att det som händer i dess värld är viktigt för dig."
                    ),
                    CourseExample(
                        scenario: "Ditt barn sitter och leker med klossar på golvet medan du viker tvätt.",
                        wrongApproach: "Du viker tvätten tyst i tio minuter utan att kommentera barnets lek.",
                        rightApproach: "Medan du viker tvätten kommenterar du ibland vad barnet gör: 'Åh, nu bygger du på höjden! Det tornet blir riktigt högt. Vilken kloss tror du passar bäst nu?'",
                        explanation: "Du behöver inte sluta med det du gör. Genom att med ord visa att du ser barnets lek, ger du uppmärksamhet även mitt i vardagssysslorna."
                    ),
                    CourseExample(
                        scenario: "Du hämtar på förskolan och ditt barn springer mot dig.",
                        wrongApproach: "Du pratar klart i telefon, vinkar åt barnet att vänta och avslutar samtalet medan barnet drar dig i armen.",
                        rightApproach: "Du avslutar samtalet snabbt eller ringer tillbaka senare. Du sätter dig på knä, öppnar armarna och säger: 'Hej älskling! Vad glad jag blir att se dig!'",
                        explanation: "Hämtningen är en av dagens viktigaste stunder. Hur du möter barnet signalerar hur viktigt det är för dig. Ett varmt, engagerat mottagande stärker anknytningen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Telefonfri kvart",
                    description: "Inför en daglig stund på 15 minuter där du lägger undan alla skärmar och ger barnet din odelade uppmärksamhet. Låt barnet bestämma aktiviteten.",
                    steps: [
                        "Välj en fast tid på dagen som passar (t.ex. direkt efter middag)",
                        "Lägg telefonen i ett annat rum – inte bara i fickan",
                        "Säg till barnet: 'Nu har vi vår speciella stund. Vad vill du att vi gör?'",
                        "Följ barnets ledning – lek det barnet vill leka",
                        "Beskriv vad barnet gör och visar: 'Jag ser att du...' och 'Berätta mer!'",
                        "Håll fast vid detta i minst en vecka och observera vad som händer"
                    ],
                    duration: "15 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Hur ofta under dagen har du verkligen ögonkontakt med ditt barn?",
                    "Vad händer med dig när du lägger ner telefonen och bara är närvarande?",
                    "Hur reagerar ditt barn när det får din odelade uppmärksamhet?",
                    "Vilka rutiner eller vanor hindrar dig från att vara närvarande?"
                ],
                forumSection: CourseForumSection(
                    intro: "Övningen med telefonfri kvart har fått stor respons bland föräldrarna i kursen.",
                    consensus: "Många föräldrar beskriver att barnen först blev misstänksamma men sedan helt förändrades. En återkommande kommentar är att barnen blev lugnare även resten av kvällen.",
                    quotes: [
                        "\"Min son frågade 'Mamma, varför tittar du på mig hela tiden?' första gången. Dag tre bad han om 'vår speciella stund' redan vid frukost.\" – Anna, mamma till Liam 3 år",
                        "\"Jag insåg att jag kollade telefonen 80+ gånger per dag. Nu lägger jag den i hallen när jag kommer hem.\" – Jonas, pappa till Maja 5 år",
                        "\"Det svåraste var att bara sitta och leka plastdjur i 15 minuter utan att kolla klockan. Men barnets glädje var värd det.\" – Camilla, mamma till tvillingar 4 år"
                    ],
                    source: "Baserat på forskning om närvarande föräldraskap och uppmärksamhetens betydelse"
                ),
                readingTimeMinutes: 10
            ),
            // Module 3
            CourseModule(
                id: "mk-3",
                title: "Beröm som fungerar",
                subtitle: "Skillnaden mellan process- och resultatberöm",
                icon: "star.fill",
                introduction: """
                Alla föräldrar vill uppmuntra sina barn, men forskningen visar att hur vi berömmer spelar enorm roll. Carol Dwecks banbrytande forskning om growth mindset visar att barn som får beröm för sina ansträngningar utvecklar mer uthållighet och motivation än barn som bara hör att de är 'duktiga' eller 'smarta'. Det handlar om att flytta fokus från resultatet till processen.

                Processberöm beskriver vad barnet gör: 'Du jobbade verkligen hårt med det där pusslet!' medan resultatberöm bedömer barnet: 'Vad duktig du är!' Skillnaden kan verka liten, men effekten är stor. Barn som hör att de är 'smarta' blir ofta rädda för att misslyckas, medan barn som hör att deras ansträngning uppskattas vågar ta sig an svårare utmaningar.

                I den här modulen får du konkreta verktyg för att byta ut tomma fraser mot beröm som verkligen bygger ditt barns inre motivation och självkänsla. Du kommer att märka att det ibland kräver att du saktar ner och verkligen observerar vad barnet faktiskt gör.
                """,
                keyPoints: [
                    "Processberöm ('Du ansträngde dig verkligen!') bygger uthållighet",
                    "Resultatberöm ('Vad duktig du är!') kan skapa prestationsångest",
                    "Beskriv specifikt vad du ser istället för att bedöma",
                    "Beröm ansträngning, strategi och framsteg – inte bara slutresultat",
                    "Äkta beröm kräver att du verkligen observerar vad barnet gör"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet visar en teckning det gjort på förskolan.",
                        wrongApproach: "Du säger automatiskt: 'Åh vad fint! Du är en riktig konstnär! Det är den finaste teckningen jag sett!'",
                        rightApproach: "Du tittar på teckningen och säger: 'Jag ser att du använt massor av olika färger! Berätta om din teckning – vad är det här? Jag ser att du ritat riktigt noga här i hörnet.'",
                        explanation: "Genom att beskriva vad du ser och be barnet berätta, visar du genuint intresse. Barnet lär sig att värdera sin egen process istället för att bli beroende av yttre bekräftelse."
                    ),
                    CourseExample(
                        scenario: "Barnet klättrar upp för klätterställningen för första gången men vågar inte klättra ner.",
                        wrongApproach: "Du säger: 'Du är så modig! Spring ner bara, det är lätt!'",
                        rightApproach: "Du säger: 'Wow, du klättrade hela vägen upp! Jag såg att du tog ett handtag i taget och var riktigt fokuserad. Ska vi fundera ut hur du kan ta dig ner? Du kan prova att sätta foten på det steget först.'",
                        explanation: "Istället för att kalla barnet modigt (egenskap) eller avfärda rädslan, bekräftar du ansträngningen och hjälper barnet hitta en strategi. Det bygger äkta tillit till den egna förmågan."
                    ),
                    CourseExample(
                        scenario: "Barnet har övat på att skriva sitt namn och visar resultatet – bokstäverna är ojämna och spegelvänt.",
                        wrongApproach: "Du säger: 'Bra jobbat! Men E:et ska åt andra hållet, titta här.' och rättar direkt.",
                        rightApproach: "Du säger: 'Du har övat jättemycket! Jag kan se att du vet vilka bokstäver som ska vara med. Förra veckan kunde du bara L och nu kan du nästan alla! Vill du att vi övar tillsammans?'",
                        explanation: "Du fokuserar på framstegen (förra veckan vs nu) och ansträngningen (att öva) istället för att rätta felet. Barnet känner sig uppmuntrat att fortsätta öva."
                    )
                ],
                exercise: CourseExercise(
                    title: "Byt ut tre fraser",
                    description: "Under en vecka ska du medvetet byta ut tre vanliga beröm-fraser mot processberöm. Skriv ner de nya fraserna och ha dem synliga (t.ex. på kylskåpet).",
                    steps: [
                        "Identifiera tre fraser du ofta säger (t.ex. 'Vad duktig du är!', 'Bra jobbat!', 'Vad fint!')",
                        "Skriv alternativa processberöm: 'Du ansträngde dig!', 'Jag ser att du provade olika sätt!', 'Berätta hur du gjorde!'",
                        "Sätt lappen synligt hemma som en påminnelse",
                        "Använd de nya fraserna medvetet under en vecka",
                        "Lägg märke till hur barnet reagerar annorlunda",
                        "Skriv ner dina observationer varje kväll"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vilken typ av beröm fick du själv som barn? Hur påverkade det dig?",
                    "Känner du dig ibland tom på ord när du ska berömma? Vad kan du göra åt det?",
                    "Hur reagerar ditt barn när du beskriver vad du ser istället för att bedöma?",
                    "Finns det situationer där resultatberöm smyger sig in? Vilka?"
                ],
                forumSection: CourseForumSection(
                    intro: "Övergången från 'Vad duktig du är!' till processberöm är en av de mest diskuterade förändringarna i kursen.",
                    consensus: "De flesta föräldrar upplever att det känns konstigt i början men att barnen snabbt börjar berätta mer om sina processer och verkar stoltare över sina ansträngningar.",
                    quotes: [
                        "\"Min dotter slutade fråga 'Är den fin?' om sina teckningar och började istället berätta historier om dem. Fantastisk skillnad!\" – Malin, mamma till Saga 4 år",
                        "\"Det svåraste var att sluta säga 'bra jobbat' automatiskt. Jag hade en kompis som påminde mig varje gång.\" – David, pappa till Noel 3 år",
                        "\"Nu säger min son 'Jag övade jättemycket!' istället för att fråga 'Är jag duktig?'. Det värmer.\" – Frida, mamma till Theo 5 år"
                    ],
                    source: "Baserat på Carol Dwecks forskning om growth mindset och Martin Forsters tillämpning"
                ),
                readingTimeMinutes: 11
            ),
            // Module 4
            CourseModule(
                id: "mk-4",
                title: "Hantera konflikter utan maktkamp",
                subtitle: "Så bryter du mönstret av tjat och motstånd",
                icon: "arrow.triangle.branch",
                introduction: """
                Konflikter mellan föräldrar och barn är oundvikliga – och faktiskt helt naturliga. Barn behöver testa gränser för att förstå världen och utveckla sin autonomi. Problemet uppstår när konflikterna eskalerar till maktkamper där båda parter gräver ner sig i sina positioner. I en maktkamp finns inga vinnare: antingen 'vinner' föräldern genom att utöva makt och barnet känner sig maktlöst, eller så 'vinner' barnet och föräldern tappar auktoritet.

                Nyckeln är att se konflikter som samarbetsproblem istället för strider. När du närmar dig en konflikt med inställningen 'Vi har ett problem som vi behöver lösa tillsammans' istället för 'Du ska lyda mig' förändras dynamiken helt. Barnet känner sig respekterat och är mer benäget att samarbeta. Det betyder inte att du ger efter – det betyder att du hittar sätt att hålla fast vid viktiga gränser utan att det blir en kamp.

                I den här modulen lär du dig konkreta strategier för att avväpna maktkamper, erbjuda valmöjligheter inom tydliga ramar och använda humor och distraktioner för att navigera genom vardagens konflikter med relationen intakt.
                """,
                keyPoints: [
                    "Se konflikter som samarbetsproblem, inte strider att vinna",
                    "Erbjud valmöjligheter inom tydliga ramar: 'Vill du borsta tänderna före eller efter pyjamas?'",
                    "Undvik att eskalera genom att sänka rösten istället för att höja den",
                    "Humor och lekfullhet kan avväpna de flesta maktkamper",
                    "Välj dina strider – inte allt är värt en konflikt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Treåringen vägrar ta på sig jackan när ni ska gå ut. Det är kallt ute.",
                        wrongApproach: "Du säger bestämt: 'Du SKA ha jackan på dig! Punkt slut!' Barnet skriker, du tvingar på jackan.",
                        rightApproach: "Du säger: 'Det är kallt ute idag. Vill du ha den blå eller den röda jackan? Eller vill du bära jackan ut och ta på dig den vid dörren?' Om barnet fortfarande vägrar: 'Okej, vi tar med jackan. Jag tror att du kommer vilja ha den när du känner hur kallt det är.'",
                        explanation: "Genom att erbjuda val ger du barnet en känsla av kontroll. Att ta med jackan istället för att tvinga på den undviker maktkampen och låter verkligheten (kylan) göra jobbet."
                    ),
                    CourseExample(
                        scenario: "Fyraåringen vill inte sluta titta på surfplattan trots att tiden är slut.",
                        wrongApproach: "Du rycker plattan ur händerna och säger: 'Nu räcker det! Du får aldrig titta mer om du inte slutar direkt!'",
                        rightApproach: "Du ger en förvarning fem minuter innan: 'Om fem minuter stänger vi plattan.' När tiden är slut: 'Nu är det dags. Vill du trycka på stoppknappen själv eller ska jag?' Om barnet protesterar: 'Jag vet att det är tråkigt att sluta mitt i. Vad ska vi göra härnäst – pussla eller rita?'",
                        explanation: "Förvarningen ger barnet tid att ställa in sig. Att låta barnet stänga av själv ger kontroll. Att validera känslan och erbjuda nästa aktivitet gör övergången smidigare."
                    ),
                    CourseExample(
                        scenario: "Femåringen protesterar högljutt i mataffären och vill ha godis.",
                        wrongApproach: "Du viskar argt: 'Sluta genast! Alla tittar på oss. Du får aldrig följa med igen!' Du köper godis för att barnet ska sluta.",
                        rightApproach: "Du går ner på barnets nivå och säger lugnt: 'Jag förstår att du vill ha godis – det ser gott ut! Men idag handlar vi det som står på listan. Du får gärna hjälpa mig hitta bananerna. Kan du se dem någonstans?'",
                        explanation: "Du validerar känslan utan att ge efter. Att ge barnet en uppgift i affären omdirigerar uppmärksamheten. Du behöver inte skämmas – alla föräldrar har varit där."
                    )
                ],
                exercise: CourseExercise(
                    title: "Valövningen",
                    description: "Under tre dagar ska du medvetet erbjuda valmöjligheter i stunder som brukar leda till maktkamper. Skriv ner vilka val du erbjuder och hur barnet reagerar.",
                    steps: [
                        "Identifiera tre återkommande konfliktsituationer (påklädning, mat, läggdags etc.)",
                        "Förbered två-tre val för varje situation som du kan leva med oavsett vad barnet väljer",
                        "Presentera valen lugnt och neutralt",
                        "Acceptera barnets val utan att kommentera",
                        "Notera hur situationen blev annorlunda",
                        "Utvärdera efter tre dagar: vilka val fungerade bäst?"
                    ],
                    duration: "Tre dagar"
                ),
                reflectionQuestions: [
                    "I vilka situationer hamnar du oftast i maktkamp med ditt barn?",
                    "Hur känns det i kroppen när du märker att en maktkamp håller på att börja?",
                    "Finns det situationer där du kan släppa kontrollen utan att det spelar roll?",
                    "Hur hanterade dina föräldrar konflikter? Gör du likadant eller tvärtom?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att sluta kämpa om jackor, skor och surfplattor – låter det som en utopi? Många föräldrar har hittat nya vägar.",
                    consensus: "Den stora insikten för de flesta är att erbjuda val inte är samma sak som att ge efter. Barnen blir faktiskt mer samarbetsvilliga när de känner att de har inflytande.",
                    quotes: [
                        "\"Jackstriden tog 20 minuter varje morgon. Nu säger jag 'Blå eller röd?' och vi är ute på 2 minuter.\" – Marcus, pappa till Astrid 3 år",
                        "\"Jag insåg att hälften av mina 'nej' var onödiga. Behöver det verkligen vara ett nej att ha olikfärgade strumpor?\" – Elin, mamma till Love 4 år",
                        "\"Min man och jag hade helt olika syn på detta. Kursen hjälpte oss hitta en gemensam linje som varken var för hård eller för mjuk.\" – Petra, mamma till tre"
                    ],
                    source: "Baserat på Ross Greenes samarbetsbaserade problemlösning och Martin Forsters principer"
                ),
                readingTimeMinutes: 12
            ),
            // Module 5
            CourseModule(
                id: "mk-5",
                title: "Naturliga konsekvenser",
                subtitle: "Låt verkligheten vara läraren",
                icon: "leaf.fill",
                introduction: """
                En av de mest effektiva pedagogiska principerna är att låta barn uppleva de naturliga konsekvenserna av sina val. När barnet vägrar ta på sig vantar och händerna blir kalla, lär det sig mer om varför vantar behövs än genom hundra förklaringar. Naturliga konsekvenser är inte bestraffning – de är livets egna lärdomar.

                Det viktiga är att skilja mellan naturliga konsekvenser och bestraffningar som förklädda konsekvenser. 'Om du inte äter upp får du inget mellanmål' är en bestraffning. 'Om du inte äter nu kanske du blir hungrig innan nästa måltid' är en naturlig konsekvens. Skillnaden ligger i tonen, intentionen och om konsekvensen verkligen hänger ihop med beteendet.

                Förstås finns det situationer där naturliga konsekvenser inte är lämpliga – när barnet kan skada sig, andra eller något värdefullt. Då behövs gränssättning. Men i vardagens alla små situationer kan naturliga konsekvenser avlasta dig som förälder enormt. Du slipper vara polisen och kan istället vara den som tröstar och hjälper barnet dra lärdomar av sina upplevelser.
                """,
                keyPoints: [
                    "Naturliga konsekvenser är inte bestraffning – de är verkligheten som lärare",
                    "Konsekvensen måste hänga ihop logiskt med beteendet",
                    "Använd aldrig naturliga konsekvenser när barnet kan skadas",
                    "Din roll är att vara stöd efteråt, inte att säga 'Vad var det jag sa?'",
                    "Barn lär sig bäst av egna erfarenheter, inte av föreläsningar",
                    "Undvik att rädda barnet från varje obehag – lagom frustration bygger motståndskraft"
                ],
                examples: [
                    CourseExample(
                        scenario: "Femåringen vägrar ta med regnkläder till förskolan trots att det ska regna.",
                        wrongApproach: "Du tvingar på regnkläderna och skapar en morgonkris, eller ger efter och packar ner dem i väskan åt barnet.",
                        rightApproach: "Du säger: 'Det ska regna idag. Jag tycker att regnkläderna är bra att ha, men du bestämmer. Vet du vad – vi lägger dem i din väska så kan du välja själv på förskolan.' (Och sedan: om barnet blir blött tröstar du utan att moralisera.)",
                        explanation: "Barnet får uppleva konsekvensen av att bli blött, men du finns där som stöd efteråt. Att lägga kläderna i väskan ger en utväg utan maktkamp. Att inte moralisera efteråt är avgörande."
                    ),
                    CourseExample(
                        scenario: "Barnet vägrar äta middag och vill ha glass istället.",
                        wrongApproach: "Du säger: 'Ingen glass förrän du ätit allt! Och om du inte äter får du gå hungrig i sängen!'",
                        rightApproach: "Du säger: 'Just nu är det middag. Jag ser att du inte är sugen just nu och det är okej. Maten finns kvar en stund till om du ändrar dig. Glass har vi inte idag, men det finns frukt om du blir hungrig senare.'",
                        explanation: "Du tvingar inte barnet att äta, skapar inget straff, men erbjuder inte heller glass som alternativ. Om barnet blir hungrigt senare är det en naturlig konsekvens – och du erbjuder en rimlig lösning."
                    ),
                    CourseExample(
                        scenario: "Sexåringen har glömt att lägga sina fotbollskläder i tvättkorgen och de är fortfarande smutsiga inför matchen.",
                        wrongApproach: "Du tvättar kläderna i panik på morgonen och klagar högt: 'Du glömmer alltid! Jag måste göra allt här hemma!'",
                        rightApproach: "Du säger: 'Åh, dina fotbollskläder är fortfarande smutsiga. Jag hinner inte tvätta dem nu. Vad tror du att vi kan göra? Du kan spela i de smutsiga eller ta ett annat par shorts.'",
                        explanation: "Barnet lär sig att handlingar har konsekvenser. Att hjälpa barnet problemlösa istället för att lösa allt åt det bygger ansvarskänsla. Nästa gång kommer barnet troligen ihåg tvättkorgen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Släpp en strid",
                    description: "Välj en återkommande konflikt där du kan låta den naturliga konsekvensen tala istället för att kontrollera utfallet. Observera vad som händer.",
                    steps: [
                        "Identifiera en situation där du brukar tjata eller kontrollera (kläder, mat, packning etc.)",
                        "Bestäm dig för att låta den naturliga konsekvensen ske (om det är säkert)",
                        "Informera barnet en gång, utan att tjata: 'Jag tror det blir kallt ute idag'",
                        "Låt barnet göra sitt val",
                        "Om den naturliga konsekvensen inträffar – trösta utan att moralisera",
                        "Notera hur det kändes för dig att släppa kontrollen"
                    ],
                    duration: "En till två dagar"
                ),
                reflectionQuestions: [
                    "Vilka situationer i din vardag skulle passa för naturliga konsekvenser?",
                    "Hur svårt är det för dig att låta ditt barn uppleva obehag?",
                    "Säger du ibland 'Vad var det jag sa?' – och hur tror du barnet upplever det?",
                    "Var går gränsen för dig mellan naturliga konsekvenser och att vara ansvarslös?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att släppa kontrollen och låta barnet lära sig av verkligheten är ofta en av de svåraste men mest befriande förändringarna för föräldrar.",
                    consensus: "Föräldrarna lyfter fram att det svåraste är att hålla tyst efteråt – att inte säga 'Jag sa ju det!'. Men de som lyckas med det märker att barnen börjar ta mer ansvar på egen hand.",
                    quotes: [
                        "\"Min son glömde matlådan tre dagar i rad. Fjärde dagen packade han den själv. Utan att jag sa ett ord.\" – Karin, mamma till Filip 6 år",
                        "\"Det är SÅ svårt att inte rädda dem hela tiden. Men jag ser att min dotter blivit mer självständig sedan jag backade.\" – Tobias, pappa till Signe 5 år",
                        "\"Bästa tipset jag fick: 'Trösta utan att moralisera.' Det förändrade allt.\" – Nina, mamma till Lo 4 år"
                    ],
                    source: "Baserat på Rudolf Dreikurs arbete om naturliga och logiska konsekvenser"
                ),
                readingTimeMinutes: 11
            ),
            // Module 6
            CourseModule(
                id: "mk-6",
                title: "Lyssna aktivt",
                subtitle: "Konsten att höra det barnet verkligen säger",
                icon: "ear.fill",
                introduction: """
                Att lyssna aktivt innebär mer än att bara höra orden ditt barn säger. Det handlar om att försöka förstå känslan bakom orden, att spegla tillbaka det du hör och att ge barnet utrymme att utforska sina egna tankar och känslor. Aktivt lyssnande är ett av de mest kraftfulla verktygen du har som förälder – det bygger förtroende, stärker relationen och hjälper barnet utveckla emotionell intelligens.

                Många föräldrar lyssnar med en lösningsfokuserad approach: barnet berättar om ett problem och föräldern hoppar direkt till att fixa det. Men ofta behöver barnet inte att du löser problemet – det behöver att du förstår hur det känns. När vi skyndar oss att fixa, ger vi omedvetet budskapet 'Det du känner är inte viktigt, det viktiga är att lösa det snabbt.' Ibland är den bästa lösningen att det inte finns någon lösning – bara en förälder som lyssnar.

                I den här modulen får du lära dig tekniker för aktivt lyssnande som du kan använda med barn i alla åldrar. Du kommer att bli förvånad över hur mycket ett barn kan säga när det känner sig verkligen hört.
                """,
                keyPoints: [
                    "Lyssna för att förstå, inte för att lösa eller svara",
                    "Spegla barnets känslor: 'Det låter som att du blev ledsen'",
                    "Ställ öppna frågor istället för ja/nej-frågor",
                    "Motstå impulsen att avbryta eller ge råd direkt",
                    "Tystnad är okej – ge barnet tid att tänka och formulera sig"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet kommer hem från förskolan och säger: 'Jag hatar förskolan! Ingen vill leka med mig!'",
                        wrongApproach: "Du säger: 'Det stämmer ju inte! Igår lekte du med Emma. Du måste vara snällare mot de andra barnen.'",
                        rightApproach: "Du sätter dig ner och säger: 'Det låter som att du haft en jobbig dag. Berätta vad som hände.' Du lyssnar utan att avbryta. 'Det måste ha känts ensamt att ingen ville vara med i din lek. Hur kändes det?'",
                        explanation: "Istället för att ifrågasätta barnets upplevelse validerar du känslan. 'Det stämmer ju inte' lär barnet att inte lita på sina egna känslor. 'Berätta vad som hände' ger utrymme att utforska."
                    ),
                    CourseExample(
                        scenario: "Fyraåringen gråter och säger: 'Du är dum! Jag vill inte ha dig!'",
                        wrongApproach: "Du säger sårat: 'Sådant säger man inte! Nu blir jag ledsen.' eller 'Om du fortsätter så går jag.'",
                        rightApproach: "Du stannar kvar och säger lugnt: 'Jag hör att du är jättearg just nu. Det är okej att vara arg, men det gör ont att höra de orden. Kan du berätta vad du egentligen är arg på?'",
                        explanation: "Barnet testar om du stannar kvar även när det är svårt. Genom att separera känslan (arg – okej) från beteendet (elaka ord – inte okej) och sedan hjälpa barnet hitta det riktiga problemet, visar du ovillkorlig kärlek."
                    ),
                    CourseExample(
                        scenario: "Sexåringen berättar upphetsat om en komplicerad lek med kompisarna som du inte riktigt förstår.",
                        wrongApproach: "Du nickar och säger 'Mm, mm' medan du gör annat, och avslutar med 'Vad roligt!'",
                        rightApproach: "Du lyssnar aktivt och ställer frågor: 'Vänta, så du var prinsessan och Wilma var draken? Och sedan hände det att riddarens häst kunde flyga? Vad spännande! Hur slutade det?'",
                        explanation: "Genom att ställa frågor som visar att du faktiskt lyssnar och försöker förstå, visar du barnet att dess värld är intressant och viktig. Det behöver inte vara ett 'problem' för att förtjäna aktivt lyssnande."
                    )
                ],
                exercise: CourseExercise(
                    title: "Lyssna utan att lösa",
                    description: "Under tre dagar ska du öva på att bara lyssna och spegla när ditt barn berättar något, utan att ge råd eller lösningar.",
                    steps: [
                        "När barnet berättar något, pausa och ta ett djupt andetag innan du svarar",
                        "Spegla tillbaka vad du hör: 'Så du menar att...' eller 'Det låter som att du kände...'",
                        "Ställ en öppen fråga: 'Berätta mer' eller 'Hur kände du dig då?'",
                        "Motstå impulsen att säga 'Men du kan ju bara...' eller ge råd",
                        "Om barnet ber om hjälp, fråga: 'Vad tror du att du kan göra?' innan du ger förslag",
                        "Notera hur barnet reagerar på att bli lyssnat på utan att få lösningar"
                    ],
                    duration: "Tre dagar"
                ),
                reflectionQuestions: [
                    "Hur ofta avbryter du ditt barn? Vad händer om du väntar lite längre?",
                    "Lyssnar du ibland mest för att kunna ge ditt svar? Hur kan du ändra det?",
                    "Hur känns det att bara lyssna utan att lösa?",
                    "Vilka signaler ger ditt barn när det känner sig riktigt hört?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att lyssna utan att lösa är svårare än det låter – de flesta föräldrar vill instinktivt fixa.",
                    consensus: "Gemensamt för föräldrarna i forumet är överraskningen över hur mycket barnen berättar när man bara lyssnar och ställer frågor, istället för att ge råd.",
                    quotes: [
                        "\"Min dotter pratade i 20 minuter om en konflikt med en kompis. Normalt avbryter jag efter 2 minuter med 'Men säg förlåt då!' Nu lyssnade jag och hon löste det helt själv i slutet.\" – Jessica, mamma till Ines 5 år",
                        "\"Det svåraste är att inte säga 'Men det är väl ingen fara!' Barns känslor är stora för dem, även om det verkar litet för oss.\" – Patrik, pappa till Albin 4 år",
                        "\"Jag testade att spegla tillbaka – 'Det låter som att du blev besviken'. Min son tittade på mig med stora ögon och sa: 'JA, exakt!'\" – Maria, mamma till Max 6 år"
                    ],
                    source: "Baserat på Thomas Gordons aktiva lyssnande och Adele Fabers kommunikationsmetoder"
                ),
                readingTimeMinutes: 11
            ),
            // Module 7
            CourseModule(
                id: "mk-7",
                title: "Kvalitetstid",
                subtitle: "Skapa minnen som stärker bandet",
                icon: "clock.fill",
                introduction: """
                Kvalitetstid handlar inte om att planera dyra utflykter eller elaborerade aktiviteter. Det handlar om de stunder där du och ditt barn verkligen möts – där ni skrattar tillsammans, utforskar världen eller bara är nära varandra utan krav. Forskning visar att det är dessa vardagliga ögonblick av samhörighet som barn minns och bär med sig, inte de stora evenemangen.

                Det är lätt att falla i fällan att tro att man måste 'göra något speciellt' för att det ska räknas som kvalitetstid. Men att baka tillsammans, gå till lekplatsen, läsa samma bok för femte gången eller bara ligga i gräset och titta på moln kan vara lika värdefullt. Det avgörande är att du är närvarande, engagerad och att stunden inte styrs av skärmar eller stressiga tidsramar.

                Barn med olika temperament behöver olika typer av kvalitetstid. Ett aktivt barn kanske behöver springlekar i parken, medan ett lugnare barn föredrar att pussla eller rita tillsammans. Att anpassa kvalitetstiden efter ditt barns behov och intressen visar att du verkligen ser och förstår just ditt barn.
                """,
                keyPoints: [
                    "Kvalitetstid behöver inte vara komplicerad eller dyr",
                    "Följ barnets intressen – det visar att du respekterar dess värld",
                    "Vardagssysslor tillsammans (baka, handla, vika tvätt) är också kvalitetstid",
                    "Planera in regelbunden en-till-en-tid om du har flera barn",
                    "Det är okej att bara vara nära – allt behöver inte vara en aktivitet"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du har dåligt samvete för att du inte gjort något speciellt med barnet under helgen.",
                        wrongApproach: "Du planerar en stressig utflykt till nöjesparken som kostar mycket pengar, alla är trötta efteråt och ni bråkade i bilen hem.",
                        rightApproach: "Du tar en promenad till lekplatsen, köper en glass på vägen, sitter på bänken och pratar om allt och ingenting. Hemma bakar ni pannkakor och barnet får röra i smeten.",
                        explanation: "Det enkla och vardagliga skapar starkare minnen än det stressiga och dyra. Barn bryr sig inte om prislappen – de bryr sig om din närvaro."
                    ),
                    CourseExample(
                        scenario: "Du har två barn och den äldre klagar på att du alltid är med lillasyster.",
                        wrongApproach: "Du säger: 'Men lillasyster behöver mig mer, du är ju stor nu.' och förväntar dig att det äldre barnet ska förstå.",
                        rightApproach: "Du planerar in 'ditt och mitt-tid' en gång i veckan med det äldre barnet. 'På lördag morgon är det bara du och jag. Vad vill du att vi gör?' Det kan vara en kort promenad, att spela ett spel eller laga frukost tillsammans.",
                        explanation: "Barn behöver veta att de är speciella individuellt, inte bara som del av syskonskaran. Regelbunden en-till-en-tid fyller det äldre barnets behov av att vara sedd."
                    ),
                    CourseExample(
                        scenario: "Barnet vill leka samma sak (dinosaurier) för trettionde gången och du är uttråkad.",
                        wrongApproach: "Du suckar och säger: 'Kan vi inte leka något annat? Dinosaurier är ju tråkigt.' Eller du leker halvhjärtat medan du kollar telefonen.",
                        rightApproach: "Du engagerar dig: 'Okej, idag vill jag vara T-Rex! Vad äter min T-Rex till frukost? Finns det dinosauriefrukost?' Du följer barnets lek men tillför ditt eget engagemang.",
                        explanation: "Barnets repetitiva lek är viktig för dess utveckling. Genom att engagera dig och kanske tillföra ett nytt element visar du respekt för barnets intressen samtidigt som du gör det roligare för dig."
                    )
                ],
                exercise: CourseExercise(
                    title: "Barnets drömdag",
                    description: "Be ditt barn berätta om sin 'drömdag' – vad skulle ni göra om ni fick en hel dag tillsammans? Lyssna noga och genomför så mycket som möjligt av det barnet önskar.",
                    steps: [
                        "Fråga barnet: 'Om du fick bestämma allt vi gör en hel dag, vad skulle vi göra?'",
                        "Skriv ner allt barnet säger utan att värdera eller korrigera",
                        "Välj ut de saker som är genomförbara och planera in en 'drömhalvdag'",
                        "Genomför planen med full närvaro – ingen telefon, inga andra göromål",
                        "Avsluta dagen med att prata om vad som var roligast",
                        "Gör detta till en återkommande tradition – kanske en gång i månaden"
                    ],
                    duration: "En halvdag"
                ),
                reflectionQuestions: [
                    "Vad tror du ditt barn minns mest av tiden med dig?",
                    "Finns det vardagssysslor som ni kan göra tillsammans istället för parallellt?",
                    "Hur mycket av er gemensamma tid styrs av skärmar?",
                    "Vad lekte du själv mest som barn – och kan du dela det med ditt barn?"
                ],
                forumSection: CourseForumSection(
                    intro: "Övningen 'Barnets drömdag' har lett till många överraskande och rörande berättelser.",
                    consensus: "Det de flesta föräldrar upptäcker är att barnens önskemål är mycket enklare än de förväntat sig. Sällan handlar det om dyra saker – det handlar nästan alltid om att vara tillsammans.",
                    quotes: [
                        "\"Jag frågade min son vad han ville göra. Han sa: 'Baka bullar med dig och sen läsa bok i sängen.' Jag grät lite inombords.\" – Henrik, pappa till Love 4 år",
                        "\"Min dotter ville 'gå till skogen och leta pinnar'. Inte Liseberg, inte köpa saker. Bara pinnar i skogen med mamma.\" – Sofia, mamma till Stella 5 år",
                        "\"Vi har 'ditt-och-mitt-tid' varje söndag nu. Min äldsta sa att det är det bästa med hela veckan.\" – Ali, pappa till tre"
                    ],
                    source: "Baserat på forskning om familjerelationers betydelse och kvalitetstid med barn"
                ),
                readingTimeMinutes: 10
            ),
            // Module 8
            CourseModule(
                id: "mk-8",
                title: "Empati och spegla känslor",
                subtitle: "Hjälp ditt barn förstå sina egna känslor",
                icon: "heart.text.square.fill",
                introduction: """
                Empati är grunden för alla goda relationer, och barn lär sig empati genom att själva bli bemötta med empati. När du sätter ord på ditt barns känslor – 'Du ser ledsen ut, blev du besviken?' – händer flera viktiga saker samtidigt. Barnet lär sig att identifiera sina känslor, det känner sig förstådd och det utvecklar ett emotionellt ordförråd som är avgörande för social kompetens.

                Att spegla känslor innebär att du som en emotionell spegel återger det du ser hos barnet. Det handlar inte om att analysera eller tolka, utan om att beskriva det du observerar: 'Jag ser att du har knutna nävar och rynkad panna – är du arg?' Detta hjälper barnet att koppla ihop kroppens signaler med känsloord, en förmåga som många vuxna fortfarande kämpar med.

                Det kanske viktigaste med empati är att det innebär att alla känslor är tillåtna, även om alla beteenden inte är det. Barnet får vara argt, men det får inte slå. Barnet får vara ledset, men vi tröstar istället för att avfärda. Denna skillnad mellan känsla och beteende är fundamental – och genom att spegla känslor hjälper du barnet navigera den skillnaden.
                """,
                keyPoints: [
                    "Alla känslor är tillåtna – alla beteenden är inte det",
                    "Att sätta ord på känslor hjälper barnet reglera dem",
                    "Spegla det du ser: 'Jag ser att du...' utan att tolka eller värdera",
                    "Undvik att avfärda känslor: 'Det är väl ingen fara' förminskar barnets upplevelse",
                    "Du behöver inte förstå varför barnet känner som det gör – bara att det gör det"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet ramlar och slår sig lätt på knät. Det gråter.",
                        wrongApproach: "Du säger: 'Åh, det var ju inte så farligt! Upp och hoppa! Titta, en fågel!' och försöker distrahera bort känslan.",
                        rightApproach: "Du tar barnet i famnen och säger: 'Aj, du slog dig! Det gör ont i knät. Jag förstår att du gråter.' Du håller barnet tills gråten stillar sig. 'Vill du att jag ska blåsa på det?'",
                        explanation: "Att validera smärtan istället för att avfärda den lär barnet att dess upplevelse är riktig. Barnet slutar gråta snabbare när känslan bekräftas, för det behöver inte 'bevisa' att det gör ont."
                    ),
                    CourseExample(
                        scenario: "Barnet är rasande för att kompisen fick sista biten av kakan.",
                        wrongApproach: "Du säger: 'Sluta nu, det är bara en kaka! Du kan inte bli så arg för en sån liten grej.'",
                        rightApproach: "Du säger: 'Du blir jättearg nu, det förstår jag. Du ville ha den sista biten och det känns orättvist att Alma fick den. Det är okej att vara arg.' Pause. 'Ska vi se om det finns något annat gott?'",
                        explanation: "Att validera känslan (arg) och namnge den (orättvist) ger barnet verktyg att förstå sig själv. Att sedan erbjuda en lösning – efter valideringen – visar att du tar känslorna på allvar."
                    ),
                    CourseExample(
                        scenario: "Barnet gråter okontrollerat vid lämningen på förskolan.",
                        wrongApproach: "Du säger: 'Men du brukar ju ha så roligt här! Sluta gråta nu, mamma måste gå.' Du smyger iväg när barnet blir distraherat.",
                        rightApproach: "Du böjer dig ner och säger: 'Jag ser att du är ledsen för att vi ska skiljas åt. Jag förstår det. Jag kommer tillbaka efter mellanmålet. Vill du ha en extra kram?' Du vinkar tydligt adjö och går bestämt.",
                        explanation: "Att smyga iväg skapar otrygghet. Att validera känslan, vara tydlig med att du kommer tillbaka och ta ett ordentligt adjö ger barnet trygghet även i separationen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Känsloord-dagbok",
                    description: "Under en vecka ska du medvetet använda känsloord med ditt barn – både för barnets känslor och dina egna. Skriv ner vilka ord ni använder och i vilka situationer.",
                    steps: [
                        "Gör en lista med känsloord: glad, ledsen, arg, rädd, besviken, frustrerad, stolt, nervös, orolig, upprymd",
                        "Under dagen, sätt ord på det du ser: 'Du ser glad ut!' eller 'Jag tror att du kanske är lite nervös?'",
                        "Dela dina egna känslor: 'Jag blir lite stressad nu' eller 'Jag är riktigt glad idag'",
                        "Om barnet inte håller med om din gissning, fråga: 'Vad känner du då?'",
                        "Notera vilka känsloord som är nya för barnet",
                        "Avsluta varje dag med att fråga: 'Vilken känsla hade du mest av idag?'"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vilka känslor är lätta för dig att hantera hos ditt barn? Vilka är svåra?",
                    "Hur hanterades dina starka känslor när du var barn?",
                    "Finns det känslor du omedvetet försöker 'fixa bort' hos ditt barn?",
                    "Hur ofta sätter du ord på dina egna känslor inför barnet?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att validera barns känslor istället för att avfärda dem har varit en game-changer för många föräldrar i kursen.",
                    consensus: "Den vanligaste insikten är hur ofta man omedvetet säger 'Det är ingen fara' – och hur stor skillnad det gör att istället säga 'Jag ser att du är ledsen'. Barnen börjar själva använda känsloord.",
                    quotes: [
                        "\"Min treåring sa 'Jag är frustrerad!' häromdagen. Det hade han aldrig sagt förut. Tydligen lyssnar han på allt.\" – Johanna, mamma till Viggo 3 år",
                        "\"Det svåraste var att sluta säga 'det är ingen fara'. Det sitter så djupt. Men nu ser jag att mina barn slutar gråta snabbare när jag bekräftar istället.\" – Robert, pappa till Emil 4 år och Alma 2 år",
                        "\"Jag insåg att jag själv aldrig fått mina känslor validerade som barn. Nu gör jag det för mina barn och det läker något i mig också.\" – Sandra, mamma till Tyra 5 år"
                    ],
                    source: "Baserat på John Gottmans emotionscoaching och affektteori"
                ),
                readingTimeMinutes: 12
            ),
            // Module 9
            CourseModule(
                id: "mk-9",
                title: "Sätta gränser med kärlek",
                subtitle: "Tydlighet och värme kan gå hand i hand",
                icon: "shield.lefthalf.filled",
                introduction: """
                En av de vanligaste missuppfattningarna i föräldraskap är att man måste välja mellan att vara snäll och att vara tydlig – att gränssättning kräver hårdhet och att kärlek innebär att man ger efter. Sanningen är att barn mår bäst med föräldrar som är både varma och tydliga. Gränser ger trygghet, och kärlek ger kontexten som gör gränserna begripliga.

                Att sätta gränser med kärlek handlar om att vara tydlig med vad som gäller utan att förminska, skrämma eller skuldbelägga barnet. Det innebär att du kan säga 'Nej, vi slår inte' med bestämd men lugn röst, att du kan hålla fast vid ett beslut utan att skrika och att du kan vara empatisk med barnets frustration utan att för den skull ändra gränsen. Det är skillnaden mellan 'Du är dum som slår!' och 'Jag ser att du är arg, men jag kan inte låta dig slå.'

                Barn som har föräldrar som sätter gränser med kärlek utvecklar en inre kompass. De lär sig inte bara vad som är rätt och fel, utan varför – och de internaliserar dessa värderingar så att de gör goda val även när ingen ser dem. Det är ett långsiktigt perspektiv som kräver tålamod, men som ger barn de bästa förutsättningarna.
                """,
                keyPoints: [
                    "Gränser och kärlek utesluter inte varandra – de kompletterar varandra",
                    "Var tydlig med regeln men empatisk med känslan: 'Jag vet att du vill, men...'",
                    "Konsistens är viktigare än stränghet",
                    "Förklara varför gränsen finns – 'Vi gör så för att...'",
                    "Ge inte efter för gråt eller tjat om du vet att gränsen är rätt",
                    "Reparera alltid relationen efter en konflikt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet vill ha godis i kassan och börjar gråta högljutt när du säger nej.",
                        wrongApproach: "Du köper godiset för att slippa scenen, eller du viskar hotfullt: 'Om du inte slutar gråta direkt åker vi hem och du får inget alls.'",
                        rightApproach: "Du sätter dig på huk och säger: 'Jag vet att du vill ha godis och det förstår jag – det ser gott ut. Men vi köper inte godis idag. Jag vet att det är ledsamt.' Du håller fast vid beslutet medan du visar förståelse. Om barnet fortsätter gråta är det okej – du behöver inte 'fixa' gråten.",
                        explanation: "Du validerar känslan utan att ge efter. Att hålla gränsen trots gråt visar att du klarar av barnets starka känslor, vilket paradoxalt nog ger barnet mer trygghet. Nästa gång vet barnet att nej betyder nej – men också att du förstår."
                    ),
                    CourseExample(
                        scenario: "Femåringen vill stanna uppe och titta på TV istället för att gå och lägga sig.",
                        wrongApproach: "Du ger efter 'bara ikväll' (för tredje kvällen i rad) eller stänger av TVn plötsligt och bär iväg det skrikande barnet.",
                        rightApproach: "Du förvarnar: 'Efter det här avsnittet är det läggdags.' När det är dags: 'Nu var avsnittet slut. Jag vet att du vill titta mer – det hade jag också velat. Men nu är det sovdags för kroppen behöver vila. Ska vi läsa två eller tre böcker ikväll?'",
                        explanation: "Förvarning, empati, förklaring och ett nytt val (antal böcker) gör övergången smidigare. Du behåller gränsen men erbjuder något positivt istället."
                    ),
                    CourseExample(
                        scenario: "Barnet slår ett syskon i ilska.",
                        wrongApproach: "Du skriker: 'Man slår inte! Gå till ditt rum!' eller du slår barnet tillbaka 'så det vet hur det känns'.",
                        rightApproach: "Du går emellan direkt och säger med bestämd men inte arg röst: 'Stopp. Jag kan inte låta dig slå. Det gör ont.' Du tröstar det slagna barnet. Sedan vänder du dig till det barn som slog: 'Jag förstår att du blev arg, men vi löser det utan att slå. Vad kan du göra istället när du är så arg?'",
                        explanation: "Du stoppar beteendet utan att skuldbelägga personen. 'Jag kan inte låta dig slå' är annorlunda än 'Du är dum som slår'. Du lär barnet alternativ genom att fråga, inte genom att bestraffa."
                    )
                ],
                exercise: CourseExercise(
                    title: "Gräns-empati-övningen",
                    description: "Öva på att säga nej med empati genom att använda formeln: Validera känslan + Sätt gränsen + Erbjud alternativ.",
                    steps: [
                        "Tänk på tre vanliga situationer där du behöver säga nej",
                        "Skriv ner din vanliga reaktion (troligtvis bara 'Nej!')",
                        "Omformulera med formeln: 'Jag förstår att du vill... + Men... + Istället kan du...'",
                        "Öva gärna framför spegeln – det kan kännas konstigt i början",
                        "Använd formeln under kommande vecka",
                        "Notera barnets reaktion: blev konflikten kortare? Lindrigare?"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vilka gränser är viktigast för dig? Varför just de?",
                    "Finns det gränser du håller mest av vana eller för att andra ska tycka att du är en bra förälder?",
                    "Hur känns det att hålla en gräns medan barnet gråter?",
                    "Reparerar du relationen efter konflikter? Hur?"
                ],
                forumSection: CourseForumSection(
                    intro: "Gränssättning med kärlek är ett ämne som väcker starka känslor hos många föräldrar.",
                    consensus: "De flesta föräldrar upplever att det svåraste är att stå ut med barnets reaktion när man håller en gräns. Men de som håller ut märker att konflikterna blir kortare och barnen tryggare.",
                    quotes: [
                        "\"Första veckan grät hon lika länge vid godishyllan. Tredje veckan frågade hon 'Är det godisdag idag?' och accepterade mitt nej. Konsistens fungerar.\" – Lina, mamma till Edith 3 år",
                        "\"Jag var så rädd att mina barn skulle sluta tycka om mig om jag sa nej. Nu inser jag att de blev tryggare.\" – Kristian, pappa till Sigge 5 år",
                        "\"Formeln 'Jag förstår att du vill + Men + Istället kan du' är tatuerad i min hjärna nu. Den funkar på jobbet också!\" – Rebecka, mamma till Melvin 4 år"
                    ],
                    source: "Baserat på Martin Forsters ABC-principer och forskning om auktoritativt föräldraskap"
                ),
                readingTimeMinutes: 13
            ),
            // Module 10
            CourseModule(
                id: "mk-10",
                title: "Vardagsrutiner som stärker relationen",
                subtitle: "Gör det vardagliga till något värdefullt",
                icon: "repeat.circle.fill",
                introduction: """
                Det är i vardagens rutiner som relationen mellan förälder och barn till stor del byggs. Morgonrutinen, middagen, kvällsrutinen – dessa repetitiva ögonblick kan antingen vara stressade kamper eller tillfällen för anknytning. Genom att medvetet designa dina rutiner med relationen i fokus kan du förvandla varje dag till hundra små tillfällen att stärka bandet med ditt barn.

                Barn älskar förutsägbarhet. En tydlig rutin ger trygghet och minskar konflikter, eftersom barnet vet vad som kommer härnäst. Men rutiner behöver inte vara stela eller tråkiga. En 'hemlig handskakning' vid hämtning, en sång ni alltid sjunger vid tandborstningen, en kram på ett särskilt ställe vid lämningen – det är dessa små ritualer som barnet bär med sig och som bygger er unika familjekultur.

                I denna avslutande modul får du hjälp att inventera dina nuvarande rutiner och identifiera vilka som kan bli varmare, roligare och mer relationsbyggande. Det handlar inte om att lägga till fler saker att göra, utan om att göra det du redan gör med mer kärlek och medvetenhet.
                """,
                keyPoints: [
                    "Rutiner skapar trygghet och minskar onödiga konflikter",
                    "Skapa små ritualer i vardagen: en speciell hälsning, en mysig tradition",
                    "Involvera barnet i att forma rutinerna – det ökar samarbetet",
                    "Morgon och kväll är extra viktiga stunder för anknytning",
                    "Rutiner kan anpassas – det viktiga är att de finns, inte att de är perfekta"
                ],
                examples: [
                    CourseExample(
                        scenario: "Morgonrutinen är kaotisk med tjat om kläder, frukost och att hinna till förskolan i tid.",
                        wrongApproach: "Du springer runt och stressar: 'Skynda dig! Vi är sena! Ta på dig nu!' Barnet blir ledset och morgonen är förstörd.",
                        rightApproach: "Du skapar en rutin med barnet: en 'morgonlista' med bilder (tröja, frukost, tänder, skor) som barnet bockar av. Ni börjar 10 minuter tidigare och har en stund för en kram i sängen innan ni startar. 'Gomorron älskling, ska vi kolla vad första bilden på listan är?'",
                        explanation: "Genom att strukturera morgonen med visuellt stöd och börja lite tidigare skapas utrymme för värme. Barnet vet vad som ska hända och kan vara delaktigt."
                    ),
                    CourseExample(
                        scenario: "Middagen blir ofta en stridsfråga – barnet vill inte sitta still, vill inte äta det som serveras.",
                        wrongApproach: "Du tjatar: 'Sitt still! Ät upp! Om du inte äter blir det ingen dessert!' Middagen blir en daglig kamp.",
                        rightApproach: "Du inför en middagsritual: alla berättar en rolig sak från dagen. Barnet får lägga upp sin egen mat. Ni äter lugnt och utan krav på att äta upp. 'Berätta det roligaste som hände idag! Jag börjar – jag såg en ekorre på jobbet!'",
                        explanation: "Genom att göra middagen till en social stund istället för en ätuppgift minskar stressen. Att barnet lägger upp själv ger kontroll. Att alla delar sin dag skapar samhörighet."
                    ),
                    CourseExample(
                        scenario: "Kvällsrutinen drar ut på tiden. Barnet vill ha vatten, kissa, mer vatten, en till bok...",
                        wrongApproach: "Du blir allt mer irriterad: 'Nu räcker det! Du har fått din bok, ligg kvar!' Du stänger dörren och barnet gråter.",
                        rightApproach: "Du skapar en tydlig men mysig rutin: pyjamas, tänder, en bok, en sång och tre 'saker jag gillar med dig idag'. Sedan: 'Nu har vi gjort alla våra mysiga saker. Det är dags att sova nu. Jag finns precis utanför.'",
                        explanation: "En förutsägbar kvällsrutin med en härlig avslutning (tre saker jag gillar med dig) ger barnet den trygghet det söker med alla extraönskemål. Barnet vet exakt vad det får och behöver inte förhandla."
                    )
                ],
                exercise: CourseExercise(
                    title: "Rutin-inventering",
                    description: "Gå igenom en vanlig dag och identifiera tre rutinsituationer som du kan göra mer relationsstärkande. Skapa en liten ritual för varje.",
                    steps: [
                        "Skriv ner din dags huvudrutiner: morgon, hämtning/lämning, middag, kväll",
                        "Markera vilka som ofta blir stressiga eller konfliktfyllda",
                        "Välj tre stunder och skapa en liten ritual: en sång, en speciell hälsning, en tradition",
                        "Involvera barnet: 'Vad ska vi alltid göra när jag hämtar dig?'",
                        "Testa i en vecka och justera det som inte fungerar",
                        "Behåll det som fungerar och låt det bli er grej"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vilken rutin hemma hos er fungerar bäst? Varför tror du att den gör det?",
                    "Vilken tid på dagen känner du mest stress? Vad kan du ändra?",
                    "Hade du speciella ritualer i din egen barndom? Vilka vill du föra vidare?",
                    "Hur skulle det kännas att börja varje dag med en kram istället för en stressad uppmaning?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att förändra rutinerna hemma har haft stor påverkan för många familjer – och det behöver inte vara stora saker.",
                    consensus: "De flesta föräldrar beskriver att bara en liten ritual – en speciell kram, en rolig fras, en kvällstradition – förändrade hela stämningen i vardagen.",
                    quotes: [
                        "\"Vi säger 'Tre bra saker' varje kväll vid sängen. Min dotter börjar räkna bra saker under dagen för att ha dem redo. Det ändrade hela perspektivet.\" – Eva, mamma till Tuva 5 år",
                        "\"Vår hemliga handskakning vid hämtningen gör att min son springer mot mig med ett jätteleende varje dag.\" – Andreas, pappa till Hugo 4 år",
                        "\"Vi började äta frukost 10 minuter tidigare och sluta stressa. Barnen bråkar hälften så mycket nu.\" – Mia, mamma till tre"
                    ],
                    source: "Baserat på forskning om rutiner, ritualer och deras betydelse för familjerelationer"
                ),
                readingTimeMinutes: 11
            )
        ],
        targetAudience: "Föräldrar med barn 1-6 år",
        estimatedWeeks: 10
    )
}

// MARK: - Course 2: Trygga anknytningen

extension Course {
    static let tryggaAnknytningen = Course(
        id: "trygga-anknytningen",
        title: "Trygga anknytningen",
        subtitle: "Bygg ett tryggt band med ditt barn",
        description: "En djupgående kurs om anknytningsteori och hur du som förälder kan skapa en trygg bas för ditt barn. Baserad på Bowlbys och Ainsworths banbrytande forskning, anpassad för den moderna svenska familjen.",
        icon: "figure.and.child.holdinghands",
        gradient: LinearGradient(colors: [Color(hex: "6B4CE6"), Color(hex: "9B7FF0")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            // Module 1
            CourseModule(
                id: "ta-1",
                title: "Anknytningsteorins grunder",
                subtitle: "Varför de första banden är så viktiga",
                icon: "link.circle.fill",
                introduction: """
                Anknytningsteori är en av de mest väldokumenterade teorierna inom barnpsykologi. Den utvecklades av den brittiske psykiatern John Bowlby på 1950-talet och vidareutvecklades av den amerikanska psykologen Mary Ainsworth. Kärnan i teorin är enkel men djupgående: barn föds med ett medfött behov av att knyta an till en eller flera omsorgspersoner, och kvaliteten på dessa tidiga band påverkar barnets utveckling genom hela livet.

                En trygg anknytning innebär att barnet litar på att dess behov kommer att bli tillgodosedda. Det betyder inte att föräldern alltid är perfekt eller alltid finns tillgänglig – det betyder att föräldern är tillräckligt bra, tillräckligt ofta. Barnet lär sig: 'När jag signalerar ett behov, kommer någon att svara.' Denna grundläggande tillit till världen formas under de första levnadsåren och blir en inre arbetsmodell som barnet bär med sig.

                Det viktigaste att förstå är att anknytning inte handlar om att vara en perfekt förälder. Forskningen visar att det räcker att vara en 'good enough'-förälder – en som svarar på barnets signaler ungefär 30-50% av gångerna. Det handlar mer om mönstret över tid än om varje enskild interaktion. Om du missar en signal, kan du alltid reparera och återansluta.

                I Sverige har vi en unik förutsättning tack vare vår generösa föräldraledighet. De första månaderna hemma med barnet ger en fantastisk möjlighet att bygga denna grundläggande anknytning. Men det betyder inte att anknytningen slutar formas efter spädbarnsåret – den fortsätter utvecklas genom hela barndomen.
                """,
                keyPoints: [
                    "Barn föds med ett medfött behov av att knyta an till omsorgspersoner",
                    "Trygg anknytning byggs genom konsekvent, lyhört omhändertagande",
                    "Du behöver inte vara perfekt – 'good enough' räcker (30-50% av gångerna)",
                    "Anknytningen formas främst under de första 2-3 åren men fortsätter hela barndomen",
                    "Barn kan knyta an tryggt till flera personer – inte bara mamman",
                    "En trygg anknytning skyddar mot stress och främjar emotionell reglering",
                    "Det går att stärka anknytningen i alla åldrar – det är aldrig för sent"
                ],
                examples: [
                    CourseExample(
                        scenario: "Åttamånaders bebis gråter och sträcker armarna mot dig när du lägger ner hen i spjälsängen.",
                        wrongApproach: "Du lägger ner bebisen bestämt och går ut ur rummet. 'Hen måste lära sig att sova själv, annars blir det aldrig bra.' Du väntar utanför medan gråten eskalerar.",
                        rightApproach: "Du tar upp bebisen igen, håller hen nära och säger mjukt: 'Jag förstår, du vill inte vara ensam. Jag är här.' Du vaggar tills bebisen lugnar sig och försöker igen när hen verkar redo. Det kan ta flera omgångar – och det är helt okej.",
                        explanation: "I spädbarnsåldern är gråt barnets enda sätt att kommunicera behov. Att svara på gråten bygger tillit och är grundstenen i trygg anknytning. Att 'lära sig sova själv' kan komma senare – just nu är det viktigaste att barnet känner sig tryggt."
                    ),
                    CourseExample(
                        scenario: "Du lämnar ditt ettåriga barn hos morföräldrarna för första gången en hel dag.",
                        wrongApproach: "Du smyger iväg när barnet är upptaget med en leksak. 'Det är lättare om hen inte märker att jag går.' Barnet upptäcker att du är borta och blir otröstlig.",
                        rightApproach: "Du säger tydligt: 'Mamma/pappa ska gå nu, men jag kommer tillbaka efter lunch. Mormor och morfar tar hand om dig.' Du ger en kram, vinkar och går – även om barnet gråter lite. Mormor tröstar.",
                        explanation: "Att smyga iväg kan verka snällare i stunden, men det bryter förtroendet. Barnet lär sig att du kan försvinna när som helst utan förvarning. Ett tydligt adjö, även med lite gråt, bygger tillit: 'Mamma/pappa säger alltid hejdå och kommer alltid tillbaka.'"
                    )
                ],
                exercise: CourseExercise(
                    title: "Kartlägg ditt anknytningsarbete",
                    description: "Reflektera över och skriv ner hur du svarar på ditt barns signaler under en vanlig dag. Identifiera mönster och styrkor.",
                    steps: [
                        "Välj en vanlig dag och var medveten om barnets signaler (gråt, leenden, sträckande armar, blickar)",
                        "Notera hur du svarar på varje signal – direkt, försenat eller inte alls",
                        "Skriv ner vilka situationer som är lättast att svara på och vilka som är svårast",
                        "Identifiera vad som hindrar dig från att svara ibland (stress, telefonen, trötthet)",
                        "Välj en sak du kan förbättra och sätt ett realistiskt mål",
                        "Prata med din partner om era gemensamma anknytningsarbete"
                    ],
                    duration: "En hel dag av observation + 30 minuters reflektion"
                ),
                reflectionQuestions: [
                    "Hur tror du din egen anknytning som barn var? Hur påverkar det dig som förälder?",
                    "Finns det situationer där du märker att det är svårt att svara på ditt barns behov?",
                    "Hur fördelar ni anknytningsarbetet i er familj? Har barnet trygg anknytning till båda föräldrarna?",
                    "Vad betyder 'good enough' för dig? Kan du ge dig själv tillåtelse att inte vara perfekt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Anknytningsteori kan kännas överväldigande – men de flesta föräldrar inser att de redan gör mycket rätt.",
                    consensus: "Många föräldrar i forumet delar att de blev oroliga först men lättade sedan. Den vanligaste insikten är att 'good enough' verkligen räcker.",
                    quotes: [
                        "\"Jag hade så dåligt samvete för att jag inte alltid orkar svara direkt på varje gnäll. Att läsa att 30-50% räcker var en lättnad.\" – Emelie, mamma till Sixten 8 mån",
                        "\"Min sambo var orolig att han inte kunde knyta an lika bra som jag som ammar. Men sen vi medvetet lät honom ta kvällsrutinen blev deras band superstark.\" – Josefin, mamma till Alva 1 år",
                        "\"Jag växte upp med en frånvarande förälder och var livrädd att upprepa mönstret. Den här kursen visade mig att medvetenhet redan är halva jobbet.\" – Daniel, pappa till Olle 10 mån"
                    ],
                    source: "Baserat på John Bowlbys anknytningsteori och Mary Ainsworths Strange Situation-forskning"
                ),
                readingTimeMinutes: 12
            ),
            // Module 2
            CourseModule(
                id: "ta-2",
                title: "Signaler och behov",
                subtitle: "Lär dig läsa ditt barns kommunikation",
                icon: "message.circle.fill",
                introduction: """
                Långt innan ett barn kan tala kommunicerar det genom ett rikt språk av signaler. Gråt, leenden, blickar, kroppsrörelser och ansiktsuttryck – allt är barnets sätt att berätta vad det behöver. Att lära sig läsa dessa signaler är en av de viktigaste färdigheterna du kan utveckla som förälder, och det är grunden för att bygga trygg anknytning.

                Olika typer av gråt betyder olika saker. En hungergråt låter annorlunda än en trötthetsgråt, som i sin tur skiljer sig från en gråt av obehag eller ensamhet. I början kan allt låta likadant, men med tiden och uppmärksamhet lär sig de flesta föräldrar att skilja på signalerna. Det handlar inte om att alltid gissa rätt – det handlar om att visa barnet att du försöker förstå.

                En viktig del av signal-läsningen är att vara uppmärksam på barnets tidiga signaler, innan gråten kommer. Ett barn som börjar bli hungrigt visar det ofta först genom att smacka, vrida huvudet mot bröstet eller tugga på handen. Om vi fångar dessa signaler tidigt, slipper barnet eskalera till full gråt – och barnet lär sig att det inte behöver skrika för att bli hört.

                Det är helt normalt att ibland misslyckas med att tolka signalerna. Kanske erbjuder du mat när barnet egentligen var trött, eller försöker lägga ner barnet som egentligen hade ont i magen. Det viktiga är att du fortsätter försöka, justerar och visar barnet att du är engagerad i att förstå. Denna process av att misslyckas och reparera är faktiskt viktig i sig – den lär barnet att missförstånd kan lösas.
                """,
                keyPoints: [
                    "Barn kommunicerar genom gråt, blickar, ansiktsuttryck och kroppsspråk",
                    "Olika typer av gråt signalerar olika behov – lär dig lyssna på nyanserna",
                    "Tidiga signaler (smackande, gnyr, vrider sig) kommer innan full gråt",
                    "Att fånga signaler tidigt lär barnet att det inte behöver skrika för att bli hört",
                    "Det är okej att gissa fel – att försöka förstå räknas",
                    "Varje barn har unika signaler – du lär dig ditt barns 'språk' med tiden"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din treveckorsbebis gråter och du vet inte varför. Du har bytt blöja, försökt mata och vagga.",
                        wrongApproach: "Du blir frustrerad och lägger ner bebisen i sängen: 'Jag vet inte vad du vill! Ingenting fungerar!' Du känner dig misslyckad.",
                        rightApproach: "Du tar ett djupt andetag och provar en sak i taget. Kanske hud-mot-hud, kanske vit brus, kanske en annan ställning. Du pratar lugnt: 'Jag hör att du är ledsen. Jag försöker hjälpa dig. Vi provar tillsammans.' Ibland gråter bebisar utan tydlig anledning – och då är din närvaro det viktigaste.",
                        explanation: "Att inte veta vad barnet vill är helt normalt, särskilt i början. Det viktigaste är att barnet inte lämnas ensamt med sin gråt. Din lugna närvaro, även när du inte hittar 'lösningen', är i sig anknytningsbyggande."
                    ),
                    CourseExample(
                        scenario: "Din sexmånaders bebis sitter i barnstolen och börjar gnälla och vrida sig medan du lagar mat.",
                        wrongApproach: "Du ignorerar gnället och tänker 'Hen gnäller alltid, det går över.' Det eskalerar till gråt och sedan skrik.",
                        rightApproach: "Du märker gnället tidigt och kollar klockan – det var länge sedan hen åt. Du går fram, böjer dig ner och säger: 'Åh, du börjar bli hungrig va? Maten kommer snart. Titta, här har du en brödskorpa att tugga på medan vi väntar.'",
                        explanation: "Genom att fånga den tidiga signalen (gnäll) innan den eskalerar till gråt, visar du barnet att det blir hört. Barnet lär sig att milda signaler räcker – det behöver inte skrika. Detta bygger kommunikation och tillit."
                    )
                ],
                exercise: CourseExercise(
                    title: "Signal-dagbok",
                    description: "Under tre dagar, för anteckningar om ditt barns signaler och vad de betydde. Bygg upp en 'ordlista' för ditt barns unika kommunikationssätt.",
                    steps: [
                        "Ha ett anteckningsblock eller telefonen redo",
                        "Varje gång barnet signalerar ett behov (gråt, gnäll, gest, ansiktsuttryck), notera vad som hände",
                        "Skriv ner vad du tolkade signalen som och vad du gjorde",
                        "Notera om din tolkning stämde eller om du fick justera",
                        "Identifiera mönster efter tre dagar: vilka signaler kan du redan läsa bra?",
                        "Dela dina observationer med din partner så att ni båda kan lära er barnets signaler"
                    ],
                    duration: "Tre dagar"
                ),
                reflectionQuestions: [
                    "Vilka av ditt barns signaler kan du läsa bäst? Vilka är svårast?",
                    "Hur känns det i kroppen när barnet gråter och du inte vet varför?",
                    "Har du märkt att du och din partner tolkar barnets signaler olika? Hur hanterar ni det?",
                    "Hur snabbt svarar du vanligtvis på barnets signaler? Finns det utrymme att bli snabbare?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att lära sig läsa sitt barns signaler tar tid – och de flesta föräldrar tvivlar på sig själva i början.",
                    consensus: "Den gemensamma erfarenheten är att det plötsligt 'klickar' efter några veckor. Plötsligt vet man skillnaden på hungergråt och trötthetsgråt utan att tänka.",
                    quotes: [
                        "\"Vecka ett tyckte jag allt gråt lät likadant. Vecka sex kunde jag höra skillnad från andra rummet. Det kommer med tiden, lita på det!\" – Klara, mamma till Ella 4 mån",
                        "\"Bästa tipset: sluta googla och lyssna på ditt barn istället. Ingen expert kan ditt barns signaler bättre än du.\" – Fredrik, pappa till Nova 6 mån",
                        "\"Min partner och jag hade helt olika tolkningar. Vi insåg att vi båda hade rätt ibland – barnet hade bara olika signaler med oss.\" – Li, mamma till Siri 5 mån"
                    ],
                    source: "Baserat på T. Berry Brazeltons arbete om nyfödda barns beteendesignaler"
                ),
                readingTimeMinutes: 11
            ),
            // Module 3
            CourseModule(
                id: "ta-3",
                title: "Den trygga basen",
                subtitle: "Var en hamn i stormen",
                icon: "house.lodge.fill",
                introduction: """
                Begreppet 'trygg bas' är centralt inom anknytningsteorin. Det innebär att barnet använder föräldern som en säker utgångspunkt för att utforska världen. Tänk dig en liten unge på en lekplats: hen springer iväg för att klättra, men vänder sig regelbundet om för att kolla att mamma eller pappa fortfarande sitter på bänken. Den där blicken tillbaka – och ditt leende eller nick tillbaka – är det som ger barnet modet att fortsätta utforska.

                En trygg bas är inte en förälder som hela tiden håller barnet nära. Tvärtom – det är en förälder som ger barnet frihet att utforska, vetandes att det finns en säker plats att återvända till. Barnet behöver båda delarna: uppmuntran att ge sig ut i världen och trygghet att komma tillbaka till famnen. Det är en balansgång som förändras i takt med barnets ålder och utveckling.

                Som förälder behöver du vara både en trygg bas (som barnet utgår ifrån) och en säker hamn (som barnet återvänder till). När barnet utforskar behöver det veta att du finns i bakgrunden. När barnet blir rädd, ledset eller överväldigat behöver det veta att du öppnar famnen. Denna dubbla funktion – att släppa iväg och att ta emot – är kärnan i trygg anknytning.

                Det är viktigt att förstå att varje barn har sitt eget tempo för utforskande. Vissa barn springer modigt iväg och kollar sällan tillbaka. Andra håller sig nära och behöver lång tid innan de vågar utforska. Båda är normala variationer – ditt jobb är inte att trycka på barnet utan att anpassa dig efter just ditt barns behov.
                """,
                keyPoints: [
                    "Den trygga basen ger barnet mod att utforska världen",
                    "Barnet behöver både frihet att utforska och trygghet att återvända till",
                    "Din blick och närvaro på avstånd räknas – du behöver inte hela tiden vara nära",
                    "Varje barn har sitt eget tempo för utforskande – respektera det",
                    "Att vara en trygg bas innebär att tåla barnets pendling mellan närhet och frihet",
                    "Med åldern ökar barnets radie – men behovet av den trygga basen finns kvar"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt tvååriga barn vill klättra på klätterställningen men stannar vid det första steget och tittar på dig med osäker blick.",
                        wrongApproach: "Du lyfter upp barnet och placerar det högre upp: 'Kom igen, det är inte farligt! Titta på de andra barnen som klättrar!' Eller du säger: 'Nej, det är för högt för dig, kom ner.'",
                        rightApproach: "Du ler och nickar uppmuntrande: 'Jag ser dig! Du kan prova om du vill – jag står precis här.' Om barnet klättrar ett steg till: 'Där ja! Du hittade nästa steg.' Om barnet vill komma ner: 'Ska jag hjälpa dig ner? Du var modig som provade.'",
                        explanation: "Din roll är att varken trycka på eller hålla tillbaka. Ditt leende och din närvaro är den trygga basen som barnet behöver för att våga utforska i sin egen takt. Oavsett om barnet klättrar vidare eller väljer att klättra ner, bekräftar du modet."
                    ),
                    CourseExample(
                        scenario: "Treåringen på öppna förskolan klamrar sig fast vid ditt ben och vägrar leka med de andra barnen.",
                        wrongApproach: "Du lossar barnet och knuffar det framåt: 'Gå och lek nu! Du kan inte hänga på mig hela tiden, alla andra barn leker.' Du skäms lite över att ditt barn är så blygt.",
                        rightApproach: "Du sätter dig ner med barnet i knäet nära de andra. 'Vi kan sitta här tillsammans och titta. Jag går ingenstans.' Du kommenterar vad de andra barnen gör: 'Titta, de bygger med klossar.' Du väntar tills barnet på eget initiativ börjar visa intresse.",
                        explanation: "Barnet behöver ladda trygghetsenergi i din famn innan det vågar ge sig ut. Att tvinga det leder till mer klamrande. Genom att vara den trygga basen – lugn, tålmodig, närvarande – ger du barnet exakt det det behöver för att småningom våga utforska."
                    )
                ],
                exercise: CourseExercise(
                    title: "Trygg bas-observation",
                    description: "Observera hur ditt barn använder dig som trygg bas under en lekplatsstund eller på öppna förskolan. Notera barnets pendling mellan utforskande och återvändande.",
                    steps: [
                        "Gå till en lekplats eller annan plats där barnet kan utforska",
                        "Sätt dig på en bänk och låt barnet leka fritt",
                        "Observera: hur ofta vänder sig barnet om och söker din blick?",
                        "Svara med leende, nick eller en uppmuntrande kommentar varje gång",
                        "Notera: när barnet blir osäkert, kommer det till dig eller löser det själv?",
                        "Reflektera efteråt: hur balanserar ditt barn utforskande och trygghetsökande?"
                    ],
                    duration: "30-60 minuter"
                ),
                reflectionQuestions: [
                    "Hur reagerar du instinktivt när ditt barn är osäkert – tryckar du på eller håller tillbaka?",
                    "Kan du vara trygg med att ditt barn utforskar i sin egen takt, även om det går långsamt?",
                    "Hur gör du för att signalera att du finns kvar även på avstånd?",
                    "Finns det situationer där du omedvetet tar över istället för att låta barnet prova?"
                ],
                forumSection: CourseForumSection(
                    intro: "Konceptet 'trygg bas' är ett av de mest kraftfulla verktygen för att förstå sitt barns beteende.",
                    consensus: "Föräldrar delar att de slutade oroa sig för att deras barn var 'för klängigt' eller 'för modigt' – och istället började se barnets beteende som kommunikation om trygghetsbehov.",
                    quotes: [
                        "\"Min dotter klängde sig vid mig på varje kalas. Jag skämdes. Nu förstår jag att hon behövde ladda trygghet – och efter 20 minuter i mitt knä lekte hon med alla!\" – Hanna, mamma till Nora 2,5 år",
                        "\"Jag insåg att jag omedvetet pushade min son att vara 'modig'. Nu låter jag honom bestämma tempot och han har blivit modigare av sig själv.\" – Simon, pappa till Leo 3 år",
                        "\"Den där blicken tillbaka på lekplatsen – nu svarar jag med ett leende varje gång. Det är vår lilla hemlighet.\" – Therese, mamma till Charlie 18 mån"
                    ],
                    source: "Baserat på Mary Ainsworths forskning om trygg bas-fenomenet"
                ),
                readingTimeMinutes: 11
            ),
            // Module 4
            CourseModule(
                id: "ta-4",
                title: "Separationsångest",
                subtitle: "Förstå och hantera barnets rädsla för att skiljas åt",
                icon: "heart.slash.fill",
                introduction: """
                Separationsångest är en av de vanligaste utmaningarna för småbarnsföräldrar. Det börjar ofta runt 6-8 månaders ålder och kan vara som starkast mellan 12-18 månader. Plötsligt gråter barnet varje gång du lämnar rummet, vill inte lämnas hos morföräldrarna och klamrar sig fast vid dig som om livet hängde på det. Det kan vara uttömmande – men det är faktiskt ett tecken på en sund utveckling.

                Separationsångest uppstår därför att barnet har utvecklat objektpermanens – förståelsen att du finns även när du inte syns – kombinerat med en ännu outvecklad förmåga att förstå tid. Barnet vet att du har försvunnit men kan inte förstå att du kommer tillbaka. I barnets värld kan 'mamma gick till toaletten' och 'mamma försvann för alltid' kännas likadant. Det är hjärtskärande men helt biologiskt normalt.

                Det viktigaste du kan göra är att vara konsekvent och förutsägbar i dina separationer. Alltid säga hejdå, alltid förklara att du kommer tillbaka och alltid komma tillbaka när du sagt att du ska. Denna förutsägbarhet bygger tillit över tid och hjälper barnet gradvis förstå att separationer är tillfälliga. Det hjälper också att ha goda överlämningar – att den person du lämnar barnet hos är lugn, trygg och bekant.

                I Sverige har vi inskolning på förskola som en viktig del av separationshanteringen. En bra inskolning, anpassad efter barnets tempo, ger barnet möjlighet att gradvis bygga en ny anknytningsrelation med förskolepedagogerna – en relation som blir en ny trygg bas under dagarna.
                """,
                keyPoints: [
                    "Separationsångest är ett normalt utvecklingssteg som börjar runt 6-8 månader",
                    "Det är ett tecken på att anknytningen fungerar – barnet bryr sig om att du finns kvar",
                    "Smyg aldrig iväg – säg alltid tydligt hejdå och att du kommer tillbaka",
                    "Håll adjöet kort, varmt och bestämt – utdragna adjö ökar ångesten",
                    "Övningsseparationer (korta stunder med bekanta personer) bygger tillit",
                    "De flesta barn lugnar sig snabbt efter att föräldern gått – fråga personalen"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt ettåriga barn skriker hysteriskt vid inskolningen på förskolan.",
                        wrongApproach: "Du stannar i tre timmar och vågar inte gå. Eller: du smyger ut genom bakdörren när barnet tittar åt ett annat håll.",
                        rightApproach: "Du säger lugnt: 'Nu ska mamma gå. Du får vara med Sara (pedagogen) och leka. Jag kommer tillbaka efter lunch.' Du ger en kram, vinkar tydligt och går bestämt ut. Även om det gråter. Du ringer förskolan 30 minuter senare för att höra hur det går.",
                        explanation: "Att stanna kvar i timmar skickar signalen 'Det här stället är farligt, jag vågar inte lämna dig.' Att smyga iväg bryter förtroendet. Det tydliga adjöet med löfte om att komma tillbaka – och att sedan hålla löftet – bygger tillit och gör varje separation lite lättare."
                    ),
                    CourseExample(
                        scenario: "Ditt tvååriga barn gråter varje gång du ska gå på toaletten.",
                        wrongApproach: "Du väntar tills barnet sover och springer till toaletten, eller du tar med barnet varje gång och får aldrig en lugn stund.",
                        rightApproach: "Du säger: 'Mamma ska bara gå på toa. Jag kommer tillbaka snart. Kan du bygga ett torn med klossarna så kollar jag det när jag kommer?' Du går och kommer tillbaka efter en kort stund med ett stort leende: 'Titta, jag kom tillbaka! Åh, vad fint torn!'",
                        explanation: "Korta, förutsägbara separationer i trygga hemmiljön är utmärkta övningstillfällen. Varje gång du går och kommer tillbaka stärker du barnets förståelse: 'Mamma försvinner inte – hon kommer alltid tillbaka.'"
                    )
                ],
                exercise: CourseExercise(
                    title: "Trygga adjö-ritualen",
                    description: "Skapa en fast adjö-ritual som ni använder vid alla separationer – lämning på förskolan, hos morföräldrarna och vid vardagliga separationer hemma.",
                    steps: [
                        "Bestäm en kort ritual: kanske en specialkram, en puss på handen, ett hemligt tecken",
                        "Använd samma ritual vid alla separationer så barnet känner igen mönstret",
                        "Säg alltid tre saker: 'Jag går nu', 'Du ska vara med [person]' och 'Jag kommer tillbaka [tidpunkt/händelse]'",
                        "Gå bestämt och med leende efter ritualen – dröj inte",
                        "Gör något speciellt vid återföreningen: 'Jag är tillbaka, precis som jag sa!'",
                        "Var konsekvent med ritualen i minst två veckor"
                    ],
                    duration: "Två veckor"
                ),
                reflectionQuestions: [
                    "Hur hanterar du din egen ångest vid separationer? Smittar din oro av sig på barnet?",
                    "Har du upplevt att ditt barn klarar separationer bättre med vissa personer? Varför tror du det?",
                    "Vad gör du för att återföreningen ska bli en positiv stund?",
                    "Hur gick inskolningen på förskolan? Vad lärde du dig av den?"
                ],
                forumSection: CourseForumSection(
                    intro: "Separationsångest kan vara enormt påfrestande – men det går över. Här delar föräldrar sina erfarenheter.",
                    consensus: "Den vanligaste lärdomen är att det nästan alltid går bättre för barnet än vad föräldern tror. De flesta barn lugnar sig inom minuter – det är föräldern som mår dåligt längre.",
                    quotes: [
                        "\"Jag grät hela vägen till jobbet varje dag i två veckor. Förskolan skickade bilder på mitt barn som lekte glatt fem minuter efter att jag gått.\" – Matilda, mamma till Algot 13 mån",
                        "\"Vi hittade på en specialkram – tre snabba kramar och en puss på näsan. Nu räcker det som adjö och sen springer hon in!\" – Karl, pappa till Iris 2 år",
                        "\"Det sämsta jag gjorde var att smyga iväg. Inskolningen tog dubbelt så lång tid efter det. Var ärlig – barn klarar mer än vi tror.\" – Saga, mamma till Nils 14 mån"
                    ],
                    source: "Baserat på Bowlbys forskning om separationsreaktioner och modern inskolningsteori"
                ),
                readingTimeMinutes: 10
            ),
            // Module 5
            CourseModule(
                id: "ta-5",
                title: "Reparation efter konflikter",
                subtitle: "Det som sker efter brottet är viktigare än brottet",
                icon: "arrow.triangle.2.circlepath.circle.fill",
                introduction: """
                Ingen förälder är perfekt. Det kommer dagar då du tappar humöret, höjer rösten, reagerar överilat eller helt enkelt inte orkar vara den förälder du vill vara. Det här är normalt och mänskligt. Men det som gör skillnad för anknytningen är inte att du aldrig misslyckas – det är vad du gör efteråt. Reparation, att återställa relationen efter en bristning, är en av de mest kraftfulla anknytningsbyggande handlingarna som finns.

                Forskning av bland andra Ed Tronick visar att föräldra-barn-interaktioner naturligt rör sig mellan harmoni och disharmoni. I normala interaktioner är förälder och barn 'i synk' bara ungefär 30% av tiden – resten består av missförstånd och reparationer. Det är genom dessa ständiga cykler av brytning och reparation som barnet lär sig att relationer tål konflikter och att förtroendet kan återställas.

                Reparation kan se ut på många sätt. Det kan vara att säga förlåt med ord, att ge en kram, att sätta sig ner och prata om vad som hände eller att helt enkelt visa med din närvaro att allt är bra igen. Det viktiga är att du tar initiativet – du är den vuxne och det är ditt ansvar att reparera. Barnet ska aldrig behöva bära skulden för att relationen ska bli hel igen.

                Att reparera lär också barnet en ovärderlig livsfärdig: att konflikter inte behöver innebära slutet på en relation. Barn som ser sina föräldrar be om ursäkt och ta ansvar utvecklar själva en förmåga att hantera konflikter konstruktivt – i kompisrelationer, i skolan och senare i livet.
                """,
                keyPoints: [
                    "Alla föräldrar misslyckas ibland – det är reparationen som räknas",
                    "Det är föräldrens ansvar att ta initiativet till reparation, aldrig barnets",
                    "Att be om ursäkt visar styrka och lär barnet en viktig livskunskap",
                    "Reparation kan ske genom ord, kramar, närvaro eller lek – anpassa efter situationen",
                    "Barn som upplever reparation lär sig att relationer tål konflikter",
                    "Reparera så snart du kan – låt det inte gå för lång tid"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du tappade humöret och skrek åt ditt treåriga barn för att det spillde mjölken.",
                        wrongApproach: "Du skäms men säger ingenting. Du hoppas att barnet glömmer. Eller du rationaliserar: 'Barnet måste lära sig att vara försiktig.'",
                        rightApproach: "När du lugnat ner dig sätter du dig ner vid barnet och säger: 'Förlåt att jag skrek. Jag blev arg, men det var inte okej att skrika. Det var inte ditt fel att mjölken spilldes – det kan hända vem som helst. Jag älskar dig.' Du ger en kram.",
                        explanation: "Att erkänna ditt misstag och be om ursäkt visar barnet att du tar ansvar. Det visar att starka känslor kan hanteras, att relationer kan repareras och att barnet inte behöver vara rädd – du är fortfarande en trygg förälder."
                    ),
                    CourseExample(
                        scenario: "Du var så stressad på morgonen att du inte märkte att barnet försökte visa dig en teckning. Du sa 'Inte nu!' och barnet blev tyst och ledsen.",
                        wrongApproach: "Du tänker inte mer på det – det var ju en stressig morgon. Barnet var väl överdriven. 'Hen kan visa mig senare.'",
                        rightApproach: "Senare, kanske vid hämtningen eller hemma, säger du: 'Jag tänkte på att du ville visa mig något imorse och jag hade inte tid. Förlåt för det. Vill du visa mig nu? Jag vill jättegärna se.'",
                        explanation: "Att komma tillbaka till stunden visar barnet att du verkligen la märke till det, trots att du inte hade tid just då. Det reparerar känslan av att inte bli sedd och visar att barnet är viktigt för dig."
                    )
                ],
                exercise: CourseExercise(
                    title: "Reparationsövningen",
                    description: "Tänk tillbaka på en nyligen situation där du reagerade på ett sätt du inte är stolt över. Reparera den aktivt med ditt barn.",
                    steps: [
                        "Identifiera en situation de senaste dagarna där du reagerade överdrivet eller inte var den förälder du vill vara",
                        "Reflektera: vad triggade dig? Vad hade du behövt för att reagera annorlunda?",
                        "Formulera en ursäkt anpassad till barnets ålder: enkel och rak",
                        "Välj ett lugnt tillfälle att prata med barnet – inte mitt i vardagskaoset",
                        "Säg förlåt, förklara kort vad som hände och bekräfta din kärlek",
                        "Notera barnets reaktion och hur det kändes för dig"
                    ],
                    duration: "30 minuter"
                ),
                reflectionQuestions: [
                    "Hur svårt är det för dig att be om ursäkt – till ditt barn, och till andra?",
                    "Fick du höra föräldrar be om ursäkt när du växte upp? Hur påverkar det dig?",
                    "Finns det gamla reparationer du aldrig gjort som det kanske är dags att ta itu med?",
                    "Hur snabbt efter en konflikt brukar du reparera? Kan du bli snabbare?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att be sitt barn om ursäkt är för många föräldrar ovant och svårt. Men det gör en enorm skillnad.",
                    consensus: "De allra flesta vittnar om att barnen reagerar med överraskande generositet och förlåtelse – och att det stärker relationen att vara ärlig om sina misstag.",
                    quotes: [
                        "\"Jag sa förlåt till min treåring för att jag skrikit. Han kramade mig och sa 'Det gör inget mamma, alla blir arga ibland.' Jag grät.\" – Ida, mamma till William 3 år",
                        "\"Mina föräldrar sa aldrig förlåt. Det har tagit mig lång tid att lära mig. Men nu gör jag det med mina barn och det förändrar allt.\" – Michael, pappa till Saga 4 år och Vidar 2 år",
                        "\"Bästa man kan göra efter att ha skrikit: andas, ta en paus, och sen gå tillbaka och säga förlåt. Barnen förtjänar det.\" – Emma, mamma till tvillingar 5 år"
                    ],
                    source: "Baserat på Ed Tronicks forskning om 'rupture and repair' i föräldra-barn-relationer"
                ),
                readingTimeMinutes: 11
            ),
            // Module 6
            CourseModule(
                id: "ta-6",
                title: "Speciella situationer",
                subtitle: "Anknytning vid förändringar och utmaningar",
                icon: "star.leadinghalf.filled",
                introduction: """
                Livet med barn innebär oundvikligen förändringar och utmaningar som kan påverka anknytningen. Att få ett syskon, separera som föräldrar, flytta, börja på ny förskola eller hantera sjukdom – alla dessa händelser kräver extra uppmärksamhet på barnets anknytningsbehov. I dessa stunder kan barnet regrediera och visa beteenden som det 'vuxit ifrån', som att vilja ha napp igen, börja kissa i byxorna eller klamra sig fast.

                Regression är barnets sätt att signalera: 'Jag behöver mer trygghet just nu.' Det är inte ett tecken på att du gjort fel – det är ett normalt svar på stress. Det mest hjälpsamma du kan göra är att acceptera regressionen utan att kommentera den negativt, ge extra närhet och kärlek och lita på att barnet kommer tillbaka till sin vanliga nivå när det känner sig tryggt igen.

                Vid separation som föräldrar ställs anknytningsbehovet på sin spets. Barnet behöver veta att det fortfarande har en trygg relation till båda föräldrarna, att det inte var barnets fel och att båda föräldrarna fortfarande älskar det. Att hålla rutiner, vara konsekvent med lämningar och hämtningar och aldrig tala illa om den andra föräldern inför barnet är avgörande.

                Det finns också situationer som kräver särskild professionell hjälp: om du som förälder har egna anknytningssvårigheter från barndomen, om du lider av förlossningsdepression eller om du märker att ditt barn konsekvent undviker närhet eller är extremt klängigt. BVC och familjecentraler i Sverige erbjuder stöd – tveka aldrig att söka hjälp.
                """,
                keyPoints: [
                    "Barn regrederar vid stress – det är normalt och tillfälligt",
                    "Svara på regression med mer närhet, inte tillrättavisning",
                    "Vid separation behöver barnet trygg relation till båda föräldrarna",
                    "Håll rutiner stabila vid förändringar – förutsägbarhet ger trygghet",
                    "Prata aldrig illa om den andra föräldern inför barnet",
                    "Sök professionell hjälp vid förlossningsdepression eller allvarliga anknytningsproblem",
                    "BVC och familjecentraler finns som stöd – använd dem"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt treåriga barn har börjat kissa i byxorna igen efter att nya bebisen kom.",
                        wrongApproach: "Du säger irriterat: 'Du kan ju kissa på pottan! Du är stor nu, inte en bebis!' Du jämför med den nya bebisen: 'Bara bebisar kissar i blöjan.'",
                        rightApproach: "Du säger lugnt: 'Hoppsan, det blev vått. Det gör inget. Ska vi byta kläder?' Privat reflekterar du: barnet signalerar att det behöver extra trygghet. Du inför extra en-till-en-tid: 'Nu får lillasyster sova. Ska vi ha vår speciella stund?'",
                        explanation: "Regressionen är barnets sätt att säga 'Jag behöver också omvårdnad.' Att skälla förstärker otryggheten. Att ge extra närhet och speciell uppmärksamhet fyller barnets trygghetsbehov – och blöjfasen går över av sig själv."
                    ),
                    CourseExample(
                        scenario: "Du och din partner har separerat. Barnet säger: 'Är det mitt fel att pappa bor i en annan lägenhet?'",
                        wrongApproach: "Du säger: 'Nej, det är pappas fel. Han ville flytta.' Eller du undviker frågan: 'Prata inte om det, allt är bra.'",
                        rightApproach: "Du sätter dig ner, tar barnet i famnen och säger: 'Nej älskling, det är absolut inte ditt fel. Ibland kan inte vuxna bo tillsammans längre, men det har ingenting med dig att göra. Både mamma och pappa älskar dig precis lika mycket, och det kommer vi alltid att göra.'",
                        explanation: "Barn tar ofta på sig skulden vid separation. Att tydligt säga att det inte är barnets fel, att inte skylla på den andra föräldern och att försäkra om ovillkorlig kärlek från båda sidor ger den trygghet barnet behöver."
                    )
                ],
                exercise: CourseExercise(
                    title: "Beredskapsplan för förändringar",
                    description: "Skapa en plan för hur ni som familj stärker anknytningen vid kommande förändringar (nytt syskon, flytt, skolstart etc.).",
                    steps: [
                        "Identifiera vilka förändringar som är aktuella eller planerade i er familj",
                        "Skriv ner hur barnet brukar reagera på förändringar – regression? Ilska? Tillbakadragande?",
                        "Planera extra en-till-en-tid och närhet runt förändringen",
                        "Förbered barnet genom att prata om vad som ska hända – med enkla, ärliga ord",
                        "Håll så mycket som möjligt av rutinerna intakta under förändringen",
                        "Ha en plan för vem barnet kan söka trygghet hos om du inte kan vara tillgänglig"
                    ],
                    duration: "1-2 timmar att planera, löpande att genomföra"
                ),
                reflectionQuestions: [
                    "Vilka förändringar har påverkat ert barns anknytningsbeteende mest?",
                    "Hur hanterar du din egen stress vid förändringar? Påverkar det barnet?",
                    "Finns det stöd du behöver söka – BVC, familjerådgivning eller annat?",
                    "Hur pratar ni med barnet om svåra förändringar i familjen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Förändringar i familjen ställer anknytningen på prov – men med medvetenhet och stöd kan ni komma igenom starkare.",
                    consensus: "Gemensamt för föräldrarna är insikten att barn klarar förändringar bättre än man tror, så länge de har minst en trygg person som ser och bekräftar deras känslor.",
                    quotes: [
                        "\"När bebis nummer två kom regrederade mitt äldsta barn totalt. Med extra en-till-en-tid var allt tillbaka till normalt på tre veckor.\" – Olivia, mamma till Axel 3 år och Emil 3 mån",
                        "\"Vi separerade och jag var livrädd. Men vi höll rutinerna, pratade öppet och sökte stöd på familjecentralen. Barnen klarade det.\" – Johan, pappa till Elsa 4 år och Hugo 2 år",
                        "\"Jag hade förlossningsdepression och kunde inte knyta an ordentligt först. Att söka hjälp var det bästa jag gjort – nu i efterhand har vi en fantastisk relation.\" – Lena, mamma till Vilma 2 år"
                    ],
                    source: "Baserat på forskning om anknytning vid livshändelser och klinisk praxis från BVC"
                ),
                readingTimeMinutes: 12
            )
        ],
        targetAudience: "Föräldrar med barn 0-4 år",
        estimatedWeeks: 6
    )
}

// MARK: - Course 3: Sömn utan tårar

extension Course {
    static let somnUtanTarar = Course(
        id: "somn-utan-tarar",
        title: "Sömn utan tårar",
        subtitle: "Trygg väg till bättre sömn för hela familjen",
        description: "En mild och evidensbaserad kurs om barns sömn. Lär dig förstå ditt barns sömnbiologi, skapa trygga rutiner och hitta metoder som fungerar utan att lämna ditt barn att gråta ensamt. Anpassad för svenska föräldrar med barn 0-3 år.",
        icon: "moon.stars.fill",
        gradient: LinearGradient(colors: [Color(hex: "1B3A5C"), Color(hex: "4A7FB5")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            // Module 1
            CourseModule(
                id: "sut-1",
                title: "Hur bebisar sover",
                subtitle: "Sömnens vetenskap för de allra minsta",
                icon: "brain.fill",
                introduction: """
                Att förstå hur barns sömn faktiskt fungerar biologiskt är det första steget mot att hantera sömnproblem utan frustration. Bebisar sover inte som vuxna – och det finns goda evolutionära skäl till det. Deras sömnmönster har utvecklats under hundratusentals år för att maximera överlevnad, och det innebär frekventa uppvaknanden, korta sömncykler och ett stort behov av närhet.

                En vuxen sömncykel är ungefär 90 minuter. En nyfödds sömncykel är bara 40-50 minuter. Det betyder att en bebis passerar genom lätt sömn mycket oftare – och vid varje övergång finns en risk att barnet vaknar. Det är därför bebisar vaknar ofta, inte för att de är 'dåliga sovare' utan för att deras hjärnor fungerar annorlunda. Dessutom har bebisar en mycket högre andel REM-sömn (drömsömn), som är viktig för hjärnans utveckling men som innebär lättare sömn.

                En annan viktig faktor är att bebisar inte har en utvecklad dygnsrytm (cirkadisk rytm) förrän vid ungefär 3-4 månaders ålder. Dessförinnan kan de inte skilja på dag och natt. Det är först då melatoninproduktionen kommer igång och barnet gradvis börjar sova längre perioder på natten. Att försöka träna en nyfödd att sova genom natten är därför biologiskt omöjligt.

                Den goda nyheten är att sömnmönstret förändras naturligt med mognad. Varje månad sover barnet lite längre, lite djupare och med allt tydligare rytm. Din roll är inte att tvinga barnet att sova på ett visst sätt, utan att skapa de bästa förutsättningarna för att sömnen ska utvecklas naturligt.
                """,
                keyPoints: [
                    "Bebisars sömncykler är kortare (40-50 min) än vuxnas (90 min)",
                    "Frekventa uppvaknanden är biologiskt normalt – inte ett tecken på problem",
                    "Dygnsrytmen utvecklas inte förrän vid 3-4 månaders ålder",
                    "REM-sömn (som innebär lättare sömn) är viktig för hjärnans utveckling",
                    "Sömnen mognar naturligt – du kan inte forcera den",
                    "Nattamning/matning är normalt och nödvändigt under hela första året",
                    "Att jämföra ditt barns sömn med andras skapar onödig stress"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din tremånadersbebis vaknar varannan timme på natten. Du är utmattad och undrar om du gör något fel.",
                        wrongApproach: "Du googlar 'lära bebis sova genom natten' och hittar metoder som säger att du ska låta bebisen gråta. Du testar, bebisen skriker i en timme, och du känner dig hemsk.",
                        rightApproach: "Du påminner dig att varannan timme är normalt vid tre månader. Du anpassar genom att sova när bebisen sover, be om avlösning av partnern och sänka förväntningarna. Du vet att detta är en fas som kommer förändras.",
                        explanation: "Att förstå att beteendet är normalt minskar stressen enormt. Problemet är ofta inte barnets sömn utan förälderns förväntningar. Att anpassa livet efter verkligheten istället för att försöka ändra barnets biologi är nyckeln."
                    ),
                    CourseExample(
                        scenario: "Din kompis berättar att hennes bebis sover 12 timmar varje natt utan uppvaknanden. Din bebis vaknar 4-5 gånger.",
                        wrongApproach: "Du tänker: 'Vad gör jag fel? Varför är mitt barn annorlunda?' Du börjar tvivla på dig själv och prövar allt möjligt för att ändra situationen.",
                        rightApproach: "Du tänker: 'Alla barn är olika. Min bebis vaknar ofta, men det kommer att förändras med tiden. Min kompis bebis kanske vaknar mer nästa månad – sömnen ändras hela tiden.' Du fokuserar på vad som fungerar för er familj.",
                        explanation: "Att jämföra är en av de vanligaste sömnfällorna. Forskningen visar att det finns en enorm naturlig variation i barns sömn. En bebis som 'sover hela natten' vid två månader kan ha en sömnregression vid fyra månader. Det jämnar ut sig."
                    )
                ],
                exercise: CourseExercise(
                    title: "Sömndagbok",
                    description: "För en enkel sömndagbok under en vecka. Notera inte bara när barnet sover utan även dina egna förväntningar och reaktioner.",
                    steps: [
                        "Notera ungefärliga sovtider, uppvaknanden och hur barnet somnar om (amning, vaggning etc.)",
                        "Notera inte bara barnets sömn utan även din egen känsla: frustrerad, lugn, trött, accepterande",
                        "Titta efter mönster: vaknar barnet vid ungefär samma tider? Finns det en begynnande rytm?",
                        "Räkna den totala sömnen under dygnet (inte bara natten)",
                        "Jämför med åldersadekvata riktlinjer (inte med kompisbebisen)",
                        "Reflektera: vilka uppvaknanden kan du hantera och vilka är svårast?"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vad har format dina förväntningar på barns sömn? Stämmer de med verkligheten?",
                    "Hur påverkar ditt barns sömn din egen hälsa och ditt välmående?",
                    "Vilka uppvaknanden kan du 'acceptera' och vilka upplever du som problematiska?",
                    "Vad skulle förändras om du slutade se ditt barns sömn som ett problem att lösa?"
                ],
                forumSection: CourseForumSection(
                    intro: "Sömnbrist är en av de tuffaste delarna av småbarnslivet. Att förstå att det är normalt hjälper – men det tar inte bort tröttheten.",
                    consensus: "Den vanligaste insikten är att 'alla andra bebisars' sömn inte heller är perfekt – folk överdriver på föräldraplattformar. Och att acceptans ofta hjälper mer än fler sömnmetoder.",
                    quotes: [
                        "\"Jag slutade räkna uppvaknanden och började bara räkna hur många gånger jag somnade om snabbt. Det ändrade hela perspektivet.\" – Amanda, mamma till Wilmer 5 mån",
                        "\"Min partner tog över en nattmatning med flaska. Jag fick sova 5 timmar i sträck och det räddade mitt förstånd.\" – Julia, mamma till Livia 4 mån",
                        "\"Alla sa 'vänta till 4 månader så sover hon igenom'. Vid 4 månader kom 4-månadersregressionen. Jag önskar någon sagt att det tar tid – men att det kommer.\" – Viktor, pappa till Majken 7 mån"
                    ],
                    source: "Baserat på sömnforskning av Jodi Mindell och James McKenna"
                ),
                readingTimeMinutes: 12
            ),
            // Module 2
            CourseModule(
                id: "sut-2",
                title: "Åldersanpassade förväntningar",
                subtitle: "Vad som är normalt vid varje ålder",
                icon: "chart.bar.fill",
                introduction: """
                En av de vanligaste orsakerna till sömnstress hos föräldrar är orealistiska förväntningar. Sociala medier, välmenande släktingar och till och med en del professionella ger bilden att alla barn 'borde' sova igenom natten vid sex månader. Sanningen är att det finns en enorm variation – och att de flesta barn vaknar en eller flera gånger under natten långt in på andra levnadsåret.

                Under de första tre månaderna är det helt normalt med 3-6 uppvaknanden per natt. Bebisen behöver äta ofta, har korta sömncykler och saknar dygnsrytm. Mellan 3-6 månader börjar sömnen konsolideras, men den fruktade fyramånadersregressionen kan tillfälligt försämra sömnen. Detta är egentligen inte en regression utan en framgång – hjärnan utvecklas och sömnmönstret ändras.

                Mellan 6-12 månader kan många barn sova längre nattliga perioder, men uppvaknanden för tröstamning eller närhet är fortfarande normalt. Separationsångest runt 8-9 månader kan tillfälligt öka uppvaknandena. Under andra levnadsåret minskar de flesta uppvaknandena gradvis, men tänder, sjukdom, utvecklingssprång och mardrömmar kan skapa tillfälliga perioder av mer störd sömn.

                Det viktigaste är att förstå att sömnmognad inte är linjär. Det går inte konstant uppåt – det finns toppar och dalar. En vecka sover barnet fantastiskt, nästa vecka vaknar det fem gånger per natt. Det är normalt och det är tillfälligt. Att ha realistiska förväntningar skyddar dig från frustration och onödiga insatser.
                """,
                keyPoints: [
                    "0-3 månader: 3-6 uppvaknanden per natt är normalt, ingen dygnsrytm",
                    "3-6 månader: dygnsrytm etableras, 4-månadersregressionen är en utvecklingsfas",
                    "6-12 månader: längre nattperioder möjliga men uppvaknanden fortfarande normala",
                    "12-24 månader: gradvis förbättring men tillfälliga försämringar vid sjukdom och utvecklingssprång",
                    "Sömnmognad är inte linjär – förvänta dig toppar och dalar",
                    "Nattamning under hela första året rekommenderas av WHO"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din niomånadersbebis som sov bra börjar plötsligt vakna 4-5 gånger per natt. Morföräldrarna säger: 'Hen manipulerar er.'",
                        wrongApproach: "Du tror att barnet 'blivit bortskämt' och bestämmer dig för att sluta ta upp barnet. Du ligger vaken och hör det gråta medan du kämpar med dåligt samvete.",
                        rightApproach: "Du vet att 8-9 månader är en vanlig period för separationsångest och kognitivt utvecklingssprång. Du svarar med extra närhet, kanske samnattning tillfälligt, och säger till morföräldrarna: 'Tack för omtanken, men det är en vanlig fas – det kommer gå över.'",
                        explanation: "Bebisar vid 9 månader kan inte manipulera – den kognitiva förmågan finns helt enkelt inte. Separationsångest och utvecklingssprång orsakar tillfälligt ökade uppvaknanden. Att svara med närhet hjälper barnet genom fasen snabbare."
                    ),
                    CourseExample(
                        scenario: "Ditt 14 månader gamla barn vaknar fortfarande två gånger per natt för att amma. BVC-sköterskan antyder att det är dags att nattavvänja.",
                        wrongApproach: "Du nattavvänjer abrupt genom att låta partnern gå in och neka barnet bröst. Barnet gråter i protest flera nätter i rad.",
                        rightApproach: "Du reflekterar: stör uppvaknandena mig och barnet, eller är det mest andras åsikter? Om du vill nattavvänja gör du det gradvis – kortar amningstiderna, erbjuder vatten istället och ger extra närhet. Om du är nöjd med situationen säger du till BVC: 'Det fungerar för oss.'",
                        explanation: "Det finns inget magiskt datum då nattamning 'borde' sluta. Både WHO och Socialstyrelsen stödjer amning upp till två år och längre. Beslutet om nattavvänjning bör baseras på familjens behov – inte andras åsikter."
                    )
                ],
                exercise: CourseExercise(
                    title: "Förväntnings-check",
                    description: "Gå igenom dina förväntningar på barnets sömn och jämför dem med åldersadekvata riktlinjer. Justera förväntningarna vid behov.",
                    steps: [
                        "Skriv ner: Hur många timmar förväntar du dig att ditt barn sover per natt? Hur många uppvaknanden?",
                        "Slå upp åldersadekvata riktlinjer (vi tillhandahåller dem i kursmaterialet)",
                        "Jämför: stämmer dina förväntningar med verkligheten?",
                        "Identifiera var du fått dina förväntningar ifrån (sociala medier, släktingar, böcker)",
                        "Justera förväntningarna till realistiska nivåer",
                        "Bestäm vad du behöver för att klara av den faktiska situationen (avlösning, tidigare läggning för dig själv)"
                    ],
                    duration: "30 minuter"
                ),
                reflectionQuestions: [
                    "Varifrån kommer dina förväntningar på barnets sömn?",
                    "Hur mycket av din sömnstress handlar om andras åsikter vs. er egen verklighet?",
                    "Vad skulle förändras i din vardag om du accepterade att uppvaknanden är normala?",
                    "Kan du hitta en balans mellan att söka förändring och att acceptera nuläget?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att inse att ens förväntningar var orealistiska är lättnad för många – men det kan också vara svårt att acceptera.",
                    consensus: "Många föräldrar delar att den största förändringen var att sluta kämpa mot barnets sömn och istället anpassa sig. Paradoxalt nog förbättrades sömnen ofta efteråt.",
                    quotes: [
                        "\"Jag trodde att 'sova igenom natten' betydde 12 timmar utan uppvaknanden. I verkligheten är 5 timmars sammanhängande sömn redan 'genom natten' för en bebis.\" – Nathalie, mamma till Melvin 6 mån",
                        "\"Min svärmor sa att mina barn 'sov igenom vid 3 månader'. Min svärfar avslöjade att hon glömt bort alla uppvaknanden. Minnesbilden ljuger!\" – Oscar, pappa till Ellie 8 mån",
                        "\"Jag slutade följa sömnkonton på Instagram och mådde 100 gånger bättre. Jämförelsen dödade mig.\" – Filippa, mamma till Albin 10 mån"
                    ],
                    source: "Baserat på Jodi Mindells sömnforskning och svenska BVC-riktlinjer"
                ),
                readingTimeMinutes: 11
            ),
            // Module 3
            CourseModule(
                id: "sut-3",
                title: "Milda sömnmetoder",
                subtitle: "Hjälp barnet sova utan att lämna det ensamt",
                icon: "hand.raised.fingers.spread.fill",
                introduction: """
                Det finns ett brett spektrum av sömnmetoder, från att låta barnet gråta ensamt ('cry it out') till att aldrig ändra något alls. Milda metoder befinner sig i mitten – de syftar till att gradvis hjälpa barnet utveckla sömnfärdigheter medan du fortfarande erbjuder närvaro och tröst. Det handlar inte om att barnet aldrig får gråta, utan om att det aldrig behöver gråta ensamt.

                En av de mest kända milda metoderna är 'fade out' (gradvis tillbakadragande). Det innebär att du gradvis minskar din hjälp vid insomningen. Om du idag vaggar barnet i sömn, kanske du nästa vecka vaggar tills det är nästan somnigt och sedan lägger ner det. Veckan efter lägger du ner det lite mer vaket. Varje steg görs i barnets takt, med dig som trygg närvaro.

                En annan metod är 'pick up/put down' där du tröstar barnet genom att ta upp det om det gråter och lägga ner det igen när det lugnat sig – upprepat tills det somnar. Det kan vara utmattande på kort sikt men många föräldrar upplever att det fungerar väl utan att bryta anknytningen.

                Det viktigaste med alla sömnmetoder är konsistens och att du väljer en metod du känner dig bekväm med. Om en metod gör att du mår dåligt, fungerar den inte – oavsett vad forskningen säger. Ditt barn mår bäst med en förälder som är lugn och trygg i sitt val, inte en som gör något som känns fel. Lita på din magkänsla och anpassa råden efter er familj.
                """,
                keyPoints: [
                    "Milda metoder innebär att barnet aldrig behöver gråta ensamt",
                    "Gradvis tillbakadragande (fade out) ändrar sömnassociationer stegvis",
                    "Konsistens är viktigare än vilken specifik metod du väljer",
                    "Välj en metod du mår bra med – din trygghet påverkar barnets trygghet",
                    "Alla förändringar tar tid – ge varje metod minst en vecka",
                    "Det är helt okej att amma, vagga eller bära barnet i sömn om det fungerar för er"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vill att ditt niomånadersbarn ska somna utan att bli vaggat i sömn, men det gråter varje gång du lägger ner det.",
                        wrongApproach: "Du lägger ner barnet och går ut ur rummet. Barnet skriker. Du väntar 5 minuter, går in, lägger ner barnet igen och går. Cykeln upprepas i en timme.",
                        rightApproach: "Du vaggar som vanligt men lägger ner barnet lite tidigare – när det är somnigt men inte helt sovet. Du behåller handen på barnets mage och sjunger din vanliga sång. Om det gnäller, shyschar du lugnt. Om det gråter tar du upp det, tröstar och provar igen. Det kan ta en vecka av gradvis förändring.",
                        explanation: "Gradvis förändring respekterar barnets behov av trygghet. Varje steg är litet nog för att barnet ska klara det med din närvaro. Det tar längre tid men skapar ingen stress – varken för barnet eller dig."
                    ),
                    CourseExample(
                        scenario: "Ditt ettårsbarn somnar bara vid bröstet och vaknar varje gång du försöker flytta det till spjälsängen.",
                        wrongApproach: "Du bestämmer att amningen vid insomning måste sluta omedelbart. Du ersätter med napp och barnet protesterar våldsamt i tre kvällar.",
                        rightApproach: "Du börjar amma barnet somnigt men inte i djupsömn. Du bryter amningstaget försiktigt och håller barnet nära medan det somnar de sista sekunderna utan bröstet. Gradvis ökar du tiden mellan att bröstet lämnar och att barnet somnar. Det kan ta 2-3 veckor.",
                        explanation: "Att bryta kopplingen mellan amning och djupsömn görs bäst gradvis. Barnet lär sig att det kan somna med dig nära, men utan att suga – ett steg i taget. Att slita bort bröstet abrupt skapar stress för alla."
                    )
                ],
                exercise: CourseExercise(
                    title: "Hitta din metod",
                    description: "Utvärdera var ni står idag med sömnrutinerna och välj en mild metod som passar er familj.",
                    steps: [
                        "Beskriv hur barnet somnar idag: amning, vaggning, barnvagn, biltur?",
                        "Bestäm: vad vill du förändra? Och varför? (Är det ditt behov eller andras förväntningar?)",
                        "Läs igenom de milda metoderna och välj den som känns mest rätt för dig",
                        "Prata med din partner om planen – ni behöver vara överens",
                        "Börja med ett litet steg – inte hela förändringen på en gång",
                        "Ge det minst en vecka och utvärdera: fungerar det? Mår alla bra?"
                    ],
                    duration: "1-3 veckor"
                ),
                reflectionQuestions: [
                    "Vad vill du egentligen förändra med barnets sömn – och varför?",
                    "Är ditt önskemål om förändring baserat på ditt behov eller andras förväntningar?",
                    "Vilken metod känns mest rätt i magen för dig? Lita på den känslan.",
                    "Vad är du beredd att acceptera – och vad behöver faktiskt förändras?"
                ],
                forumSection: CourseForumSection(
                    intro: "Valet av sömnmetod väcker starka känslor. Här delar föräldrar vad som fungerade för dem – och vad som inte gjorde det.",
                    consensus: "Det gemensamma är att det inte finns EN metod som fungerar för alla. Det viktigaste är att metoden känns rätt för föräldern – barn känner av förälderns stress.",
                    quotes: [
                        "\"Vi provade fade out och det tog tre veckor, men nu somnar hon med min hand på ryggen. Inga tårar, bara tålamod.\" – Linnéa, mamma till Tuva 9 mån",
                        "\"Jag ville nattavvänja men det kändes fel. Så jag väntade till 15 månader och då gick det nästan av sig själv.\" – Martin, pappa till Tilde 18 mån",
                        "\"Bästa rådet jag fick: 'Det som fungerar är rätt. Om amning till sömn funkar – gör det.' Jag slutade skämmas.\" – Cornelia, mamma till Oliver 7 mån"
                    ],
                    source: "Baserat på Elizabeth Pantleys 'No Cry Sleep Solution' och Sarah Ockwell-Smiths forskning"
                ),
                readingTimeMinutes: 11
            ),
            // Module 4
            CourseModule(
                id: "sut-4",
                title: "Kvällsrutinens magi",
                subtitle: "Skapa en trygg och förutsägbar väg till sömn",
                icon: "bed.double.fill",
                introduction: """
                Om det är en enda sak du gör för ditt barns sömn, låt det vara att skapa en konsekvent kvällsrutin. Forskning visar att en förutsägbar sekvens av aktiviteter före sängen är den enskilt mest effektiva insatsen för bättre barnsömn. Det handlar inte om att rutinen måste vara lång eller komplicerad – det handlar om att den är densamma varje kväll.

                Kvällsrutinen fungerar som en fysiologisk nedvarvning. När barnet gör samma saker i samma ordning varje kväll, börjar kroppen förbereda sig för sömn redan vid första steget. Det är en slags betingning: badet signalerar att det snart är sovdags, boken signalerar att sängen kommer, och den sista sången signalerar att det är dags att somna. Med tiden reagerar kroppen automatiskt med sömnighet.

                En bra kvällsrutin för de flesta barn inkluderar: en lugn aktivitet (bad eller tvättning), ta på pyjamas, borsta tänder (när de finns), läsa en bok och en avslutande ritual som en sång eller en speciell fras. Det hela bör ta 20-40 minuter och vara så lugn och dämpad som möjligt. Undvik skärmar, hög aktivitetsnivå och starka ljus den sista timmen före sängen.

                Det är viktigt att båda föräldrarna kan genomföra kvällsrutinen. Om bara en förälder 'fungerar' blir det en sårbarhet i familjen. Att växla är inte bara praktiskt utan stärker också barnets anknytning till båda föräldrarna. I början kanske barnet protesterar mot den 'nya' föräldern vid sängen, men med konsistens och tålamod etableras en ny, lika trygg rutin.
                """,
                keyPoints: [
                    "En konsekvent kvällsrutin är den mest effektiva sömninsatsen",
                    "Rutinen behöver inte vara lång – 20-40 minuter räcker",
                    "Samma saker, i samma ordning, varje kväll ger förutsägbarhet",
                    "Undvik skärmar och hög aktivitet minst en timme före sängen",
                    "Båda föräldrarna bör kunna genomföra rutinen",
                    "Dimma belysningen på kvällen – ljus hämmar melatoninet"
                ],
                examples: [
                    CourseExample(
                        scenario: "Kvällen hemma hos er är kaotisk. Barnet är överstimulerat och vägrar gå och lägga sig.",
                        wrongApproach: "Barnet tittar på surfplattan ända fram till läggdags. Du säger 'Nu ska du sova!' och bär iväg ett överstimulerat barn som är för uppjagat för att somna.",
                        rightApproach: "Du stänger av alla skärmar en timme före sängen och dimmar belysningen. Ni gör samma sak varje kväll: bad, pyjamas, tänder, två böcker, en sång och en sista kram. 'Nu har vi gjort alla våra kväll-saker. God natt älskling.'",
                        explanation: "En konsekvent rutin ger barnets nervsystem tid att varva ner. Skärmar hämmar melatonin och stimulerar hjärnan. Med en tydlig rutin vet barnet att sömnen kommer – det behöver inte kämpa emot."
                    ),
                    CourseExample(
                        scenario: "Barnet vill bara att mamma lägger. Pappa blir ledsen och frustrerad.",
                        wrongApproach: "Mamma lägger alltid 'för att det är enklast'. Pappa slutar försöka och drar sig undan från kvällsrutinen helt.",
                        rightApproach: "Ni bestämmer att pappa lägger varannan kväll. Första veckan protesterar barnet, men pappa har sin egen variant av rutinen – kanske läser han med roliga röster eller sjunger en annan sång. 'Mamma lägger imorgon. Ikväll är det du och pappa-tid!'",
                        explanation: "Att växla bygger resiliens och stärker barnets anknytning till båda föräldrarna. Det blir jobbigare kortsiktigt men bättre långsiktigt. Pappans egna touch gör kvällsrutinen speciell på sitt sätt."
                    )
                ],
                exercise: CourseExercise(
                    title: "Designa er kvällsrutin",
                    description: "Skapa en skräddarsydd kvällsrutin för er familj. Testa den konsekvent i två veckor.",
                    steps: [
                        "Bestäm en fast läggdags som passar barnets ålder (tipsa om riktlinjer)",
                        "Välj 4-5 steg för kvällsrutinen (t.ex. bad, pyjamas, tänder, bok, sång)",
                        "Gör en liten affisch med bilder av stegen som barnet kan följa",
                        "Bestäm hur ni växlar mellan föräldrar – kanske varannan kväll?",
                        "Börja rutinen vid samma tid varje kväll i minst två veckor",
                        "Utvärdera: somnar barnet lättare? Hur lång tid tar det?"
                    ],
                    duration: "Två veckor"
                ),
                reflectionQuestions: [
                    "Hur ser er kvällsrutin ut idag? Vad fungerar och vad fungerar inte?",
                    "Hur mycket skärmtid har barnet den sista timmen före sängen?",
                    "Kan båda föräldrarna lägga barnet? Om inte – vad kan ni göra åt det?",
                    "Vilken del av kvällsrutinen är mysigast för er? Hur kan ni värna om den?"
                ],
                forumSection: CourseForumSection(
                    intro: "Kvällsrutinen är det som flest föräldrar kallar 'det som faktiskt fungerade' när det gäller sömn.",
                    consensus: "Den genomgående erfarenheten är att konsistens är allt. Det spelar nästan ingen roll exakt vad ni gör – bara att ni gör det likadant varje kväll.",
                    quotes: [
                        "\"Vi införde en fast rutin: bad, bok, sång, sova. Tredje kvällen gäspade sonen redan i badet. Kroppen förstod!\" – Johanna, mamma till Felix 11 mån",
                        "\"Pappa hade egna böcker och egna sånger. Först var det kris, men nu älskar hon 'pappa-kvällar' lika mycket.\" – Emil, pappa till Ada 2 år",
                        "\"Vi dimmade alla lampor hemma kl 18 och det var som att trycka på en sovknapp. Melatoninet kickar in!\" – Sandra, mamma till Tim 8 mån"
                    ],
                    source: "Baserat på Jodi Mindells forskning om kvällsrutiners effekt på barns sömn"
                ),
                readingTimeMinutes: 10
            ),
            // Module 5
            CourseModule(
                id: "sut-5",
                title: "Nattliga uppvaknanden",
                subtitle: "Strategier för att alla ska få sova",
                icon: "zzz",
                introduction: """
                Nattliga uppvaknanden är förmodligen den del av småbarnslivet som sliter mest på föräldrar. Att bli väckt flera gånger per natt, natt efter natt, påverkar din hälsa, ditt humör, dina relationer och din förmåga att fungera i vardagen. Det är helt legitimt att vilja förändra situationen – frågan är hur man gör det på ett sätt som respekterar barnets behov.

                Först är det viktigt att förstå varför barn vaknar på natten. Ibland är det hunger, ibland obehag (blöja, temperatur), ibland sjukdom eller tänder. Men den vanligaste orsaken är att barnet passerar genom lätt sömn och inte kan somna om på egen hand utan den hjälp det fick vid insomningen. Om barnet somnade vid bröstet, kommer det söka bröstet vid varje uppvaknande. Om det vaggades i sömn, vill det vaggas igen. Detta kallas sömnassociation.

                Att förändra sömnassociationer är möjligt – men det bör göras gradvis och med hänsyn till barnets ålder och temperament. En strategi är att separera insomningshjälpen från själva sängen: amma eller vagga barnet somnigt men inte i djupsömn och sedan lägga det vaket i sängen med din hand på magen. En annan strategi är att gradvis minska tiden du vaggar eller ammar – lite mindre varje kväll.

                Det finns också praktiska strategier som inte handlar om att förändra barnets beteende utan om att anpassa ditt. Samnattning (om det görs säkert), att dela upp natten mellan föräldrar, att ha barnets säng nära din eller att ligga kvar tills barnet somnat om – allt detta kan göra nattuppvaknandena mindre störande utan att barnet behöver förändras. Ibland handlar lösningen om att ändra ramarna, inte barnet.
                """,
                keyPoints: [
                    "Sömnassociationer (amning, vaggning) är den vanligaste orsaken till frekventa uppvaknanden",
                    "Att ändra sömnassociationer görs bäst gradvis och med närvaro",
                    "Dela upp natten mellan föräldrar – ingen behöver ta alla uppvaknanden",
                    "Samnattning kan vara en lösning om det görs säkert (Socialstyrelsen har riktlinjer)",
                    "Ibland handlar lösningen om att ändra dina ramar, inte barnets beteende",
                    "Tröstamning på natten ger tröst och kalorier – det är inte en 'dålig vana'"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt tiomånadersbarn vaknar 5-6 gånger per natt och vill amma varje gång. Du är helt slutkörd.",
                        wrongApproach: "Du bestämmer att nattamningen ska sluta helt från och med ikväll. Partnern får gå in och trösta med vatten. Barnet gråter desperat i timmar.",
                        rightApproach: "Du börjar med att korta amningstiderna – om barnet brukar amma i 15 minuter, kortar du till 10, sedan 7, sedan 5. Partnern erbjuder alternativ tröst (hålla, klappa, sjunga) vid de uppvaknanden där du inte ammar. Ni minskar gradvis under 2-3 veckor.",
                        explanation: "Gradvis minskning ger barnets kropp tid att anpassa sig. Att plötsligt ta bort all nattamning kan vara traumatiskt och leda till värre sömn. Med gradvis förändring kan barnet lära sig andra tröststrategier i sin egen takt."
                    ),
                    CourseExample(
                        scenario: "Du och din partner bråkar om vem som ska gå upp till barnet på natten. Ni är båda sömnberövade och arga.",
                        wrongApproach: "Ni räknar exakt vem som gått upp flest gånger och beskyller varandra: 'Du gick bara upp en gång igår natt!' Konflikten eskalerar.",
                        rightApproach: "Ni sätter er ner en kväll (inte mitt i natten) och gör en plan. Kanske tar en förälder första halvan av natten och den andra sista halvan. Eller varannan natt. 'Vi är ett lag – hur fördelar vi detta rättvist så att vi båda orkar?'",
                        explanation: "Sömnbrist gör oss till sämre versioner av oss själva. Att ha en plan före natten – inte mitt i den – minskar konflikter. Tydlig fördelning ger vardera förälder åtminstone en period av sammanhängande sömn."
                    )
                ],
                exercise: CourseExercise(
                    title: "Natt-planen",
                    description: "Skapa en tydlig plan för hur ni hanterar nattuppvaknanden som ett team.",
                    steps: [
                        "Identifiera alla nattuppvaknanden: vid vilka tider, vad behöver barnet?",
                        "Sortera: vilka uppvaknanden kräver mat och vilka är tröst/sömnassociation?",
                        "Fördela ansvaret: vem tar vilka uppvaknanden, vilka nätter?",
                        "Bestäm strategin: gradvis minskning, alternativ tröst eller anpassade ramar?",
                        "Ge planen minst två veckor innan ni utvärderar",
                        "Justera efter behov – flexibilitet är viktigt"
                    ],
                    duration: "Två veckor"
                ),
                reflectionQuestions: [
                    "Hur påverkar sömnbristen dig, din relation och din förmåga att vara förälder?",
                    "Vilka nattuppvaknanden kan du 'leva med' och vilka behöver förändras?",
                    "Hur samarbetar du och din partner kring natten? Vad kan bli bättre?",
                    "Finns det praktiska lösningar (samnattning, bättre fördelning) ni inte provat?"
                ],
                forumSection: CourseForumSection(
                    intro: "Nattuppvaknanden är det ämne som väcker mest frustration och desperation bland föräldrar. Du är inte ensam.",
                    consensus: "Det som hjälpte mest var inte att hitta den perfekta metoden utan att dela upp natten rättvist, sänka förväntningarna och stötta varandra.",
                    quotes: [
                        "\"Vi delade natten i två pass. Jag tog 21-02 och han tog 02-07. Att veta att man får sova 5 timmar i sträck räddade oss.\" – Sarah, mamma till Noah 9 mån",
                        "\"Vi tog in barnsängen i vårt sovrum. Alla sov bättre direkt – ingen behövde gå upp och gå till ett annat rum.\" – Alexander, pappa till Vera 11 mån",
                        "\"Min son ammade 6 gånger per natt vid 10 månader. Jag kortade gradvis. Vid 13 månader var vi nere på 1 gång. Tålamod funkar.\" – Josefin, mamma till Ludvig 14 mån"
                    ],
                    source: "Baserat på forskning om sömnassociationer och säker samnattning (La Leche League, Socialstyrelsen)"
                ),
                readingTimeMinutes: 12
            ),
            // Module 6
            CourseModule(
                id: "sut-6",
                title: "Tuppar och sömnövergångar",
                subtitle: "Navigera dagssömnen och dess förändringar",
                icon: "sun.and.horizon.fill",
                introduction: """
                Dagssömnen (tuppar eller tupplurar) är ofta mer komplicerad att hantera än nattsömnen. Bebisar börjar med 3-4 tuppar om dagen som gradvis minskar till 2, sedan 1 och slutligen ingen alls. Varje övergång kan vara turbulent och påverka nattsömnen. Att förstå dessa övergångar och navigera dem med kunskap gör vardagen mycket smidigare.

                Under de första månaderna har bebisen ingen fast dagssömnrytm – hen sover och vaknar i ett oregelbundet mönster. Runt 3-4 månaders ålder börjar ett mönster framträda med 3-4 tuppar. Vid 6-8 månader minskar de flesta barn till 2 tuppar, och runt 12-18 månader sker övergången till 1 tupp. Denna sista tupp kan hålla i sig till 3-4 års ålder hos vissa barn, medan andra slutar tuppa redan vid 2.

                Övergångar mellan antalet tuppar är ofta röriga perioder. Barnet är för trött med för få tuppar men vägrar somna med det gamla antalet. Det kan leda till övertrötthet, vilket paradoxalt nog gör det svårare att somna. Under dessa perioder kan det hjälpa att vara flexibel: en dag kanske barnet behöver tre tuppar, nästa dag klarar det sig med två. Övergången tar ofta 2-4 veckor.

                En vanlig fälla är att tro att om barnet hoppar över sin tupp så kommer det att sova bättre på natten. Tyvärr fungerar det sällan så – ett övertrött barn sover ofta sämre, inte bättre. Uttrycket 'sömn föder sömn' stämmer ofta, särskilt under de första två åren. Ett välvilat barn somnar lättare och sover djupare.
                """,
                keyPoints: [
                    "Antalet tuppar minskar naturligt: 3-4 → 2 → 1 → 0",
                    "Övergångar mellan antal tuppar tar 2-4 veckor och kan vara rörigt",
                    "Ett övertrött barn sover sämre, inte bättre – 'sömn föder sömn'",
                    "Var flexibel under övergångar – barnet kan behöva olika från dag till dag",
                    "Tidig eftermiddagstupp påverkar nattsömnen positivt",
                    "Tuppen försvinner naturligt – tvinga inte barnet att sluta tuppa"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt sjumånadersbarn vägrar den tredje tuppen men blir övergrinig varje kväll.",
                        wrongApproach: "Du insisterar på tre tuppar och tvingar barnet i vagnen. Barnet gråter och vägrar. Alternativt skiter du i det och hoppas det löser sig.",
                        rightApproach: "Du inser att barnet är mitt i övergången 3→2 tuppar. Du flyttar läggdags 30-45 minuter tidigare tillfälligt för att kompensera. Några dagar behöver hen tre tuppar, andra dagar klarar hen sig med två. Du anpassar dig efter barnets signaler.",
                        explanation: "Övergångsperioder kräver flexibilitet. Att flytta läggdags tidigare kompenserar för den förlorade tuppen. Att tvinga en tupp skapar onödig stress – det är bättre att följa barnets signaler och låta övergången ske naturligt."
                    ),
                    CourseExample(
                        scenario: "Ditt tvååriga barn som tuppar en timme om dagen har börjat sova dåligt på natten. Farmor säger: 'Sluta med tuppen.'",
                        wrongApproach: "Du stryker tuppen helt. Barnet klarar två dagar och sedan rasar det ihop – övergrinig, tårar, ohanterlig. Nattsömnen blir ännu värre.",
                        rightApproach: "Du kortar tuppen till 45 minuter och ser till att den sker före kl 14. Du utvärderar: sover barnet bättre på natten med en kortare tupp? Om inte, kanske det helt enkelt inte är dags att ändra tuppen ännu.",
                        explanation: "Att förkorta en tupp är ofta bättre än att stryka den helt. Barn som fortfarande behöver en tupp blir överst trötta utan den – och det hjälper inte nattsömnen. Tidpunkten på tuppen spelar större roll än längden."
                    )
                ],
                exercise: CourseExercise(
                    title: "Tuppstrategin",
                    description: "Kartlägg ditt barns dagssömn och skapa en strategi som anpassas efter barnets nuvarande fas.",
                    steps: [
                        "Notera barnets tuppar under en vecka: antal, tidpunkter, längd",
                        "Titta efter signaler på övergång: vägrar tuppar, svårt att somna, vakentiden ökar",
                        "Jämför med åldersriktlinjer: stämmer antalet tuppar med barnets ålder?",
                        "Om barnet är i en övergång: var flexibel och flytta läggdags vid behov",
                        "Prova i två veckor och utvärdera: sover barnet bättre totalt sett?",
                        "Justera planen – inget är hugget i sten"
                    ],
                    duration: "Två veckor"
                ),
                reflectionQuestions: [
                    "Hur ser ditt barns dagsömn ut just nu? Verkar det vara i en övergångsfas?",
                    "Hur påverkar tupparna din vardag – positivt och negativt?",
                    "Följer du barnets signaler eller ett fast schema? Vad fungerar bäst för er?",
                    "Hur hanterar du dagarna då tuppen inte blir av?"
                ],
                forumSection: CourseForumSection(
                    intro: "Dagssömnen är ett ämne som kan göra den mest zen-buddhisten bland föräldrar frustrerad.",
                    consensus: "Föräldrar delar att det mest hjälpsamma var att följa barnets signaler istället för att styra efter klockan. Och att övergångar är kaotiska men tillfälliga.",
                    quotes: [
                        "\"Övergången 2→1 tupp tog en månad av total kaos. Jag trodde barnet var trasigt. Sen plötsligt – perfekt tupp mitt på dagen.\" – Rebecca, mamma till Lova 14 mån",
                        "\"Vi slutade tvinga tuppen och lät sonen sova i bilen om det behövdes. Ingen tupp-polis behövs.\" – Anders, pappa till Edvin 2 år",
                        "\"Bästa tipset: tidig läggdags de dagar tuppen inte blir av. Vi la honom kl 17:30 ibland – och han sov hela natten!\" – Karin, mamma till Otto 10 mån"
                    ],
                    source: "Baserat på Marc Weissbluth och Jodi Mindells forskning om barns dagssömn"
                ),
                readingTimeMinutes: 10
            )
        ],
        targetAudience: "Föräldrar med barn 0-3 år",
        estimatedWeeks: 6
    )
}

// MARK: - Course 4: Starten med mat

extension Course {
    static let startenMedMat = Course(
        id: "starten-med-mat",
        title: "Starten med mat",
        subtitle: "En trygg guide till barnets första smakupplevelser",
        description: "Allt du behöver veta om att introducera fast föda – från mognadstecken och allergiprevention till BLW, traditionell matintroduktion och familjegemensamma måltider. Baserad på svenska rekommendationer och aktuell forskning.",
        icon: "fork.knife",
        gradient: LinearGradient(colors: [Color(hex: "2ECC71"), Color(hex: "27AE60")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            // Module 1
            CourseModule(
                id: "smm-1",
                title: "Mognadstecken och timing",
                subtitle: "När är barnet redo för mat?",
                icon: "clock.badge.checkmark.fill",
                introduction: """
                Frågan 'När ska jag börja ge mat?' är en av de vanligaste bland svenska föräldrar. Svaret har förändrats genom åren – för bara ett par decennier sedan rekommenderades smakportioner redan vid fyra månader. Idag rekommenderar både WHO och Livsmedelsverket att barn börjar med fast föda runt sex månaders ålder, men det individuella barnet avgör exakt när.

                Det viktigaste är inte att räkna dagar utan att läsa av barnets mognadstecken. Det finns tre avgörande tecken som alla bör vara på plats: barnet kan sitta relativt stabilt med stöd, det har tappat tungstötningsreflexen (som automatiskt skjuter ut fast föda ur munnen) och det visar intresse för mat – till exempel genom att sträcka sig efter din tallrik, följa maten med blicken eller öppna munnen när det ser dig äta.

                Att börja för tidigt, innan barnet är moget, kan vara kontraproduktivt. Matsmältningssystemet är inte redo, risken för allergier kan öka och barnet kan bli frustrerat av att inte kunna hantera maten. Å andra sidan bör man inte vänta för länge – efter sex-sju månaders ålder ökar barnets behov av järn och andra näringsämnen som bröstmjölk eller modersmjölksersättning inte längre täcker fullt ut.

                I Sverige har vi en BVC-tradition som stödjer föräldrar vid matintroduktionen. Din BVC-sköterska kan hjälpa dig bedöma om ditt barn är redo och ge personliga råd. Använd den resursen – den finns just för att du inte ska behöva navigera detta ensam.
                """,
                keyPoints: [
                    "WHO rekommenderar start runt sex månader, men barnet avgör exakt tidpunkt",
                    "Tre mognadstecken: sitter med stöd, tappat tungstötningsreflex, visar intresse för mat",
                    "Alla tre mognadstecken bör vara på plats innan start",
                    "Att börja för tidigt kan skapa problem – vänta på mognadstecknen",
                    "Efter sex månader ökar behovet av järn som behöver kompletteras med mat",
                    "BVC är en viktig resurs – prata med din sköterska"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din fyra månader gamla bebis tittar intensivt när du äter. Farförälderna säger att barnet 'vill ha mat'.",
                        wrongApproach: "Du ger barnet en smakportion gröt vid fyra månader. Barnet skjuter ut allt med tungan och protesterar. Du försöker flera gånger per dag.",
                        rightApproach: "Du förklarar att barnet tittar på allt – det är en del av utvecklingen att utforska världen med blicken. Du väntar tills barnet visar alla tre mognadstecken och pratar med BVC vid nästa besök. 'Hen tittar intresserat, men vi väntar tills hen kan sitta och tungstötningsreflexen försvunnit.'",
                        explanation: "Att titta intensivt på mat vid fyra månader är normalt och betyder inte nödvändigtvis att barnet är redo. Tungstötningsreflexen, som skyddar mot kvävning, försvinner typiskt inte förrän runt sex månader. Att vänta på alla mognadstecken gör matintroduktionen smidigare."
                    ),
                    CourseExample(
                        scenario: "Ditt barn är sex och en halv månad men verkar inte alls intresserad av mat. Du oroar dig.",
                        wrongApproach: "Du tvingar in skeden i munnen: 'Du MÅSTE äta nu, du är redan sen!' Du provar fem olika gröter samma dag i hopp om att hitta en barnet gillar.",
                        rightApproach: "Du erbjuder mat i lugn miljö utan press. Du sätter barnet i stolen vid bordet när ni äter och låter det utforska maten med händerna. Du vet att en del barn behöver lite mer tid och att amning/ersättning fortfarande ger det som behövs.",
                        explanation: "Alla barn utvecklas i sin egen takt. Sex och en halv månad är fortfarande helt inom normalspannet. Att tvinga skapar negativa matupplevelser och kan göra barnet ännu mer motvilligt. Att erbjuda utan att pressa ger barnet trygghet att utforska i sin egen takt."
                    )
                ],
                exercise: CourseExercise(
                    title: "Mognadstecken-checklista",
                    description: "Observera ditt barn och bedöm var det befinner sig i matmognaden. Använd checklistan för att avgöra om det är dags.",
                    steps: [
                        "Observera: kan barnet sitta med stöd (i en barnstol)? Ja/Nej",
                        "Testa tungstötningsreflexen: lägg en liten klick mat på barnets underläpp. Skjuter tungan ut den automatiskt?",
                        "Observera intresse: sträcker sig barnet efter mat? Följer det maten med blicken? Öppnar det munnen?",
                        "Kontrollera ålder: är barnet minst 4 månader? (4 mån = absolut tidsgräns, 6 mån = rekommendation)",
                        "Prata med BVC om din bedömning",
                        "Om alla tecken stämmer – dags att börja! Om inte – vänta och observera igen om en vecka"
                    ],
                    duration: "En vecka av observation"
                ),
                reflectionQuestions: [
                    "Vad har format dina förväntningar om när och hur matintroduktionen ska ske?",
                    "Känner du press från omgivningen att börja med mat tidigare än du tänkt?",
                    "Hur kan du göra matintroduktionen till en positiv upplevelse utan stress?",
                    "Har du pratat med BVC om matintroduktionen? Vad sa de?"
                ],
                forumSection: CourseForumSection(
                    intro: "Matintroduktionen väcker många frågor och viss prestationsångest. Avdramatisering är receptet.",
                    consensus: "De flesta föräldrar önskar att de stressat mindre. Barnen äter när de är redo – och det finns ett brett spann av vad som är normalt.",
                    quotes: [
                        "\"Min son visade noll intresse vid sex månader. Jag stressade. Vid sju månader tog han en broccoli från min tallrik och stoppade i munnen. Han var redo – på sitt sätt.\" – Frida, mamma till Vincent 9 mån",
                        "\"Svärmor tyckte vi var galna som inte gav gröt vid fyra månader. Vi stod på oss och väntade. Bästa beslutet.\" – Rasmus, pappa till Svea 8 mån",
                        "\"BVC-sköterskan var fantastisk. Hon sa: 'Barnet kommer inte att svälta. Slappna av och ha kul med det.' Det var allt jag behövde höra.\" – Isabelle, mamma till Nora 6 mån"
                    ],
                    source: "Baserat på Livsmedelsverkets rekommendationer och WHO:s riktlinjer"
                ),
                readingTimeMinutes: 10
            ),
            // Module 2
            CourseModule(
                id: "smm-2",
                title: "BLW eller traditionellt?",
                subtitle: "Hitta den metod som passar er familj",
                icon: "hand.point.up.fill",
                introduction: """
                BLW (Baby Led Weaning) och traditionell matintroduktion med sked är de två huvudmetoderna för att börja ge barn fast föda. BLW innebär att barnet äter själv med händerna från start – ingen mos, ingen sked, ingen matning. Traditionell metod börjar med slät mos på sked och ökar gradvis konsistensen. Båda metoderna har fördelar och ingen är 'rätt' eller 'fel'.

                BLW har blivit allt populärare i Sverige och har flera fördelar. Barnet styr själv hur mycket det äter, vilket kan främja en hälsosam relation till mat. Det utvecklar finmotoriken tidigt och barnet lär sig hantera olika konsistenser direkt. Dessutom kan barnet ofta äta samma mat som resten av familjen, vilket förenklar vardagen. Nackdelar är att det kan vara stökigare, att det kan vara svårt att veta hur mycket barnet faktiskt äter och att en del föräldrar upplever mer oro kring kvävningsrisken.

                Traditionell matintroduktion med sked ger föräldern mer kontroll och gör det lättare att se hur mycket barnet äter. Det kan kännas tryggare och lämpar sig väl för föräldrar som är oroliga för kvävning. Nackdelen är att barnet inte styr lika mycket själv och att det kan ta längre tid att gå över till grova konsistenser.

                Allt fler föräldrar och experter förespråkar en kombination: barnet får fingermats-bitar att utforska själv och ibland mosad mat på sked. Denna flexibla approach tar det bästa från båda metoderna. Det viktigaste är inte vilken metod du väljer utan att måltiden är en trygg, positiv stund fri från press och stress.
                """,
                keyPoints: [
                    "BLW: barnet äter själv med händerna från start – ingen sked, ingen mos",
                    "Traditionellt: slät mos på sked som gradvis blir grovare",
                    "Båda metoderna är säkra och evidensbaserade – välj det som passar er",
                    "En kombination av BLW och sked är vanligast i praktiken",
                    "Kräkreflexen sitter längre fram hos bebisar och skyddar mot kvävning – den är inte farlig",
                    "Det viktigaste är att maten erbjuds utan press"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vill prova BLW men din partner är livrädd att barnet ska sätta i halsen.",
                        wrongApproach: "Du ignorerar partnerns oro och ger barnet stora bitar mat. Barnet kräks och partnern blir hysterisk. 'Jag sa ju det!'",
                        rightApproach: "Ni läser om skillnaden mellan kräkning (normalt, skyddande reflex) och kvävning (tyst, ovanligt) tillsammans. Ni tittar på en hjärt-lungräddningskurs för barn. Ni börjar med mjuka bitar som smälter (avokado, banan) och har båda koll. 'Vi testar försiktigt och lär oss tillsammans.'",
                        explanation: "Kräkning och kvävning är helt olika saker. Kräkreflexen sitter längre fram i munnen hos bebisar (vid 2/3 av tungan) och är ett effektivt skyddssystem. Att förstå detta minskar oron drastiskt. Att göra en HLR-kurs ger trygghet till alla föräldrar – oavsett metod."
                    ),
                    CourseExample(
                        scenario: "Du ger mos på sked men barnet vränger sig och vill ta skeden själv – det blir kaos.",
                        wrongApproach: "Du tar tillbaka skeden och insisterar på att mata. 'Du spiller ju bara!' Måltiden blir en maktkamp.",
                        rightApproach: "Du ger barnet en egen sked att hålla medan du matar med en annan. Du lägger också några mjuka bitar direkt på bordet som barnet kan utforska med händerna. 'Visst kan du prova själv! Här har du en broccoli att hålla i.'",
                        explanation: "Att vilja äta själv är ett tecken på mognad och nyfikenhet. Att blanda metoderna – sked OCH fingerbitar – ger barnet det bästa av två världar. Röran är tillfällig; den positiva relationen till mat varar hela livet."
                    )
                ],
                exercise: CourseExercise(
                    title: "Välj er matmetod",
                    description: "Bestäm tillsammans vilken metod – BLW, traditionell eller kombination – som passar er familj bäst.",
                    steps: [
                        "Diskutera med din partner: vad känns mest naturligt och tryggt?",
                        "Gå en online HLR-kurs för spädbarn (Röda Korset erbjuder gratis)",
                        "Börja med 2-3 lätthanterliga matvaror oavsett metod (avokado, banan, sötkartoffel)",
                        "Erbjud mat vid en tidpunkt då barnet är utvilat och inte superhungrigt",
                        "Filma gärna de första matförsöken – det blir fantastiska minnen!",
                        "Utvärdera efter en vecka: vad fungerar, vad behöver justeras?"
                    ],
                    duration: "En veckas förberedelse + en veckas test"
                ),
                reflectionQuestions: [
                    "Vilken metod tilltalar dig mest – och varför?",
                    "Hur påverkar din egen relation till mat hur du introducerar mat för ditt barn?",
                    "Vilka rädslor har du kring matintroduktionen? Är de baserade på fakta eller oro?",
                    "Hur kan ni göra måltiderna till en positiv familjestund från allra första början?"
                ],
                forumSection: CourseForumSection(
                    intro: "BLW vs. sked är en het debatt i föräldraplattformar. I verkligheten väljer de flesta en blandning.",
                    consensus: "Det gemensamma är att de som stressade minst hade mest positiva upplevelser – oavsett metod. Och att HLR-kursen gav alla trygghet.",
                    quotes: [
                        "\"Vi började med BLW och det var fantastiskt att se henne utforska. Ja, det var stökigt. Men att se ett sjumånadersbarns ansikte när det äter sin första broccoli – ovärderligt!\" – Louise, mamma till Astrid 10 mån",
                        "\"Jag matade med sked och barnet tog skeden ur handen och kastade den. Budskapet var tydligt. Vi bytte till BLW.\" – Joel, pappa till Hjalmar 8 mån",
                        "\"Vi blandar. Mos vid frukost (snabbt, smidigt) och BLW vid middag (kul, familjemåltid). Funkar perfekt.\" – Stina, mamma till Folke 9 mån"
                    ],
                    source: "Baserat på Gill Rapleys forskning om BLW och Livsmedelsverkets rekommendationer"
                ),
                readingTimeMinutes: 11
            ),
            // Module 3
            CourseModule(
                id: "smm-3",
                title: "Allergier och introduktion",
                subtitle: "Ny forskning som ändrar spelreglerna",
                icon: "allergens.fill",
                introduction: """
                Synen på allergiprevention har genomgått en revolution under de senaste åren. Tidigare rekommenderades att man skulle vänta med att introducera vanliga allergiframkallande livsmedel – jordnötter, ägg, fisk, mjölk – till barnet var äldre. Ny forskning visar att detta var fel. Tidig introduktion, runt 4-6 månaders ålder, verkar faktiskt skydda mot allergier. Ju tidigare barnet exponeras (efter fyra månader), desto lägre tycks risken vara.

                Livsmedelsverket rekommenderar idag att alla vanliga livsmedel, inklusive jordnötssmör, ägg och fisk, introduceras gradvis från att barnet börjar äta – oavsett om det finns allergier i familjen. Den gamla regeln 'ett livsmedel i taget, vänta tre dagar' har tonats ner. Man rekommenderar fortfarande att introducera nya livsmedel ett i taget för att kunna identifiera eventuella reaktioner, men det behöver inte ta tre dagar mellan varje nytt livsmedel.

                De vanligaste allergiframkallande livsmedlen i Sverige är komjölk, ägg, fisk, skaldjur, vete, soja, jordnötter och trädnötter. Symptom på allergi kan vara utslag runt munnen, kräkning, diarré, svullnad eller i sällsynta fall andningsbesvär. De allra flesta reaktioner är milda och övergående. Det är dock viktigt att veta skillnaden mellan en mild reaktion och en allvarlig – och att söka vård vid andningsbesvär.

                Om det finns starka allergier i familjen (föräldrar eller syskon med konstaterade allergier) kan det vara bra att diskutera matintroduktionen med BVC eller en barnläkare. Även i dessa fall rekommenderas tidig introduktion – men kanske med extra uppmärksamhet och beredskap.
                """,
                keyPoints: [
                    "Tidig introduktion (från 4-6 månader) av allergena livsmedel skyddar mot allergier",
                    "Vänta inte med jordnötter, ägg, fisk eller gluten – introducera dem tidigt",
                    "Introducera nya livsmedel ett i taget så att du kan se eventuella reaktioner",
                    "De flesta allergiska reaktioner är milda – utslag, kräkning, magont",
                    "Sök vård omedelbart vid andningsbesvär eller allvarlig svullnad",
                    "Prata med BVC om det finns starka allergier i familjen",
                    "Fortsätt ge livsmedlet regelbundet efter introduktion – enstaka exponering räcker inte"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vill ge ditt sexmånadersbarn jordnötssmör men din mamma säger att det är farligt och att du borde vänta till tre år.",
                        wrongApproach: "Du väntar med jordnötter till barnet är äldre. Eller: du ger en hel macka med jordnötssmör som första gång.",
                        rightApproach: "Du blandar en liten nypa jordnötssmör med lite bröstmjölk eller mos och erbjuder det på en sked. Du gör det hemma, på dagtid, när du har möjlighet att observera barnet. Du ger en liten mängd och väntar 30 minuter. Allt går bra – du fortsätter ge jordnötter regelbundet.",
                        explanation: "Forskningen (LEAP-studien) visar att tidig introduktion av jordnötter minskar risken för jordnötsallergi med upp till 80%. Börja med en liten mängd, blandad i annan mat. Att introducera på dagtid hemma ger trygghet att observera eventuella reaktioner."
                    ),
                    CourseExample(
                        scenario: "Du ger ditt barn ägg för första gången och det får röda prickar runt munnen.",
                        wrongApproach: "Du panikslår och ringer 112. Alternativt: du bestämmer att barnet är allergiskt mot ägg och stryker det helt.",
                        rightApproach: "Du observerar: är det bara runt munnen eller sprider det sig? Mår barnet i övrigt bra? Röda prickar lokalt runt munnen är vanligt och oftast inte allergi utan kontaktirritation. Du tvättar av och väntar. Om utslaget försvinner inom en timme och barnet mår bra, provar du ägg igen om några dagar. Om utslaget sprider sig eller barnet verkar dåligt – kontakta vården.",
                        explanation: "Kontaktirritation runt munnen är mycket vanligare än äkta allergi. Det är viktigt att inte överreagera och stryka livsmedel i onödan – barnet kan gå miste om viktig tidig exponering. Men: vid utbredd reaktion, svullnad eller andningsbesvär ska du alltid söka vård."
                    )
                ],
                exercise: CourseExercise(
                    title: "Allergi-introduktionsplan",
                    description: "Skapa en plan för att introducera de vanligaste allergena livsmedlen under de första matmånaderna.",
                    steps: [
                        "Lista de vanligaste allergenerna: ägg, mjölk, fisk, jordnötter, vete, soja, trädnötter",
                        "Planera ordningen: börja med det du känner dig tryggast med",
                        "Introducera ett nytt allergen per vecka",
                        "Ge det nya livsmedlet på dagtid, hemma, i liten mängd",
                        "Fortsätt ge det introduserade livsmedlet regelbundet (2-3 gånger/vecka)",
                        "Notera eventuella reaktioner och prata med BVC vid frågor"
                    ],
                    duration: "6-8 veckor"
                ),
                reflectionQuestions: [
                    "Finns det allergier i er familj? Hur påverkar det din inställning till matintroduktionen?",
                    "Känner du oro kring att introducera allergena livsmedel? Vad kan minska oron?",
                    "Har du pratat med BVC om allergiprevention?",
                    "Hur kan du se till att barnet fortsätter äta de introduserade allergenerna regelbundet?"
                ],
                forumSection: CourseForumSection(
                    intro: "Allergioro är vanligt – men kunskapen att tidig introduktion faktiskt skyddar har lättat en del av den bördan.",
                    consensus: "Föräldrar vittnar om att de var mest oroliga innan de börjat. De flesta barn hanterade nya livsmedel helt utan problem, och att ha en plan minskade stressen.",
                    quotes: [
                        "\"Jag var livrädd för att ge jordnötter. Blandade lite i moset, höll andan – och inget hände! Nu äter hon jordnötssmörgås varje dag.\" – Alexandra, mamma till Lilly 8 mån",
                        "\"Min son fick lite utslag av ägg första gången. BVC sa att det var kontaktirritation. Vi provade igen en vecka senare – inga problem.\" – Erik, pappa till Alfred 7 mån",
                        "\"Som allergiker själv var jag extremt nervös. Barnläkaren lugnade mig och hjälpte oss med en plan. Det gick jättebra.\" – Sofia, mamma till Edith 9 mån"
                    ],
                    source: "Baserat på LEAP-studien, EAT-studien och Livsmedelsverkets uppdaterade rekommendationer 2024"
                ),
                readingTimeMinutes: 11
            ),
            // Module 4
            CourseModule(
                id: "smm-4",
                title: "Järn och näring",
                subtitle: "Viktig näring i barnets första matår",
                icon: "leaf.arrow.circlepath",
                introduction: """
                Järn är det näringsämne som alla föräldrar bör ha koll på under barnets första matår. En bebis föds med ett järnförråd som räcker ungefär sex månader. Därefter behöver barnet få järn via kosten, eftersom bröstmjölken innehåller relativt lite järn (även om det järn som finns absorberas effektivt). Järnbrist hos småbarn är vanligt och kan påverka hjärnans utveckling, så detta är viktigare än de flesta föräldrar tror.

                Goda järnkällor för småbarn inkluderar rött kött, lever, bönor, linser, tofu, ägg (särskilt gulan), järnberikad gröt och mörka bladgrönsaker som spenat. Genom att kombinera järnrik mat med C-vitaminrik mat (frukt, paprika, tomat) ökar du kroppens upptag av järn. Å andra sidan hämmar mejeriprodukter och te järnupptaget – så ge inte mjölk till maten och undvik att ge komjölk som dryck före ett års ålder.

                Utöver järn behöver barnet en balanserad kost med fett (mycket viktigt för hjärnan!), protein, kolhydrater, vitaminer och mineraler. Barn under två år behöver relativt sett mycket fett i kosten – undvik därför lättmjölksprodukter och fettsnåla alternativ. Hela ägg, avokado, olivolja, smör och fet fisk är utmärkta för de minsta.

                I Sverige rekommenderas D-vitamindroppar från en veckas ålder upp till två år. Detta är extra viktigt under vinterhalvåret då solexponeringen är minimal. De flesta föräldrar känner till detta men det är värt att påminna om – D-vitamin är avgörande för skelett och immunförsvar.
                """,
                keyPoints: [
                    "Järnförrådet från födseln räcker ca sex månader – därefter krävs järn via kosten",
                    "Bästa järnkällor: rött kött, bönor, linser, äggula, järnberikad gröt",
                    "C-vitamin ökar järnupptaget – ge frukt eller grönsaker till järnrik mat",
                    "Undvik komjölk som dryck före 12 månaders ålder – det hämmar järnupptag",
                    "Barn under två år behöver mycket fett – undvik lättmjölksprodukter",
                    "D-vitamindroppar dagligen från 1 vecka till 2 års ålder"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn äter mest frukt och gröt men tackar nej till allt kött.",
                        wrongApproach: "Du tvingar i barnet kött: 'Du MÅSTE äta kött för att få järn!' Måltiden blir obehaglig. Eller du struntar i det och hoppas det löser sig.",
                        rightApproach: "Du erbjuder alternativa järnkällor: linssoppa, bönröra, ägg, järnberikad gröt. Du serverar kött i olika former – kanske i en bolognesesås, köttfärsgryta eller som tunna strimlor att tugga på. Du kombinerar med C-vitamin: ett par bitar mango till linsgrytan.",
                        explanation: "Det finns många järnkällor utöver kött. Att tvinga skapar motstånd. Att erbjuda variation och kombinera med C-vitamin maximerar järnupptaget. Om barnet konsekvent äter mycket lite järnrik mat, prata med BVC om eventuellt järntillskott."
                    ),
                    CourseExample(
                        scenario: "Ditt barn vill bara dricka mjölk och äter nästan ingen fast föda vid 11 månaders ålder.",
                        wrongApproach: "Du tänker: 'Mjölk är nyttig, det räcker nog.' Du fortsätter ge mjölk på begäran och oroar dig inte.",
                        rightApproach: "Du minskar mjölkmängden och erbjuder fast föda oftare. Mjölk ges som dryck i begränsad mängd (max 300-500ml/dag) och inte precis innan måltider. Du erbjuder vatten som törstsläckare. 'Nu äter vi middag – du kan få mjölk till mellanmålet sedan.'",
                        explanation: "För mycket mjölk fyller magen, hämmar järnupptaget och minskar intresset för fast föda. Mjölk är nyttig men ska inte ersätta den fasta maten. Att begränsa mjölken gör barnet hungrigare vid måltiderna och främjar en balanserad kost."
                    )
                ],
                exercise: CourseExercise(
                    title: "Järnkollen",
                    description: "Gör en inventering av ditt barns kost och bedöm om järnintaget är tillräckligt.",
                    steps: [
                        "Skriv ner allt ditt barn äter under tre vanliga dagar",
                        "Markera vilka livsmedel som är järnrika",
                        "Kontrollera: äter barnet järnrik mat minst 1-2 gånger per dag?",
                        "Kollar du: kombinerar du järnrik mat med C-vitamin?",
                        "Undviker du att ge mjölk till måltiderna? (Ge vatten istället)",
                        "Om järnintaget verkar lågt – prata med BVC och prova nya järnrika recept"
                    ],
                    duration: "Tre dagar"
                ),
                reflectionQuestions: [
                    "Vet du vilka livsmedel som är järnrika? Äter ditt barn dem regelbundet?",
                    "Hur mycket mjölk dricker ditt barn per dag? Kan det vara för mycket?",
                    "Ger du D-vitamindroppar dagligen? Om inte, vad hindrar dig?",
                    "Känner du dig trygg med att ditt barn får tillräcklig näring? Vad kan du göra för att känna dig tryggare?"
                ],
                forumSection: CourseForumSection(
                    intro: "Järnfrågan oroar många föräldrar. Men med lite kunskap är det enklare än man tror att säkerställa bra järnintag.",
                    consensus: "Det som hjälpte flest föräldrar var konkreta tips: linser i allt, ägg till frukost, berikad gröt som mellanmål. Och att inte ge mjölk till maten.",
                    quotes: [
                        "\"Min dotter vägrade kött men älskade linssoppa. Jag gömde linser i allt – pastasås, pannkakor, bröd. Järnvärdena var toppen!\" – Sara, mamma till Luna 11 mån",
                        "\"Vi upptäckte att vår son drack nästan en liter mjölk om dagen. När vi minskade till 400ml började han äta mycket bättre.\" – Per, pappa till Isak 13 mån",
                        "\"BVC tog ett blodprov vid 10 månader och han hade lågt järn. Med tillskott och kostförändring var det normalt inom en månad.\" – Christina, mamma till Milton 14 mån"
                    ],
                    source: "Baserat på Livsmedelsverkets kostråd för spädbarn och Socialstyrelsens riktlinjer"
                ),
                readingTimeMinutes: 10
            ),
            // Module 5
            CourseModule(
                id: "smm-5",
                title: "Familjemåltiden",
                subtitle: "Lägg grunden för en livslång positiv relation till mat",
                icon: "person.3.fill",
                introduction: """
                Det allra viktigaste du kan göra för ditt barns relation till mat är att skapa positiva, stressfria måltider – och helst äta tillsammans som familj. Forskning visar att barn som regelbundet äter måltider med sin familj har bättre kostvanor, sundare relation till mat och till och med bättre psykisk hälsa. Familjemåltiden handlar inte bara om näring – den handlar om gemenskap, rutiner och att barnet ser vuxna äta och njuta av mat.

                En av de viktigaste principerna kommer från den amerikanska dietisten Ellyn Satter: föräldern bestämmer vad, när och var – barnet bestämmer om och hur mycket. Det innebär att du har ansvar för att erbjuda varierad, näringsrik mat vid regelbundna tider, i en lugn miljö. Barnet har ansvar för att bestämma om det vill äta och hur mycket. Denna arbetsfördelning tar bort pressen från måltiden och ger barnet en sund kontroll.

                Det kan vara frestande att kommentera barnets ätande: 'Ät lite till!', 'Smaka åtminstone!' eller 'Du har inte ätit tillräckligt.' Men all forskning pekar åt samma håll: press vid matbordet ger sämre matvanor, inte bättre. Barn som pressas att äta äter i längden mindre och utvecklar oftare problematiska relationer till mat. Att erbjuda utan att pressa är svårt men avgörande.

                Den svenska matttraditionen med gemensamma måltider, lagom portioner och bröd på bordet ger en fantastisk grund. Att låta barnet sitta med vid bordet från start, servera samma mat som familjen (anpassad i konsistens) och göra måltiden till en social stund – det är receptet för en livslång positiv relation till mat.
                """,
                keyPoints: [
                    "Förälder bestämmer vad, när och var – barnet bestämmer om och hur mycket",
                    "Press vid matbordet ger sämre matvanor – erbjud utan att tjata",
                    "Ät tillsammans som familj så ofta det går – barnet lär sig genom att se er äta",
                    "Servera samma mat till alla – anpassa konsistens men inte hela menyval",
                    "Kräsighet är normalt vid 1-3 år – det är en utvecklingsfas som går över",
                    "Gör måltiden till en social stund, inte en matningssession"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt ettåring vägrar äta middagen du lagat. Det har hänt flera dagar i rad.",
                        wrongApproach: "Du lagar en separat måltid som du vet att barnet gillar. 'Okej, du får pasta med ketchup istället.' Eller du tvingar: 'Du sitter kvar tills du ätit upp.'",
                        rightApproach: "Du serverar familjens mat tillsammans med något du vet att barnet brukar äta (bröd, frukt). Du äter själv med god aptit och kommenterar inte barnets ätande. 'Mmm, vad god soppa!' Om barnet inte äter – det är okej. Nästa måltid kommer snart.",
                        explanation: "Att laga separat mat lär barnet att det kan 'beställa' sin egen meny. Att tvinga skapar matkamp. Att erbjuda familjens mat plus en trygg komponent (bröd) ger barnet ett val utan att du blir kortidsrestaurang. Och att äta själv med entusiasm är den bästa reklamen för maten."
                    ),
                    CourseExample(
                        scenario: "Ditt tvååring äter bara pasta, bröd och banan. Du oroar dig för näringen.",
                        wrongApproach: "Du gömmer grönsaker i smoothies och bröd. Barnet genomskådar allt och blir misstänksamt. Alternativt ger du upp helt: 'Hen äter bara pasta, vad kan jag göra?'",
                        rightApproach: "Du fortsätter servera varierad mat och låter barnet ha pasta eller bröd vid sidan om. Du äter själv grönsakerna med glädje. Du involverar barnet i matlagningen: 'Vill du hjälpa mig röra i såsen?' Du vet att kräsighet är normalt och att det oftast går över.",
                        explanation: "Kräsighet vid 1-3 år är en evolutionär skyddsmekanism – barnet som börjar gå vill inte stoppa okänt i munnen. Forskning visar att barn behöver exponeras för ett livsmedel 10-20 gånger innan de accepterar det. Fortsätt erbjuda utan press – tålamod är nyckeln."
                    )
                ],
                exercise: CourseExercise(
                    title: "Stressfria måltidsveckan",
                    description: "Under en vecka, testa Ellyn Satters princip: du bestämmer vad, när och var – barnet bestämmer om och hur mycket.",
                    steps: [
                        "Planera veckans måltider i förväg – en sak du vet barnet äter vid varje måltid",
                        "Servera familjens mat – inga separata barnmenyalternativ",
                        "Kommentera inte barnets ätande: inget 'ät mer', 'smaka', eller 'bra att du äter'",
                        "Ät själv med synlig njutning och prata om maten positivt",
                        "Om barnet inte äter – ta bort tallriken utan drama efter 20-30 minuter",
                        "Notera: äter barnet mer, mindre eller annorlunda utan press?"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Hur ser era måltider ut idag? Är de stressiga eller lugna?",
                    "Kommenterar du ditt barns ätande? Vad händer om du slutar?",
                    "Äter ni som familj tillsammans? Om inte – vad hindrar?",
                    "Hur var din egen uppväxt kring mat? Påverkar det hur du gör med dina barn?"
                ],
                forumSection: CourseForumSection(
                    intro: "Att sluta kommentera barnets ätande är en av de svåraste men mest befriande förändringarna föräldrar gör.",
                    consensus: "De flesta föräldrar rapporterar att det blev lugnare vid matbordet, att barnen faktiskt smakade mer av egen vilja och att stressen minskade drastiskt.",
                    quotes: [
                        "\"Jag slutade säga 'ät lite till' och plötsligt åt han mer. Det var som magi. Men egentligen var det logik.\" – Pernilla, mamma till Sixten 2 år",
                        "\"Vi bestämde att middagen tar max 30 min. Äter barnet – bra. Äter det inte – nästa måltid kommer. Stressen försvann.\" – Niklas, pappa till Meja 18 mån",
                        "\"Min dotter hjälpte mig röra i grytan och smakade plötsligt moroten. Hon hade vägrat morötter i sex månader!\" – Camilla, mamma till Ebba 2 år"
                    ],
                    source: "Baserat på Ellyn Satters Division of Responsibility och svensk barndietistik"
                ),
                readingTimeMinutes: 11
            )
        ],
        targetAudience: "Föräldrar med barn 4-24 månader",
        estimatedWeeks: 5
    )
}

// MARK: - Course 5: Första årets utveckling

extension Course {
    static let forstaAretsUtveckling = Course(
        id: "forsta-arets-utveckling",
        title: "Första årets utveckling",
        subtitle: "En komplett guide till ditt barns första tolv månader",
        description: "Följ ditt barns fantastiska utvecklingsresa från nyfödd till ettåring. Förstå varje fas, stimulera utvecklingen på rätt sätt och lär dig när du kan slappna av och när du bör söka hjälp. Baserad på modern utvecklingspsykologi och svenska BVC-riktlinjer.",
        icon: "figure.child",
        gradient: LinearGradient(colors: [Color(hex: "F39C12"), Color(hex: "E67E22")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            // Module 1
            CourseModule(
                id: "fau-1",
                title: "0-3 månader: Den fjärde trimestern",
                subtitle: "Transition från livmoder till omvärld",
                icon: "heart.circle.fill",
                introduction: """
                De första tre månaderna efter födseln kallas ibland 'den fjärde trimestern' – och det är ett bra begrepp. Ditt nyfödda barn har precis lämnat en miljö av konstant värme, rytmiskt ljud, mjukt tryck och total trygghet. Världen utanför är ljus, kall, öppen och överväldigande. Det viktigaste du kan göra under dessa månader är att göra övergången så mjuk som möjligt: bär barnet nära, svara på dess behov och skapa en känsla av trygghet som liknar den i livmodern.

                Under de första veckorna sker enormt mycket neurologisk utveckling. Bebisen kan se ungefär 20-30 cm (precis avståndet till ditt ansikte vid amning), hör din röst och känner din lukt. Dessa sinnen är redan väldefinierade vid födseln. Synen utvecklas snabbt – från att bara se kontraster och konturer till att vid två månader kunna följa objekt med blicken och le det berömda 'sociala leendet' som smälter varje förälders hjärta.

                Motoriskt går utvecklingen från de nyfödda reflexerna (gripreflexen, mororeflex, sugreflexen) till de första medvetna rörelserna. Vid slutet av tre månader kan de flesta bebisar hålla upp huvudet en stund på magen, följa objekt med blicken och börja nå efter saker. Varje bebis utvecklas i sin egen takt – dessa tidsramar är ungefärliga och det finns ett brett normalspann.

                I Sverige har du BVC-kontroller vid 1-2 veckors ålder, 4 veckors ålder och sedan regelbundet. Dessa kontroller följer barnets utveckling och ger dig som förälder möjlighet att ställa frågor. Tveka aldrig att kontakta BVC mellan besöken om något oroar dig – det är deras jobb och de vill att du hör av dig.
                """,
                keyPoints: [
                    "Nyfödda ser 20-30 cm – precis ditt ansikte vid amning",
                    "Det sociala leendet kommer runt 6-8 veckor – det är inte gas!",
                    "Hud-mot-hud och bärande reglerar barnets temperatur, hjärtslag och stressnivå",
                    "Nyfödda reflexer (grip, moro, sug) försvinner gradvis under de första månaderna",
                    "Gråt är normal kommunikation – den ökar och toppar runt 6-8 veckor (kolikperioden)",
                    "Tummy time (tid på mage) från start stärker nacke och rygg",
                    "Ditt barn hör, känner och känner igen din röst redan från födseln"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din tvåveckorsbebis gråter mycket på kvällarna. Du har provat allt och ingenting hjälper.",
                        wrongApproach: "Du panikgooglar 'kolik lösningar' vid tre på natten, provar tio olika saker på en timme och blir alltmer desperat. Du tänker att du gör något fel.",
                        rightApproach: "Du vet att kvällsgråt är extremt vanligt under de första veckorna och toppar runt 6-8 veckor. Du tröstar genom att hålla bebisen nära, vagga, använda vitt brus och byta avlösning med din partner. 'Det här är svårt, men det är normalt och det kommer gå över.'",
                        explanation: "Kvällsgråt (ibland kallad kolik) drabbar de flesta bebisar i varierande grad. Det är inte ett tecken på att du gör fel. Ingen metod fungerar varje gång – det viktigaste är att bebisen inte lämnas ensam med gråten och att du tar avlösning innan du blir utmattad."
                    ),
                    CourseExample(
                        scenario: "Din bebis är en månad och ligger bara still. Du undrar om du borde 'stimulera' mer.",
                        wrongApproach: "Du köper massor av utvecklingsleksaker och hänger en mobil med blinkande ljus och ljud. Du visar flashcards. 'Bebisen behöver stimulans!'",
                        rightApproach: "Du pratar med bebisen, sjunger, bär henne nära, ger hud-mot-hud och lägger henne på magen en kort stund varje dag. Du tittar henne i ögonen och ler. 'Den bästa stimulansen just nu är du – din röst, ditt ansikte, din närvaro.'",
                        explanation: "Under den fjärde trimestern behöver bebisen framför allt din närvaro, inte leksaker. Ditt ansikte är det mest fascinerande föremålet i barnets värld. Att prata, sjunga och ge ögonkontakt är den perfekta stimulansen. Tummy time i korta stunder bygger styrka."
                    )
                ],
                exercise: CourseExercise(
                    title: "Fjärde trimestern-dagbok",
                    description: "Dokumentera ditt barns utveckling under de första veckorna. Notera små framsteg som du annars kanske missar i sömnbristen.",
                    steps: [
                        "Skapa en enkel dagbok (papper eller telefon) med en rad per dag",
                        "Notera ett nytt beteende eller framsteg du ser: 'Följde mitt finger med blicken', 'Höll upp huvudet 3 sekunder'",
                        "Notera hur barnet svarar på din röst, ditt ansikte och din beröring",
                        "Ta ett foto per vecka i samma position – du kommer bli förvånad över hur snabbt barnet förändras",
                        "Skriv en mening om hur DU mår – det är viktigt att dokumentera",
                        "Dela med din partner – det stärker känslan av att vara ett team"
                    ],
                    duration: "Löpande under de tre första månaderna"
                ),
                reflectionQuestions: [
                    "Hur upplever du den fjärde trimestern – vilka delar är svårast och vilka är mest magiska?",
                    "Får du tillräckligt med stöd och avlösning? Vad behöver du mer av?",
                    "Hur hanterar du sömnbristen? Finns det praktiska lösningar du inte provat?",
                    "Kan du hitta stunder av glädje mitt i kaoset? Vad ger dig energi?"
                ],
                forumSection: CourseForumSection(
                    intro: "Den fjärde trimestern är en berg-och-dalbana. Det hjälper att veta att andra föräldrar delar exakt samma upplevelse.",
                    consensus: "Föräldrar är överens om att ingen kan förbereda en för hur det verkligen känns – men att det hjälper att veta att det är normalt att tycka det är svårt, och att det blir lättare.",
                    quotes: [
                        "\"De tre första månaderna var det tuffaste jag gjort. Men vid exakt 12 veckor log hon rakt mot mig och allt var värt det.\" – Rebecca, mamma till Lea 4 mån",
                        "\"Bästa rådet: sänk ALLA förväntningar. Ät, sov, håll bebisen. Mer behöver du inte göra de första veckorna.\" – Mattias, pappa till Elton 6 veckor",
                        "\"Jag hade ingen aning om att alla bebisar gråter så mycket. Att läsa att det toppar vid 6 veckor och sedan minskar räddade mig.\" – Elin, mamma till Mio 3 mån"
                    ],
                    source: "Baserat på Harvey Karps fjärde trimester-koncept och BVC:s utvecklingsuppföljning"
                ),
                readingTimeMinutes: 12
            ),
            // Module 2
            CourseModule(
                id: "fau-2",
                title: "3-6 månader: Upptäckternas tid",
                subtitle: "Världen öppnar sig",
                icon: "sparkles",
                introduction: """
                Mellan tre och sex månader händer en explosion av utveckling. Bebisen som nyss verkade mest sova och äta blir plötsligt en aktiv, nyfiken och social varelse som vill upptäcka allt. Det sociala leendet som framkallades vid 6-8 veckor blir nu till högljudda skratt, jollersamtal och en förmåga att hålla ögonkontakt som får dig att smälta. Den här perioden är ofta den som föräldrar minns som den mest njutbara.

                Motoriskt sker stora framsteg. Barnet lär sig kontrollera händerna – först genom att hålla föremål som läggs i handen och sedan genom att aktivt sträcka sig efter och gripa saker. Allt hamnar i munnen, eftersom munnen vid denna ålder är det känsligaste verktyget för att utforska. Rullningen (från mage till rygg och sedan tvärtom) kan börja så tidigt som vid tre månader eller så sent som vid sex månader – variationen är enorm.

                Kognitivt börjar barnet förstå orsak och verkan: 'Om jag skakar den här skallran, kommer det ett ljud.' Det är början på medveten interaktion med omvärlden. Barnet börjar också känna igen bekanta ansikten och kan visa preferens – det kanske vill helst vara med mamma eller pappa, och reagerar annorlunda på främlingar. Detta är helt normalt och en del av den kognitiva utvecklingen.

                En viktig milstolpe under denna period är etablering av dygnsrytmen. De flesta barn börjar sova längre nattliga perioder (om än med uppvaknanden) och utvecklar ett mönster med 2-3 tuppar om dagen. Det här är också perioden då den beryktade fyramånaders-sömnregressionen kan slå till – en tillfällig försämring av sömnen som egentligen är ett tecken på att hjärnan mognar.
                """,
                keyPoints: [
                    "Sociala leenden utvecklas till skratt och aktiv joller-kommunikation",
                    "Barnet börjar gripa föremål medvetet och utforskar allt med munnen",
                    "Rullning kan börja – det finns ett brett normalspann (3-6 månader)",
                    "Orsak-verkan-förståelse uppstår: skaka skallra → ljud",
                    "Dygnsrytmen etableras – längre nattperioder och tydligare tuppmönster",
                    "4-månadersregressionen är normal – hjärnan utvecklas, sömnen påverkas tillfälligt",
                    "Barnet börjar skilja bekanta från främlingar"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt fyramånadersbarns sömn har plötsligt blivit mycket sämre efter att ha sovit relativt bra.",
                        wrongApproach: "Du tänker att barnet 'gått bakåt' och att något är fel. Du provar nya sömnmetoder i desperation och ändrar allt i rutinerna.",
                        rightApproach: "Du vet att fyramånadersregressionen är en normal del av hjärnans mognad. Du behåller rutinerna, ger extra tröst och vet att det brukar gå över inom 2-6 veckor. 'Hjärnan gör ett stort jobb just nu. Vi rider ut stormen.'",
                        explanation: "Vid fyra månader ändras sömnmönstret permanent – från nyföddsömn till mer vuxenlik sömn med tydliga cykler. Det är inte en regression utan en progression som tillfälligt stör nattsömnen. Konsistens i rutinerna hjälper barnet hitta sin nya sömnrytm."
                    ),
                    CourseExample(
                        scenario: "Din femmånadersbebis stoppar absolut allt i munnen. Du oroar dig för hygien och kvävningsrisk.",
                        wrongApproach: "Du plockar bort allt som barnet sträcker sig efter och säger 'nej, inte i munnen!' varje gång.",
                        rightApproach: "Du ser till att omgivningen är säker (inga smådelar, inga farliga föremål) och låter barnet utforska. Du erbjuder lämpliga leksaker att tugga på. 'Munnen är ditt bästa verktyg just nu – utforska!'",
                        explanation: "Att stoppa saker i munnen är ett av de viktigaste sätten barnet utforskar världen vid denna ålder. Det utvecklar sensorisk förståelse, förbereder munmotoriken för mat och är helt normalt. Din roll är att säkra miljön, inte att stoppa utforskandet."
                    )
                ],
                exercise: CourseExercise(
                    title: "Utvecklingslek 3-6 månader",
                    description: "Testa dessa åldersanpassade lekar som stödjer ditt barns utveckling under perioden 3-6 månader.",
                    steps: [
                        "Spegelleken: håll barnet framför en spegel. Titta på hur det reagerar på sin egen spegelbild",
                        "Sträckleken: lägg leksaker precis utom räckhåll på golvet och låt barnet sträcka sig – det bygger motivation att röra sig",
                        "Jollersamtal: när barnet jollrar, svara! Härma ljuden och pausa – som ett riktigt samtal",
                        "Byta hand: lägg en leksak i ena handen, låt barnet öva på att flytta den till andra handen",
                        "Titta-bort-lek (enkel): göm ditt ansikte bakom händerna och visa dig med 'Tittut!'",
                        "Gör fem minuters medveten lek varje dag och notera barnets reaktioner"
                    ],
                    duration: "5-10 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Vilka nya förmågor har ditt barn visat den senaste veckan?",
                    "Hur kommunicerar ni med varandra? Har ni egna 'samtal'?",
                    "Hur har sömnmönstret förändrats? Kan du se en dygnsrytm ta form?",
                    "Vad gör ditt barn gladast just nu? Hur kan du erbjuda mer av det?"
                ],
                forumSection: CourseForumSection(
                    intro: "Perioden 3-6 månader är ofta en favorit bland föräldrar – bebisen börjar verkligen 'svara' och interagera.",
                    consensus: "De flesta vittnar om att det plötsligt blev roligt – de första skratten, det medvetna gripandet, de långa jollersamtalen. Och att fyramånadersregressionen var tuff men gick över.",
                    quotes: [
                        "\"Vid fyra månader skrattade hon för första gången – åt att pappan nyste. Vi fick henne att skratta i 20 minuter. Bästa kvällen i mitt liv.\" – Gabriel, pappa till Hedda 5 mån",
                        "\"Sömnregressionen var brutal. Två veckor av kaos. Sen plötsligt – bättre än innan. Häng in!\" – Linnea, mamma till Hugo 5 mån",
                        "\"Min son 'pratar' med mig hela dagarna nu. Jag svarar och han svarar tillbaka. Det är det finaste samtalet jag haft.\" – Kristina, mamma till Noah 4 mån"
                    ],
                    source: "Baserat på utvecklingspsykologisk forskning och BVC:s utvecklingsstöd"
                ),
                readingTimeMinutes: 11
            ),
            // Module 3
            CourseModule(
                id: "fau-3",
                title: "6-9 månader: Rörelse och nyfikenhet",
                subtitle: "Barnet börjar utforska på egen hand",
                icon: "figure.crawl",
                introduction: """
                Mellan sex och nio månader tar den motoriska utvecklingen ett jättekliv. De flesta barn lär sig sitta stabilt utan stöd, många börjar åla eller krypa och en del börjar resa sig mot möbler. Det är en period av enorm nyfikenhet – barnet vill nå allt, utforska allt och smaka på allt. Det är också perioden då många föräldrar inser att det är dags att barnsäkra hemmet på allvar.

                Denna period sammanfaller ofta med matintroduktionen, vilket öppnar en helt ny värld av smakupplevelser. Samtidigt börjar separationsångesten visa sig tydligt – barnet som nyss lekte glatt på golvet klamrar sig plötsligt fast och vill inte ens lämnas på golvet medan du går till köket. Det är ett tecken på normal kognitiv utveckling: barnet förstår att du finns, men kan inte förstå att du kommer tillbaka.

                Kommunikationen blir alltmer sofistikerad. Barnet börjar använda gester – vinka, peka, sträcka armarna uppåt – och jollret börjar innehålla stavelser som 'mama' och 'dada'. Det finns dock inget löfte om att 'mama' verkligen syftar på mamma vid denna ålder – barnet experimenterar med ljud. Men de första avsiktliga orden är inte långt borta.

                En viktig aspekt av denna period är barnets ökande behov av att utforska men samtidigt ökande behov av trygghet. Det är den klassiska anknytningsdansen – barnet kryper iväg men tittar tillbaka för att kolla att du finns kvar. Ditt leende och din uppmuntrande blick på avstånd är allt barnet behöver för att våga fortsätta utforska. Var den trygga basen.
                """,
                keyPoints: [
                    "De flesta barn sitter stabilt utan stöd runt 6-7 månader",
                    "Krypning kan börja från 6 månader – men en del hoppar över och går direkt",
                    "Separationsångest visar sig tydligt och kan vara intensiv",
                    "Joller utvecklas till stavelser: 'mama', 'dada', 'baba'",
                    "Gester som att vinka och peka utvecklas – tidig kommunikation",
                    "Barnsäkra hemmet – barnet når längre än du tror!",
                    "Pincettgreppet utvecklas – barnet kan plocka upp små föremål"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt sjumånadersbarn ålar sig framåt men kryper inte. Din kompis bebis i samma ålder kryper redan.",
                        wrongApproach: "Du oroar dig och börjar 'träna' krypning genom att tvinga barnet in i krypställning. 'Alla andra barn kryper redan!'",
                        rightApproach: "Du vet att det finns en enorm normalvariation. Ålning är en förstadium till krypning och helt funktionellt. Du lägger intressanta leksaker just utom räckhåll som motivation och låter barnet lösa problemet själv. 'Du hittar ditt eget sätt att röra dig!'",
                        explanation: "Normalspannet för krypning är 6-10 månader, och en del barn hoppar över krypning helt och går direkt. Det finns ingen forskning som visar att barn som inte kryper utvecklas sämre. Ditt barn utvecklar sin motorik i sin egen takt och ordning."
                    ),
                    CourseExample(
                        scenario: "Ditt åttamånadersbarns har blivit extremt klängigt. Det gråter om du ens lämnar rummet.",
                        wrongApproach: "Du smyger ut ur rummet och hoppas att barnet inte märker. Eller du blir irriterad: 'Jag kan inte ens gå på toa utan att du skriker!'",
                        rightApproach: "Du förstår att detta är separationsångest – ett normalt utvecklingssteg. Du säger alltid vart du går: 'Mamma ska bara gå till köket, jag kommer tillbaka.' Du gör 'tittut' runt hörn som en lek. Med tiden lär sig barnet att du alltid kommer tillbaka.",
                        explanation: "Separationsångest vid 8-9 månader är ett tecken på att anknytningen fungerar och att barnets kognitiva förmåga utvecklats. Barnet förstår att du finns även när du inte syns, men saknar förmågan att förstå tid. Ditt konsekventa återvändande bygger tillit."
                    )
                ],
                exercise: CourseExercise(
                    title: "Utforskningsbana",
                    description: "Skapa en säker utforskningsbana hemma som utmanar ditt barns motorik och nyfikenhet.",
                    steps: [
                        "Barnsäkra ett rum ordentligt: täck eluttag, ta bort ömtåliga saker, säkra möbler",
                        "Skapa en 'bana' med kuddar, filtar och leksaker på golvet",
                        "Placera intressanta föremål (inte bara leksaker – slevar, bollar, tyger) på olika platser",
                        "Sätt dig på golvet och låt barnet utforska fritt",
                        "Kommentera vad barnet gör: 'Åh, du hittade bollen! Den är rund.'",
                        "Observera barnets problemlösning: hur tar det sig fram? Vilka strategier använder det?"
                    ],
                    duration: "20-30 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Hur har barnets rörelsemönster förändrats den senaste månaden?",
                    "Hur hanterar du separationsångesten – din egen och barnets?",
                    "Är hemmet barnsäkrat för barnets nuvarande nivå? Behöver du uppdatera?",
                    "Hur kommunicerar ditt barn med dig nu jämfört med för tre månader sedan?"
                ],
                forumSection: CourseForumSection(
                    intro: "Perioden 6-9 månader är en omställning – bebisen blir plötsligt ett litet barn som rör sig och har en egen vilja.",
                    consensus: "Föräldrar delar att jämförelsen med andra barn är som svårast i denna period. Men alla som har lite perspektiv säger samma sak: det jämnar ut sig.",
                    quotes: [
                        "\"Min son kröp inte vid 8 månader och jag var hysterisk. Vid 9 månader kröp han – och vid 10 gick han. Varje barn har sin egen tidslinje.\" – Erik, pappa till Leo 12 mån",
                        "\"Separationsångesten var brutal. Jag kunde inte lämna rummet utan skrik. Vid 11 månader var den som bortblåst.\" – Angelica, mamma till Maja 11 mån",
                        "\"Det bästa med den här perioden? Att se barnet lösa problem. Hur tar jag mig runt soffan? Genialiska lösningar varje dag.\" – Patrik, pappa till Selma 8 mån"
                    ],
                    source: "Baserat på motorisk utvecklingsforskning och BVC:s utvecklingsuppföljning"
                ),
                readingTimeMinutes: 11
            ),
            // Module 4
            CourseModule(
                id: "fau-4",
                title: "9-12 månader: Personligheten växer fram",
                subtitle: "Från bebis till litet barn",
                icon: "person.fill.badge.plus",
                introduction: """
                De sista tre månaderna av det första året är en period av snabb transformation. Bebisen som nyss låg på en filt på golvet är nu på väg att bli ett litet barn med en tydlig personlighet, egna viljor och en allt mer sofistikerad förmåga att kommunicera. Många barn börjar gå (eller förbereder sig för det), säger sina första ord och visar en allt starkare vilja att göra saker själva.

                Motoriskt kan man ofta se barnet resa sig mot möbler, 'kryssmöblera' (gå längs möbler med stöd) och kanske ta sina första steg. Det normala spannet för första steget är 9-16 månader – en enorm variation. Finmotoriken utvecklas också: pincettgreppet (tumme mot pekfinger) gör att barnet kan plocka upp små föremål som ärtor och russin, vilket är både en fantastisk färdighet och en säkerhetsrisk.

                Språkligt börjar de flesta barn säga sina första meningsfulla ord runt ettårsdagen, men passiv språkförståelse är mycket längre kommen. Ditt barn förstår troligen många fler ord än det kan säga: 'Var är bollen?', 'Vill du ha mat?', 'Vi ska gå ut.' Att prata mycket med barnet, namnge föremål och beskriva vad ni gör stödjer språkutvecklingen enormt.

                Personlighetsmässigt visar sig temperament och preferenser allt tydligare. En del barn är forsfarande modiga utforskare som klättrar på allt, medan andra är försiktigare och observerande. En del är sociala och söker kontakt med alla, andra är mer reserverade. Allt är normalt – det är ditt barns unika personlighet som tar form. Din uppgift är att se och respektera detta unika barn, inte att forma det efter en mall.
                """,
                keyPoints: [
                    "Första stegen tas normalt mellan 9-16 månader – variationen är stor",
                    "Pincettgreppet möjliggör finmotorik men kräver vaksamhet på smådelar",
                    "Första meningsfulla orden kommer runt 12 månader – men förståelsen är långt före",
                    "Barnets personlighet och temperament blir allt tydligare",
                    "Vilja och självständighet ökar – 'Jag kan själv!' börjar ta form",
                    "Imitation är ett kraftfullt lärverktyg – barnet kopierar allt du gör"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn är 11 månader och har inte tagit sina första steg. Alla kompisar barn i samma ålder går redan.",
                        wrongApproach: "Du håller barnet i händerna och 'går' det runt huset hela dagarna. Du köper en gåstol. Du oroar dig högt för att barnet är försenat.",
                        rightApproach: "Du skapar möjligheter: möbler att resa sig mot, stabila leksaker att skjuta framför sig, golvet fritt att utforska. Du vet att 9-16 månader är normalspannet och att varje barn har sin tidslinje. Du uppmuntrar utan att tvinga.",
                        explanation: "Gåstolar rekommenderas inte av barnläkare – de kan försinkar den naturliga utvecklingen och är en olycksrisk. Barn som tillåts utvecklas i sin egen takt bygger starkare muskulatur och bättre balans. De som går sent går ofta säkrare."
                    ),
                    CourseExample(
                        scenario: "Ditt ettåriga barn vill göra allt själv – äta med sked, ta på skor, öppna lådor – men klarar det inte och blir frustrerat.",
                        wrongApproach: "Du tar över direkt: 'Nej, du klarar inte det, låt mig göra det.' Du gör allt åt barnet för att det ska gå snabbare.",
                        rightApproach: "Du låter barnet försöka, hjälper lite i smyg om det behövs och uppmuntrar ansträngningen: 'Du försöker verkligen! Ska jag hjälpa lite med dragkedjan?' Du ger tid – det tar längre tid, men det bygger självständighet.",
                        explanation: "Viljan att göra själv är en av de viktigaste utvecklingskrafterna. Att ta över kvävde motivationen. Att låta barnet kämpa lite (lagom frustration) och sedan hjälpa bygger uthållighet och tillit till den egna förmågan. Tiden du investerar nu sparar du senare."
                    )
                ],
                exercise: CourseExercise(
                    title: "Personlighetsporträttet",
                    description: "Skriv ett 'porträtt' av ditt barns framväxande personlighet. Det blir ett fantastiskt minne – och hjälper dig se och förstå ditt unika barn.",
                    steps: [
                        "Beskriv barnets temperament: modigt/försiktigt, socialt/reserverat, lugnt/intensivt",
                        "Vad gör barnet gladast? Vilken lek, vilken plats, vilken person?",
                        "Hur reagerar barnet på nya situationer, nya människor, nya platser?",
                        "Vad frustrerar barnet mest? Hur visar det frustration?",
                        "Vilka är barnets första ord eller tecken? Vad kommunicerar det?",
                        "Spara porträttet – du kommer att älska att läsa det om tio år"
                    ],
                    duration: "30 minuter"
                ),
                reflectionQuestions: [
                    "Hur skulle du beskriva ditt barns personlighet? Liknar det dig eller din partner?",
                    "Hur balanserar du mellan att hjälpa och att låta barnet klara sig själv?",
                    "Vilka färdigheter har barnet som förvånar dig?",
                    "Hur hanterar du det ökande behovet av tillsyn nu när barnet rör sig mer?"
                ],
                forumSection: CourseForumSection(
                    intro: "De sista månaderna av det första året är fyllda av 'första gånger' och snabb utveckling.",
                    consensus: "Föräldrar delar att det går otroligt fort – och att de önskar att de hade stannat upp och njutit mer. Och att jämförelsen med andra barn aldrig leder till något gott.",
                    quotes: [
                        "\"Min dotter sa 'pappa' före 'mamma'. Jag var lite ledsen i tre sekunder – sedan smälte jag av lycka. Första ordet!\" – Anna, mamma till Elise 11 mån",
                        "\"Han gick inte förrän vid 15 månader. Jag var orolig i månader. Nu springer han fortare än alla kompisar.\" – Jonas, pappa till Valter 2 år",
                        "\"Det bästa med denna ålder: barnet visar vem det ÄR. Min son är lugn, observerande och strategisk. Precis som sin farfar.\" – Maria, mamma till Eskil 12 mån"
                    ],
                    source: "Baserat på WHO:s motoriska milstolpar och utvecklingspsykologisk forskning"
                ),
                readingTimeMinutes: 11
            ),
            // Module 5
            CourseModule(
                id: "fau-5",
                title: "Stimulera utvecklingen",
                subtitle: "Enkla sätt att stödja ditt barns lärande",
                icon: "puzzlepiece.fill",
                introduction: """
                Alla föräldrar vill ge sina barn bästa möjliga förutsättningar, och det är lätt att hamna i en prestationsångest kring stimulans och utveckling. Sanningen är att den bästa stimulansen inte kostar pengar, kräver inga speciella leksaker och ingen expertkunskap. Den bästa stimulansen är du – en närvarande, engagerad förälder som pratar, sjunger, leker och utforskar världen tillsammans med sitt barn.

                Forskning om hjärnans utveckling under det första året visar att det som har störst positiv effekt är 'serve and return'-interaktioner: barnet gör något (jollrar, pekar, ler) och du svarar (svarar, tittar, ler tillbaka). Denna enkla dans av kommunikation bygger miljontals neurala kopplingar. Varje gång du svarar på ditt barns initiativ stärks hjärnan. Det är inte komplicerat – men det kräver närvaro.

                Lek är barnets viktigaste lärverktyg. Under det första året handlar lek om att utforska med alla sinnen: känna på texturer, höra ljud, se färger och mönster, smaka och lukta. Leksaker behöver inte vara dyra eller avancerade – en trähållare, en metallkastrull att slå på, en korg med tyger i olika texturer är perfekta. De bästa leksakerna är öppna – de kan användas på många sätt istället för att göra en enda sak.

                Det är lika viktigt att veta vad du INTE behöver göra. Du behöver inte visa flashcards, spela Mozart, köpa 'pedagogiska' appar eller ägna hela dagen åt strukturerad stimulans. Överstimulering är lika kontraproduktivt som understimulering. Barn behöver också tid för vila, självlek och att bara vara. Att respektera barnets signaler – intresse eller mättnad – är nyckeln.
                """,
                keyPoints: [
                    "Den bästa stimulansen är din närvaro och ditt engagemang – inte leksaker",
                    "'Serve and return'-interaktioner bygger hjärnans arkitektur",
                    "Prata med barnet – beskriv vad ni gör, namnge saker, berätta historier",
                    "Enkla leksaker som kan användas på många sätt slår avancerade elektroniska",
                    "Överdriv inte – barn behöver också tid att bara vara och utforska själva",
                    "Lek utomhus i naturen ger stimulans för alla sinnen",
                    "Läs böcker från allra första dagarna – det stödjer språk och anknytning"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du känner skuld för att du inte 'stimulerar' barnet tillräckligt. Du jämför dig med föräldrar på Instagram som gör sensoriska lekar varje dag.",
                        wrongApproach: "Du beställer dyra sensoriska lekkit, bok om babystimulans och planerar schemalagda 'lektioner' varje dag. Du stressar över att du inte gör tillräckligt.",
                        rightApproach: "Du påminner dig: att byta blöja med ögonkontakt är stimulans. Att prata under promenaden är stimulans. Att sjunga i duschen är stimulans. Du slutar följa stressande konton och leker med barnet på det sätt som känns naturligt.",
                        explanation: "Instagram visar höjdpunkterna, inte verkligheten. Forskning visar att vardaglig interaktion – ögonkontakt, samtal, lek – ger all stimulans ett barn behöver. Strukturerade aktiviteter kan vara roliga men är inte nödvändiga. Det viktigaste är din autentiska närvaro."
                    ),
                    CourseExample(
                        scenario: "Ditt barn vill leka med samma saker hela tiden – slå två klossar mot varandra om och om igen.",
                        wrongApproach: "Du tar klossarna och visar att man ska 'bygga torn istället'. 'Titta, gör så här!' Du styr leken mot det du tycker är mer utvecklande.",
                        rightApproach: "Du observerar: barnet utforskar ljud, orsak-verkan, kraft. Du kommenterar: 'Vad fint det låter! Prova den här klosssn – den låter annorlunda.' Du följer barnets intresse och berikar det, istället för att styra om.",
                        explanation: "Repetitiv lek är inte slöseri med tid – det är djupinlärning. Barnet bearbetar och befäster nya kunskaper genom upprepning. Att styra om till 'bättre' lek avbryter barnets koncentration och inlärningsprocess. Följ barnets initiativ och bygg vidare på det."
                    )
                ],
                exercise: CourseExercise(
                    title: "En veckas vardagsstimulans",
                    description: "Under en vecka, var medveten om alla vardagliga stunder som är stimulans – utan att lägga till något extra.",
                    steps: [
                        "Varje dag, notera tre stunder där du interagerade med barnet (ögonkontakt vid amning, samtal vid blöjbyte, lek på golvet)",
                        "Försök svara på barnets initiativ varje gång du märker ett: joller, gest, blick",
                        "Beskriv vad du gör och ser: 'Nu tar vi på tröjan – den är blå! Först ena armen...'",
                        "Läs en bok varje dag – det räcker med en kort pekbok",
                        "Gå ut varje dag – kommentera vad ni ser: fåglar, bilar, löv, hundar",
                        "Reflektera: hur mycket stimulans ger du redan utan att tänka på det?"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Jämför du dig med andra föräldrar när det gäller stimulans? Hur påverkar det dig?",
                    "Hur mycket av dagen ägnar du åt skärmar vs. interaktion med barnet?",
                    "Kan du hitta stimulans i vardagsrutinerna – blöjbyte, matlagning, promenad?",
                    "Respekterar du barnets signaler för 'nog'? Hur visar barnet att det vill vara ifred?"
                ],
                forumSection: CourseForumSection(
                    intro: "Prestationsångest kring stimulans är vanligare än man tror. Avdramatiseringen har hjälpt många.",
                    consensus: "Föräldrar vittnar om att de redan stimulerade sina barn mer än tillräckligt – de behövde bara sluta jämföra med Instagram och börja lita på sig själva.",
                    quotes: [
                        "\"Jag insåg att jag pratade med mitt barn hela dagarna, sjöng, lekte – men ändå kände mig otillräcklig. Nu vet jag: det jag redan gör ÄR stimulans.\" – Evelina, mamma till Milo 7 mån",
                        "\"Vi slutade med planerade aktiviteter och lekte med kastruller och tygbitar. Barnet var mycket gladare. Och vi med.\" – Jakob, pappa till Tilda 9 mån",
                        "\"En BHV-psykolog sa: 'Om du pratar med ditt barn, tittar det i ögonen och svarar när det jollrar – grattis, du stimulerar optimalt.' Jag andades ut.\" – Mikaela, mamma till Oliwer 5 mån"
                    ],
                    source: "Baserat på Center on the Developing Childs forskning om 'serve and return' och lekens betydelse"
                ),
                readingTimeMinutes: 10
            ),
            // Module 6
            CourseModule(
                id: "fau-6",
                title: "När ska man oroa sig?",
                subtitle: "Varningssignaler och när du bör söka hjälp",
                icon: "exclamationmark.triangle.fill",
                introduction: """
                En av de svåraste balanserna som förälder är att å ena sidan acceptera att alla barn utvecklas i sin egen takt och å andra sidan vara uppmärksam på signaler som kan tyda på att barnet behöver extra stöd. Det finns ett brett normalspann för all utveckling – men det finns också gränser för det spannet. Att veta vad som är normalt och vad som bör utredas ger trygghet och säkerställer att barnet får hjälp i tid om det behövs.

                Det svenska BVC-systemet är utformat för att fånga utvecklingsavvikelser tidigt. Regelbundna kontroller med mätningar, observationer och screening följer barnets fysiska, motoriska, kognitiva och sociala utveckling. Men BVC-besöken sker med veckor eller månader emellan, och du som förälder ser barnet varje dag. Din magkänsla är värdefull – om något känns fel, lyssna på den och kontakta BVC.

                Det finns några specifika saker att vara uppmärksam på: om barnet inte visar socialt intresse (leende, ögonkontakt, reaktion på din röst) vid 3 månader, om barnet inte kan hålla upp huvudet vid 4 månader, om det inte sitter vid 9 månader, om det inte jollrar eller använder gester vid 12 månader, eller om du ser att barnet förlorar färdigheter det redan haft. Dessa behöver inte betyda att något är fel – men de bör utredas.

                Det allra viktigaste: att söka hjälp tidigt är alltid rätt. Ingen barnläkare, BVC-sköterska eller specialistmottagning kommer att tycka att du är överbeskyddande eller dum. Tvärtom – tidig upptäckt och tidiga insatser ger bästa möjliga utfall om det verkligen finns en avvikelse. Och om allt visar sig vara normalt har du fått trygghet och lugn. Det finns inga nackdelar med att fråga.
                """,
                keyPoints: [
                    "Ett brett normalspann finns för all utveckling – men det finns gränser",
                    "BVC följer utvecklingen regelbundet – men din dagliga observation är lika viktig",
                    "Lyssna på din magkänsla – om något känns fel, kontakta BVC",
                    "Varningssignaler: saknad ögonkontakt, inget socialt leende vid 3 mån, inget sittande vid 9 mån",
                    "Förlust av färdigheter som barnet redan haft bör alltid utredas",
                    "Tidig hjälp ger bäst resultat – det är alltid rätt att fråga",
                    "Att oroa sig ibland är normalt som förälder – men lev inte i oro, sök svar"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn är 8 månader och sitter inte stadigt utan stöd. Din kompis barn i samma ålder sitter och kryper redan.",
                        wrongApproach: "Du panikgooglar 'sen sittare 8 månader' och läser skräckscenarier på forum. Du bokar privat barnläkare utan att prata med BVC först.",
                        rightApproach: "Du noterar att barnet visar framsteg – det kanske sitter med stöd, lutar sig framåt och övar. Du ringer BVC och beskriver vad du ser. BVC-sköterskan bedömer och bokar eventuellt ett extra besök. 'Jag vill gärna att ni tittar på hur hon sitter, jag vill vara trygg.'",
                        explanation: "Att inte sitta stadigt vid 8 månader är inom normalspannet men bör följas upp. BVC är rätt instans att kontakta – de har erfarenhet av vad som är normalt och vad som bör utredas. Att ringa kostar ingenting och ger antingen trygghet eller rätt åtgärd."
                    ),
                    CourseExample(
                        scenario: "Ditt barn var tio månader och sa 'mama' och 'dada'. Nu vid tolv månader har det slutat och jollrar inte alls.",
                        wrongApproach: "Du tänker: 'Det är säkert bara en fas.' Du väntar och hoppas att det kommer tillbaka av sig själv.",
                        rightApproach: "Du kontaktar BVC omedelbart. Förlust av språk eller sociala färdigheter bör alltid utredas, oavsett ålder. Du beskriver precis vad du observerat: 'Han sa mama och dada för två månader sedan, men har slutat helt. Jag vill att ni tittar på det.'",
                        explanation: "Regression – att förlora färdigheter barnet redan hade – är en av de viktigaste varningssignalerna att vara uppmärksam på. Det kan ha många förklaringar, de flesta ofarliga, men det ska alltid utredas. Att agera snabbt är alltid rätt i denna situation."
                    )
                ],
                exercise: CourseExercise(
                    title: "Utvecklingsöversikt",
                    description: "Gå igenom en enkel utvecklingsöversikt för ditt barns ålder och notera var ditt barn befinner sig.",
                    steps: [
                        "Hitta BVC:s utvecklingsöversikt för ditt barns ålder (vi tillhandahåller den i kursmaterialet)",
                        "Gå igenom varje punkt: motorik, kommunikation, social förmåga, kognition",
                        "Notera vilka färdigheter ditt barn har, vilka som är på gång och vilka som saknas",
                        "Finns det områden som oroar dig? Skriv ner dem",
                        "Förbered frågor till nästa BVC-besök",
                        "Andas. De flesta barn ligger helt inom normalspannet – och om inte, finns hjälp"
                    ],
                    duration: "30 minuter"
                ),
                reflectionQuestions: [
                    "Finns det specifika delar av ditt barns utveckling som oroar dig? Har du pratat med BVC?",
                    "Hur skiljer du mellan normal oro och verkliga varningssignaler?",
                    "Litar du på din magkänsla som förälder? Har du agerat på den?",
                    "Vad skulle ge dig mer trygghet kring ditt barns utveckling?"
                ],
                forumSection: CourseForumSection(
                    intro: "Oro för barnets utveckling är en av de vanligaste anledningarna till att föräldrar söker stöd. Du är inte ensam – och det finns hjälp.",
                    consensus: "Det gemensamma budskapet är: lita på din magkänsla, sök svar när du är orolig och jämför inte med andra barn. Och: i de allra flesta fall är allt helt normalt.",
                    quotes: [
                        "\"Jag oroade mig för att min son inte kröp vid 10 månader. BVC-sköterskan lugnade mig – han var stark och aktiv på andra sätt. Vid 11 månader gick han rakt upp.\" – Henrik, pappa till Olle 14 mån",
                        "\"Min dotter hade slutat jollra och jag ringde BVC. Det visade sig vara en öroninflammation – hon hörde dåligt. Vi fick hjälp direkt.\" – Susanne, mamma till Freja 9 mån",
                        "\"Bästa rådet: ring BVC om du oroar dig. De sa 'Vi vill hellre att du ringer en gång för mycket än en gång för lite.' Det lugnade mig.\" – Johan, pappa till Vera 7 mån"
                    ],
                    source: "Baserat på BVC:s screeningprogram och svenska riktlinjer för tidig upptäckt"
                ),
                readingTimeMinutes: 12
            )
        ],
        targetAudience: "Föräldrar med barn 0-12 månader",
        estimatedWeeks: 6
    )
}

// MARK: - Course 6: Amning — din guide till en bra start

extension Course {
    static let amningGuide = Course(
        id: "amning-guide",
        title: "Amning — din guide till en bra start",
        subtitle: "Praktisk kunskap för de avgörande första veckorna",
        description: "En kurs som ger dig evidensbaserad kunskap om amning — från förberedelse under graviditeten till avvänjning. Lär dig rätt teknik, hur du hanterar vanliga problem och hur du fattar välgrundade beslut om din och bebisens matning.",
        icon: "drop.fill",
        gradient: LinearGradient(colors: [Color(hex: "0EA5E9"), Color(hex: "38BDF8")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "amning-1",
                title: "Förberedelse för amning",
                subtitle: "Vad du kan göra redan under graviditeten",
                icon: "checkmark.circle.fill",
                introduction: """
                De flesta mammor kan amma, men kunskap ökar sannolikheten för en bra start avsevärt. Amning är en färdighet som lärs in — av dig och din bebis — och förberedelse under graviditeten gör de första dygnen mer hanterbara.

                Brösten börjar förbereda sig för amning tidigt i graviditeten. Från vecka 16 produceras råmjölk (kolostrum) — en guldfärgad, koncentrerad vätska rik på antikroppar och näring. Produktionen av mogen mjölk startar 2-5 dagar efter förlossningen, styrd av hormonet prolaktin.

                Det viktigaste du kan göra under graviditeten är att informera dig. Gå på amningskurs (erbjuds av barnmorskan/MVC), läs om rätt amningsteknik, och bestäm dig för hur länge du vill försöka amma utan att sätta orealistiska mål.
                """,
                keyPoints: [
                    "Kolostrum produceras redan från vecka 16 — brösten är redan förberedda",
                    "Amning är en inlärd färdighet — förberedelse ökar chansen till lyckad start",
                    "Rätt tag (latch) är det viktigaste enskilda elementet för smertsam amning",
                    "Hud-mot-hud direkt efter förlossningen stimulerar amning effektivt",
                    "Amningsstöd finns att få — du behöver inte klara det ensam"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du är gravid i vecka 30 och orolig för att du inte har tillräckligt med mjölk",
                        wrongApproach: "Vänta och hoppas att det löser sig — eller köp hemlagringspump direkt.",
                        rightApproach: "Gå på amningskurs via MVC, diskutera med barnmorskan, och lär dig om hur mjölkproduktionen fungerar.",
                        explanation: "Mjölkproduktionen styrs av bebisens sugande — inte av bröststorlek eller förberedelse. Kunskap minskar oro."
                    )
                ],
                exercise: CourseExercise(
                    title: "Amningsförberedelse",
                    description: "Gör tre konkreta saker den här veckan för att förbereda dig för amning.",
                    steps: [
                        "Boka amningskurs via MVC om du inte redan gjort det",
                        "Läs om rätt amningsteknik och rätt tag (latch) — amningshjälpen.se är en bra källa",
                        "Prata med din partner om hur ni ska samarbeta kring amning/matning",
                        "Förbered en amningskorg: vatten, snacks, amningskudde, amningsinlägg, lanolin",
                        "Lägg in telefonnumret till amningsrådgivaren på MVC i mobilen"
                    ],
                    duration: "En timmes förberedelse"
                ),
                reflectionQuestions: [
                    "Vilka förväntningar har du på amningen? Är de realistiska?",
                    "Hur länge vill du försöka amma? Vad händer om det inte fungerar — vad är din Plan B?",
                    "Vet du var du kan söka amningsstöd om det blir svårt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Blivande mammor och nyblivna mammor delar om amningsförberedelse:",
                    consensus: "De flesta önskar att de hade förberett sig mer. Amningskursen via MVC nämns som värdefull. Att veta att det kan vara svårt — och att hjälp finns — ses som det viktigaste.",
                    quotes: [
                        "\"Ingen berättade för mig att det kunde göra ONT de första veckorna. Förberedelse hade minskat chocken.\" – Sara, mamma till Alva 2 mån",
                        "\"Amningskursen var ovärderlig. Lärde oss rätt tag och vad normal amning ser ut.\" – Karin, mamma till Noel 3 mån",
                        "\"Valde att inte amma. Bästa beslut vi tog för vår familj. Det är OK att det inte passar alla.\" – Marie, mamma till Leo 5 mån"
                    ],
                    source: "Amningshjälpen.se, WHO/UNICEF Baby-Friendly Hospital Initiative"
                ),
                readingTimeMinutes: 8
            ),
            CourseModule(
                id: "amning-2",
                title: "Amningsteknik",
                subtitle: "Rätt tag är allt",
                icon: "hand.point.up.left.fill",
                introduction: """
                Det vanligaste skälet till amningssmärta och mjölkproblem är felaktigt tag. Med rätt tag töms bröstet effektivt, du slipper sår bröstvårtor och mjölkproduktionen stimuleras optimalt.

                Amning ska inte göra ont. Lite initial ömhet de första dagarna är normalt, men ihållande smärta är ett tecken på att något inte stämmer — oftast tagget. Det är alltid rätt att kontakta amningsrådgivare om amningen gör ont.

                Det finns flera amningspositioner — välj den som fungerar för dig och bebisen. Fotbollsgrepp, ligga ner och amma, klassisk madonna-position, crossover. Pröva dig fram. Nyfödda ammar 8-12 gånger per dygn, vilket är helt normalt och nödvändigt för mjölkproduktionen.
                """,
                keyPoints: [
                    "Bebisens mun ska vara vidöppen vid tag — som ett gäspande",
                    "Läpparna ska vara utåtvikta, hakan mot bröstet, näsan fri",
                    "Areolan (inte bara bröstvårtan) ska vara i munnen",
                    "Amning ska inte göra ont — ihållande smärta kräver hjälp",
                    "Nyfödda ammar 8-12 gånger/dygn — det är normalt, inte otillräcklig mjölk"
                ],
                examples: [
                    CourseExample(
                        scenario: "Bebisen verkar inte vilja ta tag eller tappar bröstet hela tiden",
                        wrongApproach: "Pressa bebisens huvud mot bröstet hårdare eller ge upp och ta fram flaska.",
                        rightApproach: "Försök igen med wider approach: håll bröstet, tickla bebisens läppar med bröstvårtan tills munnen öppnar sig STORT, och för sedan bebisen snabbt in mot bröstet.",
                        explanation: "Bebisen behöver ha munnen vidöppen INNAN du för henne mot bröstet. Hastigheten är viktig — sänka snarare än att pressa."
                    )
                ],
                exercise: CourseExercise(
                    title: "Amningsteknik-checklist",
                    description: "Gå igenom rätt amningsteknik steg för steg vid nästa amningstillfälle.",
                    steps: [
                        "Hitta en bekväm position — stöd din arm och rygg",
                        "Håll bebisen mage mot mage, örat-axel-höft i en rak linje",
                        "Tickla bebisens läppar med bröstvårtan — vänta tills munnen öppnar sig brett",
                        "För bebisen snabbt mot bröstet (inte bröstet mot bebisen)",
                        "Kontrollera: utåtvikta läppar? Haka mot bröstet? Gör det inte ont?",
                        "Om smärta — bryt suget med finger i mungipan och försök igen"
                    ],
                    duration: "Praktisera vid varje amningstillfälle"
                ),
                reflectionQuestions: [
                    "Gör amningen ont? Om ja — har du sökt hjälp av amningsrådgivare?",
                    "Verkar bebisen nöjd efter amning, åtminstone ibland?",
                    "Hur många gånger ammar bebisen per dygn?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om amningsteknik:",
                    consensus: "Rätt tag nämns som den enskilt viktigaste faktorn. Att söka hjälp av amningsrådgivare vid smärta ses som självklart i efterhand.",
                    quotes: [
                        "\"Amningsrådgivaren kom hem till oss dag 4. Fixade tagget på 10 minuter. Aldrig ont sedan dess.\" – Lisa, mamma till Ebbe 6 veckor",
                        "\"Videoguider på YouTube hjälpte mig förstå hur tagget ska se ut. Lättare att lära sig visuellt.\" – Petra, mamma till Ida 2 mån"
                    ],
                    source: "Amningshjälpen.se, WHO Baby-Friendly Hospital guidelines"
                ),
                readingTimeMinutes: 7
            ),
            CourseModule(
                id: "amning-3",
                title: "Vanliga utmaningar",
                subtitle: "Mjölkstockning, mastit och osäker mjölkproduktion",
                icon: "exclamationmark.triangle.fill",
                introduction: """
                De flesta ammande mammor möter utmaningar — det är normalt, inte ett tecken på misslyckande. Kunskap om vanliga problem och hur man hanterar dem gör det möjligt att fortsätta amma om det är ditt mål, eller fatta ett välgrundat beslut om att gå över till flaskmatning.

                Ömma bröstvårtor, mjölkstockning och mastit är de vanligaste problemen de första veckorna. Alla har lösningar. Nyckeln är att söka hjälp tidigt — inte att brottas med problemen ensam.
                """,
                keyPoints: [
                    "Ömma bröstvårtor orsakas nästan alltid av felaktigt tag — inte av 'för känslig hud'",
                    "Mjölkstockning behandlas med värme, massage och frekventa amningstillfällen",
                    "Mastit kräver antibiotika men amning ska fortsätta under behandlingen",
                    "Uppfattad otillräcklig mjölk är vanligare än verklig brist — bebisen avgör med antalet blötor blöjor",
                    "Amningsrådgivare (IBCLC) kan lösa de flesta problem"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vaknar med ett hårt, ömt område i bröstet och rodnad på huden",
                        wrongApproach: "Undvika att amma från det bröstet för att det gör ont.",
                        rightApproach: "Värm bröstet, massera mot bröstvårtan, amma ofta från det drabbade bröstet och kontakta barnmorskan vid feber.",
                        explanation: "Att tömma bröstet är behandlingen vid mjölkstockning. Att undvika det förvärrar och kan leda till mastit."
                    )
                ],
                exercise: CourseExercise(
                    title: "Problemlösningsplan",
                    description: "Förbered en plan för vad du gör om amningsproblemet uppstår.",
                    steps: [
                        "Lägg in Amningshjälpens nummer i telefonen: 0771-22 00 00",
                        "Identifiera vem din amningsrådgivare på MVC är och hur du kontaktar henne",
                        "Köp lanolin-salva och amningsinlägg i god tid",
                        "Lär dig tecknen på mastit: feber, frossa, röd/het fläck i bröstet = sök vård"
                    ],
                    duration: "30 minuters förberedelse"
                ),
                reflectionQuestions: [
                    "Vet du vad du ska göra om amningen gör ont?",
                    "Har du telefonnumret till amningsrådgivaren sparad?",
                    "Vad är din plan om amningen inte fungerar — är du redo att fatta det beslutet utan skuld?"
                ],
                forumSection: CourseForumSection(
                    intro: "Mammor delar om amningsutmaningar:",
                    consensus: "Att söka hjälp tidigt — och att sluta amma är ett giltigt val — är det genomgående budskapet.",
                    quotes: [
                        "\"Hade mastit tre gånger. Tredje gången var nog. Ingen ska behöva lida för att amma.\" – Helena",
                        "\"Amningsrådgivaren bokade in mig dagen efter jag ringde. Gratis. Världens bästa investering.\" – Johanna"
                    ],
                    source: "Amningshjälpen.se, 1177.se"
                ),
                readingTimeMinutes: 8
            ),
            CourseModule(
                id: "amning-4",
                title: "Kostråd under amning",
                subtitle: "Vad du behöver äta — och inte äta",
                icon: "fork.knife",
                introduction: """
                Amning kräver extra kalorier och vätska, men det är inte nödvändigt med en perfekt kost för att producera näringssrik mjölk. Kroppens prioritering är alltid bebisen — om din kost är bristfällig tar mjölken näringen från dina egna förråd.

                Det viktiga är att äta tillräckligt (ungefär 500 kalorier extra per dag), dricka tillräckligt (lyssna på törst), och inte utesluta hela livsmedelsgrupper utan anledning. Myten om att du måste undvika vitlök, kål och kryddstark mat är i stort sett ogrundad — de flesta mammor kan äta normalt utan att bebisen reagerar.
                """,
                keyPoints: [
                    "500 extra kalorier per dag rekommenderas under amning",
                    "D-vitamin-tillskott till bebisen rekommenderas oavsett kosthållning",
                    "Alkohol: liten mängd är OK — vänta 2-3 timmar per drink innan amning",
                    "Koffein passerar till mjölken men är OK i normala mängder (max 2-3 koppar kaffe)",
                    "De flesta mammor kan äta normalt — undvik inte mat utan anledning"
                ],
                examples: [
                    CourseExample(
                        scenario: "Bebisen verkar kolik-trött och gasig — du misstänker att det beror på din mat",
                        wrongApproach: "Sluta äta vitlök, lök, kål, citrus och allt kryddstark omedelbart.",
                        rightApproach: "Håll matdagbok i en vecka. Om ett specifikt livsmedel konsekvent verkar ge bebisen symtom 2-6 timmar efter att du ätit det — testa att utesluta just det under en vecka.",
                        explanation: "Studier visar att kolik sällan beror på mammans kost. Eliminationsdieter utan anledning kan leda till näringsbrist."
                    )
                ],
                exercise: CourseExercise(
                    title: "Amningskost-vecka",
                    description: "Fokusera på att äta tillräckligt och dricka tillräckligt den här veckan.",
                    steps: [
                        "Ät tre ordentliga måltider per dag — hoppa inte över frukost",
                        "Ha snacks lättillgängligt: nötter, frukt, yoghurt, smörgås",
                        "Drick ett glas vatten inför varje amningstillfälle",
                        "Ta D-vitamintillskott till bebisen om BVC rekommenderat det",
                        "Ät inte restriktivt — ditt välmående påverkar amningen"
                    ],
                    duration: "En veckas fokus"
                ),
                reflectionQuestions: [
                    "Äter du tillräckligt? Hoppar du ofta över måltider?",
                    "Dricker du tillräckligt vatten? Är du sällan törstig?",
                    "Har du uteslutit livsmedel utan konkret anledning?"
                ],
                forumSection: CourseForumSection(
                    intro: "Ammande mammor om kosthållning:",
                    consensus: "De flesta inser att de onödigt begränsat sin kost. Att äta gott och tillräckligt beskrivs som viktigare än att utesluta mat.",
                    quotes: [
                        "\"Åt ingenting med smak i tre månader. Bebisen fick kolik ändå. Önskar att jag vetat att det inte var mitt fel.\"",
                        "\"Amningssuget var reellt. Ät och drick ordentligt — det gör skillnad för hur du mår.\""
                    ],
                    source: "Livsmedelsverket, WHO Infant Feeding guidelines"
                ),
                readingTimeMinutes: 6
            ),
            CourseModule(
                id: "amning-5",
                title: "Avsluta amningen",
                subtitle: "Avvänjning på ditt och bebisens villkor",
                icon: "arrow.forward.circle.fill",
                introduction: """
                Att avsluta amningen är ett beslut som hör till dig, din bebis och er familj — inte till andra. WHO rekommenderar amning upp till 2 år, men svenska rekommendationer är att amma minst 6 månader med fast föda som komplement. Det finns inget rätt svar på när avvänjning ska ske.

                Avvänjning kan initieras av mamman, av bebisen, eller av omständigheter. Den kan vara gradvis (att minska ett amningstillfälle i taget) eller snabb (om medicinskt nödvändigt). Gradvis avvänjning är gentlast för kroppen och bebisens trygghet.
                """,
                keyPoints: [
                    "Det finns inget rätt eller fel datum för avvänjning",
                    "Gradvis avvänjning (ersätt ett amningstillfälle i taget) är skonsamst",
                    "Engorgement vid snabb avvänjning behandlas med kylning, inte med pumpning",
                    "Bebisens näring tas over av välling, fast föda och bröstmjölksersättning",
                    "Amningsstoppet kan utlösa hormonell dipp — var beredd på humörsvängningar"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vill sluta amma vid 6 månader men bebisen vägrar flaska",
                        wrongApproach: "Slutar abrupt och låter bebisen svälta tills hon accepterar flaskan.",
                        rightApproach: "Introducera flaska tidigt (helst vid 4-6 veckors ålder för den som ska amma och ändå introducera flaska), låt någon annan än mamman ge flaskan initialt, och ha tålamod.",
                        explanation: "Bebisen associerar mamman med amning. En annan person kan lättare introducera flaska."
                    )
                ],
                exercise: CourseExercise(
                    title: "Avvänjningsplan",
                    description: "Planera avvänjningen om det är relevant för dig nu.",
                    steps: [
                        "Bestäm vilket amningstillfälle du vill ersätta först (vanligtvis mitt på dagen)",
                        "Ersätt det tillfället med flaska/sippy cup i en vecka",
                        "Nästa vecka: ersätt ytterligare ett tillfälle",
                        "Fortsätt gradvis — bevarar alltid morgon- och kvällsamnning sist",
                        "Ge extra kramar och kroppsnärhet under processen"
                    ],
                    duration: "Gradvis process över 4-8 veckor"
                ),
                reflectionQuestions: [
                    "Är du redo att sluta amma? Är det ett fritt val eller driven av omständigheter?",
                    "Hur tror du bebisen kommer reagera på avvänjning?",
                    "Vet du att det är normalt att känna sorg när amningen avslutas — oavsett dina känslor inför det?"
                ],
                forumSection: CourseForumSection(
                    intro: "Mammor delar om avvänjning:",
                    consensus: "Att avsluta amningen på egna villkor och utan skuld lyfts som centralt. Sorgen är verklig, oavsett om man ammat länge eller kort.",
                    quotes: [
                        "\"Slutade vid 3 månader av medicinska skäl. Grät i en vecka. Sen lättade det. Bebisen mår bra.\"",
                        "\"Ammade i 18 månader tills dottern avvände sig själv. Saknar det fortfarande men det var hennes tid.\""
                    ],
                    source: "WHO, 1177.se, Amningshjälpen.se"
                ),
                readingTimeMinutes: 7
            )
        ],
        targetAudience: "Gravida och nyblivna mammor",
        estimatedWeeks: 3
    )
}

// MARK: - Course 7: Förlossningsförberedelse

extension Course {
    static let forlossningsForberedelse = Course(
        id: "forlossnings-forberedelse",
        title: "Förlossningsförberedelse",
        subtitle: "Bli redo för förlossningens alla faser",
        description: "Lär dig allt om förlossningens faser, smärtlindring, andningstekniker och vad som händer på BB. Kunskap minskar rädsla och ökar din känsla av kontroll — oavsett hur förlossningen utvecklar sig.",
        icon: "heart.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "EC4899"), Color(hex: "F472B6")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "forl-1",
                title: "Förlossningens faser",
                subtitle: "Vad som händer i kroppen",
                icon: "waveform.path.ecg",
                introduction: """
                Förlossningen delas in i tre faser: öppningsskedet, utdrivningsskedet och efterbördsskedet. Att förstå dessa faser hjälper dig att veta var du är i processen och vad du kan förvänta dig härnäst.

                Förlossningens varaktighet varierar enormt. Förstagångsmammors förlossningar tar i genomsnitt 12-18 timmar från aktiv förlossning. Flergångsmammors förlossningar är ofta kortare, 6-8 timmar. Variation är dock stor — förlossningar kan ta allt från 2 timmar till mer än 24 timmar, vilket är normalt.
                """,
                keyPoints: [
                    "Öppningsskedet: livmoderhalsen utplånas och öppnar sig 0-10 cm",
                    "Latent fas (0-6 cm) kan vara lång och ska hanteras hemma om möjligt",
                    "Aktiv fas (6-10 cm) börjar vanligtvis när du ringer förlossningen",
                    "Utdrivningsskedet: kryststadiet — bebisen föds",
                    "Efterbördsskedet: moderkakan föds, brukar ta 5-30 minuter"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du har värkar var 10:e minut sedan 5 timmar — ska du åka in?",
                        wrongApproach: "Åka in direkt eftersom det pågått länge.",
                        rightApproach: "Ringa förlossningen och beskriva värkarna. Aktiv fas börjar vanligtvis vid värkar var 3-5:e minut, i 1 minut, under 1 timme (3-1-1-regeln).",
                        explanation: "Att åka in för tidigt i latent fas kan leda till onödig oro och medicinsk intervention. De flesta förlossningsavdelningar rekommenderar att du ringer och får råd."
                    )
                ],
                exercise: CourseExercise(
                    title: "Förlossningsplan",
                    description: "Skriv en kortfattad förlossningsplan.",
                    steps: [
                        "Vilka smärtlindringsmetoder vill du prova? (ordning: TENS, bad, lustgas, epidural)",
                        "Vem ska vara med på förlossningen?",
                        "Finns det något du är extra rädd för?",
                        "Vad är dina önskemål om hud-mot-hud och navelsträng?",
                        "Kom ihåg: förlossningsplanen är önskemål, inte ett kontrakt"
                    ],
                    duration: "30 minuter att skriva"
                ),
                reflectionQuestions: [
                    "Vad är du mest rädd för inför förlossningen?",
                    "Har du och din partner pratat om era roller under förlossningen?",
                    "Vet du när du ska ringa förlossningen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Gravida och nyförlösta delar om förlossning:",
                    consensus: "Att ha ett öppet sinne och acceptera att planen kan ändras är det vanligaste rådet. Kunskap minskar rädsla.",
                    quotes: [
                        "\"Min förlossningsplan kastades ut direkt. Lärde mig att hålla planen löst och förlita mig på barnmorskan.\" – Anna",
                        "\"Hade inte förstått att latent fas kunde vara SÅ lång. Satt hemma i 14 timmar. Bra förberedelse hade hjälpt.\" – Maria"
                    ],
                    source: "1177.se, Barnmorskeförbundet, WHO"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "forl-2",
                title: "Smärtlindring",
                subtitle: "Alternativ och vad som passar dig",
                icon: "cross.case.fill",
                introduction: """
                Det finns ett brett spektrum av smärtlindringsalternativ, från naturliga metoder till medicinsk analgesi. Alla är giltiga val — det finns ingen medalj för att föda utan smärtlindring. Välj det som hjälper dig att hantera förlossningsarbetet.

                Smärtan vid förlossning är annorlunda från annan smärta: den är intermittent, ändamålsenlig och ledsagad av hormonet oxytocin som skapar välmående mellan värkarna. Det är ett filosofiskt perspektiv, men många kvinnor finner det hjälpsamt att se smärtan som arbete snarare än skada.
                """,
                keyPoints: [
                    "TENS: elektrisk stimulering som motverkar smärtsignaler — börja tidigt",
                    "Varmt bad: kraftigt smärtlindrande, tillgängligt tidigt i förlossningen",
                    "Lustgas: snabbverkande, tar inte bort smärtan men tar bort kanten",
                    "Epidural: den mest effektiva smärtlindringen men påverkar rörelseförmåga",
                    "Sterila vatteninjektioner: effektivt mot värk i korsryggen"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du vill ha epidural men är rädd att den ska bromsa förlossningen",
                        wrongApproach: "Vänta tills du inte klarar smärtan längre för att inte 'riskera' förlossningen.",
                        rightApproach: "Fråga barnmorskan när det är lämpligaste tillfälle. Moderna studier visar inte att epidural i aktiv fas förlänger förlossningen.",
                        explanation: "Rädslan för att epidural bromsar förlossningen är en seglivad myt. Det är OK att begära epidural."
                    )
                ],
                exercise: CourseExercise(
                    title: "Smärtlindrings-ranking",
                    description: "Rangordna smärtlindringsalternativen i din preferensordning.",
                    steps: [
                        "Läs om varje alternativ (TENS, bad, lustgas, epidural, opioider)",
                        "Diskutera med din partner vad ni vill prova",
                        "Skriv ner en önskad ordning — utan att låsa dig",
                        "Lägg in önskemålen i din förlossningsplan",
                        "Acceptera att du kan ändra dig under förlossningen"
                    ],
                    duration: "En timme att diskutera"
                ),
                reflectionQuestions: [
                    "Är du orolig för smärtan? Vad skrämmer dig mest?",
                    "Har du fördomar mot epidural eller naturlig förlossning?",
                    "Vet du att du kan ändra dig om smärtlindringen under förlossningen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Förlossningserfarenheter och smärtlindring:",
                    consensus: "Att ta den smärtlindring man behöver utan att döma sig själv är det viktigaste budskapet.",
                    quotes: [
                        "\"Ville föda naturligt. Tog epidural vid 7 cm. Den bästa beslut jag fattade.\" – Petra",
                        "\"Badet var fantastiskt. Klarade hela förlossningen i vattnet. Men det är inte för alla.\" – Sofie"
                    ],
                    source: "1177.se, SBU-rapport om smärtlindring under förlossning"
                ),
                readingTimeMinutes: 8
            ),
            CourseModule(
                id: "forl-3",
                title: "Andningstekniker",
                subtitle: "Andningen som ditt viktigaste verktyg",
                icon: "wind",
                introduction: """
                Andningen är det enda du alltid kan kontrollera under förlossningen. Medveten andning aktiverar det parasympatiska nervsystemet, motverkar stressrespons, minskar smärtupplevelsen och hjälper dig att bevara fokus under värkarna.

                Det behövs ingen komplicerad teknik. Grundprincipen är: andas ut längre än du andas in. Det aktiverar vagusnerven och sänker kortisol. Du kan öva på det nu — det kommer naturligt vid förlossningen om du praktiserat.
                """,
                keyPoints: [
                    "Andas IN 4 sekunder, UT 6-8 sekunder — aktiverar parasympatiska nervsystemet",
                    "Under värken: fokusera på en lång, lugn utandning",
                    "Undvik att hålla andan — det spänner muskler",
                    "Hypnobirthing-andning: mjuk abdominal andning med öppen mun",
                    "Öva dagligen under graviditeten — kroppen lär sig andningsmönstret"
                ],
                examples: [
                    CourseExample(
                        scenario: "En stark väck gör att du spänner dig och håller andan",
                        wrongApproach: "Bita ihop och vänta på att värken ska gå över.",
                        rightApproach: "Så fort värken börjar: en lång inandning, sedan en lång kontrollerad utandning. Slappna av axlar, händer och käke medvetet.",
                        explanation: "Spänning förstärker smärtupplevelsen. Att andas ut aktivt ger kroppen signalen att det är säkert att slappna av."
                    )
                ],
                exercise: CourseExercise(
                    title: "5-minuters daglig andningsövning",
                    description: "Öva förlossningsandning varje dag fram till förlossningen.",
                    steps: [
                        "Sätt dig bekvämt eller ligg på sidan",
                        "Andas in genom näsan, 4 sekunder, känn magen expandera",
                        "Andas ut mjukt genom munnen, 6-8 sekunder",
                        "Upprepa 10 gånger, 2 gånger om dagen",
                        "Under den simulerade 'värken' (30 sek): fokusera enbart på utandningen"
                    ],
                    duration: "5 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Har du praktiserat andningstekniken? Känns det naturligt?",
                    "Vet din partner din andningsteknik och kan de påminna dig under förlossningen?",
                    "Vad hjälper dig att fokusera under intensiv smärta?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om andningstekniker under förlossning:",
                    consensus: "De flesta som övat beskriver andningen som avgörande. Det svåra är att komma ihåg den mitt i en intensiv väck.",
                    quotes: [
                        "\"Min man påminde mig om andningen vid varje väck. Utan hans röst hade jag glömt allt.\" – Karin",
                        "\"Hade övat hypnobirthingandning varje dag. Den enda sak som verkligen hjälpte mig.\" – Emma"
                    ],
                    source: "Hypnobirthing Institute, 1177.se Förlossning"
                ),
                readingTimeMinutes: 6
            ),
            CourseModule(
                id: "forl-4",
                title: "På BB och förlossningsavdelningen",
                subtitle: "Vad du kan förvänta dig",
                icon: "building.2.fill",
                introduction: """
                Att veta vad som händer på förlossningsavdelningen och BB minskar ångesten. De flesta förlossningsavdelningar i Sverige har privata rum, och BB-vistelsen är vanligtvis 1-2 dagar för okomplicerad vaginal förlossning och 2-3 dagar efter kejsarsnitt.

                Under BB-vistelsen får du och din bebis stöd av barnmorskor och BH-sjuksköterskor i etablering av amning, observationer av bebisens tillstånd, och din återhämtning.
                """,
                keyPoints: [
                    "Ta med bebisens hemfärdskläder och bilbarnstol",
                    "BB-vistelse: 1-2 dagar vaginal, 2-3 dagar kejsarsnitt",
                    "Bebisen kontrolleras: viktsförlust, gulsot, hörsel, hjärta, reflexer",
                    "PKU-provet (blodprov) tas 48-72 timmar efter förlossning",
                    "Hembesök av barnmorska erbjuds vanligtvis 1-2 dagar efter hemgång"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din bebis har tappat 8% av födslovikten vid 3 dagars ålder",
                        wrongApproach: "Panikera och ge genast bröstmjölksersättning.",
                        rightApproach: "Förstå att viktnedgång upp till 7-10% är normalt de första dagarna. Diskutera med barnmorskan om ämning och eventuell komplettering.",
                        explanation: "Bebisen minskar i vikt de första dagarna tills mjölken kommit in. Det är normalt och förväntat."
                    )
                ],
                exercise: CourseExercise(
                    title: "BB-packlista",
                    description: "Packa BB-väskan i god tid — från graviditetsvecka 36.",
                    steps: [
                        "Till dig: komfortabla kläder, toalettsaker, amningsinlägg, smärtstillande",
                        "Till bebisen: bodys (3 st), sparkdräkt, mössa, sockar, hemfärdskläder, filtar",
                        "Administrativt: legitimation, vårdkort, eventuell förlossningsplan",
                        "Komfort: hörlurar, laddare, snacks, kudde hemifrån",
                        "Till partner: ombyte, toalettsaker, pengar/kort till automater"
                    ],
                    duration: "En timme att packa"
                ),
                reflectionQuestions: [
                    "Har du packat BB-väskan?",
                    "Vet du hur ni tar er till förlossningsavdelningen?",
                    "Har ni planerat vem som tar hand om eventuella äldre barn?"
                ],
                forumSection: CourseForumSection(
                    intro: "Erfarenheter från BB:",
                    consensus: "Att be om hjälp på BB och ta vara på barnmorskornas stöd nämns som viktigt. Vistelsen kan kännas kort — fråga allt du undrar.",
                    quotes: [
                        "\"Frågade barnmorskan om allt varje gång de kom in. Det är deras jobb och de ville hjälpa.\" – Lena",
                        "\"BB gick för fort. Hade velat ha mer stöd med amningen. Lär dig ställa krav på vård.\" – Hanna"
                    ],
                    source: "1177.se BB-vistelsen, Socialstyrelsen"
                ),
                readingTimeMinutes: 7
            ),
            CourseModule(
                id: "forl-5",
                title: "Hemgång och de första dagarna",
                subtitle: "Vad händer när ni är hemma?",
                icon: "house.fill",
                introduction: """
                Hemgången kan kännas överväldigande — du lämnar den trygga miljön med professionellt stöd och är plötsligt ensam ansvarig för ett litet liv. Det är normalt att känna sig osäker, rädd och overwhelmed. Det är också normalt att känna enormt lycka och kärlek.

                De första veckorna hemma handlar om återhämtning, etablering av matning och att lära känna sin bebis. Acceptera hjälp. Sänk förväntningarna på dig själv. Huset behöver inte vara städat. Mat behöver inte lagas från grunden. Din uppgift är att läka och ta hand om bebisen.
                """,
                keyPoints: [
                    "Barnmorska hembesöker vanligtvis 1-2 dagar efter hemgång",
                    "BVC-besök bokas via 1177 och sker vanligtvis vecka 1-2",
                    "Eftervärkar (normal sammandragning av livmodern) är normala och kan göra ont",
                    "Baby blues (dag 3-5): hormonell dipp med tårar och svängningar — normalt",
                    "Ring 1177 eller gå till akuten vid: hög feber, starkt blödning, andningsproblem hos bebisen"
                ],
                examples: [
                    CourseExample(
                        scenario: "Dag 3 hemma: du gråter oavbrutet utan anledning och känner dig hopplös",
                        wrongApproach: "Tänka att du är en dålig mamma eller att något är fel med dig.",
                        rightApproach: "Förstå att du sannolikt upplever baby blues — en hormonell reaktion som kulminerar dag 3-4. Prata med din partner. Det går över inom en vecka. Om det inte gör det — kontakta barnmorskan.",
                        explanation: "Baby blues drabbar upp till 80% av mammor och är orsakad av den kraftigaste hormonella förändringen i livet. Det är biologiskt, inte psykologiskt."
                    )
                ],
                exercise: CourseExercise(
                    title: "Hjälpplan",
                    description: "Planera konkret hjälp för de första två veckorna.",
                    steps: [
                        "Lista tre personer som kan komma och hjälpa till praktiskt",
                        "Boka dem specifikt: 'Kan du komma tisdag och laga mat?'",
                        "Planera enkla maträtter — acceptera leverans och halvfabrikat",
                        "Bestäm med partner hur ni delar på natten de första veckorna",
                        "Ta bort alla icke-nödvändiga åtaganden de första 2 veckorna"
                    ],
                    duration: "30 minuter att planera"
                ),
                reflectionQuestions: [
                    "Har du ett stödsystem planerat för de första veckorna?",
                    "Vet du att baby blues skiljer sig från förlossningsdepression?",
                    "Vad behöver du för att känna dig trygg hemma med bebisen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om hemgången och de första dagarna:",
                    consensus: "Att acceptera hjälp och sänka förväntningarna på sig själv lyfts som det viktigaste rådet.",
                    quotes: [
                        "\"Hade storhandlat och fryst mat inför hemgången. Det räddade oss. Gör det.\" – Filip, pappa till Max",
                        "\"Dag 3 var det mörkaste jag upplevt. Dag 7 var det ljusaste. Baby blues är verkligt.\" – Sara"
                    ],
                    source: "Rikshandboken Barnhälsovård, 1177.se"
                ),
                readingTimeMinutes: 8
            )
        ],
        targetAudience: "Gravida i andra och tredje trimestern",
        estimatedWeeks: 3
    )
}

// MARK: - Course 8: Bebisens första år — milstolpar och utveckling

extension Course {
    static let bebisenForstaAret = Course(
        id: "bebisenforsta-aret",
        title: "Bebisens första år",
        subtitle: "Milstolpar och utveckling månad för månad",
        description: "Följ din bebis resa från nyfödd till ett-åring. Lär dig om motorisk, kognitiv, social och språklig utveckling — och hur du som förälder kan stötta varje fas på bästa sätt.",
        icon: "star.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "8B5CF6"), Color(hex: "C4B5FD")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "bfa-1",
                title: "0–3 månader",
                subtitle: "Den nyföddes fantastiska kapacitet",
                icon: "moon.stars.fill",
                introduction: """
                En nyfödd är inte ett "tomt blad". Bebisen föds med en fullt fungerande uppsättning reflexer, förmåga att känna igen mammans röst (inlärd under graviditeten), preferens för ansikten, och känslighet för beröring, smak och doft.

                De första tre månaderna handlar om att anpassa sig till världen utanför livmodern, etablera grundläggande sömnmönster, och bygga den grundläggande tillitsrelationen till föräldrarna. Ditt responsiva föräldraskap dessa veckor lägger grunden för ett tryggt anknytningsmönster.
                """,
                keyPoints: [
                    "Nyfödda kan fokusera 20-30 cm — precis din ansiktsdistans vid amning",
                    "Socialt leende uppstår vid 4-8 veckor — ett av föräldraskapets stora ögonblick",
                    "Kolik kulminerar runt 6 veckor och avtar nästan alltid vid 3 månader",
                    "Sömncykler är 40-50 minuter — nattliga uppvaknanden är normala och biologiska",
                    "Tummy time från dag ett (när bebisen är vaken) bygger motorisk grund"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din 6 veckor gamla bebis skriker i timmar utan uppenbar orsak på kvällen",
                        wrongApproach: "Tro att det är något allvarligt fel eller att du gör något fel.",
                        rightApproach: "Kolik är normalt, drabbar ca 20% av bebisars, kulminerar vid 6 veckor och går över vid 3 månader. Prova: rörelse, hud-mot-hud, vagnsåkning, vit brus.",
                        explanation: "Kolik är inte smärtsamt för bebisen (trots utseendet) och kan inte 'bort-uppfostras'. Det är en övergående fas."
                    )
                ],
                exercise: CourseExercise(
                    title: "Tummy time-rutin",
                    description: "Etablera daglig tummy time de tre första månaderna.",
                    steps: [
                        "Börja med 1-2 minuters tummy time direkt efter varje byt (inte efter mat)",
                        "Bygg upp till 20-30 minuter totalt per dag vid 3 månader",
                        "Gör det roligt: lägg dig bredvid på golvet, prata och sjung",
                        "Pröva tummy time på ditt bröst/mage — bebisen kan lättare lyfta huvudet",
                        "Om bebisen hatar det: börja med kortare stunder och avsluta INNAN gråten"
                    ],
                    duration: "2-5 min per session"
                ),
                reflectionQuestions: [
                    "Känner du igen bebisens olika skrik? Hunger, trötthet, stimulering?",
                    "Hur hanterar du de svåra stunderna — kolik, sömnbrist, osäkerhet?",
                    "Vad är det mest fantastiska du sett bebisen göra den här månaden?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar om de tre första månaderna:",
                    consensus: "Att överleva snarare än att prestera är mantrat. De flesta beskriver perioden som svårare och underbarare än de förväntat sig.",
                    quotes: [
                        "\"Ingen berättade för mig hur hårt det skulle vara. Och ingen berättade hur fantastiskt. Bådadera är sanna.\" – Maja",
                        "\"Sociala leendet vid 6 veckor. Inget hade förberett mig för hur det skulle kännas.\" – Anders"
                    ],
                    source: "Rikshandboken Barnhälsovård, WHO, American Academy of Pediatrics"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bfa-2",
                title: "3–6 månader",
                subtitle: "Bebisens personlighet träder fram",
                icon: "sun.max.fill",
                introduction: """
                Månaderna 3-6 är för många föräldrar en ynnestperiod: kolik brukar ha försvunnit, bebisen ler och skrattar, kommunicerar med joller, och interaktionen börjar kännas mer meningsfull. Du börjar lära känna ditt barns unika personlighet.

                Motoriken tar stora kliv: bebisen lyfter huvud och bröst vid tummy time, börjar rulla (vanligtvis rygg till mage), börjar nå efter föremål och föra dem till munnen. Handkoordination och munaktivitet är central — allt går i munnen, och det är normalt och bra för sensorisk inlärning.
                """,
                keyPoints: [
                    "Joller börjar vid 3-4 månader — svarar på dig, turtagning i proto-konversation",
                    "Handfunktion: grepp börjar medvetet vid 3-4 månader, palmer till pincett vid 9-12 mån",
                    "Rullning: rygg till mage vanligtvis vid 4-5 månader",
                    "Smakintroduktion kan börja vid 6 månader — Livsmedelsverket rekommenderar ej tidigare",
                    "Separationsångest börjar byggas upp i slutet av perioden — normalt och sunt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Bebisen (5 månader) verkar tråkad och gnällig hela dagen",
                        wrongApproach: "Skärmdump eller sätta på TV för att underhålla.",
                        rightApproach: "Babyn behöver variation och stimulering: spegel-aktivitet, bollövningar, sjunga, läsa, tummy time, utevistelse. Variera miljö.",
                        explanation: "5-månadersbebisen behöver aktivt samspel och sensorisk variation — inte passiv underhållning."
                    )
                ],
                exercise: CourseExercise(
                    title: "Aktivitetsmeny",
                    description: "Skapa en meny med aktiviteter för 3-6 månader.",
                    steps: [
                        "Spegel-stund: håll bebisen framför spegel, prata om vad ni ser",
                        "Sångstund: sjung 3 valfria sånger med ögonkontakt",
                        "Sensorisk låda: olika texturer att känna på (silke, bubbelplast, korrugerat papper)",
                        "Utevistelse: 30 minuter dagligen — natur är sensorisk stimulering",
                        "Bokläsning: enkla pekböcker med kontrasterande färger"
                    ],
                    duration: "10-15 minuter per aktivitet"
                ),
                reflectionQuestions: [
                    "Har du märkt bebisens personlighet börja träda fram? Vad är karaktäristiskt för just ditt barn?",
                    "Svarar bebisen på ditt joller med eget joller?",
                    "Hur förbereder du er för introduktionen av fast föda vid 6 månader?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar om 3-6 månader:",
                    consensus: "Perioden beskrivs som 'belöningen' efter de tunga nyfödddsveckorna. Det sociala samspelet är en vändpunkt.",
                    quotes: [
                        "\"Skrattet vid 4 månader. Det första riktiga skrattet. Allt förändrades.\" – Eva",
                        "\"Han börjar bli EN PERSON. Med åsikter. Det är häpnadsväckande och roligt.\" – Jonas"
                    ],
                    source: "Rikshandboken Barnhälsovård, Socialstyrelsen"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "bfa-3",
                title: "6–9 månader",
                subtitle: "Fast föda och stor rörlighet",
                icon: "fork.knife",
                introduction: """
                Vid 6 månader rekommenderar Livsmedelsverket att fast föda introduceras. Det är inte för att ersätta mjölkmat (bröstmjölk eller bröstmjölksersättning är fortfarande primär näringskälla), utan för att introducera smaker, texturer och ätkunskaper.

                Motoriken exploderar: sittande utan stöd, krypning i alla varianter, dra sig upp mot möbler. Bebisen börjar utforska rummet aktivt — nu är det tid för babyproofing.
                """,
                keyPoints: [
                    "Smakintroduktion: börja med enstaka smaker, ett i taget, vänta 3 dagar för allergikoll",
                    "BLW (Baby Led Weaning) och purée är båda giltiga — välj det som passar er",
                    "Pincettgrepp (tumme + pekfinger) börjar runt 7-9 månader",
                    "Separation/främlingsångest kulminerar vid 6-9 månader — normalt och sunt",
                    "Krypning: normalt att börja 6-9 månader, men inte obligatoriskt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Bebisen (7 månader) börjar gråta hysteriskt när du lämnar rummet",
                        wrongApproach: "Aldrig lämna bebisen ensam — alltid vara i närheten.",
                        rightApproach: "Normalisera kort frånvaro: berätta att du går, kom tillbaka och bekräfta. Gradvis öka distansen. Separationsångest är ett tecken på trygg anknytning.",
                        explanation: "Separationsångest visar att bebisen har bildat en trygg anknytning — det är ett positivt tecken, inte ett problem."
                    )
                ],
                exercise: CourseExercise(
                    title: "Smakintroduktionsplan",
                    description: "Planera de första smakerna.",
                    steps: [
                        "Börja med mild, enkelt smaker: rotfrukter (sötpotatis, morot), frukt (banan, päron)",
                        "En ny smak varannan dag — observera reaktioner",
                        "Introducera potentiella allergener (ägg, fisk, nötter) tidigt — de reducerar allergirisken",
                        "Välj en struktur: purée, finger food, eller mix",
                        "Förvänta dig stök — skydda golvet och klä bebisen enkelt"
                    ],
                    duration: "10 minuter per måltid"
                ),
                reflectionQuestions: [
                    "Hur planerar du smakintroduktionen?",
                    "Har du babyproofat hemmet inför den ökade rörligheten?",
                    "Hur reagerar bebisen på separation från dig?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om 6-9 månader:",
                    consensus: "Matintroduktionen beskrivs som rolig och stressig. Att inte ta det för allvarligt och ha kul med maten lyfts.",
                    quotes: [
                        "\"BLW var kaotisk men dottern älskade kontrollen. Ät vad familjen äter (mjukt).\" – Carina",
                        "\"Separationsångesten kom som ett blixtslag. Förstod äntligen vad anknytning innebär i praktiken.\" – Robert"
                    ],
                    source: "Livsmedelsverket: Bra mat 0-5 år, Rikshandboken BHV"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "bfa-4",
                title: "9–12 månader",
                subtitle: "Mot upprätt gång och första ord",
                icon: "figure.walk",
                introduction: """
                Det sista kvartalet av det första levnadsåret är en explosion av nya färdigheter. De flesta barn börjar gå (eller är nära att börja) och säger de första meningsfulla orden. Leken utvecklas från att bara undersöka föremål till att använda dem meningsfullt.

                Kommunikationen är rikare: pekande, vinkning, imitation av ljud och rörelser. Allt detta är förstadier till språk och socialt samspel.
                """,
                keyPoints: [
                    "Pekande (deictic gesture) vid 9-12 mån är ett starkt tecken på kommunikationsutveckling",
                    "Första ord: vanligtvis 'mamma', 'pappa', eller ett enkelt substantiv",
                    "Fritt gående: genomsnitt 12 månader, normalt 9-15 månader",
                    "Imitation ökar kraftigt — de observerar allt du gör",
                    "Läsning högt varje dag är den bästa investeringen för språkutveckling"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn (11 månader) säger fortfarande inga tydliga ord",
                        wrongApproach: "Jämföra med andra barn och oroa dig för sen språkutveckling.",
                        rightApproach: "Kolla kommunikationsmarkörerna: pekar barnet? Vinkar? Imiterar ljud och rörelser? Dessa är viktigare indikationer än ord. Prata med BVC om du är orolig.",
                        explanation: "Ord vid 12 månader är ett genomsnitt — stor variation är normal. Kommunikationsmarkörer är bättre indikatorer på utveckling."
                    )
                ],
                exercise: CourseExercise(
                    title: "Språkstimulering dagligen",
                    description: "Fem enkla sätt att stimulera språkutvecklingen varje dag.",
                    steps: [
                        "Kommentera vad du gör: 'Nu sätter pappa på bebisens jacka. Den är röd.'",
                        "Läs högt minst 10 minuter per dag — välj böcker med tydliga bilder",
                        "Sjung sånger med rörelser (Byssan Lull, Fem fina fingrar)",
                        "Svara på pekanden: 'Ja! Det är en bil! Brum-brum!'",
                        "Prata till bebisen hela dagen — löpande kommentar på livet"
                    ],
                    duration: "Integrerat i vardagen"
                ),
                reflectionQuestions: [
                    "Hur kommunicerar bebisen med dig? Utöver gråt?",
                    "Peker bebisen på saker de vill visa dig?",
                    "Hur förbereder ni er för ettårsdagen och reflektionen över ett fantastiskt första år?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar om 9-12 månader:",
                    consensus: "Det första riktiga ordet och de första stegen beskrivs som livsavgörande ögonblick. Årets snabbhet upplevs av alla.",
                    quotes: [
                        "\"Första gången hon sa 'mamma' och menade det. Jag grät i 20 minuter.\" – Ingrid",
                        "\"Årets gick SÅ fort. Nu förstår jag varför alla säger det. Ångrar att jag inte tog fler bilder på det enkla vardagslivet.\" – Marcus"
                    ],
                    source: "Rikshandboken BHV, Language Development in the First Year of Life"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bfa-5",
                title: "Lekstimulering",
                subtitle: "Lek som lärande — hela första året",
                icon: "sparkles",
                introduction: """
                Lek är barnets arbete. Det är genom lek som bebisen utforskar världen, bygger hjärnförbindelser, och lär sig allt från motorik till sociala regler. Du behöver inte köpa dyra leksaker — de bästa leksaker för bebisar är enkla, sensoriska och involverar dig.

                Lekens karaktär förändras under det första året: från refleksstyrd till intentionell, från solitär till social, från enkel utforskning till symbolisk lek (låtsaslek). Varje fas har sin logik och sina behov.
                """,
                keyPoints: [
                    "0-3 mån: sensorisk stimulering — kontraster, ljud, beröring",
                    "3-6 mån: kaus-effekt lek — 'om jag gör X händer Y'",
                    "6-9 mån: objektpermanens — saker finns kvar när de göms",
                    "9-12 mån: funktionell lek — använda föremål rätt (kopp, sked, telefon)",
                    "De bästa 'leksakerna': vardagsföremål, ditt ansikte, din röst"
                ],
                examples: [
                    CourseExample(
                        scenario: "Din bebis (8 månader) är mer intresserad av kartonger och köksredskap än sina leksaker",
                        wrongApproach: "Köpa fler och dyrare leksaker.",
                        rightApproach: "Förstå att nyfikenhet på vardagsföremål är normalt och bra. Säkra föremål från köket, kartonger, kasserade behållare — ge fri tillgång.",
                        explanation: "Bebisar är mer intresserade av 'riktiga' saker än designade leksaker. Vardagsföremål erbjuder rikare sensorisk upplevelse."
                    )
                ],
                exercise: CourseExercise(
                    title: "Åldersanpassade lekidéer",
                    description: "En veckas lekaktiviteter anpassade till din bebis ålder.",
                    steps: [
                        "Måndag: Sensorlåda — fyll en låda med material av olika texturer",
                        "Tisdag: Musik — slå på kärl med sked, skaka flaska fylld med ris",
                        "Onsdag: Utomhusexploration — gräs, löv, sand (under uppsikt)",
                        "Torsdag: Pekbok-session — 20 minuter med en bok",
                        "Fredag: Spegellek — titta i spegel och imitera ansiktsuttryck",
                        "Lördag: Vattensäck — lägg bebisen på en vattenmadrass med vatten inuti",
                        "Söndag: Familjens bästa aktivitet — vad gillar just er bebis?"
                    ],
                    duration: "15-30 minuter per aktivitet"
                ),
                reflectionQuestions: [
                    "Vad verkar din bebis tycka är roligast? Vad ger du mer av det?",
                    "Är du bra på att följa bebisens ledning i leken — låta henne bestämma riktningen?",
                    "Hur balanserar du strukturerade aktiviteter med fri utforskning?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar om lek och stimulering:",
                    consensus: "Att följa bebisens intresse och inte pressa fram aktiviteter lyfts. De enklaste aktiviteterna är ofta de bästa.",
                    quotes: [
                        "\"Köpte allt dyrt leksaker. Han föredrog den tomma yoghurtbehållaren. Spenderade för mycket pengar.\" – Peter",
                        "\"Att vara fullt närvarande under 15 minuter är mer värt än passiv närvaro under en timme.\" – Sofie"
                    ],
                    source: "Socialstyrelsen, WHO Early Childhood Development guidelines"
                ),
                readingTimeMinutes: 8
            )
        ],
        targetAudience: "Föräldrar med barn 0-12 månader",
        estimatedWeeks: 5
    )
}

// MARK: - Course 9: Fertilitet & Kropp

extension Course {
    static let fertilitetKropp = Course(
        id: "fertility_body",
        title: "Fertilitet & Kropp",
        subtitle: "Förstå din fertilitet",
        description: "En grundlig kurs om hur kroppen fungerar under försök att bli gravid. Lär dig om menscykeln, det fertila fönstret, mätmetoder och hur livsstil påverkar fertiliteten — med stöd för hela resan.",
        icon: "heart.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "F43F5E"), Color(hex: "FB7185")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "fb-1",
                title: "Menscykeln och hormoner",
                subtitle: "Din cykels fyra faser",
                icon: "waveform.path",
                introduction: """
                Menscykeln är långt mer än bara mensen — det är ett komplext hormonellt orkesterverk i fyra distinkta faser. Varje fas påverkar din energi, humör, libido och kroppens beredskap för befruktning. Att förstå dessa faser är grunden för all fertilitetskunskap.

                Östrogen, progesteron, LH och FSH samarbetar i ett precist mönster. När du lär dig känna igen kroppens signaler i varje fas kan du arbeta med din cykel snarare än mot den — och få en mycket tydligare bild av vad som händer varje månad.

                I den här modulen går vi igenom alla fyra faser, de viktigaste hormonerna och vad du kan förvänta dig av din kropp under cykeln.
                """,
                keyPoints: [
                    "Cykelns fyra faser: menstruation, follikulär, ovulation och lutealfas",
                    "FSH stimulerar äggmognaden i follikulärfasen",
                    "LH-toppen triggar ovulationen — vanligtvis mitt i cykeln",
                    "Progesteron dominerar lutealfasen och förbereder livmodern",
                    "En 'normal' cykel är 21–35 dagar — stor variation är vanlig"
                ],
                examples: [
                    CourseExample(
                        scenario: "Emma har alltid haft oregelbundna cykler på 26–33 dagar och undrar om det är ett problem.",
                        wrongApproach: "Anta att oregelbundenhet alltid betyder hormonella problem och bli orolig.",
                        rightApproach: "Förstå att variation på upp till 7–9 dagar fortfarande kan vara normal. Börja spåra cykeln i 3 månader för att se mönster och ta sedan upp det med en gynekolog om variationen fortsätter.",
                        explanation: "En enstaka oregelbunden cykel är sällan ett tecken på problem. Tre månaders spårning ger ett mycket mer informativt underlag för samtal med vården."
                    )
                ],
                exercise: CourseExercise(
                    title: "Starta din cykelkalender",
                    description: "Börja spåra din cykel och märk ut de fyra faserna varje dag under en hel cykel.",
                    steps: [
                        "Notera cykeldagens nummer varje morgon (dag 1 = mens börjar)",
                        "Markera: mensfas (dag 1–5), follikulärfas (dag 6–13), ovulation (dag 14±), lutealfas (dag 15–28)",
                        "Skriv kort om energi och humör varje dag (1–5 i skala)",
                        "Notera eventuella fysiska symtom: ömma bröst, midjeont, mellanblödning",
                        "Jämför tre cykler och se om du hittar dina egna mönster"
                    ],
                    duration: "2–3 minuter dagligen i en hel cykel"
                ),
                reflectionQuestions: [
                    "Vilken fas i cykeln känner du dig starkast och mest energifull?",
                    "Har du märkt av PMS-symtom i lutealfasen? Vad hjälper dig?",
                    "Hur länge har din cykel vanligtvis varit — är det konsekvent?"
                ],
                forumSection: CourseForumSection(
                    intro: "Många som börjar spåra sin cykel berättar om hur det förändrar deras självkännedom.",
                    consensus: "Att faktiskt förstå sin cykel — inte bara perioden — beskrivs som en ögonöppnare. Många önskar de fått lära sig detta tidigare.",
                    quotes: [
                        "\"Jag är 28 år och visste inte att ovulationen händer bara en dag. Trodde det pågick hela veckan.\" – Sofia",
                        "\"Sedan jag förstår cykeln har jag slutat kämpa mot mitt humör. Jag vet nu varför dag 24 alltid är svår.\" – Anna",
                        "\"Appen hjälpte mig se att min lutealfas bara är 9 dagar — det är för kort. Nu vet jag vad jag ska fråga läkaren om.\" – Karin"
                    ],
                    source: "Baserat på reproduktiv fysiologi och Taking Charge of Your Fertility (Weschler)"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "fb-2",
                title: "Det fertila fönstret",
                subtitle: "Sex dagar som förändrar allt",
                icon: "calendar.circle.fill",
                introduction: """
                Det fertila fönstret är de dagar i cykeln då graviditet är möjlig — och det är kortare än de flesta tror. Ett ägg lever bara 12–24 timmar efter ovulationen, men spermier kan överleva upp till fem dagar i livmoderhalsen. Det innebär ett möjligt fönster på upp till sex dagar per cykel.

                Att identifiera ditt fertila fönster handlar om att kombinera flera tecken: cervixsekret, basal kroppstemperatur och eventuell LH-mätning. Inget av dessa tecken är perfekt ensamt, men tillsammans ger de en stark signal.

                Många par försöker för sällan eller vid fel tidpunkt. Att förstå det fertila fönstret ökar chanserna markant utan att det behöver bli stressigt.
                """,
                keyPoints: [
                    "Det fertila fönstret är 5–6 dagar per cykel — upp till 5 dagar före ovulationen",
                    "Äggviteliknande cervixsekret signalerar att du snart är i ditt fönster",
                    "Spermier överlever 3–5 dagar i rätt miljö — börja försöka när sekretet förändras",
                    "Ovulationstest (LH-test) fångar LH-toppen 24–36 timmar före ägglossningen",
                    "Regelbundet sex var 2–3 dag under fönstret ger bäst chanser"
                ],
                examples: [
                    CourseExample(
                        scenario: "Mia och hennes partner försöker bara på dag 14 eftersom de hört att ovulation alltid sker då.",
                        wrongApproach: "Låsa sig vid dag 14 som universell ovulationsdag.",
                        rightApproach: "Förstå att dag 14 är ett genomsnitt för en 28-dagarscykel. Mia bör spåra sitt cervixsekret och använda LH-test för att hitta sin personliga ovulationstidpunkt.",
                        explanation: "Ovulation varierar enormt mellan individer och cykler. Att förlita sig på en fast dag minskar chanserna avsevärt om din cykel avviker från genomsnittet."
                    ),
                    CourseExample(
                        scenario: "Lisa sparar upp sig för att försöka exakt på ovulationsdagen, tänkande att det ger störst chans.",
                        wrongApproach: "Vänta med sex tills LH-toppen är bekräftad.",
                        rightApproach: "Börja ha sex när äggviteliknande cervixsekret uppträder — det kan vara 3–5 dagar före ovulationen. Fortsätt varannan dag tills basal temperaturen stiger.",
                        explanation: "Eftersom ägget lever kort tid och spermier lever längre, ger sex FÖRE ovulationen faktiskt bättre chanser än att vänta tills exakt på dagen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Cervixsekret-dagbok",
                    description: "Lär dig läsa ditt cervixsekret för att identifiera det fertila fönstret.",
                    steps: [
                        "Kontrollera sekretet varje morgon — torka med toalettpapper före toalettbesöket",
                        "Notera: torrt, kremigt/vitt, lottionsliknande, eller äggviteliknande (klar och elastisk)",
                        "Äggviteliknande sekret = du är i eller nära det fertila fönstret",
                        "Markera i din kalender och jämför med din cykeldag",
                        "Gör detta i 2 cykler för att se ditt personliga mönster"
                    ],
                    duration: "2 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Har du märkt förändringar i ditt sekret under cykeln tidigare — utan att veta varför?",
                    "Hur känns tanken på att aktivt spåra fertiliteten — befriande eller stressig?",
                    "Pratar du och din partner öppet om timing och försök?"
                ],
                forumSection: CourseForumSection(
                    intro: "Erfarenheter från par som lärt sig identifiera det fertila fönstret:",
                    consensus: "De flesta som börjar spåra aktivt berättar att de känt sig mer i kontroll. Många blev förvånade över hur tidigt i cykeln det fertila fönstret kom för dem.",
                    quotes: [
                        "\"Vi försökte i 8 månader på 'fel' dagar. En vecka efter att jag lärde mig om cervixsekret blev jag gravid.\" – Petra",
                        "\"LH-testerna tog bort en del av mysteriet och hjälpte oss ha sex vid rätt tidpunkt utan att känna press varje dag.\" – Marcus & Johanna",
                        "\"Jag är glad att jag lärde mig detta — men det är viktigt att inte bli besatt av det heller.\" – Elin"
                    ],
                    source: "Baserat på fertilitetsövervakning enligt Fertility Awareness Method"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "fb-3",
                title: "BBT och LH-mätning",
                subtitle: "Verktyg för exakt spårning",
                icon: "thermometer.medium",
                introduction: """
                Basal kroppstemperatur (BBT) och LH-mätning är två kraftfulla verktyg som kompletterar varandra. BBT-mätning bekräftar att ovulation har skett — temperaturen stiger 0,2–0,4°C efter ägglossningen och håller sig förhöjd under lutealfasen. LH-test förutsäger ovulation 24–36 timmar i förväg.

                Tillsammans med cervixsekret ger dessa tre tecken — ibland kallade "symptotermala metoden" — en heltäckande bild av cykeln. Det kräver lite rutin och disciplin, men belöningen är en djup förståelse för din unika fertilitetsprofil.

                Det är viktigt att förstå att BBT mäter i efterhand och LH-test mäter i förväg. De fyller alltså helt olika funktioner och är starkast när de används tillsammans.
                """,
                keyPoints: [
                    "BBT mäts direkt vid uppvaknade, innan du ens sätter dig upp",
                    "Temperaturen stiger 0,2–0,4°C dagen efter ovulation",
                    "BBT bekräftar att ovulation skett — den förutsäger inte",
                    "LH-test är positivt 24–36 timmar FÖRE ovulationen",
                    "Sjukdom, alkohol och sömnbrist påverkar BBT-resultaten"
                ],
                examples: [
                    CourseExample(
                        scenario: "Sara mäter sin temperatur men glömde ta den en dag och är förvirrad av grafen.",
                        wrongApproach: "Kasta hela cykeln och börja om.",
                        rightApproach: "Markera det saknade värdet och tolka grafen med det i åtanke. En mätvärde har lite inverkan på helheten — leta efter det tydliga temperaturskiftet.",
                        explanation: "BBT-grafer är sällan perfekta. Det övergripande mönstret — en tydlig temperaturstegring — är viktigare än enstaka avvikelser."
                    )
                ],
                exercise: CourseExercise(
                    title: "Starta BBT-mätning",
                    description: "Sätt upp rutinen för daglig BBT-mätning och börja bygga din temperaturkurva.",
                    steps: [
                        "Köp ett BBT-termometer (mäter till 0,1 graders noggrannhet)",
                        "Lägg termometern på nattduksbordet — använd den INNAN du lyfter huvud från kudden",
                        "Mät varje morgon vid samma tid (±30 minuter)",
                        "Notera temperaturen direkt i en app eller på papper",
                        "Markera när mensen börjar, när sekretet förändras, och när temperaturen stiger",
                        "Fortsätt minst 2 cykler för att se ett mönster"
                    ],
                    duration: "2 minuter varje morgon"
                ),
                reflectionQuestions: [
                    "Verkar rutinen med BBT-mätning hanterbar för dig — eller stressar den dig?",
                    "Har du sett en tydlig temperaturstegring i din graf?",
                    "Hur kombinerar du BBT med andra fertilitetsmetoder?"
                ],
                forumSection: CourseForumSection(
                    intro: "Erfarenheter med BBT och LH-testning:",
                    consensus: "BBT-spårning beskrivs som tidskrävande men lärorikt. Många berättar att det tog 2–3 cykler innan mönstret blev tydligt. LH-test upplevs som enklare att börja med.",
                    quotes: [
                        "\"BBT-grafen blev mitt smarta sätt att bekräfta att jag faktiskt ovulerar. Det var ovärderlig information.\" – Therese",
                        "\"Jag kombinerar LH-strip och BBT — LH ger mig förvarning och BBT bekräftar. Det funkar perfekt för mig.\" – Rebecka",
                        "\"Det tog tre månader innan min graf började se 'rätt' ut. Ha tålamod med processen.\" – Frida"
                    ],
                    source: "Baserat på symptotermala metoden och Taking Charge of Your Fertility"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "fb-4",
                title: "Livsstil och fertilitet",
                subtitle: "Hur dina vanor påverkar chanserna",
                icon: "leaf.fill",
                introduction: """
                Fertilitet är inte enbart genetik — livsstilsfaktorer har en dokumenterad påverkan på både äggkvalitet, spermiekvalitet och hormonbalans. Den goda nyheten är att många av dessa faktorer är påverkbara. Förändringar i kost, träning, sömn och stressnivå kan göra en mätbar skillnad på relativt kort tid.

                Det handlar inte om att vara perfekt eller följa en strikt regim. Forskningen pekar på att moderata, hållbara förändringar — snarare än extrema insatser — ger bäst resultat. Och kom ihåg: det gäller båda partnerna. Spermiekvalitet påverkas lika mycket av livsstil som äggkvalitet.

                I den här modulen tittar vi på de faktorer som faktiskt har vetenskapligt stöd — utan att ge efter för kvacksalveri eller orealistiska löften.
                """,
                keyPoints: [
                    "Rökning skadar äggkvalitet, spermier och hormonbalans — sluta om möjligt",
                    "BMI utanför normalintervallet (18,5–25) påverkar ovulationen negativt",
                    "Extrem träning kan störa menscykeln — måttlig rörelse är optimal",
                    "Folsyra (400–800 mcg) är det mest dokumenterade kosttillskottet för fertilitet",
                    "Spermier tar 72 dagar att produceras — manlig livsstil spelar lika stor roll"
                ],
                examples: [
                    CourseExample(
                        scenario: "Jonas dricker 15–20 glas alkohol per vecka och paret försöker bli gravida.",
                        wrongApproach: "Fokusera bara på kvinnans livsstil eftersom det är hon som bär graviditeten.",
                        rightApproach: "Informera Jonas om att alkohol direkt försämrar spermiekvalitet, testosteronnivåer och rörlighet. Forskning visar att manlig alkoholkonsumtion på denna nivå signifikant minskar befruktningschanserna.",
                        explanation: "Manlig fertilitet är lika viktig som kvinnlig. Spermier bildas under 72 dagar — förändringar i livsstil syns i spermieprover efter ca 3 månader."
                    )
                ],
                exercise: CourseExercise(
                    title: "Fertilitetsvänlig veckoplan",
                    description: "En veckas fokus på de livsstilsfaktorer som har störst påverkan.",
                    steps: [
                        "Måndag: Börja ta folsyra (båda partners, om möjligt)",
                        "Tisdag: Byt ut en alkoholfri dag — notera hur det känns",
                        "Onsdag: 30 minuters promenad — måttlig träning gynnar fertilitet",
                        "Torsdag: Sömnfokus — lägg dig 30 minuter tidigare",
                        "Fredag: Kostgranskning — ät fler grönsaker och fullkorn",
                        "Helgen: Stressreduktion — en aktivitet du vet hjälper dig koppla av"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Vilken livsstilsfaktor tror du har störst påverkan på dig personligen?",
                    "Har du och din partner diskuterat livsstilsförändringar inför försöken?",
                    "Vad är mest realistiskt för er att förändra just nu?"
                ],
                forumSection: CourseForumSection(
                    intro: "Livsstilsförändringar under TTC — gemensamma erfarenheter:",
                    consensus: "De flesta berättar att livsstilsförändringar under TTC kändes meningsfulla oavsett om de hade direkt effekt. Känslan av att göra något aktivt hjälpte mot ångesten att vänta.",
                    quotes: [
                        "\"Vi slutade dricka alkohol båda två. Det blev oväntat ett bra sätt att hantera stressen av TTC — vi var ett team.\" – Sara & Johan",
                        "\"Jag la på 5 kilo för att mitt BMI var lite lågt. Min cykel blev mer regelbunden direkt.\" – Lena",
                        "\"Folsyran tog jag i 6 månader innan vi lyckades. Vet inte om den hjälpte men det kändes bra.\" – Maria"
                    ],
                    source: "WHO, Läkemedelsverket, American Society for Reproductive Medicine"
                ),
                readingTimeMinutes: 11
            ),
            CourseModule(
                id: "fb-5",
                title: "När det tar tid — nästa steg",
                subtitle: "Vad gäller och när söka hjälp",
                icon: "clock.arrow.circlepath",
                introduction: """
                För de flesta par tar det flera månader att bli gravida — och det är helt normalt. Statistiskt sett uppnår ungefär 85 % av par graviditet inom ett år av regelbundna försök. Men månader av negativa tester kan ta på krafterna, och det är viktigt att veta när det är läge att söka professionell hjälp.

                Riktlinjerna är tydliga: om du är under 35 och försökt i ett år utan resultat, är det dags att kontakta vården. Om du är 35 eller äldre gäller sex månader. Och vid kända riskfaktorer — oregelbundna cykler, endometrios, tidigare STI eller manliga faktorer — kan det vara värt att söka hjälp tidigare.

                Att söka hjälp är inte ett misslyckande — det är ett aktivt val att ta kontroll. Utredning ger svar, och svar ger möjligheter.
                """,
                keyPoints: [
                    "85 % av par uppnår graviditet inom 12 månader av regelbundna försök",
                    "Under 35 år: sök hjälp efter 12 månaders försök utan resultat",
                    "35 år eller äldre: sök hjälp efter 6 månader",
                    "Kända riskfaktorer: oregelbunden cykel, endometrios, PCOS — sök tidigare",
                    "Första steget är vanligtvis hormontester och spermieprov — relativt enkelt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Anna, 32, har försökt i 14 månader. Hennes läkare sa 'fortsätt försöka, det tar tid'.",
                        wrongApproach: "Acceptera det och vänta ytterligare ett år.",
                        rightApproach: "Be om en remiss till gynekolog eller fertilitetsläkare. Vid 12+ månaders försök utan graviditet har du rätt att kräva en utredning. Ta med en lista på cykeldata och spårning du gjort.",
                        explanation: "En allmänläkare är inte alltid uppdaterad på fertilitetsvård. Att vara självhävdande och begära remiss är helt befogat efter 12 månaders försök."
                    )
                ],
                exercise: CourseExercise(
                    title: "Förbered ditt läkarbesök",
                    description: "Sammanfatta din fertilitetsspårning och förbered frågor inför ett läkarbesök.",
                    steps: [
                        "Sammanfatta dina cykellängder de senaste 6 månaderna",
                        "Anteckna eventuella symtom: oregelbundna blödningar, smärta, flödesproblem",
                        "Skriv ner hur länge ni försökt och hur ofta",
                        "Förbered 3–5 frågor du vill ha svar på",
                        "Be din partner komma med — mannens hälsa undersöks lika viktigt"
                    ],
                    duration: "30 minuter förberedelse"
                ),
                reflectionQuestions: [
                    "Hur hanterar du månader av väntan och osäkerhet?",
                    "Har du och din partner samma inställning till när ni ska söka hjälp?",
                    "Vad är dina största farhågor inför en eventuell utredning?"
                ],
                forumSection: CourseForumSection(
                    intro: "Erfarenheter från par som sökte hjälp:",
                    consensus: "Att ta steget att söka hjälp beskrivs som en lättnad. Många ångrar att de väntade för länge. Utredningsfasen kan vara tuff men ger svar.",
                    quotes: [
                        "\"Väntade ett och ett halvt år med att söka hjälp. Hade vi gått ett år in hade vi sparat oss 6 månader av onödig väntan.\" – Helena",
                        "\"Det kändes som ett misslyckande att söka IVF-hjälp. Nu ser jag det som det smartaste vi gjort.\" – Kristina & Peter",
                        "\"Spermieprovet visade låg rörlighet. Det visste vi inte förrän vi utredde. Kände mig dum att vi inte kollat det tidigare.\" – Markus"
                    ],
                    source: "SFOG (Svensk förening för obstetrik och gynekologi), 1177 Vårdguiden"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "fb-6",
                title: "Emotionell hälsa under TTC",
                subtitle: "Hålla sig hel när det är svårt",
                icon: "brain.head.profile",
                introduction: """
                Att försöka bli gravid utan att lyckas kan vara en av de emotionellt mest påfrestande upplevelserna ett par genomgår. Ångesten inför ett nytt test, sorgen när mensen kommer igen, stressen i relationen — det är verkliga och tunga känslor som ofta underskattas av omgivningen.

                Forskning visar att stress inte orsakar infertilitet, men kronisk stress påverkar hormonbalansen. Ännu viktigare: psykisk ohälsa under TTC-perioden är vanlig och tar inte hand om sig själv. Du förtjänar stöd.

                I den här modulen pratar vi om hur du kan ta hand om dig emotionellt, kommunicera med din partner, och när det kan vara rätt att söka professionellt psykologstöd.
                """,
                keyPoints: [
                    "Ångest och depression är vanligare under TTC än vad folk pratar om",
                    "Stress orsakar inte infertilitet men påverkar hormonbalansen negativt",
                    "Kommunikation med partner är avgörande — ni kan ha helt olika hanteringsstrategier",
                    "Socialt stöd — vänner, grupper, terapi — är dokumenterat hjälpsamt",
                    "Det är okej att ta pauser från aktiv TTC-försökning för din mentala hälsa"
                ],
                examples: [
                    CourseExample(
                        scenario: "Lena vill prata om TTC-processen med sin man varje dag, men han stänger av och vill 'inte ta hem jobbet'.",
                        wrongApproach: "Tolka hans tystnad som ointresse eller att han inte bryr sig.",
                        rightApproach: "Förstå att par hanterar emotionell stress på fundamentalt olika sätt. Komma överens om 'TTC-fria' dagar och dedikerade samtalstider — det ger båda kontroll.",
                        explanation: "Olikheter i kommunikationsstilar är bland de vanligaste relationsstressorerna under TTC. Att sätta upp strukturer för när ni pratar om det hjälper båda."
                    )
                ],
                exercise: CourseExercise(
                    title: "Parsamtal om TTC-resan",
                    description: "Ett strukturerat samtal med din partner för att stämma av emotionellt var ni befinner er.",
                    steps: [
                        "Välj ett neutralt tillfälle — inte precis efter ett negativt test",
                        "Varje partner delar: 'En sak jag är tacksam för i vår resa'",
                        "Varje partner delar: 'En sak jag finner svårast just nu'",
                        "Diskutera: 'Hur kan jag stötta dig bättre?'",
                        "Avsluta med ett konkret nästa steg ni tar tillsammans"
                    ],
                    duration: "30–45 minuter"
                ),
                reflectionQuestions: [
                    "Hur mår du psykiskt under TTC-resan — har du ett ärligt svar på det?",
                    "Har du berättat för din partner hur du faktiskt mår, eller håller du något tillbaka?",
                    "Vilka aktiviteter eller rutiner hjälper dig att känna dig hel — utanför TTC-fokuset?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om den emotionella sidan av TTC:",
                    consensus: "Det är den del av TTC som är minst synlig men mest påfrestande. Många berättar att terapin eller stödgruppen var den viktigaste insatsen under hela resan.",
                    quotes: [
                        "\"Alla frågar om det 'fungerar' — ingen frågar hur du mår. Det är ensamt.\" – Maja",
                        "\"Jag sökte KBT-terapi efter 18 månader av TTC. Det räddade mitt förhållande.\" – Cecilia",
                        "\"Vi tog en tre-månaders paus från aktivt försökande. Det var det bästa vi gjorde — vi fick tillbaka oss själva.\" – Tobias & Eva"
                    ],
                    source: "Psykologisk forskning om infertilitetsrelaterad stress, KBT-baserad coping"
                ),
                readingTimeMinutes: 10
            )
        ],
        targetAudience: "TTC",
        estimatedWeeks: 4
    )
}

// MARK: - Course 10: Babysömn 0–12 månader

extension Course {
    static let babySomn = Course(
        id: "baby_sleep",
        title: "Babysömn 0–12 månader",
        subtitle: "Bygg hälsosamma sömnvanor",
        description: "En komplett guide till babysömn från nyfödd till ett-åring. Lär dig vad som är normalt, hur du skapar hållbara sömnrutiner och hur du navigerar regressioner och övergångar med trygghet.",
        icon: "moon.zzz.fill",
        gradient: LinearGradient(colors: [Color(hex: "4F46E5"), Color(hex: "818CF8")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "bs-1",
                title: "Nyföddsömn — normalt och förväntat",
                subtitle: "Förväntningarna som gör skillnad",
                icon: "moon.stars.fill",
                introduction: """
                Nyfödda sover mycket — upp till 16–18 timmar per dygn — men sällan mer än 2–3 timmar i sträck. Detta är helt biologiskt normalt och handlar om magsäckens lilla storlek, det höga kaloriberäkningsbehovet och sömncykelns struktur. Att förvänta sig nattlångasömn de första veckorna skapar onödig frustration.

                Nyföddsömn är kaotisk och oförutsägbar — och det är meningen. Bebisens dygnsrytm är inte inbyggd från början utan formas gradvis under de första 3–4 månaderna. Din roll är att tillhandahålla en trygg sömnmiljö och responsivt stöd, inte att programmera ett schema.

                Att förstå vad som faktiskt är normalt hjälper dig att vila i kaos snarare än att kämpa mot det.
                """,
                keyPoints: [
                    "Nyfödda sover 16–18 timmar per dygn i korta pass om 2–3 timmar",
                    "Dygnsrytm etableras inte förrän vid 3–4 månaders ålder",
                    "REM-sömn utgör 50 % av nyföddsömnen — viktig för hjärnutveckling",
                    "Hungersignaler vaknar var 2–3 timme — nattmatning är biologiskt nödvändig",
                    "Safe sleep: rygg, fast madrass, ingen lös sängklädsel under 12 månader"
                ],
                examples: [
                    CourseExample(
                        scenario: "Leila, 3 veckor gammal, vaknar var 90:e minut på natten och hennes föräldrar tror att något är fel.",
                        wrongApproach: "Söka efter sömnmetoder för att 'träna' bebisen att sova längre.",
                        rightApproach: "Förstå att 90 minuters sömncykler är normalt för en nyfödd och att täta uppvaknanden är biologiska behov. Fokusera på skiftesarbete med partner och vila när bebisen sover.",
                        explanation: "Att försöka sömnträna en nyfödd är kontraproduktivt och potentiellt skadligt. De täta uppvaknandena är en skyddsmekanism, inte ett problem att lösa."
                    )
                ],
                exercise: CourseExercise(
                    title: "Skiftschema för de första veckorna",
                    description: "Planera ett realistiskt sömnschema för er som par under de första intensiva veckorna.",
                    steps: [
                        "Dela upp natten i 'tidigt' (21:00–02:00) och 'sent' (02:00–07:00) pass",
                        "En förälder har ansvaret per pass — den andra sover oavbrutet",
                        "Rotera varje natt eller varannan natt beroende på amning/pumpning",
                        "Håll ett enkelt schema skrivet — det minskar nattliga diskussioner",
                        "Utvärdera schemat efter en vecka och justera"
                    ],
                    duration: "Planering: 20 minuter. Genomförande: 4–8 veckor"
                ),
                reflectionQuestions: [
                    "Hur förberedda var ni på hur lite ni skulle sova de första veckorna?",
                    "Vilket stöd har ni runt er — kan ni be om avlastning?",
                    "Hur hanterar ni frustrationen när ingenting fungerar och bebisen skriker?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om de första veckornas sömnkaos:",
                    consensus: "Det allra vanligaste rådet från föräldrar längre fram är: 'Det går över'. De flesta beskriver vecka 4–8 som det tuffaste och att det vänder vid 3–4 månader.",
                    quotes: [
                        "\"Ingen berättade för mig att vi inte skulle sova de första månaderna. Hade jag vetat hade jag förberett mig mentalt.\" – Hanna",
                        "\"Skiftschemat räddade oss. Vi visste att vi inte behövde klara av allt — bara vårt pass.\" – Jonas",
                        "\"Vecka 6 var absolut mörkast. Vecka 12 sov hon 4 timmar i sträck och det kändes som ett mirakel.\" – Emma"
                    ],
                    source: "Karolinska Institutet, Normal infant sleep development, AAP Safe Sleep guidelines"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bs-2",
                title: "Wake windows och sömntecken",
                subtitle: "Timing är allt",
                icon: "clock.fill",
                introduction: """
                Wake windows — den tid bebisen är vaken mellan sömnpass — är ett av de viktigaste begreppen i babysömn. Lägger du bebisen för tidigt sover den inte. Lägger du den för sent är den övertröttad, och övertröttade bebisar sover paradoxalt nog sämre.

                Varje åldersgrupp har ett specifikt fönster där sömn sätter sig naturligast. Kombinerat med sömnteckensavläsning — de tidiga signalerna på att bebisen börjar bli trött — kan du optimera timingen och minska sömnkampen.

                Det handlar inte om att följa ett strikt schema, utan om att lära sig läsa din bebis och agera på rätt signaler i rätt tid.
                """,
                keyPoints: [
                    "0–6 veckor: wake windows 45–60 minuter",
                    "2–3 månader: 60–90 minuter",
                    "4–6 månader: 1,5–2,5 timmar",
                    "7–12 månader: 2–4 timmar (ökar gradvis)",
                    "Tidiga sömntecken: stirrigt blick, gnidning av ögon, minskad aktivitet — inte gråt"
                ],
                examples: [
                    CourseExample(
                        scenario: "Gustav, 5 månader, kämpar vid läggdags — skriker och verkar inte trött trots att han vaknat för länge sedan.",
                        wrongApproach: "Vänta tills han gäspar upprepade gånger innan du börjar sömnrutinen.",
                        rightApproach: "Starta sömnrutinen baserat på wake window — ca 2 timmar efter att han vaknade. Tidiga sömntecken är subtila; gäspningar är ett sent tecken.",
                        explanation: "Att vänta tills sent sömntecken som gäspningar dyker upp kan innebära att bebisen redan är övertröttad och att kortisol (stresshormon) stigit, vilket gör insomning svårare."
                    )
                ],
                exercise: CourseExercise(
                    title: "Sömnteckens-logg",
                    description: "Observera och notera din bebis personliga sömntecken under 3 dagar.",
                    steps: [
                        "Sätt en timer på 10 minuter innan förväntat wake window-slut",
                        "Observera bebisen noga: blick, aktivitet, humör",
                        "Notera tre saker du märker AV att bebisen börjar bli trött",
                        "Starta sömnrutinen vid dessa tidiga tecken — inte senare",
                        "Utvärdera: somnade lättare om du agerade tidigare?"
                    ],
                    duration: "3 dagars observation"
                ),
                reflectionQuestions: [
                    "Vilka är din bebis unika sömntecken — utöver gråten?",
                    "Har du märkt att din bebis sover bättre på vissa tider?",
                    "Hur reagerar bebisen om du lägger den för tidigt vs. för sent?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om wake windows och timing:",
                    consensus: "Wake windows beskrivs som det mest praktiskt användbara konceptet för babysömn. Många berättar att bara det förändrade hela sömnsituationen.",
                    quotes: [
                        "\"Wake window-konceptet var en revolution. Vi hade lagt henne för tidigt varje gång.\" – Karin",
                        "\"Jag lärde mig hennes blick — den lite frånvarande blicken. Det är mitt signal att börja vira in henne.\" – Pernilla",
                        "\"Det är inte ett exakt schema — det är ett fönster. Den insikten tog bort stressen.\" – Lars"
                    ],
                    source: "Sleep Research Society, Taking Cara Babies, pediatrisk sömnforskning"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "bs-3",
                title: "4-månaders regressionen",
                subtitle: "Varför allt förändras",
                icon: "exclamationmark.triangle.fill",
                introduction: """
                4-månaders regressionen är en av de mest dokumenterade och utmanande förändringarna i babysömn. Runt 3,5–5 månader genomgår hjärnan en mognadssprång: sömnarkitekturen förändras permanent från nyföddsömn till vuxenliknande sömnstadier. Det innebär fler uppvaknanden mellan cykler — och ett plötsligt slut på 'lång sömnstretch'.

                Det är viktigt att förstå att detta inte är en regression som 'går tillbaka' till hur det var. Sömnmönstret har förändrats permanent. Det som däremot kan förändras är hur bebisen hanterar uppvakningarna — om den har sömnassociationer eller kan återinsomna själv.

                Regressionen är ett tecken på neurologisk mognad, inte på att något är fel. Men det är också ett utmärkt tillfälle att börja bygga mer hållbara sömnstrukturer.
                """,
                keyPoints: [
                    "Sömnarkitekturen ändras permanent vid 3,5–5 månader",
                    "Fler uppvaknanden är normalt — problemet är sömnassociationer",
                    "Sömnassociationer: det bebisen kräver vid varje uppvaknande för att återinsomna",
                    "Vanliga asociationer: amning, nappning, bärande — inte dåliga i sig",
                    "4-månaders regression är ett bra tillfälle att börja introduera sömnritual"
                ],
                examples: [
                    CourseExample(
                        scenario: "Max, 4,5 månader, vaknar 6–8 gånger per natt och kräver amning vid varje uppvaknande, trots att han väjer sig i 3 månader.",
                        wrongApproach: "Tro att det handlar om hunger och börja erbjuda ersättning på natten.",
                        rightApproach: "Förstå att amningen har blivit en sömnassociation — Max associerar insomning med amning och kräver det vid varje uppvakningscykel. Gradvis introducera alternativa sömnrutiner vid lättare uppvaknanden.",
                        explanation: "Täta nattuppvaknanden vid denna ålder handlar sällan om hunger. Det handlar om sömnassociationer som formades när bebisen var yngre och som nu behöver gradvis förändras."
                    )
                ],
                exercise: CourseExercise(
                    title: "Kartlägg sömnassociationer",
                    description: "Identifiera ditt barns nuvarande sömnassociationer och rangordna dem.",
                    steps: [
                        "Lista: vad gör du/sker vid varje insomningstillfälle? (amning, vagga, napp, bärande, musik)",
                        "Lista: vad sker vid nattliga uppvaknanden? Är det samma mönster?",
                        "Rangordna: vilka associationer är du redo att förändra?",
                        "Välj EN association att gradvis förändra — börja med det enklaste",
                        "Ge förändringen minst 5–7 nätter innan du utvärderar"
                    ],
                    duration: "Planering 20 minuter, genomförande 1–2 veckor"
                ),
                reflectionQuestions: [
                    "Vilka sömnassociationer har ditt barn? Är du redo att förändra dem?",
                    "Hur mår du som förälder mitt i regressionen — söker du stöd?",
                    "Vad är din viktigaste prioritet: kortvarig sömn nu vs. långsiktig sömnförmåga?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om 4-månaders regressionen:",
                    consensus: "Beskrivs konsekvent som en av de tuffaste perioderna. Vetskapen om att det är normalt och biologiskt hjälper, men tar inte bort tröttheten. Stöd från partner och omgivning är nyckeln.",
                    quotes: [
                        "\"Ingen varnade mig. Jag trodde att min bebis var sjuk när hon gick från 5-timmars sträckor till att vakna varje timme.\" – Ylva",
                        "\"När jag förstod sömnassociations-konceptet klickade allt. Det handlar inte om mat, det handlar om vanor.\" – Markus",
                        "\"Det tog 3 veckor men vi kom igenom det. Var snäll mot dig själv under den perioden.\" – Sofia"
                    ],
                    source: "Karolinska sömnforskning, Macall Gordon, sömnvetenskapen bakom sömnarkitektur"
                ),
                readingTimeMinutes: 11
            ),
            CourseModule(
                id: "bs-4",
                title: "Sömnritualer som fungerar",
                subtitle: "Bygga en konsekvent sömnrutin",
                icon: "moon.fill",
                introduction: """
                En sömnritual — en konsekvent sekvens av aktiviteter före sömn — är ett av de mest kraftfulla verktygen för babysömn. Ritualen signalerar till bebisens hjärna att sömn är på väg, och sänker arousalsnivån gradvis. Det behöver inte vara komplicerat: 15–20 minuter med samma aktiviteter i samma ordning räcker.

                Forskning visar att bebisar och barn med konsekvent sömnritual somnar snabbare, sover längre och vaknar färre gånger på natten. Ritualen skapar förutsägbarhet — och förutsägbarhet är trygghet.

                En effektiv sömnritual inkluderar visuella, auditiva och sensoriska signaler: dimma belysningen, samma musik eller vitt brus, bad eller massage, matning, sovbok eller sång.
                """,
                keyPoints: [
                    "Konsekvent sömnritual minskar insomingstid och nattuppvaknanden",
                    "15–20 minuters ritual är tillräcklig — mer är inte bättre",
                    "Sekvensen är viktigare än enskilda aktiviteterna",
                    "Dim belysning 30 minuter före sömn hjälper melatoninproduktionen",
                    "Ritualen ska avslutas i sängplatsen — inte i dina armar"
                ],
                examples: [
                    CourseExample(
                        scenario: "Isabella, 7 månader, somnar alltid i mammas armar men vaknar och skriker när hon läggs ner.",
                        wrongApproach: "Fortsätta hålla henne i armarna tills hon är djupt sovandes.",
                        rightApproach: "Förändra ritualen gradvis: avsluta matning tidigare, lägg henne sömnig men vaken i sängen, placera handen på hennes mage. Ge henne möjligheten att avsluta insomnandet själv.",
                        explanation: "Att lägga ner bebisen sömnig men vaken är grunden för att bebisen ska lära sig insomna i sängen. Det kallas 'drowsy but awake' och är en nyckelprincip i sömncoachning."
                    )
                ],
                exercise: CourseExercise(
                    title: "Designa er sömnritual",
                    description: "Skapa en 15–20 minuters sömnritual anpassad till er familj.",
                    steps: [
                        "Välj start: när börjar ritualen? (t.ex. bad eller dimmad belysning)",
                        "Välj 3–4 aktiviteter i fast ordning (t.ex. bad → massage → amning/mat → sång → säng)",
                        "Välj ett ljudlandskap: vitt brus, naturljud eller tystnad",
                        "Bestäm avslutningsfras: samma ord varje gång ('God natt, vi ses på morgonen')",
                        "Håll ritualen konsekvent i 5–7 dagar och notera effekt"
                    ],
                    duration: "Planering 15 minuter, utvärdering efter 1 vecka"
                ),
                reflectionQuestions: [
                    "Har ni en sömnritual idag? Hur konsekvent är den?",
                    "Vilka delar av ritualen fungerar bra — vad kan ni bygga vidare på?",
                    "Hur hanterar ni ritualen när ni är borta hemifrån eller rutinen bryts?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om sömnritualer och läggdagsrutiner:",
                    consensus: "Konsistens betonas av alla. Att ha en rutin som fungerar även på bortaplan — bada hemma, ta med sin sova-musik — ger trygghet.",
                    quotes: [
                        "\"Det var inte aktiviteterna som var viktiga — det var att vi alltid gjorde dem i samma ordning. Hjärnan kopplar rätt.\" – Alexander",
                        "\"Vitt brus förändrade allt. Vi är på 14 månader och fortfarande samma ljud.\" – Ida",
                        "\"'Drowsy but awake' lät omöjligt i veckor. Sen plötsligt lade jag henne ner och hon stängde ögonen av sig själv. Det var magiskt.\" – Gunilla"
                    ],
                    source: "Pediatrisk sömnforskning, Dr Marc Weissbluth, American Academy of Sleep Medicine"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bs-5",
                title: "Nattavvänjning — metoder och timing",
                subtitle: "Gradvis minska nattmatning",
                icon: "arrow.down.circle.fill",
                introduction: """
                Nattavvänjning — att gradvis minska eller eliminera nattmatning — är ett av de mer komplexa besluten i babysömn, eftersom det rör sig om biologiska behov, sömnassociationer och föräldrarnas värderingar på en och samma gång. Det finns ingen universell tidpunkt för när det är 'rätt' att minska nattmatning.

                De flesta barn kan klara sig utan nattmatning vid 6 månaders ålder ur medicinsk synvinkel, men det är en stor skillnad mot att de ska klara sig utan. Många barn ammas eller ges flaska på natten långt in i det andra levnadsåret — och det är helt normalt.

                Det viktigaste är att skilja på hungersbaserade uppvaknanden och sömnassociationsbaserade. Gradvis avvänjning, med respekt för barnets signaler, är bättre än abrupt avslutning.
                """,
                keyPoints: [
                    "Medicinsk nattfasta möjlig från ca 6 månader — men behöver inte innebära avvänjning",
                    "Skilja på hunger och sömnassociation — mattning tar 20+ minuter vid riktig hunger",
                    "Gradvis avvänjning: minska mängd eller varaktighet med 1–2 minuter per natt",
                    "Pappor/partner kan ta nattuppvaknanden för att undvika amningsassociation",
                    "Abrupt avslutning fungerar för vissa barn men är inte nödvändig"
                ],
                examples: [
                    CourseExample(
                        scenario: "Nora, 8 månader, ammar 4 gånger per natt men äter bara i 2–3 minuter vid varje tillfälle.",
                        wrongApproach: "Tolka kort amning som att hon inte är hungry och stoppa omedelbart.",
                        rightApproach: "Förstå att kort amning vid uppvaknande är ett tydligt sömnassociationstecken. Börja gradvis avvänjning: minska varje amning med 1 minut per natt, tills den är 0, och ersätt med annan lugning.",
                        explanation: "Amning som bara varar 2–3 minuter vid varje uppvaknande handlar nästan alltid om sömnassociation, inte hunger. Gradvis minskning respekterar barnets behov av trygghet."
                    )
                ],
                exercise: CourseExercise(
                    title: "Nattavvänjningsplan",
                    description: "Skapa en gradvis plan för att minska eller eliminera en nattmatning.",
                    steps: [
                        "Välj den nattmatning du vill börja avvänja (t.ex. 02:00-matningen)",
                        "Notera nuvarande varaktighet (t.ex. 10 minuter)",
                        "Minska med 2 minuter per natt: dag 1 = 8 min, dag 2 = 6 min...",
                        "När matningen är < 2 minuter, ersätt med annan lugning (klapp, sång)",
                        "Ge 3–5 nätter på varje steg — det ska gå långsamt"
                    ],
                    duration: "2–4 veckor gradvis process"
                ),
                reflectionQuestions: [
                    "Är du redo att börja minska nattmatning — är det din önskan eller yttre tryck?",
                    "Hur kommunicerar du och din partner kring nattuppvaknanden och ansvarsfördelning?",
                    "Vad är ditt mål — helt nattfasta eller bara minska antalet uppvaknanden?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om nattavvänjning:",
                    consensus: "Timing är personlig. Många berättar att yttre tryck ('vid det här laget borde...') skapade onödig stress. Att göra det på familjens villkor och i rätt takt ger bäst resultat.",
                    quotes: [
                        "\"Jag sa att jag skulle sluta nattamma vid 6 månader. Vi fortsatte till 14 månader och jag ångrar ingenting.\" – Birgitta",
                        "\"Gradvis var nyckeln för oss. En matning i taget. Det tog 6 veckor men det var smärtfritt.\" – Niklas",
                        "\"Pappan tog nattskiften en vecka. Det tog tre nätter och sedan sov han igenom. Jag hade väntat i ett år.\" – Marianne"
                    ],
                    source: "WHO amningsriktlinjer, Dr Jay Gordon Night Weaning, pediatrisk sömnforskning"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bs-6",
                title: "Tupplursövergångar",
                subtitle: "Navigera förändrade tupplursbehov",
                icon: "sun.max.fill",
                introduction: """
                Under det första levnadsåret minskar bebisens tupplursbehov successivt: från 4–5 korta tupplurer som nyfödd till 3, sedan 2, och slutligen mot 1 vid ca 12–18 månaders ålder. Varje övergång är en stor förändring som kräver justering av hela dygnsrytmen.

                Tecken på att bebisen är redo för en tupplursövergång: konsekvent kortare tupplurer, svårt att somna vid sin vanliga tupplurtid, eller att läggdagssömnen påverkas negativt av sena tupplurer.

                Att göra övergångarna för tidigt är ett vanligt misstag — övertröttad bebis ger kortare tupplurer och sämre nattsömn. Att vänta för länge ger sen sova-tid och nattuppvaknanden. Det gäller att hitta rätt fönster.
                """,
                keyPoints: [
                    "3→2 tupplurer: vanligtvis vid 3–4 månader",
                    "2→1 tupplur: vanligtvis vid 15–18 månader (inte 12 månader som många tror)",
                    "Tidiga tecken: konsistenta kortare tupplurer, motstånd vid tupplurtid",
                    "Övergångsfasen kan ta 2–4 veckor — förvänta dig röriga dagar",
                    "Håll läggdags flexibelt: vid tunga tupplurdagar, flytta fram lite"
                ],
                examples: [
                    CourseExample(
                        scenario: "Hugo, 14 månader, kämpas mot eftermiddagstuppluren men är tydligt trött runt 14:00.",
                        wrongApproach: "Tolka motståndet som att han inte behöver tuppluren och eliminera den omedelbart.",
                        rightApproach: "Förstå att motstånd vid 14 månader inte nödvändigtvis signalerar 2→1-övergång (den sker typiskt vid 15–18 månader). Prova att justera tupplurtid eller sömnritual snarare än att eliminera.",
                        explanation: "Att eliminera tuppluren för tidigt leder till kronisk övertrötthet. Motstånd vid tupplurtid kan ha många orsaker — timing, sömnassociationer, miljö — som kan åtgärdas utan att eliminera tuppluren."
                    )
                ],
                exercise: CourseExercise(
                    title: "Tupplursdagbok",
                    description: "Spåra tupplursmönstret under en vecka för att avgöra om en övergång är aktuell.",
                    steps: [
                        "Notera varje tupplur: tid, varaktighet, hur länge det tog att somna",
                        "Notera läggdagstid och -varaktighet på natten",
                        "Notera barnets humör: trött, pigg, irritabel?",
                        "Identifiera mönster: sover konsekvent kort? Motstånd konsekvent?",
                        "Jämför med ålderstypiska förväntningar och besluta om timing"
                    ],
                    duration: "7 dagars observation"
                ),
                reflectionQuestions: [
                    "Hur ser ditt barns nuvarande tupplursschema ut — stämmer det med ålderstypiskt mönster?",
                    "Har du märkt förändringar i nattsömnen kopplad till tupplurerna?",
                    "Hur anpassar ni er vardag kring tupplurerna — är det flexibelt eller strikt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om tupplursövergångar:",
                    consensus: "2→1-övergången beskrivs som svårast och mest utdragen. Att acceptera en rörig övergångsmånad utan att stressa ger bäst resultat.",
                    quotes: [
                        "\"Min svärmor sa att ett-åringen inte behöver tupplur. Det stämde inte — han behövde tupplur tills han var 2,5 år.\" – Stina",
                        "\"Övergångsfasen med en tupplur om dagen tog tre veckor av kaos. Men när vi väl var igenom var schemat fantastiskt.\" – Björn",
                        "\"Jag lärde mig att hålla läggdagen dynamisk under övergångar. 19:30 en dag, 18:30 nästa.\" – Annelie"
                    ],
                    source: "Sömnforskning om nap transitions, Taking Cara Babies, The Happy Sleeper"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "bs-7",
                title: "Sömnregression vid 8–10 månader",
                subtitle: "Separation och motorik förändrar sömnen",
                icon: "person.2.fill",
                introduction: """
                Kring 8–10 månader sker en annan vanlig sömnregression, orsakad av två parallella utvecklingssprång: separationsångest och motorisk explosion. Bebisen lär sig krypa, resa sig och stå — färdigheter som övas intensivt, till och med på natten. Och separationsångesten gör att närheten till föräldrarna känns ännu viktigare.

                Till skillnad från 4-månaders regressionen är denna mer tillfällig — vanligtvis 2–6 veckor. Men det kan ändå vara påfrestande eftersom bebisen nu är starkare, mer uttrycksfull och mer kapabel att eskalera när den inte får sin vilja igenom.

                Nyckeln är att möta behovet av trygghet utan att bygga nya sömnassociationer som är svåra att avveckla.
                """,
                keyPoints: [
                    "8–10 månaders regression drivs av separationsångest + motorisk utveckling",
                    "Bebisen övar motoriska färdigheter aktivt — även mitt i natten",
                    "Separationsprotester vid sänggaende är normala och förväntade",
                    "Konsekvent avsked-ritual minskar separationsångesten",
                    "Regressionen är tillfällig — 2–6 veckor vanligtvis"
                ],
                examples: [
                    CourseExample(
                        scenario: "Elsa, 9 månader, reser sig upp i sängen och skriker vid varje uppvaknande. Hon kan inte ligga ner av sig själv.",
                        wrongApproach: "Gå in och lägga henne ner varje gång hon reser sig — vilket triggar omedelbart uppstigning igen.",
                        rightApproach: "Hjälp henne lära sig att lägga sig ner under dagtid via övning. På natten: gå in, säg lugnt 'läggdags', hjälp henne ner en gång utan att lyfta upp henne, lämna rummet.",
                        explanation: "Att lägga ner bebisen upprepade gånger vid varje uppvaknande förstärker mönstret. Att lära ut förmågan under dagtid ger bebisen verktyget att använda på natten."
                    )
                ],
                exercise: CourseExercise(
                    title: "Trygg avskedsritual",
                    description: "Skapa en konsekvent och trygg avskedsrutin för sänggaendet.",
                    steps: [
                        "Välj ett avskedsfrases som ni alltid använder: 'Godnatt, vi ses på morgonen'",
                        "Gör en fysisk signal: kyss, kram, klapp på madrassen",
                        "Lämna rummet konsekvent — inte smyg ut när bebisen inte ser",
                        "Om bebisen protesterar: vänta 1–2 minuter, gå in lugnt, upprepa frasen",
                        "Håll samma rutin under hela regressionen — konsekvens ger trygghet"
                    ],
                    duration: "Dagligen under regressionsperioden"
                ),
                reflectionQuestions: [
                    "Hur hanterar du separationsångesten — tar det på dina egna känslor?",
                    "Vilka sömnassociationer är du beredd att acceptera under regressionen, och vilka vill du undvika?",
                    "Hur stöttar du dig själv och din partner under en regressionsfas?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om 8–10 månaders regressionen:",
                    consensus: "Den tillfälliga naturen av denna regression är tröstande. Det viktigaste rådet: håll rutinerna konsekvent och undvik att skapa nya sova-krav i desperation.",
                    quotes: [
                        "\"Hon reste sig upp och skrek i sängen i en vecka. Dag 8 lade hon sig ner av sig själv. Det gick faktiskt fort.\" – Helena",
                        "\"Separationsångesten slog till även vid tupplurer. Det hjälpte att göra avskedet kort och konsekvent istället för lång och dröjande.\" – Viktor",
                        "\"Vi missade ett nattuppvaknande en natt (sov igenom det) och gissade: han somnade om av sig själv. Det var en vändpunkt.\" – Julia"
                    ],
                    source: "Barns separationsångest och sömnforskning, Ainsworth anknytningsteori"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "bs-8",
                title: "Sömn och separation",
                subtitle: "Dagis, resor och rutinbrott",
                icon: "house.fill",
                introduction: """
                Sömnrutiner testas hårt av verklighetens störningar: dagisinskolning, semesterresor, tidszonsbyten, sjukdom och sjukperioder. Barn som annars sover bra kan plötsligt vakna igen — och det är normalt.

                Inskolning till dagis är en av de vanligaste triggarna för sömnregression hos barn under ett år. Den nya miljön, den ökade sociala stimuleringen och separationen aktiverar stressystemet — och sömnen påverkas ofta.

                Det finns strategier för att minimera störningen och snabbt återupprätta rutiner efter ett uppehåll. Det viktigaste är att inte övertolka tillfälliga baksteg som permanenta förändringar.
                """,
                keyPoints: [
                    "Dagisinskolning triggar ofta 1–4 veckors sömnförsämring",
                    "Sjukdomsperioder kräver flexibilitet — rutinen återupptas när barnet är friskt",
                    "Resor: ta med sömnmiljömarkörer (vitt brus, sova-leksak, sov-säck)",
                    "Tidszoner: justera 15 minuter per dag för att minska jetlag",
                    "Tillfälliga baksteg är normala — håll grundrutinen och det löser sig"
                ],
                examples: [
                    CourseExample(
                        scenario: "Familjen återvänder från semesterresa och sonen, 10 månader, sover plötsligt väldigt dåligt trots att han sov bra före resan.",
                        wrongApproach: "Söka nya sömnlösningar och tro att allt måste börjas om.",
                        rightApproach: "Återupprätta sömnritualen konsekvent från dag ett hemma. Håll normala tider. Förvänta dig 3–7 dagar av anpassning utan att ändra grundstrategin.",
                        explanation: "Barn behöver tid att återanpassa sig efter rutinstörningar. Att hålla sig till den kända rutinen skickar signalen att normalläget är tillbaka — och anpassningen sker snabbare."
                    )
                ],
                exercise: CourseExercise(
                    title: "Sömnpaketet för resande",
                    description: "Förbered en miniversion av sömnmiljön för resor och bortavistelser.",
                    steps: [
                        "Lista barnets sömnmarkörer: vitt brus? Sova-leksak? Sovsäck? Specifik filt?",
                        "Packa dessa i ett dedikerat 'sömn-kit' för resor",
                        "Håll ritualen identisk även på hotell eller hos morföräldrar",
                        "Säkerhetskontrollera sovmiljön på nytt ställe (inga kuddar, rätt temperatur)",
                        "Planera en buffert av lugn tid dagen efter ankomst"
                    ],
                    duration: "Förberedelse 30 minuter"
                ),
                reflectionQuestions: [
                    "Vad är de viktigaste sömnmarkörerna för ditt barn — vad måste alltid följa med?",
                    "Hur reagerar du när sömnrutinen störs — håller du dig lugn och konsekvent?",
                    "Vilka kommande händelser kan störa sömnen — hur förbereder ni er?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om sömnrutiner och störningar:",
                    consensus: "De som lyckas hålla grundrutinen konsekvent trots störningar berättar att anpassningen alltid sker snabbare. De som avviker för länge märker att det tar längre tid att komma tillbaka.",
                    quotes: [
                        "\"Dagisstart var tufft i 3 veckor. Sedan sov hon som ett log igen. Det var en period — inte ett nytt normaltillstånd.\" – Camilla",
                        "\"Vi reser med hela sömnkitet. Vitt brus-appen, sovsäcken, nallen. Det fungerar på hotell och hemma.\" – Daniel",
                        "\"Sjukdomar är undantag. När barnet är friskt återgår vi till rutinen, oavsett hur många dåliga vanor vi fått under sjukperioden.\" – Ingela"
                    ],
                    source: "Pediatrisk sömnmedicin, sömnregressioner vid dagisstart, reseanpassning"
                ),
                readingTimeMinutes: 8
            )
        ],
        targetAudience: "Föräldrar med baby 0–12 mån",
        estimatedWeeks: 6
    )
}

// MARK: - Course 11: Livet som ny förälder

extension Course {
    static let livetSomNyForalder = Course(
        id: "new_parent_life",
        title: "Livet som ny förälder",
        subtitle: "Navigera det nya livet",
        description: "En ärlig kurs om hur livet förändras när du blir förälder. Parrelationen, identiteten, ansvarsfördelningen och vägen tillbaka till dig själv — med verktyg för hela övergången.",
        icon: "figure.2.and.child.holdinghands",
        gradient: LinearGradient(colors: [Color(hex: "10B981"), Color(hex: "34D399")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "lnf-1",
                title: "Parrelationen efter bebisen",
                subtitle: "Relationens nya kartografi",
                icon: "heart.text.square.fill",
                introduction: """
                Att bli förälder förändrar en parrelation fundamentalt — och forskning bekräftar det. En av de mest robusta fynden i familjeforskningen är att partnertillfredsställelsen minskar markant det första året efter ett barns födelse. Det är inte ert fel. Det är normalt. Och det kan bli bättre.

                Förändringarna är många: sömnbrist, ansvarsfördelning, libido, identitetsförskjutning och förlorad 'vi-tid'. Många par hamnar i ett mönster av effektiv co-föräldraskap men tappar kontakten som partners. Att uppmärksamma det är första steget.

                I den här modulen pratar vi om de vanligaste relationsstressorerna under det första föräldraåret och konkreta verktyg för att navigera dem utan att tappa varandra.
                """,
                keyPoints: [
                    "Partnernöjdhet minskar det första föräldraskapsåret — men kan återhämta sig",
                    "Sömnbrist förstärker konflikter och minskar empatikapacitet",
                    "Ojämn ansvarsfördelning är den vanligaste stressorn i heterosexuella par",
                    "Parpratsstunder — korta, regelbundna — är viktigare än sällsynta stora samtal",
                    "Föräldrar som upprätthåller vänskap och skratt klarar sig bättre"
                ],
                examples: [
                    CourseExample(
                        scenario: "Hanna och Mikael bråkar allt mer om vem som 'gör mest'. Båda känner sig underskattas.",
                        wrongApproach: "Hålla på med ömsesidig bokföring av uppgifter som bevis i diskussionen.",
                        rightApproach: "Boka ett 'check-in'-samtal (utan bebis) och börja med vad varje person uppskattar hos den andre. Dela sedan ärligt: 'Jag känner mig överväldigad av...' Skapa en gemensam plan snarare än en rättegång.",
                        explanation: "Relationer under stress behöver nyheter om att den andre ser och värderar dem. Att börja med uppskattning sänker försvarsberedskapen och öppnar för verklig kommunikation."
                    )
                ],
                exercise: CourseExercise(
                    title: "Veckocheck-in som par",
                    description: "Ett 20-minutersformat för att stanna upp och stämma av som par en gång i veckan.",
                    steps: [
                        "Välj ett fast tillfälle: söndagskväll, fredagsfrukost, etc.",
                        "Varje person: 'Något jag uppskattade hos dig den här veckan'",
                        "Varje person: 'Något jag behöver mer av nästa vecka'",
                        "Gemensamt: 'En sak vi kan göra tillsammans den här veckan — bara vi'",
                        "Avsluta: 'Tack för att du är min partner i det här'"
                    ],
                    duration: "20 minuter, en gång per vecka"
                ),
                reflectionQuestions: [
                    "Känner du att ni är partners eller mestadels medarbetare just nu?",
                    "Vad var det som fick er att bli ett par — finns det fortfarande kvar?",
                    "Vad behöver DU från relationen som du inte får just nu?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om parrelationen efter bebisen:",
                    consensus: "Det mest gemensamma: båda tyckte att den andre inte förstod hur trötta de var. Att erkänna att tröttheten gör oss till sämre partners är ett viktigt steg.",
                    quotes: [
                        "\"Vi gick i parterapi när bebisen var 6 månader. Det räddade inte bara relationen — det förbättrade den.\" – Erik & Sandra",
                        "\"Fredagskväll utan mobil och bebis varannan vecka. Det kostar ingenting och är värt allt.\" – Lina",
                        "\"Det tog ett år innan vi log mot varandra igen och menade det. Men det kom tillbaka.\" – Thomas"
                    ],
                    source: "John Gottman Institute, forskning om parrelationer och föräldraskap"
                ),
                readingTimeMinutes: 11
            ),
            CourseModule(
                id: "lnf-2",
                title: "Postpartum — kropp och sinne",
                subtitle: "Läkning, hormoner och psykisk hälsa",
                icon: "bandage.fill",
                introduction: """
                Postpartumperioden — de fyra till tolv veckorna efter förlossningen — är en av de mest intensiva kroppsliga och psykologiska övergångarna en person kan genomgå. Kroppen läker från förlossningen, hormonerna störtdyker och den psykologiska realiteten av föräldraskap sjunker in.

                Postpartum blues (stämningssvängningar och gråtmildhet de första dagarna) är normalt och drabbar upp till 80 % av alla föräldrar. Postpartum depression, som är mer allvarlig och varar längre, drabbar 10–15 % och kräver professionell hjälp. Det finns också postpartum ångest, OCD-liknande tankar och i sällsynta fall postpartum psykos.

                Att veta vad som är normalt, när man ska söka hjälp, och hur man tar hand om sig under den här perioden är livsviktigt.
                """,
                keyPoints: [
                    "Postpartum blues: normal, drabbar 80 %, klingar av inom 2 veckor",
                    "PPD: drabbar 10–15 %, kräver stöd/behandling — söka hjälp är styrka",
                    "PPD drabbar även pappor och icke-bärande partners",
                    "Hormonstörtan efter förlossning är biologisk och inte ditt fel",
                    "Sömnbrist förstärker alla psykiska symtom — stöd är inte lyx"
                ],
                examples: [
                    CourseExample(
                        scenario: "Maria, 3 veckor efter förlossning, gråter varje dag, kan inte njuta av bebisen och känner sig som en dålig mamma.",
                        wrongApproach: "Tro att det är normalt postpartum blues och vänta ut det utan att söka hjälp.",
                        rightApproach: "Söka kontakt med barnmorska, BVC eller husläkare direkt. Symtom som varar mer än 2 veckor och inkluderar inability att njuta av bebisen är tecken på PPD — inte svaghet, utan en sjukdom som kan behandlas.",
                        explanation: "PPD behandlas framgångsrikt med terapi, medicinering eller kombinationen. Att söka hjälp tidigt förbättrar prognosen och är det bästa för både förälder och bebis."
                    )
                ],
                exercise: CourseExercise(
                    title: "Postpartum välmåendekoll",
                    description: "Gör en ärlig självskattning varje vecka under de första 3 månaderna.",
                    steps: [
                        "Skriv ner svar på: Hur sover jag? Hur äter jag? Hur mår jag psykiskt (1–10)?",
                        "Notera: Har jag några glädjestunder med bebisen idag?",
                        "Notera: Har jag haft hjälp denna vecka — av någon?",
                        "Flagga om: siffrorna är under 5 i tre dagar i rad, eller om du har negativa tankar om dig själv eller bebisen",
                        "Vid flaggning: kontakta barnmorska, BVC eller din läkare"
                    ],
                    duration: "5 minuter dagligen"
                ),
                reflectionQuestions: [
                    "Vet din partner och närstående hur du faktiskt mår — inte hur du ser ut att mår?",
                    "Har du stödsystem runt dig — vem kan du ringa om det blir svårt?",
                    "Vad är skillnaden för dig between trött och verkligen inte okej?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om postpartumupplevelsen:",
                    consensus: "Ärligheten om PPD och hur vanligt det är tas emot med enorm lättnad. Många berättar att de lidit i onödan för att de trodde att de var ensamma.",
                    quotes: [
                        "\"Jag trodde att det var så man kände sig som mamma. Ingen sa till mig att det var PPD. Sökte hjälp 6 månader för sent.\" – Kristin",
                        "\"Min man fick PPD — ingen berättade att det var möjligt. Han fick hjälp och det förändrade allt.\" – Jessica",
                        "\"Barnmorskan ställde EPDS-frågan vid 6-veckorskontrollen. Att bara få frågan öppnade dörren.\" – Malin"
                    ],
                    source: "Socialstyrelsen, Edinburgh Postnatal Depression Scale, PPD-forskning"
                ),
                readingTimeMinutes: 11
            ),
            CourseModule(
                id: "lnf-3",
                title: "Att dela på ansvaret",
                subtitle: "Rättvis och hållbar ansvarsfördelning",
                icon: "scale.3d",
                introduction: """
                Ojämn ansvarsfördelning är en av de vanligaste och mest relationsskadliga stressorerna under det första föräldraåret. Forskning visar att heterosexuella par systematiskt underskattar den icke-bärande partnerns bidrag — och att den bärande partnern ofta tar på sig mer än planerat, gradvis och utan medvetna beslut.

                Det handlar inte bara om vem som byter flest blöjor. Det handlar om det mentala lasset — att hålla i minnet vad som behöver göras, planeras, bokas, och tänkas på. Den osynliga koordineringen av familjelivet faller oproportionerligt på en person.

                Att adressera ansvarsfördelningen proaktivt — innan det blivit ett problem — ger en starkare grund för hela föräldraperioden.
                """,
                keyPoints: [
                    "Mental belastning är lika tung som fysisk arbetsbelastning",
                    "Forskning: heterosexuella par glider mot traditionella könsroller vid barns födelse",
                    "Konkret uppdelning är bättre än löften om 'hjälper till när du ber'",
                    "Föräldraledighetsfördelning påverkar ansvarsbalansen långsiktigt",
                    "Regelbunden omförhandling är nödvändig — livet förändras konstant"
                ],
                examples: [
                    CourseExample(
                        scenario: "Sara sköter allt planering — BVC-tider, vänners presenter, barnkläder, matinköp. Hennes partner 'hjälper till'.",
                        wrongApproach: "Fortsätta det nuvarande systemet men klaga mer.",
                        rightApproach: "Göra det osynliga arbetet synligt: skriva upp allt Sara håller i minnet och dela listan. Sedan fördela uppgifter (inte 'hjälp') — partnern äger specifika domäner fullt ut.",
                        explanation: "Att 'äga' en uppgift innebär att ha ansvaret för att komma ihåg, planera och utföra den — inte att vänta på instruktioner. Delat ägarskap eliminerar koordineringsbördan."
                    )
                ],
                exercise: CourseExercise(
                    title: "Ansvarskarta för familjen",
                    description: "Kartlägg och omfördela familjens arbetsbelastning transparent.",
                    steps: [
                        "Skriv ner ALLT ni gör för familjen under en vecka — inklusive planeringen",
                        "Markera vem som gör vad idag",
                        "Diskutera: är fördelningen rimlig? Vad tar mest energi?",
                        "Omfördela: välj 2–3 uppgifter som byter ägare",
                        "Ägarskap innebär: du tänker på det, planerar det, utför det — utan påminnelse"
                    ],
                    duration: "1 timmes gemensamt samtal"
                ),
                reflectionQuestions: [
                    "Vad bär du på som din partner inte vet om — det osynliga arbetet?",
                    "Hur hade du velat att ansvarsfördelningen såg ut — stämmer det med verkligheten?",
                    "Vad skulle du behöva lämna över för att känna dig mer balanserad?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om ansvarsdelning och mental belastning:",
                    consensus: "Det mentala lasset lyfts som det minst pratade om men tyngsta. Att namnge det förändrar dynamiken direkt. Konkret uppdelning av ägarskap — inte 'hjälp' — är nyckeln.",
                    quotes: [
                        "\"Jag lät min man se listan på allt jag håller i minnet. Han sa ingenting på länge. Sedan tog han över BVC och alla läkarbesök.\" – Mia",
                        "\"Vi delade föräldraledigheten 50/50. Det jämnade ut ansvarsfördelningen på ett sätt ingenting annat kunnat göra.\" – Andreas",
                        "\"Det är inte brist på vilja — det är osynlighet. När det osynliga görs synligt förändras allt.\" – Carolina"
                    ],
                    source: "Forskning om mental belastning, Eve Rodsky Fair Play, jämställdhetsstatistik SCB"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "lnf-4",
                title: "Socialt liv med baby",
                subtitle: "Navigera det sociala livet som ny förälder",
                icon: "person.3.fill",
                introduction: """
                Socialt isolering är en av de minst pratade om men mest genomgripande förändringarna när man blir ny förälder. Det spontana social livet försvinner nästan över en natt. Vänner utan barn förstår inte riktigt. Vänner med barn är lika utmattade. Och många nya föräldrar beskriver en djup ensamhet mitt i ett rum fyllt av kärlek.

                Att upprätthålla och bygga sociala kontakter efter barnets ankomst är inte lyx — det är en grundläggande del av mental hälsa. Och det kräver aktivt arbete, eftersom det spontana inte längre fungerar.

                I den här modulen pratar vi om hur du navigerar befintliga vänskaper, hur du hittar din nya föräldratribé och hur du sätter realistiska förväntningar på sociala aktiviteter med baby.
                """,
                keyPoints: [
                    "Social isolering drabbar 40–50 % av nya föräldrar, särskilt under föräldraledigheten",
                    "Spontaniteten försvinner — social kontakt kräver nu aktiv planering",
                    "Föräldragrupper via BVC är en av de mest effektiva motmedelerna",
                    "Vänskaper som överlever föräldraskapets första år är extra starka",
                    "Socialt stöd är dokumenterat skyddande mot PPD"
                ],
                examples: [
                    CourseExample(
                        scenario: "Marie ser sina barnfria vänner allt mer sällan sedan bebisens ankomst. De förstår inte varför hon alltid avbokar.",
                        wrongApproach: "Ge upp vänskaperna och anta att de inte kan förstå.",
                        rightApproach: "Kommunicera öppet: 'Jag saknar er jättemycket. Mitt liv ser annorlunda ut just nu. Kan vi hitta ett format som funkar — t.ex. ni kommer hem till oss på lördag förmiddag?' Möt dem halvvägs.",
                        explanation: "Många vänskaper överlever föräldraskapets omvälvning om man kommunicerar ärligt om vad som hänt och aktivt hittar nya sätt att umgås. Tystnad och uteblivande tolkas som ointresse."
                    )
                ],
                exercise: CourseExercise(
                    title: "Sociala kontakter — inventering och plan",
                    description: "Kartlägg ditt sociala nätverk och skapa en realistisk plan för att upprätthålla det.",
                    steps: [
                        "Lista dina tre viktigaste vänskaper/relationer utanför kärnfamiljen",
                        "Notera: hur länge sedan pratade ni senast? Varför?",
                        "Välj EN kontakt att återaktivera den här veckan — skicka ett enkelt meddelande",
                        "Hitta ett forum för nya föräldrarelationer: BVC-grupp, promenadgrupp, online",
                        "Boka in en social aktivitet per vecka — liten räcker (promenad, fika hemma)"
                    ],
                    duration: "Planering 20 minuter, aktivitet löpande"
                ),
                reflectionQuestions: [
                    "Hur ensam känner du dig under föräldraledigheten — är det svårare än du väntat?",
                    "Vilka vänskaper är viktigast för dig att bevara — vad gör du för dem?",
                    "Har du hittat andra föräldrar att dela erfarenheter med?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om social isolering och nya kontakter:",
                    consensus: "Den sociala isoleringen är en av de mest oväntat svåra delarna av tidig föräldraskap. BVC-gruppen lyfts konsekvent som en livlina.",
                    quotes: [
                        "\"BVC-gruppen är mina bästa vänner idag. Vi träffades i Aveny-korridoren när barnen var 3 veckor. Nu är de 3 år.\" – Sara",
                        "\"Jag förlorade tre vänner till föräldraskapets krav. Och jag fick fem nya som förstår precis.\" – Tomas",
                        "\"Den mest värdefulla saken jag gjort är promenadgruppen varje tisdag. En timme i friska luften med folk som förstår.\" – Annika"
                    ],
                    source: "Forskning om social isolering vid föräldraskap, WHO mental health guidelines"
                ),
                readingTimeMinutes: 9
            ),
            CourseModule(
                id: "lnf-5",
                title: "Tillbaka till jobbet",
                subtitle: "Omställningen som många underskattar",
                icon: "briefcase.fill",
                introduction: """
                Återgången till arbetslivet är en av de mest emotionellt laddade händelserna i det tidiga föräldraskapets landskap. För vissa är det en lättnad och ett välkommet identitetsskifte tillbaka. För andra är det en sorg — ett avsked från en intensiv tid med barnet. De flesta är en blandning.

                Praktiska utmaningar är många: logistik med dagis och schema, anpassning av arbetstider, amning/pumpning på arbetsplatsen, sjukdagar som nu innebär logistikpusslet, och att orka prestera på jobbet trots sömnbrist.

                Att förbereda sig mentalt och praktiskt — och att kommunicera öppet med arbetsgivaren om vad du behöver — gör en enorm skillnad.
                """,
                keyPoints: [
                    "Återgång till jobbet är en stor identitetsövergång — tillåt dig tid att anpassa",
                    "Planera de praktiska delarna i detalj: vem hämtar, vad händer vid sjukdom",
                    "Kommunicera med arbetsgivaren om dina behov — inklusive amning",
                    "Känslor av skuld är normala — du kan vara en god förälder OCH en god medarbetare",
                    "Gradvis återgång (deltid) minskar chocken för alla parter"
                ],
                examples: [
                    CourseExample(
                        scenario: "Anna börjar jobba igen efter 12 månaders föräldraledighet. Hon gråter varje morgon på väg till jobbet.",
                        wrongApproach: "Tro att tårarna betyder att hon gör fel val.",
                        rightApproach: "Förstå att sorg vid övergången är normalt och inte ett tecken på att dagis är fel. Tillåt sig sörja övergången OCH skapa en ny ritual på morgonen som signalerar 'vi ses ikväll' — kram, ett lösenord, ett foto.",
                        explanation: "Sorg vid återgång till jobbet är ett tecken på att det föräldraledighetsåret var värdefullt och kärleksfullt — inte att något är fel. Det klingas vanligtvis av efter 2–4 veckor."
                    )
                ],
                exercise: CourseExercise(
                    title: "Checklista för återgång till jobbet",
                    description: "Förbered återgången i god tid med praktiska och emotionella perspektiv.",
                    steps: [
                        "Logistik: schema klart, dagisinskolning bokad, sjukdomsberedskapsplan med partner",
                        "Arbetsplatskommunikation: meddela ev. behov (amning, flexibelt schema, gradvis återgång)",
                        "Avskedsritual med barnet: ett tryggt och konsekvent avsked varje morgon",
                        "Emotionell förberedelse: prata med partner om hur du tror det känns",
                        "Plan för de första veckorna: vad gör du om det är svårare än förväntat?"
                    ],
                    duration: "Förberedelse 1–2 veckor innan start"
                ),
                reflectionQuestions: [
                    "Ser du återgången till jobbet som positiv, negativ eller neutral — och varför?",
                    "Vad oroar dig mest med återgången — praktiskt eller emotionellt?",
                    "Vad behöver du från din partner och arbetsgivare för att det ska gå bra?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om återgången till jobbet:",
                    consensus: "De flesta berättar att det var svårare än väntat den första veckan och enklare än väntat den fjärde. Planering och kommunikation lyfts som det mest hjälpsamma.",
                    quotes: [
                        "\"Jag gick tillbaka på 75 % de första tre månaderna. Det var det bästa beslutet vi tagit.\" – Cecilia",
                        "\"Dagis-inskolning var hjärtskärande dag ett. Dag tio sprang han in utan att kolla om vi var kvar.\" – Martin",
                        "\"Att prata med min chef om amningspauserna tog 5 minuter och hon var helt okej med det. Jag hade oroat mig i 2 månader.\" – Linda"
                    ],
                    source: "SCB föräldraledighetsstatistik, forskning om arbetsåtergång och föräldraidentitet"
                ),
                readingTimeMinutes: 10
            ),
            CourseModule(
                id: "lnf-6",
                title: "Hitta tillbaka till sig själv",
                subtitle: "Identitet, intressen och eget utrymme",
                icon: "person.fill.viewfinder",
                introduction: """
                Föräldraskap förändrar identiteten på djupet. Många nya föräldrar beskriver en känsla av att ha 'förlorat sig själv' — att all tid, energi och uppmärksamhet gått till barnet och att den person de var före bebisen känns avlägsen.

                Att hitta tillbaka till sig själv handlar inte om att lämna föräldrarollen bakom sig — det handlar om att expandera identiteten snarare än att ersätta den. Du är fortfarande du. Du är nu också förälder. Båda kan finnas.

                Forskning visar att föräldrar som upprätthåller egna intressen och eget utrymme mår bättre, är bättre partners och faktiskt är bättre föräldrar. Att ta hand om sig själv är inte egoistiskt — det är nödvändigt.
                """,
                keyPoints: [
                    "Föräldraidentitetsomvälvning kallas 'matrescence' — en biologisk och psykologisk transformation",
                    "Att behålla egna intressen är dokumenterat skyddande för mental hälsa",
                    "Skuld vid eget utrymme är normalt — men bör inte hindra dig",
                    "Barn mår bra av att se sina föräldrar ta hand om sig själva",
                    "Börja smått: 30 minuter i veckan för något som är bara ditt"
                ],
                examples: [
                    CourseExample(
                        scenario: "David tränade regelbundet före bebisen men har inte tränat en enda gång på 10 månader. Han mår sämre men känner sig skyldig att vara hemma på fritiden.",
                        wrongApproach: "Offra träningen helt och hållet för att vara en 'bra pappa'.",
                        rightApproach: "Komma överens med partnern om 2 träningstillfällen per vecka — 45 minuter vardera. Partnern får motsvarande utrymme för något eget. Ingen behöver offra sig för att vara en bra förälder.",
                        explanation: "Forskning visar att fysisk aktivitet är en av de starkaste buffrarna mot föräldraburnout. Att ge sig själv tillstånd att träna gör David till en mer energisk och närvande pappa, inte en sämre."
                    )
                ],
                exercise: CourseExercise(
                    title: "Hitta mitt utrymme — ett experiment",
                    description: "Identifiera och inled ett återupptagande av något som är bara ditt.",
                    steps: [
                        "Lista: tre saker du gillade göra INNAN bebisen som du inte gör nu",
                        "Välj ETT och gör det under 30–60 minuter inom de närmaste 7 dagarna",
                        "Kommunicera med din partner: 'Jag behöver detta. Vad behöver du?'",
                        "Boka in det i kalendern — det som inte bokas händer inte",
                        "Reflektera efteråt: hur kändes det? Vad hände med skulden?"
                    ],
                    duration: "Planering 15 minuter, aktivitet 30–60 minuter"
                ),
                reflectionQuestions: [
                    "Vad saknar du mest från ditt liv innan föräldraskap?",
                    "Tillåter du dig själv att ha tid som är bara din — och hur känns det?",
                    "Vad vill du att ditt barn ska se när de ser dig ta hand om dig själv?"
                ],
                forumSection: CourseForumSection(
                    intro: "Om identitet och att hitta sig själv igen:",
                    consensus: "Processen att hitta sig själv igen beskrivs som aktiv, inte passiv. Det händer inte av sig självt — du måste ta steget. Men när du gör det, är det transformativt.",
                    quotes: [
                        "\"Jag tog upp löpningen när min dotter var 8 månader. Det var den dagen jag kände att jag fortfarande var jag.\" – Petra",
                        "\"Min terapeut sa: 'Du kan inte hälla ur en tom karaff.' Det förändrade hur jag tänker på att ta hand om mig.\" – Anna",
                        "\"Jag börjar måla igen — bara en timme på söndagar. Min man tar bebisen. Det är min timme och det är helig.\" – Marie"
                    ],
                    source: "Matrescence-forskning (Dr Alexandra Sacks), föräldraburnout-forskning"
                ),
                readingTimeMinutes: 10
            )
        ],
        targetAudience: "Nyblivna föräldrar",
        estimatedWeeks: 4
    )
}

// MARK: - Additional Parent Courses

extension Course {
    static let abcModellen = Course(
        id: "abc-modelen",
        title: "ABC-modellen i vardagen",
        subtitle: "Se mönstret bakom beteendet",
        description: "En praktisk kurs i beteendeanalys inspirerad av ABC-modellen och Patterson. Lär dig att beskriva vad som händer före, under och efter ett beteende så att ni kan ändra miljön istället för att fastna i konflikter.",
        icon: "rectangle.3.group.fill",
        gradient: LinearGradient(colors: [Color(hex: "2563EB"), Color(hex: "60A5FA")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "abc-1",
                title: "Antecedent, beteende, konsekvens",
                subtitle: "Gör beteendet synligt",
                icon: "chart.bar.doc.horizontal",
                introduction: """
                ABC står för Antecedent, Behavior och Consequence. Du börjar med att beskriva vad som händer precis före ett beteende, själva beteendet i konkreta ord och vad som händer direkt efteråt. Det hjälper dig att se om barnet försöker få kontakt, undvika något eller få tillgång till något.

                Poängen är inte att analysera allt i överkant utan att hitta ett tydligt mönster. När vuxna ändrar på triggern eller konsekvensen blir beteendet ofta lättare att förstå och påverka.
                """,
                keyPoints: [
                    "Antecedent = vad som händer före beteendet",
                    "Beteendet ska beskrivas konkret, inte med tolkning",
                    "Konsekvensen visar ofta vad beteendet förstärks av",
                    "Det som får effekt upprepas, även när vi inte vill det"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn skriker varje gång du stänger av paddan.",
                        wrongApproach: "Du fokuserar bara på att barnet är 'trotsigt'.",
                        rightApproach: "Du noterar att skriket alltid kommer när paddan stängs av utan förvarning. Du testar förvarning, tidsbegränsning och en tydlig övergångsritual.",
                        explanation: "När du ser antecedenten och konsekvensen kan du ändra situationen istället för att enbart reagera på utbrottet."
                    )
                ],
                exercise: CourseExercise(
                    title: "ABC-logg i tre dagar",
                    description: "Notera ett återkommande beteende och fyll i ABC-kedjan.",
                    steps: [
                        "Välj ett beteende du vill förstå bättre",
                        "Skriv ned vad som hände precis innan",
                        "Skriv ned beteendet utan värdering",
                        "Skriv ned vad som hände direkt efter",
                        "Testa en liten förändring i miljön och se vad som händer"
                    ],
                    duration: "10 minuter per observation"
                ),
                reflectionQuestions: [
                    "Vilka triggers ser du oftast i vardagen?",
                    "Vilka konsekvenser råkar du förstärka utan att vilja det?",
                    "Vilket beteende vill du förstå istället för att bara stoppa?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som arbetat med ABC-modellen beskriver ofta en aha-upplevelse:",
                    consensus: "Att skriva ned beteendet gör det mindre mystiskt och mer hanterbart.",
                    quotes: [
                        "\"Jag trodde min son var 'alltid arg'. ABC-loggen visade att han mest blev överväldigad när vi skyndade honom.\" – Lina",
                        "\"När vi såg mönstret före kvällströttheten kunde vi ändra rutinen istället för att bråka varje kväll.\" – Erik"
                    ],
                    source: "Patterson GR (1982). Coercive Family Process; modern tillämpad beteendeanalys"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let cosTryggBas = Course(
        id: "circle-of-security",
        title: "Circle of Security",
        subtitle: "Var barnets trygghet och bas",
        description: "En kurs inspirerad av Circle of Security Parenting. Du lär dig att läsa barnets behov av utforskande och närhet, så att du kan vara både trygg hamn och säker bas.",
        icon: "circle.grid.2x2.fill",
        gradient: LinearGradient(colors: [Color(hex: "0EA5E9"), Color(hex: "22C55E")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "cos-1",
                title: "Trygg bas och trygg hamn",
                subtitle: "Två jobb samtidigt",
                icon: "house.fill",
                introduction: """
                Circle of Security beskriver hur barn behöver en trygg bas att utforska ifrån och en trygg hamn att komma tillbaka till. När barnet vågar gå ut i världen och vet att du finns där, blir nyfikenheten starkare och rädslan mindre.

                Modellen hjälper föräldrar att se att barnets beteenden ofta är ett sätt att visa behov av kontakt eller stöd. Det är inte ett misslyckande när barnet söker dig igen, utan ett tecken på att anknytningen fungerar.
                """,
                keyPoints: [
                    "Utforskande behöver en trygg bas",
                    "Stress och osäkerhet behöver en trygg hamn",
                    "Barn visar behov genom beteenden, inte alltid ord",
                    "Närvaro är viktigare än perfektion"
                ],
                examples: [
                    CourseExample(
                        scenario: "På lekplatsen vill ditt barn klättra upp igen och igen men blir ledset när du går för långt bort.",
                        wrongApproach: "Du pushar barnet att vara självständigt hela tiden.",
                        rightApproach: "Du stannar nära, bekräftar modet och låter barnet komma tillbaka till dig mellan försöken.",
                        explanation: "Barn blir ofta modigare när de vet att basen finns kvar. Trygghet och självständighet går ihop."
                    )
                ],
                exercise: CourseExercise(
                    title: "Rita er säkerhetscirkel",
                    description: "Kartlägg när barnet utforskar och när hen behöver återkoppla.",
                    steps: [
                        "Rita en cirkel med barnet i mitten",
                        "Skriv vad barnet brukar utforska själv",
                        "Skriv vad som brukar få barnet att komma tillbaka",
                        "Identifiera ett ögonblick när du kan vara mer närvarande",
                        "Testa att säga mindre och vara mer tillgänglig"
                    ],
                    duration: "15 minuter"
                ),
                reflectionQuestions: [
                    "När behöver ditt barn mest stöd?",
                    "När brukar du själv bli osäker som förälder?",
                    "Hur märker barnet att du finns kvar även när det testar gränser?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som gått Circle of Security-kursen återkommer ofta till samma insikt:",
                    consensus: "Att vara tillgänglig utan att styra överallt känns lugnande både för barn och vuxna.",
                    quotes: [
                        "\"Jag slutade tolka närhet som klängighet. Det var ett stort skifte.\" – Maja",
                        "\"När jag blev mer trygg i att vara bas blev vardagen mindre dramatisk.\" – Jonas"
                    ],
                    source: "Cooper, Hoffman & Powell. Circle of Security Parenting"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let pmtoPrinciper = Course(
        id: "pmto-principer",
        title: "PMTO-principer",
        subtitle: "Positivt ledarskap utan skrik",
        description: "En kurs med kärnan från Parent Management Training Oregon: tydliga instruktioner, konsekvent uppföljning och mer förstärkning av det du vill se.",
        icon: "hand.raised.fill",
        gradient: LinearGradient(colors: [Color(hex: "F97316"), Color(hex: "FBBF24")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "pmto-1",
                title: "Tydlighet och förstärkning",
                subtitle: "Gör det enkelt att lyckas",
                icon: "megaphone.fill",
                introduction: """
                PMTO betonar att barn behöver tydliga, korta instruktioner och mycket positiv feedback för sådant som fungerar. När vuxna blir mer förutsägbara minskar behovet av att barnet gissar vad som förväntas.

                Den praktiska kärnan är att förstärka önskat beteende snabbt, konkret och ofta. Det du uppmärksammar växer. Det du gör otydligt blir svårare att följa.
                """,
                keyPoints: [
                    "Kort instruktion ger större chans till samarbete",
                    "Beröm det du vill se, direkt när det händer",
                    "Följ upp konsekvent utan att förhandla i affekt",
                    "Rutin och förutsägbarhet minskar motstånd"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet ignorerar dina tio upprepade påminnelser om att ta på skor.",
                        wrongApproach: "Du höjer rösten och ger fler ord.",
                        rightApproach: "Du går nära, säger lugnt 'Skor på nu', väntar, och ger beröm direkt när första steget tas.",
                        explanation: "Korta instruktioner och snabb förstärkning fungerar bättre än långa förklaringar när barnet redan är upptaget."
                    )
                ],
                exercise: CourseExercise(
                    title: "Beröm med precision",
                    description: "Öva på att ge konkret beröm under en dag.",
                    steps: [
                        "Välj tre beteenden du vill se mer av",
                        "Beröm med namn på beteendet, inte bara 'bra jobbat'",
                        "Ge beröm direkt när det händer",
                        "Notera om barnets samarbete förändras under dagen",
                        "Utvärdera om du behöver vara tydligare i instruktionerna"
                    ],
                    duration: "En dag"
                ),
                reflectionQuestions: [
                    "Är dina instruktioner korta nog för att kunna följas?",
                    "Vilket positivt beteende får för lite uppmärksamhet hos er?",
                    "När blir du otydlig för att slippa konflikt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som arbetat med PMTO-principer beskriver ofta en snabb effekt på vardagskaos:",
                    consensus: "När vuxna blir tydligare blir barnet mindre motsträvigt.",
                    quotes: [
                        "\"Det var inte fler regler vi behövde, utan bättre instruktioner.\" – Sara",
                        "\"När jag började berömma små steg blev morgnarna mycket mjukare.\" – Oskar"
                    ],
                    source: "Forgatch & Patterson; PMTO-programmet"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let cpsSamarbete = Course(
        id: "cps-samarbete",
        title: "CPS och svåra situationer",
        subtitle: "Lös problem tillsammans",
        description: "Ross Greens Collaborative & Proactive Solutions visar hur du kan se svåra beteenden som olösta problem och arbeta med Plan B i stället för maktkamp.",
        icon: "hands.sparkles.fill",
        gradient: LinearGradient(colors: [Color(hex: "7C3AED"), Color(hex: "A78BFA")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "cps-1",
                title: "Vad är det som är svårt?",
                subtitle: "Leta efter den osynliga färdigheten",
                icon: "brain.head.profile",
                introduction: """
                CPS utgår från att barn gör bra ifrån sig när de kan. Om de inte lyckas finns det oftast en laggande färdighet eller ett olöst problem. I stället för att utgå från vilja utgår du från färdigheter.

                Metoden hjälper föräldrar att sluta fastna i samma konflikt om och om igen. När ni hittar det underliggande problemet blir lösningen mer hållbar.
                """,
                keyPoints: [
                    "Barn gör rätt när de kan",
                    "Det bakomliggande problemet är ofta otydligt",
                    "Empatisk nyfikenhet öppnar för samarbete",
                    "Plan B skapas tillsammans, inte uppifrån"
                ],
                examples: [
                    CourseExample(
                        scenario: "Varje kväll exploderar det när tandborsten kommer fram.",
                        wrongApproach: "Du ser det som ren olydnad och skruvar upp konsekvenserna.",
                        rightApproach: "Du frågar vad som är svårt med tandborstningen och upptäcker att barnet hatar smaken. Ni provar annan tandkräm och en förvarning.",
                        explanation: "När du ser problemet genom barnets ögon blir lösningen ofta enkel och relationen mindre laddad."
                    )
                ],
                exercise: CourseExercise(
                    title: "Plan B-samtal",
                    description: "Välj en återkommande konflikt och prata igenom den i lugn tid.",
                    steps: [
                        "Beskriv problemet utan skuld",
                        "Fråga barnet vad som är svårt",
                        "Berätta vad som är viktigt för dig",
                        "Hitta en lösning tillsammans",
                        "Testa planen i några dagar och utvärdera"
                    ],
                    duration: "20 minuter"
                ),
                reflectionQuestions: [
                    "Vilken konflikt återkommer mest hos er?",
                    "Vad är svårt för barnet som du kanske inte har sett?",
                    "Hur låter det när du pratar om problemet utan skuld?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som provat CPS beskriver ofta att tonen förändras direkt:",
                    consensus: "Samarbete fungerar bättre än att vinna.",
                    quotes: [
                        "\"När vi slutade tala om 'trots' blev samtalen mycket bättre.\" – Elin",
                        "\"Plan B tog bort en stor del av dagliga maktkamperna.\" – Viktor"
                    ],
                    source: "Ross W. Greene, The Explosive Child; CPS-modellen"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let emotionCoaching = Course(
        id: "emotion-coaching",
        title: "Emotion coaching",
        subtitle: "Validera känslor och sätt gränser",
        description: "En kurs inspirerad av Gottmans emotion coaching: se känslan, sätt ord på den och hjälp barnet vidare utan att skämmas bort från gränser.",
        icon: "heart.text.square.fill",
        gradient: LinearGradient(colors: [Color(hex: "DB2777"), Color(hex: "F472B6")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "ec-1",
                title: "Säg vad du ser",
                subtitle: "Känslor tål att nämnas",
                icon: "text.bubble.fill",
                introduction: """
                Emotion coaching handlar om att lägga märke till barnets känsla, sätta ord på den och visa att den går att bära. Det betyder inte att alla beteenden tillåts, men att känslan inte avvisas.

                När barnet känner sig sett blir det lättare att återvända till lugn. Validering är inte samma sak som att hålla med. Det är att säga: jag ser dig, och jag hjälper dig igenom detta.
                """,
                keyPoints: [
                    "Namnge känslan",
                    "Validera utan att ge upp gränsen",
                    "Hjälp barnet tillbaka till kroppsligt lugn",
                    "Lös först när barnet kan lyssna"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet kastar sig på golvet när du säger nej till en extra glass.",
                        wrongApproach: "Du säger 'sluta överdriv' och går därifrån.",
                        rightApproach: "Du säger 'du är jättebesviken, jag hör det. Glass är slut i dag. Vi kan välja frukt eller yoghurt.'",
                        explanation: "Känslan kan vara stor även när gränsen står fast. Det lugnar ofta barnet snabbare än att argumentera."
                    )
                ],
                exercise: CourseExercise(
                    title: "Tre steg i känslomötet",
                    description: "Öva på att svara på känsla innan du löser beteende.",
                    steps: [
                        "Beskriv känslan du ser",
                        "Bekräfta att känslan får finnas",
                        "Håll gränsen och erbjud nästa steg",
                        "Öva samma fras flera gånger",
                        "Utvärdera om barnet lugnar sig snabbare"
                    ],
                    duration: "5 minuter per tillfälle"
                ),
                reflectionQuestions: [
                    "Vilka känslor har du svårast att tåla hos ditt barn?",
                    "Hur låter du när du validerar i stället för att förminska?",
                    "Var går din gräns även när känslan är stor?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta emotion coaching som mindre dramatik och mer kontakt:",
                    consensus: "Att först bekräfta känslan gör gränser lättare att acceptera.",
                    quotes: [
                        "\"Jag trodde jag behövde lösa allt direkt. Att bara sätta ord på känslan gjorde enorm skillnad.\" – Hanna",
                        "\"Det blev mycket mindre skam när jag slutade säga 'det där är väl inget'.\" – Fredrik"
                    ],
                    source: "John Gottman & Joan DeClaire, The Heart of Parenting"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let coreglering = Course(
        id: "coreglering",
        title: "Co-reglering",
        subtitle: "Låna ditt lugn till barnet",
        description: "En kurs om hur vuxnas nervsystem hjälper barnets nervsystem att hitta tillbaka till balans. Bygger på co-regulation, affektreglering och trygg närvaro.",
        icon: "leaf.fill",
        gradient: LinearGradient(colors: [Color(hex: "0F766E"), Color(hex: "5EEAD4")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "cr-1",
                title: "När lugn smittar",
                subtitle: "Reglera först, prata sen",
                icon: "wind",
                introduction: """
                Co-reglering handlar om att ditt lugn kan lånas av barnet när det egna systemet går upp i varv. Små barn kan sällan reglera stark stress själva och behöver en vuxen som hjälper kroppen att hitta ner igen.

                Det betyder att tonfall, tempo, ansiktsuttryck och kroppshållning är minst lika viktiga som orden du använder. När du sänker ditt tempo ger du barnet en chans att följa med.
                """,
                keyPoints: [
                    "Barn behöver ofta först yttre reglering, sedan inre",
                    "Kort och lugnt språk hjälper mer än många ord",
                    "Din kropp signalerar säkerhet",
                    "Fysisk närhet är ofta första steget"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet skriker i affären och går inte att nå.",
                        wrongApproach: "Du pratar snabbt och högt om varför det måste sluta.",
                        rightApproach: "Du sänker rösten, håller barnet nära och säger kort vad som händer härnäst: 'Jag är här. Vi går ut en stund.'",
                        explanation: "När vuxenregleringen kommer först blir det lättare för barnet att följa med kroppen, inte bara orden."
                    )
                ],
                exercise: CourseExercise(
                    title: "Din lugn-rutin",
                    description: "Bygg en kort ordning du använder när barnet spårar ur.",
                    steps: [
                        "Andas ut längre än du andas in",
                        "Sänk axlar och röst",
                        "Kom nära utan att ta över",
                        "Säg en kort trygg fras",
                        "Upprepa samma sekvens nästa gång"
                    ],
                    duration: "2 minuter"
                ),
                reflectionQuestions: [
                    "Vad händer i din egen kropp när barnet blir överväldigat?",
                    "Vilken fras hjälper dig att hålla dig lugn?",
                    "Hur ser du när barnet börjar reglera ner?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta att deras egna andning blev startpunkten för lugnare konflikter:",
                    consensus: "Barn smittas av vuxnas tempo lika mycket som av deras ord.",
                    quotes: [
                        "\"När jag började prata långsammare blev allting mindre farligt.\" – Amanda",
                        "\"Jag behövde reglera mig själv innan jag kunde hjälpa mitt barn.\" – David"
                    ],
                    source: "Polyvagal teori, affektreglering och modern utvecklingspsykologi"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let autonomistod = Course(
        id: "autonomy-support",
        title: "Autonomistödjande föräldraskap",
        subtitle: "Stöd utan att styra sönder",
        description: "En kurs inspirerad av Self-Determination Theory. Lär dig att ge val inom ramar, minska kontrollspråk och bygga barns egen motivation.",
        icon: "hand.raised.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "06B6D4"), Color(hex: "67E8F9")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "as-1",
                title: "Val inom ramar",
                subtitle: "Autonomi behöver struktur",
                icon: "slider.horizontal.3",
                introduction: """
                Autonomistödjande föräldraskap betyder inte att barnet får bestämma allt. Det betyder att du erbjuder tydliga ramar och ger val där val faktiskt är möjliga. Barn samarbetar ofta bättre när de upplever viss kontroll.

                Självbestämmandeteorin lyfter tre behov: autonomi, kompetens och tillhörighet. När du stödjer alla tre blir motivationen mer hållbar än när du bara pressar fram lydnad.
                """,
                keyPoints: [
                    "Val inom ramar bygger motivation",
                    "Kontrollspråk skapar ofta mer motstånd",
                    "Bekräfta barnets perspektiv innan du styr vidare",
                    "Kompetens växer när barnet får lyckas själv"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet vägrar ta på ytterkläderna.",
                        wrongApproach: "Du säger att det är din order och att barnet måste lyda.",
                        rightApproach: "Du säger: 'Vill du ta jackan först eller mössan först?' och hjälper sedan vidare inom den ram som finns.",
                        explanation: "När barnet får ett verkligt val minskar känslan av att bli överkörd, samtidigt som vuxenriktningen finns kvar."
                    )
                ],
                exercise: CourseExercise(
                    title: "Byt ut kontrollspråk",
                    description: "Öva på att göra om tre vardagsfraser till autonomistödjande versioner.",
                    steps: [
                        "Skriv ner tre saker du ofta säger",
                        "Gör dem kortare och mindre kontrollerande",
                        "Lägg till ett val där det är möjligt",
                        "Testa dem samma dag",
                        "Notera om motståndet minskar"
                    ],
                    duration: "10 minuter"
                ),
                reflectionQuestions: [
                    "Var använder du kontrollspråk oftare än du tror?",
                    "Vilka val kan barnet faktiskt få?",
                    "Hur märker du att barnet känner mer kompetens?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som tränar autonomistöd beskriver ofta mindre kamp och mer samarbete:",
                    consensus: "Små val ger ofta stor effekt.",
                    quotes: [
                        "\"När jag slutade kommandera och började erbjuda val blev mornarna lugnare.\" – Sofia",
                        "\"Barnet ville bidra när vi lät honom välja mellan två rimliga alternativ.\" – Amir"
                    ],
                    source: "Deci & Ryan; Self-Determination Theory"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let temperamentGoodFit = Course(
        id: "temperament-good-fit",
        title: "Temperament och good fit",
        subtitle: "Rätt matchning slår rätt mall",
        description: "En kurs om barns temperament, från Thomas och Chess till goodness of fit. När du ser barnets personlighet tydligare blir det lättare att anpassa miljön i stället för att försöka göra alla likadana.",
        icon: "person.fill.badge.plus",
        gradient: LinearGradient(colors: [Color(hex: "8B5CF6"), Color(hex: "C4B5FD")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "tf-1",
                title: "Vad är temperament?",
                subtitle: "Barn är olika från början",
                icon: "person.2.fill",
                introduction: """
                Temperament handlar om hur barnet reagerar, inte om hur bra eller dåligt barnet är. Vissa barn är snabbt varma, andra behöver längre tid. Vissa är intensiva, andra lågmälda. Good fit uppstår när den vuxna anpassar sitt bemötande efter barnets stil.

                När du slutar se temperament som ett problem och börjar se det som information blir mycket lättare begripligt. Barnet är inte felstavat, bara annorlunda.
                """,
                keyPoints: [
                    "Temperament är ett mönster av reaktioner",
                    "Good fit betyder att miljö och barn passar bättre ihop",
                    "Samma strategi passar inte alla barn",
                    "Anpassning minskar onödiga konflikter"
                ],
                examples: [
                    CourseExample(
                        scenario: "Ditt barn hatar övergångar och blir alltid upprört när ni ska gå hem från lekplatsen.",
                        wrongApproach: "Du försöker träna bort känsligheten genom att skynda på ännu mer.",
                        rightApproach: "Du ger varning i god tid, använder samma avskedsritual och låter övergången ta lite längre tid.",
                        explanation: "Ett barn med långsam uppvärmning behöver mer förutsägbarhet, inte mer press."
                    )
                ],
                exercise: CourseExercise(
                    title: "Temperamentprofil",
                    description: "Beskriv ditt barns temperament med tre ord och anpassa en situation därefter.",
                    steps: [
                        "Välj tre ord som beskriver barnet",
                        "Beskriv en situation som blir svår",
                        "Anpassa miljön eller tajmingen till barnets stil",
                        "Testa förändringen i några dagar",
                        "Notera vad som blev lättare"
                    ],
                    duration: "15 minuter"
                ),
                reflectionQuestions: [
                    "Vilken typ av temperament har ditt barn?",
                    "Vilka situationer missar ofta din anpassning?",
                    "Vad skulle vara en bättre 'good fit' i vardagen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta lättnad när temperament ses som en styrka och inte ett fel:",
                    consensus: "När man möter barnets stil i stället för att kämpa mot den blir vardagen mjukare.",
                    quotes: [
                        "\"Det var skönt att sluta tänka att min dotter var 'svår'. Hon behöver bara mer förutsägbarhet.\" – Anna",
                        "\"När vi anpassade tempot blev konflikterna färre direkt.\" – Johan"
                    ],
                    source: "Thomas & Chess; temperamentforskning"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let sprakbad = Course(
        id: "sprakbad",
        title: "Språkbad i vardagen",
        subtitle: "Prata, läsa, sjunga och peka",
        description: "En kurs om språkets vardagskraft. Bygger på serve-and-return, högläsning och små samtal som gör stor skillnad för barns språk och hjärnans utveckling.",
        icon: "text.book.closed.fill",
        gradient: LinearGradient(colors: [Color(hex: "14B8A6"), Color(hex: "99F6E4")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "sl-1",
                title: "Språk finns överallt",
                subtitle: "Ord + rytm + blick",
                icon: "quote.bubble.fill",
                introduction: """
                Barn lär sig språk genom upprepning, respons och meningsfull kontakt. Det viktigaste är inte avancerade ord utan att du sätter ord på det ni redan gör tillsammans. Språket blir starkast när det används i vardagen.

                Högläsning, sång och vardagssnack är alla delar av samma språkbad. Ju fler gånger barnet hör ord i meningsfulla sammanhang, desto lättare blir det att förstå och senare använda dem själv.
                """,
                keyPoints: [
                    "Prata om det du gör",
                    "Följ barnets fokus och bygg vidare",
                    "Läs högt varje dag",
                    "Sång och rim stärker språkmelodin"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet pekar på en bil i stället för att använda ord.",
                        wrongApproach: "Du ber barnet säga hela ordet rätt direkt.",
                        rightApproach: "Du svarar: 'Ja, det är en bil! En röd bil.' och väntar på nästa interaktion.",
                        explanation: "Språk växer av respons och expansion, inte av press."
                    )
                ],
                exercise: CourseExercise(
                    title: "10 minuter språkbad",
                    description: "Gör en kort språkrutin varje dag i en vecka.",
                    steps: [
                        "Välj en vardagssituation",
                        "Berätta högt vad som händer",
                        "Stanna upp och vänta på barnets respons",
                        "Läs en kort bok eller sjung en sång",
                        "Utvärdera vilka stunder som fungerade bäst"
                    ],
                    duration: "10 minuter per dag"
                ),
                reflectionQuestions: [
                    "Vilka stunder pratar ni mest i vardagen?",
                    "Hur ofta läser du högt utan att skynda igenom det?",
                    "Var kan du lägga in mer rytm och respons?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar märker ofta hur små språkvanor blir stora över tid:",
                    consensus: "Barnet behöver inte flashiga aktiviteter, utan fler små språkstunder.",
                    quotes: [
                        "\"När vi började kommentera allt i vardagen kom orden snabbare.\" – Ingrid",
                        "\"Högläsningen före läggdags blev vår bästa rutin.\" – Simon"
                    ],
                    source: "Center on the Developing Child; Hart & Risley; högläsningsforskning"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let lekOchScaffolding = Course(
        id: "lek-scaffolding",
        title: "Lek och scaffolding",
        subtitle: "Stötta utan att ta över",
        description: "En kurs om Vygotskij, närmaste utvecklingszonen och hur lek kan bli lärande när du hjälper lagom mycket i stället för för mycket.",
        icon: "figure.and.child.holdinghands",
        gradient: LinearGradient(colors: [Color(hex: "F59E0B"), Color(hex: "FCD34D")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "ls-1",
                title: "Lagom svårt",
                subtitle: "Zonen där lärande händer",
                icon: "puzzlepiece.extension",
                introduction: """
                Scaffolding betyder att du ger precis lagom mycket stöd för att barnet ska kunna ta nästa steg. Om du gör för mycket lär sig barnet mindre. Om du gör för lite blir barnet frustrerat. Den rätta nivån finns någonstans mitt emellan.

                Lek är den plats där scaffolding blir naturligt. Genom att följa barnets idéer och lägga till ett litet steg hjälper du utvecklingen utan att ta över kontrollen.
                """,
                keyPoints: [
                    "Hjälp ska vara temporär",
                    "Nästa steg ska vara möjligt men inte för lätt",
                    "Frågor kan bromsa lek, kommentarer kan stötta",
                    "Barn lär sig bäst när de är engagerade"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet försöker bygga ett torn men blir argt när det rasar.",
                        wrongApproach: "Du bygger klart tornet åt barnet.",
                        rightApproach: "Du säger 'vill du ha en bredare botten?' och låter barnet prova igen med lite stöd.",
                        explanation: "Scaffolding hjälper barnet att lyckas själv. Det känns bättre än att bli hjälpt bort från utmaningen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Fem minuters lekstöd",
                    description: "Öva på att stötta utan att styra över leken.",
                    steps: [
                        "Välj en lek barnet redan gör",
                        "Följ barnets initiativ utan att ta över",
                        "Lägg till ett litet utmanande steg",
                        "Kommentera vad barnet gör",
                        "Lämna tillbaka kontrollen till barnet"
                    ],
                    duration: "5 minuter"
                ),
                reflectionQuestions: [
                    "När tar du över för snabbt?",
                    "Hur ser du att barnet är nära nästa utvecklingssteg?",
                    "Vad blir lättare när du följer barnets idéer?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver lek som roligare när de inte försöker leda varje minut:",
                    consensus: "Barn behöver stöd, inte regissering.",
                    quotes: [
                        "\"När jag slutade styra leken blev min dotter mer kreativ direkt.\" – Petra",
                        "\"Att bara kommentera och lägga till ett steg gjorde stor skillnad.\" – Marcus"
                    ],
                    source: "Vygotskij, Wood/Bruner/Ross och scaffolding-litteraturen"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let syskonRelationer = Course(
        id: "syskon-relationer",
        title: "Syskonrelationer utan jämförelse",
        subtitle: "Minska rivalitet och öka allians",
        description: "En kurs om syskonsjalusi, rättvisa och hur du hjälper barn att vara olika utan att göra varje konflikt till ett mått på din föräldraskap.",
        icon: "person.2.fill",
        gradient: LinearGradient(colors: [Color(hex: "EC4899"), Color(hex: "F9A8D4")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "sr-1",
                title: "Rivalitet är inte misslyckande",
                subtitle: "Det betyder att syskonen märker varandra",
                icon: "arrow.triangle.branch",
                introduction: """
                Syskonrelationer är ofta både kärleksfulla och konfliktfyllda. Rivalitet betyder inte att något är fel. Det betyder att barnen delar på viktiga resurser som uppmärksamhet, tid och plats i familjen.

                När du slutar kräva att syskon alltid ska vara snälla lär du dig i stället att coacha reparation, gränser och respekt. Det är mer realistiskt och mer hjälpsamt.
                """,
                keyPoints: [
                    "Jämförelser skapar mer friktion",
                    "Särskild tid med varje barn minskar konkurrens",
                    "Reparation är viktigare än perfekt harmoni",
                    "Alla syskon behöver inte vara lika nära"
                ],
                examples: [
                    CourseExample(
                        scenario: "Storasyrran säger att bebisen får all uppmärksamhet.",
                        wrongApproach: "Du förklarar att hon är stor och borde förstå bättre.",
                        rightApproach: "Du bekräftar känslan, visar särskild tid med henne och hjälper henne hitta ett sätt att vara delaktig utan att konkurrera.",
                        explanation: "Känslan av orättvisa blir mindre när barnet får egen plats, inte bara förklaringar."
                    )
                ],
                exercise: CourseExercise(
                    title: "Enskild tid",
                    description: "Boka en liten stund med varje barn utan syskonen.",
                    steps: [
                        "Välj 10–15 minuter per barn",
                        "Låt barnet styra aktivitetens innehåll",
                        "Undvik att undervisa eller rätta",
                        "Spegel barnet i ord och uppmärksamhet",
                        "Upprepa några gånger i veckan"
                    ],
                    duration: "10–15 minuter per barn"
                ),
                reflectionQuestions: [
                    "Var jämför du syskonen mest?",
                    "Hur kan du ge varje barn egen tid?",
                    "Vad behöver barnen öva på i relationen till varandra?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar upptäcker ofta att syskonbråk minskar när varje barn får sin egen plats:",
                    consensus: "Jämförelser gör nästan alltid mer skada än nytta.",
                    quotes: [
                        "\"När jag slutade säga 'se på din bror' blev konflikterna mindre.\" – Cecilia",
                        "\"En egen liten stund med varje barn förändrade hela dynamiken hemma.\" – Henrik"
                    ],
                    source: "Faber & Mazlish, Siblings Without Rivalry"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let skarmPlan = Course(
        id: "skarmplan",
        title: "Skärmplan för familjen",
        subtitle: "Regler som går att hålla",
        description: "En kurs som hjälper er skapa en familjemediepakt: tydliga ramar, mindre konflikter och mer medvetna val kring skärmar i vardagen.",
        icon: "tv.fill",
        gradient: LinearGradient(colors: [Color(hex: "334155"), Color(hex: "94A3B8")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "sp-1",
                title: "Gemensamma regler",
                subtitle: "En plan som alla kan följa",
                icon: "doc.text.fill",
                introduction: """
                En fungerande skärmplan är enkel, tydlig och konsekvent. Den berättar när, var och hur skärmar används i familjen. När ramarna är tydliga behöver du inte förhandla om samma sak varje dag.

                Målet är inte noll skärm för alltid. Målet är att skärmanvändningen inte styr familjens rytm eller relationerna runt bord och läggdags.
                """,
                keyPoints: [
                    "Inga skärmar vid måltider",
                    "Ingen skärm nära läggdags",
                    "Titta tillsammans när det går",
                    "Konsekvens minskar konflikter"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet vill ha paddan varje gång det blir tråkigt.",
                        wrongApproach: "Du ger efter ibland och säger nej ibland.",
                        rightApproach: "Du har en tydlig regel för när skärm erbjuds och håller den konsekvent, samtidigt som du erbjuder annat som också fungerar.",
                        explanation: "Förutsägbarhet gör att barnet lättare accepterar gränsen. Blandade signaler leder ofta till mer tjat."
                    )
                ],
                exercise: CourseExercise(
                    title: "Familjens medieplan",
                    description: "Skriv ned er egen plan för skärmvanor hemma.",
                    steps: [
                        "Bestäm var skärmar inte får användas",
                        "Bestäm när skärmen stängs av för kvällen",
                        "Skriv en regel för vuxnas telefonanvändning",
                        "Välj ett undantag som faktiskt är rimligt",
                        "Sätt upp planen där alla ser den"
                    ],
                    duration: "20 minuter"
                ),
                reflectionQuestions: [
                    "Var skapar skärmar mest konflikt hos er?",
                    "Vilken regel skulle göra störst skillnad direkt?",
                    "Följer vuxna samma plan som barnen?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som gjort en skärmplan beskriver ofta att tjatet minskade snabbt:",
                    consensus: "Det är lättare att hålla en regel som är bestämd i förväg.",
                    quotes: [
                        "\"När planen sattes upp blev det plötsligt inte förhandlingsbart varje kväll.\" – Therese",
                        "\"Vi började faktiskt prata mer när vi slutade ha tv:n på i bakgrunden.\" – Patrik"
                    ],
                    source: "AAP Family Media Plan; WHO under-5 media guidance"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let satterDOR = Course(
        id: "satter-dor",
        title: "DOR vid måltider",
        subtitle: "Du bestämmer ramarna, barnet innehållet",
        description: "En kurs byggd på Ellyn Satters Division of Responsibility. När du slutar trycka på och börjar lita på aptit och rytm blir måltider ofta lugnare.",
        icon: "fork.knife.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "16A34A"), Color(hex: "86EFAC")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "dor-1",
                title: "Vem ansvarar för vad?",
                subtitle: "Ramen är ditt jobb",
                icon: "list.bullet.rectangle",
                introduction: """
                Division of Responsibility är enkel: den vuxna bestämmer vad som serveras, när det serveras och var det äts. Barnet bestämmer om det vill äta och hur mycket. Det låter lättare än det känns, men det är en av de mest kraftfulla förändringarna i matbordsklimatet.

                När ansvarsfördelningen blir tydlig minskar behovet av tjat, lock och mutor. Barnet får möjlighet att lyssna till sin egen hunger och mättnad i stället för att reagera på press.
                """,
                keyPoints: [
                    "Vuxen = vad, när, var",
                    "Barn = om och hur mycket",
                    "Press ökar ofta motstånd",
                    "Regelbunden struktur hjälper aptiten"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet äter bara två ärtor och du blir orolig.",
                        wrongApproach: "Du försöker få barnet att äta mer genom att kommentera varje tugga.",
                        rightApproach: "Du serverar maten utan press och låter barnet avgöra mängden. Nästa måltid kommer i sin tid.",
                        explanation: "Barn lär sig bäst när måltiden inte blir en maktkamp. Aptiten kommer och går över dagen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Bygg måltidsramen",
                    description: "Skapa en förutsägbar måltidsstruktur för en vecka.",
                    steps: [
                        "Bestäm ungefärliga måltids- och mellanmålstider",
                        "Servera samma typ av struktur varje dag",
                        "Lägg till minst en sak barnet brukar acceptera",
                        "Undvik att kommentera mängden barnet äter",
                        "Observera om samtalet vid bordet förändras"
                    ],
                    duration: "En vecka"
                ),
                reflectionQuestions: [
                    "Hur ofta kommenterar du hur mycket barnet äter?",
                    "Vad händer när du inte försöker styra tuggorna?",
                    "Hur tydlig är er måltidsstruktur idag?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta DOR som en lättnad efter år av matstress:",
                    consensus: "Mindre press gav ofta mer matglädje.",
                    quotes: [
                        "\"När jag slutade jaga varje tugga åt han faktiskt bättre.\" – Karin",
                        "\"Sällan har något känts så enkelt i teorin och så svårt i praktiken. Men det fungerar.\" – Markus"
                    ],
                    source: "Ellyn Satter, Division of Responsibility"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let responsiveFeeding = Course(
        id: "responsive-feeding",
        title: "Responsive feeding",
        subtitle: "Se hunger, mättnad och tempo",
        description: "En kurs om att mata med lyhördhet. Du lär dig se när barnet vill ha mer, när det är klart och hur matningen kan bli lugnare oavsett om det gäller bröst, flaska eller vanlig mat.",
        icon: "drop.circle.fill",
        gradient: LinearGradient(colors: [Color(hex: "0284C7"), Color(hex: "7DD3FC")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "rf-1",
                title: "Barnets signaler",
                subtitle: "Lyssna på kroppen, inte på tallriken",
                icon: "eye.fill",
                introduction: """
                Responsive feeding innebär att du svarar på barnets hunger- och mättnadssignaler och inte pressar när signalerna säger stopp. Det är särskilt viktigt i början av matresan, när barnet fortfarande lär sig att äta och reglera sitt tempo.

                När vuxna följer signalerna blir måltiderna ofta mindre konfliktfyllda och barnet bygger bättre förtroende för mat och kropp.
                """,
                keyPoints: [
                    "Hunger kommer före gråt",
                    "Mättnad kan se ut som att barnet vänder bort huvudet",
                    "Tempo är viktigare än mängd i början",
                    "Press stör ofta barnets egen reglering"
                ],
                examples: [
                    CourseExample(
                        scenario: "Bebisen vänder bort huvudet efter några skedar.",
                        wrongApproach: "Du fortsätter mata ändå för att få i lite mer.",
                        rightApproach: "Du slutar när barnet signalerar mättnad och erbjuder igen vid nästa måltid.",
                        explanation: "Respekt för mättnad hjälper barnet att lita på sin egen kropp."
                    )
                ],
                exercise: CourseExercise(
                    title: "Cue-logg",
                    description: "Notera hunger- och mättnadssignaler under två dagar.",
                    steps: [
                        "Skriv ned hur hunger ser ut hos ditt barn",
                        "Skriv ned hur mättnad ser ut",
                        "Notera hur snabbt barnet äter när det är hungrigt",
                        "Prova att pausa en gång mitt i måltiden",
                        "Utvärdera om barnet visar tydligare signaler"
                    ],
                    duration: "2 dagar"
                ),
                reflectionQuestions: [
                    "Vilka signaler missar du lätt?",
                    "Hur kan du mata långsammare utan att bli orolig?",
                    "Vad händer när du slutar övertala barnet?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar brukar beskriva att matningen blir lugnare när de släpper kontrollen över mängden:",
                    consensus: "Barnets tempo är ofta den bästa guiden.",
                    quotes: [
                        "\"När jag slutade stressa över mängden blev vår lilla mycket tryggare kring mat.\" – Nina",
                        "\"Paced bottle feeding räddade vårt amnings/fla ske-pussel.\" – Joel"
                    ],
                    source: "WHO responsive feeding guidance; pediatrisk näringslära"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let pottraningMognad = Course(
        id: "pottraning-mognad",
        title: "Potträning vid rätt tid",
        subtitle: "Mognad först, metod sen",
        description: "En kurs om potträning som börjar med readiness och slutar med mindre drama. Fokuset ligger på att vänta in mognad och hålla processen positiv.",
        icon: "toilet.fill",
        gradient: LinearGradient(colors: [Color(hex: "14B8A6"), Color(hex: "A7F3D0")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "pt-1",
                title: "Redo eller inte?",
                subtitle: "Mognadstecken före kalender",
                icon: "checkmark.seal.fill",
                introduction: """
                Potträning fungerar bäst när barnet visar tydliga mognadstecken: intresse, förmåga att sitta still korta stunder, att märka när blöjan är blöt och att kunna förstå enkla instruktioner. Ålder hjälper som riktmärke, men mognad är viktigare.

                När du väntar in barnet blir processen ofta kortare och mer positiv. För tidig start leder ofta bara till motstånd och extra tvätt.
                """,
                keyPoints: [
                    "Intresse är viktigt",
                    "Barnet behöver kunna kommunicera något om kiss/bajs",
                    "Konsekvens är bättre än press",
                    "Olyckor hör till"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du börjar potträna för att barnet snart ska börja förskolan.",
                        wrongApproach: "Du kör på trots att barnet verkar ointresserat och upprört.",
                        rightApproach: "Du väntar in mognad och gör potta till något neutralt och tryggt först.",
                        explanation: "Stress och tidskrav gör ofta processen sämre. Mognad är en bättre startpunkt än önsketänkande."
                    )
                ],
                exercise: CourseExercise(
                    title: "Readiness-checklista",
                    description: "Gå igenom barnets mognad innan ni startar.",
                    steps: [
                        "Skriv ned minst tre mognadstecken",
                        "Bestäm en lugn startperiod",
                        "Låt barnet bekanta sig med pottan utan krav",
                        "Beröm nyfikenhet, inte resultat",
                        "Acceptera att olyckor är en del av lärandet"
                    ],
                    duration: "15 minuter"
                ),
                reflectionQuestions: [
                    "Är det du eller barnet som är mest redo?",
                    "Vilka mognadstecken ser du redan?",
                    "Hur kan ni göra pottan tryggare och mindre laddad?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som väntat in mognad beskriver ofta att det gick snabbare när de väl började:",
                    consensus: "Rätt timing slog nästan alltid snabbhet.",
                    quotes: [
                        "\"Vi väntade några månader extra och det blev mycket enklare.\" – Sara",
                        "\"När vi tog bort pressen gick det från kaos till att faktiskt fungera.\" – Olof"
                    ],
                    source: "Brazelton potty training research; AAP guidance"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let kvallsrutin = Course(
        id: "kvallsrutin",
        title: "Kvällsrutin som håller",
        subtitle: "Bygg en kväll som signalerar sömn",
        description: "En kurs om att skapa en lugn, repeterbar kvällssekvens som hjälper barnets kropp att förstå att sömn är på väg.",
        icon: "moon.stars.fill",
        gradient: LinearGradient(colors: [Color(hex: "4338CA"), Color(hex: "818CF8")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "kr-1",
                title: "Samma ordning varje kväll",
                subtitle: "Förutsägbarhet sänker motstånd",
                icon: "clock.fill",
                introduction: """
                En bra kvällsrutin är kort, lugn och görs i samma ordning nästan varje kväll. Barnets hjärna älskar förutsägbarhet. När kvällen följer samma mönster blir övergången till sömn mindre dramatisk.

                Målet är inte perfektion utan en återkommande signal om att dagen är slut. Det är ofta sekvensen, inte de enskilda aktiviteterna, som hjälper mest.
                """,
                keyPoints: [
                    "Kort rutin slår lång rutin",
                    "Låg stimulans före läggdags hjälper",
                    "Samma ord och samma ordning bygger trygghet",
                    "Rutinen avslutas i sängen eller sovplatsen"
                ],
                examples: [
                    CourseExample(
                        scenario: "Barnet vill ha 'bara en till' i en evig kedja av önskemål vid läggning.",
                        wrongApproach: "Du förhandlar länge och ändrar rutinen varje kväll.",
                        rightApproach: "Du håller rutinen kort, upprepar samma avslutningsfras och leder tillbaka till sängen lugnt och konsekvent.",
                        explanation: "Barn testar ofta gränser vid läggning. En konsekvent rutin minskar förhandlingarna över tid."
                    )
                ],
                exercise: CourseExercise(
                    title: "Designa er 15-minutersrutin",
                    description: "Sätt ihop en kvällssekvens som ni kan upprepa.",
                    steps: [
                        "Välj tre eller fyra steg",
                        "Bestäm en fast avslutningsfras",
                        "Håll ljus och ljud dämpade",
                        "Öva samma ordning i en vecka",
                        "Justera endast om något verkligen inte fungerar"
                    ],
                    duration: "15 minuter"
                ),
                reflectionQuestions: [
                    "Vilken del av läggningen skapar mest motstånd?",
                    "Hur lång är er rutin egentligen?",
                    "Vad skulle hända om ni gjorde färre saker men varje kväll likadant?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta att kvällsrutinen blev lättare först när de kortade den:",
                    consensus: "Kort, lugn och konsekvent slår ofta varierad och lång.",
                    quotes: [
                        "\"När vi skippade två steg och höll samma ordning somnade hon snabbare.\" – Jenny",
                        "\"Rutinen blev vårt ankare när allt annat var kaos.\" – Magnus"
                    ],
                    source: "Mindell bedtime routine research; sömnmedicin"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let coParentingMentalLoad = Course(
        id: "co-parenting-mental-load",
        title: "Co-parenting och mentala lasset",
        subtitle: "Gör ansvar synligt och delbart",
        description: "En kurs om att dela på det som syns och det som bara finns i huvudet. Inspirerad av mental load-forskning och moderna verktyg för rättvist familjearbete.",
        icon: "square.grid.2x2.fill",
        gradient: LinearGradient(colors: [Color(hex: "64748B"), Color(hex: "CBD5E1")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "cp-1",
                title: "Synligt, osynligt och ägande",
                subtitle: "Det handlar om mer än uppgifter",
                icon: "list.bullet.clipboard.fill",
                introduction: """
                Det mentala lasset är allt det du måste komma ihåg, planera och följa upp för att familjelivet ska fungera. Det är lätt att se blöjbyten och diskmaskiner men svårare att se den ständiga koordineringen runt BVC, kläder, presenter och tider.

                Co-parenting blir bättre när ni gör ansvar till ägarskap. Då räcker det inte att någon 'hjälper till'; någon behöver faktiskt äga en domän från början till slut.
                """,
                keyPoints: [
                    "Ägarskap är mer än att hjälpa",
                    "Det osynliga arbetet måste bli synligt",
                    "Veckovisa check-ins minskar missförstånd",
                    "Tydliga överlämningar skapar mindre friktion"
                ],
                examples: [
                    CourseExample(
                        scenario: "En förälder har huvudansvar för allt som gäller BVC medan den andra bara följer med ibland.",
                        wrongApproach: "Ni fortsätter som vanligt och hoppas att belastningen jämnar ut sig.",
                        rightApproach: "Ni skriver ned hela BVC-domänen och fördelar ägarskap tydligt, inklusive tider, frågor och uppföljning.",
                        explanation: "När ansvar blir synligt blir det också möjligt att fördela rättvist."
                    )
                ],
                exercise: CourseExercise(
                    title: "Ansvarskarta",
                    description: "Kartlägg allt som ingår i ett familjeområde och fördela det fullt ut.",
                    steps: [
                        "Välj ett område i familjelivet",
                        "Skriv ned alla små steg som ingår",
                        "Markera vem som äger vad idag",
                        "Flytta över ett helt område till den andra vuxna",
                        "Ha en kort avstämning efter en vecka"
                    ],
                    duration: "45 minuter"
                ),
                reflectionQuestions: [
                    "Vad bär du i huvudet som ingen annan ser?",
                    "Vilken domän kan du lämna över helt?",
                    "Hur pratar ni om ansvar utan att det blir kritik?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar som gjort det osynliga synligt beskriver ofta stor lättnad:",
                    consensus: "När ägarskap blir tydligt blir ansvar mindre personligt och mer praktiskt.",
                    quotes: [
                        "\"Det var först när vi skrev ned allt som vi förstod hur ojämnt det faktiskt var.\" – Sofia",
                        "\"Att äga en hel domän är mycket bättre än att få en lista över småsaker.\" – Adam"
                    ],
                    source: "Mental load-forskning; Fair Play"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let foraldraBurnout = Course(
        id: "foraldra-burnout",
        title: "Föräldraburnout",
        subtitle: "När belastningen blir för hög",
        description: "En kurs om föräldrautmattning, återhämtning och hur du känner igen skillnaden mellan vanlig trötthet och ett system som gått för länge utan paus.",
        icon: "bolt.heart.fill",
        gradient: LinearGradient(colors: [Color(hex: "B91C1C"), Color(hex: "FCA5A5")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "pb-1",
                title: "Utmattning är ett signalvärde",
                subtitle: "Inte ett karaktärsfel",
                icon: "flame.fill",
                introduction: """
                Föräldraburnout handlar om långvarig utmattning, emotionell distans och en känsla av att man inte räcker till. Det är inte samma sak som att vara trött efter en dålig natt. Det är ett system som har gått för länge utan återhämtning.

                När du ser burnout som information blir nästa steg mer praktiskt: minska belastningen, öka återhämtningen och be om stöd innan systemet kraschar helt.
                """,
                keyPoints: [
                    "Burnout är mer än sömnbrist",
                    "Avstånd till barnet kan vara ett varningstecken",
                    "Återhämtning kräver små pauser varje dag",
                    "Stöd från andra vuxna är skyddande"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du känner dig tom och irriterad nästan varje dag trots att inget enskilt 'händer'.",
                        wrongApproach: "Du fortsätter som vanligt och väntar på att det ska gå över av sig själv.",
                        rightApproach: "Du identifierar belastningar, sänker kraven och bokar in återhämtningstid varje dag. Du ber om konkret hjälp.",
                        explanation: "Burnout blir sällan bättre av att bara bita ihop. Systemet behöver regelbunden avlastning."
                    )
                ],
                exercise: CourseExercise(
                    title: "Återhämtningsmeny",
                    description: "Gör en lista över små saker som faktiskt laddar dig.",
                    steps: [
                        "Skriv fem saker som lugnar dig",
                        "Skriv fem saker som ger energi",
                        "Välj en sak per dag från listan",
                        "Be någon annan ta ett praktiskt ansvar",
                        "Utvärdera efter en vecka vad som hjälpte mest"
                    ],
                    duration: "20 minuter"
                ),
                reflectionQuestions: [
                    "Vad tömmer dig snabbast just nu?",
                    "Vilken liten paus skulle göra mest skillnad?",
                    "Vem kan du be om konkret hjälp utan att förklara allt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta en stark lättnad när burnout får ett namn:",
                    consensus: "Det går att vara en bra förälder utan att vara konstant överkapabel.",
                    quotes: [
                        "\"Jag trodde jag var en dålig mamma. Det visade sig att jag var utmattad.\" – Rebecka",
                        "\"När vi tog bort ett par krav om dagen blev allt mer hanterbart.\" – Johan"
                    ],
                    source: "Mikolajczak & Roskam; parental burnout research"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let konfliktReparation = Course(
        id: "konflikt-reparation",
        title: "Konflikt och reparation",
        subtitle: "Hur man återkopplar efter att det brustit",
        description: "En kurs om reparation efter svåra stunder. Inspirerad av Gottmans reparationsidéer och familjeforskning om att det inte är frånvaron av konflikt som räknas utan kvaliteten på återkopplingen.",
        icon: "arrow.triangle.2.circlepath",
        gradient: LinearGradient(colors: [Color(hex: "F59E0B"), Color(hex: "FB7185")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "krp-1",
                title: "Reparation efter brist",
                subtitle: "Säg förlåt specifikt",
                icon: "bandage.fill",
                introduction: """
                Alla föräldrar tappar tålamod ibland. Det som stärker relationen är inte att du aldrig brister, utan att du reparerar tydligt efteråt. Barn lär sig mycket av hur vuxna återknyter efter en svår stund.

                En bra reparation är enkel, specifik och utan försvar. Den visar att relationen håller även efter en spricka.
                """,
                keyPoints: [
                    "Reparation är en färdighet",
                    "Specifik ursäkt slår vag förklaring",
                    "Återkoppla när du är lugn",
                    "Barn behöver se att vuxna kan reparera"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du höjde rösten åt ditt barn i stress och ångrar det direkt efteråt.",
                        wrongApproach: "Du låtsas som ingenting och hoppas att det glöms bort.",
                        rightApproach: "Du säger att du blev för arg, att det inte var okej och att du ska försöka igen. Sedan gör du en konkret ny start.",
                        explanation: "Barn lär sig trygghet när vuxna kan reparera. Det minskar skam och stärker kontakt."
                    )
                ],
                exercise: CourseExercise(
                    title: "Reparationsfraser",
                    description: "Skriv tre sätt att reparera som känns naturliga för dig.",
                    steps: [
                        "Skriv en ursäkt utan försvar",
                        "Skriv hur du vill göra annorlunda nästa gång",
                        "Skriv en kort kontaktåterkoppling",
                        "Öva fraserna högt",
                        "Använd dem nästa gång du behöver"
                    ],
                    duration: "10 minuter"
                ),
                reflectionQuestions: [
                    "Hur ser en bra ursäkt ut i er familj?",
                    "När reparerar du för sent eller inte alls?",
                    "Vad behöver barnet höra efter en svår stund?"
                ],
                forumSection: CourseForumSection(
                    intro: "Föräldrar beskriver ofta att relationen stärks när reparation blir normalt:",
                    consensus: "Det är fullt möjligt att vara varm, gränssättande och mänsklig samtidigt.",
                    quotes: [
                        "\"När jag började be om förlåtelse blev det faktiskt mindre drama, inte mer.\" – Emma",
                        "\"Min son slutade bli lika rädd för mina misstag när jag började reparera dem högt.\" – Lars"
                    ],
                    source: "Gottman, repair attempts; familjeterapiforskning"
                ),
                readingTimeMinutes: 5
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )

    static let aktivtFaderskap = Course(
        id: "aktivt-faderskap",
        title: "Aktivt faderskap",
        subtitle: "Närvaro som bygger trygghet",
        description: "En kurs om aktivt och engagerat faderskap eller medföräldraskap. Fokus ligger på praktisk kompetens, trygg närvaro och att vara mer än en hjälpreda.",
        icon: "figure.2.and.child.holdinghands",
        gradient: LinearGradient(colors: [Color(hex: "2563EB"), Color(hex: "38BDF8")], startPoint: .topLeading, endPoint: .bottomTrailing),
        modules: [
            CourseModule(
                id: "af-1",
                title: "Egen kompetens",
                subtitle: "Du behöver inte vänta på instruktioner",
                icon: "person.badge.plus",
                introduction: """
                Aktivt faderskap handlar om att ta plats i omsorgen på riktigt, inte bara hjälpa till när någon annan frågar. Barnet behöver fler än en person som kan trösta, natta, mata och förstå vardagen.

                När den icke-bärande vuxna bygger egen kompetens stärks både barnet och relationen mellan de vuxna. Trygghet växer av regelbunden närvaro, inte av att någon alltid är assistent.
                """,
                keyPoints: [
                    "Du äger uppgifter, inte bara hjälper till",
                    "Barn lär känna dig genom upprepad vård",
                    "Praktisk kompetens bygger trygghet",
                    "Delat ansvar minskar belastning på den andra vuxna"
                ],
                examples: [
                    CourseExample(
                        scenario: "Du väntar på att den andra föräldern ska berätta exakt hur nattningen ska gå till.",
                        wrongApproach: "Du ser dig själv som oduglig tills du får instruktioner.",
                        rightApproach: "Du lär dig rutinen och äger den fullt ut, även om den inte blir exakt som den andra vuxna gör den.",
                        explanation: "Barn mår bra av att fler vuxna är kompetenta omsorgspersoner. Det minskar också stressen i relationen."
                    )
                ],
                exercise: CourseExercise(
                    title: "Ett helt ansvar",
                    description: "Välj en omsorgsdomän du tar fullt ansvar för i två veckor.",
                    steps: [
                        "Välj ett område, till exempel kvällsrutin eller morgonlogistik",
                        "Bestäm vad som ingår från början till slut",
                        "Ta ansvar utan att vänta på påminnelser",
                        "Utvärdera vad du lärde dig",
                        "Behåll området om det fungerade"
                    ],
                    duration: "Två veckor"
                ),
                reflectionQuestions: [
                    "Vilket ansvar kan du ta helt och hållet?",
                    "Var blir du för mycket assistent och för lite ägare?",
                    "Hur märker barnet att du finns där på riktigt?"
                ],
                forumSection: CourseForumSection(
                    intro: "Många föräldrar beskriver att aktivt ansvar skapade snabbare trygghet och mindre stress:",
                    consensus: "Att ta egen kompetens på allvar förändrar familjens dynamik.",
                    quotes: [
                        "\"När jag tog över nattningen på riktigt blev vi båda lugnare.\" – Emil",
                        "\"Jag väntade för länge med att ta ansvar själv. När jag väl gjorde det blev allt enklare.\" – Tobias"
                    ],
                    source: "Lambs forskning om involved fathering; jämställdhets- och föräldraforskning"
                ),
                readingTimeMinutes: 6
            )
        ],
        targetAudience: "Förälder",
        estimatedWeeks: 1
    )
}
