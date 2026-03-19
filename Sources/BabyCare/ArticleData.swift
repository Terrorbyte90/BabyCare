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
