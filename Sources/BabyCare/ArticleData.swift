import SwiftUI

// MARK: - Pregnancy Week Articles (v.4–v.42)

extension Article {
    static let pregnancyWeekArticles: [Article] = [

        // MARK: Vecka 4
        Article(
            id: "pregnancy_week_4",
            category: .pregnancy,
            title: "Vecka 4 — Implantationen sker",
            subtitle: "Det befruktade ägget fäster i livmoderväggen",
            icon: "circle.dotted",
            readTimeMinutes: 4,
            intro: "I vecka 4 har det befruktade ägget nått livmodern och börjar nu bädda in sig i livmoderväggen — en process som kallas implantation. Många kvinnor vet ännu inte att de är gravida, men kroppen har redan börjat förändras. Graviditetstestet visar nu positivt.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 4", body: """
Det som i vecka 4 kallas ett embryo är egentligen en liten cellklump kallad blastocyst — ungefär 0,1–0,2 mm stor. Cellerna delar sig snabbt och börjar differentiera sig: vissa bildar embryot självt, andra bildar moderkakan och fosterhinnan. Primitiva strukturer som senare ska bli nervsystem, hjärta och tarmkanal håller på att anläggas. HCG-hormonet (humant koriongonadotropin) börjar utsöndras och stimulerar gulkroppen att fortsätta producera progesteron, vilket hindrar mensen från att komma.
"""),
                ArticleSection(heading: "Din kropp i vecka 4", body: """
Progesteronet gör att livmoderslemhinnan hålls tjock och kvar. Du kan märka en lätt brun eller rosa fläck i underkläder — detta kallas implantationsblödning och är helt normalt. Brösten kan kännas ömma och tyngre. Tröttheten börjar smyga sig på eftersom kroppen mobiliserar enorma resurser för att bygga en ny livsmiljö åt embryot.
"""),
                ArticleSection(heading: "Praktiska tips och när du bör söka vård", body: """
Ta ett graviditetstest om mensen uteblir. Börja ta folsyra 400 µg dagligen om du inte redan gör det — det minskar risken för ryggmärgsbråck. Undvik alkohol, tobak och läkemedel som inte är godkända under graviditet. Kontakta MVC (mödravårdscentralen) för att anmäla graviditeten; den första undersökningen bokas vanligtvis in runt vecka 8–10. Vid kraftig smärta i sidan eller riklig blödning bör du söka akutvård för att utesluta utomkvedshavandeskap.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 4",
                consensus: "Blandade känslor av glädje och nervositet dominerar — många testar flera gånger för att vara säkra.",
                quotes: [
                    "Jag testade tre gånger på en timme för att vara helt säker att det inte var ett fel.",
                    "Hade lite rosa fläckar och trodde mensen kommit tidigt — men det var implantationsblödning!"
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 5
        Article(
            id: "pregnancy_week_5",
            category: .pregnancy,
            title: "Vecka 5 — Hjärtat börjar slå",
            subtitle: "Det primitiva hjärtat pumpar för första gången",
            icon: "heart.fill",
            readTimeMinutes: 4,
            intro: "I vecka 5 är embryot ungefär 2 mm stort — som ett sesamfrö. Det primitiva hjärtat börjar nu slå, ett av graviditetens mest betydelsefulla ögonblick. Illamåendet gör sig påmint för många.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 5", body: """
Embryot har nu tre cellager: ektoderm (som bildar hud och nervsystem), mesoderm (hjärta, muskler, skelett) och endoderm (inre organ). Det primitiva hjärtat — ett rör som slår — pumpar blod för första gången. Neuraltubslutet, det som ska bli ryggraden och hjärnan, börjar sluta sig. Just därför är folsyra så viktigt i tidigt skede. Ögon och öron anläggs som små gropar i huvudet.
"""),
                ArticleSection(heading: "Din kropp i vecka 5", body: """
Illamående — ofta kallat "morgonillamående" trots att det kan komma när som helst — drabbar upp till 80 % av gravida. Det drivs av det snabbt stigande HCG-hormonet. Bröstömhet, trötthet och ökad urineringsdrift är vanliga. Livmodern börjar växa, men magen syns fortfarande inte utifrån.
"""),
                ArticleSection(heading: "Hantera illamående och första trimesterns besvär", body: """
Ät små, täta måltider och undvik tom mage. Ingefärakex, ingefärate och iskall citrondryck hjälper många. Akupressurband mot åksjuka kan lindra. Om du kräks så mycket att du inte kan hålla vatten inne bör du kontakta vården — hyperemesis gravidarum kräver ibland dropp på sjukhus. Vila är inte lyx utan nödvändighet under första trimestern.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 5",
                consensus: "Illamåendet är överväldigande för många, men känslan av att höra hjärtljudet på ultraljud uppväger allt.",
                quotes: [
                    "Jag åt ingefärakex varje vaken stund. Hjälpte faktiskt lite.",
                    "Tröttheten var total — somnade på jobbet under lunchen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 6
        Article(
            id: "pregnancy_week_6",
            category: .pregnancy,
            title: "Vecka 6 — Hjärnan formas",
            subtitle: "Hjärnblåsor och ansiktsdrag tar form",
            icon: "brain.head.profile",
            readTimeMinutes: 4,
            intro: "I vecka 6 är embryot ungefär 4–5 mm. Hjärnan växer snabbt och delas upp i tre primära blåsor. Ansiktets grundstrukturer — nos, mun och ögon — är synliga som gropar och utbuktningar.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 6", body: """
Hjärnan växer med upp till 100 nya nervceller per minut. Tre hjärnblåsor — prosencephalon, mesencephalon och rhombencephalon — anläggas och ger upphov till storhjärna, hjärnstam och lillhjärna. Armknoppar och benknoppar syns tydligt. Hjärtat slår nu med 100–160 slag per minut och är synligt på ultraljud som ett flimrande. Tarmslingan har börjat vrida sig och lever och njurar anläggas.
"""),
                ArticleSection(heading: "Din kropp i vecka 6", body: """
Livmodern är nu ungefär lika stor som en apelsin. Hormonet relaxin mjukar upp banden i bäckenet, vilket kan ge en dragande känsla i ljumskarna. Salivproduktionen ökar för många, vilket förvärrar illamåendet. Luktsinnet är ofta hyperkänsligt — dofter du tidigare tyckt om kan nu utlösa kväljningar. Humörsvängningar hör till och beror på hormonell omställning.
"""),
                ArticleSection(heading: "Ultraljud och bekräftelse av graviditeten", body: """
Vid tidig ultraljudsundersökning i vecka 6–7 kan barnmorskan eller läkaren se hjärtslagen och bekräfta att graviditeten sitter i livmodern (och inte är ett utomkvedshavandeskap). Om du haft missfall tidigare, haft smärtor eller blödningar kan du få remiss till tidig ultraljudskontroll. Boka mödravårdskontakt om du inte redan gjort det.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 6",
                consensus: "Att se hjärtat slå på ultraljud är ett känslomässigt genombrott för de flesta.",
                quotes: [
                    "När vi såg hjärtat flimra på skärmen började vi båda gråta.",
                    "Luktsinnet var galet — kunde inte vara i samma rum som kaffebryggaren."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 7
        Article(
            id: "pregnancy_week_7",
            category: .pregnancy,
            title: "Vecka 7 — Armar och ben växer",
            subtitle: "Lemmarnas konturer blir tydligare",
            icon: "figure.arms.open",
            readTimeMinutes: 4,
            intro: "I vecka 7 är embryot ungefär 1 cm — lika stor som ett blåbär. Armar och ben har vuxit märkbart och händernas plattor börjar delas in i fingrar. Hjärnan fortsätter sin intensiva tillväxt.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 7", body: """
Armarna böjer sig nu vid armbågen och händerna visar tydliga fingerstrålor. Ögonen har pigment och ögonlock håller på att anläggas. Näsan, läpparna och öronen formas successivt. Njurarna börjar producera sin första primitiva urin. Buktarmen, som tidigare låg delvis utanför embryot i navelsträngen, börjar dra sig tillbaka in i bukhålan. Hjärtat har nu fyra kammare.
"""),
                ArticleSection(heading: "Din kropp i vecka 7", body: """
Blodvolymen har börjat öka — under hela graviditeten ökar den med upp till 50 %. Det gör att hjärtat jobbar hårdare och att du kan känna dig yr och andfådd. Livmodern trycker ännu inte på blåsan, men det ökade blodflödet till njurarna gör att du kissar oftare. Förstoppning är vanlig på grund av progesteronet, som saktar ner tarmrörelserna.
"""),
                ArticleSection(heading: "Kost och livsstil", body: """
Ät fiberrikt för att motverka förstoppning: grönsaker, fullkornsprodukter och linser. Drick minst 1,5–2 liter vatten per dag. Koffein bör begränsas till maximalt 200 mg per dag (ungefär en kopp bryggkaffe). Undvik opastöriserad mjölk och ost, rå fisk, lever och sushi med rå fisk — dessa kan innehålla bakterier eller ämnen skadliga för fostret. Lätt motion som promenader är välkommet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 7",
                consensus: "Första trimestern är tuff men vetskapen om snabb fosterutveckling ger kraft.",
                quotes: [
                    "Förstoppningen var värre än illamåendet. Fiber och vatten räddade mig.",
                    "Jag var tvungen att sluta dricka kaffe helt — lukten ensam gjorde mig illamående."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 8
        Article(
            id: "pregnancy_week_8",
            category: .pregnancy,
            title: "Vecka 8 — Alla organ på plats",
            subtitle: "Fostret har fått sina grundläggande organ",
            icon: "heart.circle.fill",
            readTimeMinutes: 5,
            intro: "I vecka 8 är fostret ungefär 1,6 cm långt — lika stort som ett hallon. Trots den lilla storleken är de flesta grundläggande organen nu på plats och börjar mogna.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 8", body: """
Fostret är nu officiellt ett foster (embryo kallas det inte längre). Hjärnan, hjärtat, lungorna och njurarna är alla på plats. Hjärtat slår med 150–170 slag per minut. Armar och ben har vuxit, och fingrar och tår håller på att formas, om än fortfarande sammankopplade. Yttre könsorgan har börjat utvecklas, men det är för tidigt att avgöra kön med ultraljud.
"""),
                ArticleSection(heading: "Din kropp i vecka 8", body: """
Livmodern har nu vuxit till ungefär apelsinens storlek. Du kanske märker att kläder sitter annorlunda, även om magen inte syns utåt ännu. Illamåendet brukar vara som värst i vecka 8–10 för många. Tröttheten kan också vara påtaglig — kroppen arbetar hårt med att bygga moderkakan.
"""),
                ArticleSection(heading: "Praktiska tips", body: """
Om du inte redan gjort det: boka din första mödravårdskontroll. Vanligtvis erbjuds den runt vecka 8–10. Ta med eventuella mediciner du tar så att barnmorskan kan bedöma om de är säkra under graviditeten. Folsyra bör tas dagligen under hela första trimestern.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 8",
                consensus: "Illamåendet och tröttheten dominerar, men vetskapen om att hjärtat slår ger energi.",
                quotes: [
                    "Jag var så trött att jag somnade på soffan varje kväll klockan 8.",
                    "Illamåendet var jobbigt men tröstade mig att det brukar betyda att allt är som det ska."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 9
        Article(
            id: "pregnancy_week_9",
            category: .pregnancy,
            title: "Vecka 9 — Fingrar och tår separeras",
            subtitle: "Fostret börjar röra på sig",
            icon: "hand.raised.fill",
            readTimeMinutes: 4,
            intro: "I vecka 9 är fostret ungefär 2,3 cm — stort som ett vindruvsfrö. Fingrarna och tårna separeras nu och fostret gör sina första spontana rörelser, även om du ännu inte kan känna dem.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 9", body: """
Fingrarna är nu separata och nagelansatser bildas. Fostret rör armar och ben spontant, drivet av den tidiga nervaktiviteten i ryggmärgen. Ögonlocken har vuxit och täcker ögonen; de förblir slutna ända till vecka 26–28. Tändernas anlag bildas inuti tandköttet. Könsorganen har börjat differentiera sig, men ultraljud kan ännu inte fastställa kön.
"""),
                ArticleSection(heading: "Din kropp i vecka 9", body: """
Moderkakan är nu väl etablerad och tar gradvis över produktionen av progesteron och östrogen från gulkroppen. Det innebär att illamåendet och tröttheten för många börjar avta något från vecka 10–12. Brösten fortsätter att växa och areolan mörknar. Blodtrycket kan vara något lägre än normalt på grund av hormonernas inverkan på blodkärlen.
"""),
                ArticleSection(heading: "Mental hälsa under graviditetens tidiga skede", body: """
Oro och ångest är vanligt under första trimestern — rädsla för missfall, för fostrets hälsa och för hur livet ska förändras är normala känslor. Prata med din partner, barnmorska eller en närstående. Om oron är överväldigande finns det stöd att få via MVC. Mindfulness och lätt rörelse kan hjälpa. Det är viktigt att veta att 80 % av alla graviditeter som nått vecka 8 med konstaterat hjärtljud fortgår utan komplikationer.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 9",
                consensus: "Första trimesterns oro är real, men stöd från partner och barnmorska hjälper mycket.",
                quotes: [
                    "Jag googlade allt jag inte borde googla varje natt. Lärde mig att sluta efter vecka 9.",
                    "Min partner var fantastisk — lagade all mat och frågade aldrig om jag var trött (för det visste han)."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 10
        Article(
            id: "pregnancy_week_10",
            category: .pregnancy,
            title: "Vecka 10 — Fostret simmar",
            subtitle: "Spontana rörelser syns tydligt på ultraljud",
            icon: "figure.pool.swim",
            readTimeMinutes: 4,
            intro: "I vecka 10 är fostret ungefär 3 cm och väger ca 4 gram. Det rör sig aktivt i fostervattnet och samtliga organ är nu anlagda — resten av graviditeten handlar om tillväxt och mognad.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 10", body: """
Alla vitala organ är nu på plats. Hjärnan är den snabbast växande strukturen och producerar hundratusentals nervceller per minut. Tarmslingan, som låg i navelsträngen, drar sig nu helt in i bukhålan. Fostret kan göra knytnävar och har mänskliga konturer. Mjölktandernas gropar bildas i käkbenet. Yttre könsorgan är fortfarande svåra att skilja på ultraljud.
"""),
                ArticleSection(heading: "Din kropp i vecka 10", body: """
Livmodern är nu ungefär lika stor som ett grapefrukt. Många upplever att illamåendet gradvis lättar från vecka 10–12 när moderkakan tar över hormonproduktionen. Navelsträngen är nu fullt funktionell och transporterar syre och näring till fostret. Du kan börja märka en svag midjelinje — linea nigra — nedåt magen.
"""),
                ArticleSection(heading: "KUB-test och fosterdiagnostik", body: """
Runt vecka 10–13 erbjuds KUB (kombinerat ultraljud och blodprov) som screenar för kromosoavvikelser som Downs syndrom. KUB ger en riskvärdering, inte ett definitivt svar. Om risken bedöms som förhöjd kan NIPT (icke-invasivt prenatalt test, ett blodprov) eller fostervattenprov erbjudas. Prata med barnmorskan om vad som erbjuds i din region och vad du vill veta.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 10",
                consensus: "KUB-testet väcker tankar och samtal som paret kan behöva föra i lugn och ro.",
                quotes: [
                    "Vi diskuterade länge om vi ville ta KUB. Bestämde oss för att vi ville veta.",
                    "Illamåendet lättade precis i vecka 10 — kände mig nästan som en människa igen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 11
        Article(
            id: "pregnancy_week_11",
            category: .pregnancy,
            title: "Vecka 11 — Reflexer tränas",
            subtitle: "Fostret svälja och gripper om navelsträngen",
            icon: "hand.point.up.fill",
            readTimeMinutes: 4,
            intro: "I vecka 11 är fostret ca 4,5 cm och väger ungefär 7 gram. Reflexerna aktiveras — fostret sväljer fostervatten, gripper om navelsträngen och reagerar på beröring.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 11", body: """
Irisen i ögonen bildas och ögonen börjar kunna reagera på ljus, trots att de fortfarande är slutna. Diafragman, muskeln som styr andningen, är på plats. Fostret tränar andningsrörelser med fostervatten. Könsorganen differentieras tydligare — pojkfoster börjar producera testosteron. Benen är nu längre än armarna, till skillnad från tidigare.
"""),
                ArticleSection(heading: "Din kropp i vecka 11", body: """
Många märker en känsla av mer energi i och med att hormonerna stabiliseras. Graviditetsillamåendet avtar för majoriteten mot slutet av vecka 11–12. Livmodern har rest sig ur bäckenet och kan nu palperas strax ovanför blygdbenet. Huden kan börja förändras — akne på grund av hormoner eller, för en del, en klarare hy.
"""),
                ArticleSection(heading: "Berätta för omgivningen — när är rätt tid?", body: """
Många väljer att vänta med att berätta om graviditeten tills efter vecka 12, när missfallsrisken sjunker markant. Men det finns inga regler — gör det som känns rätt för er. Arbetsgivaren behöver inte informeras förrän betydligt senare, men om arbetet innebär fysisk belastning eller exponering för kemikalier bör du informera tidigt för att kunna anpassa arbetsuppgifter.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 11",
                consensus: "Spänningen inför att berätta för familj och vänner är stor — och reaktionerna är oftast underbara.",
                quotes: [
                    "Vi berättade för föräldrarna i vecka 11 — kunde inte hålla det hemligt längre.",
                    "Energin kom tillbaka nästan exakt i vecka 11. Hade glömt hur normalt mänskligt liv kändes."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 12
        Article(
            id: "pregnancy_week_12",
            category: .pregnancy,
            title: "Vecka 12 — Första trimestern klar",
            subtitle: "Missfallsrisken minskar markant",
            icon: "checkmark.seal.fill",
            readTimeMinutes: 5,
            intro: "Vecka 12 markerar slutet på första trimestern. Fostret är ca 5,5 cm och väger ungefär 14 gram. Missfallsrisken sjunker till under 1 % och de flesta väljer nu att berätta om graviditeten.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 12", body: """
Fostrets ansikte är välformat — ögon, näsa, mun och öron på rätt plats. Naglarna har börjat växa. Fostret producerar sin egna blodkroppar i levern och mjälten (benmärgen tar inte över förrän sent i graviditeten). Njurarna fungerar och utsöndrar urin i fostervattnet. Fostret är nu proportionerligt mänskligt. Könsorganen är möjliga att urskilja på ultraljud för en erfaren undersökare.
"""),
                ArticleSection(heading: "Din kropp i vecka 12", body: """
Livmodern är nu tydligt palpabel och börjar lyfta ur bäckenet. Graviditetsillamåendet avtar för de flesta, men för ca 10–15 % håller det i sig in i andra trimestern. En tidig mage kan börja synas, särskilt hos de som är gravida för andra eller tredje gången. Viktökning på 1–2 kg under första trimestern är normalt — mer eller mindre kan vara normalt beroende på illamående.
"""),
                ArticleSection(heading: "Ultraljudsundersökning i vecka 12", body: """
Rutinultraljudet i vecka 11–14 (nacktransparens-mätning som ingår i KUB) görs för att bedöma risken för kromosoavvikelser. Barnmorskan eller läkaren mäter nackfoldstjocklek och kontrollerar hjärta, hjärna och övrig anatomi. Du ser fostret i rörelse och de flesta föräldrar beskriver det som ett av graviditetens starkaste ögonblick. Be gärna att få bilder att ta med hem.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 12",
                consensus: "Ultraljudet i vecka 12 är en vändpunkt — många börjar känna sig 'riktigt gravida' efter det.",
                quotes: [
                    "När vi såg bebisen vifta med armarna på ultraljudet rann tårarna. Otroligt.",
                    "Berättade för hela familjen direkt efter ultraljudet — de väntade utanför kliniken!"
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 13
        Article(
            id: "pregnancy_week_13",
            category: .pregnancy,
            title: "Vecka 13 — Andra trimestern börjar",
            subtitle: "Energin återvänder och magen börjar synas",
            icon: "sun.max.fill",
            readTimeMinutes: 4,
            intro: "Vecka 13 inleder andra trimestern — den period som många kallar graviditetens 'honungsmånad'. Fostret är ca 7,5 cm och energin återvänder för de flesta blivande mammor.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 13", body: """
Fostret kan nu suga på tummen och gör det ibland på ultraljud. Fingeravtrycken börjar bildas som unika mönster i huden. Skelettet hårdnar från brosk till ben — ett process som kallas ossifikation. Tarmen är nu fullt inuti buken. Fostret rör sig livligt men rörelserna är ännu för svaga och slumpmässiga för att kännas av mamman.
"""),
                ArticleSection(heading: "Din kropp i vecka 13", body: """
Energin återvänder och många känner sig mer som sig själva igen. Moderkakan har fullt tagit över hormonproduktionen. Blodvolymen har ökat med 20–30 % sedan graviditetens början och hjärtat pumpar 40 % mer blod per minut. En tydligare rund mage börjar synas. Livmodern pressar uppåt och du kan börja känna den som en fast rund boll strax under naveln.
"""),
                ArticleSection(heading: "Fysisk aktivitet och motion", body: """
Regelbunden måttlig motion under graviditeten minskar risken för graviditetsdiabetes, för högt blodtryck och ryggsmerter, och gör förlossningen lättare. Promenader, simning, yoga och cykling (tidig graviditet) är utmärkta alternativ. Undvik kontaktsporter, aktiviteter med risk för fall och intensiv träning som höjer pulsen till mer än 140 slag per minut. Lyssna alltid på kroppen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 13",
                consensus: "Andra trimestern välkomnas med öppna armar av de flesta — äntligen lite ork och matlust.",
                quotes: [
                    "Vecka 13 var som att vakna ur en dimma. Åt middag med aptit för första gången på veckor.",
                    "Började yoga för gravida — bästa beslutet under hela graviditeten."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 14
        Article(
            id: "pregnancy_week_14",
            category: .pregnancy,
            title: "Vecka 14 — Könsorgan syns",
            subtitle: "Möjligt att se fostrets kön på ultraljud",
            icon: "person.fill.questionmark",
            readTimeMinutes: 4,
            intro: "I vecka 14 är fostret ca 8,5 cm och väger ungefär 43 gram. Könsorganen är nu tillräckligt utvecklade för att en erfaren ultraljudsspecialist ska kunna se om det är ett pojke eller flicka.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 14", body: """
De yttre könsorganen är nu tydligt differentierade. Sköldkörteln producerar hormoner och fostret tillverkar egna röda blodkroppar. Ögonbrynen och hårstrån börjar växa. Fostret är täckt av ett tunt vaxlikt skikt kallat vernix caseosa, som skyddar huden mot fostervattnets vätskor. Ansiktsmuskulaturen möjliggör primitiva grimaser.
"""),
                ArticleSection(heading: "Din kropp i vecka 14", body: """
Graviditetshormoner kan påverka huden — en del får en glänsande "gravid hy" medan andra drabbas av akne. Linea nigra — den mörka linjen nedåt magen — kan bli tydligare. Bröstvårtorna mörknar ytterligare. Livmodern är nu klart palpabel och du kanske märker att du behöver byta till lösare kläder eller graviditetskläder.
"""),
                ArticleSection(heading: "Navelsträngsblod och andra val du kan göra nu", body: """
Nu är ett bra tillfälle att börja fundera på val inför förlossningen: vill ni ta reda på könet? Ska ni spara navelsträngsblod (erbjuds privat och kostar extra)? Vill ni ha en doula? Börja läsa på om Föräldrapenning hos Försäkringskassan — det är bra att planera i god tid. Anmäl er till föräldraförberedelsekurser hos MVC eller privat.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 14",
                consensus: "Debatten om att ta reda på könet är livlig — hälften vill veta, hälften vill vänta.",
                quotes: [
                    "Vi tog reda på könet direkt — kunde inte vänta. Inte ångrat det en sekund.",
                    "Vi valde att vänta tills förlossningen. Den känslan av överraskning var magisk."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 15
        Article(
            id: "pregnancy_week_15",
            category: .pregnancy,
            title: "Vecka 15 — Ljus och ljud uppfattas",
            subtitle: "Fostret reagerar på omvärlden",
            icon: "ear.fill",
            readTimeMinutes: 4,
            intro: "I vecka 15 är fostret ca 10 cm och väger ungefär 70 gram. Det börjar reagera på starka ljus och ljud utifrån. Hörselorganen formas och inre örat är nu funktionellt.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 15", body: """
Innerörats snäcka och hörselben är på plats och fostret kan uppfatta vibrationer. Starka ljud utanför livmodern kan utlösa en reaktion. Ögonen är fortfarande slutna men reagerar på stark ljusexponering mot magen som en reflexrörelse. Benen är nu längre än armarna. Fostret gör aktiva andningsrörelser med fostervatten — ett träningsmoment för lungorna.
"""),
                ArticleSection(heading: "Din kropp i vecka 15", body: """
Många upplever ökad energi och välmående. Livmodern når nu halvvägs mellan blygdben och navel. Ryggsmärtor kan börja — livmoderns ökande vikt ändrar tyngdpunkten och belastar ländkotorna. Bäckenbottensövningar (Kegelövningar) är viktiga nu — de stärker musklerna runt vagina, urinrör och anus och minskar risken för inkontinens efter förlossningen.
"""),
                ArticleSection(heading: "Fostervattenprov och NIPT", body: """
Om KUB-testet visade förhöjd risk, eller om du är över 35 år, kan du erbjudas NIPT (blodprov som analyserar fostrets DNA i mammans blod) eller fostervattenprov (amniocenthes). Fostervattenprov ger definitivt svar på kromosoavvikelser men medför en liten risk (ca 0,5–1 %) för missfall. Diskutera noggrant med din läkare och ta den tid du behöver för beslutet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 15",
                consensus: "Att sjunga och prata med magen börjar kännas naturligt — och meningsfullt.",
                quotes: [
                    "Min partner pratade med magen varje kväll. Jag skrattade till en början, men det var faktiskt rörande.",
                    "Bäckenbottenövningarna — börja TIDIGT. Önskar att jag startat ännu tidigare."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 16
        Article(
            id: "pregnancy_week_16",
            category: .pregnancy,
            title: "Vecka 16 — Rörelserna kan snart kännas",
            subtitle: "Snart dags att känna de första sparken",
            icon: "wind",
            readTimeMinutes: 4,
            intro: "I vecka 16 är fostret ca 11,5 cm och väger ungefär 100 gram. Rörelserna är nu starka nog att snart kännas inifrån — de flesta blivande mammor märker de första rörelserna mellan vecka 16–22.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 16", body: """
Fostret gör kraftfullare rörelser och kan hålla ihop navelsträngen i handen. Ögonen rör sig sakta bakom de slutna ögonlocken. Hjärtat pumpar ca 25 liter blod per dag. Huden är fortfarande genomskinlig och rödaktig — blodkärlen lyser tydligt igenom. Fettlagret under huden är ännu minimalt. Naglarna är fullt formade.
"""),
                ArticleSection(heading: "Din kropp i vecka 16", body: """
Du är i andra trimesterns mitt och graviditetsmagen är nu tydlig. Många upplever att sex känns mer lustfyllt under andra trimestern — energin är tillbaka och kroppen är inte så tung ännu. Graviditetshormoner kan orsaka igensatta näsor och näsblod på grund av ökad blodgenomströmning i slemhinnorna. Tandköttet kan bli svullet och blöda lättare — besök tandläkaren.
"""),
                ArticleSection(heading: "Tandvård under graviditeten", body: """
Graviditetshormonerna gör tandköttet mer känsligt och blödningsbenäget. Graviditetsgingivit (tandköttsinflammantion) är vanligt och kan leda till tandlossning om det inte behandlas. Besök tandläkaren för en kontroll — tandvård under graviditeten är gratis via mödravårdsremiss. Borsta tänderna mjukt två gånger om dagen och använd tandtråd. Undvik om möjligt röntgen, men om det behövs är det säkert med blyförkläde.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 16",
                consensus: "Att vänta på de första rörelserna är spännande och nervöst på samma gång.",
                quotes: [
                    "Vecka 16 och inget spark ännu — var nervös. Barnmorskan sa att det är helt normalt tills vecka 22.",
                    "Gick till tandläkaren för första gången under graviditeten — bra att jag inte väntade längre."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 17
        Article(
            id: "pregnancy_week_17",
            category: .pregnancy,
            title: "Vecka 17 — Fettet byggs upp",
            subtitle: "Fostret börjar lagra värmegivande brunt fett",
            icon: "thermometer.medium",
            readTimeMinutes: 4,
            intro: "I vecka 17 är fostret ca 13 cm och väger ungefär 140 gram. Det börjar nu lagra brunt fettvävnad som spelar en viktig roll för temperaturregleringen efter födseln.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 17", body: """
Brunt fett — unikt för nyfödda — lagras runt hjärtat, njurarna och axlarna. Det bränns snabbt för att ge värme direkt efter födseln när barnet lämnar den varma livmodern. Fostret producerar mekonium — dess första avföring, sammansatt av döda celler och gallpigment — som samlas i tarmen inför födseln. Brosket i öron och näsa hårdnar. Reflexer som gripereflex och svantereflex är nu aktiva.
"""),
                ArticleSection(heading: "Din kropp i vecka 17", body: """
Livmodern är nu stor som ett litet vattenmelon. Rundbandsmärta — en skarp, krampliknande smärta på sidan av magen — är vanlig och orsakas av att de runda banden som håller livmodern på plats sträcks ut. Den utlöses ofta av snabba rörelser, hosstningar eller nysningar. Den är ofarlig men kan vara intensiv. Vila och lugna rörelser hjälper.
"""),
                ArticleSection(heading: "Förberedelse för föräldraledigheten", body: """
Nu är bra tid att undersöka reglerna för föräldrapenning hos Försäkringskassan. I Sverige har varje förälder rätt till 240 dagar vardera och 90 av dessa är reserverade. Planera hur ni vill dela och anmäl graviditeten till arbetsgivaren senast 2 månader innan planerat ledighetsuttag. Undersök om arbetsgivaren erbjuder förstärkt föräldralön. Börja även fundera på barnvaktskö och förskoleansökan — köerna kan vara långa.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 17",
                consensus: "Rundbandsmärtan överraskar många — det är skönt att veta att den är normal.",
                quotes: [
                    "Fick en knivskarp smärta i sidan när jag nös — trodde något var fel. Men det var bara rundbanden.",
                    "Ansökte om barnomsorgsplats i vecka 17. Bra att vi inte väntade — kön var lång."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 18
        Article(
            id: "pregnancy_week_18",
            category: .pregnancy,
            title: "Vecka 18 — Mina första sparkar",
            subtitle: "Fosterrörelserna kan nu kännas tydligt",
            icon: "figure.kickboxing",
            readTimeMinutes: 5,
            intro: "Vecka 18 är för många en milstolpe — de första tydliga fosterrörelserna (quickening) kan nu kännas. Fostret är ca 14 cm och väger ungefär 190 gram.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 18", body: """
Fosterrörelserna är nu regelbundna och kraftfulla nog att tydligt uppfattas av mamman, särskilt i lugnt läge. Fostret gäspar, sträcker på sig och suger på tummen. Könsorganen är fullt formade och kön kan fastställas på ultraljud. Myelinisering — en process där nervfibrerna kläs in i ett isolerande skikt — börjar i ryggmärgen och fortsätter långt efter födseln. Det är grunden för koordination och snabb nervsignalering.
"""),
                ArticleSection(heading: "Din kropp i vecka 18", body: """
Magen är nu väl synlig och det är dags för graviditetskläder om du inte redan byter. Du kan uppleva sväljningssvårigheter och halsbränna eftersom livmodern trycker uppåt mot magsäcken. Sov med upphöjt huvud och undvik att äta sent på kvällen. Benskador — smärta längs benen på natten — beror på brist på kalcium eller magnesium; prata med barnmorskan om tillskott.
"""),
                ArticleSection(heading: "Känn och dokumentera rörelserna", body: """
Börja nu lägga märke till ditt fosters rörelsemönster. De flesta fostrar är mest aktiva på kvällen. Det är normalt att inte känna rörelser varje dag vid vecka 18 — men från vecka 24 bör du känna minst 10 rörelser per dag. Om rörelserna märkbart minskar eller upphör bör du kontakta förlossningsavdelningen omgående. Att dokumentera rörelserna i en app eller anteckningsbok kan vara lugnande och användbart vid kontakter med vården.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 18",
                consensus: "Att känna sparkarna förändrar relationen till graviditeten fundamentalt — det blir verkligt.",
                quotes: [
                    "Första sparken kände jag som bubblor i magen. Trodde det var gas tills det hände igen.",
                    "Min partner kände sparken för första gången i vecka 18 — det var ett magiskt ögonblick för oss båda."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 19
        Article(
            id: "pregnancy_week_19",
            category: .pregnancy,
            title: "Vecka 19 — Hjärnan kartlägger sinnena",
            subtitle: "Hjärnan skapar kopplingar för smak, lukt och beröring",
            icon: "brain",
            readTimeMinutes: 4,
            intro: "I vecka 19 är fostret ca 15 cm och väger ungefär 240 gram. Hjärnan skapar nu dedikerade områden för syn, hörsel, smak, lukt och beröring. Fostret upplever redan smaker genom fostervattnet.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 19", body: """
Hjärnans sensoriska cortex — de områden som bearbetar intryck från sinnena — börjar specialisera sig. Fostret smakar på det du äter via fostervattnet och forskning visar att exponering för smaker under graviditeten påverkar barnets smakpreferenser efter födseln. Huden är täckt av vernix caseosa och lanugo — ett fint hårskikt som isolerar och skyddar. Benen är tillräckligt starka för att ge kännbara sparkar.
"""),
                ArticleSection(heading: "Din kropp i vecka 19", body: """
Du kan nu känna fostret röra sig regelbundet. Ryggont är vanligt och beror på den förändrade tyngdpunkten och ökad rörlighet i bäckenleder på grund av hormonet relaxin. Prova graviditetskudde för att avlasta ryggen vid sömn. Sov på vänster sida för att optimera blodflödet till foster och placenta — ryggläge kan komprimera den stora vena cava och minska blodflödet.
"""),
                ArticleSection(heading: "Rutinultraljudet i vecka 18–20", body: """
Det stora rutinultraljudet, anatomisk genomgång, görs runt vecka 18–20. Det kontrollerar fostrets anatomi i detalj: hjärna, hjärta, njurar, ryggmärg, mage, läppar och ben. Kön fastställs om föräldrarna vill. Placentas läge kontrolleras. Fostervattnets mängd bedöms. Undersökningen tar 30–45 minuter och är en av graviditetens viktigaste. Ta med dig partnern om möjligt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 19",
                consensus: "Rutinultraljudet är spänningen och nervositeten på topp — de flesta kan andas ut efteråt.",
                quotes: [
                    "Ultraljudet i vecka 20 var intensivt. Vi satt tysta medan läkaren räknade fingrar och tår.",
                    "Läkaren sa att allt såg fint ut — vi grät av lättnad direkt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 20
        Article(
            id: "pregnancy_week_20",
            category: .pregnancy,
            title: "Vecka 20 — Halvtid",
            subtitle: "Halva graviditeten är avklarad",
            icon: "flag.checkered",
            readTimeMinutes: 5,
            intro: "Vecka 20 är halvtid — 20 veckor kvar till beräknat förlossningsdatum. Fostret är ca 25 cm (mätt huvud till fot) och väger ungefär 300 gram. Det är nu täckt av ett tjockt lager vernix.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 20", body: """
Fostret är nu fullt proportionerat och ser ut som ett litet spädbarn. Lugnet håller längre perioder och aktivitet och vila avlöser varandra i cykler. Smakknopparna är fullt formade och fostret kan skilja på söta och bittra smaker. Tarmens rörlighet börjar övas i form av peristaltik. Mjölktändernas gropar är klara inuti käkbenet och permanenta tändernas anlägger sig nu under dem.
"""),
                ArticleSection(heading: "Din kropp i vecka 20", body: """
Livmoderbotten (fundus) når nu naveln — ett klassiskt mätvärde som barnmorskan följer vid varje kontroll. Viktuppgång på totalt 4–6 kg vid halvtid är normalt. Hormonet östrogen ökar blodflödet till huden och ger den mjukare och mer genomblödd karaktär. Hud-förändringar som sträckmärken kan börja uppstå — kokosolja eller graviditetskräm kan lindra men hindrar dem inte.
"""),
                ArticleSection(heading: "Planering och checklista för vecka 20", body: """
Halvtid är ett bra tillfälle att gå igenom en checklista: Är föräldraledigheten planerad? Är barnomsorgsplats ansökt? Är rutinultraljudet gjort? Har du diskuterat förlossningsplats med din partner? Funderar ni på att gå förlossningsförberedelsekurs? Det är aldrig för tidigt att börja förbereda bebisrummet — men vänta gärna med att handla till vecka 24–28 för att undvika stress.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från halvtid",
                consensus: "Halvtid ger ett perspektivskifte — plötsligt är förlossningen 'nära' snarare än 'längt borta'.",
                quotes: [
                    "Halvtid! Nu börjar det kännas på riktigt.",
                    "Vi började planera bebisrummet på halvtid. Roligaste projektet vi gjort tillsammans."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 21
        Article(
            id: "pregnancy_week_21",
            category: .pregnancy,
            title: "Vecka 21 — Marschövningar",
            subtitle: "Fostret tränar koordinerade rörelser",
            icon: "figure.walk",
            readTimeMinutes: 4,
            intro: "I vecka 21 är fostret ca 27 cm och väger ungefär 360 gram. Rörelserna är nu koordinerade och rytmiska — fostret 'marscherar' och tränar de muskler som behövs för livet utanför livmodern.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 21", body: """
Fostret absorberar ca 500 ml fostervatten per dag som en del av sin tarmträning. Levern och mjälten producerar blodkroppar. Benmärgen börjar gradvis ta över blodkroppsproduktionen. Lanugo-håret täcker hela kroppen och hjälper vernix att fästa på huden. Immunsystemet mognar och fostret börjar producera egna antikroppar, om än i begränsad mängd.
"""),
                ArticleSection(heading: "Din kropp i vecka 21", body: """
Bäckensmärta (SPD – symfyseolys) drabbar ca 20 % av gravida och uppstår när hormonet relaxin gör bäckenfogarna för lösa. Den yttrar sig som smärta i blygdbenet och ljumskarna, ofta vid gång, trappklättring och vid att vända sig i sängen. Fysioterapeut kan ge specifika övningar och hjälpmedel som stödskärp. Undvik ensidiga belastningar — stå med jämnt fördelad vikt.
"""),
                ArticleSection(heading: "Sömnproblem och praktiska lösningar", body: """
Sömnproblem är mycket vanliga nu. Kombinationen av stor mage, fostrorrörelser på natten och frekvent toalettbesök gör det svårt att sova. Investera i en lång graviditetskudde (som stöder mage, rygg och knän). Sov på vänster sida. Drick mer vätska på dagtid och minska under kvällen för att reducera nattliga toalettbesök. Undvik skärmar sista timmen innan läggdags.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 21",
                consensus: "Graviditetskudden är en livräddare som ingen borde klara sig utan.",
                quotes: [
                    "Köpte en graviditetskudde i vecka 21 — varför väntade jag så länge??",
                    "Bäckensmärtan kom smygande. Fysioterapeuten hjälpte mig med övningar som faktiskt funkade."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 22
        Article(
            id: "pregnancy_week_22",
            category: .pregnancy,
            title: "Vecka 22 — Viabilitetsgränsen",
            subtitle: "Fostret är nu livsdugligt med intensivvård",
            icon: "staroflife.fill",
            readTimeMinutes: 5,
            intro: "Vecka 22 markerar en medicinsk milstolpe — fostret är nu i teorin livsdugligt med avancerad intensivvård, om en för tidig förlossning skulle ske. Det är ca 28 cm och väger ungefär 430 gram.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 22", body: """
Lungorna producerar nu surfaktant — ett ämne som hindrar lungblåsorna från att kollapsa vid utandning. Detta är avgörande för att ett extremt prematurbomt barn ska kunna andas. Hjärnans ytskikt (cortex) börjar bilda vindlingar (gyri och sulci), vilket ökar ytan. Sömnperioderna är nu längre och mönstret liknar det som kommer att ses hos det nyfödda barnet. Ögonbrynen och ögonfransarna är klara.
"""),
                ArticleSection(heading: "Din kropp i vecka 22", body: """
Navelsträngen är tjock och spiralvriden — en form som minskar risken för knutar. Sammandragningar (Braxton-Hicks) kan börja uppstå — oregelbundna, smärtfria spänningar i livmodern som förbereder den inför förlossningen. De skiljer sig från förlossningsvärkar genom att de är oregelbundna, inte tilltar i styrka och lugnar ner vid rörelse. Vaginalflödet ökar ofta under andra trimestern.
"""),
                ArticleSection(heading: "Tecken på för tidig förlossning", body: """
Även om de flesta graviditeter fortgår normalt är det viktigt att känna till varningssignalerna: regelbundna sammandragningar (mer än 4–5 per timme), tryckkänsla nedåt i bäckenet, vattenartad flytning (kan vara fostervatten), blodig flytning eller smärta i nedre ryggen. Om något av detta uppstår bör du omgående kontakta förlossningsavdelningen. Tidigt omhändertagande av hotande för tidig förlossning kan rädda liv.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 22",
                consensus: "Vetskapen om viabilitetsgränsen ger trygghet, men också en djupare respekt för graviditetens sårbarhet.",
                quotes: [
                    "Läste om prematura barn och förstod hur otroligt hårt neonatalavdelningarna arbetar.",
                    "Braxton-Hicks skrämde mig i vecka 22. Barnmorskan förklarade skillnaden — lugnade mig helt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 23
        Article(
            id: "pregnancy_week_23",
            category: .pregnancy,
            title: "Vecka 23 — Hörsel och balans mognar",
            subtitle: "Fostret kan nu höra din röst tydligt",
            icon: "waveform",
            readTimeMinutes: 4,
            intro: "I vecka 23 är fostret ca 29 cm och väger ungefär 500 gram. Hörseln är nu tillräckligt mogen för att fostret tydligt ska uppfatta röster och musik utifrån. Forskning visar att det nyfödda barnet känner igen moderns röst.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 23", body: """
Innerörats cochlea — hörselsnäckan — är fullt utvecklad. Fostret kan höra lågfrekventa ljud bäst, som basgångar, hjärtljud och dova röster. Forskning visar att nyfödda föredrar sin mammas röst framför andra röster — ett resultat av de månader av exponering i livmodern. Balansorganet (vestibularsystemet) i innerörat är fullt funktionellt och fostret uppfattar sin läge och rörelserna i livmodern.
"""),
                ArticleSection(heading: "Din kropp i vecka 23", body: """
Huden kan börja klía på magen när den sträcks ut. Kokosolja, mandelolja eller graviditetskräm kan lindra. Hemorrider är vanliga under tredje trimestern och kan börja bli besvärliga nu — de uppstår av ökat blodflöde och trycket av livmodern mot ändtarmen. Fiberrik kost, rikligt med vatten och att undvika ansträngning vid toalettbesök hjälper. Snorkande ökar under graviditeten på grund av svullna slemhinnor.
"""),
                ArticleSection(heading: "Kommunicera med ditt foster", body: """
Att prata, sjunga och spela musik för fostret är meningsfullt. Välj lugn, melodisk musik — klassisk musik och folkvisa har visats ha lugnande effekt på foster. Läs sagor högt. Att skriva en dagbok om graviditeten skapar minnen och kan vara ett fint minne att dela med barnet senare. Välmående i familjesystemet — parrelationen, syskonrelationer — påverkar fostrets stressnivåer positivt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 23",
                consensus: "Att prata med magen börjar kännas naturligt och fosterrörelserna bekräftar kontakten.",
                quotes: [
                    "Min man sjöng varje kväll för magen. Barnet lugnade sig alltid när han sjöng — även efter födseln!",
                    "Kliande mage är ingen skämt. Oljan hjälpte men varningarna om sträckmärken kom ändå."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 24
        Article(
            id: "pregnancy_week_24",
            category: .pregnancy,
            title: "Vecka 24 — Graviditetsdiabetes screenas",
            subtitle: "Dags för glukostest och intensifierad kontroll",
            icon: "cross.vial.fill",
            readTimeMinutes: 5,
            intro: "I vecka 24 är fostret ca 30 cm och väger ungefär 600 gram. Nu genomförs i många regioner ett glukosbelastningstest för graviditetsdiabetes. Rörelserna är nu kraftfulla och tydliga varje dag.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 24", body: """
Lungorna producerar nu mer surfaktant och ett för tidigt fött barn i vecka 24 har med intensivvård ca 50 % chans att överleva. Huden börjar mjukna och bli mindre genomskinlig. Svettkörtlarna bildas i huden. Sömnmönstret är väldefinierat med tydliga aktiv- och viloperioder. Hjärnan är nu i snabb tillväxtfas och fördubblas i vikt under tredje trimestern.
"""),
                ArticleSection(heading: "Din kropp i vecka 24", body: """
Från vecka 24 bör du känna fostret röra sig dagligen. Förlossningsavdelningen rekommenderar att du räknar rörelser om du är osäker — tio rörelser på 2 timmar är ett riktvärde. Graviditetskontrollerna tätnar nu. Urinprov, blodtryck och fundushöjd (mätning av livmodertopps höjd) är standardundersökningar vid varje besök.
"""),
                ArticleSection(heading: "Graviditetsdiabetes", body: """
Graviditetsdiabetes drabbar ca 5–10 % av alla gravida i Sverige. Den uppstår när moderkakans hormoner minskar insulinkänsligheten. Riskfaktorer är övervikt, ärftlighet och ålder över 35. Diagnosen ställs med ett glukosbelastningstest (OGTT). Vid diagnos behandlas med kost, motion och ibland insulin. Obehandlad kan den leda till stort barn (macrosomi), förlossningskomplikationer och ökad risk för typ 2-diabetes senare i livet för både mor och barn.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 24",
                consensus: "Glukostestet oroas många för, men de flesta slipper graviditetsdiabetes.",
                quotes: [
                    "Drack sockerdrycken och tyckte det var den äckligaste saken under hela graviditeten.",
                    "Fick graviditetsdiabetes men med kost och promenader höll jag blodsockret stabilt utan insulin."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 25
        Article(
            id: "pregnancy_week_25",
            category: .pregnancy,
            title: "Vecka 25 — Håret och naglarna växer",
            subtitle: "Fostret liknar alltmer ett nyfött barn",
            icon: "scissors",
            readTimeMinutes: 4,
            intro: "I vecka 25 är fostret ca 34 cm och väger ungefär 660 gram. Håret på huvudet är synligt och naglarna är välformade — fostret liknar nu i allt väsentligt ett nyfött litet barn.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 25", body: """
Hudlagret under huden börjar byggas upp med fett, vilket minskar hudens genomskinlighet. Hjärnan fortsätter sin intensiva tillväxt och bildandet av nya synapser pågår i rasande takt. Lungorna fortsätter att mogna. Pupillreflexen utvecklas — ett starkt ljus mot magen utlöser en reaktion i fostrets ögon. Immunsystemet mognar och fostret börjar producera antikroppar (IgG) som det fått från modern via moderkakan.
"""),
                ArticleSection(heading: "Din kropp i vecka 25", body: """
Livmodern är nu stor som ett basketboll. Tyngdpunktsförändringen kan ge ländryggssmärta och "anka-gång" — det senare beror på relaxin-påverkade bäckenleder. Varikös (åderbråck) och spindeladrar är vanliga i benen och vulvaregionen på grund av ökat blodflöde. Kompressionsstrumpor kan lindra. Ta inte antiinflammatoriska läkemedel (ibuprofen, diklofenak) utan att fråga barnmorskan — de kan påverka fosternjurarna.
"""),
                ArticleSection(heading: "Förlossningsförberedelsekurs", body: """
Nu är bra tid att boka förlossningsförberedelsekurs om du inte redan gjort det. Mödravårdscentralen erbjuder gratis kurser. Privata alternativ finns och ger ofta mer tid per deltagare. Kurserna täcker andningsteknik, smärtlindring, hur man känner igen förlossningens faser, amning och det nyfödda barnets första dagar. Kurser för partners är ofta separata men lika värdefulla.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 25",
                consensus: "Förlossningsförberedelsekursen ger verktyg och trygghet — rekommenderas varmt.",
                quotes: [
                    "Förlossningskursen var bättre än väntat — vi fick öva andningstekniker och det hjälpte verkligen.",
                    "Åderbråcket i benen var oväntat jobbigt. Kompressionsstrumporna hjälpte men var varma."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 26
        Article(
            id: "pregnancy_week_26",
            category: .pregnancy,
            title: "Vecka 26 — Ögonen öppnas",
            subtitle: "Fostret börjar öppna och sluta ögonen",
            icon: "eye.fill",
            readTimeMinutes: 4,
            intro: "I vecka 26 är fostret ca 35 cm och väger ungefär 760 gram. En av graviditetens mest symboliska händelser sker nu — fostret börjar öppna och sluta ögonen för första gången.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 26", body: """
Ögonlocken öppnas nu delvis och irisen kan urskiljas — de flesta nyfödda har grå eller blå ögon som mörknar under de första månaderna. Synnerven är funktionell och fostret reagerar på ljusförändringar. Hjärnans vita substans — de nervbanor som kopplar samman hjärnans delar — byggs upp snabbt. Lungorna är mer mogna men behöver ytterligare veckor för full funktion. Benmärgen har tagit över hela blodkroppsproduktionen.
"""),
                ArticleSection(heading: "Din kropp i vecka 26", body: """
Tredje trimestern börjar nästa vecka och kroppen gör sig redo. Restless legs-syndrom (oroliga ben) är vanligt under tredje trimestern — en krypande, stickande känsla i benen som tvingar till rörelse, särskilt på natten. Det kan bero på järnbrist eller magnesiumhrist. Kolla järnvärdet hos din barnmorska. Brist på järn under graviditeten är mycket vanligt och behandlas med tillskott.
"""),
                ArticleSection(heading: "Järnbrist och anemi under graviditeten", body: """
Järnbrist är den vanligaste näringsbristsjukdomen under graviditeten — blodvolymen ökar med 50 % men jernförråden hinner inte alltid med. Symtom är trötthet, yrsel, blek hud och hjärtklappning. Screening med blodprov görs rutinmässigt. Behandling sker med järntillskott (tas på tom mage med C-vitamin för bättre upptagning). Järnrika livsmedel: lever, rött kött, linser, spenat och fullkorn.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 26",
                consensus: "Oroliga ben på natten är ett distinkt problem — järntillskott hjälpte många.",
                quotes: [
                    "Oroliga ben varje natt från vecka 26. Barnmorskan kontrollerade järnet — hade järnbrist.",
                    "Att veta att bebisen nu öppnade ögonen var något speciellt. Lyste en ficklampa mot magen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 27
        Article(
            id: "pregnancy_week_27",
            category: .pregnancy,
            title: "Vecka 27 — Sista veckan i andra trimestern",
            subtitle: "Tredje trimesterns intensitet stundar",
            icon: "hourglass.bottomhalf.filled",
            readTimeMinutes: 4,
            intro: "Vecka 27 är den sista veckan i andra trimestern. Fostret är ca 36 cm och väger ungefär 875 gram. Nu tar kroppen en klar vändning mot förlossningsförberedelse.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 27", body: """
Fostret drömmer nu — REM-sömn är observerad på ultraljud. Vad det drömmer om vet vi inte, men sömnmönstret är väldefinierat. Hjärnan fortsätter att bilda ny vit substans och de snabba synapskopplingarna ökar. Lungorna producerar mer surfaktant. Kroppen ökar nu i vikt med ca 200 gram per vecka under tredje trimestern. Fostret kan hicka — du kan känna rytmiska ryckningar i magen.
"""),
                ArticleSection(heading: "Din kropp i vecka 27", body: """
Tredje trimestern är nära och med den återvänder en del av första trimesterns obehag — trötthet, frekvent urineringsbehov och andnöd — men nu orsakade av fostrets storlek snarare än hormoner. Brösten producerar kanske redan råmjölk (colostrum) — en gulaktig, tjock vätska som är rik på antikroppar och näring. Om det läcker kan bröstskydd i bh:n hjälpa.
"""),
                ArticleSection(heading: "Planera runt förlossningen", body: """
Boka om du inte gjort det: förlossningsförberedelsekurs, amningskurs och eventuell visning av förlossningsavdelningen. Undersök om det finns möjlighet till vattenförlossning, epiduralbedövning och andrahandsval om dessa inte är möjliga. Börja packa förlossningsväskan — det är aldrig för tidigt. Ta reda på vilken förlossningsavdelning du ska till och var närmaste ingång är på sjukhuset.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 27",
                consensus: "Planeringen intensifieras — och det är skönt att ha koll och kontroll.",
                quotes: [
                    "Packade förlossningsväskan redan i vecka 27. Kände mig omedelbart lugnare.",
                    "Var på visning av BB i vecka 27 — att veta exakt vart man ska är guld värt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 28
        Article(
            id: "pregnancy_week_28",
            category: .pregnancy,
            title: "Vecka 28 — Tredje trimestern börjar",
            subtitle: "Sista raksträckan mot förlossningen",
            icon: "flag.fill",
            readTimeMinutes: 5,
            intro: "Vecka 28 inleder tredje och sista trimestern. Fostret är ca 37 cm och väger ungefär 1 kg. Förlossningsdatumet är nu 12 veckor bort och det är dags att intensifiera förberedelserna.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 28", body: """
Fosterets hjärna rymmer nu ca 10 miljarder nervceller — samma antal som en vuxen. Lanugo-håret börjar försvinna. Huden är nu mjukare och mer opak. Lungmognaden accelererar markant — ett prematurbomt barn i vecka 28 har med vård ca 90 % chans att överleva. Blicken kan röra sig i fokus. Hjärnan styr nu andningen rytmiskt.
"""),
                ArticleSection(heading: "Din kropp i vecka 28", body: """
Tredje trimesterns symtom tar fart: andnöd (livmodern trycker upp mot mellangärdet), halsbränna (ökat magsäckstryck), svullna fötter och anklar (ödem), och svårigheter att sova. Att lyfta fötterna och röra på dem regelbundet minskar ödemet. Halsbränna lindras av small och täta måltider, upphöjt läge och att undvika starka kryddor.
"""),
                ArticleSection(heading: "Kontrollerna tätnar", body: """
Från vecka 28–32 ökar antalet MVC-kontroller till var fjärde vecka och sedan var andra vecka mot slutet. Barnmorskan mäter fundushöjd, kontrollerar blodtrycket, tar urinprov och lyssnar på hjärtljudet. CTG (cardiotokografi) — registrering av hjärtljudet och eventuella sammandragningar — kan göras om det finns frågetecken kring fostrets välmående. Rh-negativa mammor erbjuds anti-D-injektion i vecka 28.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 28",
                consensus: "Tredje trimesterns obehag är påtagliga, men närheten till mötet med barnet ger kraft.",
                quotes: [
                    "Andnöden i vecka 28 var oväntat jobbig. Kom inte ihåg att det stod i boken om det.",
                    "Läkaren sa att bebisen snart väger ett kilo — det var svårt att fatta men väldigt konkret."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 29
        Article(
            id: "pregnancy_week_29",
            category: .pregnancy,
            title: "Vecka 29 — Benen sparkar kraftigt",
            subtitle: "Rörelserna är nu starka och koordinerade",
            icon: "bolt.fill",
            readTimeMinutes: 4,
            intro: "I vecka 29 är fostret ca 38 cm och väger ungefär 1,2 kg. Benen är nu starka nog att ge riktigt kraftiga sparkar — och ibland syns rörelserna utifrån på magen.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 29", body: """
Skelettet är nu nästan helt hårt ben — kalciumbehovet är nu som störst, ca 1000 mg per dag. Muskelmassan ökar snabbt. Immunsystemet fortsätter att mogna och fostret ackumulerar antikroppar från modern via moderkakan (passiv immunitet). Den vita och gröna hjärnsubstansen kan nu urskiljas tydligt på ultraljud. Fostrets rytm — aktiv dag och nattperiod — matchar ofta mammans.
"""),
                ArticleSection(heading: "Din kropp i vecka 29", body: """
Kalciumbehovet är förhöjt — säkerställ att du får i dig tillräckligt via mejeriprodukter, mandlar, broccoli och baljväxter. D-vitamin är nödvändigt för kalciumupptaget — tillskott rekommenderas under graviditeten. Nattliga benmuskelkramper (muskelbräcka) är vanliga och beror på elektrolytbalansen. Töj ut kalven direkt vid anfall. Bananäten kan hjälpa (kalium och magnesium).
"""),
                ArticleSection(heading: "Förlossningsplan", body: """
En förlossningsplan är ett dokument där du formulerar dina önskemål inför förlossningen: smärtlindring (epidural, lustgas, sterilt vatten, akupunktur), födelseposition, vem som klipper navelsträngen, amniotomi (hinnbristning), hudhud-kontakt direkt efter födseln och amning. Planen är inte bindande men ger personalen vägledning och ger dig en känsla av delaktighet. Diskutera med barnmorskan vid nästa kontroll.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 29",
                consensus: "Förlossningsplanen skapar samtal och ger en gemensam bild för paret inför förlossningen.",
                quotes: [
                    "Att skriva förlossningsplan var oväntat givande — vi kom fram till att vi hade väldigt olika förväntningar.",
                    "Sparkarna var nu så kraftiga att mitt kaffe skakade. Imponerade på kollegorna."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 30
        Article(
            id: "pregnancy_week_30",
            category: .pregnancy,
            title: "Vecka 30 — Fett och hjärna på topp",
            subtitle: "Snabb tillväxt av hjärna och fettvävnad",
            icon: "chart.bar.fill",
            readTimeMinutes: 4,
            intro: "I vecka 30 är fostret ca 40 cm och väger ungefär 1,4 kg. Hjärnan och underhudsfettet växer nu som snabbast, vilket ger fostret de avrundade konturer som ett nyfött barn har.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 30", body: """
Hjärnans ytskikt (cortex) bildar nu djupa fåror och vindlingar. Det vita fettvävnadslagret under huden ökar snabbt och ger fostret dess karakteristiska rundhet. Lanugo-håret nästan helt borta. Naglar och tånaglar är nu fullt formade. Ögonen kan nu röra sig i fokus och pupillreflexen är aktiv. Njurarna filtrerar ca 500 ml urin per dag.
"""),
                ArticleSection(heading: "Din kropp i vecka 30", body: """
Livmodern är nu stor som en basketboll och trycket upp mot revbenen kan ge ont i flanken. Braxton-Hicks-sammandragningar är nu vanliga. Det är normalt att känna bäckensmärta när fostret sjunker ner. Många märker att det är svårt att sova bekvämt — byt position ofta, ta hjälp av kuddar och sträck på dig regelbundet.
"""),
                ArticleSection(heading: "Amningsförberedelse", body: """
Nu är ett bra tillfälle att gå en amningskurs. Råmjölk (colostrum) finns redan i brösten och kan börja komma i vecka 30–32. Amning är naturligt men kan kräva inlärning — det är vanligt att ha problem de första dagarna. Kontakta barnmorska eller amningsrådgivare tidigt vid problem. Amning skyddar mot infektioner, stärker barnets immunsystem och minskar risken för plötslig spädbarnsdöd.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 30",
                consensus: "Amningskursen rekommenderas varmt — kunskapen ger ett bättre startläge.",
                quotes: [
                    "Colostrum läckte redan i vecka 30 — blev förvånad men barnmorskan sa att det är normalt.",
                    "Amningskursen öppnade ögonen. Jag trodde det bara 'satt'. Det gjorde det inte direkt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 31
        Article(
            id: "pregnancy_week_31",
            category: .pregnancy,
            title: "Vecka 31 — Alla sinnen aktiva",
            subtitle: "Fostret smakar, hör, ser och känner",
            icon: "sparkles",
            readTimeMinutes: 4,
            intro: "I vecka 31 är fostret ca 41 cm och väger ungefär 1,6 kg. Alla fem sinnena är nu aktiva och sammankopplade med hjärnans sensoriska centrum. Fostret upplever världen på ett medvetet sätt.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 31", body: """
Hjärnan integrerar nu information från alla sinnen — fostret smakar fostervatten, hör röster, ser ljus och skuggor, och känner beröring och temperaturförändringar. Immunsystemet är nu tillräckligt moget för att hantera vanliga infektioner. Lungorna producerar riklig surfaktant. Fosterrörelserna är nu mest koordinerade sparkrörelser snarare än slumpmässiga rörningar.
"""),
                ArticleSection(heading: "Din kropp i vecka 31", body: """
Blodtrycket kontrolleras noga vid varje MVC-besök nu. Preeklampsi — graviditetsförgiftning — kan debutera i tredje trimestern med plötsligt högt blodtryck, svullnad och protein i urinen. Symtom att reagera på: svår huvudvärk, synförändringar, smärta under revbenen, plötslig kraftig svullnad. Sök akutvård omgående om dessa uppstår.
"""),
                ArticleSection(heading: "Partner och föräldraskap", body: """
Partnerns roll under tredje trimestern är viktig. Stöd praktiskt med hushållssysslor, närvaro vid MVC-kontroller och förlossningsförberedelse. Prata om förväntningar på föräldrarollen, fördelning av nattpassningar och hur parrelationen ska prioriteras efter barnets ankomst. Forskning visar att par som diskuterar rollerna i förväg rapporterar högre nöjdhet med parrelationen efter födseln.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 31",
                consensus: "Preeklampsi-informationen skrämmer, men att känna till symtomen ger trygghet.",
                quotes: [
                    "Barnmorskan informerade om preeklampsi och jag googlade direkt. Slutade googla — för mycket ångest.",
                    "Min partner började följa med mer aktivt till kontrollerna nu. Det hjälpte oss båda."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 32
        Article(
            id: "pregnancy_week_32",
            category: .pregnancy,
            title: "Vecka 32 — Lägesändring",
            subtitle: "Fostret vänder sig till huvudläge",
            icon: "arrow.down.circle.fill",
            readTimeMinutes: 5,
            intro: "I vecka 32 är fostret ca 42 cm och väger ungefär 1,8 kg. De flesta foster vänder sig nu till huvudläge (cephalic) — det läge som är optimalt för förlossningen. Kontrollerna tätnar.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 32", body: """
Ca 70 % av alla foster är nu i huvudläge. Resterande 30 % vänder sig under de kommande veckorna. Säteläge (fostret med rumpan eller fötterna nedåt) kvarstår hos ca 3–4 % vid fullgången graviditet. Fostret är nu trångt i livmodern och rörelsemönstret förändras — färre stora rörelser men fler mindre. Det är normalt. Lungmognaden är nu i princip klar.
"""),
                ArticleSection(heading: "Din kropp i vecka 32", body: """
Trycket mot blåsan är nu konstant och täta toalettbesök hör till vardagen. Baksmärta och bäckensmärta är vanligt. Nästäppa och snarkande ökar på grund av hormonpåverkade slemhinnor. Hud under brösten och magen kan bli irriterad av friktion — bomullstextil och fuktskyddande kräm hjälper. Viktuppgången totalt bör nu ligga runt 8–12 kg.
"""),
                ArticleSection(heading: "Säteläge — vad händer om fostret inte vänder?", body: """
Om fostret fortfarande ligger i säteläge vid vecka 36 erbjuds extern cephalisk version (ECV) — ett försök av en obstetriker att manuellt vända fostret utifrån. Lyckas med ca 50–60 %. Om vändning misslyckas diskuteras kejsarsnitt eller planerad sätesförlossning beroende på sjukhusrutiner. Yoga-positioner (moxy, vändövningar på alla fyra) kan uppmuntras men vetenskapligt stöd är begränsat.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 32",
                consensus: "Oron för säteläge är vanlig — de flesta foster vänder sig i tid.",
                quotes: [
                    "Låg i säteläge fram till vecka 35 och vände sig dagen innan det planerade vändningsförsöket.",
                    "Täta toalettbesök nattetid var det jobbigaste i vecka 32. Kom ihåg att minska vätskeintaget på kvällen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 33
        Article(
            id: "pregnancy_week_33",
            category: .pregnancy,
            title: "Vecka 33 — Immunsystem och fett",
            subtitle: "Sista finpussen på fostrets skyddssystem",
            icon: "shield.fill",
            readTimeMinutes: 4,
            intro: "I vecka 33 är fostret ca 43 cm och väger ungefär 2 kg. Immunsystemet och fettlagren byggs upp i rask takt inför livet utanför livmodern.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 33", body: """
Fostret tar emot antikroppar från modern (IgG) via moderkakan — dessa passiva antikroppar skyddar barnet mot infektioner de första 3–6 månaderna efter födseln. Underhudsfett fortsätter att ansamlas och ger de typiska "bebisrullarna". Hudens rödaktiga ton minskar. Skallen är fortfarande mjuk och formbar — de fyra skallbenen är separerade för att möjliggöra passage genom förlossningskanalen.
"""),
                ArticleSection(heading: "Din kropp i vecka 33", body: """
Andnöden kan vara påtaglig nu — livmodern trycker upp mot mellangärdet. Om fostret sjunker ner i bäckenet (sänkning) kan andningen faktiskt bli lättare, men trycket mot blåsan ökar. Hälsostationsbesök täta — blodtryck, vikt och fundushöjd vid varje möte. CTG kan ordineras om rörelsemönstret ändras.
"""),
                ArticleSection(heading: "Mental förberedelse för förlossningen", body: """
Förlossningsrädsla drabbar ca 15–20 % av gravida i Sverige i kliniskt signifikant grad. Aurorasamtal — specialiserat stöd för förlossningsrädsla vid MVC — kan bokas kostnadsfritt. Psykoprofylax, hypnobirthing och visualiseringsövningar kan hjälpa. Att veta att du kan be om stöd under förlossningen, att barnmorskan är utbildad att hjälpa vid smärta och att kejsarsnitt alltid är ett alternativ, kan minska rädslan.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 33",
                consensus: "Förlossningsrädsla är vanligare än man tror — och det finns hjälp att få.",
                quotes: [
                    "Bokade Aurorasamtal och det förändrade allt. Kände mig faktiskt redo efteråt.",
                    "Andnöden var värst när jag lade mig ner. Fick sova halvt sittande med kuddar."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 34
        Article(
            id: "pregnancy_week_34",
            category: .pregnancy,
            title: "Vecka 34 — Nästan redo",
            subtitle: "Lungorna är nästan fullt mogna",
            icon: "lungs.fill",
            readTimeMinutes: 4,
            intro: "I vecka 34 är fostret ca 45 cm och väger ungefär 2,2 kg. Lungorna är nu nästan fullt mogna — ett barn fött i vecka 34 klarar sig i de flesta fall utan respiratorvård.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 34", body: """
Surfaktantproduktionen är nu nästan komplett. Barn födda i vecka 34 (sent prematura) behöver ibland lite extra stöd med andning, temperaturreglering och amning, men prognosen är generellt utmärkt. Nänivorna av mekonium i tarmen är höga. Nagelplattorna når nu fingertopparna. Testiklar hos pojkfoster sänker sig till pungen (om de inte redan gjort det).
"""),
                ArticleSection(heading: "Din kropp i vecka 34", body: """
Livmodern är nu så stor att den pressar mot nästan alla inre organ. Förutom andnöd och halsbränna kan njurarna pressas och ge ökad risk för urinvägsinfektion. Symtom på urinvägsinfektion (sveda, täta urineringsbehov, grumlig urin) bör alltid behandlas under graviditeten för att undvika att infektionen sprider sig till njurarna. Tvillinggraviditeter förlöses vanligtvis runt vecka 37–38.
"""),
                ArticleSection(heading: "Förberedelse hemma", body: """
Kontrollera att bebisrummet är klart: skötbord på rätt höjd, vagga eller säng, köldskyddat badkar, babykläder i storlek 50–56, blöjor, badhandduk och bilbarnstol. Bilbarnstolen ska monteras och kontrolleras INNAN förlossningen — kontakta Biltema eller NTF för montagekontroll. Se till att telefonnumret till förlossningsavdelningen är sparat i mobilen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 34",
                consensus: "Hemmaförberedelserna ger en känsla av kontroll och beredskap som är ovärderlig.",
                quotes: [
                    "Kontrollerade bilbarnstolen i vecka 34 — bra att vi gjorde det, den var inte rätt monterad.",
                    "Vecka 34 och fortfarande inga bebiskläder köpta. Fick en mild panik och handlade allt på en dag."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 35
        Article(
            id: "pregnancy_week_35",
            category: .pregnancy,
            title: "Vecka 35 — Sänker sig i bäckenet",
            subtitle: "Fostret rör sig nedåt i beredskapsläge",
            icon: "arrow.down.to.line",
            readTimeMinutes: 4,
            intro: "I vecka 35 är fostret ca 46 cm och väger ungefär 2,4 kg. Hos förstföderskor börjar fostret ofta sjunka ner i bäckenet nu — förberedelse inför förlossningen.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 35", body: """
Fostret är nästan fullt utveckat — de kommande veckorna handlar om tillväxt och finslipning. Hjärnan väger nu ca 400 gram och har ca 100 miljarder nervceller. Det vita fettvävnadslagret är nu rejält och ger de runda kinderna och veckade lemmar som vi associerar med nyfödda. Vernix caseosa täcker fortfarande huden. Lanugo-håret är nästan helt borta.
"""),
                ArticleSection(heading: "Din kropp i vecka 35", body: """
Om fostret sjunker ner (engagement) märker du att andningen lättar — men trycket mot blåsan, rektum och bäckenbotten ökar. Tung känsla i underliv och bäcken är normal. Vaginalfluor ökar och kan bli tjockare. Förlossningstecknet att tappa mensproppen — ett slemigt, ibland blodtingerat utsöndring — kan ske närsomhelst nu, men det betyder inte att förlossningen är nära.
"""),
                ArticleSection(heading: "GBS-screening", body: """
Runt vecka 35–37 tas ett odlingsprov för grupp B-streptokocker (GBS) — bakterier som ca 20–30 % av alla kvinnor bär på utan symptom i underlivet och som kan smitta barnet vid förlossningen. Vid positivt GBS-prov ges antibiotika intravenöst under förlossningen för att skydda barnet mot svår infektion. Provtagningen är enkel (svabb från vagina och anus) och görs vid barnmorskemottagningen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 35",
                consensus: "Bäckentrycket och den ökade urineringsdriften i vecka 35 är påtagliga men förståliga.",
                quotes: [
                    "Kissar var 20:e minut. Jobbar hemifrån nu — hade inte klarat pendling.",
                    "GBS-provet var ingen stor grej. Resultatet kom snabbt och det var skönt att veta."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 36
        Article(
            id: "pregnancy_week_36",
            category: .pregnancy,
            title: "Vecka 36 — Sista finishen",
            subtitle: "Alla organ är mogna och redo",
            icon: "checkmark.circle.fill",
            readTimeMinutes: 5,
            intro: "I vecka 36 är fostret ca 47 cm och väger ungefär 2,6 kg. Alla organ är nu mogna och färdiga för livet utanför livmodern. Fyra veckor kvar till beräknat förlossningsdatum.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 36", body: """
Lever och njurar fungerar fullt ut. Immunsystemet är tillräckligt moget för att hantera de flesta vanliga infektioner. Lungorna är mogna. Skallen är fortfarande formbar. Naglar och tånaglar kan vara ganska långa. Fosterrörelserna är nu mer utbytade mot stötande och sträckningar snarare än sparkar — trängsel i livmodern begränsar utrymmet. Rörelserna bör dock fortfarande vara regelbundna.
"""),
                ArticleSection(heading: "Din kropp i vecka 36", body: """
Bäckensmärta och tryck kan vara intensivt nu. Sammandragningar (Braxton-Hicks) är vanliga. Cervix (livmodertappen) börjar mjukna och förkortas — detta kallas mognads- eller ripening-processen. Barnmorskan kan bedöma cervix vid undersökning om det finns klinisk anledning. Slemstoppen kan lossna — det är inte en säker signal om att förlossningen är nära.
"""),
                ArticleSection(heading: "Vad utlöser förlossningen?", body: """
Förlossningens startpunkt styrs av ett komplext samspel av hormoner — fostrets kortisol, mammans oxytocin och prostaglandiner. Ingen vet exakt vad som utlöser starten. Vanliga "knep" som gång, sex och nippling av bröstvårtorna har liten men möjlig effekt (nipling ökar oxytocinfrisättningen). Medicinsk igångsättning erbjuds vid behov, oftast efter fullgången vecka 42 men ibland tidigare vid specifika indikationer.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 36",
                consensus: "Otålighet och spänning blandas med en önskan om att kroppen ska ta hand om resten.",
                quotes: [
                    "Fyra veckor kvar. Varje dag nu är ett äventyr i att undra om det börjar idag.",
                    "Sömnen är som sämst just nu. Men det sägs att kroppen förbereder en för nätterna med bebis."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 37
        Article(
            id: "pregnancy_week_37",
            category: .pregnancy,
            title: "Vecka 37 — Tidigt fullgången",
            subtitle: "Graviditeten räknas nu som tidigt fullgången",
            icon: "star.circle.fill",
            readTimeMinutes: 4,
            intro: "Vecka 37 är en medicinsk milstolpe — graviditeten klassas nu som 'tidigt fullgången' (early term). Fostret är ca 48 cm och väger ungefär 2,9 kg och är i princip redo för livet utanför.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 37", body: """
Trots att graviditeten nu räknas som fullgången sker viktig hjärnmognad ända till vecka 39–40 och under de första åren efter födseln. Barn födda i vecka 37–38 kan ha lite sämre förutsättningar än barn födda vecka 39–40 på mått som skolprestanda och andningsförmåga. Vernix täcker alltjämt huden. Naglarna behöver klippas strax efter födseln. Skallens form formas vid passage genom förlossningskanalen.
"""),
                ArticleSection(heading: "Din kropp i vecka 37", body: """
Livmodern är nu vid maximalt tryck mot ryggen och bukorganen. "Lightning crotch" — plötsliga stickande smärtor i underlivet orsakade av fostrets tryck mot nerver — är vanligt. Halsbränna, andnöd och ryggvärk kulminerar. Energivågen — "reden-instinkten" — kan uppstå med en plötslig och oemotståndlig lust att städa, organisera och förbereda hemmet. Det är normalt och en trevlig sidoeffekt.
"""),
                ArticleSection(heading: "Förlossningens tre tidiga tecken", body: """
Tre klassiska tecken kan signalera att förlossningen börjar: 1) Slemstoppen lossnar (slemig, rosa flytning). 2) Fostervattnet går — en plötslig flöde eller ett läckage. 3) Regelbundna värkar — sammandragningar med tilltagande styrka, intervall kortare än 5 minuter och längd om minst 60 sekunder. Kontakta förlossningsavdelningen vid vattnet, vid blödning eller om du känner att fostret inte rör sig som vanligt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 37",
                consensus: "Reden-instinkten är verklig och välkommen — men det är bra att inte slita ut sig.",
                quotes: [
                    "Städade hela lägenheten på tre timmar i vecka 37. Förstod efteråt att det var reden-instinkten.",
                    "Varje sammandragning satte igång oss. Blev ett falskt alarm fyra gånger."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 38
        Article(
            id: "pregnancy_week_38",
            category: .pregnancy,
            title: "Vecka 38 — Redo för världen",
            subtitle: "Fostret är fullt moget och väntar på rätt ögonblick",
            icon: "gift.fill",
            readTimeMinutes: 4,
            intro: "I vecka 38 är fostret ca 49 cm och väger ungefär 3,1 kg. Alla system är redo. Förlossningen kan starta när som helst nu — 50 % av alla förlossningar sker innan beräknat datum.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 38", body: """
Hjärnan fortsätter att mogna ända in i tredje levnadsåret. Immunsystemet är klart. Tarmarna fylls med mekonium — den första avföringen. Vernix minskar men finns kvar. Lanugo är helt borta. Skallbenen kan nu börja pressas ihop lite (configuration) vid passage. Fostret kan suga, gäspa och koordinera reflexer som är nödvändiga för amning — sugreflexen, rotreflexen.
"""),
                ArticleSection(heading: "Din kropp i vecka 38", body: """
Cervix (livmodertappen) fortsätter mjukna och utplana sig. Braxton-Hicks-värkar är nu täta och kan likna riktiga förlossningsvärkar. Säkraste sättet att skilja dem åt: förlossningsvärkar är regelbundna, intensifieras och försvinner inte vid rörelse. Ont i ryggen kan beror på att fostret rör sig ner i bäckenet. Eventuell slemstoppe kan lossna när som helst.
"""),
                ArticleSection(heading: "Vad händer vid ankomst till förlossningsavdelningen?", body: """
Vid ankomst till förlossningen görs CTG (registrering av fosterhjärta och sammandragningar), vaginal undersökning av barnmorskan (cervixstatus), blodtryck och identifiering. Du erbjuds ett förlossningsrum och din barnmorska presenterar sig. Ta med förlossningsplanen, legitimation, MVC-journalen och förlossningsväskan. Ring i förväg — förlossningsavdelningen kan ge dig råd om det är dags att komma in.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 38",
                consensus: "Vecka 38 är en av de mest intensiva — varje känsla analyseras om det är 'dags'.",
                quotes: [
                    "Varje gång jag fick ont i ryggen trodde vi att det var dags. Gick 10 dagar till.",
                    "Sov med förlossningsväskan vid dörren från vecka 38. Var inte alls överdrivet."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 39
        Article(
            id: "pregnancy_week_39",
            category: .pregnancy,
            title: "Vecka 39 — Fullt fullgången",
            subtitle: "Optimal tidpunkt för födseln",
            icon: "rosette",
            readTimeMinutes: 4,
            intro: "Vecka 39–40 anses vara den optimala tidpunkten för förlossningen. Fostret är ca 50 cm och väger ungefär 3,3 kg. Hjärnmognaden är nu komplett för de grundläggande funktionerna.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 39", body: """
Alla organ fungerar fullt ut. Hjärnan har slutfört sin grundläggande strukturella mognad, om än funktionell mognad pågår i år efter födseln. Immunsystemet är redo. Tarmen är full av mekonium. Naglarna är långa nog att behöva klippas. Lanugo är borta. Vernix finns kvar i hudveck. Fostrets huvud är ofta engagerat (pressas in i bäckenet) hos förstföderskor.
"""),
                ArticleSection(heading: "Din kropp i vecka 39", body: """
Cervix är nu ofta utplanad (effaced) och kan vara 1–3 cm öppen även utan aktivt förlossningsarbete hos omföderskor. Sammandragningarna är täta. Trycket i underlivet är intensivt. Sömnen är svår. Aptiten kan minska. Många upplever en känsla av ro och förberedd fokus inför förlossningen. Lita på din kropp — den vet vad den gör.
"""),
                ArticleSection(heading: "Smärtlindring under förlossningen", body: """
Tillgängliga smärtlindringsmetoder: epiduralbedövning (effektivast, men kan sakta ner förlossningen), lustgas (snabbt, lättstyrt men mindre effektivt), sterilt vatten (injektioner i ryggen, effektivt mot ryggsmärta), akupunktur, TENS (elektrisk stimulering), varmvatten (bad eller dusch) och psykoprofylax (andning och fokus). Du har rätt att be om smärtlindring när du vill — det är ett medicinskt val, inte ett prestige-val.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 39",
                consensus: "Smärtlindringen diskuteras flitigt — de flesta ångrar inte sin epidural.",
                quotes: [
                    "Planerade att klara mig utan epidural. Fick epidural. Ångrar ingenting.",
                    "Lustgasen hjälpte mig hålla fokus och andas rätt. Kombinerade med varmvattenbad."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 40
        Article(
            id: "pregnancy_week_40",
            category: .pregnancy,
            title: "Vecka 40 — Beräknat förlossningsdatum",
            subtitle: "Beräknat datum är idag — men de flesta väntar längre",
            icon: "calendar.badge.clock",
            readTimeMinutes: 4,
            intro: "Vecka 40 är det beräknade förlossningsdatumet (BFD). Men bara 5 % av alla barn föds exakt på beräknat datum — 80 % föds mellan vecka 38–42. Lugn och tålamod är det viktigaste nu.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 40", body: """
Fostret är nu fullt moget i alla biologiska avseenden. Naglarna kan vara långa. Huden kan börja bli lite torr när vernix försvinner. Skalpen kan ha riklig hårväxt. Ryggmärgen och hjärnan producerar de hormoner som snart utlöser förlossningen. Fostrets position är avgörande för hur förlossningen fortskrider — normalt läge är huvud nedåt, lite åt vänster.
"""),
                ArticleSection(heading: "Din kropp i vecka 40", body: """
Det är normalt att graviditeten fortsätter förbi beräknat datum. Upp till 42 veckor är acceptabelt ur medicinsk synvinkel med normal fosterövervakning. MVC-kontrollerna tätnar — CTG, ultraljud för att bedöma fostervattensmängd och fostertillstånd görs varannan–var tredje dag. Kontakta alltid förlossningsavdelningen vid minskade rörelser, blödning, vattning eller värkar.
"""),
                ArticleSection(heading: "Igångsättning vid överskridande av beräknat datum", body: """
Vid vecka 41+0 erbjuds de flesta kvinnor igångsättning om förlossningen inte startat spontant. Igångsättning sker med prostaglandingel (som mjukar upp och öppnar cervix), ballong (mekanisk cervixdilatation) eller syntetiskt oxytocin via dropp. Metoden väljs utifrån cervixstatus. Igångsatta förlossningar tar generellt lite längre tid men resulterar i lika positiva utfall som spontana.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser kring beräknat datum",
                consensus: "De flesta föds inte på BFD — att hantera förväntningarna är en konst i sig.",
                quotes: [
                    "BFD kom och gick. Tre dagar senare gick vattnet klockan 3 på natten.",
                    "Var igångsatt i vecka 41+2. Lite jobbigt att inte det hände spontant, men allt gick bra."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 41
        Article(
            id: "pregnancy_week_41",
            category: .pregnancy,
            title: "Vecka 41 — Över beräknat datum",
            subtitle: "Tät uppföljning och förberedelse för igångsättning",
            icon: "clock.badge.exclamationmark",
            readTimeMinutes: 4,
            intro: "Vecka 41 innebär att graviditeten gått förbi det beräknade datumet. Fostret mår i de allra flesta fall bra, men kontrollerna tätnar markant. Igångsättning diskuteras nu aktivt.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 41", body: """
Fostret fortsätter att växa, men placentas funktion börjar sakta mattas av. Fostervattnet kan minska i mängd (oligohydramnios). Naglarna är nu ofta långa och lite gula. Huden kan vara torr och lagad. Barnet är fullt moget men det är viktigt att övervaka placentans funktion noggrant. Mekonium i fostervatten förekommer hos ca 15–20 % av posttermsgravida.
"""),
                ArticleSection(heading: "Din kropp i vecka 41", body: """
Otålighet, oro och sömnbrist toppar. Det är normalt att vara frustrerad. Kontrollerna inkluderar CTG varannan dag och ultraljud för fostertillstånd. Cervixmognad bedöms regelbundet. Du kan erbjudas membranstimulation — barnmorskan för in ett finger och separerar fosterhinnorna från livmoderväggen, vilket kan utlösa prostaglandinproduktion. Det kan göra lite ont men är ofarligt.
"""),
                ArticleSection(heading: "Risker med postterm graviditet och beslut om igångsättning", body: """
Risken för fostersuffokation och mekoniumaspiration ökar något efter vecka 41. Placenta åldras och dess funktion försämras. Studier (ARRIVE-studien och liknande) visar att igångsättning vid vecka 41 ger lika bra eller bättre utfall än avvaktan för både mor och barn. De flesta förlossningskliniker i Sverige erbjuder igångsättning vid 41+0 till 41+5. Du har rätt att ställa frågor och vara delaktig i beslutet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 41",
                consensus: "Otåligheten är total — men de flesta är tacksamma för tät uppföljning och ett tryggt system.",
                quotes: [
                    "CTG varannan dag gav mig ro — vi fick höra hjärtat slå och personalen sa att allt var fint.",
                    "Membranstimulationen fungerade! Fick värkar samma natt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

        // MARK: Vecka 42
        Article(
            id: "pregnancy_week_42",
            category: .pregnancy,
            title: "Vecka 42 — Igångsättning planeras",
            subtitle: "Graviditeten avslutas nu medicinsk om ej förlöst",
            icon: "exclamationmark.triangle.fill",
            readTimeMinutes: 4,
            intro: "Vecka 42 är den medicinska gränsen för graviditeten — de allra flesta förlossningskliniker igångsätter nu om förlossning inte skett spontant. Fostret mår i de flesta fall bra, men risken för komplikationer stiger.",
            sections: [
                ArticleSection(heading: "Fosterutveckling vecka 42", body: """
Fostret väger nu ca 3,5–4 kg och är ca 51 cm. Huden är ofta torr, avflagnad och gulfärgad (macererad) på grund av att vernix försvunnit. Naglarna är långa och kan vara gulfärgade av mekonium. Risken för att placenta inte längre ger fostret tillräcklig näring och syre ökar. Fostervattnets mängd minskar. Mekonium i fostervatten förekommer hos upp till 25 %.
"""),
                ArticleSection(heading: "Din kropp i vecka 42", body: """
Om du fortfarande är gravid i vecka 42 är det med stor sannolikhet för att du ligger i kö för igångsättning eller att planeringen just pågår. Kroppen är nu redo att föda — cervix är mjuk och utplanad. Lugnet och tröttheten är totala. Det är viktigt att fortsätta räkna rörelserna varje dag och omgående kontakta sjukhuset om de minskar.
"""),
                ArticleSection(heading: "Förlossningen och det som väntar efter", body: """
Oavsett hur förlossningen sker — spontan, igångsatt eller kejsarsnitt — är slutmålet ett friskt barn och en välmående förälder. Hudhud-kontakt direkt efter födseln är viktigt för barnets temperaturreglering, sugreflex och anknytning. Det nyfödda barnets apgar-poäng mäts vid 1 och 5 minuter. Förlossningen är bara början — sedan börjar det stora äventyret som förälder. Ni är redo.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar sina upplevelser från vecka 42",
                consensus: "Vecka 42 är en blandning av utmattning, hopp och förväntan — mötet med barnet är nära.",
                quotes: [
                    "Igångsatt i vecka 42. Det var intensivt men jag fick det fina mötet med mitt barn jag drömde om.",
                    "Tänkte aldrig att jag skulle nå vecka 42. Men det gick. Och det gick bra."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen"]
        ),

    ]
}

// MARK: - Baby Week Guides (v.1–v.52)

extension Article {
    static let babyWeekGuides: [Article] = [

        // MARK: Vecka 1
        Article(
            id: "baby_week_1",
            category: .health,
            title: "Vecka 1 — De första dagarna hemma",
            subtitle: "Allt är nytt — för er båda",
            icon: "house.fill",
            readTimeMinutes: 4,
            intro: "Den första veckan hemma med ett nyfött barn är intensiv. Kroppen återhämtar sig, amningen startar och det lilla livet lär sig världen.",
            sections: [
                ArticleSection(heading: "Vad din bebis upplever", body: """
Nyfödda ser bäst på 20–30 cm avstånd — precis lagom för att se ditt ansikte under amning. De känner igen mammas röst och doft redan från födseln. Reflexerna styr mycket: rooting-reflex (söker bröstet), sugreflex och Moro-reflex (rycker till vid ljud). Bebisen sover 16–18 timmar per dygn, men i korta pass om 2–4 timmar.
"""),
                ArticleSection(heading: "Amning och matning", body: """
Råmjölk (kolostrum) är det första som produceras — tjock, gulaktig och extremt näringsrik. Bebisen behöver mata 8–12 gånger per dygn, ungefär var 2–3 timme. Räkna blöjor: minst 1 blöt blöja dag 1, 2 dag 2 osv — det visar att bebisen får i sig tillräckligt.
"""),
                ArticleSection(heading: "Ta hand om dig själv", body: """
Födslosmärta efteråt kan vara kraftig, oavsett förlossningssätt. Värktabletter som Ipren och Alvedon kan kombineras. Sår och stygn: ta bort blöt bindel snabbt, lufta om möjligt, ring BB om rodnad eller feber.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar från den första veckan",
                consensus: "Det är kaotiskt och magiskt på samma gång. Inget är perfekt och det behöver det inte vara.",
                quotes: [
                    "Jag grät mer än bebisen de första tre dagarna.",
                    "Ingen förberedde oss på hur svår amningen var — men det löste sig till vecka 2."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 2
        Article(
            id: "baby_week_2",
            category: .health,
            title: "Vecka 2 — Navelsträngen faller av",
            subtitle: "Bebisen börjar gå upp i vikt igen",
            icon: "staroflife.fill",
            readTimeMinutes: 4,
            intro: "I vecka 2 stabiliseras rutinerna lite. Navelsträngsresterna torkar och faller av, och bebisen börjar ta igen den vikt den förlorade efter födseln.",
            sections: [
                ArticleSection(heading: "Bebisens utveckling", body: """
Nyfödda tappar normalt 5–10 % av födslovikten de första dagarna — det är helt normalt. Nu börjar vikten återhämta sig. Navelsträngsresterna mörknar, krymper och faller vanligen av inom dag 7–14. Håll området torrt och rent, undvik att täcka med blöjan. Gulsot (gulfärgad hud) syns hos många nyfödda och är vanligen ofarligt men ska följas av BVC.
"""),
                ArticleSection(heading: "Matning och signaler", body: """
Bebisen kommunicerar hunger med subtila signaler innan skriket kommer: rotar med munnen, för hand till munnen, rör sig rastlöst. Lär dig dessa tidiga tecken — det gör matningarna lugnare. Amning etableras nu på allvar; bröstmjölksproduktionen styrs av hur ofta bebisen suger.
"""),
                ArticleSection(heading: "Praktiska råd", body: """
Bada bebisen högst 2–3 gånger i veckan med ljummet vatten — huden är känslig. Klä bebisen i ett lager mer än du själv bär. Kontrollera att nacken inte böjs framåt i bilbarnstolen. Ring BVC om navelsträngen luktar illa eller ser inflammerad ut.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 2",
                consensus: "Navelsträngen och gulsoten oroar många — men de flesta löser sig utan åtgärd.",
                quotes: [
                    "Navelsträngen föll av dag 10. Lite läskigt men gick bra!",
                    "BVC mätte gulsoten och sa att det var normalt. Stor lättnad."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 3
        Article(
            id: "baby_week_3",
            category: .health,
            title: "Vecka 3 — Kolik och kväll­skrik",
            subtitle: "Det svåraste kan börja nu",
            icon: "exclamationmark.bubble.fill",
            readTimeMinutes: 4,
            intro: "Vecka 3 är för många den tuffaste — bebisen kan börja skrika intensivt på kvällar utan uppenbar orsak. Det kallas kolik och är vanligt men utmattande.",
            sections: [
                ArticleSection(heading: "Vad är kolik?", body: """
Kolik definieras som gråt mer än 3 timmar per dag, mer än 3 dagar i veckan, hos ett i övrigt friskt barn. Det drabbar upp till 20 % av alla nyfödda. Orsaken är okänd men teorier inkluderar omogen tarm, gasbildning och överstimulering. Det brukar toppa runt vecka 6 och försvinna av sig självt runt vecka 12–16.
"""),
                ArticleSection(heading: "Lindra och hantera", body: """
Håll bebisen upprätt efter matning och rapa noga. Prova magmassage medsols. Vitt brus (dammsugare, fläkt) kan ha lugnande effekt. Bär bebisen tätt mot kroppen i bärsjal. Skifta med partnern så ni inte båda är vid bristningsgränsen samtidigt.
"""),
                ArticleSection(heading: "Ta hand om er själva", body: """
Kolik är ingen föräldras fel. Lägg ner bebisen säkert och gå ut i 5 minuter om du behöver. Ring BVC om du är orolig eller behöver stöd — det är därför de finns. Skaka aldrig ett gråtande barn.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om kolik",
                consensus: "Det går över. Det lovar alla som tagit sig igenom det — men det hjälper föga när man är mitt i det.",
                quotes: [
                    "Vi turades om varje timme. Det räddade oss.",
                    "Vitt brus på YouTube var en livräddare kl 02 på natten."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 4
        Article(
            id: "baby_week_4",
            category: .health,
            title: "Vecka 4 — En månads bebis",
            subtitle: "Första kontroll på BVC",
            icon: "calendar.badge.checkmark",
            readTimeMinutes: 4,
            intro: "Bebisen fyller en månad och kroppen har anpassat sig till livet utanför magen. BVC-kontrollen ger svar på hur tillväxten går.",
            sections: [
                ArticleSection(heading: "Bebisens utveckling", body: """
Vid en månad kan bebisen lyfta huvudet kort stund i magläge. Ögonen börjar följa rörliga föremål. Sociala leenden är fortfarande reflexmässiga men verkliga leenden är nära. Bebisen känner igen föräldrars röster och lugnar sig vid dem. Händerna är oftast knutna.
"""),
                ArticleSection(heading: "Sömn och rytm", body: """
Dygnsrytmen är fortfarande kaotisk — bebisen skiljer inte på dag och natt. Exponering för dagsljus på dagen och mörker på natten hjälper det biologiska klocksystemet mogna. Sovpass är 2–4 timmar långa. Totalt behöver bebisen 14–17 timmars sömn per dygn.
"""),
                ArticleSection(heading: "BVC-besöket", body: """
Vid fyraveckorskontrollen mäts längd, vikt och huvudomfång. Läkaren lyssnar på hjärtat, kontrollerar höfter och reflexer. Ta med din blå bok (hälsoboken). Förbered frågor i förväg — om amning, sömn, navelstränge, gulsot. BVC är din viktigaste resurs det första året.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om ettmånaderskollen",
                consensus: "BVC-besöket ger trygghet — att höra att allt ser bra ut är ovärderligt.",
                quotes: [
                    "Vikten hade stigit bra och barnläkaren sa att allt var perfekt. Jag grät av lättnad.",
                    "Kom med en lista på 15 frågor. BVC-sköterskan svarade på alla utan att stressa."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 5
        Article(
            id: "baby_week_5",
            category: .sleep,
            title: "Vecka 5 — Sömnmönster förändras",
            subtitle: "Längre vakna perioder på dagen",
            icon: "moon.stars.fill",
            readTimeMinutes: 3,
            intro: "Runt vecka 5 börjar bebisen ha längre vakna perioder på dagen. Det är ett tecken på neurologisk mognad — och ett bra tillfälle att börja forma lite rutiner.",
            sections: [
                ArticleSection(heading: "Bebisens utveckling", body: """
Bebisen är nu mer alert och tittar aktivt runt. Huvudkontrollen förbättras i magläge. Det sociala leendet — ett äkta, avsiktligt leende som svar på ditt ansikte — kan dyka upp runt denna tid och är ett av de första kommunikativa milstolparna. Bebisen börjar också producera tårar vid gråt.
"""),
                ArticleSection(heading: "Sömn och vakenhetsfönster", body: """
Vid 5 veckor klarar bebisen vanligen 45–60 minuters vakenhet innan trötthetssignaler dyker upp. Signaler: gnider ögonen, vänder bort blicken, gnäller. Lägg ner innan bebisen är övertrött — övertrötthet gör det svårare att somna. Nattpasset är fortfarande 2–3 timmar långa.
"""),
                ArticleSection(heading: "Lugna aktiviteter", body: """
Ansiktsimitation fungerar redan nu — räck ut tungan och se om bebisen imiterar. Svart-vita mönster fångar uppmärksamheten bra. Sång och mjuk tal stimulerar språkutvecklingen. Undvik överstimulering: ett par minuter aktiv lek räcker innan paus behövs.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 5",
                consensus: "Det första riktiga leendet är ett av föräldraskapets absolut finaste ögonblick.",
                quotes: [
                    "Bebisen log på riktigt i dag. Jag smälte totalt.",
                    "Äntligen lite längre pass nattetid. Kände mig som en ny människa."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 6
        Article(
            id: "baby_week_6",
            category: .feeding,
            title: "Vecka 6 — Amningskrisen",
            subtitle: "Tillväxtsprång och ökad hunger",
            icon: "drop.fill",
            readTimeMinutes: 4,
            intro: "Vecka 6 är känd för ett av de första tillväxtsprången — bebisen vill mata oftare, verkar aldrig nöjd och många mammor undrar om mjölken räcker.",
            sections: [
                ArticleSection(heading: "Tillväxtsprång", body: """
Under tillväxtsprång ökar bebisens näringsbehov plötsligt. Kroppen signalerar detta med intensiv hunger och mer skrikighet. Det är inte ett tecken på att mjölken tagit slut — det är tvärtom: frekvent amning triggar ökad mjölkproduktion. Språnget brukar vara över på 2–3 dagar.
"""),
                ArticleSection(heading: "Amningens anpassning", body: """
Bröstmjölksproduktionen styrs av utbud och efterfrågan. Ju mer bebisen suger, desto mer mjölk produceras. Under språnget: amma på begäran, dygnet runt om det behövs. Undvik att ge ersättning utan rådgivning — det kan minska den naturliga produktionen. Kontakta BVC eller amningsrådgivare om du är orolig.
"""),
                ArticleSection(heading: "Återhämtning och stöd", body: """
Vecka 6 är också känd som en topp för efterfödseldepression — hormonerna sjunker och sömnbristen är på topp. Prata med partnern, BVC-sköterskan eller barnmorskan om du mår dåligt. Det är vanligt och det finns hjälp att få.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om sextaveckorskrisen",
                consensus: "Nästan alla upplever det och undrar om mjölken räcker. Den gör det — håll ut i tre dagar.",
                quotes: [
                    "Ammade var 45:e minut i två dagar. Trodde jag höll på att bli galen. Sen lade det sig.",
                    "Amningsrådgivaren på BVC räddade amningen för oss."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 7
        Article(
            id: "baby_week_7",
            category: .sleep,
            title: "Vecka 7 — Sömnassociationer",
            subtitle: "Hur bebisen lär sig somna",
            icon: "bed.double.fill",
            readTimeMinutes: 4,
            intro: "Runt vecka 7 börjar bebisens sömnmönster bli mer förutsägbara. Det är ett bra tillfälle att förstå sömnassociationer och hur de formas.",
            sections: [
                ArticleSection(heading: "Vad är sömnassociationer?", body: """
En sömnassociation är det bebisen associerar med att somna: amning, rörelse, sugande, förälderns närvaro. Det är inte negativt i sig — alla har sömnassociationer. Problemet uppstår när bebisen vaknar mellan sömnfaser och inte kan somna om utan hjälp. Vid 7 veckor är det normalt att bebisen behöver din hjälp för att somna.
"""),
                ArticleSection(heading: "Dag- och nattskillnad", body: """
Melatoninproduktionen mognar de första månaderna. Hjälp bebisen förstå skillnaden: dagsömn i ljust rum med bakgrundsljud, nattsömn i mörkt tyst rum. Skillnaden i miljö hjälper det biologiska klocksystemet kalibreras. Försök ha en enkel kvällsrutin: bad, amning, sång, lägg ner.
"""),
                ArticleSection(heading: "Praktiska tips", body: """
Vaggning och amning till sömns är helt okej nu. Det går att ändra sömnassociationer senare. Fokusera på att bebisen sover tillräckligt totalt — kvaliteten på hur den somnar spelar mindre roll i detta skede. Håll egna sömnbehov i åtanke: sov när bebisen sover om det är möjligt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om sömn i vecka 7",
                consensus: "Gör vad som fungerar nu. Det är för tidigt att stressa om sömnrutiner.",
                quotes: [
                    "Ammade till sömns varje gång. Fungerade perfekt tills 6 månader.",
                    "Hittade en sömnrytm som fungerade — lade ner vid första trötthetstecknet."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 8
        Article(
            id: "baby_week_8",
            category: .feeding,
            title: "Vecka 8 — Flaskintroduktion",
            subtitle: "Om du vill ge flaska vid sidan av amning",
            icon: "waterbottle.fill",
            readTimeMinutes: 3,
            intro: "Vecka 8 är ofta ett lämpligt tillfälle att introducera flaska om du ammar och vill ge en annan person möjlighet att mata, eller planerar att börja arbeta.",
            sections: [
                ArticleSection(heading: "Bebisens utveckling", body: """
Vid 8 veckor är bebisen mer social och responsiv. Ögonkontakten är tydligare och bebisen börjar "prata" tillbaka — kurrar och låter som svar på ditt tal. Magkontroll i magläge förbättras och många klarar att lyfta huvudet 45 grader. Fingrarna börjar rätas ut och händerna studeras med stor intresse.
"""),
                ArticleSection(heading: "Flaska vid sidan av amning", body: """
Vänta minst 4–6 veckor med flaska om du ammar, för att inte störa amningsetableringen. Välj en flaska med långsamt flöde (slow-flow napp). Låt en annan person ge den första flaskan — bebisen kan vägra från mamman som luktar bröstmjölk. Börja med avsammad bröstmjölk så smaken är bekant.
"""),
                ArticleSection(heading: "Om bebisen vägrar flaskan", body: """
Prova olika napptyper. Ge flaskan när bebisen är lagom hungrig — inte desperat hungrig. Försök i rörelse (gå runt). Ge inte upp för snabbt — det kan ta 10–20 försök. Konsultera BVC om det fortsätter vara svårt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om flaskintroduktion",
                consensus: "Många barn vägrar flaskan länge men de flesta accepterar den till slut — tålamod är nyckeln.",
                quotes: [
                    "Försökte i tre veckor. Dag 18 tog hon flaskan utan problem.",
                    "Min man gav alltid flaskan. Bebisen tog aldrig flaskan från mig."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 9
        Article(
            id: "baby_week_9",
            category: .development,
            title: "Vecka 9 — Sociala leenden",
            subtitle: "Kommunikationen blommar ut",
            icon: "face.smiling.fill",
            readTimeMinutes: 4,
            intro: "Runt vecka 9 exploderar den sociala kommunikationen. Bebisen ler stort och avsiktligt, kurrar och svarar på ditt tal — det är startskottet för det som ska bli ett rikt språk.",
            sections: [
                ArticleSection(heading: "Social och kognitiv utveckling", body: """
Det sociala leendet är nu konsekvent och avsiktligt. Bebisen söker ögonkontakt aktivt och svarar med ljud och mimik. Detta är grunden för turtagning — den växelvis kommunikation som är ryggraden i mänskligt språk. Bebisen känner igen föräldrarnas ansikten och prefererar dem framför främlingar. Kortisol (stresshormonet) sjunker när bebisen ser ett känt ansikte.
"""),
                ArticleSection(heading: "Sömn vid 9 veckor", body: """
Nätterna börjar ofta bli lite längre — en del bebisar sover 4–5 timmar i ett sträck. Det är fortfarande normalt att vakna 2–3 gånger per natt. Dagsömnen sker i 3–4 kortare pass. Vakenhetsfönstret är nu 60–90 minuter. Att följa vakenhetsfönstren minskar övertrötthet och gör det lättare att lägga ner bebisen.
"""),
                ArticleSection(heading: "Stimulera utvecklingen", body: """
Prata med bebisen hela dagen — kommentera vad du gör, sjung, berätta sagor. Det spelar ingen roll vad du säger, det är sättet du säger det på som bygger hjärnan. Ansikts- och röstimitation stimulerar spegelneuronet. Magläge varje dag bygger styrka för framtida motorik.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 9",
                consensus: "Leendet och kurret gör allt slit värt det. Många beskriver det som att bebisen äntligen 'vaknar'.",
                quotes: [
                    "Hon ler nu varje gång jag lutar mig ner. Hjärtat exploderar.",
                    "Sov 5 timmar i ett sträck! Jag vaknade i panik och kollade att han andades."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 10
        Article(
            id: "baby_week_10",
            category: .development,
            title: "Vecka 10 — Ögonkontakt och följning",
            subtitle: "Bebisen spårar rörelser med blicken",
            icon: "eye.fill",
            readTimeMinutes: 3,
            intro: "Vid 10 veckor har synen förbättrats markant. Bebisen följer nu rörliga föremål och ansikten med blicken och börjar förstå att saker existerar också när de rör sig.",
            sections: [
                ArticleSection(heading: "Synutveckling", body: """
Vid födseln var synen suddig och begränsad till 20–30 cm. Nu kan bebisen följa ett föremål som rör sig 180 grader — från sida till sida. Färgseendet utvecklas: rött och grönt urskiljs bäst. Djupseendet börjar mogna. Bebisen kan nu hålla blicken på ett ansikte i 5–10 sekunder utan att tappa fokus.
"""),
                ArticleSection(heading: "Motorisk utveckling", body: """
I magläge lyfter bebisen nu huvudet 45–90 grader och håller det uppe längre stunder. Armarna används som stöd. Händerna öppnas och stängs och bebisen kan kort greppa ett föremål som placeras i handen. Sparkarna är kraftfulla och koordinerade.
"""),
                ArticleSection(heading: "Lekar och stimulans", body: """
Hängsaker (babygym) är perfekt nu — bebisen tränar ögon-hand-koordination. Håll ett ljust föremål framför bebisen och flytta det sakta — träna ögonföljningen. Sjung samma sånger upprepade gånger — repetition bygger minnesfunktionen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 10",
                consensus: "Babygymet är en hit — ger en stunds frihet och tränar bebisen på samma gång.",
                quotes: [
                    "Han stirrade på det röda hjärtat på babygymet i tio minuter. Koncentrationen!",
                    "Bebisen 'pratar' nu hela tiden. Jag pratar tillbaka och hon tittar så nöjd ut."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 11
        Article(
            id: "baby_week_11",
            category: .development,
            title: "Vecka 11 — Röstljud och skratt",
            subtitle: "De första skratten är nära",
            icon: "mic.fill",
            readTimeMinutes: 3,
            intro: "Runt vecka 11 börjar bebisen producera en rikare palett av ljud — kurr, gurgel och snart de första skratten. Kommunikationen är nu tydligt social.",
            sections: [
                ArticleSection(heading: "Språk och kommunikation", body: """
Bebisen kurrar och gagglar som svar på ditt tal — turtagning på sin allra enklaste nivå. Vokaler dominerar: 'aaa', 'ooo', 'uuu'. Detta är grundstenarna för talat språk. Bebisen pausar och väntar på din respons, precis som i ett riktigt samtal. Gensvar från föräldrar är den starkaste drivkraften för språkutveckling.
"""),
                ArticleSection(heading: "Sömn och tillväxt", body: """
Många bebisar har nu ett längre nattpass på 5–6 timmar. Dagsömnens mönster börjar också bli lite mer förutsägbart med 3 sovpass per dag. Bebisens tillväxt är fortfarande snabb — 150–200 g per vecka är normalt.
"""),
                ArticleSection(heading: "Praktiska tips", body: """
Läs högt varje dag — det stimulerar hörseln, ordförrådet och ögonkontakten. Böcker med kontrasterande bilder och enkla former är bäst nu. Bär bebisen i bärsjal under promenader — närheten stärker anknytningen och stimulerar vestibularissinnet (balanssinnet).
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 11",
                consensus: "Att höra bebisen 'svara' i ett samtal är en av de finaste stunderna tidigt.",
                quotes: [
                    "Han kurrade tillbaka varje gång jag sa något. Vi höll på i tjugo minuter.",
                    "Första lilla fnisset i dag. Jag filmade det förstås."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 12
        Article(
            id: "baby_week_12",
            category: .development,
            title: "Vecka 12 — Tre månader!",
            subtitle: "Kolik vänder och bebisen vaknar",
            icon: "3.circle.fill",
            readTimeMinutes: 4,
            intro: "Tre månader är en vändpunkt för de flesta familjer. Kolik brukar avta, bebisen är mer vaken och responsiv, och nätterna börjar bli lite mer mänskliga.",
            sections: [
                ArticleSection(heading: "Bebisens milstolpar vid 3 månader", body: """
Vid tre månader håller bebisen upp huvudet stabilt i magläge och vilar på underarmarna. Händerna studeras fascinerat. Bebisen ler konsekvent som svar på ditt ansikte och börjar skratta. Rooting-reflexen är borta — amning styrs nu av avsikt, inte reflex. Bebisen kan kortvarigt underhålla sig själv med ett hängande föremål.
"""),
                ArticleSection(heading: "Sömnutveckling", body: """
Melatoninproduktionen mognar och nätterna blir ofta mer förutsägbara. Många bebisar sover ett längre pass på 6–8 timmar runt denna ålder, om de är stora nog och växer bra. Det är fortfarande normalt att vakna 1–2 gånger. Dagsömnen konsolideras mot tre pass.
"""),
                ArticleSection(heading: "BVC-kontroll vid 3 månader", body: """
BVC-besöket vid 3 månader inkluderar kontroll av syn och hörsel (enkel screening), rörelseförmåga, socialt samspel och viktutveckling. Vaccinationer mot difteri, stelkramp, kikhosta, polio och Hib ges nu. Prata gärna med BVC-sköterskan om amning, sömn och hur ni som föräldrar mår.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om treveckorssskiftet",
                consensus: "Tre månader är en milstolpe som de flesta föräldrar pekar på som vändpunkten — lite lättare, lite mer glädje.",
                quotes: [
                    "Det var som att koliken bara försvann över en natt. Inte helt, men nästan.",
                    "Vaccineringen var jobbig men gick fort. Bebisen var gnällig en dag sen var det över."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 13
        Article(
            id: "baby_week_13",
            category: .development,
            title: "Vecka 13 — Händerna upptäcks",
            subtitle: "Grepp och koordination tränas",
            icon: "hand.raised.fill",
            readTimeMinutes: 3,
            intro: "Vid 13 veckor fastnar bebisen helt för sina egna händer. De studeras, förs till munnen och börjar användas för att slå mot föremål — det är starten på avsiktlig motorik.",
            sections: [
                ArticleSection(heading: "Motorisk utveckling", body: """
Bebisen för händerna mot varandra och till munnen. Suger på knogarna och fingrarna — det är en del av munmotorisk utforskning, inte nödvändigtvis hungerssignal. Kan slå mot ett hängande föremål men kan ännu inte koordinera ett precist grepp. Benen sparkar kraftfullt och koordinerat.
"""),
                ArticleSection(heading: "Matning och sömn", body: """
Amningsfrekvensen minskar lite — bebisen är effektivare och klarar sig på 6–8 amningar per dygn. Natten kan ha ett långt pass plus 1–2 uppvaknanden. Bebisen börjar visa tydligare trötthetstecken och vakenhetsfönstret är nu upp till 90 minuter.
"""),
                ArticleSection(heading: "Stimulans och lek", body: """
Hängande leksaker i olika texturer är perfekt nu — bebisen vill ta på och utforska. Prova rattlar som bebisen kan hålla i och skaka. Sjung sånger med handrörelser — det kopplar samman ljud, rörelse och social interaktion.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 13",
                consensus: "Att se bebisen avsiktligt sträcka sig efter något är ett av de första tecknen på vilja och intention.",
                quotes: [
                    "Hon slog på bjällran och förvånades av ljudet. Sen slog hon igen med flit!",
                    "Händerna i munnen hela tiden — jag lärde mig skilja på hunger och utforskning."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 14
        Article(
            id: "baby_week_14",
            category: .development,
            title: "Vecka 14 — Fyra månaders bebis",
            subtitle: "Droppande dregel och kraftfulla rullningar",
            icon: "4.circle.fill",
            readTimeMinutes: 4,
            intro: "Runt fyra månader blommar bebisens personlighet ut. Skratten är nu fulltoniga, dregel­produktionen ökar (tänderna är på väg långt ned) och rullningar från mage till rygg kan dyka upp.",
            sections: [
                ArticleSection(heading: "Motorik och rullning", body: """
Bebisen lyfter sig på utsträckta armar i magläge — en push-up! Rullning från mage till rygg (och vice versa) sker nu hos många. Lägg alltid bebisen på ett säkert underlag — rullningar kan komma oväntat. Greppet börjar bli mer avsiktligt: bebisen sträcker sig aktivt efter föremål och lyckas ibland.
"""),
                ArticleSection(heading: "Dregel och tandning", body: """
Dregel är inte alltid ett tecken på tänder — salivkörtlarna är aktiva länge innan tänder bryter fram. Första tänderna dyker vanligen upp 4–7 månaders ålder. Tuggandet på allt och allt är ett sätt att utforska världen och lindra det tryck som tänderna skapar under tandköttet.
"""),
                ArticleSection(heading: "Sömn vid 4 månader — regressen", body: """
Fyramånadersregressen är verklig och dokumenterad. Den neurologiska omstruktureringen av sömnarkitekturen gör att bebisen vaknar vid varje sovfasövergång. Det är övergående men kan vara utmattande. Håll rutinerna konsekventa. Regressen varar vanligen 2–6 veckor.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om fyramånaders­regressen",
                consensus: "De flesta hörde om den och hoppades den inte skulle drabba dem. Den gjorde det. Men den gick över.",
                quotes: [
                    "Vaknade varje 45:e minut i tre veckor. Trodde att jag aldrig skulle sova igen.",
                    "Fullt skratt för första gången i dag — allt är förlåtet."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 15
        Article(
            id: "baby_week_15",
            category: .development,
            title: "Vecka 15 — Grepp och utforskande",
            subtitle: "Allt hamnar i munnen",
            icon: "hand.point.up.left.fill",
            readTimeMinutes: 3,
            intro: "Vid 15 veckor tar bebisens nyfikenhet ett stort kliv. Föremål greppas, vrids och förs direkt till munnen — munnen är det viktigaste utforskningsverktyget.",
            sections: [
                ArticleSection(heading: "Kognitiv och motorisk utveckling", body: """
Bebisen griper nu aktivt efter föremål med hela handen (palmargrepp). Föremål förs till munnen och utforskas med tungan och läpparna. Orsak-verkan börjar förstås: bebisen lär sig att skakande av en rattel ger ett ljud. Ansiktsuttrycken är nu rika och varierade.
"""),
                ArticleSection(heading: "Sömn och dagsrytm", body: """
Dagsömnen börjar ofta konsolideras mot tre tydligare pass runt dessa veckor. Vakenhetsfönstret är upp till 90–120 minuter. Kvällsrutiner hjälper bebisen att varva ner — ett bad, en amning och några minuter med lugn sång gör skillnad.
"""),
                ArticleSection(heading: "Säkerhet", body: """
Nu när bebisen griper aktivt är det dags att se över miljön: inga små föremål inom räckhåll, inga snören eller sladdar i närheten av sovplatsen. Bebisen kan rulla om — lämna aldrig ensam på skötbordet eller soffan.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 15",
                consensus: "Allt hamnar i munnen — säkerheten tar ett nytt steg.",
                quotes: [
                    "Fick byta till säkrare grejar på babygymet. Drog ner det på sig.",
                    "Fascinationen för händerna är oändlig. Stirrar på dem som om det vore en film."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 16
        Article(
            id: "baby_week_16",
            category: .development,
            title: "Vecka 16 — Spegeln fascinerar",
            subtitle: "Bebisen möter sig själv för första gången",
            icon: "mirror.side.left",
            readTimeMinutes: 3,
            intro: "Runt 16 veckor fascineras bebisen av speglar. De förstår ännu inte att det är de själva de ser, men reaktionen — leenden, pratkande mot spegeln — är en viktig social och kognitiv milstolpe.",
            sections: [
                ArticleSection(heading: "Social och kognitiv utveckling", body: """
Bebisen reagerar på sitt eget spegelreflexen med glädje och nyfikenhet. Den sociala responsiviteten är nu välutvecklad: bebisen ler, skrattar och 'pratar' i samspel. Främlingsångest börjar inte förrän 6–9 månader — nu är bebisen fortfarande glad mot de flesta. Bebisen börjar förstå att föräldrar finns kvar även när de inte syns (permanens börjar anläggas).
"""),
                ArticleSection(heading: "Matning vid 4 månader", body: """
Amningsfrekvensen stabiliseras runt 5–7 gånger per dygn. Bebisen är effektivare och amningspassen kortare. Nattamningar är fortfarande normala och fysiologiskt befogade. Vänta med introduktionen av fast föda till 6 månaders ålder — WHO och svenska råd rekommenderar detta.
"""),
                ArticleSection(heading: "Lek och stimulans", body: """
Speglar i lekområdet stimulerar social kognition. Böcker med ansikten och kontrasterande bilder fascinerar. Bubbelbad och puttlekar i vatten stärker sensorisk integration. Sjung och läs varje dag — repetitionen bygger minnesfunktionen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 16",
                consensus: "Spegeln är ett billigt men fantastiskt leksak — bebisen är aldrig uttråkad framför den.",
                quotes: [
                    "Han skrattar åt sig själv i spegeln. Bästa tingen i världen.",
                    "Fyramånaders­kontroll på BVC gick bra. Läkaren var nöjd med allt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 17
        Article(
            id: "baby_week_17",
            category: .development,
            title: "Vecka 17 — Sittande med stöd",
            subtitle: "Core-styrkan byggs",
            icon: "figure.seated.seatbelt",
            readTimeMinutes: 3,
            intro: "Runt 17 veckor börjar bebisen sitta med stöd och njuta av det upprätta perspektivet. En helt ny vy öppnar sig — och med den kommer ny nyfikenhet.",
            sections: [
                ArticleSection(heading: "Motorisk utveckling", body: """
Bebisen håller nu upp huvudet stabilt utan stöd. Med stöd i ryggen kan den sitta upprätt i korta stunder. Bålmuskulaturen och ryggens muskler stärks successivt. I magläge reser sig bebisen på utsträckta armar och börjar eventuellt rotera runt på magen. Benen sparkar aktivt och bebisen älskar att stå med stöd.
"""),
                ArticleSection(heading: "Sömn och rytm", body: """
Dagsömnen börjar konsolideras mot 2–3 tydliga pass. Kvällssömnen är ofta 6–8 timmar utan avbrott för de barn som är stora nog. Total sömnbehov är fortfarande 14–15 timmar per dygn. Om sömnen är fragmenterad: kontrollera vakenhetsfönstren och konsistensy i kvällsrutinen.
"""),
                ArticleSection(heading: "Förberedelse inför fast föda", body: """
Fast föda rekommenderas från 6 månader, men det är bra att börja fundera nu. Tecken på mognad: kan sitta med lätt stöd, förlorat tungutskjutningsreflexen, visar intresse för mat. Ingen rush — bröstmjölk eller ersättning ger all näring som behövs till 6 månader.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 17",
                consensus: "Sittandet med stöd öppnar en ny värld — bebisen ser äntligen vad som händer runt om.",
                quotes: [
                    "Satte henne i Bumbo-stolen och hon tittade sig nöjt omkring som en liten kung.",
                    "Magläge är fortfarande hatat men nödvändigt. Vi gör det fem minuter åt gången."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 18
        Article(
            id: "baby_week_18",
            category: .development,
            title: "Vecka 18 — Babbling startar",
            subtitle: "Konsonanter och vokaler blandas",
            icon: "text.bubble.fill",
            readTimeMinutes: 3,
            intro: "Runt 18 veckor tar bebisens vokaliseringar ett nytt steg — de första konsonanterna blandas in och 'babling' tar form. Det är hjärnans tal-motoriska system som övar.",
            sections: [
                ArticleSection(heading: "Språkutveckling", body: """
Bebisen kombinerar nu konsonanter och vokaler: 'ba', 'ma', 'da', 'ga'. Det är inte meningsfull kommunikation ännu men är grunden för allt kommande tal. Bebisen imiterar dina munrörelser och tonfall. Tala tydligt, överdrivet och glatt — 'baby talk' (högt, tydligt, melodiöst) är faktiskt optimal input för spädbarnshjärnan.
"""),
                ArticleSection(heading: "Grepp och koordination", body: """
Bebisen för nu föremål från en hand till den andra (transferring). Palmargreppet är säkrare och bebisen håller föremål längre. Koordinationen öga-hand förbättras dramatiskt. Bebisen börjar utforska texturer aktivt — ger föremål till förälder och tar emot igen (rudimentär turtagning med föremål).
"""),
                ArticleSection(heading: "Rutiner och trygghet", body: """
Konsekventa rutiner ger bebisen trygghet och förutsägbarhet. Det hjälper stressystemet att kalibreras rätt. En enkel dagstruktur: vakna, ät, lek, sov — upprepat 3–4 gånger — är ett bra ramverk utan att vara rigid.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 18",
                consensus: "Babblet är bedårande och oemotståndligt att svara på — vilket är precis meningen.",
                quotes: [
                    "Hon säger 'mamamamam' när hon är hungrig. Jag vet att det inte är meningsfullt men det smälter hjärtat.",
                    "Tog föremålet från ena handen och lade i den andra — stod och hoppade av förtjusning."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 19
        Article(
            id: "baby_week_19",
            category: .development,
            title: "Vecka 19 — Separation och anknytning",
            subtitle: "Bebisen vill alltid ha dig nära",
            icon: "person.2.fill",
            readTimeMinutes: 4,
            intro: "Runt 19 veckor intensifieras anknytningen. Bebisen protesterar när du lämnar rummet och söker aktivt din närvaro — det är ett sunt tecken på stark anknytning.",
            sections: [
                ArticleSection(heading: "Anknytning och separation", body: """
Separation­sprotesten visar att bebisen har en trygg anknytning till dig — den vet att du är den säkra basen. Detta är en sund och förväntad fas. Bebisen har ännu inte full objektpermanens (förstår inte att du kommer tillbaka), vilket gör separation skrämmande. Säg alltid adjö tydligt — försvinn inte utan förvarning.
"""),
                ArticleSection(heading: "Sömn och separationsångest", body: """
Separationsångesten kan påverka nattssömnen — bebisen protesterar mer vid läggdags. Håll en konsekvent, lugn kvällsrutin. Att kontrollera bebisens välmående utan att ta upp för snabbt hjälper bebisen lära sig att du finns kvar. Det är inte grymhet utan träning av trygghet.
"""),
                ArticleSection(heading: "Praktiska tips", body: """
Gömlek ('tittut') är en lek med djup innebörd — den tränar objektpermanens. Börja med korta separationer som byggs upp successivt. Berätta alltid vart du ska och när du kommer tillbaka, även om bebisen inte förstår orden ännu.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om separationsprotester",
                consensus: "Det är jobbigt men ett gott tecken — bebisen är tryggt anknuten.",
                quotes: [
                    "Klarar inte gå till toaletten utan tjut. Vet att det är normalt men det är uttröttande.",
                    "Spelade tittut i tio minuter. Det hjälpte faktiskt — förstod att mamma alltid kommer tillbaka."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 20
        Article(
            id: "baby_week_20",
            category: .feeding,
            title: "Vecka 20 — Fem månader",
            subtitle: "Förbereda sig för smakstart",
            icon: "fork.knife",
            readTimeMinutes: 4,
            intro: "Vid fem månader är bebisen nyfiken på det mesta — inklusive mat. Smakstarten börjar officiellt vid 6 månader, men förberedelserna kan börja nu.",
            sections: [
                ArticleSection(heading: "Bebisens utveckling vid 5 månader", body: """
Bebisen rullar nu ofta från rygg till mage och mage till rygg. Sitter med minimalt stöd i korta stunder. Griper föremål med precision och för dem direkt till munnen. Härmningsförmågan är imponerande — kopierar ansiktsuttryck, ljud och gester. Skrattar högt och frekvent.
"""),
                ArticleSection(heading: "Tecken på redo för mat", body: """
Tecken på att bebisen kan börja med smakprover nära 6 månader: kan sitta med lätt stöd, tappar inte all mat direkt med tungan (förlorat tungutskjutningsreflexen), visar tydligt intresse för mat (sträcker sig mot tallriken). Alla tre tecknen ska helst finnas. Vänta till 6 månader om inte.
"""),
                ArticleSection(heading: "Praktisk förberedelse", body: """
Bestäm om du vill göra traditionell sondmat (purée) eller Baby Led Weaning (BLW, mjuka bitar bebisen håller själv). Båda metoderna fungerar bra. BLW kräver att bebisen kan sitta stabilt och pincettgreppa. Börja alltid med enkla smaker: rotfrukter, gröt, fruktpurée. Inga smakregulatorer, socker eller salt de första 1–2 åren.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om förberedelse för smakstart",
                consensus: "Många är ivriga att börja tidigare — men de flesta är glada att de väntade till 6 månader.",
                quotes: [
                    "Han stirrar på vår mat som om det är det finaste han sett. Snart!",
                    "Bestämde oss för BLW — verkar roligare för hela familjen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 21
        Article(
            id: "baby_week_21",
            category: .development,
            title: "Vecka 21 — Rörelse och utforskning",
            subtitle: "Bebisen vill ta sig dit den vill",
            icon: "figure.roll",
            readTimeMinutes: 3,
            intro: "Vid 21 veckor börjar bebisen visa tydliga tecken på att vilja röra sig mot föremål och platser. Magkryp, rullningar och pivoting är förberedelsen för krypandet.",
            sections: [
                ArticleSection(heading: "Motorisk utveckling", body: """
Bebisen roterar nu runt sin egen axel i magläge (pivoting) för att nå föremål. Försök att dra sig framåt i magläge (magkrypning) kan synas. Benen är starka och bebisen 'studsar' glad i knät om man håller den stående. Koordinationsförmågan förbättras snabbt.
"""),
                ArticleSection(heading: "Sömn vid 5 månader", body: """
Många bebisar har nu en tydligare sömnrytm med 2–3 dagsövnar och ett längre nattpass. Nattamningar är fortfarande normala — bebisen behöver näring och trygghet nattetid. Undvik jämförelse med andra bebisar; sömnbehovet varierar mycket.
"""),
                ArticleSection(heading: "Säkerhet i ny rörelseförmåga", body: """
Nu när bebisen rör sig mer, se över säkerheten: säkra möbler som kan välta, täck eluttag, lägg undan sladdar. Lämna inte bebisen ensam på höga ytor ens en sekund. Babyproofing kan behöva påbörjas tidigare än väntat.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om rörelselustan",
                consensus: "Rörelselusten dyker upp snabbt — huset behöver babyproofas fortare än man tror.",
                quotes: [
                    "Han tog sig tre decimeter mot den röda bollen. Stolt som en tupp.",
                    "Rullade rätt av gymnastikmattan och in under soffbordet. Snabb den!"
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 22
        Article(
            id: "baby_week_22",
            category: .development,
            title: "Vecka 22 — Imitationsförmågan ökar",
            subtitle: "Bebisen kopierar allt du gör",
            icon: "person.wave.2.fill",
            readTimeMinutes: 3,
            intro: "Vid 22 veckor är bebisens härmningsförmåga imponerande. Den kopierar gester, ljud och ansiktsuttryck — och förväntar sig att du ska härma tillbaka.",
            sections: [
                ArticleSection(heading: "Social och kognitiv utveckling", body: """
Imitationen fungerar nu i båda riktningarna — bebisen kopierar dig och förväntar sig att du kopierar den. Detta bidrag-och-svar-mönster är grunden för all kommunikation och inlärning. Bebisen börjar förstå att föremål har funktioner (en rattel skakas, en flaska dricks ur). Minnet sträcker sig nu bakåt i upp till en vecka.
"""),
                ArticleSection(heading: "Tandning och olust", body: """
Tandning kan ge ökad salivering, tuggande, irritabilitet och lätt förhöjd temperatur (men inte hög feber — det är inte orsakad av tandning). Tandningsringar, kylda bitleksaker och lätt massage av tandköttet med ren finger kan lindra. Ring BVC om feber över 38,5.
"""),
                ArticleSection(heading: "Lek och inlärning", body: """
Peekaboo-lekar är fortfarande favoriten. Putta föremål ut ur synen och låt bebisen se dem försvinna — det tränar permanens. Ge föremål av olika tyngd, textur och form. Namnge allt du gör och pekar på — ordförrådsuppbyggnaden börjar nu.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om vecka 22",
                consensus: "Imitationsförmågan gör bebisen till en fascinerande lekkamrat.",
                quotes: [
                    "Räckte ut tungan och han gjorde detsamma direkt. Fnissade åt varandra i fem minuter.",
                    "Tandning in action — allt hamnar i munnen och han är gnälligare. Men det går."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 23
        Article(
            id: "baby_week_23",
            category: .development,
            title: "Vecka 23 — Sitter stabilt",
            subtitle: "Fri sittning tar form",
            icon: "chair.fill",
            readTimeMinutes: 3,
            intro: "Runt 23 veckor kan många bebisar sitta utan stöd i korta stunder. Det upprätta perspektivet förändrar allt — leken, kommunikationen och synen på världen.",
            sections: [
                ArticleSection(heading: "Motorisk milstolpe: sittande", body: """
Fri sittning kräver stark core-muskulatur, balans och koordination. Bebisen sitter i 'tripod-position' (lutar framåt med händerna i golvet) till att gradvis sitta rakare. Normalt att kuta ihop sig och falla inom 10–30 sekunder till att sitta i flera minuter. Fri sittning utan stöd uppnås vanligen 6–8 månader.
"""),
                ArticleSection(heading: "Sömn och sömnregression", body: """
Motoriska språng påverkar ofta sömnen — bebisen övar sina nya rörelser mentalt under natten. Fler uppvaknanden och svårare insomnande är typiskt under ett motoriskt språng. Det är övergående. Håll rutinerna stabila och ge extra tröst om det behövs.
"""),
                ArticleSection(heading: "Näring inför smakstarten", body: """
Bara några veckor kvar till 6 månader och smakstarten. Se till att ha järnrik föda redo: kött, bönor, gröt med järn. Järnbehovet ökar markant runt 6 månader när de medfödda lagren tar slut. Välj inte enbart frukter och grönsaker i början — balansera med proteinkällor.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om det fria sittandet",
                consensus: "Att sitta friare öppnar en ny fas av lek och samspel.",
                quotes: [
                    "Satt i fem sekunder utan stöd och kollade sig nöjt omkring. Sedan plask framåt.",
                    "Babygymet är utdött — hon vill sitta och ha saker att hålla i händerna."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 24
        Article(
            id: "baby_week_24",
            category: .feeding,
            title: "Vecka 24 — Sex månader och smakstart!",
            subtitle: "Det stora äventyr börjar",
            icon: "fork.knife.circle.fill",
            readTimeMinutes: 5,
            intro: "Sex månader är startskottet för fast föda. Det är en av de roligaste milstolparna — och en av de mest stökiga. Välkommen till smakstarten!",
            sections: [
                ArticleSection(heading: "Hur man börjar", body: """
Börja med ett nytt livsmedel åt gången, med 2–3 dagars mellanrum — för att kunna identifiera eventuella reaktioner. Bra förstamatar: rotsaker (morot, sötpotatis, palsternacka), gröt (havregröt, rismjölsgröt), avokado, banan. Små mängder — en tesked — de första dagarna. Bröstmjölk eller ersättning är fortfarande primär näringskälla hela det första året.
"""),
                ArticleSection(heading: "Allergiintroduktion", body: """
Forskning visar att tidig introduktion av allergener (gluten, ägg, fisk, nötter) minskar allergirisken. Ge gluten (bröd, gröt) tidigt. Välkokta ägg kan introduceras. Fisk från 6 månader. Jordnötter (i form av jordnötssmör utblandat i gröt) bör introduceras tidigt, inte undvikas. Kontakta BVC om barnet har eksem eller känd familjehistoria av allergi.
"""),
                ArticleSection(heading: "Praktiska tips", body: """
Var beredd på stök — sked och mat hamnar överallt. Det är en del av lärandet. Skärm­fria måltider i gott sällskap lär bebisen att mat är social och njutbar. Tvinga aldrig ner mat — bebisen styr mängden, du styr vad som erbjuds.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om smakstarten",
                consensus: "Det är roligare — och stökigare — än man trodde. Ha alltid kameran redo.",
                quotes: [
                    "Ansiktet när hon smakade morotspuré för första gången — ren chock sen nöjd smekning.",
                    "Gröten landade i håret, på mig och på väggen. Inte i munnen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 25
        Article(
            id: "baby_week_25",
            category: .feeding,
            title: "Vecka 25 — Utöka smakpaletten",
            subtitle: "Nya smaker varje dag",
            icon: "leaf.fill",
            readTimeMinutes: 3,
            intro: "Veckan efter smakstarten handlar om att successivt utöka smakpaletten. Varje ny smak bygger ett bredare kostmönster och minskar risken för kräsenhet senare.",
            sections: [
                ArticleSection(heading: "Nya livsmedel", body: """
Introducera grönsaker innan frukter om möjligt — forskning tyder på att söta smaker tidigt kan göra bebisen mer kräsen. Brokkoli, zucchini, spenat och blomkål är bra att testa tidigt. Kombinera gärna med en välkänd smak (morot + brokkoli) för att underlätta acceptansen.
"""),
                ArticleSection(heading: "Sömn vid 6 månader", body: """
Många föräldrar börjar fundera på sömnträning runt 6 månader. Det finns olika metoder — från no-cry till kontrollerad gråt. Det finns inget vetenskapligt stöd för att någon metod skadar barnet om den utförs med kärlek och lyhördhet. Gör det som känns rätt för din familj.
"""),
                ArticleSection(heading: "Järnrik kost är viktig", body: """
Järnlagrarna från födseln börjar ta slut runt 6 månader. Järnbrist är den vanligaste näringsbristen hos spädbarn och kan påverka hjärnutvecklingen. Ge järnrik mat varje dag: kött, fisk, baljväxter, järnberikad gröt. C-vitamin (frukt, paprika) ökar järnupptaget.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om smakutökning",
                consensus: "Smakpreferenser formas nu — bred bas tidigt lönar sig.",
                quotes: [
                    "Brokkoli togs emot med misstänksamhet dag 1, men dag 5 åt han det glatt.",
                    "BLW fungerar fantastiskt — han äter mer när han håller maten själv."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 26
        Article(
            id: "baby_week_26",
            category: .feeding,
            title: "Vecka 26 — Halv ett år!",
            subtitle: "Halvårskontroll och ny matrutin",
            icon: "chart.line.uptrend.xyaxis",
            readTimeMinutes: 4,
            intro: "Sex månader och en vecka — bebisen har blivit hälften så gammal som ett år. Halvårskontrollen på BVC ger en bra bild av hur allt ser ut.",
            sections: [
                ArticleSection(heading: "BVC-kontroll vid 6 månader", body: """
Halvårskontrollen inkluderar vikt, längd, huvudomfång, motorisk granskning (sitter med stöd? rullar?), syn- och hörselscreening samt socialt samspel. Vaccinationer ges ofta vid detta tillfälle. Prata om matintroduktionen, sömnbehov och hur hela familjen mår.
"""),
                ArticleSection(heading: "Matrytm vid 6 månader", body: """
Matrytmen börjar etableras: frukost, lunch och middag med eventuellt mellanmål. Bröstmjölk eller ersättning ges fortfarande 4–6 gånger per dygn. Syftet med maten nu är smaklärande och järnintagning — inte kalorireplacering. Maten ska komplettera, inte ersätta mjölken.
"""),
                ArticleSection(heading: "Motorisk milstolpe", body: """
Bebisen bör vid 6 månader hålla upp huvudet stabilt, rulla i båda riktningarna och sitta med stöd. Fri sittning kan dyka upp snart. Om bebisen fortfarande har svårt att hålla upp huvudet eller visa intresse för omgivningen — prata med BVC. Tidiga insatser ger bäst resultat.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om halvårsmilstolpen",
                consensus: "Halvårskontrollen sätter ord på alla framsteg — riktigt fint att höra dem bekräftade.",
                quotes: [
                    "BVC-sköterskan sa 'allt ser fantastiskt ut'. Bästa meningen jag hört.",
                    "Sex månader! Det är fortfarande svårt att fatta att det gått så fort."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 27
        Article(
            id: "baby_week_27",
            category: .development,
            title: "Vecka 27 — Krypandet förbereds",
            subtitle: "Quadrupedal position och magdragning",
            icon: "figure.crawling",
            readTimeMinutes: 3,
            intro: "Runt 27 veckor börjar bebisen ta sig upp på händer och knän — krypandet är nära. Det är en dramatisk ökning av mobilitet som förändrar hela familjelivet.",
            sections: [
                ArticleSection(heading: "Motorisk förberedelse för krypande", body: """
Bebisen tar sig nu upp i fyrfotaposition och vaggar fram och tillbaka. Det bygger styrka i armar, skuldror, core och ben. Magdragning (commando crawl) förekommer ofta före klassiskt krypande. Alla bebisar behöver inte krypa — en del rullar, en del glider på sättet — men de flesta kryper 7–10 månader.
"""),
                ArticleSection(heading: "Babbling och kommunikation", body: """
Babblet blir nu mer varierat och konsekvent. Bebisen upprepar stavelser: 'ba-ba-ba', 'da-da-da', 'ma-ma-ma'. Den lyssnar uppmärksamt på ditt tal och svarar med egna ljud. Förstår nu tonen i din röst — glad, varnade, lugn — och svarar med olika reaktioner.
"""),
                ArticleSection(heading: "Babyproofing", body: """
Det är dags att babyproofa ordentligt. Dörrstopp och trappgrindar bör monteras nu — inte efter att bebisen börjat krypa. Eluttag täcks, sladdar undanröjs, kemikalier och mediciner låses in. Kanten på möbler med skarpa hörn bör skyddas.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om krypförberedelse",
                consensus: "Babyproofingen är ett projekt — börja tidigt.",
                quotes: [
                    "Hittade honom under soffan. Hade kryp-crawlat dit utan att vi märkte.",
                    "Monterade trappgrinden i förebyggande syfte. Bra beslut."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 28
        Article(
            id: "baby_week_28",
            category: .development,
            title: "Vecka 28 — Sju månader",
            subtitle: "Fri sittning och aktivt grepp",
            icon: "7.circle.fill",
            readTimeMinutes: 3,
            intro: "Vid sju månader sitter de flesta bebisar fritt utan stöd och utforskar aktivt med händerna. En ny era av självständig lek börjar.",
            sections: [
                ArticleSection(heading: "Motorik vid 7 månader", body: """
Fri sittning utan stöd är nu etablerad hos de flesta. Bebisen sitter och leker med händerna fria. Greppet förbättras — övergång från palmärt grepp mot ett rudimentärt pincettgrepp börjar. Bebisen börjar dra sig upp i stående med hjälp av möbler.
"""),
                ArticleSection(heading: "Sömn vid 7 månader", body: """
Dagsömnen konsolideras mot 2 pass (förmiddagsvila och eftermiddagsvila). Nattpasset är för många 9–11 timmar. Nattamningar börjar minska naturligt för de bebisar som äter bra fast föda. Sömnträning är ett alternativ nu om sömnen fortfarande är mycket fragmenterad.
"""),
                ArticleSection(heading: "Mat vid 7 månader", body: """
Bebisen äter nu 2–3 mål fast föda per dag. Konsistensen kan gradvis göras tjockare och klumpigare. BLW-bebisen håller bitar och tuggar. Familjemat (utan salt och socker) kan börja delas. Maten ska fortfarande kompletteras med bröstmjölk eller ersättning.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om sjumånadersåldern",
                consensus: "Att sitta fritt och leka självständigt ger föräldrar en liten paus — äntligen.",
                quotes: [
                    "Sitter och leker med klossar i fem minuter. Frihet!",
                    "Pincettgreppet är så söt att titta på — sitter och försöker plocka upp smulor från mattan."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 29
        Article(
            id: "baby_week_29",
            category: .development,
            title: "Vecka 29 — Separation och omdöme",
            subtitle: "Bebisen lär sig att du alltid kommer tillbaka",
            icon: "arrow.uturn.left.circle.fill",
            readTimeMinutes: 3,
            intro: "Runt 29 veckor intensifieras objektpermanensen. Bebisen förstår nu att dolda föremål fortfarande finns — och att föräldrar som lämnar rummet också kommer tillbaka.",
            sections: [
                ArticleSection(heading: "Objektpermanens och kognition", body: """
Bebisen letar nu aktivt efter ett dolt föremål — drar undan en handduk för att hitta en gömd boll. Objektpermanensen är på plats. Det förklarar också separationsångesten: bebisen vet att du finns, men förstår ännu inte när du kommer tillbaka. Tittut-leken har nu djupare mening.
"""),
                ArticleSection(heading: "Främlingsångest", body: """
Runt 6–9 månader toppar främlingsångesten. Bebisen blir rädd för okända ansikten och klamrar sig fast vid föräldrarna. Det är normalt och sunt — det visar en trygg anknytning. Tvinga aldrig bebisen att gå till okända. Ge tid och låt bebisen leda takten.
"""),
                ArticleSection(heading: "Sömn och separationsångest nattetid", body: """
Separationsångesten kan skapa nya sömnproblem nattetid. Bebisen protesterar mer vid läggdags och kan vakna och skrika i panik. Svara på kontakt och tröst — du lär bebisen att du finns och att det är tryggt. En sömnleksak eller klädesplagg med din doft kan hjälpa.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om separationsångesten",
                consensus: "Jobbigt att inte ens kunna gå till köket — men ett tydligt tecken på trygg anknytning.",
                quotes: [
                    "Gömde bollen under en duk och han letade rätt på den direkt. Imponerad!",
                    "Klamrar sig fast vid mitt ben som ett litet bläckfisk. Sött och utmattande."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 30
        Article(
            id: "baby_week_30",
            category: .development,
            title: "Vecka 30 — Krypandet börjar",
            subtitle: "Mobilitet och äventyrslust",
            icon: "arrow.right.circle.fill",
            readTimeMinutes: 3,
            intro: "Runt 30 veckor kryper många bebisar på riktigt för första gången. Det är en av de största milstolparna — och startskottet för en ny, mer intensiv fas av föräldraskap.",
            sections: [
                ArticleSection(heading: "Krypandets milstolpe", body: """
Klassiskt krypande (på händer och knän, alternerande ben-armrörelser) kräver bilateral koordination, styrka och balans. Det är en enorm neurologisk prestation. Inte alla bebisar kryper i klassisk form — rullande, glutekrypande ('bumshuffling') och direkt till gång är normala varianter. Krypandet stimulerar hjärnans integration av vänster och höger hemisfär.
"""),
                ArticleSection(heading: "Säkerhet och ny mobilitet", body: """
Nu är babyproofingen avgörande. Bebisen kan röra sig snabbt och oförutsägbart. Trappgrindar måste sitta korrekt monterade (skruvade, inte klämda). Dörrar till badrum och kök måste hållas stängda. Värmeelement och ugnar måste skyddas.
"""),
                ArticleSection(heading: "Mat och näringsbehov", body: """
Ju mer bebisen rör sig, desto mer energi behövs. Öka mängden mat gradvis. Tre mål fast föda per dag plus bröstmjölk eller ersättning 3–4 gånger. Fingermaten fascinerar — små bitar av kokt grönsak, pasta, mjukt bröd, banan tränar pincettgreppet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om de första krypstegen",
                consensus: "Krypandet är frihet för bebisen och stress för föräldrarna — på bästa tänkbara sätt.",
                quotes: [
                    "Kröp tre meter mot katten. Katten var inte lika entusiastisk.",
                    "Hittar honom nu alltid på ett annat ställe än jag la honom. Huset är ett äventyrland."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 31
        Article(
            id: "baby_week_31",
            category: .development,
            title: "Vecka 31 — Uppresning och kläng",
            subtitle: "Bebisen drar sig upp i stående",
            icon: "figure.stand",
            readTimeMinutes: 3,
            intro: "Runt 31 veckor börjar bebisen dra sig upp i stående med hjälp av möbler. Det är motorisk modighet i praktiken — och det finns inga bromsar.",
            sections: [
                ArticleSection(heading: "Uppresning till stående", body: """
Bebisen drar sig upp längs möbelkanten med armkraft och legkraft. Att komma upp är lätt — att komma ner igen är svårare. Bebisen fastnar i stående och faller bakåt när armarna tröttnar. Lär bebisen att böja knäna och sjunka ner kontrollerat — det tar tid men ökar säkerheten.
"""),
                ArticleSection(heading: "Tal och kommunikation", body: """
Babbling med konsonanter är nu intensivt. Bebisen kan använda 'mama' och 'dada' i specifik riktning mot respektive förälder — det är en av de första riktiga orden, även om meningsfullt tal inte är etablerat. Bebisen förstår nu fler ord än den kan producera (passivt ordförråd > aktivt ordförråd).
"""),
                ArticleSection(heading: "Mat och sömn", body: """
Tre mål mat per dag är nu standard. Snacks (mjuk frukt, kex) kan introduceras mellan målen. Sömnen kan störas av det motoriska språnget — bebisen övar uppresning mentalt om natten. Ge extra tröst och håll rutinerna stabila.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om uppresning",
                consensus: "Fastnar i stående och skriker om hjälp ner — varje kvartminut.",
                quotes: [
                    "Drog sig upp längs sänggaveln kl 03. Skrek sedan i panik för att hon inte kom ner.",
                    "Säger 'dada' och tittar direkt på min man. Han smälter varje gång."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 32
        Article(
            id: "baby_week_32",
            category: .development,
            title: "Vecka 32 — Åtta månader",
            subtitle: "Åttamånaderskontroll på BVC",
            icon: "8.circle.fill",
            readTimeMinutes: 4,
            intro: "Åtta månader är en milstolpe — bebisen är en krypande, klängande, babblande liten utforskare. BVC-kontrollen bekräftar att allt är på rätt spår.",
            sections: [
                ArticleSection(heading: "Milstolpar vid 8 månader", body: """
Vid 8 månader kryper de flesta, sitter stabilt, drar sig upp och 'cruisar' längs möbler. Pincettgreppet är under utveckling. Babbling med dubbelstavelser är tydlig. Bebisen förstår 'nej' och enkla ord i kontext. Pekar ännu inte (det kommer 9–12 månader) men tittar åt det hållet förälder tittar.
"""),
                ArticleSection(heading: "BVC vid 8 månader", body: """
BVC-besöket inkluderar motorisk granskning, social screening (leende, ögonkontakt, kommunikation), och samtal om mat och sömn. MCHAT-screeningen för autismtecken påbörjas. Prata om eventuell oro — det är det besöket finns till för.
"""),
                ArticleSection(heading: "Föräldrahälsa", body: """
Åtta månader in är det vanligt att vara utmattad men simultant förälskad i sin bebis. Parrelationen kan vara ansträngd av sömnbrist och förändrade roller. Prata med varandra. Reservera tid som ett par — även en kort kvällspromenad utan bebis räknas.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om åttamånadersåldern",
                consensus: "Åtta månader är full fart och fullt liv — tröttheten och glädjen i jämnvikt.",
                quotes: [
                    "BVC-kontrollen gick bra. Han cruisar längs soffan som en liten proffs.",
                    "Vi gick på middag utan bebisen för första gången. Saknade henne redan på parkeringsplatsen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 33
        Article(
            id: "baby_week_33",
            category: .development,
            title: "Vecka 33 — Peka och dela upplevelser",
            subtitle: "Gemensam uppmärksamhet tar form",
            icon: "hand.point.right.fill",
            readTimeMinutes: 3,
            intro: "Runt 33 veckor börjar bebisen peka — ett av de viktigaste kommunikativa sprången. Pekandet är en inbjudan att dela en upplevelse tillsammans.",
            sections: [
                ArticleSection(heading: "Gemensam uppmärksamhet (joint attention)", body: """
Gemensam uppmärksamhet innebär att bebisen och du tittar på samma sak samtidigt — och båda vet det. Det är grunden för all kommunikation, inlärning och empati. Bebisen pekar, förälder tittar, bebisen kollar att förälder kollar. Detta triangulerade samspel är ett viktigt tecken på sund social utveckling.
"""),
                ArticleSection(heading: "Sömn vid 8–9 månader", body: """
Dagsömnen är nu ofta 2 pass: ett förmiddagspass (30–60 min) och ett eftermiddagspass (60–90 min). Totalt dagsömn: 2–3 timmar. Nattpasset: 10–12 timmar. Vissa bebisar sover igenom natten nu — andra vaknar fortfarande 1–2 gånger. Båda varianterna är normala.
"""),
                ArticleSection(heading: "Mat och texturer", body: """
Nu kan bebisen äta mjuka familjemat-varianter. Pasta, ris, potatis, mjukt kött, kokt fisk — allt smaksat utan salt. Bröd utan tillsatser är okej. Mjuka bitar uppmuntrar tuggandet och minskar risken för kräsenhet. Avoid choking hazards: hela vindruvor, nötter, råa morötter.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om pekandet",
                consensus: "Pekandet känns som ett genombrott — bebisen kommunicerar avsiktligt om världen.",
                quotes: [
                    "Pekade på hunden och tittade på mig. Verkade vänta på att jag skulle bekräfta. Gjorde det!",
                    "Äter nu familjemat vid middagsbordet. Helt fantastiskt att äta tillsammans."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 34
        Article(
            id: "baby_week_34",
            category: .development,
            title: "Vecka 34 — Cruising och balans",
            subtitle: "Sidestegs längs möbel­kanten",
            icon: "figure.walk",
            readTimeMinutes: 3,
            intro: "Vid 34 veckor sidestegar de flesta bebisar längs möbler — 'cruising'. Det är träning för det fria gåendet som väntar runt hörnet.",
            sections: [
                ArticleSection(heading: "Cruising och gåförberedelse", body: """
Cruising innebär att bebisen håller sig i en möbel och tar sidesteg. Det tränar balans, viktöverföring och benstyrka. Bebisen kan nu stå friare — håller med en hand, prövar utan stöd i en sekund. Gångvagnar och push-leksaker hjälper att träna gångmönstret. Undvik gåstolar (walkers) — de är inte rekommenderade av säkerhetsskäl.
"""),
                ArticleSection(heading: "Kommunikation och förståelse", body: """
Bebisen förstår nu enkla instruktioner i kontext ('kom hit', 'ge mig'). Reagerar på sitt eget namn konsekvent. Babbling är melodiöst och varierat. Vissa bebisar har nu ett eller två verkliga ord med konsekvent betydelse.
"""),
                ArticleSection(heading: "Kost och näring", body: """
Järnintaget är fortsatt viktigt. Kontrollera att bebisen får järnrik mat dagligen. D-vitamin­droppar rekommenderas till alla bebisar det första levnadsåret (10 µg/dag). Kontakta BVC om du är osäker på om bebisen äter tillräckligt med järn.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om cruisingfasen",
                consensus: "Gångvagnen var den bästa investeringen — hon cruisar runt hela lägenheten.",
                quotes: [
                    "Stod utan stöd i tre sekunder och tittade förvånat ner på sina egna fötter.",
                    "Satte sig på kommando! Förstår uppenbarligen mer ord än vi trodde."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 35
        Article(
            id: "baby_week_35",
            category: .development,
            title: "Vecka 35 — Nio månader",
            subtitle: "Lika länge ute som inne",
            icon: "9.circle.fill",
            readTimeMinutes: 4,
            intro: "Nio månader! Bebisen har nu levt lika länge utanför magen som inne i den. Niomånaderskontrollen är en av de viktigaste under första året.",
            sections: [
                ArticleSection(heading: "Niomånaderskontroll", body: """
Kontrollen vid 9 månader är en av de mest ingående under första året. BVC kontrollerar motorik, kommunikation (pekar? vinkar? gemensam uppmärksamhet?), social interaktion och matvanor. MCHAT-frågeformuläret fylls i av föräldrarna. Hörsel­kontroll kan göras.
"""),
                ArticleSection(heading: "Milstolpar vid 9 månader", body: """
Bebisen bör vid 9 månader: krypa (eller ha alternativ rörelseförmåga), sitta stabilt, dra sig upp, ha gemensam uppmärksamhet, reagera på eget namn, vinka och/eller peka. Avsaknad av dessa tecken bör diskuteras med BVC — tidig utredning är alltid bättre.
"""),
                ArticleSection(heading: "Sömn och sömnlösningar", body: """
Om sömnen fortfarande är mycket störd vid 9 månader: utvärdera rutiner, vakenhetsfönster och matintag. Sömnträning (gradvis uttrappning, pick-up/put-down) kan vara ett alternativ. Rådfråga BVC. Kom ihåg att sömnbehov och mönster varierar enormt mellan barn.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om niomånaderskontrollen",
                consensus: "En av de viktigaste kontrollerna — det är skönt att ha en professionell bedömning.",
                quotes: [
                    "BVC-läkaren var nöjd med allt. Kan pusta ut ett tag.",
                    "Nio månader! Lika länge ute som inne. Det är ett perspektiv."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 36
        Article(
            id: "baby_week_36",
            category: .development,
            title: "Vecka 36 — Pincettgrepp",
            subtitle: "De minsta detaljerna plockas upp",
            icon: "hand.point.up.fill",
            readTimeMinutes: 3,
            intro: "Runt 36 veckor mognar pincettgreppet — bebisen kan plocka upp mycket små föremål med tumme och pekfinger. En neurologisk prestation som tar månader att bemästra.",
            sections: [
                ArticleSection(heading: "Pincettgreppets mognad", body: """
Övergången från palmärt grepp (hela handen) till pincettgrepp (tumme + pekfinger) är en viktig neurologisk milstolpe. Det kräver finmotorisk kontroll i fingertopparna och är associerat med prefrontala kortex mognad. Bebisen är nu fixerad vid små saker: matsmulor, knappar, hårstrån — allt förs till munnen.
"""),
                ArticleSection(heading: "Säkerhet och pincettgrepp", body: """
Nu när bebisen kan plocka upp det minsta är säkerheten avgörande. Inget mindre än 3 cm i diameter bör finnas inom räckhåll — det är tumregeln. Kontrollera golv och lekplatser regelbundet. Var vaksam på mynt, batterier, magneter och plastfolie.
"""),
                ArticleSection(heading: "Fingermat och självständighet", body: """
Pincettgreppet öppnar för mer avancerad fingermat: ärtor, bönor, kokt pasta, liten bitar av frukt. Självständigt ätande (självmatning) stimulerar koordination, koncentration och matglädje. Ge bebisen tid och låt det bli stökigt — det är en del av processen.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om pincettgreppet",
                consensus: "Plötsligt kan de plocka upp allt — inklusive det du inte ville att de skulle hitta.",
                quotes: [
                    "Plockade upp ett hårstå från golvet och föste det i munnen. Blixtsnabbt.",
                    "Äter nu ärtor på egen hand. Tar tjugo minuter men det är hennes stolthet."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 37
        Article(
            id: "baby_week_37",
            category: .development,
            title: "Vecka 37 — Ord med mening",
            subtitle: "De första orden tar form",
            icon: "bubble.left.fill",
            readTimeMinutes: 3,
            intro: "Runt 37 veckor kan de första riktiga orden dyka upp — ord som används konsekvent för ett specifikt objekt eller person. Det är ett av de mest gripande ögonblicken.",
            sections: [
                ArticleSection(heading: "Första ord", body: """
Första ord definieras som ett ljud eller kombination av ljud som bebisen använder konsekvent med samma mening. 'Mamma', 'pappa', 'namnge husdjur', 'nej', 'ja', 'mer' är typiska. Orden ser ofta ut som förenklade versioner av rätt ord. Det är normalt att ha 1–3 ord vid 12 månader — flera ord är också normalt.
"""),
                ArticleSection(heading: "Förståelse och instruktioner", body: """
Bebisen förstår nu 10–20 ord passivt. Reagerar på enkla kommandon ('kom', 'ge mig', 'sätt dig'). Förstår 'nej' och väljer ibland att ignorera det — det är normalt. Upprepad namngivning av föremål och händelser bygger ordförrådet snabbt.
"""),
                ArticleSection(heading: "Lek och inlärning", body: """
Orsak-verkan-leksaker (trycka en knapp ger ljud) fascinerar. Enkla pusslen (2–3 bitar) kan börja introduceras. Böcker med en bild per sida och ett ord ('hund', 'bil', 'boll') är perfekt nu. Namnge föremål konsekvent varje dag — repetition är nyckel.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om de första orden",
                consensus: "När de säger 'mamma' med intention för första gången är det oförglömligt.",
                quotes: [
                    "Sa 'ball' och pekade på bollen. Riktigt ord med mening! Filmade det direkt.",
                    "Förstår 'nej' perfekt men väljer aktivt att ignorera. Intelligensen är skrämmande."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 38
        Article(
            id: "baby_week_38",
            category: .development,
            title: "Vecka 38 — Stå fritt",
            subtitle: "Sekunder utan stöd",
            icon: "figure.stand.line.dotted.figure.stand",
            readTimeMinutes: 3,
            intro: "Runt 38 veckor kan bebisen stå fritt utan stöd i korta stunder. Balansen testar sig själv och det är fascinerande att se koncentrationen i ansiktet.",
            sections: [
                ArticleSection(heading: "Fritt stående", body: """
Bebisen lyfter händerna från möbeln och balanserar friare. De flesta klarar 2–5 sekunder fritstående. Fallet är kontrollerat — bebisen har lärt sig att vika knäna och sjunka ner mjukt. Modet att pröva ökar med varje dag. Det fria gåendet är nu veckor bort för de flesta.
"""),
                ArticleSection(heading: "Sömn vid 9–10 månader", body: """
Dagsömnen rör sig nu mot 2 tydliga pass. Totalt dagsömn: 2–3 timmar. Nattpasset: 10–12 timmar. Bebisar som fortfarande vaknar ofta nattetid kan ha nytta av att äta mer mat under dagen. Nattamning är fortfarande normalt och okej.
"""),
                ArticleSection(heading: "Tandning och munomsorg", body: """
Många bebisar har nu 2–8 tänder. Rengöring av tänderna börjar nu — mjuk tandborste med vatten eller lite fluortandkräm (barntandkräm med rätt fluormängd). Inga söta drycker i nappflaska. Boka första tandläkarbesöket runt 1 år eller vid de första tänderna.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om fristående",
                consensus: "De sekunder bebisen balanserar fritt är en av de mest spännande du ser som förälder.",
                quotes: [
                    "Stod fritt i fem sekunder och log stolt som en påfågel innan hon satte sig.",
                    "Tänderna är ett kapitel för sig — han tuggar på allt och alla."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 39
        Article(
            id: "baby_week_39",
            category: .development,
            title: "Vecka 39 — Tio månader",
            subtitle: "Kommunikation och personlighet",
            icon: "person.crop.circle.badge.checkmark",
            readTimeMinutes: 3,
            intro: "Vid tio månader lyser bebisens personlighet klart igenom. Humor, envishet, nyfikenhet och kärlek — det är en liten individ med egna preferenser och åsikter.",
            sections: [
                ArticleSection(heading: "Personlighet och kognition", body: """
Bebisen har nu en tydlig personlighet — lugn eller livlig, social eller tillbakadragen, envis eller flexibel. Temperamentet är delvis medfött och delvis format av erfarenheter. Bebisen förstår komplexa situationer: vet vad som händer när du tar fram jackan, förstår att en stängd dörr göms bakom mat.
"""),
                ArticleSection(heading: "Kommunikation vid 10 månader", body: """
Bebisen kommunicerar nu med en kombination av gester, ljud, pekande och ord. Vinkar 'hej då', klappar händerna (pattycake), rör sig till musik. Prövar att imitera nya ord du säger — upprepa dem klart och tydligt. Passivt ordförråd är nu 20–50 ord.
"""),
                ArticleSection(heading: "Mat och familjeliv", body: """
Bebisen äter nu i stort sett familjemat (utan salt och socker). Tre mål och 1–2 mellanmål. Bröstmjölk eller ersättning 2–3 gånger om dagen. Måltider vid bordet i sällskap är viktiga för det sociala lärandet om mat. Undvik att ha skärm på under maten.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om tiomånaderspersonligheten",
                consensus: "Personligheten lyser igenom — du ser vem ditt barn är.",
                quotes: [
                    "Han är envis som ett åsne och fnissar åt egna skämt. Min kopia.",
                    "Förstår 'inte röra!' men väljer att titta på mig medan han tar det ändå."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 40
        Article(
            id: "baby_week_40",
            category: .development,
            title: "Vecka 40 — Första stegen är nära",
            subtitle: "Balans och mod ökar",
            icon: "shoeprints.fill",
            readTimeMinutes: 3,
            intro: "Runt 40 veckor är de flesta bebisar redo att ta sina första självständiga steg. Modet byggs upp dag för dag och snart händer det.",
            sections: [
                ArticleSection(heading: "Förberedelse för gång", body: """
Bebisen stegar nu längs möbler med allt mer självförtroende. Lyfter en hand, prövar att stå fritt 5–10 sekunder. Klarar att byta riktning och tvärstanna. Balansen är god nog för ett eller två steg, men hjärnan processar fortfarande det komplexa koordinationsmönster som fri gång kräver.
"""),
                ArticleSection(heading: "Tillväxt vid 10 månader", body: """
Tillväxttakten minskar nu jämfört med de första månaderna. Bebisen väger typiskt 8–10 kg och är 70–75 cm lång vid 10 månader. Viktkurvan kan plana ut — det är normalt. Aptiten varierar från dag till dag, vilket oroar många föräldrar i onödan. Följ kurvan på BVC, inte dagsvikten.
"""),
                ArticleSection(heading: "Skor och barfota", body: """
Barfota är bäst för fotsulornas och balansens utveckling — golvkontakten ger proprioceptiv feedback. Inomhus: strumpor med halkskydd eller barfota. Skor behövs utomhus — välj mjuka, böjliga skor med platt sula och lite spelrum för tårna. Undvik styva plastbootar och hårda skalor.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om gångförberedelsen",
                consensus: "Det är spännande och nervöst — man vill att de ska börja gå men saknar krypet redan.",
                quotes: [
                    "Stog fritt i tio sekunder och log Brett. Sen satte hon sig lugnt ner.",
                    "Köpte mjuka gymnastikskor. Han verkar mer säker med dem."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 41
        Article(
            id: "baby_week_41",
            category: .development,
            title: "Vecka 41 — Elva månader",
            subtitle: "Självständighet och nyfikenhet",
            icon: "star.circle.fill",
            readTimeMinutes: 3,
            intro: "Elva månader är fullt av kontraster: bebisen vill vara självständig men klamrar sig fast, utforskar allt men vill ha dig nära. Det är en tid av snabb kognitiv och social mognad.",
            sections: [
                ArticleSection(heading: "Kognitiv utveckling vid 11 månader", body: """
Bebisen förstår nu enkla orsak-verkan och kan lösa enkla problem: öppna en låda, peta ut en boll ur ett rör. Leker parallellt med andra barn (inte ihop ännu — det kommer 18–24 månader). Härmning av vardagshandlingar: låtsas äta, 'prata' i leksakstelefon, sätter en hatt på sig.
"""),
                ArticleSection(heading: "Ord och kommunikation", body: """
Bebisen har nu vanligen 1–5 ord med konsekvent mening. Använder gester för att komplettera kommunikationen. 'Vad är det?' och 'Var är X?' frågor svarar bebisen på med pekande. Ordförrådet byggs snabbast när föräldrar namnger allt, läser högt och har rika samtal.
"""),
                ArticleSection(heading: "Sömn och dagsrytm", body: """
Dagsömnen är nu 2 pass för de flesta. Vissa bebisar rör sig mot 1 pass runt 12–18 månaders ålder. Tecken på att vara redo för 1 pass: svårt att somna på förmiddagen, natten påverkas av för mycket dagsömn. Gå inte ner till 1 pass för tidigt — det kan orsaka övertrötthet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om elmånadersåldern",
                consensus: "Självständigheten och envisigheten börjar — det är charm och utmaning i ett.",
                quotes: [
                    "Låtsaspratade i telefonen och sa 'hej'. Klar för socialt liv.",
                    "Vill göra allt själv — klä på sig, äta, gå upp och ner för trappan. Tar dubbla tid."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 42
        Article(
            id: "baby_week_42",
            category: .growth,
            title: "Vecka 42 — Tillväxt och viktkurva",
            subtitle: "Aptiten varierar men kurvan håller",
            icon: "chart.bar.fill",
            readTimeMinutes: 3,
            intro: "Mot slutet av det första året planar viktökningen ut. Bebisen rör sig mer och är mer selektiv med mat. Det är normalt och behöver inte oroar.",
            sections: [
                ArticleSection(heading: "Normal tillväxt det sista kvartalet", body: """
Tillväxten det sista kvartalet av år 1 är 1–2 cm i månaden och 300–500 g per månad. Det är mycket långsammare än de första månaderna. Kurvan ska följa samma percentil som tidigare — inte stiga eller sjunka drastiskt. BVC har tillväxtkurvor anpassade för ammat barn respektive ersättningsbarn.
"""),
                ArticleSection(heading: "Selektiv aptit och matvanor", body: """
Bebisen börjar visa tydliga preferenser och avvisanden. Det är normalt och kallas 'neofobia' (rädsla för ny mat) — det är en evolutionär skyddsmekanism. Fortsätt erbjuda mat utan tvång. Det tar 10–15 exponeringar för ett nytt livsmedel innan ett litet barn accepterar det. Tvinga aldrig — det skapar negativa associationer.
"""),
                ArticleSection(heading: "Vitamin D och näring", body: """
Vitamin D-tillskott rekommenderas hela det första levnadsåret (10 µg/dag). Om bebisen äter lite kött: kontrollera järnstatus med BVC. Kalcium täcks av bröstmjölk, ersättning eller mejeriprodukter. Inga tillsatt socker, honung (risk för botulism under 1 år) eller salt.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om mat och tillväxt",
                consensus: "Aptitdipparna oroar de flesta — men BVC bekräftar att kurvan håller.",
                quotes: [
                    "Åt fantastiskt i sex månader och vägrar nu hälften av allt. BVC sa att det är normalt.",
                    "D-vitamin-droppar varje morgon. Glömmer ibland men försöker."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 43
        Article(
            id: "baby_week_43",
            category: .development,
            title: "Vecka 43 — Lekfullhet och humor",
            subtitle: "Bebisen förstår och skapar roliga situationer",
            icon: "theatermasks.fill",
            readTimeMinutes: 3,
            intro: "Runt 43 veckor visar många bebisar tydliga tecken på humor. De förstår vad som är oväntat, absurt eller roligt — och provocerar gärna fram reaktioner.",
            sections: [
                ArticleSection(heading: "Humorutveckling", body: """
Bebisens humor bygger på det oväntade och inkongruenta — något som bryter mot förväntningen. De skrattar när du låtsas nys, lägger saker på fel ställe eller gör dumma ljud. De provocerar också medvetet: kastar mat från stolen och tittar på dig för att se reaktionen. Det är social testning, inte olydnad.
"""),
                ArticleSection(heading: "Social lek och samspel", body: """
Rollek i rudimentär form: bebisen matar nallebjörnen, lägger dockan att sova, 'kokar' i leksaksköket. Härmning av vardagshandlingar är rikare. Parallell lek med ett annat barn: sitter bredvid och leker med liknande leksaker, tittar på och imiterar. Äkta samlek börjar vid 18–24 månader.
"""),
                ArticleSection(heading: "Sömn inför ettårsdagen", body: """
Sömnen är nu ganska stabil för de flesta. 2 dagsövnar, totalt 2–3 timmar dagtid, 10–12 timmar natt. Om sömnproblemen kvarstår: prata med BVC. Kom ihåg att sömnbehov varierar — jämför inte med andra familjer.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om bebishumor",
                consensus: "Bebisens humor är helt på deras egna villkor — och fullständigt charmig.",
                quotes: [
                    "Kastar ärterna från stolen och fnissar åt mig. Vet precis vad hon gör.",
                    "Lägger nallebjörnen att sova och lägger en filt över. Varje kväll."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 44
        Article(
            id: "baby_week_44",
            category: .development,
            title: "Vecka 44 — Ordförrådet växer",
            subtitle: "Förståelse löper långt före tal",
            icon: "character.book.closed.fill",
            readTimeMinutes: 3,
            intro: "Vid 44 veckor är klyftan mellan passivt och aktivt ordförråd stor. Bebisen förstår enormt mycket mer än den kan säga — och det är helt normalt.",
            sections: [
                ArticleSection(heading: "Passivt vs aktivt ordförråd", body: """
Vid 11 månader förstår bebisen typiskt 50–100 ord passivt men producerar 1–5 aktivt. Det beror på att förståelse kräver att höra ett ljud kopplas till ett objekt, medan produktion kräver kontroll av talorganen och motorisk planering. Ordproduktionen exploderar vanligen vid 18 månader ('ordexplosion').
"""),
                ArticleSection(heading: "Läsning och ordförrådsbyggande", body: """
Läs högt varje dag — 15–20 minuter är idealiskt men även 5 minuter gör skillnad. Peka på bilder och namnge: 'Titta, en hund! Hunden säger voff.' Ställ enkla frågor: 'Var är bollen?' och vänta på pekning. Böcker med enkla bilder och ett ord per sida är perfekt nu.
"""),
                ArticleSection(heading: "Motorik och finmotorik", body: """
Bebisen kan nu lägga en kloss på en annan (stapla). Vänder sidor i en bok (grovmotoriskt). Skruvar på locket av en burk. Dessa finmotoriska prestationer kräver planering och koordination — kognition och motorik samarbetar.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om ordförrådsutvecklingen",
                consensus: "De förstår allt men säger lite — det är frustrerande och fascinerande.",
                quotes: [
                    "Frågade var skon var och han gick direkt och hämtade den. Förstår allt!",
                    "Läser tre böcker om kvällen. Han pekar på varje bild och väntar på att jag ska namnge."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 45
        Article(
            id: "baby_week_45",
            category: .development,
            title: "Vecka 45 — Första stegen",
            subtitle: "Det oförglömliga ögonblicket",
            icon: "figure.walk.circle.fill",
            readTimeMinutes: 4,
            intro: "Runt 45 veckor tar många bebisar sina allra första självständiga steg. Det är ett av föräldraskapets absolut mest minnesvärda ögonblick.",
            sections: [
                ArticleSection(heading: "De första stegen", body: """
Normalt att börja gå mellan 9 och 15 månader — allt inom det spannet är normalt. De första stegen är korta, osäkra och med brett bensteg. Fallet tillhör processen — barnet lär sig av varje fall. Uppmuntra utan att överdriva eller göra fall dramatiska. Gå barfota eller med strumpor med halkskydd inomhus för bäst markkontakt.
"""),
                ArticleSection(heading: "Hjärnan och gångmönstret", body: """
Att gå är neurologiskt extremt komplext: det kräver synkroniserad aktivering av hundratals muskler, balansorganen, proprioception, syn och planering. Det tar 2–3 månader efter de första stegen innan gångmönstret är stabilt och effektivt. Farten och uthålligheten ökar snabbt de första veckorna.
"""),
                ArticleSection(heading: "Tillväxt och rörelse", body: """
Nu när bebisen går, ökar kaloribehovet ytterligare. Benen är ofta lite krokiga (bowlegs) vid gångstart — det är normalt och rätar ut sig. Plattfot (utan fotvalv) är normalt upp till 3–4 år. Kontakta BVC om du märker att bebisen haltar, ett ben är styvare eller om gångstarten uteblir efter 15 månader.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om de första stegen",
                consensus: "Du gråter. Det är oundvikligt.",
                quotes: [
                    "Fyra steg mot mig. Jag grät så mycket att jag inte ens filmade.",
                    "Gick tre steg, föll, reste sig och gick tre till. Inga problem alls."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 46
        Article(
            id: "baby_week_46",
            category: .growth,
            title: "Vecka 46 — Ettårskontroll förbereds",
            subtitle: "Inför det stora BVC-besöket",
            icon: "stethoscope",
            readTimeMinutes: 3,
            intro: "Med bara veckor kvar till ettårsdagen börjar förberedelsen inför ettårskontrollen på BVC. Det är en av de viktigaste och mest heltäckande kontrollerna under barnets första år.",
            sections: [
                ArticleSection(heading: "Ettårskontrollens innehåll", body: """
Ettårskontrollen inkluderar: vikt, längd, huvudomfång, syn och hörsel, motorisk granskning (går? kryper?), kommunikation (ord, pekande, gemensam uppmärksamhet), socialt samspel och föräldrahälsa. MCHAT-R screeningen fylls i. Vaccinationer ges (MPR-vaccin mot mässling, påssjuka, röda hund).
"""),
                ArticleSection(heading: "Frågor att ta med till BVC", body: """
Förbered frågor: Hur värderar ni ordförrådsutvecklingen? Är rörelseförmågan normal? Hur gör vi med amning och ersättning efter 1 år? Vad bör vi tänka på med mat och mjölk? Hur mycket är normalt att sova? Är det vi upplever typiskt? Skriv ner frågorna i förväg.
"""),
                ArticleSection(heading: "Amning och mjölk efter 1 år", body: """
WHO rekommenderar amning till 2 år och därutöver om det fungerar. Svenska råd: amning välkomnas så länge det fungerar. Komjölk kan introduceras vid 1 år som dryck (inte som primär dryck för under 1 år). Ersättning avslutas vid 1 år om barnet äter bra mat och dricker modersmjölksersättning ersätts av komjölk.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om ettårskontroll",
                consensus: "Ettårskontrollen väcker reflektioner om hela det gångna året.",
                quotes: [
                    "Hade en lista med åtta frågor. BVC-sköterskan svarade på alla lugnt och tydligt.",
                    "MPR-vaccinet gick bra — pigg och glad efteråt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 47
        Article(
            id: "baby_week_47",
            category: .development,
            title: "Vecka 47 — Envishet och gränser",
            subtitle: "Viljan vaknar",
            icon: "exclamationmark.triangle.fill",
            readTimeMinutes: 3,
            intro: "Runt 47 veckor blir bebisens vilja alltmer tydlig. Det säger nej, kastar leksaker och blir frustrerat när det inte får som det vill. Det är sunt och normalt — och starten på gränsövning.",
            sections: [
                ArticleSection(heading: "Autonomi och envishet", body: """
Viljan att göra saker själv och på eget vis är ett tecken på hälsosam psykologisk utveckling. Bebisens hjärna utforskar agentskap — att den egna viljan kan orsaka saker i världen. Frustrationen när det inte lyckas är äkta och intensiv. Ge bebisen möjligheter att lyckas: säkra situationer där den kan utöva kontroll.
"""),
                ArticleSection(heading: "Gränssättning för de minsta", body: """
Konsekventa, kärleksfulla gränser ger trygghet. 'Nej' är inte ett straff — det är information. Omdirigering fungerar bättre än förbud i denna ålder: flytta bebisen till ett alternativ istället för att bara säga nej. Bibehåll lugnet — bebisens reglering är beroende av din reglering.
"""),
                ArticleSection(heading: "Sömn och motoriskt språng", body: """
Gångsprånget påverkar sömnen. Bebisen övar gångmönster mentalt om natten och kan ha svårare att somna. Håll rutinen stabil. Extra tid vid läggning är okej under språnget. Det går över.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om envishet och gränser",
                consensus: "Det är tidigt för 'terrible twos' — men försmaken kommer nu.",
                quotes: [
                    "Kastar tallriken på golvet och tittar stint på mig. Testar gränserna aktivt.",
                    "Omdirigering fungerar fortfarande — ta bort telefonen och ge en boll."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 48
        Article(
            id: "baby_week_48",
            category: .development,
            title: "Vecka 48 — Tolv månader!",
            subtitle: "Ett helt år",
            icon: "birthday.cake.fill",
            readTimeMinutes: 5,
            intro: "Ettårsdagen är här. Från ett hjälplöst nyfött till ett gående, talande, skrattande litet barn på ett år. Fira — det är förtjänat.",
            sections: [
                ArticleSection(heading: "Milstolpar vid 12 månader", body: """
Vid 12 månader bör de flesta barn: gå eller stå fritt (eller ha tydlig riktning mot det), ha minst 1 ord med konsekvent mening, peka på föremål, vinka, ha gemensam uppmärksamhet, reagera på sitt namn. Förståelse av enkla instruktioner. Stor variation är normal — prata med BVC om du är orolig.
"""),
                ArticleSection(heading: "Ettårskontrollen", body: """
Ettårskontrollen är heltäckande. MPR-vaccination ges. Läkaren granskar motorik, kommunikation, syn och hörsel. MCHAT-R fylls i. Diskutera mat, sömn, tandvård och föräldrahälsa. Ta med alla frågor du haft under det gångna året — det är sista möjligheten för en tid.
"""),
                ArticleSection(heading: "Reflektioner och framåtblick", body: """
Det första året är ett av de tuffaste och finaste i livet. Du har sovit lite, vuxit mycket och lärt dig mer om kärlek än du visste var möjligt. Ditt barn är unikt. Jämför inte — följ ditt barns kurva, inte andras. Det andra året bjuder på ännu mer personlighet, fler ord och ett allt tydligare 'jag'.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om ettårsdagen",
                consensus: "Alla gråter. Barnet är mer intresserat av presentpappret än presenten.",
                quotes: [
                    "Satt med tårtor i håret och fnissade. Det perfekta ettårsfirandet.",
                    "Tittade på bilderna från födseln och förstod inte hur fort det gick."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 49
        Article(
            id: "baby_week_49",
            category: .development,
            title: "Vecka 49 — Livet efter ettårsdagen",
            subtitle: "Nu börjar det riktigt roliga",
            icon: "sparkles",
            readTimeMinutes: 3,
            intro: "Veckan efter ettårsdagen — barnet är nu ett toddler. Rörligheten, nyfikenheten och kommunikationen tar nya kliv i det andra levnadsåret.",
            sections: [
                ArticleSection(heading: "Toddlerlivets start", body: """
Det andra levnadsåret präglas av rörlighet, språkexplosion och stark autonomiutveckling. Barnet utforskar utan rädslor och behöver trygga vuxna som sätter säkra gränser. Separation från föräldrar är fortfarande svår men lättare än vid 8–9 månader för många. Nyfikenheten är outtröttlig.
"""),
                ArticleSection(heading: "Mat efter 1 år", body: """
Komjölk som dryck: max 3–4 dl per dag för att inte tränga undan mat. Familjemat i alla former. Salt och socker kan förekomma i liten mängd nu. Undvik fortfarande: honung (till 2 år), hela nötter, hårda råa morötter och andra kvävningsrisker. Tre mål och 1–2 mellanmål per dag.
"""),
                ArticleSection(heading: "Sömn i det andra levnadsåret", body: """
De flesta ettåringar sover 11–14 timmar totalt. Dagsömnen är fortfarande 2 pass (övergång mot 1 pass sker 12–18 månader). Kvällsrutinen är viktig — förutsägbarhet och lugn signalerar att natten är nära. Nattuppvaknanden är fortfarande normala.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om livet precis efter ettårsdagen",
                consensus: "Det roligaste och tuffaste börjar nu på riktigt.",
                quotes: [
                    "Toddler på riktigt nu. Allt är ett äventyr och en katastrof på samma gång.",
                    "Komjölken gick hem direkt. Ingen konflikt med amningen."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 50
        Article(
            id: "baby_week_50",
            category: .growth,
            title: "Vecka 50 — Gångstabilitet och fart",
            subtitle: "Gångmönstret mognar snabbt",
            icon: "figure.run",
            readTimeMinutes: 3,
            intro: "Vecka 50 — barnet har nu gått i ett par veckor och stabiliteten förbättras snabbt. Steglängden ökar, armrörelserna balanserar och snart kommer springet.",
            sections: [
                ArticleSection(heading: "Gångmognaden", body: """
Under de första veckorna av gång är steget brett, osäkert och med händerna högt. Successivt: armarna sjunker, stegen blir smalare och rytmiska. Det normala 'W-sittandet' (sitter på knäna med fötterna ut) är vanligt och ofarligt. Tågångning (tiptoeing) är normalt upp till 2–3 år om det inte är konsekvent och ensidigt.
"""),
                ArticleSection(heading: "Kommunikation och ord", body: """
Ordantalet ökar nu snabbt. Barnet prövar nya ljud varje dag. Ord kan vara förenklade men konsistenta: 'ba' för boll, 'nana' för banan. Gestikulering med pekande och visande är en viktig del av kommunikationen. Bekräfta allt barnet kommunicerar — det uppmuntrar till mer.
"""),
                ArticleSection(heading: "Lek och kognition", body: """
Orsak-verkan är nu väl förstått. Sortera föremål efter storlek eller färg börjar. Lyssnar till enkla berättelser i böcker och tittar på bilderna. Imiterar hushållssysslor: sopar med leksakskvast, 'lagar mat'. Låtsasleken är under snabb utveckling.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om gångstabiliteten",
                consensus: "Farten ökar exponentiellt — håll koll på handen i trafiken.",
                quotes: [
                    "Sprang! Tre steg och sedan platt på näsan. Reste sig och sprang igen.",
                    "Sopar golvet med min sopkvast varje morgon. Hjälper faktiskt lite."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 51
        Article(
            id: "baby_week_51",
            category: .development,
            title: "Vecka 51 — Imitation och inlärning",
            subtitle: "Barnet lär sig genom att se och kopiera",
            icon: "eyes.inverse",
            readTimeMinutes: 3,
            intro: "Vid 51 veckor är imitation barnets primära inlärningsmetod. Allt du gör kopieras — med stor noggrannhet och stor humor.",
            sections: [
                ArticleSection(heading: "Imitationsinlärning", body: """
Imitation av vuxnas handlingar är nu sofistikerad: barnet kopierar inte bara enstaka gester utan sekvenser av handlingar ('förbered mat', 'städa'). Denna förmåga kallas 'overimitation' — barnet kopierar även onödiga steg i en process, vilket tyder på att det tolkar handlingar som meningsfulla och socialt viktiga. Det är en markör för social intelligens.
"""),
                ArticleSection(heading: "Språk och tvåspråkighet", body: """
Tvåspråkiga barn kan ha ett något mindre aktivt ordförråd i varje språk vid 12 månader, men det totala ordantalet är normalt. De hänger fullt upp inom 18–24 månader. Blanda inte ihop språken i samma mening (code-switching) om möjligt — tydligare separation hjälper sorteringen. Varje förälder talar sitt modersmål.
"""),
                ArticleSection(heading: "Sömn och sista dagsövnen", body: """
Mot slutet av det första året börjar en del barn visa tecken på att vilja gå mot ett dagspass. Tecken: tar lång tid att somna på förmiddagen, kortar ner eftermiddagspasset. Vänta gärna till 15–18 månader med att ta bort förmiddagspasset om det är möjligt — det minskar övertrötthet.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om imitationsglädjen",
                consensus: "Det är skrämmande och fantastiskt vad barnet kopierar.",
                quotes: [
                    "Tog min telefon och 'pratade' i den. Exakt mitt tonfall. Jobbigt.",
                    "Kopplar efter mig i köket. Fattar att det är imitation men det är fortfarande för söt."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

        // MARK: Vecka 52
        Article(
            id: "baby_week_52",
            category: .development,
            title: "Vecka 52 — Ett helt år av kärlek",
            subtitle: "Tillbakablick och framtidsblik",
            icon: "heart.circle.fill",
            readTimeMinutes: 5,
            intro: "Vecka 52 — det sista kapitlet i det första levnadsåret. Från knappt 50 cm och 3 kg till en gående, talande, skrattande liten människa. Det är otroligt.",
            sections: [
                ArticleSection(heading: "Ett år av utveckling", body: """
Under det första levnadsåret har hjärnan fördubblat sin volym. Barnet har gått från total hjälplöshet till att gå, kommunicera, lösa problem och ha starka sociala band. Synapstätheten i hjärnan toppar just nu och är högre än den någonsin kommer att vara i vuxen ålder. Det första året lägger grunden för allt som kommer.
"""),
                ArticleSection(heading: "Anknytning och trygghet", body: """
En trygg anknytning till minst en primär omsorgsperson är den viktigaste skyddsfaktorn för barns psykiska hälsa, skolresultat och relationer som vuxna. Du behöver inte vara perfekt — du behöver vara tillräckligt bra och tillgänglig. Reparation av konflikter ('förtjusning-bråk-reparation') är lika viktig som harmoni.
"""),
                ArticleSection(heading: "Blick framåt — det andra levnadsåret", body: """
Det andra levnadsåret bjuder på ordexplosion (18 månader), djupare rollek, starka vänskap och de berömda 'terrible twos' (som faktiskt är ett tecken på hälsosam autonomiutveckling). Var nyfiken på vem ditt barn håller på att bli. Det bästa kapitlet är alltid det nästa.
""")
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar om att avsluta det första året",
                consensus: "Det gick för fort. Det var för svårt. Det var det finaste i livet.",
                quotes: [
                    "Tittade på nyföddbilderna och grät. Sedan tittade jag på henne nu och grät igen.",
                    "Jag är en annan människa efter det här året. Bättre, tror jag."
                ],
                source: "Familjeliv.se"
            ),
            sources: ["1177.se", "Rikshandboken"]
        ),

    ]
}
