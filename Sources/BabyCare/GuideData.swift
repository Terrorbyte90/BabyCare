import SwiftUI

// MARK: - Guide Articles

extension Article {

    // MARK: Fertility Guides (10 articles)
    static let fertilityGuides: [Article] = [

        // MARK: 1 — LH-tester
        Article(
            id: "guide_lh_tester",
            category: .fertility,
            title: "LH-tester — hur de fungerar och tolkas",
            subtitle: "Identifiera din ägglossning med urintester",
            icon: "drop.circle.fill",
            readTimeMinutes: 6,
            intro: "LH-tester (luteiniserande hormon) är ett av de enklaste och mest tillförlitliga sätten att identifiera sitt fertila fönster. Hormonet LH stiger kraftigt 24–36 timmar före ägglossningen — LH-surgen — och ett positivt test innebär att ägglossningen sannolikt sker inom ett dygn. Den här guiden förklarar hur testerna fungerar, hur du tolkar dem korrekt och vilka fallgropar som finns.",
            sections: [
                ArticleSection(
                    heading: "Hur LH-tester fungerar",
                    body: "LH produceras av hypofysen och styr äggstockarnas funktion under hela menscykeln, men det är den kraftiga ökningen — surgen — strax före ägglossningen som är diagnostiskt användbar. Testremsor mäter LH-koncentrationen i urin och visar en positiv rad när värdet överstiger ett visst tröskelvärde, vanligtvis 20–40 mIU/ml beroende på fabrikat.\n\nDigitala LH-tester (exempelvis Clearblue Digital) visar ett smileyansikte vid positivt resultat och är lättare att tolka, men kostar mer per test. Remstestar från apotek fungerar lika bra medicinskt men kräver mer övning i avläsning — testlinjen ska vara lika mörk eller mörkare än kontrolllinjen för att räknas som positiv.\n\nTesta morgon- eller eftermiddagsurin (undvik första morgonurinen som kan ge falskt negativa resultat på grund av utspädning). Börja testa 3–4 dagar före förväntad ägglossning — för en 28-dagarscykel runt dag 10–11."
                ),
                ArticleSection(
                    heading: "Tolka resultatet rätt",
                    body: "Ett positivt LH-test innebär att ägglossning förväntas ske inom 12–36 timmar. Det optimala tillfället för samlag är samma dag som det positiva testet och dagen efter. Väntar du längre riskerar du att missa det fertila fönstret eftersom äggcellen bara överlever 12–24 timmar efter ägglossning.\n\nNegativa tester med svaga linjer är normalt — LH finns alltid i lågkoncentration. Förväxla inte en svag linje med ett positivt resultat; den måste vara lika mörk som kontrolllinjen.\n\nKvinnor med PCOS kan ha kroniskt förhöjda LH-värden och få falska positiva resultat eller flera toppar under en cykel. I dessa fall kan basaltemperaturmätning (BBT) komplettera för att bekräfta att ägglossning faktiskt skett."
                ),
                ArticleSection(
                    heading: "Praktiska tips",
                    body: "Testa vid samma tid varje dag för jämförbara resultat. Spara använda teststickor i ett plastficka med datum — en visuell tidslinje hjälper dig se när linjen mörknar.\n\nAvancerade monitorer som Clearblue Connected mäter även östrogen och ger ett bredare fertilt fönster (upp till 6 dagar), men kostar betydligt mer. För de flesta par som försöker bli gravida räcker enkla LH-remsor.\n\nOm du inte fått positivt test vid dag 20 av en normal 28-dagarscykel är det troligt att ägglossning uteblivit den cykeln (anovulatorisk cykel). Kontakta barnmorska eller läkare om detta sker upprepat."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "På svenska föräldraforum diskuteras ofta hur man tolkar svagt positiva LH-tester.",
                consensus: "De flesta erfarenheter pekar på att konsekvens — testa vid samma tid varje dag — ger mest tillförlitliga resultat.",
                quotes: [
                    "\"Jag köpte billiga teststickor i bulk och fotograferade dem varje dag — då ser man verkligen när linjen mörknar!\" – Familjeliv",
                    "\"Mitt LH-surge pågick bara 12 timmar, hade jag inte testat två gånger om dagen hade jag missat det.\" – Babycentrum-forum",
                    "\"Med PCOS fick jag positiva tester nästan varje dag i veckor. BBT hjälpte mig förstå vad som faktiskt hände.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Fertility and Sterility journal"]
        ),

        // MARK: 2 — BBT
        Article(
            id: "guide_bbt",
            category: .fertility,
            title: "Basaltemperatur (BBT) — mäta, tolka och använda",
            subtitle: "Förstå din cykel via daglig temperaturmätning",
            icon: "thermometer.medium",
            readTimeMinutes: 7,
            intro: "Basal kroppstemperatur (BBT) är din vilotemperatur mätt direkt vid uppvaknandet, innan du rör dig. Efter ägglossning stiger temperaturen med 0,2–0,5 °C på grund av progesteron och förblir förhöjd tills nästa mens. Genom att föra ett temperaturdiagram varje dag kan du retroaktivt bekräfta att ägglossning skett — och med tid lära dig förutsäga när den sker.",
            sections: [
                ArticleSection(
                    heading: "Hur du mäter korrekt",
                    body: "Använd ett BBT-termometer med två decimaler (exempelvis 36,62 °C). Vanliga febertermometrar är inte tillräckligt exakta. Mät oralt, vaginalt eller rektalt — välj en plats och håll dig till den under hela cykeln.\n\nMät varje morgon vid samma tid (±30 min), direkt vid uppvaknandet innan du sätter fötterna i golvet, dricker vatten eller pratar. Sätt gärna termometern på nattduksbordet kvällen innan. Minst 3 timmars sammanhängande sömn krävs för ett tillförlitligt värde.\n\nNotera störningar: kortare sömn, alkohol kvällen innan, infektion eller stress kan ge tillfälligt höjda värden som bör markeras separat i diagrammet."
                ),
                ArticleSection(
                    heading: "Tolka temperaturkurvan",
                    body: "En typisk kurva visar en lägre fas (follikelfasen) följt av en tydlig temperaturökning på 0,2–0,5 °C som håller sig förhöjd i 10–16 dagar (lutealfasen). Denna bifasiska kurva bekräftar att ägglossning ägt rum.\n\nÄgglossning sker vanligtvis 1–2 dagar INNAN temperaturstegringen, inte vid stegringen. BBT berättar alltså i efterhand att du ägglossade — kombinera med LH-tester för att fånga det fertila fönstret i realtid.\n\nOm kurvan inte visar tydlig uppdelning (monofasisk) under flera cykler kan det tyda på anovulatoriska cykler. En temperatur som förblir förhöjd i mer än 18 dagar efter förväntad ägglossning utan mens är ett tidigt graviditetstecken."
                ),
                ArticleSection(
                    heading: "Appar och digitala hjälpmedel",
                    body: "Appar som Natural Cycles (CE-märkt medicinteknisk produkt), Kindara och Clue Pro hjälper dig registrera och visualisera BBT-data. Natural Cycles är den enda appen godkänd som preventivmedel i EU — men som TTC-verktyg fungerar alla dessa appar väl.\n\nWearables som Tempdrop (bärs under armen över natten) mäter kontinuerlig temperatur och kompenserar automatiskt för störd sömn — praktiskt för skiftarbetare.\n\nKom ihåg att BBT ensamt ger ett retroaktivt besked om ägglossning. För att maximera chansen att träffa rätt bör du kombinera metoden med cervixslemobservation och/eller LH-tester."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Många delar sina BBT-diagram och frågar om tolkning i svenska TTC-forum.",
                consensus: "Konsistens är nyckeln — de som mäter vid exakt samma tid varje dag får de mest pålitliga diagrammen.",
                quotes: [
                    "\"Första månaden förstod jag ingenting av diagrammet, tredje månaden kunde jag nästan förutsäga exakt när jag ägglossade.\" – Familjeliv TTC-tråd",
                    "\"Tempdrop förändrade allt för mig — ingen mer stressig vaken mätning klockan 6 exakt.\" – Instagram-kommentar",
                    "\"Min kurva var monofasisk i tre månader, läkaren hittade att jag hade PCOS. Utan BBT hade jag aldrig sökt hjälp.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, Natural Cycles community"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Natural Cycles kliniska dokumentation"]
        ),

        // MARK: 3 — PCOS och fertilitet
        Article(
            id: "guide_pcos_fertilitet",
            category: .fertility,
            title: "PCOS och fertilitet",
            subtitle: "Polycystiskt ovariesyndrom och vägen till graviditet",
            icon: "waveform.path.ecg",
            readTimeMinutes: 8,
            intro: "Polycystiskt ovariesyndrom (PCOS) är den vanligaste hormonella störningen hos kvinnor i fertil ålder och drabbar uppskattningsvis 8–13 procent av alla kvinnor. PCOS är en av de ledande orsakerna till anovulation och ofrivillig barnlöshet, men med rätt diagnos och behandling blir majoriteten av kvinnor med PCOS gravida.",
            sections: [
                ArticleSection(
                    heading: "Symtom och diagnos",
                    body: "PCOS diagnostiseras enligt Rotterdam-kriterierna (2003) när minst två av tre kriterier uppfylls: oregelbundna eller uteblivna mens, kliniska eller biokemiska tecken på hyperandrogenism (acne, ökad kroppsbehåring, förhöjda androgennivåer), samt polycystisk morfologi på äggstockarna vid ultraljud.\n\nVanliga symtom inkluderar oregelbunden menscykel (cykler längre än 35 dagar), svårigheter att gå ner i vikt, insulinresistens och psykisk ohälsa (depression och ångest är vanligare vid PCOS).\n\nDiagnosen ställs av gynekolog via blodprov (LH, FSH, testosteron, DHEAS, AMH, insulin) och ultraljud. AMH är typiskt kraftigt förhöjt vid PCOS."
                ),
                ArticleSection(
                    heading: "Behandling för att uppnå graviditet",
                    body: "Livsstilsförändringar är förstahandsbehandling, särskilt vid övervikt. En viktnedgång på 5–10 % kan återställa ägglossning hos många. Lågglykemisk kost och regelbunden fysisk aktivitet förbättrar insulinkänsligheten.\n\nLäkemedelsbehandling börjar vanligtvis med letrozol (aromatashämmare), som numera rekommenderas framför klomifen som förstahandsval för ovulationsinduktion vid PCOS. Metformin kan läggas till för att förbättra insulinkänsligheten.\n\nVid utebliven respons erbjuds gonadotrofininjektioner under ultraljudsövervakning, laparoskopisk ovariell drilling (LOD) eller IVF/ICSI. Kvinnor med PCOS har god äggstocksreserv men riskerar ovariellt hyperstimuleringssyndrom (OHSS)."
                ),
                ArticleSection(
                    heading: "Leva med PCOS på lång sikt",
                    body: "PCOS innebär ökad livstidsrisk för typ 2-diabetes, metabolt syndrom och hjärt-kärlsjukdom. Regelbunden uppföljning hos läkare är viktig även efter graviditet.\n\nUnder graviditet är risken för graviditetsdiabetes, preeklampsi och prematuritet förhöjd — noggrannare kontroller erbjuds via MVC.\n\nPsykisk hälsa bör inte glömmas bort: ångest och depression förvärras ofta under TTC-perioden. Kuratorkontakt eller KBT kan vara ett viktigt komplement."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "PCOS är ett av de mest diskuterade ämnena i svenska fertilitetsforum.",
                consensus: "Livsstilsförändringar i kombination med medicinsk behandling ger bäst resultat.",
                quotes: [
                    "\"Jag fick diagnosen sent, efter tre års försök. Letrozol + lågkolhydratkost och jag var gravid efter andra behandlingscykeln.\" – Familjeliv",
                    "\"Kräv remiss till gynekolog om du misstänker PCOS — vänta inte ett år.\" – PCOS Sverige-forumet",
                    "\"AMH 32 och inga ägglossningstecken alls — men med rätt behandling fick vi vår son till slut.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, PCOS Sverige"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Rotterdam PCOS Consensus 2003", "Human Reproduction journal", "FIGO PCOS guidelines 2023"]
        ),

        // MARK: 4 — IVF-processen
        Article(
            id: "guide_ivf_processen",
            category: .fertility,
            title: "IVF-processen steg för steg",
            subtitle: "Från utredning till embryoöverföring",
            icon: "staroflife.circle.fill",
            readTimeMinutes: 10,
            intro: "IVF (in vitro-fertilisering) innebär att ägg befruktas utanför kroppen i laboratorium. I Sverige utförs IVF både inom offentlig vård (med subventionerad avgift) och privat. Processen är medicinsk och emotionellt krävande, men ger många par möjlighet att bilda familj när naturliga försök inte lyckats.",
            sections: [
                ArticleSection(
                    heading: "Utredning och förberedelse",
                    body: "Innan IVF påbörjas görs en grundlig utredning av båda parter. Kvinnan undersöks med ultraljud, blodprov (AMH, FSH, LH, östradiol, sköldkörtelhormoner) och ibland hysteroskopi. Mannen lämnar spermaanalys.\n\nI Sverige rekommenderar Socialstyrelsen subventionerad IVF efter 12 månaders ofrivillig barnlöshet (6 månader om kvinnan är över 38 år). Folsyra (400 µg/dag) rekommenderas minst 1 månad innan behandlingsstart."
                ),
                ArticleSection(
                    heading: "Stimulering, äggplock och befruktning",
                    body: "Stimuleringsfasen varar 10–14 dagar med dagliga injektioner av gonadotropiner som stimulerar äggstockarna att producera flera folliklar. Ultraljudskontroller och blodprover varannan dag följer tillväxten.\n\nTrigger-injektion ges 34–36 timmar innan äggplock, som sker under ultraljudsvägledning via vagina med sedering. 8–15 ägg är ett typiskt utfall.\n\nBefruktning sker med standard IVF eller ICSI (ett spermium injiceras direkt i ägget). Embryona odlas 3–5 dagar i inkubator."
                ),
                ArticleSection(
                    heading: "Embryoöverföring och graviditetstest",
                    body: "På dag 3 (8-cellsstadiet) eller dag 5 (blastocyst) väljs det bäst utvecklade embryot för överföring. Blastocystöverföring ger något bättre implantationsfrekvens. Övriga livskraftiga embryon fryses.\n\nProgesteronstöd ges som vagitorier eller injektioner. Graviditetstest (blod-hCG) tas 10–14 dagar efter embryoöverföring. Implantationsfrekvens per överförd blastocyst är ca 40–50 % i Sverige (Q-IVF)."
                ),
                ArticleSection(
                    heading: "Känslomässiga aspekter",
                    body: "IVF är emotionellt intensivt — hormoner, väntan och osäkerhet påverkar hela relationen. Kurator finns kopplad till de flesta fertilitetskliniker i Sverige och rekommenderas varmt.\n\nEn genomsnittlig levande födselsfrekvens per påbörjad cykel är ca 25–30 % i Sverige (Q-IVF 2022), vilket innebär att de flesta par behöver mer än ett försök. Realistiska förväntningar tidigt minskar risken för kris vid negativa besked."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "IVF-forum är aktiva i Sverige med tusentals inlägg om processen, biverkningar och resultat.",
                consensus: "Information och förberedelse minskar ångesten — ställ frågor till kliniken och ta hjälp av kuratorn.",
                quotes: [
                    "\"Ingen berättade att progesteronpessarierna gör en så uppsvälld och yr. Bra att veta i förväg.\" – Familjeliv IVF-tråd",
                    "\"Tredje försöket, äntligen en liten plus. Ge inte upp efter ett negativt svar.\" – Babycentrum",
                    "\"Kuratorn på kliniken räddade mitt äktenskap under processen.\" – Nätet mot ofrivillig barnlöshet"
                ],
                source: "Familjeliv.se, Q-IVF nationellt register"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Q-IVF Nationellt kvalitetsregister 2022", "ESHRE guidelines on ART 2023"]
        ),

        // MARK: 5 — Timing och samlag
        Article(
            id: "guide_timing_samlag",
            category: .fertility,
            title: "Timing och samlag — när och hur ofta",
            subtitle: "Maximera chansen under det fertila fönstret",
            icon: "calendar.badge.clock",
            readTimeMinutes: 5,
            intro: "Det fertila fönstret — de dagar per cykel då graviditet är möjlig — är begränsat till ungefär 6 dagar: de 5 dagarna innan ägglossning och dagen för ägglossning. Spermier överlever 3–5 dagar i livmoderhalsen, medan äggcellen överlever 12–24 timmar. Att förstå detta fönster ökar chansen avsevärt utan minutiös planering.",
            sections: [
                ArticleSection(
                    heading: "Det fertila fönstret",
                    body: "Forskning (Wilcox et al., NEJM 1995) visar att graviditeter nästan uteslutande uppstår vid samlag under de 6 dagarna fram till och med ägglossningsdagen. Chansen per samlag topper 2 dagar innan ägglossning och på ägglossningsdagen (ca 25–30 % per cykel för unga friska par).\n\nIdentifiera ägglossning via: LH-tester (positiv 12–36 h före ägglossning), cervixslem (äggviteliknande töjbart slem signalerar fertil fas) eller BBT-kurva. Ägglossning sker vanligtvis 14 dagar FÖR nästa mens, inte 14 dagar efter sista mensens start."
                ),
                ArticleSection(
                    heading: "Hur ofta?",
                    body: "Dagligt samlag under det fertila fönstret ger något högre graviditetschans jämfört med varannan dag, men skillnaden är liten. Varannan dag under den fertila perioden är en realistisk och vetenskapligt väl underbyggd rekommendation.\n\nMer frekvent samlag under icke-fertila dagar tillför inte ytterligare fördel. Spermiernas kvalitet påverkas marginellt av daglig ejakulation hos friska män — vilodagar är inte nödvändiga.\n\nUndvik lubrikanter som kan skada spermier — om lubrikant behövs välj fertilitetskompatibla produkter som Pre-Seed eller Conceive Plus."
                ),
                ArticleSection(
                    heading: "Stress och TTC",
                    body: "Stress kan påverka menscykelns längd via hypotalamus-hypofys-axeln, men det finns lite stöd för att lindrig vardagsstress direkt hindrar befruktning hos friska par. Påståendet \"sluta stressa så blir du gravid\" är förenklat och kan upplevas kränkande.\n\nOm ni försöker utan resultat i 12 månader (6 månader om ≥35 år), kontakta barnmorska för remiss till utredning — att vänta längre är onödigt."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Timing-diskussioner är vanliga i TTC-forum, med många frågor om hur ofta man ska ha samlag.",
                consensus: "Varannan dag under det fertila fönstret fungerar bra — fokus på att identifiera fönstret är viktigare än exakt frekvens.",
                quotes: [
                    "\"Vi hade samlag varannan dag från dag 10 till 18 utan att tänka på LH-tester. Fungerade utmärkt.\" – Familjeliv",
                    "\"Lubrikant-tipset är verkligt — vi använde vanlig glidmedel i ett år. Byt till Pre-Seed!\" – Babycentrum-forum",
                    "\"Sluta räkna dagar, börja observera cervixslem. Det är den bästa gratismetoden.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Wilcox AJ et al. NEJM 1995", "Socialstyrelsen", "NICE fertility guidelines 2023"]
        ),

        // MARK: 6 — Manlig fertilitet
        Article(
            id: "guide_manlig_fertilitet",
            category: .fertility,
            title: "Manlig fertilitet — spermiernas roll",
            subtitle: "Spermiekvalitet, livsstilsfaktorer och utredning",
            icon: "figure.stand",
            readTimeMinutes: 7,
            intro: "Manlig infertilitet bidrar till ca 40–50 % av alla ofrivilliga barnlöshetsproblem, men är fortfarande underdiagnostiserat eftersom utredningen ofta fokuserar på kvinnan. Spermaanalys är ett enkelt, billigt och informativt test som bör ingå tidigt i all barnlöshetsutredning. Den här guiden förklarar vad som mäts, vilka livsstilsfaktorer som påverkar och när man bör söka hjälp.",
            sections: [
                ArticleSection(
                    heading: "Spermaanalys — vad mäts?",
                    body: "WHO:s referensvärden (2021) för ett normalt spermaprov är: volym ≥1,4 ml, total spermiekoncentration ≥39 miljoner per ejakulat, rörelsehastighet (progressiv motilitet) ≥30 %, och morfologi ≥4 % normala former (Krüger strict).\n\nAzoospermi (inga spermier alls) förekommer hos ca 1 % av alla män och kräver vidare utredning med hormonstatus och ibland testikelbiopsi. Oligospermi (lågt antal), asthenozoospermi (nedsatt rörlighet) och teratozospermi (onormal morfologi) kan förekomma var för sig eller kombinerat.\n\nDNA-fragmentering är ett test som inte ingår i standardanalys men kan beställas om standardanalys är normal men paret ändå inte lyckas bli gravida — hög DNA-fragmentering kan påverka embryokvalitet och öka risken för missfall."
                ),
                ArticleSection(
                    heading: "Livsstilsfaktorer",
                    body: "Värme är spermiernas fiende: spermieproduktion sker optimalt vid 2–3 °C under kroppstemperatur. Tätsittande underkläder, heta bad, bastu och laptop i knäet under lång tid kan sänka spermiekvaliteten. Undvik dessa faktorer vid aktivt TTC.\n\nRökning minskar spermieantal och motilitet med upp till 20 %. Alkohol i stora mängder påverkar testosteronproduktionen. Anabola steroider är en vanlig orsak till azoospermi — produktionen kan ta 1–2 år att återhämtas efter avslutad användning.\n\nOxidativ stress skadar spermie-DNA. Antioxidanter (C-vitamin, E-vitamin, zink, selen, CoQ10) i kosttillskott kan ha måttlig positiv effekt enligt begränsad men lovande forskning. Medelhavskost har associerats med bättre spermiekvalitet.\n\nViktnedgång vid övervikt förbättrar hormonnivåer och spermiekvalitet. Regelbunden motion (men inte extrem uthållighetsträning) är positiv."
                ),
                ArticleSection(
                    heading: "Utredning och behandling",
                    body: "Spermaanalys kan beställas via läkare, barnmorska eller direkt på fertilitetsklinik. Provet lämnas efter 2–5 dagars sexuell abstinens. Upprepa provet om resultatet är avvikande — stor variation förekommer naturligt.\n\nVid svåra avvikelser remitteras till androlog (specialist på manlig reproduktiv medicin) eller urolog. Hormonrubbningar (lågt testosteron, högt FSH) kan ibland behandlas. Varicocele (åderbråck i pungen) kan opereras om det bedöms bidra till infertiliteten.\n\nICSI (intracytoplasmatisk spermieinjektion, ett IVF-förfarande) är standardbehandling vid svår manlig faktor — ett enda spermium kan leda till graviditet."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Manlig fertilitet diskuteras alltmer öppet i svenska forum, men är fortfarande underrepresenterat.",
                consensus: "Spermaanalys tidigt i utredningen sparar tid och kan styra om fokus från enbart kvinnan.",
                quotes: [
                    "\"Jag väntade ett år med att testa mig. Mitt spermievärde var noll. Hade vi vetat det tidigare hade vi startat IVF mycket snabbare.\" – Familjeliv",
                    "\"Sluta med bastun och täta kalsonger var de bästa råden jag fick.\" – Babycentrum-forum",
                    "\"CoQ10 i 3 månader förbättrade motiliteten från 15 % till 38 %. Kanske placebo, kanske inte — men det hände.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "WHO Laboratory Manual for Semen Analysis 2021", "Human Reproduction Update"]
        ),

        // MARK: 7 — Endometrios och fertilitet
        Article(
            id: "guide_endometrios_fertilitet",
            category: .fertility,
            title: "Endometrios och fertilitet",
            subtitle: "Hur endometrios påverkar möjligheten att bli gravid",
            icon: "heart.text.clipboard.fill",
            readTimeMinutes: 8,
            intro: "Endometrios drabbar uppskattningsvis 10 % av alla kvinnor i fertil ålder och är en av de vanligaste orsakerna till kronisk bäckensmärta och infertilitet. Sjukdomen innebär att vävnad liknande livmoderslemhinnan finns utanför livmodern, ofta på äggledare, äggstockar och bäckenhålan. Diagnosen fördröjs i genomsnitt 7–10 år — varje kvinna med svår menssmärta bör ta sina symtom på allvar.",
            sections: [
                ArticleSection(
                    heading: "Endometrios och fertilitetspåverkan",
                    body: "Endometrios påverkar fertilitet via flera mekanismer: anatomisk distorsion av äggledarna, inflammation som skadar ägg och spermier, nedsatt äggkvalitet, och immunologiska förändringar i livmodern som försvårar implantation.\n\nGraderas i stadier I–IV (minimal till svår) enligt American Society for Reproductive Medicine (ASRM). Ungefär 30–40 % av kvinnor med endometrios har svårt att bli gravida naturligt. Svårighetsgraden korrelerar dock inte alltid med fertilitetseffekten — även stadium I–II kan ge betydande infertilitet.\n\nCystor på äggstockarna (endometriom) kan skada den omgivande vävnaden och minska äggstocksreserven (lägre AMH). Kirurgi för endometriom är kontroversiellt — det kan ta bort frisk ovarialvävnad och sänka AMH ytterligare."
                ),
                ArticleSection(
                    heading: "Diagnos och behandling",
                    body: "Definitiv diagnos kräver laparoskopi med biopsi. Ultraljud kan identifiera endometriom men inte ytliga lesioner. MRI ger bättre information vid djup endometrios. Blodmarkörer (CA-125) är för opålitliga för diagnostik.\n\nFör fertilitet rekommenderas ofta att inte fördröja graviditetsförsök. Hormonell behandling (P-piller, GnRH-agonister) hämmar sjukdomen men stänger av ägglossning — inte aktuellt vid aktivt TTC.\n\nKirurgi (laparoskopi för att avlägsna lesioner och endometriom) kan förbättra naturliga graviditetschanser vid stadium I–II, men effekten är mer osäker vid svår endometrios. Diskutera alltid individuellt med specialistläkare."
                ),
                ArticleSection(
                    heading: "IVF vid endometrios",
                    body: "IVF är effektivt vid endometrios-associerad infertilitet, med liknande framgångssiffror som andra diagnoser i milda-måttliga fall. Vid svår endometrios kan äggkvalitet och ovarialrespons vara nedsatta.\n\nGDG-riktlinjer (ESHRE 2022) rekommenderar IVF vid uttalad endometrios, om röret är skadat, vid manlig faktor eller om naturlig TTC + ev. kirurgi inte lyckats inom rimlig tid.\n\nPostoperativt IVF direkt efter laparoskopi (utan graviditetsförsök däremellan) är ibland det som rekommenderas vid svår endometrios och lägre äggstocksreserv."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Endometrios-community är aktiv i Sverige med patientföreningen Endometriosföreningen Sverige.",
                consensus: "Tidig diagnos och specialistvård är avgörande — kräv remiss och acceptera inte att menssmärtan är \"normal\".",
                quotes: [
                    "\"Jag fick diagnosen vid 32 efter 8 år av oacceptabel menssmärta. Varför visste ingen om det tidigare?\" – Endometriosföreningens forum",
                    "\"IVF med nedfryst embryo efter kirurgi fungerade för oss. Ge inte upp.\" – Familjeliv",
                    "\"Kirurgi sänkte mitt AMH — det visste jag inte om i förväg. Viktigt att diskutera det med läkaren.\" – Fertilitetsforumet"
                ],
                source: "Endometriosföreningen Sverige, Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "ESHRE Endometriosis Guideline 2022", "Fertil Steril journal"]
        ),

        // MARK: 8 — Ofrivillig barnlöshet
        Article(
            id: "guide_ofrivillig_barnloshet",
            category: .fertility,
            title: "Ofrivillig barnlöshet — att hantera sorgen",
            subtitle: "Psykologiska aspekter och stöd under fertilitetsresan",
            icon: "heart.slash.fill",
            readTimeMinutes: 7,
            intro: "Ofrivillig barnlöshet drabbar ca 10–15 % av alla par i reproduktiv ålder. Det är en sorg som sällan erkänns socialt på samma sätt som andra förluster — ingen begravning, inga kondoleanser — ändå kan det vara lika smärtsamt. Den här artikeln handlar om de psykologiska aspekterna, sorgprocessen och hur man kan hitta stöd.",
            sections: [
                ArticleSection(
                    heading: "Sorgens psykologi",
                    body: "Infertilitetssorg är komplex och cyklisk — varje ny menscykel kan innebära en ny förlust. Det är vanligt att uppleva alla stadier i Kübler-Ross sorgmodell: förnekelse, ilska, förhandling, depression och acceptans — inte linjärt utan om och om om.\n\nKvinnor och män sörjer ofta olika och i olika takt, vilket kan skapa konflikter i relationen. Kvinnan internaliserar ofta sorgen, mannen externaliserar den genom aktivitet eller distansering. Att förstå dessa skillnader minskar risken för missförstånd.\n\nSocialt tryck — \"när ska ni skaffa barn?\" — är extra smärtsamt för par som kämpar med infertilitet. Det är helt acceptabelt att sätta gränser och välja vad man berättar för vem."
                ),
                ArticleSection(
                    heading: "Effekter på parrelationen",
                    body: "Forskning visar att ofrivillig barnlöshet ökar risken för relationskris, men också att par som genomgår IVF rapporterar ökad intimitet och närmande när de stöttar varandra. Processen kan alltså stärka eller slita på relationen beroende på hur paret kommunicerar.\n\nTips för relationen: sätt regelbundna samtal om hur ni mår (inte bara TTC-status), hitta aktiviteter tillsammans som inte handlar om fertilitet, och erkänn att ni kan ha olika behov av att prata om eller distansera sig från situationen.\n\nSexualitet påverkas ofta negativt av TTC — när sex enbart blir ett redskap för graviditet tappar det sin spontanitet. Att medvetet skapa intimitet utanför det fertila fönstret hjälper."
                ),
                ArticleSection(
                    heading: "Stöd och resurser",
                    body: "Psykologhjälp: de flesta fertilitetskliniker erbjuder kuratorkontakt, och psykologstöd specifikt riktat mot infertilitet finns hos privata aktörer. KBT och mindfulness har vetenskapligt stöd för att minska ångest och depression vid infertilitet.\n\nOrganisationer i Sverige: Nätet mot ofrivillig barnlöshet (NMOB) erbjuder forum, stödgrupper och information. RFSU och Riksförbundet för sexuell upplysning har även resurser.\n\nHur länge ska man försöka? Det finns inget universellt svar, men att sätta upp en gemensam plan — \"vi provar X behandlingsrundor, sedan utvärderar vi\" — ger struktur och minskar känslan av att hamna i ett ändlöst limbo. Adoption och fosterhem är alternativa vägar till familjebildning som kan utforskas parallellt."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Stödforum för ofrivillig barnlöshet är viktiga gemenskaper där erfarenheter delas öppet.",
                consensus: "Att söka professionellt stöd tidigt är klokt — det är inte ett tecken på svaghet utan på sunt förnuft.",
                quotes: [
                    "\"Det var när vi slutade hålla det hemligt för familjen och berättade att sorgen lättade lite.\" – NMOB-forum",
                    "\"Terapin hjälpte mig acceptera att vi kanske aldrig skulle bli biologiska föräldrar — och sen blev vi det.\" – Familjeliv",
                    "\"Gå inte ensam med detta. Det finns så många som förstår exakt hur det känns.\" – Babycentrum"
                ],
                source: "NMOB, Familjeliv.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Human Reproduction journal", "RFSU", "Nätet mot ofrivillig barnlöshet"]
        ),

        // MARK: 9 — TTC efter 35
        Article(
            id: "guide_ttc_efter_35",
            category: .fertility,
            title: "TTC efter 35 — risker, råd och realistiska förväntningar",
            subtitle: "Graviditetsplanering i 35-plus-åren",
            icon: "clock.arrow.circlepath",
            readTimeMinutes: 7,
            intro: "Att skaffa barn efter 35 är allt vanligare i Sverige — medelåldern för förstföderskor är idag ca 30 år och en betydande andel föder efter 35. Fertilitet minskar gradvis från 30-årsåldern och mer märkbart efter 35, men de flesta friska kvinnor över 35 lyckas bli gravida. Kunskapen om risker och rimliga förväntningar är viktig för att inte onödigtvis oroa sig — och för att söka hjälp vid rätt tidpunkt.",
            sections: [
                ArticleSection(
                    heading: "Hur fertilitet förändras med åldern",
                    body: "Äggstocksreserven (antalet och kvaliteten på ägg) minskar kontinuerligt från födseln. Omkring 35 accelererar minskningen. AMH-nivåer och antralfollikelräkning (AFC) mäter reserven och kan ge vägledning.\n\nChansen att bli gravid naturligt per cykel är ca 20–25 % vid 25 år, ca 15 % vid 35 år och ca 5 % vid 40 år. Det innebär att det tar längre tid i genomsnitt, men det är inte omöjligt. De flesta friska 35-åriga kvinnor är gravida inom 1–2 år.\n\nÄggkvaliteten — specifikt risken för kromosomavvikelser — ökar med åldern. Vid 35 är risken för Down-syndrom ca 1/350, vid 40 ca 1/100. Prenataldiagnostik (KUB, NIPT, fostervattenprov) erbjuds i Sverige och är viktigt att diskutera."
                ),
                ArticleSection(
                    heading: "Utredning och timing",
                    body: "Vänta inte ett år vid 35+. Socialstyrelsen och NICE rekommenderar att utredning påbörjas efter 6 månaders försök vid ≥35 år. Vid 40+ bör utredning ske ännu snabbare — remiss direkt till gynekolog är rimligt.\n\nBasal utredning inkluderar AMH-test (äggstocksreserv), FSH/östradiol dag 2–3, ultraljud och spermaanalys. Resultaten ger underlag för beslut om att fortsätta naturlig TTC, börja med lättare behandling (letrozol) eller gå direkt till IVF.\n\nBeslutet om att frysa ägg (social egg freezing) är individuellt. I Sverige finns möjligheten men kostnaderna är höga (privat). Bäst utfall vid äggnedfrysning före 37 år."
                ),
                ArticleSection(
                    heading: "Graviditeten efter 35",
                    body: "Mödrar efter 35 kategoriseras som \"äldre förstföderskor\" (advanced maternal age, AMA) medicinskt sett. Risken för graviditetsdiabetes, högt blodtryck, prematuritet och sectio är något förhöjda, men absolut risk är fortfarande låg för friska kvinnor.\n\nExtra kontroller erbjuds på MVC: NIPT (icke-invasiv prenatal testning) erbjuds i Sverige från 2023 i allt fler landsting för att screening för kromosomavvikelser. Diskutera provtagning med din barnmorska.\n\nGoda nyheter: äldre mödrar har statistiskt lägre risk för plötslig spädbarnsdöd (SIDS), ammar längre och rapporterar generellt högre välmående i föräldraskapet jämfört med yngre mödrar."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "TTC-forum för 35+ är aktiva och stöttande gemenskaper i Sverige.",
                consensus: "Sök utredning snabbt och var proaktiv — tid är viktigare än att vänta och se vid 35+.",
                quotes: [
                    "\"Fick veta att mitt AMH var lågt för min ålder och kunde starta IVF direkt. Utan testet hade vi väntat ett år till.\" – Familjeliv",
                    "\"Var 37 när vi försökte. Tre IVF-rundor senare fick vi tvillingar. Det är möjligt.\" – Babycentrum 35+-tråd",
                    "\"Ingen berättade för mig att 6-månadersgränsen gäller vid 35+. Läste det här och gick direkt till läkaren.\" – Fertilitetsforumet"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "NICE fertility guidelines 2023", "Human Reproduction journal"]
        ),

        // MARK: 10 — Fertilitetskost
        Article(
            id: "guide_fertilitetskost",
            category: .fertility,
            title: "Fertilitetskost och livsstilsförändringar",
            subtitle: "Vad forskning säger om kost, motion och fertilitet",
            icon: "fork.knife.circle.fill",
            readTimeMinutes: 6,
            intro: "Kost och livsstil påverkar fertilitet — det är välestablerat i forskningen. Men det innebär inte att man måste följa ett strikt \"fertilitetsprogram\" för att lyckas. Den här artikeln sammanfattar vad som faktiskt har evidens, utan modeord och överdrivna löften.",
            sections: [
                ArticleSection(
                    heading: "Kosten och fertiliteten",
                    body: "Medelhavskost — rik på grönsaker, frukt, baljväxter, fullkorn, fisk och olivolja — har i flera studier associerats med bättre fertilitet, bättre äggkvalitet och bättre IVF-utfall. Det är den kostmodell med starkast evidensstöd.\n\nFolsyra (400 µg/dag) bör tas minst 1 månad före planerad graviditet och under första trimestern för att minska risken för neuralrörsdefekter. D-vitamin (10 µg/dag) rekommenderas i Sverige under hela året.\n\nUndvik: extrem lågkaloridieting (under 1200 kcal/dag stänger av ägglossning), stort alkoholintag (mer än 1–2 standardglas/vecka påverkar fertiliteten negativt), och transfetter (industriellt framtagna, kopplade till anovulation i Nurses Health Study).\n\nKaffeinintag under 200 mg/dag (ca 2 koppar) är säkert. Sockerintag och processad mat har negativa associationer men direkta orsakssamband är svåra att isolera."
                ),
                ArticleSection(
                    heading: "Motion och vikt",
                    body: "BMI under 18,5 eller över 30 är kopplat till sämre fertilitet och sämre IVF-utfall. Normalvikt förbättrar hormonbalansen och ökar chansen för spontan ägglossning.\n\nMåttlig motion (30 min daglig aktivitet) är gynnsam. Extrem konditionsträning (>60 min/dag av hög intensitet) kan störa hypotalamus-hypofys-ovarial-axeln och leda till anovulation — känt som \"female athlete triad\" när det kombineras med energiunderskott och låg benmassa.\n\nStyrketräning i moderat mängd är säkert och bra. Yoga och mindfulness har visat lovande effekter på stressreducering och fertilitet i pilotstudier."
                ),
                ArticleSection(
                    heading: "Kosttillskott — vad funkar?",
                    body: "Utöver folsyra och D-vitamin finns begränsad men lovande evidens för: CoQ10 (koenzym Q10, 200–600 mg/dag) för äggkvalitet och spermier, omega-3-fettsyror, och inositol (speciellt vid PCOS — myo-inositol förbättrar insulinkänslighet och ägglossning).\n\nUndvik höga doser A-vitamin (>3000 µg/dag) som kan vara fosterskadlig vid graviditet. Järn bör bara tas vid konstaterad järnbrist (blodprov).\n\nVar kritisk mot dyrare \"fertilitetspaketet\" — det vetenskapliga underlaget är oftast svagt. Investera hellre i bra basföda och en bra multivitamin specifikt för graviditetsförberedelse (innehåller rätt doser folsyra, D-vitamin, jod)."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Kostrådsforum under TTC innehåller allt från välunderbyggda tips till tveksamma myter.",
                consensus: "Medelhavskost, folsyra och normalvikt är de mest välstödda faktorerna. Skippa dyra wunder-supplement.",
                quotes: [
                    "\"Bytte till medelhavskost, tog CoQ10 och folsyra. Vet inte vad som hjälpte, men jag var gravid på 3 månader.\" – Familjeliv",
                    "\"Inositol var game-changer för mig med PCOS — ägglossning äntligen regelbunden.\" – PCOS Sverige-forum",
                    "\"Sluta röka var det bästa vi gjorde. Svårt men värt det.\" – Babycentrum"
                ],
                source: "Familjeliv.se, PCOS Sverige"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Chavarro et al., Fertility Diet 2007", "ESHRE nutrition guidelines", "Nurses Health Study"]
        )
    ]

    // MARK: Thematic Parenting Guides (20 articles)
    static let thematicGuides: [Article] = [

        // MARK: T1 — Amning från start
        Article(
            id: "guide_amning_start",
            category: .feeding,
            title: "Amning från start",
            subtitle: "Råmjölk, inläggning och att etablera mjölkflöde",
            icon: "drop.fill",
            readTimeMinutes: 8,
            intro: "De första dagarna och veckorna av amning är avgörande för att etablera ett bra mjölkflöde. Råmjölken (kolostrum) som produceras de första dagarna är guldgul, tjock och full av antikroppar — viktigare än man tror trots att volymen är liten. Den här guiden tar dig igenom de första veckorna: råmjölk, mjölkinläggning, amningsteknik och vanliga utmaningar.",
            sections: [
                ArticleSection(
                    heading: "Råmjölk och de första 72 timmarna",
                    body: "Kolostrum (råmjölk) produceras under graviditetens sista trimester och de första 2–4 dagarna efter förlossning. Det är extremt nähringsrikt: högt i protein, IgA-antikroppar (skyddar tarmens slemhinna), vita blodkroppar och tillväxtfaktorer. Volymen är liten — 3–5 ml per matning — men det är precis vad det nyfödda barnets lilla mage behöver.\n\nPåbörja amning inom en timme efter förlossningen om möjligt. Hud-mot-hud-kontakt (\"golden hour\") stimulerar barnets sökreflex och ger de bästa förutsättningarna för ett tidigt amningsetablering. Barnet suger på bröstvårtan, inte bara nippeln — se till att barnet tar ett stort tag med hela areolan.\n\nAmma ofta de första dygnen: minst 8–12 gånger per dygn (dvs. var 2–3 timme) stimulerar prolaktinproduktionen och sätter igång mjölkproduktionen."
                ),
                ArticleSection(
                    heading: "Mjölkinläggning dag 2–5",
                    body: "Runt dag 3–5 sker mjölkinläggningen — övergången från råmjölk till mogen bröstmjölk. Brösten kan bli hårda, spänna och göra ont. Amnia ofta (var 2 timme) är det bästa sättet att lindra. Undvik att pumpa mer än nödvändigt under inläggningen, eftersom det kan skapa överproduktion.\n\nSvullna bröst vid inläggning kan göra det svårt för barnet att gripa rätt. Mjölka ut lite för hand (handuttag) innan varje matning för att mjuka upp areolan och göra det lättare för barnet att ta tag.\n\nSmärta i bröstvårtan de första veckorna är vanligt men ska inte vara uthärdlig. Korrekt sugtag är avgörande — kontakta amningshjälpen, barnmorskan eller en IBCLC-certifierad amningskonsult om smärtan är svår."
                ),
                ArticleSection(
                    heading: "Mjölkflöde och utmaningar",
                    body: "Mjölkproduktionen styrs av tillgång och efterfrågan: ju oftare och effektivare barnet suger, desto mer mjölk produceras. Hoppa inte över matningar de första veckorna.\n\nVanliga utmaningar: platta eller indragna bröstvårtor (amningskonsult kan hjälpa med teknik och nipple shield), mjölkstockning (hård öm klump i bröstet — amnia, massera, värm), och mastit (bröstkörtelnsinfektion med feber och röd hudrodnad — kräver läkarkontakt och eventuellt antibiotika, men amning bör fortsätta).\n\nTilläggsmatning med formel är ibland medicinskt nödvändigt (viktnedgång >10 % av födslovikten, hypoglykemi, svår ikterus) men bör inte ges rutinmässigt. Rådfråga barnmorskan eller BB innan du börjar tillägga."
                ),
                ArticleSection(
                    heading: "Amningsstöd i Sverige",
                    body: "I Sverige finns ett brett stödnätverk: BB-personal under vårdtiden, barnmorskemottagningar, BVC (barnhälsovård), Amningshjälpen (ideell organisation med volontärtelefon och lokala grupper) och IBCLC-certifierade amningskonsulter (mot avgift).\n\nAmning rekommenderas av WHO och Socialstyrelsen som enda mat de 6 första månaderna och gärna fortsatt upp till 2 år vid sidan av annan mat. Det är dock ett personligt beslut — om amning inte fungerar eller inte önskas är modersmjölksersättning ett fullgott alternativ."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Amning är ett av de mest diskuterade ämnena i föräldraforum — med allt från stöd till frustration.",
                consensus: "Professionellt stöd tidigt (amningskonsult, barnmorska) gör stor skillnad. Ingen ska behöva lida ensam.",
                quotes: [
                    "\"Ingen berättade för mig hur ont ett felaktigt sugtag gör. Amningskonsulten räddade min amning på dag 4.\" – Familjeliv",
                    "\"Handuttag av mjölk för att mjuka upp bröstet vid inläggning var det bästa tipset jag fick.\" – Babycentrum",
                    "\"Mastit på vecka 3. Febrigt, fruktansvärt ont — men antibiotika hjälpte och jag ammade i 13 månader till.\" – BVC-forum"
                ],
                source: "Familjeliv.se, Amningshjälpen.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "WHO Breastfeeding guidelines", "Amningshjälpen", "IBCLC-organisationens riktlinjer"]
        ),

        // MARK: T2 — Kolik
        Article(
            id: "guide_kolik",
            category: .health,
            title: "Kolik — orsaker, lindring och vad forskning säger",
            subtitle: "Förstå och hantera spädbarnets intensiva skrikperioder",
            icon: "exclamationmark.bubble.fill",
            readTimeMinutes: 7,
            intro: "Kolik definieras klassiskt som skrik mer än 3 timmar per dag, mer än 3 dagar per vecka, under mer än 3 veckor hos ett i övrigt friskt spädbarn under de tre första månaderna (Wessels kriterium). Det drabbar ca 10–30 % av alla nyfödda och är en av de vanligaste orsakerna till att nyblivna föräldrar kontaktar vård. Orsakerna är fortfarande inte fullt förstådda, men forskningen ger en del svar.",
            sections: [
                ArticleSection(
                    heading: "Vad är kolik?",
                    body: "Kolikskrik kännetecknas av intensivt, ihållande gråt som verkar okontrollerbar och börjar typiskt vid 2–3 veckors ålder, topper runt 6 veckor och försvinner för de flesta vid 3–4 månaders ålder. Barnet drar upp benen, spänner magen och är svår att trösta.\n\nViktig distinktion: kolik är ett uteslutningsdiagnos — det ska inte finnas annan medicinsk orsak till skriket. Saker att utesluta: hunger (är barnet ordentligt mätt?), felaktigt sugtag med luftsväljning, mjölkproteinallergi, sura uppstötningar (GERD), urinvägsinfektion, hårt i magen (förstoppning).\n\nOm barnet har feber, blodig avföring, kräks upprepat, inte ökar i vikt eller om gråten är annorlunda än vanligt — sök läkarvård."
                ),
                ArticleSection(
                    heading: "Orsaker och teorier",
                    body: "Forskning har föreslagit flera teorier: omoget nervsystem och mag-tarmkanal, störd tarmflora (microbiom), gas och tarmkramper, överstimulering och svårighet att varva ner, och psykosociala faktorer (stressad miljö förstärker skriket).\n\nEn spännande ny riktning är tarmmikrobiomet: studier visar att kolikbarn ofta har lägre Lactobacillus reuteri-nivåer. Probiotikatillskott (L. reuteri DSM 17938, Biogaia droppar) har i randomiserade kontrollerade studier visat en signifikant minskning av skrikminuter per dag hos ammade kolikbarn — men effekten är mer osäker för formelmatade barn.\n\nMjölkproteinallergi eller intolerans kan ge kolikliknande symtom och bör övervägas, särskilt om barnet har eksem, blod i avföringen eller familjehistorik av allergi."
                ),
                ArticleSection(
                    heading: "Lindring och strategier",
                    body: "Det finns inget universellt botemedel mot kolik, men följande har vetenskapligt stöd eller bred klinisk acceptans: bärande (bärnos mot magen), rörelse (barnvagn, bil, gungstol), vitt brus, svagling (tight insvepning), ammande mammas dietförändringar (uteslut komjölksprotein, koffein) vid misstänkt mjölkproteinallergi.\n\nUndvik gasdropparna Dimetikon (Minifom) — metaanalyser visar ingen signifikant effekt jämfört med placebo. Däremot har L. reuteri (probiotika) det starkaste evidensstödet för ammade barn.\n\nFör föräldrarna: kolik är extrem utmattning och frustration — det är normalt att känna sig överväldigad, irriterad och ledsen. Tag hjälp av partner, familj eller vänner. Om du inte kan trösta barnet och känner dig farligt frustrerad — lägg ner barnet i sängen och gå till ett annat rum i några minuter. Det är säkrare än att bära ett skrikande barn i desperation."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Kolik-trådar i svenska föräldraforum är bland de mest aktiva — solidaritet och praktiska tips delas flitigt.",
                consensus: "Det går över. De flesta kolikbarn är symptomfria vid 3–4 månader. Håll ut och sök avlastning.",
                quotes: [
                    "\"Vecka 8 var mörkast. Vecka 12 var det som att byta barn — plötsligt log hon. Det går över.\" – Familjeliv",
                    "\"Biogaia-dropparna hjälpte märkbart för oss. Inte mirakel, men tydlig förbättring.\" – Babycentrum",
                    "\"Vitt brus på YouTube, 8 timmar lång. Det enda som fick henne att sova.\" – Instagrammammagrupp"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Savino et al. Pediatrics 2010 (L. reuteri)", "Cochrane review: kolik 2018"]
        ),

        // MARK: T3 — Sömnträning
        Article(
            id: "guide_somntraning",
            category: .sleep,
            title: "Sömnträning — metoder och när det är lämpligt",
            subtitle: "En genomgång av evidensbaserade sömnmetoder",
            icon: "moon.zzz.fill",
            readTimeMinutes: 8,
            intro: "Sömnträning (att lära ett barn att somna och sova utan kontinuerlig föräldrahjälp) är ett av de mest debatterade ämnena inom småbarnsföräldraskap. Det finns flera välstuderade metoder med olika grad av barnets gråt involverat. Forskningen visar att sömnträning inte skadar barn — men timing och föräldrarnas välmående är avgörande.",
            sections: [
                ArticleSection(
                    heading: "Grundläggande om barnsömn",
                    body: "Nyfödda har korta sömnlcykler (50–60 min) och vaknar naturligt mellan cyklerna. Förmågan att somna om själv (\"self-soothing\") utvecklas successivt — de flesta barn är inte biologiskt redo för sömnträning förrän vid 4–6 månaders ålder, när de har en mer mogen dygnsrytm och inte längre behöver nattmål för nutrition.\n\nSömnassociationer är det barnet lär sig koppla ihop med att somna: amning, nappar, skakande, föräldrars närvaro. Om barnet somnar med hjälp av en association behöver det samma hjälp för att somna om vid varje nattuppvaknande.\n\nMål med sömnträning: att barnet lär sig somna IN självständigt vid läggdags, vilket gör att det kan klara av att somna om på nätterna utan föräldrarnas hjälp."
                ),
                ArticleSection(
                    heading: "Metoder — från hårdast till mjukast",
                    body: "Extinction (\"Cry it Out\", CIO, Weissbluth-metoden): barnet läggs vaket i sängen och föräldern lämnar rummet. Inga återvändanden förrän morgonen (med medicinska undantag). Snabbast resultat (ofta 2–3 nätter) men kräver stark föräldranerv och att barnet är ≥6 månader.\n\nFerber-metoden (\"graduated extinction\"): föräldern återvänder med ökande tidsintervall för kort tröst (utan att ta upp barnet) — t.ex. 3 min, 5 min, 10 min. Balanserar effektivitet med lite mer föräldranärvaro. Vanligast använd och väl studerad.\n\nChair-metoden (Sleep Lady Shuffle): föräldern sitter vid sängen, gradvis rör sig mot dörren över 2 veckor. Mer lugnande men långsammare.\n\nPickUp-PutDown (PUPD, Tracy Hogg): plocka upp vid gråt, lägg ner vid lugnande. Tidskrävande och fungerar bäst för yngre barn.\n\nFading (\"no-cry\"): gradvis minska insomninshjälpen, t.ex. amna tills nästan sovande → amna och lägga ner vaken → gradvis kortare närvaro. Tar längst tid men involverar minst gråt."
                ),
                ArticleSection(
                    heading: "Forskning och säkerhet",
                    body: "En viktig meta-analys (Mindell et al. 2006, 2021) visade att beteendemetoder för barnsömn är effektiva och inte skadar barn psykologiskt, varken kortsiktigt eller på lång sikt. En välciterad RCT-studie (Price et al. 2012, Pediatrics) fann inga negativa effekter på barnets stressnivåer, beteende, anknytning eller emotionell hälsa vid 5 och 6 års ålder.\n\nSömnträning är inte lämpligt: före 4–6 månaders ålder, vid medicinsk orsak till nattvaknande (GERD, sjukdom), vid pågående regress (sjukdom, ny händelse i familjen, separation anxiety), eller om föräldrarna inte är eniga om att genomföra det.\n\nVäljer ni att inte sömnträna är det också ett fullgott val — cosleeping (förlängt samsovande) och nattamning är normen i stora delar av världen."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Sömnträning skapar starka åsikter i svenska föräldraforum, men erfarenheterna är övervägande positiva.",
                consensus: "Sömnträning fungerar om familjen är redo och barnet är 5–6 månader+. Det är ett personligt val utan ett universellt rätt svar.",
                quotes: [
                    "\"Vi Ferbrade vid 6 månader. Tre nätter, sen sov han 11 timmar. Jag önskar vi gjort det tidigare.\" – Familjeliv",
                    "\"Vi valde gradvis fading utan gråt. Tog 6 veckor men passade vår familj.\" – Babycentrum",
                    "\"Sömnträning är inte för alla — vi samsover och är lyckliga. Respektera varandras val.\" – Föräldraforum"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Mindell et al. Sleep 2006", "Price et al. Pediatrics 2012", "AAP safe sleep guidelines 2022"]
        ),

        // MARK: T4 — BVC-besök
        Article(
            id: "guide_bvc_besok",
            category: .health,
            title: "BVC-besök — vad händer och hur man förbereder sig",
            subtitle: "Barnhälsovårdens besök från nyfödd till skolstart",
            icon: "stethoscope",
            readTimeMinutes: 6,
            intro: "Barnhälsovården (BVC) erbjuder regelbundna hälsokontroller av alla barn från födseln till skolstart, kostnadsfritt i Sverige. BVC-sjuksköterskan och läkaren följer barnets tillväxt, utveckling och vaccination samt ger stöd till föräldrarna. Att veta vad som händer vid varje besök minskar oron och gör besöken mer givande.",
            sections: [
                ArticleSection(
                    heading: "BVC-programmet — en översikt",
                    body: "Det nationella BVC-programmet inkluderar besök vid: 1–2 veckor, 4–6 veckor, 3 månader, 5 månader, 8 månader, 10 månader, 12 månader, 18 månader, 2,5 år, 4 år och 5 år (inför skolstart). Därtill läkarbedömning vid 4–6 veckor, 8 månader och 4 år.\n\nVid varje besök mäts längd, vikt och huvudomfång som plottas på tillväxtkurvor. Stagnation i tillväxt (crossing percentile curves) kräver vidare bedömning. Motorisk, språklig, social och kognitiv utveckling bedöms via strukturerade observationer och föräldraintervjuer."
                ),
                ArticleSection(
                    heading: "Viktiga milstolpebesök",
                    body: "4–6 veckors besök: läkare undersöker höfter (Ortolani/Barlow-test för höftluxation), ögon (röd reflexreflex), hjärta (blåsljud), testiklar (pojkar) och neurologisk status. Föräldrars välmående och stödbehov diskuteras — amning, sömn, oro.\n\n8-månaders besök: barnläkare gör en bred neurologisk och sensorisk bedömning. Syn och hörsel bedöms. Separation anxiety börjar synas. Introduktion av tilläggskost stäms av.\n\n18-månaders besök: MCHAT-screeningformulär för autism fylls i och diskuteras. Språkutveckling bedöms noggrant. AUDIT-frågor om alkohol och stressymtom hos föräldrar.\n\n4-årsbesök: Åldersadekvat syn- och hörseltest. Finmotorik, grovmotorik, språk och social förmåga bedöms grundligt. Skolberedskap diskuteras."
                ),
                ArticleSection(
                    heading: "Att förbereda sig",
                    body: "Ta med: BVC-boken (röda boken), eventuella frågor du antecknat, barnets föda/napp/leksak för tröst.\n\nVara ärlig om hur ni mår som föräldrar. BVC-sjuksköterskan och läkaren är vana vid att höra om sömnbrist, oro, relationsstress och amningssvårigheter — de är inte där för att döma utan för att hjälpa.\n\nOm du är orolig för barnets utveckling mellan besöken — ring din BVC direkt. Tidiga insatser vid försenad språk- eller motorikutveckling ger bäst resultat. Vänta inte till nästa planerade besök om du är bekymrad."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar erfarenheter av BVC-besök flitigt online, ofta med frågor om vad som är normalt.",
                consensus: "BVC är en enorm resurs — utnyttja den fullt ut och var öppen med era frågor och funderingar.",
                quotes: [
                    "\"Vår BVC-sköterska är guld. Alltid tid för att svara på frågor, aldrig dömande.\" – Familjeliv",
                    "\"Jag visste inte att man kan ringa BVC bara för att ställa en fråga. Ring alltid!\" – Babycentrum",
                    "\"4-årsbesöket var mer ingående än jag trott. Bra att veta i förväg.\" – Föräldraportalforum"
                ],
                source: "Familjeliv.se, BVC-rikshandboken"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Rikshandboken i barnhälsovård"]
        ),

        // MARK: T5 — Förlossning
        Article(
            id: "guide_forlossning_faser",
            category: .pregnancy,
            title: "Förlossning — vad som händer i kroppen",
            subtitle: "Förlossningens tre faser förklarade",
            icon: "figure.2.and.child.holdinghands",
            readTimeMinutes: 9,
            intro: "Förlossningen delas in i tre stadier: öppningsskedet, utdrivningsskedet och efterbördsskedet. Att förstå vad som fysiologiskt händer i varje fas minskar ofta rädslan och hjälper dig att hantera smärta och fatta beslut. Den här guiden ger en medicinsk men tillgänglig beskrivning av förlossningsprocessen.",
            sections: [
                ArticleSection(
                    heading: "Öppningsskedet — latent och aktiv fas",
                    body: "Öppningsskedet är det längsta stadiet och delas i latent fas (0–5 cm öppnad) och aktiv fas (5–10 cm). Under latent fas, som kan pågå 6–12 timmar (upp till 20 h för förstföderskor), värker värkarna oregelbundet och glesas ut. Du ska kunna prata mellan värkarna. Bli hemma och vila, drick vatten, äta lätt, ta ett bad eller promenera.\n\nRing förlossningen vid: vatten­avgang, blödning, försämrade fosterrörelser, värkfrekvens ≤3–4 minuters intervall, eller om du inte känner dig trygg hemma.\n\nAktiv fas börjar vid 5–6 cm öppning. Värkarna är intensiva, regelbundna och ca 45–60 sekunder långa. Smärtlindring erbjuds: lustgas (kvävgas+syre, lindrar lätt-måttlig smärta), epidural (mest effektiv, block av nervledning, ges av anestesiolog), spinalbedövning, sterilt vatten (injektioner i korsryggen vid ryggsmärta), och badkar/shower."
                ),
                ArticleSection(
                    heading: "Utdrivningsskedet — krysta och föda",
                    body: "När livmoderhalsen är fullt öppnad (10 cm) börjar utdrivningsskedet. Barnet rör sig nedåt i förlossningskanalen och du får aktiva krystningskänslor (en oundviklig, stark tryckningskänsla). Barnmorskan guidar krystningen — följ hennes instruktioner om du ska krysta aktivt eller låta det gå av sig självt (passiv utdrivning).\n\nUtdrivningsskedet varar i genomsnitt 20–50 minuter (förstföderskor kan ta längre). Perineum (mellangårdet) töjs och kan spricka — barnmorskan masserar och stödjer för att minimera bristningar. Episiotomi (ett kirurgiskt snitt) görs idag mer sällan och bara vid medicinsk indikation.\n\nFostrets huvud kröns (\"croningen\") och föds. Kroppen följer snabbt. Kontakt hud mot hud prioriteras direkt efter födseln."
                ),
                ArticleSection(
                    heading: "Efterbördsskedet och de första timmarna",
                    body: "Moderkakan föds vanligtvis 5–30 minuter efter barnet. Oxytocin ges ofta som injektion (aktiv handläggning) för att minska blödningsrisken. Livmodern kontraherar och moderkakan lossnar.\n\nBristningar eller episiotomi sys under dessa minuter, vanligtvis med lokalbedövning. Grad 1 (ytlig) och grad 2 (muskelskikt) är vanligast — grad 3–4 (till ändtarm/anus) kräver specialistbedömning och kirurgi.\n\nDe första 1–2 timmarna är \"golden hour\": hud-mot-hud, amningsstart, navelsträngsklippning (gärna försenad, 1–3 min, ger barnet extra blod och järn). Apgar-poäng registreras vid 1, 5 och 10 minuter."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Förlossningsberättelser är populärt innehåll i föräldraforum — varje berättelse är unik.",
                consensus: "Att vara förberedd på att processen tar tid, och att ändra sina förväntningar, underlättar upplevelsen.",
                quotes: [
                    "\"Jag trodde att epidural var 'ge upp'. Det var det absolut inte — det gav mig kraft att orka resten.\" – Familjeliv",
                    "\"Latent fas hemma i 14 timmar. Ingen berättade att det kunde ta så lång tid. Kryssa in det i planen.\" – Babycentrum",
                    "\"Hud-mot-hud direkt är ovärderligt — kämp för det om du kan.\" – Förlossningsforum"
                ],
                source: "Familjeliv.se, 1177.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "SFOG (Svensk förening för obstetrik och gynekologi)", "WHO intrapartum care guidelines 2018"]
        ),

        // MARK: T6 — Postpartum
        Article(
            id: "guide_postpartum_veckor",
            category: .parentHealth,
            title: "Postpartum — de första veckorna hemma",
            subtitle: "Kroppslig läkning, babyblues och att hitta fotfästet",
            icon: "house.and.flag.fill",
            readTimeMinutes: 7,
            intro: "De första veckorna hemma med ett nyfött barn är en radikal övergång. Kroppen återhämtar sig efter förlossningen, sömnbristen slår till, hormonnivåerna rusar och roller förändras. Den här guiden ger en realistisk bild av vad som är normalt — fysiskt och psykiskt — och när man bör söka hjälp.",
            sections: [
                ArticleSection(
                    heading: "Kroppen efter förlossning",
                    body: "Livmodern involveras (krymper tillbaka) under 6 veckor och kan ge sammandragningssmärtor (\"eftervärkar\"), särskilt under amning. NSAID-preparat (ibuprofen) lindrar effektivt och är säkert under amning i rekommenderade doser.\n\nLochier (livmoderslems-flöde) pågår 4–6 veckor. Börjar som röd blödning, övergår till rosa/brun och slutligen gul-vit. Om du plötsligt blöder mer, får feber eller obehaglig lukt — kontakta barnmorskan.\n\nPerineumsmärta (efter bristningar eller episiotomi) kan lindras med is, smärtstillande och sits-bad. Undvik konstipation (drick vatten, ät fiberrikt, mild laxermedel vid behov). Hemorojder är vanliga efter vaginal förlossning.\n\nEfter kejsarsnitt: rörelser begränsade de första 2 veckorna, kör inte bil 6 veckor, lyft inget tyngre än barnet. Snittet läker 6–8 veckor."
                ),
                ArticleSection(
                    heading: "Babyblues och postpartumdepression",
                    body: "Babyblues (gråtattacker, humörsvängningar, oro) är normalt och drabbar 50–80 % av nyblivna mammor under de första 1–2 veckorna, drivet av hormonfall (östrogen, progesteron rasar efter förlossning). Babyblues försvinner av sig självt och kräver inget behandling utöver stöd och vila.\n\nPostpartumdepression (PPD) är mer allvarligt och drabbar ca 10–15 % av nyblivna mammor (och ca 10 % av nyblivna pappor). Symtom: ihållande nedstämdhet (>2 veckor), känsla av otillräcklighet, svårt att binda an till barnet, sömnproblem utöver det vanliga, ångest, tankeproblem. EDPS-screening (Edinburgh Postnatal Depression Scale) görs rutinmässigt på BVC och MVC.\n\nSök hjälp direkt om du har tankar på att skada dig eller barnet — det är ett medicinskt nödläge. PPD behandlas effektivt med KBT och/eller SSRI-preparat. Du är inte en dålig förälder för att du mår dåligt."
                ),
                ArticleSection(
                    heading: "Praktiska råd för de första veckorna",
                    body: "Sov när barnet sover — det är ett kliché men också ett medicinskt råd. Sömnbrist av den här graden påverkar immunförsvar, mental hälsa och smärta. Ta emot hjälp med tvätt, matlagning och handling.\n\nInfrastruktur första veckorna: ha basmat hemma (pasta, ris, bönor, frysta grönsaker), ta emot matleverans, acceptera att huset är rörigt. \"Du behöver inte städa, du behöver vila.\"\n\nSexliv: vänta tills blödning upphört och eventuella bristningar läkt (vanligtvis minst 6 veckor). Många väntar längre — det är helt normalt. Kommunikation med partnern om behov och gränser är avgörande."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "De första veckorna hemma är ett intensivt diskussionsämne i svenska föräldraforum.",
                consensus: "Ta emot hjälp. Inga hjälteinsatser. Sömnbrist är ett akut medicinskt tillstånd, inte ett bevis på styrka.",
                quotes: [
                    "\"Jag grät varje dag i två veckor och trodde att jag var trasig. Det var babyblues. Det gick över.\" – Familjeliv",
                    "\"PPD diagnostiserades för sent för mig. Om du mår dåligt LÄNGRE ÄN 2 veckor — sök hjälp direkt.\" – Babycentrum",
                    "\"Bästa rådet vi fick: låt svärföräldrarna komma och ta hand om huset medan ni sover.\" – Forum nyfödd"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Edinburgh PPD Scale (EPDS)", "SFOG postpartumriktlinjer"]
        ),

        // MARK: T7 — Parrelationen efter baby
        Article(
            id: "guide_parrelation_efter_baby",
            category: .parentHealth,
            title: "Parrelationen efter baby",
            subtitle: "Vad som händer och hur man navigerar",
            icon: "figure.2.arms.open",
            readTimeMinutes: 7,
            intro: "Forskning visar att upp till 70 % av par rapporterar minskad relationskvalitet under det första året efter att ha fått barn. Det beror inte på att de inte älskar varandra — det beror på sömnbrist, rolломförändring, minskad intimitet och att man plötsligt är medföräldrar mer än partners. Den här guiden ger konkreta strategier för att vårda relationen.",
            sections: [
                ArticleSection(
                    heading: "Vad forskning säger",
                    body: "Gottmans longitudinella studier visar att 67 % av par rapporterar signifikant nedgång i relationsbelåtenhet det första året efter barnets birth. Men par som behåller vänskap, positiv kommunikation och delar på omsorgsansvar klarar sig märkbart bättre.\n\nVanliga stressorer: asymmetri i omsorgsarbete (fortfarande vanligast att mammor tar mer ansvar), minskad sexuell intimitet (biologisk, hormonell och praktisk), otydlig kommunikation om förväntningar och behov, identitetsskifte (\"vem är jag utöver förälder?\"), och ekonomisk stress (föräldraledighet påverkar ekonomin)."
                ),
                ArticleSection(
                    heading: "Kommunikation och konflikthantering",
                    body: "Gottmans \"4 ryttare\" — kritik (\"du gör alltid...\"), förakt, defensivitet och stängning — förutspår relationskollaps. Byt till mjukare start: \"Jag mår dåligt av X och behöver Y\" istället för att attackera personligheten.\n\nHa regelbundna check-ins: kort daglig samtalsrutin om hur ni mår, inte bara barnlogistik. Planera för parlediga stunder — även 30 minuter ensamma per vecka har dokumenterad positiv effekt.\n\nJämlik fördelning av nattjour och omsorgsansvar är inte bara rättvisa — det förhindrar bitterness och burnout hos den som tar mest ansvar."
                ),
                ArticleSection(
                    heading: "Intimitet och sexualitet",
                    body: "Minskad sexlust efter förlossning är normalt och driven av: prolaktin (amning sänker östrogen och libido), sömnbrist, kroppsbild, rädsla för smärta (efter bristningar) och att man är \"tuchad out\" av att vara fysisk nära barnet hela dagen.\n\nKommunikation är nyckeln: var ärlig om var du befinner dig utan att avfärda partnerns behov. Intimitet behöver inte vara sex — kramar, kyssar och hudkontakt håller bandet levande.\n\nOm sex är smärtsamt: vestibulit och torrhet (låga östrogennivåer vid amning) behandlas med östrogenkräm lokalt (säkert vid amning) och eventuellt sexologisk rådgivning."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Parrelationsproblem efter barn är ett tabubelagt men viktigt diskussionsämne.",
                consensus: "Det är normalt att relationen knarrar. Att investera i den — även med en trött hjärna — lönar sig.",
                quotes: [
                    "\"Vi gick i parterapi när dottern var 6 månader. Det bästa vi gjort. Vänta inte tills det är kris.\" – Familjeliv",
                    "\"Jag insåg att vi pratade om barnet 100 % av kvällen. Vi bestämde att ett ämne per kväll fick handla om oss.\" – Babycentrum",
                    "\"Sömnbristens effekt på humör och empati underskattas totalt. Det är det som skapar konflikterna.\" – Parrelationsforum"
                ],
                source: "Familjeliv.se, Gottman Institute"
            ),
            sources: ["1177.se", "Gottman J. The Seven Principles for Making Marriage Work", "Socialstyrelsen föräldraskapsstöd"]
        ),

        // MARK: T8 — VAB
        Article(
            id: "guide_vab_regler",
            category: .parentHealth,
            title: "VAB — regler, ersättning och praktiska tips",
            subtitle: "Tillfällig föräldrapenning när barnet är sjukt",
            icon: "cross.case.fill",
            readTimeMinutes: 5,
            intro: "VAB (vård av sjukt barn) ger föräldrar rätt att stanna hemma med ett sjukt barn och få ersättning från Försäkringskassan. Reglerna kan verka krångliga, men är i grunden enkla. Den här guiden reder ut vad som gäller 2024.",
            sections: [
                ArticleSection(
                    heading: "Grundläggande regler",
                    body: "Du har rätt till tillfällig föräldrapenning (TFP) om: barnet är under 12 år (16 år vid funktionsnedsättning), du normalt arbetar, och du behöver avstå arbete för att vårda barnet eller följa med till läkare/BVC.\n\nErsättning: 80 % av sjukpenninggrundande inkomst (SGI) per dag, upp till taket (2024: ca 1 117 kr/dag). Ingen karensdag — ersättning från dag 1. Anmäl till Försäkringskassan via Mina sidor senast 7 dagar efter att perioden börjat.\n\nDu behöver INTE läkarintyg för VAB-period. Läkarintyg krävs bara om FK efterfrågar det vid längre perioder (mer än 7 dagar) eller om de gör kontroll."
                ),
                ArticleSection(
                    heading: "Vem kan VABba?",
                    body: "Båda föräldrarna kan VABba, oavsett om de är gifta, sambos eller separerade. Adoptivföräldrar och i vissa fall mor/farföräldrar eller annan närstående kan ta ut TFP om föräldrarna inte kan.\n\nVid delad vårdnad: den förälder som har barnet när det är sjukt VABbar. Om ni vill dela på VAB-dagarna kan ni rotera, men båda kan inte ta betald TFP för samma barn samma dag.\n\nOm barnet är sjukt mer än 60 dagar per år: då kan FK begära läkarintyg. Det är viktigt att vara konsekvent i sin anmälan för att inte riskera återkrav."
                ),
                ArticleSection(
                    heading: "Praktiska tips",
                    body: "Anmäl direkt i appen — Försäkringskassans app är smidig och anmälan tar 2 minuter. Välj rätt barn, rätt period.\n\nTänk på SGI: om du är föräldraledig och inte arbetar finns ingen aktiv SGI. Se till att anmäla dig som arbetssökande hos AF eller ta deltidsjobb för att behålla en aktiv SGI för VAB.\n\nVAB och semester: du kan avbryta semester för att VABba om barnet insjuknar under semesterperioden. Anmäl omedelbart och spara semester-dagarna till senare.\n\nRestidsersättning: om barnet är inlagt på sjukhus kan du ha rätt till resersättning och VAB-ersättning för att besöka barnet."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "VAB-frågor är vanliga i föräldraforum, ofta kring reglerna och hur man anmäler korrekt.",
                consensus: "Anmäl alltid digitalt och i tid. Försäkringskassans app är enkel att använda.",
                quotes: [
                    "\"Visste inte att man kan VABba för att följa med till BVC-besök. Superbra!\" – Familjeliv",
                    "\"Vi turas om att VABba för att båda ska ha kvar bra SGI på sikt.\" – Babycentrum",
                    "\"FK ringer ibland och frågar om sjukdomen. Var ärlig — det är inga konstiga frågor.\" – Forum föräldrar"
                ],
                source: "Familjeliv.se, Försäkringskassan.se"
            ),
            sources: ["1177.se", "Försäkringskassan.se", "Socialstyrelsen"]
        ),

        // MARK: T9 — Övergångsmaten
        Article(
            id: "guide_overgangsmaten",
            category: .feeding,
            title: "Övergångsmaten — när börja och hur introducera",
            subtitle: "Fast föda, allergi-protokollet och babymat",
            icon: "carrot.fill",
            readTimeMinutes: 8,
            intro: "Övergångsmaten — introduktionen av fast föda parallellt med bröstmjölk eller ersättning — är en viktig milstolpe. Socialstyrelsen rekommenderar att börja runt 6 månader, men individuell mognad varierar. Den här guiden täcker när och hur man börjar, hur man undviker vanliga misstag och hur man hanterar allergier.",
            sections: [
                ArticleSection(
                    heading: "Tecken på mognad och startpunkten",
                    body: "Tecken på att barnet är redo: sitter stabilt med stöd, har förlorat tungreflexen (stöter inte automatiskt ut mat med tungan), visar intresse för mat vid matbordet. Åldersmässigt gäller runt 6 månader (aldrig före 4 månader).\n\nBörja med grönsaker (potatis, morötter, palsternacka, broccoli), rotfrukter och välling (fullkornsvälling med järn). Frukter är välgodtagna men börja inte med dem — barnet kan bli kräsen. Späd puréerna gradvis grövre för att vänja barnet vid textur.\n\nBabyledd avvänjning (BLW, Baby-Led Weaning) är ett alternativ till puréer: barnet matar sig självt med mjuka bitar mat. Evidensen är likvärd med traditionell puréintroduktion. BLW kräver noggrant urval av textur och storlek för att undvika kvävningsrisk."
                ),
                ArticleSection(
                    heading: "Allergi-protokollet — tidig introduktion",
                    body: "LEAP-studien (Learning Early About Peanut Allergy, 2015) revolutionerade synen på allergiintroduktion: tidig introduktion av allergena livsmedel MINSKAR risken för allergi. Nuvarande råd (Socialstyrelsen, ESPGHAN): introducera alla allergena livsmedel (jordnötter, ägg, vete, mjölk, nötter, fisk, skaldjur, sesam) vid 6 månaders ålder, ett åt gången.\n\nInfört i liten mängd, ett nytt livsmedel var 3:e dag, observera i 15–30 minuter efter. Om ingen reaktion: fortsätt ge regelbundet (1–2 ggr/vecka) för att bibehålla toleransen.\n\nOm barnet har svår eksem eller redan känd äggallergi: diskutera med barnläkare/allergolog INNAN jordnötsintroduktion — de kan ha nytta av hudpricktest eller provokation under medicinsk övervakning."
                ),
                ArticleSection(
                    heading: "Mat att undvika under det första året",
                    body: "Undvik under första levnadsåret: honung (risk för Clostridium botulinum hos spädbarn), salt och sockersalt mat (njurarna klarar inte stor saltmängd), hel mjölk som dryck (kan ges i mat men inte som ersättning för bröstmjölk/ersättning), hårdkokta ägg och nötter i hel form (kvävningsrisk), samt nitratrika grönsaker (spenat, rödbetor, rädisor) i stora mängder under 6 månaders ålder.\n\nJärn är viktigt — fullkornsvälling med järntillsats och rött kött/fisk säkerställer järnbehovet. Järnbrist vid 9–12 månader är annars vanligt, särskilt hos ammade barn.\n\nVattendryck kan introduceras gradvis från 6 månader men behövs inte i stora mängder under det första levnadsåret."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Övergångsmatsintroduktionen väcker många frågor och lite ångest i föräldraforum.",
                consensus: "Börja runt 6 månader, introducera allergener tidigt och en i taget, lita på barnets signaler.",
                quotes: [
                    "\"BLW passade oss perfekt — barnet åt vad vi åt och vi slapp laga extra.\" – Familjeliv",
                    "\"Jordnötssmörsintroduktion enligt LEAP-protokollet. Nervöst men inga reaktioner. Nu äter han jordnötter varje dag.\" – Babycentrum",
                    "\"Ingen berättade för mig att starta med grönsaker. Startade med frukter — barnet vill nu knappt äta grönsaker. Lärdomar.\" – Matintroduktionsforum"
                ],
                source: "Familjeliv.se, Livsmedelsverket.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Livsmedelsverket", "LEAP Study NEJM 2015", "ESPGHAN complementary feeding guidelines 2017"]
        ),

        // MARK: T10 — Separation anxiety
        Article(
            id: "guide_separation_anxiety",
            category: .development,
            title: "Separation anxiety — vad det är och hur man hanterar det",
            subtitle: "Normal separationsångest och strategier för föräldrar",
            icon: "person.fill.questionmark",
            readTimeMinutes: 6,
            intro: "Separation anxiety (separationsångest) är ett normalt och förväntat utvecklingssteg. Barnet inser att du existerar även när du inte syns, och reagerar med protest och oro när du lämnar. Det är ett tecken på hälsosam anknytning — inte på att barnet är skämt bort eller beroende. Den här guiden förklarar vad som händer och hur man navigerar som förälder.",
            sections: [
                ArticleSection(
                    heading: "Vad som händer neurologiskt",
                    body: "Separation anxiety uppträder vanligtvis vid 6–8 månaders ålder (när objektpermanens — förståelsen att saker existerar utom synhåll — utvecklas), topper vid 10–18 månader och minskar gradvis under 2–3 år.\n\nBarnet gråter intensivt när föräldern lämnar men lugnar sig ofta snabbt efter att föräldern gått. Vardagsfenomenet kräver ingen behandling. Det är biologiskt programmerat — ett spädbarn bör inte vara okej med att den primära anknytningsfiguren försvinner.\n\nStarka separationsreaktioner vid inskolning i förskola (vanligtvis 1–2 år) är normala. En inskolningsperiod på 1–2 veckor med gradvis ökande tid är standard i Sverige."
                ),
                ArticleSection(
                    heading: "Strategier som fungerar",
                    body: "Förutsägbarhet och rutiner minskar oro: barnet lär sig snabbt att du återvänder. Konsistenta avskedshälsningar (\"Mamma går nu men kommer tillbaka efter lunchen\") ger kontroll. Smyg aldrig iväg — det förvärrar ångesten.\n\nKort och tydlig farewell-ritual: kram, ett lugnt farväl, gå. Dröj inte kvar för att trösta ett gråtande barn — det förlänger ångesten för båda. Dagispers bekräftar att barnet lugnar sig snabbt efter föräldrarnas bortgång.\n\nPeek-a-boo-lekar (tittut) är pedagogiska — de lär barnet på ett lekfullt sätt att saker försvinner och återkommer. Övningsseparationer i säkra, korta doser (lämna rummet i 30 sekunder, återkom) stärker tilltron till att du kommer tillbaka."
                ),
                ArticleSection(
                    heading: "När ska man oroa sig?",
                    body: "Separation anxiety som kvarstår intensivt efter 4–5 år, hindrar barnets funktionsnivå (vägrar leka ensam, kan inte gå till förskola alls), eller är kopplat till annan oro (extrem rädsla, sömnproblem, magont) kan kräva bedömning av BVC-läkare eller barnpsykolog.\n\nSkillnad mot normal separationsångest: patologisk separationsångest är intensivare, längre varaktig och mer funktionshämmande. Den diagnostiseras som Separation Anxiety Disorder i DSM-5 och behandlas med KBT.\n\nFöräldrar som känner extrem skuld vid separation — det är normalt men ska inte styra barnets beteende. Barn behöver lära sig att separationer är säkra och reversibla."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Separation anxiety vid inskolning är ett av de vanligaste diskussionsämnena för föräldrar med ett-till-tvååringar.",
                consensus: "Korta, tydliga avsked är bättre än långa utdragna farväl. Barnet lugnar sig nästan alltid snabbt.",
                quotes: [
                    "\"Jag stod och grät utanför dagisdörren. Personalen sa att dottern log igen inom 5 minuter. Tro dem.\" – Familjeliv",
                    "\"Tittut varje dag hemma, i månader. Sedan gick inskolningen som en dans.\" – Babycentrum",
                    "\"Aldrig smyg ut — det är det värsta du kan göra. Säg alltid hejdå, alltid.\" – Förskoleforumet"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Bowlby J. Attachment Theory", "DSM-5 separation anxiety disorder criteria"]
        )
        ,

        // MARK: T11 — Tandsprickning
        Article(
            id: "guide_tandsprickning",
            category: .health,
            title: "Tandsprickning — tecken, lindring och tandvård",
            subtitle: "Från de första tänderna till tandläkarbesöket",
            icon: "mouth.fill",
            readTimeMinutes: 5,
            intro: "De flesta barn får sina första tänder mellan 5 och 10 månaders ålder, men det är normalt att börja redan vid 3 månader eller vänta till 12–14 månader. Tandsprickning kan ge besvär — men vad forskningen säger om symtom skiljer sig ibland från vad föräldrar upplever. Den här guiden reder ut fakta från myt.",
            sections: [
                ArticleSection(
                    heading: "Tecken på tandsprickning",
                    body: "Vanliga tecken: ökad salivering (drooling), bitbehov (barnet gnager på allt), rodnad i kinderna, irritabilitet och störd sömn dagarna kring att tanden bryter igenom.\n\nVad forskning visar: en stor systematisk genomgång (Cochrane) finner att feber (>38°C), diarré och hosta INTE är bevisade symtom på tandsprickning. Om barnet har feber bör annan orsak uteslutas — ring 1177 om osäker.\n\nTandsprickningstabellen: undre mittentänder (6–10 mån), övre mittentänder (8–12 mån), laterala incisiver (9–13 mån), första mjölkmolarer (13–19 mån), hörntänder (16–22 mån), andra mjölkmolarer (25–33 mån). Variation är stor och normal."
                ),
                ArticleSection(
                    heading: "Lindring",
                    body: "Kylbara bittleksaker (inte frysta — för hårda och kan skada tandköttet), gnaga på ett kallt fuktigt textil, att massera tandköttet med ett rent finger, eller Paracetamol vid uttalad smärta och sömnstörning.\n\nUndvik tandsprickningsgeler med lidokain/benzokain (Bonjela) till barn under 2 år — FDA och Läkemedelsverket varnar för methemoglobinemi (sällsynt men allvarlig biverkning). Homeopatiska medel och bärnstenshalsband saknar dokumenterad effekt."
                ),
                ArticleSection(
                    heading: "Tandvård och tandläkarbesök",
                    body: "Börja borsta tänderna så snart den första tanden syns — med en mjuk barnborste och en korn fluortandkräm (1000–1450 ppm) kvällsvis. Fluorid är det enskilt viktigaste skyddet mot karies.\n\nFörsta tandläkarbesöket: Folktandvården erbjuder gratis tandvård till alla barn upp till 23 år. Första besöket sker vanligtvis vid 1–2 års ålder, men kontakta tandläkare direkt om du ser missfärgning, gropar eller frakturer.\n\nNappbruk och flaskmatning på natten ökar kariesrisken (\"nappkaries\", \"flaskkaries\") — undvik nappning och nattflaska med mjölk eller juice efter att tänderna kommit."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Föräldrar delar flitigt erfarenheter kring tandsprickning och vilka lindringmetoder som fungerar.",
                consensus: "Kylbara bittleksaker och fingermassage är de mest effektiva lättillgängliga metoderna. Undvik benzokain-geler.",
                quotes: [
                    "\"Fryst tvättlapp — enkelt, billigt, det enda som hjälpte.\" – Familjeliv",
                    "\"Vår dotter fick ALLA symtom inkl. feber och lös mage. Läkaren sa att det inte är bevisat men jag såg det med egna ögon.\" – Babycentrum",
                    "\"Kom ihåg att börja borsta! Vi glömde och fick karies vid 18 månader.\" – BVC-forum"
                ],
                source: "Familjeliv.se, Folktandvården"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Folktandvården", "Cochrane review tandsprickning 2016"]
        ),

        // MARK: T12 — Feberbedömning
        Article(
            id: "guide_feber_bedomning",
            category: .health,
            title: "Feberbedömning — när är feber allvarlig?",
            subtitle: "Vad du ska göra och när du ska söka vård",
            icon: "thermometer.high",
            readTimeMinutes: 6,
            intro: "Feber (rektal temperatur ≥38°C) är ett av de vanligaste symtomen hos småbarn och en av de vanligaste orsakerna till att föräldrar kontaktar sjukvård. Feber är inte en sjukdom — det är ett immunförsvarssvar. Men hos nyfödda och små spädbarn kan feber vara tecken på allvarlig infektion. Den här guiden hjälper dig bedöma när du ska söka vård.",
            sections: [
                ArticleSection(
                    heading: "Åldersanpassad bedömning",
                    body: "Under 3 månader: ALL feber ≥38°C kräver omedelbar läkarkontakt (akutmottagning). Spädbarn under 3 månader saknar mogen immunförmåga och kan ha allvarliga infektioner (sepsis, meningit) utan tydliga symtom utöver feber.\n\n3–6 månader: Kontakta 1177 eller läkare vid feber ≥38°C. Barn i denna ålder kan snabbt bli sämre.\n\n6 månader och äldre: Bedöm barnets allmäntillstånd. Hur mår barnet när febern går ner med febernedsättande? Leker det, dricker det, är det kontaktbart? Om ja — observera hemma. Om allmäntillståndet är nedsatt trots febernedsättande — sök vård."
                ),
                ArticleSection(
                    heading: "Varningssymtom — sök vård omedelbart",
                    body: "Ring 112 eller akutmottagning direkt vid: krampanfall (feberkramp), petekier (lila-röda hudblödningar som inte bleknar vid tryck), uttalad andnöd/andningssvårigheter, svårt att väcka/onormalt slött, kraftig nackstyvhet, frossa med ihållande feber ≥40°C trots febernedsättande.\n\nSök akut (men ej 112) vid: feber i mer än 5 dagar, feber som återkommer efter feberfri period, tecken på öroninflammation (kraftigt öronvärk, nyligen föregången ÖLI), hög feber (≥39,5°C) utan tydlig orsak hos vaccineradt barn."
                ),
                ArticleSection(
                    heading: "Febernedsättande — när och hur",
                    body: "Febernedsättande är indicerat när barnet har OBEHAG av febern, inte för att siffran på termometern är hög. Paracetamol (Alvedon, Panodil) är förstahandsval, doserat efter vikt (15 mg/kg per dos, max var 6:e timme). Ibuprofen (Ipren, Nurofen) kan ges från 3 månaders ålder och 5 kg — effektivare vid höga febrar, håller längre (6–8 tim).\n\nAlternera inte rutinmässigt (det rekommenderas inte längre) — välj ett preparat och ge det vid behov. Aspirin (acetylsalicylsyra) är kontraindicerat hos barn under 16 år (risk för Reyes syndrom).\n\nTätmätning och dokumentation hjälper vid kontakt med sjukvård — notera: temperatur, tidpunkt, eventuella läkemedel, barnets allmäntillstånd."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Feber hos barn skapar stor oro och många samtal till 1177 — och i föräldraforum.",
                consensus: "Bedöm barnets allmäntillstånd, inte bara termometersiffran. Tveka inte att ringa 1177.",
                quotes: [
                    "\"Under 3 månader = ALLTID ring. Lärde mig det på svårt sätt.\" – Familjeliv",
                    "\"Feberkramp är skrämmande men sällan farligt. Viktigt att veta vad man ska göra.\" – Babycentrum",
                    "\"1177 är fantastiska. Ring alltid om du är osäker — de ber dig aldrig komma i onödan.\" – Föräldraforum"
                ],
                source: "Familjeliv.se, 1177.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Barnläkarföreningen", "NICE fever guidance 2019"]
        ),

        // MARK: T13 — Nattväckning
        Article(
            id: "guide_nattvackning",
            category: .sleep,
            title: "Nattväckning — normalt vs. störande, strategier",
            subtitle: "När är nattvaknanden ett problem och vad man kan göra",
            icon: "moon.stars.fill",
            readTimeMinutes: 7,
            intro: "Nattväckning är en av de vanligaste anledningarna till att föräldrar söker råd och hjälp. Vad som är normalt varierar dramatiskt med barnets ålder, och förväntningarna som omger barnsömn i Sverige är ibland orealistiska. Den här guiden ger en evidensbaserad bild av normal barnsömn och när nattväckning bör adresseras aktivt.",
            sections: [
                ArticleSection(
                    heading: "Normal barnsömn — ålder för ålder",
                    body: "0–3 månader: 14–17 timmars sömn totalt, uppdelade i korta 2–4 timmarsperioder dygnet runt. Nattmål varannan timme är normalt. Dygnsrytmen (cirkadisk rytm) är inte etablerad.\n\n4–6 månader: 12–16 timmar, dygnsrytmen utvecklas. Många barn konsoliderar sömnen men det är NORMALT att vakna 1–3 ggr per natt. Biologiskt behov av nattmål kvarstår för de flesta.\n\n6–12 månader: 12–15 timmar. Medicinskt nutritionsbehov av nattmål minskar för de flesta (ett friskt barn som äter tillräckligt på dagarna klarar utan nattmål). Socialt/sömnassosiationsbehov kvarstår. 1–2 uppvaknanden är normalt.\n\n1–3 år: 11–14 timmar. Sömnregressioner vid 8–10 mån, 12 mån, 18 mån och 2 år är normala och tillfälliga. Separationsångest bidrar till nattvaknanden."
                ),
                ArticleSection(
                    heading: "Sömnhygien och miljö",
                    body: "Säker sömnmiljö (SSM): på rygg, i eget säkert sovutrymme (spjälsäng, resbädd), fast madrass utan lösa föremål, svalt rum (16–20°C), mörkt. Cosleeping (samsovande) sker i Sverige men kräver noggrannhet kring säkerhetsriktlinjer (undvik alkohol, rökning, mjuka ytor).\n\nSömnhygienåtgärder: konsekvent läggdagsrutin (bad, bok, sång, lägg ner vaken), konstant läggdagstid (±30 min), tillräckliga dagtuppar (undersöversömn kvällen → sämre nattsömn), mörkt och svalt rum, vitt brus vid behov.\n\nLägg ner barnet VAKET vid insomningstillfället — detta är den viktigaste sömnhygienåtgärden för att barnet ska utveckla förmågan att somna om självständigt."
                ),
                ArticleSection(
                    heading: "Strategier vid störande nattvaknanden",
                    body: "Bedöm: är barnet under 4–5 månader eller i akut sjukdomsregress? → Inte rätt tid för sömnträning, normala nattvaknanden.\n\nÄr barnet 5–6 månader+ och vaknar 4–6 ggr per natt? → Sömnträning kan vara aktuellt (se separat guide om sömnträning).\n\nAmmade barn vaknar statistiskt mer på natten — ett aktivt val. Nattavvänjning (gradvis minska nattmål) kan ske från 6–9 månader om barnet äter tillräckligt på dagen.\n\nFör föräldrar: sömnbrist är ett hälsoproblem. Att turas om nattjour, låta en partner ta ett nattpass medan den andra sover ostört 5–6 timmar, gör stor skillnad för funktionsförmågan."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Nattvaknanden är nummer ett i sömnrelaterade diskussioner i svenska föräldraforum.",
                consensus: "Realistiska förväntningar reducerar lidandet. Det mesta är normalt och går över.",
                quotes: [
                    "\"Mitt barn vaknade 8 ggr en natt vid 7 månader. Sedan köpte vi blackout-gardiner och lade ner vaket — 2 vaknanden nästa natt.\" – Familjeliv",
                    "\"Nattavvänjning vid 8 månader — tre nätter, sedan sov han igenom. Inget gråt, bara tröst utan bröst.\" – Babycentrum",
                    "\"Turordning på nätterna räddade mitt äktenskap och min sanity.\" – Sömnforum"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "NSF (National Sleep Foundation) pediatric guidelines", "AAP safe sleep 2022"]
        ),

        // MARK: T14 — Barnvacciner FAQ
        Article(
            id: "guide_barnvacciner_faq",
            category: .health,
            title: "Barnvacciner FAQ — varför, säkerhet och bieffekter",
            subtitle: "Vetenskaplig genomgång av det svenska vaccinationsprogrammet",
            icon: "syringe.fill",
            readTimeMinutes: 7,
            intro: "Det svenska barnvaccinationsprogrammet är ett av världens mest genomarbetade folkhälsoinstrument. Vaccinationer har utrotat smittkoppor globalt, nästan eliminerat polio och dramatiskt minskat sjuklighet och dödlighet i barnsjukdomar. Den här guiden svarar på de vanligaste frågorna.",
            sections: [
                ArticleSection(
                    heading: "Det svenska vaccinationsprogrammet",
                    body: "Barn i Sverige erbjuds kostnadsfritt: DTaP-IPV-Hib-HepB (difteri, tetanus, kikhosta, polio, Hib, hepatit B) vid 3, 5, 12 månader, MPR (mässling, påssjuka, röda hund) vid 18 månader och 5 år, pneumokocker (PCV) vid 3, 5 och 12 månader, HPV (humant papillomvirus) i årskurs 5–6, och influensavaccin till riskgrupper.\n\nVaccinationstäckning i Sverige är ca 95–97 % för flerbarnsvacciner — tillräckligt för flockimmunitet mot de flesta sjukdomar men närheten till gränsen gör oss sårbara vid lokala utbrott."
                ),
                ArticleSection(
                    heading: "Säkerhet och biverkningar",
                    body: "Vanliga biverkningar: rodnad/svullnad vid injektionsstället, lätt feber, irritabilitet, sömnighet — uppkommer timmar efter vaccination och försvinner inom 1–3 dagar. Ge gärna Paracetamol vid uttalad feberrеaktion.\n\nSällsynta men kända: feberkramp (ca 1/3000 vid MPR-vaccin, ofarlig), allergisk reaktion (1/1 000 000 doser — kliniken har utrustning för behandling).\n\nOgrundad rädsla: Wakefield-studien (1998) som påstod koppling mellan MPR och autism var bedrägeri, publicerades av Lancet som drog tillbaka den, och Wakefield förlorade sin läkarlicens. Dussintals stora oberoende studier med miljontals barn har bekräftat: inget samband mellan vacciner och autism.\n\nAluminium som adjuvans i vacciner är säkert i de mängder som ges — barnet utsätts för mer aluminium via bröstmjölk och mat."
                ),
                ArticleSection(
                    heading: "Vanliga frågor",
                    body: "\"Kan mitt barn få för många vacciner?\" Nej — immunsystemet hanterar dagligen tusentals antigener; de 10–20 i ett vaccin är en minimal belastning. Kombinationsvacciner (sexvalenta) minskar antalet injektioner utan att kompromissa effekten.\n\n\"Ska jag vaccinera trots att barnet har förkylning?\" Mild förkylning utan feber är inte ett hinder. Vänta vid feber (≥38°C) eller tydlig sjukdomskänsla.\n\n\"Vad händer om jag väljer bort vaccination?\" Barnet riskerar allvarliga sjukdomar och bidrar till sänkt flockimmunitet, vilket kan drabba immunsvaga barn som inte kan vaccineras. Det är ett beslut med konsekvenser bortom den egna familjen."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Vaccinationsdiskussioner är känsliga men viktiga — misinformation är utbredd.",
                consensus: "Vetenskapen är entydig: vaccinationsprogrammet är säkert och effektivt. Följ rekommendationerna.",
                quotes: [
                    "\"Jag var tveksam tills jag läste originalstudien som widerlade Wakefield. Sen vaccinerade vi direkt.\" – Familjeliv",
                    "\"Min son hade feberkramp efter MPR. Skrämmande men ofarligt, sa läkaren. Han är nu frisk och vaccinerad mot mässling.\" – Babycentrum",
                    "\"Vacciner är ett av de bästa folkhälsoinstrumenten vi har. Det är inte ett beslut jag tog lätt men fakta är fakta.\" – Forum vetenskap och hälsa"
                ],
                source: "Familjeliv.se, Folkhälsomyndigheten"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Folkhälsomyndigheten", "WHO vaccine safety", "Lancet retraction Wakefield 2010"]
        ),

        // MARK: T15 — Allergier hos barn
        Article(
            id: "guide_allergier_barn",
            category: .health,
            title: "Allergier hos barn — symtom, testning och hantering",
            subtitle: "Vanligaste allergier hos spädbarn och småbarn",
            icon: "allergens",
            readTimeMinutes: 7,
            intro: "Allergier hos barn ökar i Sverige och i hela västvärlden. De vanligaste hos små barn är mjölkproteinallergi, äggallergi, nötallergi och eksem/atopisk dermatit. Att skilja allergi från intolerans och normala reaktioner är viktigt för att undvika onödiga elimineringsdieter.",
            sections: [
                ArticleSection(
                    heading: "Vanligaste allergier och symtom",
                    body: "Mjölkproteinallergi (CMPA) drabbar ca 2–3 % av spädbarn och ger symtom som eksem, kolik, blod i avföringen, kräkningar, nässelutslag och i svårare fall andningssvårigheter. Diagnos via eliminations-/provokationsdiet med moderkaka (amma mamma eliminerar mjölk) eller hypoallergen ersättning (HA-ersättning, aminosyrabaserad vid svår allergi).\n\nÄggallergi: ca 1,5–2 % av barn, symtom vid kontakt eller intag. Ofta utväxt vid 5–7 år. Influensavaccin kan innehålla spår av äggprotein — diskutera med läkare vid känd äggallergi.\n\nJordnöts- och trädnötsallergi: vanligtvis livslång och kan orsaka anafylaxi. Epipen (adrenalinpenna) ordineras vid diagnos.\n\nAtopisk dermatit (eksem): drabbar 15–20 % av barn, kronisk hudsjukdom med kliande eksem. Ofta kopplat till allergi men kan förekomma utan matallergier."
                ),
                ArticleSection(
                    heading: "Utredning och testning",
                    body: "Pricktest (SPT) utförs av allergolog och mäter IgE-medierad reaktion mot specifika allergener. Specifikt IgE i blod (RAST/ImmunoCAP) ger liknande information. Tester bekräftar sensibilisering men korrelerar inte alltid med klinisk symtom — provokation är guldstandard.\n\nEliminationsdiagnos: misstänkt matallergien vid amning behandlas med att ammande mamma undviker allergenet i 2–4 veckor, med tydlig förbättring som diagnostiskt kriterium.\n\nRemiss till barnallergolog: vid anafylaksi, svår CMPA med svikt, multipla allergier eller dålig effekt av hembehandling."
                ),
                ArticleSection(
                    heading: "Hantering och framtidsutsikter",
                    body: "Undvikande är fortfarande basen i behandling. Barn med mjölkproteinallergi och äggallergi växer vanligtvis ur allergin vid 3–7 år. Jordnöts- och trädnötsallergier är mer sällan utväxta.\n\nOral immunoterapi (OIT) för jordnötsallergi är tillgänglig i Sverige på specialistkliniker och kan minska risken för svåra reaktioner vid oavsiktlig exponering.\n\nAtopisk march: eksem i spädbarn ökar risken för astma och allergisk rinit i skolåldern. Profylaktisk daglig fuktkräm (emollient) på spädbarn med eksem kan minska risken för sensibilisering. Steroidsalva för aktiva eksemfläckar är säkert vid korrekt användning."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Allergiforum för barn är aktiva och erbjuder stöd och praktiska råd.",
                consensus: "Tidig utredning och rätt diagnos undviker onödig eliminationsdietet och ger adekvat behandling.",
                quotes: [
                    "\"Vår son hade blod i avföringen vid 6 veckors ålder. Mjölkeliminering löste allt inom en vecka.\" – Familjeliv",
                    "\"Pricktest vid 12 månader visade äggallergi — vi introducerade titta på bok om ägg istället. Humor hjälper.\" – Babycentrum",
                    "\"Allergologen var fantastisk. Gå dit med konkret matdagbok — det hjälper diagnosen enormt.\" – Allergiförbundet-forum"
                ],
                source: "Familjeliv.se, Astma- och Allergiförbundet"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Astma- och Allergiförbundet", "ESPGHAN CMPA guidelines 2012", "LEAP Study NEJM 2015"]
        ),

        // MARK: T16 — Magkramper och gaser
        Article(
            id: "guide_magkramper_gaser",
            category: .health,
            title: "Magkramper och gaser hos nyfödda",
            subtitle: "Orsaker, lindring och när det är normalt",
            icon: "figure.infant",
            readTimeMinutes: 5,
            intro: "Nyfödda har ett omoget mag-tarmsystem som producerar mycket gas, vilket kan ge smärta och gråt. Gaser och magkramper är en av de vanligaste orosorsakerna hos föräldrar under de första månaderna. Den här guiden förklarar vad som händer, vad som hjälper och vad som inte hjälper.",
            sections: [
                ArticleSection(
                    heading: "Varför får nyfödda gaser?",
                    body: "Nyfödda sväljer luft vid amning och flaskmatsning. Tarmbakterierna bryter ner kolhydrater och bildar gas. Tarmmotiliteten (rörelsemönstret i tarmarna) är oregelbunden de första månaderna.\n\nVid amning: luftsväljning minimeras med korrekt sugtag (barnet ska täcka hela areolan, inte bara nippeln). Amningsposition påverkar — reclinerat amning (bakåtlutad position, \"laid-back breastfeeding\") minskar luftintag.\n\nVid flaskmatsning: välj nappar med rätt flödeshastighet (för snabbt flöde → mer luftsväljning), håll flaskan i 45 graders vinkel, rapa barnet ofta (var 60–90 ml och efter matningen)."
                ),
                ArticleSection(
                    heading: "Lindring",
                    body: "Rapa: håll barnet upprätt mot axeln, mot buken eller sittande med stöd, massera lätt ryggen. Cykelrörelser: lägg barnet på rygg och rör benen i cykelpedalsrörelse — stimulerar tarmperistaltiken. Magläge under bevakning (aldrig sovande): tryck mot magen lindrar gassmärta och stärker magmuskler.\n\nMagmassage: längs tarmens rörelseriktning (medsols, nedåt på vänster sida) kan hjälpa. Värmeplatta mot magen vid gassmärta kan lindra, men se till att värmen är mild.\n\nDimetikon (Minifom, Infacol): metaanalyser visar ingen signifikant effekt jämfört med placebo. L. reuteri (Biogaia) har bäst evidensstöd vid kolikliknande symtom. Fänkåltete saknar evidensstöd och bör undvikas till spädbarn (risk för elektrolytproblem)."
                ),
                ArticleSection(
                    heading: "Kosttips vid amning",
                    body: "Ammande mammas kost påverkar barnets gaser i begränsad utsträckning för de flesta. Viss forskning pekar på koffein och kor mjölksprotein som möjliga faktorer hos känsliga barn.\n\nElimineringsdieter (undvika vitlök, lök, broccoli, kål etc.) är inte evidensbaserade och bör inte göras rutinmässigt. Om du misstänker en specifik koppling — eliminerA ett ämne i taget och observera noga.\n\nOm barnet har kraftig gråt, verkar ha ont, och ingenting hjälper — kontakta BVC. Uteslut mjölkproteinallergi om symtomen är kraftiga och kombinerads med andra tecken (eksem, blod i avföringen)."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Gaser och magkramper är ett av de allra vanligaste ämnena i nyfödda-forum.",
                consensus: "Rapa, cykelrörelser och magläge (under bevakning) hjälper. Dimetikon-dropparna hjälper oftast inte.",
                quotes: [
                    "\"Cykelpedals-massage varje kväll efter bad — sedan fick vi lugna kvällar. Enkelt och gratis.\" – Familjeliv",
                    "\"Bytte till reclinerat amning och luftsväljningen halverades. Varför berättas inte detta för alla?\" – Babycentrum",
                    "\"Biogaia-droppar från dag 14 — märkbar minskning av skrik och gaser. Kan rekommendera.\" – Nyfödda-forum"
                ],
                source: "Familjeliv.se, Babycentrum.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Savino et al. Pediatrics 2010", "Cochrane infant colic 2018"]
        ),

        // MARK: T17 — Vestibulit
        Article(
            id: "guide_vestibulit_postpartum",
            category: .parentHealth,
            title: "Vestibulit — smärta vid samlag postpartum",
            subtitle: "Orsaker, behandling och att söka rätt hjälp",
            icon: "cross.circle.fill",
            readTimeMinutes: 6,
            intro: "Vestibulit (vulvavestibulit) är ett kroniskt smärttillstånd i slidöppningens ingång (vestibulum) som ger brännande, stickande smärta vid beröring, gynundersökning eller samlag. Det är vanligare postpartum än de flesta tror och är underdiagnostiserat. Du är inte ensam — och det finns behandling.",
            sections: [
                ArticleSection(
                    heading: "Vad är vestibulit och varför uppstår det postpartum?",
                    body: "Vestibulit klassificeras som en form av vulvodyni (kronisk vulvasmärta). Karakteriseras av: punktformad smärta vid beröring av vestibulum (\"Q-tipstest\" positivt), rodnad, och undvikandebeteende.\n\nPostpartum-specifika orsaker: låga östrogennivåer vid amning leder till vaginal atrofi och torrhet (\"genitourinärt syndrom vid amning\"). Bristningar eller episiotomis ärrvävnad kan ge lokal smärta och hyperalgesi. Bäckenbottenmuskler spänns reflexmässigt vid smärtförväntning — en ond cirkel.\n\nVestibulit drabbar upp till 12 % av kvinnor och är vanligare bland förstföderskor och ammande mammor."
                ),
                ArticleSection(
                    heading: "Diagnos och utredning",
                    body: "Diagnosen ställs kliniskt av gynekolog, barnmorska med specialistkompetens, eller vulvaspecialist. Q-tipstest: lätt beröring med Q-tips runt vestibulum vid klockan 4, 6 och 8 — positiv om det ger uttalad smärta och hypersensitivitet.\n\nUteslut: vaginal infektion (candida, bakteriell vaginos), STI, dermatologiska tillstånd (lichen sclerosus). Dessa behandlas först.\n\nEfterlyser du hjälp: beskriv symtomen tydligt för läkaren — smärta vid samlag, vid tamponganvändning, vid gynundersökning. Termen \"vestibulit\" eller \"vulvodyni\" kan behöva nämnas för att styra mot rätt diagnos."
                ),
                ArticleSection(
                    heading: "Behandling",
                    body: "Lokal östrogenbehandling (vagitorie, kräm) är förstahandsval vid amningsrelaterad atrofi — säkert under amning och ger snabb förbättring av vävnadens kvalitet.\n\nFysioterapi (bäckenbotten): specialiserad fysioterapeut arbetar med muskelavspänning, desensibilisering och biofeedback. Mycket effektivt för bäckenbottendysfunktion och smärtstörning.\n\nLokalbedövningsgel (Lidokain 2 %) kvällen innan samlag kan underlätta i akut fas men adresserar inte grundorsaken.\n\nKBT med sexologisk inriktning adresserar undvikandebeteende och smärtkatastrofisering. Kombinationsbehandling (östrogen + fysioterapi + KBT) ger bäst resultat.\n\nSamlag ska aldrig göra ont. Om det gör det — sluta och sök hjälp."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Vestibulit är tabu men diskuteras allt mer öppet i postpartum-forum.",
                consensus: "Sök hjälp tidigt. Diagnosen fördröjs ofta i flera år — det behöver det inte göra.",
                quotes: [
                    "\"Tre år av smärta innan jag fick diagnosen. Östrogenkräm + bäckenbottenfysioterapi och nu har vi ett normalt sexliv igen.\" – Familjeliv",
                    "\"Be specifikt om en gynekolog med vulvaerfarenhet — inte alla känner till tillståndet väl.\" – Vestibulit-forum",
                    "\"Du behöver inte acceptera smärta vid sex. Det är inte normalt och det finns hjälp.\" – Postpartum-forum"
                ],
                source: "Familjeliv.se, RFSU.se"
            ),
            sources: ["1177.se", "Socialstyrelsen", "RFSU", "Bornstein J et al. ISSVD vulvodynia guidelines 2016"]
        ),

        // MARK: T18 — Förlossningsskador
        Article(
            id: "guide_forlossningsskador",
            category: .parentHealth,
            title: "Förlossningsskador — gradering, läkning och rehab",
            subtitle: "Perineala bristningar och återhämtning efter vaginal förlossning",
            icon: "bandage.fill",
            readTimeMinutes: 7,
            intro: "Perineala bristningar vid vaginal förlossning är vanliga — ca 80–85 % av förstföderskor och ca 60 % av omföderskor drabbas av någon form av bristning. De flesta är lindriga och läker bra med rätt vård, men allvarligare bristningar (grad 3–4) kräver specialistvård och strukturerad rehabilitering.",
            sections: [
                ArticleSection(
                    heading: "Graderingssystemet",
                    body: "Grad 1: Enbart hud och ytlig vävnad. Sutureras ofta inte eller med enstaka suturer. Läker utan komplikationer.\n\nGrad 2: Hud och underliggande muskler i mellangårdet (perineum) men ej sfinktern. Sutureras under lokalbedövning. Läktid 3–6 veckor.\n\nGrad 3: Analsfinkterns yttre muskulatur involverad. Grad 3a (< 50 % av sfinkterns tjocklek), 3b (> 50 %), 3c (intern sfinkter också skadad). Kräver kirurgisk suturering av gynekolog/specialist på förlossningssalen.\n\nGrad 4: Hel sfinkter plus rektalslemmhinnan skadad. Allvarligast, kräver omedelbar kirurgi. Risk för fekal inkontinens.\n\nEpisiotomi räknas separat men klassas som grad 2-liknande om den inte sträcker sig till sfinkter."
                ),
                ArticleSection(
                    heading: "Läkning och akutvård",
                    body: "De första dagarna: isomslag 10–20 min flera gånger dagligen minskar svullnad. Paracetamol och ibuprofen (säkert vid amning) för smärtstillande. Undvik förstoppning (drick vatten, ät fiberrikt, laktulos/laxermedel vid behov) — stark pressning belastar suturerna.\n\nHygien: duscha perineum efter varje toalettbesök (handhållen dusch eller bidett). Torka framifrån och bakåt. Lufta såret om möjligt.\n\nSök vård om: ökande smärta, feber, illaluktande flytning, blödning, känsla av att suturerna gett sig — tecken på infektion eller suturdehiscens (suturerna som öppnat sig).\n\nKontrollbesök: boka uppföljning hos barnmorska/gynekolog 6–8 veckor efter förlossning — standardprocedur vid grad 3–4."
                ),
                ArticleSection(
                    heading: "Rehabilitering och bäckenbotten",
                    body: "Bäckenbottenträning (Kegel-övningar) bör påbörjas varsamt inom 24–48 timmar efter förlossning — även vid suturer, försiktigt. Regelbunden träning minskar risk för framfall och inkontinens.\n\nFysioterapeut med specialisering på bäckenbotten: rekommenderas starkt vid grad 2–4, och vid symtom som urin- eller fekal inkontinens, känsla av tyngd i underlivet eller smärta. I Sverige erbjuder många landsting detta via remiss.\n\nÅterföra sexlivet: vid grad 3–4 bör samlag vänta tills fullständig läkning bedömts av specialist — ofta 3–4 månader. Smärta vid återförsök är vanligt; se vestibulit-guiden för hjälp vid lokaliserad smärta."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Förlossningsskador diskuteras mer öppet idag, men stigma kvarstår kring inkontinens och sexuell påverkan.",
                consensus: "Sök rehabilitering aktivt — bäckenbottenfysioterapi bör vara standard efter alla förlossningar.",
                quotes: [
                    "\"Grad 3b bristning. Fyra månader av smärta och inkontinens. Bäckenbottenfysioterapi förändrade allt.\" – Familjeliv",
                    "\"Ingen frågade mig hur jag mådde fysiskt vid 6-veckorskontrollen. Begär en ordentlig undersökning.\" – Postpartum-forum",
                    "\"Det är tabu att prata om läckage, men det drabbar så många. Vi måste normalisera att söka hjälp.\" – Bäckenbottenforum"
                ],
                source: "Familjeliv.se, SFOG riktlinjer"
            ),
            sources: ["1177.se", "Socialstyrelsen", "SFOG (Svensk förening för obstetrik och gynekologi)", "RCOG perineal trauma guidelines 2023"]
        ),

        // MARK: T19 — Pappaledighet
        Article(
            id: "guide_pappaledighet",
            category: .parentHealth,
            title: "Pappaledighet — rätten, fördelarna och hur man planerar",
            subtitle: "Pappors föräldraledighet och barnets välmående",
            icon: "figure.and.child.holdinghands",
            readTimeMinutes: 6,
            intro: "Sverige har ett av världens mest generösa föräldraledighetsystem — 480 dagar per barn att fördela fritt (med 90 reserverade dagar per förälder som inte är överförbara). Trots detta tar pappor ut betydligt färre dagar än mammor. Forskning visar att pappaledighet ger tydliga fördelar för barnet, pappan och parrelationen.",
            sections: [
                ArticleSection(
                    heading: "Regler och dagar 2024",
                    body: "Föräldrapenning: totalt 480 dagar per barn (uppdelade i 390 dagar på sjukpenningnivå, 90 dagar på lägstanivå/grundnivå). 90 dagar är reserverade per förälder (\"pappamånader\") och förfaller om inte den föräldern tar ut dem — de kan inte överföras till den andra föräldern.\n\nTiodagarsregeln: pappan (eller den medförälder som inte fött barnet) har rätt till 10 dagars ledighet med ersättning i samband med barnets ankomst (förlossning eller adoption). Tas ut inom 60 dagar.\n\nFlexibilitet: föräldrapenning kan tas ut till och med barnet fyller 12 år. Kan kombineras med deltidsarbete. Dubbeldagar (båda föräldrarna hemma) är tillåtna 30 dagar per barn."
                ),
                ArticleSection(
                    heading: "Fördelar med pappaledighet",
                    body: "Forskning (bl.a. Institutet för social forskning, SOFI) visar att pappor som tar längre föräldraledighet: utvecklar starkare anknytning till barnet, är mer engagerade föräldrar i skolåldern, har bättre psykisk hälsa, och att deras barn har bättre kognitiv och social utveckling.\n\nFör mamman: jämnare fördelning av omsorgsarbete minskar utmattningsrisken och karriärpausen blir kortare. Ammande mammor som delar föräldraledigheten tenderar att amma längre (paradoxalt — mer avlastning ger mer ork).\n\nFör relationen: gemensam tid med barnet och delat ansvar stärker parrelationen. Pappor som tar längre ledighet rapporterar bättre kommunikation med partnern om barnuppfostran."
                ),
                ArticleSection(
                    heading: "Planering och praktik",
                    body: "Planera tidigt — diskutera fördelning under graviditeten, inte i efterhand. Anmäl till FK via Mina sidor (kan anmälas från graviditetsvecka 22). Arbetsgivaren behöver meddelas minst 2 månader i förväg.\n\nVanliga mönster: \"Papa 4–6 månader\" (pappan tar ledighet när mamman återgår till arbete) ger mest kontinuitet för barnet. Alternativt: dela upp ledigheten med pappan hemma första 3 månader och mamman återgår sedan gradvis.\n\nSGI-skyddet: din sjukpenninggrundande inkomst (SGI) beräknas utifrån inkomst vid föräldraledighetens start. Informera FK om förändringar i inkomst."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Pappaledighet diskuteras alltmer och erfarenheter av längre ledigheter delas öppet.",
                consensus: "Ta ut fler dagar än minimumet — det gynnar hela familjen och är inte \"att offa karriären\".",
                quotes: [
                    "\"6 månader ensam med dottern var det bästa jag gjort. Jag är en bättre pappa, make och människa för det.\" – Familjeliv",
                    "\"Arbetsgivaren ifrågasatte min 6-månaders ledighet. Jag tog den ändå. Inga problem i efterhand.\" – Pappaforum",
                    "\"Forskning är tydlig: pappaledighet ger starkare fadersbindning. Det är inte en fråga om ideologi.\" – Babycentrum"
                ],
                source: "Familjeliv.se, Försäkringskassan.se, SOFI"
            ),
            sources: ["1177.se", "Försäkringskassan.se", "Socialstyrelsen", "SOFI rapport pappaledighet 2020"]
        ),

        // MARK: T20 — Barnets sociala utveckling 0-3 år
        Article(
            id: "guide_social_utveckling_0_3",
            category: .development,
            title: "Barnets sociala utveckling 0–3 år",
            subtitle: "Milstolpar i anknytning, lek och social förmåga",
            icon: "person.2.fill",
            readTimeMinutes: 7,
            intro: "Socialt och emotionellt lärande börjar från födseln — faktiskt redan i livmodern. Under de tre första levnadsåren sker en explosionsartad social och emotionell utveckling som lägger grunden för barnets relationer, självreglering och välmående under hela livet. Den här guiden beskriver vad som händer, när och hur du som förälder kan stödja utvecklingen.",
            sections: [
                ArticleSection(
                    heading: "0–6 månader: anknytning och dialog",
                    body: "Nyfödda föredrar mänskliga ansikten framför alla andra stimuli. Vid 2–3 månader ger barnet socialt leende — ett avgörande steg som bekräftar ömsesidig social igenkänning.\n\nProto-konversation: barn och förälder växlar vokaliseringar och ansiktsuttryck i ett turrytm som påminner om vuxenkonversation. Denna tidiga dialog bygger grunden för språk och social responsivitet.\n\nAnknytning (Bowlby): barnet utvecklar preferens för primär omsorgsperson och protesterar vid separation. Trygg anknytning (secure attachment) — baserad på konsekvent, lyhörd omsorg — korrelerar med bättre social kompetens, lägre ångestnivåer och bättre kognitiv utveckling i skolåldern."
                ),
                ArticleSection(
                    heading: "6–18 månader: intentionalitet och imitering",
                    body: "Vid 6–9 månader: barnet inser att handlingar är intentionella (att du tar en sak med ett syfte). Börjar imitera ansiktsuttryck och gester. Separation anxiety topper (se separat guide).\n\nJoint attention (delad uppmärksamhet) vid 9–12 månader: barnet pekar, tittar på föremål och sedan på dig, och följer din blick — ett kritiskt socialt kompetenstecken. Frånvaro av joint attention är en tidig indikator på atypisk social utveckling (autism spectrum).\n\nSpegelneuroner och social inlärning: barnet lär sig enormt mycket via imitation. \"Serve and return\" — föräldrars responsivitet på barnets initiativ — bygger direkta neurala kopplingar i prefrontal cortex.\n\nVid 12–18 månader: protoimperativa (\"ge mig\") och protodeklarativa (\"titta!\") pekningar uppträder. Socialt drama-spel börjar (\"ta telefonen\", \"mata dockan\")."
                ),
                ArticleSection(
                    heading: "18 månader–3 år: självkänsla och parallell lek",
                    body: "18 månader: barnet känner igen sig i spegel (rouge-test positiv för ca 25 %, mer konsekvent vid 2 år) — ett tecken på självkännedom. Empatiska reaktioner: tröstar gråtande kamrat, delar mat.\n\nParallell lek (18 mån–2,5 år): barn leker bredvid varandra utan direkt interaktion. Det är normalt och viktigt — de observerar och lär. Interaktiv lek med turtagning och regelföljning utvecklas successivt.\n\n\"Terrible twos\" (18–36 månader): intensivt trotsbeteende, frustrationsgråt och viljestyrka är normala tecken på individuation — barnet testar gränser för sin autonomi. Det är inte ett misslyckande i föräldraskap.\n\nSpråk och social kompetens hänger ihop: barn med bättre språk har bättre konfliktshantering och vänskap. Läs högt varje dag — det är den enskilt mest dokumenterade interventionen för språk och social inlärning."
                ),
                ArticleSection(
                    heading: "När att reagera och söka stöd",
                    body: "Tecken att ta på allvar (screening på BVC med MCHAT-R vid 18 månader): inget social leende vid 3 månader, ingen ögonkontakt vid 6 månader, ingen pointing vid 12 månader, ingen 2-ordskombination vid 24 månader, förlust av previously acquired skills (alltid undersökning).\n\nASD (autismspektrumtillstånd) diagnostiseras ofta mellan 2–4 år. Tidig intervention (intensiv beteendeterapi, EIBI) är mest effektiv ju tidigare den sätts in.\n\nBarnets temperament är medfött och ska inte blandas ihop med social kompetens — blyga, introverta barn är inte socialt försenade. De behöver andra strategier och mer tid, inte fler sociala exponeringar på tvång."
                )
            ],
            forumSection: ArticleForumSection(
                intro: "Frågor om social utveckling och autism-oro är vanliga i forum för föräldrar med 1–3-åringar.",
                consensus: "Följ din barnmorskas och BVCs riktlinjer. Tidig oro om autism bör alltid tas på allvar och utredas.",
                quotes: [
                    "\"Min son pekade inte vid 12 månader. BVC tog det på allvar och vi fick tidigt stöd. Ovärderligt.\" – Familjeliv",
                    "\"Terrible twos förklarade som individuation — det förändrade hela mitt förhållningssätt. Plötsligt var det normalt och coolt.\" – Babycentrum",
                    "\"Läs högt. Varje dag. Det är det bästa du kan göra för ditt barns språk och sociala förmåga.\" – Läsrörelsens forum"
                ],
                source: "Familjeliv.se, BVC rikshandboken"
            ),
            sources: ["1177.se", "Socialstyrelsen", "Rikshandboken barnhälsovård", "Bowlby Attachment Theory", "MCHAT-R screening instrument"]
        )
    ]

    static let allGuides: [Article] = fertilityGuides + thematicGuides
}
