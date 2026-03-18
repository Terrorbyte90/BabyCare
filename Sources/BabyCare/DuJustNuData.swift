import SwiftUI

// MARK: - Du Just Nu Data Models

struct DuJustNuContent: Identifiable {
    let id: String
    let ageLabel: String
    let ageMinDays: Int
    let ageMaxDays: Int
    let headline: String
    let introduction: String
    let whatBabyDoes: [String]
    let milestones: [DuJustNuMilestone]
    let tips: [DuJustNuTip]
    let commonChallenges: [DuJustNuChallenge]
    let activities: [DuJustNuActivity]
    let sleepInfo: DuJustNuSleepInfo
    let feedingInfo: String
    let forumSection: DuJustNuForumSection
}

struct DuJustNuMilestone {
    let title: String
    let description: String
    let icon: String
}

struct DuJustNuTip {
    let title: String
    let body: String
    let icon: String
}

struct DuJustNuChallenge {
    let title: String
    let description: String
    let advice: String
}

struct DuJustNuActivity {
    let title: String
    let description: String
    let ageAppropriate: Bool
}

struct DuJustNuSleepInfo {
    let totalHours: String
    let nightSleep: String
    let daySleep: String
    let wakeWindow: String
    let naps: String
}

struct DuJustNuForumSection {
    let intro: String
    let consensus: String
    let quotes: [String]
    let source: String
}

// MARK: - All Periods

extension DuJustNuContent {
    static let allPeriods: [DuJustNuContent] = [

        // MARK: 1. Nyfödd (0–2 veckor)
        DuJustNuContent(
            id: "newborn",
            ageLabel: "Nyfödd",
            ageMinDays: 0,
            ageMaxDays: 14,
            headline: "Välkommen till världen!",
            introduction: """
            Grattis till ert lilla mirakel! De första dagarna med en nyfödd är fyllda av starka känslor – kärlek, förundran och kanske lite nervositet. Det är helt normalt att känna sig överväldigad. Ditt barn har precis lämnat en trygg, varm värld och behöver nu din närhet mer än någonsin.

            Under de första två veckorna anpassar sig bebisen till livet utanför livmodern. Hen sover mycket, äter ofta och vill helst ligga hud mot hud med dig. Ditt barns sinnen är fortfarande outvecklade, men hen känner igen din röst och doft redan från födseln.

            Ta det lugnt och försök att vila när bebisen sover. Det finns ingen anledning att stressa – just nu handlar allt om att lära känna varandra och bygga trygghet. Be om hjälp från partner, familj eller vänner om du behöver det.
            """,
            whatBabyDoes: [
                "Sover 16–20 timmar per dygn i korta pass",
                "Äter var 2–3:e timme, dag som natt",
                "Gripper reflexmässigt om ditt finger",
                "Reagerar på starka ljud genom att rycka till (mororeaktion)",
                "Söker bröstet med huvudet (rotningsreflex)",
                "Kan fokusera blicken på föremål 20–30 cm bort"
            ],
            milestones: [
                DuJustNuMilestone(title: "Hud-mot-hud", description: "Bebisen lugnas av att ligga hud mot hud. Det reglerar kroppsvärme, puls och andning.", icon: "heart.fill"),
                DuJustNuMilestone(title: "Reflexer", description: "Nyfödda har flera medfödda reflexer: gripreflex, sugreflex, mororeaktion och rotningsreflex.", icon: "hand.raised.fill"),
                DuJustNuMilestone(title: "Känner igen din röst", description: "Redan från födseln känner bebisen igen röster hen hörde i magen. Prata och sjung för ditt barn!", icon: "ear.fill"),
                DuJustNuMilestone(title: "Ögonkontakt", description: "Bebisen kan fokusera på ditt ansikte när du är nära (ca 20–30 cm). Håll ögonkontakt vid amning/matning.", icon: "eye.fill")
            ],
            tips: [
                DuJustNuTip(title: "Vila när bebisen vilar", body: "Sömn är guld värd just nu. Lägg dig ner när bebisen sover, även om du inte somnar – vila kroppen.", icon: "bed.double.fill"),
                DuJustNuTip(title: "Hud mot hud ofta", body: "Bär bebisen hud mot hud så mycket som möjligt. Det stärker bandet, hjälper amningen och lugnar bebisen.", icon: "heart.fill"),
                DuJustNuTip(title: "Be om hjälp", body: "Du behöver inte klara allt själv. Låt partnern, mor- eller farföräldrar hjälpa till med matlagning, tvätt och syskon.", icon: "person.2.fill"),
                DuJustNuTip(title: "Navelstumpen", body: "Håll navelstumpen ren och torr. Den ramlar av av sig själv inom 1–3 veckor. Kontakta BVC om den luktar illa eller blir röd.", icon: "cross.case.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Amningsproblem",
                    description: "Amningen kan vara svår i början – det är normalt. Bebisen behöver lära sig att suga och du behöver hitta bra ställningar.",
                    advice: "Kontakta amningsmottagningen eller BVC för stöd. En bra tag är grunden – bred gaping, mycket bröstvårta i munnen. Ge det tid, det brukar bli lättare efter 2–3 veckor."
                ),
                DuJustNuChallenge(
                    title: "Babyblubbel (Baby blues)",
                    description: "Många nyblivna mammor upplever gråtattacker, humörsvängningar och ångest de första dagarna efter förlossningen.",
                    advice: "Baby blues är mycket vanligt och beror på hormonförändringar. Det brukar gå över inom 2 veckor. Om känslorna inte släpper eller förvärras, kontakta din barnmorska – det finns hjälp att få."
                ),
                DuJustNuChallenge(
                    title: "Sömnbrist",
                    description: "Nyfödda har inga dygnsrutiner och vaknar ofta. Det kan vara enormt tröttande för dig som förälder.",
                    advice: "Turas om med partnern om nattliga matningar. Sov när bebisen sover. Sänk kraven på allt annat – städning och matlagning kan vänta."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Hud-mot-hud-stunder", description: "Lägg bebisen på ditt bara bröst och täck med en filt. Prata lugnt eller sjung. Detta är den bästa aktiviteten för en nyfödd.", ageAppropriate: true),
                DuJustNuActivity(title: "Prata och sjung", description: "Berätta vad du gör: 'Nu byter vi blöja, nu ska vi äta.' Bebisen älskar din röst och det stimulerar språkutvecklingen redan nu.", ageAppropriate: true),
                DuJustNuActivity(title: "Ansiktsstudier", description: "Håll ditt ansikte nära bebisens (20–30 cm) och låt hen studera dina ansiktsdrag. Nyfödda är fascinerade av ansikten.", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "16–20 timmar",
                nightSleep: "8–9 timmar (med uppvaknanden)",
                daySleep: "8–9 timmar",
                wakeWindow: "30–60 minuter",
                naps: "Oregelbundet, 4–8 tupplurer"
            ),
            feedingInfo: "Bebisen äter 8–12 gånger per dygn, var 2–3:e timme. Första dagarna kommer råmjölken (kolostrum) som är extremt näringsrik. Mjölken brukar komma in dag 2–5. Ammas eller matas med ersättning efter behov – bebisen visar hunger genom att smacka, suga på händerna och vända huvudet.",
            forumSection: DuJustNuForumSection(
                intro: "Så här beskriver föräldrar i forum den nyfödda tiden:",
                consensus: "De flesta föräldrar beskriver den första tiden som underbar men kaotisk. Många lyfter fram vikten av att sänka kraven och bara vara.",
                quotes: [
                    "\"Jag kunde inte sluta titta på henne. Allt annat blev oviktigt. Men herregud vad trött jag var.\" – Emma, 28",
                    "\"Bästa tipset jag fick var: sov när bebisen sover. Jag skrattade åt det först, men det räddade mig.\" – Johan, 33",
                    "\"Amningen var så mycket svårare än jag trodde. Ring amningshjälpen – de räddade oss!\" – Sara, 31"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 2. 2–4 veckor
        DuJustNuContent(
            id: "2-4-weeks",
            ageLabel: "2–4 veckor",
            ageMinDays: 15,
            ageMaxDays: 28,
            headline: "Ni börjar hitta varandra",
            introduction: """
            Nu har ni haft lite tid att landa hemma och börjar sakta men säkert hitta era rutiner. Bebisen är fortfarande väldigt liten och behöver din närhet konstant, men du kanske börjar märka små förändringar – kanske är bebisen lite mer vaken, kanske börjar hen titta på dig med mer intresse.

            Vid den här åldern börjar många bebisar ha en mer alert vakentid. Hen kanske ligger stilla och studerar lampan i taket eller ditt ansikte. Det är början på att utforska världen, och ditt barn gör det med alla sina sinnen.

            Kroppen efter förlossningen börjar också återhämta sig, men det tar tid. Var snäll mot dig själv och jämför inte med andra. Varje familj hittar sin egen rytm.
            """,
            whatBabyDoes: [
                "Börjar ha lite längre vakna stunder",
                "Tittar mer intensivt på ansikten och kontrastrika mönster",
                "Kan börja le i sömnen (reflexleende)",
                "Rörelserna är fortfarande ryckiga och oregelbundna",
                "Gråter för att kommunicera hunger, trötthet eller obehag",
                "Börjar lyfta huvudet kort stund i bukläge"
            ],
            milestones: [
                DuJustNuMilestone(title: "Vakna stunder", description: "Bebisen har nu perioder av stilla vakenhet där hen observerar omgivningen. Dessa stunder blir längre vecka för vecka.", icon: "eye.fill"),
                DuJustNuMilestone(title: "Huvudkontroll", description: "I bukläge börjar bebisen försöka lyfta huvudet en kort stund. Musklerna i nacken börjar bli starkare.", icon: "figure.stand"),
                DuJustNuMilestone(title: "Bättre fokus", description: "Bebisen kan nu följa ett föremål med blicken en kort bit om det rör sig långsamt framför ansiktet.", icon: "eyes"),
                DuJustNuMilestone(title: "Igenkänning", description: "Bebisen visar tydligare att hen känner igen sina närmaste genom att bli lugnare i er famn.", icon: "person.crop.circle.badge.checkmark")
            ],
            tips: [
                DuJustNuTip(title: "Magtid varje dag", body: "Lägg bebisen på mage en kort stund varje dag (1–5 minuter). Det stärker nacke, rygg och axlar. Var alltid med och titta.", icon: "figure.walk"),
                DuJustNuTip(title: "Följ bebisens signaler", body: "Lär dig bebisens hungersignaler (smackar, suger på händerna) och trötthetssignaler (gnyr, gnuggar ögonen, tittar bort).", icon: "lightbulb.fill"),
                DuJustNuTip(title: "Kom ut på promenad", body: "Frisk luft gör gott för både dig och bebisen. En kort promenad med barnvagnen kan bli er dagliga rutin.", icon: "leaf.fill"),
                DuJustNuTip(title: "Första BVC-besöket", body: "Runt 2 veckor sker första hembesöket eller besöket på BVC. Skriv ner dina frågor i förväg!", icon: "building.2.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Kolik och gråt",
                    description: "Många bebisar börjar gråta mer runt 2–3 veckor. Kvällsgråt är vanligt och kan vara uttryck för överstimulering.",
                    advice: "Försök lugna med vagga, vitt brus, bärsjal eller bilåkning. Kolik brukar ha sin topp runt 6 veckor och avtar runt 3–4 månader. Prata med BVC om gråten är ihållande."
                ),
                DuJustNuChallenge(
                    title: "Bebisen vill bara vara i famnen",
                    description: "Det är biologiskt normalt att bebisen vill vara nära dig hela tiden. Hen är programmerad att söka trygghet.",
                    advice: "Använd bärsjal eller bärsele så du får händerna fria. Du kan inte skämma bort en nyfödd – alla behov ska tillgodoses."
                ),
                DuJustNuChallenge(
                    title: "Ojämn viktuppgång",
                    description: "Bebisar tappar upp till 10% av sin födelsevikt de första dagarna men ska ha återhämtat sig inom 2 veckor.",
                    advice: "BVC följer vikten noga. Om bebisen kissar 6+ blöta blöjor per dag och verkar nöjd efter matning är det oftast bra. Kontakta BVC om du är orolig."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Magtid med stöd", description: "Lägg bebisen på din bröstkorg i bukläge. Prata och sjung medan hen försöker lyfta huvudet. Börja med 1–2 minuter.", ageAppropriate: true),
                DuJustNuActivity(title: "Kontraster", description: "Visa svartvita bilder eller mönster på ca 25 cm avstånd. Nyfödda ser kontraster bäst och fascineras av ränder och cirklar.", ageAppropriate: true),
                DuJustNuActivity(title: "Massage", description: "Massera bebisens armar, ben och mage med mjuka rörelser. Det lindrar gasbesvär och stärker bandet mellan er.", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "15–18 timmar",
                nightSleep: "8–9 timmar (med uppvaknanden)",
                daySleep: "7–9 timmar",
                wakeWindow: "45–75 minuter",
                naps: "4–7 tupplurer, oregelbundet"
            ),
            feedingInfo: "Bebisen äter fortfarande 8–12 gånger per dygn. Amningen börjar nu bli mer etablerad och många upplever att det går smidigare. Bebisen kan ha tillväxtspurter runt 2–3 veckor då hen vill äta oftare. Det är kroppens sätt att öka mjölkproduktionen – mata efter behov.",
            forumSection: DuJustNuForumSection(
                intro: "Så här upplever andra föräldrar vecka 2–4:",
                consensus: "Många föräldrar beskriver en blandning av att börja hitta rutiner och att fortfarande vara i en dimma av sömnbrist.",
                quotes: [
                    "\"Runt vecka 3 kände jag att vi började hitta en rytm. Inte riktigt rutiner, men jag kunde läsa honom bättre.\" – Anna, 30",
                    "\"Bärsjalen var livräddaren! Hon ville bara ligga där, och jag fick händerna fria att göra lite.\" – Marcus, 35",
                    "\"BVC-besöket var så skönt. Att höra att allt var normalt – jag behövde det verkligen.\" – Linda, 27"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 3. 1 månad
        DuJustNuContent(
            id: "1-month",
            ageLabel: "1 månad",
            ageMinDays: 29,
            ageMaxDays: 59,
            headline: "Det första leendet nalkas!",
            introduction: """
            En månad redan! Tiden går fort och långsamt på samma gång. Din bebis börjar nu bli mer social och alert. De vakna stunderna blir längre, och du kanske märker att bebisen tittar på dig med allt större intresse. Snart kommer det magiska första riktiga leendet!

            Vid en månads ålder börjar bebisen utveckla mer kontroll över sina rörelser, även om de fortfarande är ganska spretiga. Hen kanske rör armarna och benen mer medvetet och börjar kunna lyfta huvudet bättre i bukläge.

            Du som förälder börjar också hitta din nya roll. Det är okej att fortfarande känna sig osäker – det gör alla. Lita på din instinkt och kom ihåg att du känner ditt barn bäst.
            """,
            whatBabyDoes: [
                "Börjar le socialt (det första riktiga leendet!)",
                "Följer föremål och ansikten med blicken",
                "Lyfter huvudet kort stund i bukläge",
                "Gör gurgelljud och små läten",
                "Griper fast om saker som läggs i handen (reflexmässigt)",
                "Reagerar på ljud genom att vända huvudet"
            ],
            milestones: [
                DuJustNuMilestone(title: "Socialt leende", description: "Det första riktiga leendet som svar på ditt leende – en milstolpe som smälter hjärtan! Brukar komma runt 4–8 veckor.", icon: "face.smiling.fill"),
                DuJustNuMilestone(title: "Blickföljning", description: "Bebisen kan nu följa ett föremål med blicken i en båge från sida till sida.", icon: "eye.trianglebadge.exclamationmark"),
                DuJustNuMilestone(title: "Huvudlyft i bukläge", description: "I bukläge kan bebisen nu lyfta huvudet 45 grader en kort stund. Nackmusklerna blir starkare!", icon: "arrow.up"),
                DuJustNuMilestone(title: "Ljud och joller", description: "Bebisen börjar experimentera med ljud – gurglande, kurrande och små vokaler som 'a' och 'o'.", icon: "mouth.fill"),
                DuJustNuMilestone(title: "Dag/natt-rytm", description: "Bebisen börjar sakta skilja på dag och natt, även om dygnsrytmen fortfarande är omogen.", icon: "moon.stars.fill")
            ],
            tips: [
                DuJustNuTip(title: "Prata mycket med bebisen", body: "Kommentera allt du gör. Forskning visar att barn som hör många ord utvecklar ett rikare språk. Det spelar ingen roll vad du säger – din röst är det viktigaste.", icon: "text.bubble.fill"),
                DuJustNuTip(title: "Bygg på magtiden", body: "Öka magtiden gradvis till 5–10 minuter, flera gånger om dagen. Lägg spännande leksaker framför bebisen som motivation.", icon: "figure.strengthtraining.traditional"),
                DuJustNuTip(title: "Svara på leendet", body: "När bebisen ler, le tillbaka! Denna turtagning är grunden för all kommunikation och stärker ert band enormt.", icon: "face.smiling.fill"),
                DuJustNuTip(title: "Kvällsrutin", body: "Börja med en enkel kvällsrutin: bad, massage, pyjamas, matning. Det hjälper bebisen att förstå att natten närmar sig.", icon: "moon.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Koliktoppen",
                    description: "Runt 6 veckor brukar koliken nå sin topp. Bebisen kan gråta flera timmar på kvällen, ofta utan synbar anledning.",
                    advice: "Kolik är inte farligt men väldigt påfrestande. Prova de 5 S:en: Swaddle (linda), Side (sida), Shush (susa), Swing (gunga), Suck (sug). Turas om och lämna rummet om du behöver en paus."
                ),
                DuJustNuChallenge(
                    title: "Ensamhet och isolering",
                    description: "Många föräldrar, särskilt den som är hemma, kan känna sig isolerade under småbarnsperioden.",
                    advice: "Gå med i en föräldragrupp via BVC, öppna förskolan eller babysim. Att träffa andra i samma situation gör stor skillnad."
                ),
                DuJustNuChallenge(
                    title: "Tillväxtspurt",
                    description: "Runt 4–6 veckor kommer ofta en tillväxtspurt då bebisen vill äta betydligt oftare och kan vara gnällig.",
                    advice: "Mata efter behov. Spurten varar oftast 2–3 dagar. Kroppen anpassar mjölkproduktionen efter behovet."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Babygym", description: "Häng upp leksaker i en babygym. Bebisen börjar nu nå mot saker med händerna, även om hen inte träffar ännu. Spännande för ögonen!", ageAppropriate: true),
                DuJustNuActivity(title: "Sjung ramsor", description: "Sjung 'Imse Vimse Spindel', 'Bä Bä Vita Lamm' och andra klassiska barnvisor. Bebisen älskar repetition och melodier.", ageAppropriate: true),
                DuJustNuActivity(title: "Spegellek", description: "Håll en spegel framför bebisen. Hen kan inte känna igen sig själv ännu, men fascineras av ansiktet hen ser.", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "14–17 timmar",
                nightSleep: "8–10 timmar (med uppvaknanden)",
                daySleep: "6–8 timmar",
                wakeWindow: "60–90 minuter",
                naps: "4–6 tupplurer"
            ),
            feedingInfo: "Bebisen äter 7–10 gånger per dygn. Många märker att amningen har blivit smidigare och att matningarna går snabbare. Bebisen blir mer effektiv på att suga. Tillväxtspurter runt 4–6 veckor kan innebära att bebisen vill äta oftare några dagar.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar delar med sig om 1-månadersåldern:",
                consensus: "Det första leendet lyfts fram som en magisk stund av nästan alla föräldrar. Koliken nämns som den största utmaningen.",
                quotes: [
                    "\"När hon log mot mig för första gången grät jag. Alla sömnlösa nätter var värda det i det ögonblicket.\" – Karin, 32",
                    "\"Koliken var det värsta jag varit med om. Men det gick över. Håll ut – det blir bättre!\" – Erik, 29",
                    "\"Vi började med BVC:s föräldragrupp och det var det bästa vi gjort. Äntligen vuxna att prata med!\" – Fatima, 34"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 4. 2 månader
        DuJustNuContent(
            id: "2-months",
            ageLabel: "2 månader",
            ageMinDays: 60,
            ageMaxDays: 89,
            headline: "Nu jollrar vi!",
            introduction: """
            Vid två månaders ålder börjar din bebis verkligen vakna till och visa sin personlighet. Leendena kommer allt oftare och du märker tydligare vad bebisen gillar och inte gillar. Många föräldrar upplever att det nu börjar bli riktigt roligt!

            Bebisen jollrar mer och mer – experimenterar med ljud och vokaler. Hen försöker kommunicera med dig och njuter av turtagning. Svara på bebisens joller och se hur hen svarar tillbaka – det är en riktig konversation!

            Det är också dags för de första vaccinationerna. Det kan kännas nervöst, men vaccin skyddar ditt barn mot allvarliga sjukdomar. BVC-sköterskan hjälper dig genom det.
            """,
            whatBabyDoes: [
                "Jollrar aktivt med vokaler ('aaa', 'ooo', 'eee')",
                "Ler socialt och ibland till och med skrattar",
                "Följer föremål med blicken i hela bågar",
                "Lyfter huvudet i bukläge och tittar runt",
                "Sparkar och rör armar och ben mer kontrollerat",
                "Börjar föra händerna till munnen medvetet"
            ],
            milestones: [
                DuJustNuMilestone(title: "Aktivt joller", description: "Bebisen jollrar med vokaler och svarar på ditt prat. Grunderna för språkutvecklingen läggs nu!", icon: "mouth.fill"),
                DuJustNuMilestone(title: "Bättre huvudkontroll", description: "I bukläge kan bebisen nu hålla huvudet uppe längre stunder och titta runt i rummet.", icon: "arrow.up.circle.fill"),
                DuJustNuMilestone(title: "Händer i munnen", description: "Bebisen har upptäckt sina händer och för dem till munnen. Det är en viktig motorisk milstolpe!", icon: "hand.raised.fill"),
                DuJustNuMilestone(title: "Socialt skratt", description: "Vissa bebisar börjar skratta högt nu. Andra behöver lite mer tid – det kommer!", icon: "face.smiling.fill")
            ],
            tips: [
                DuJustNuTip(title: "Turtagning i joller", body: "Vänta på att bebisen gör ett ljud, svara sedan. Vänta igen. Denna turtagning lär bebisen grunderna i kommunikation.", icon: "arrow.left.arrow.right"),
                DuJustNuTip(title: "Vaccination", body: "Vid 3 månader ges den första vaccinationen mot difteri, stelkramp, kikhosta, polio, Hib och pneumokocker. Förbered dig genom att fråga BVC.", icon: "cross.case.fill"),
                DuJustNuTip(title: "Variation i positioner", body: "Låt bebisen vara i olika positioner under dagen: rygg, mage, i famnen, i babysittern. Det stimulerar motoriken.", icon: "arrow.triangle.2.circlepath"),
                DuJustNuTip(title: "Läs högt", body: "Det är aldrig för tidigt att börja läsa högt! Välj böcker med starka kontraster och enkla bilder. Det handlar mer om din röst än om innehållet.", icon: "book.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Sömnregression",
                    description: "Vissa bebisar som börjat sova längre pass kan plötsligt vakna oftare igen. Det är normalt och övergående.",
                    advice: "Håll fast vid rutinerna. Det kan vara en tillväxtspurt eller en neurologisk utvecklingsfas. Det brukar normaliseras inom 1–2 veckor."
                ),
                DuJustNuChallenge(
                    title: "Flat bakhuvud (platthuvud)",
                    description: "Om bebisen alltid ligger med huvudet åt samma håll kan bakhuvudet bli platt.",
                    advice: "Variera vilken sida bebisen tittar åt. Lägg intressanta saker på den sida hen inte föredrar. Magtid hjälper också. Prata med BVC om du är orolig."
                ),
                DuJustNuChallenge(
                    title: "Jämförelse med andra bebisar",
                    description: "Det är lätt att jämföra sitt barn med andras och oroa sig. Alla barn utvecklas i sin egen takt.",
                    advice: "Utvecklingsspannet är brett. Vissa ler tidigt, andra sent. Det spelar ingen roll – fokusera på ditt barns unika utveckling."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Jollersamtal", description: "Sätt dig mitt emot bebisen och ha en 'konversation'. Gör ljud, vänta, och svara på bebisens joller. En fantastisk stund av samspel!", ageAppropriate: true),
                DuJustNuActivity(title: "Rattleting", description: "Skaka en skallra långsamt från sida till sida framför bebisen. Hen tränar ögonkoordination och börjar sträcka sig mot den.", ageAppropriate: true),
                DuJustNuActivity(title: "Cykla med benen", description: "Lägg bebisen på rygg och rör benen i cyklande rörelser. Det hjälper mot gasbesvär och är en rolig lek!", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "14–16 timmar",
                nightSleep: "9–10 timmar (med uppvaknanden)",
                daySleep: "5–7 timmar",
                wakeWindow: "75–105 minuter",
                naps: "4–5 tupplurer"
            ),
            feedingInfo: "Bebisen äter 6–9 gånger per dygn och kan börja ha lite längre pauser mellan matningarna på natten. Många bebisar blir mer effektiva i sin matning och äter snabbare. En del börjar skippa en nattmatning.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 2-månadersåldern:",
                consensus: "Föräldrarna är överens om att det börjar bli riktigt kul nu. Jollret och interaktionen gör att man känner att man får mycket tillbaka.",
                quotes: [
                    "\"Han jollrade 'agoo' och jag smälte. Vi har riktiga samtal nu – han väntar på sin tur!\" – Lisa, 26",
                    "\"Äntligen börjar det likna ett schema. Hon sover lite längre på nätterna och vi mår alla bättre.\" – Henrik, 37",
                    "\"Bästa investering: babygymmet. Han ligger och slår på leksakerna och ser så nöjd ut!\" – Camilla, 30"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 5. 3 månader
        DuJustNuContent(
            id: "3-months",
            ageLabel: "3 månader",
            ageMinDays: 90,
            ageMaxDays: 119,
            headline: "Bebisen upptäcker sina händer!",
            introduction: """
            Tre månader – och vilken utveckling! Din bebis är nu betydligt mer social, alert och nyfiken på omvärlden. En av de stora milstolparna vid den här åldern är att bebisen upptäcker sina egna händer. Du kanske ser hen studera sina fingrar med stor fascination – det är en helt ny värld!

            Bebisen griper nu medvetet efter saker (inte bara reflexmässigt) och för dem till munnen. Allt ska smakprövas! Det är bebisens sätt att utforska – munnen är det känsligaste organet just nu.

            Koliken brukar lätta eller försvinna helt nu, och många föräldrar upplever en lättnad. Bebisen sover kanske lite mer förutsägbart och dagarna får mer struktur.
            """,
            whatBabyDoes: [
                "Griper medvetet efter leksaker och föremål",
                "Studerar sina händer fascinerat",
                "Skrattar högt – ett ljud som gör alla glada",
                "Håller huvudet stadigt i sittande ställning med stöd",
                "Rullar från mage till rygg (eller försöker)",
                "Visar tydliga känslor: glädje, missnöje, förvåning"
            ],
            milestones: [
                DuJustNuMilestone(title: "Medvetet grepp", description: "Bebisen griper nu efter saker medvetet istället för reflexmässigt. Hen kan hålla en skallra en kort stund.", icon: "hand.point.right.fill"),
                DuJustNuMilestone(title: "Skrattar högt", description: "Det fullskaliga skrattet kommer nu – ett av de mest belönande ljuden för en förälder!", icon: "face.smiling.fill"),
                DuJustNuMilestone(title: "God huvudkontroll", description: "Huvudet hålls stabilt när bebisen sitter med stöd. I bukläge kan hen lyfta huvudet och överkroppen med armarna.", icon: "figure.stand"),
                DuJustNuMilestone(title: "Orsak och verkan", description: "Bebisen börjar förstå att hen kan påverka sin omgivning – sparkar jag på leksaken så rör den sig!", icon: "gearshape.2.fill"),
                DuJustNuMilestone(title: "Sträcker sig mot saker", description: "Bebisen sträcker sig aktivt mot intressanta föremål med armarna. Koordinationen förbättras snabbt.", icon: "arrow.right")
            ],
            tips: [
                DuJustNuTip(title: "Olika texturer", body: "Låt bebisen känna på olika material: trä, tyg, gummi, plast. Det stimulerar känseln och nyfikenheten.", icon: "hand.raised.fingers.spread.fill"),
                DuJustNuTip(title: "Spegeltid", body: "Bebisen börjar nu bli riktigt intresserad av sin spegelbild. En säker spegel i lekhörnan är en bra investering.", icon: "rectangle.portrait.fill"),
                DuJustNuTip(title: "Rutin men flexibel", body: "Ha en ungefärlig dagstruktur men var flexibel. Bebisen mår bra av förutsägbarhet, men strikta scheman skapar mest stress.", icon: "clock.fill"),
                DuJustNuTip(title: "Förbered för vaccination", body: "Vid 3 månader får bebisen sin första vaccinationsspruta. Ge gärna paracetamol vid feber efteråt (fråga BVC om dos).", icon: "cross.case.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "4-månadersregressionen (börjar ibland tidigt)",
                    description: "Vissa bebisar börjar sova sämre redan nu, som en föraning om 4-månadersregressionen.",
                    advice: "Håll fast vid goda sömnvanor. En mörk, sval sovmiljö hjälper. Vissa bebisar behöver mer stöd att somna under den här perioden."
                ),
                DuJustNuChallenge(
                    title: "Bebisen vill inte ligga på mage",
                    description: "En del bebisar protesterar mot att ligga på mage. Det är vanligt men magtid är viktigt för motoriken.",
                    advice: "Prova att lägga bebisen på ditt bröst istället, eller använd en amningskudde som stöd. Korta, frekventa stunder är bättre än långa."
                ),
                DuJustNuChallenge(
                    title: "Dregling och allt i munnen",
                    description: "Bebisen dreglar mer och stoppar allt i munnen. Många tror det är tänder, men det är oftast bara en utvecklingsfas.",
                    advice: "Dregling och munmotorisk utforskning är normalt. Ha haklapp för att skydda kläderna. Riktiga tänder kommer oftast inte förrän 4–7 månader."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Griplek", description: "Ge bebisen olika föremål att gripa: skallra, bitring, mjuk boll. Variera storlek, form och textur. Bebisen tränar finmotoriken.", ageAppropriate: true),
                DuJustNuActivity(title: "Flyglekar", description: "Lyft bebisen i luften (stöd nacken!) och 'flyg' runt i rummet. Det stärker kärnmusklerna och ger massor av skratt.", ageAppropriate: true),
                DuJustNuActivity(title: "Titta vad jag gör", description: "Låt bebisen titta på när du gör vardagliga saker. Kommentera allt: 'Nu viker vi tvätten, se vilken röd tröja!' Världen är spännande!", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "14–16 timmar",
                nightSleep: "9–11 timmar (med 1–2 uppvaknanden)",
                daySleep: "4–6 timmar",
                wakeWindow: "90–120 minuter",
                naps: "3–4 tupplurer"
            ),
            feedingInfo: "Bebisen äter 5–8 gånger per dygn. Många bebisar börjar nu ha ett tydligare matschema med längre pauser mellan matningarna. Nattmatningarna kan minska till 1–2. Ersättningsmatade bebisar äter större portioner. Det är fortfarande för tidigt för fast mat.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 3-månadersåldern:",
                consensus: "Tre månader beskrivs ofta som en vändpunkt – koliken är borta, bebisen ler och skrattar, och föräldrarna börjar hitta sin nya normala.",
                quotes: [
                    "\"Koliken försvann som genom ett trollslag! Plötsligt hade vi en glad, nöjd bebis.\" – Oskar, 31",
                    "\"Hon upptäckte sina händer och nu sitter hon bara och stirrar på dem. Som om det vore det mest fantastiska hon sett!\" – Maria, 29",
                    "\"Första gången han skrattade riktigt högt grät vi båda av lycka. Det bästa ljudet i världen.\" – David, 34"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 6. 4 månader
        DuJustNuContent(
            id: "4-months",
            ageLabel: "4 månader",
            ageMinDays: 120,
            ageMaxDays: 149,
            headline: "Lilla utforskaren vaknar!",
            introduction: """
            Fyra månader – och vilken skillnad! Din bebis är nu en liten utforskare som vill se, höra, smaka och ta på allt. Händerna har blivit verktyg och allt som grips hamnar i munnen. Världen är otroligt spännande!

            Vid den här åldern sker stora förändringar i sömnen. Bebisens sömnmönster mognar och börjar likna vuxnas – med tydliga sömnfaser. Det kan leda till den så kallade 4-månadersregressionen där bebisen plötsligt vaknar oftare. Det är en helt normal utvecklingsfas.

            Bebisen börjar också visa större intresse för mat. Hen kanske tittar hungrigt på er mat och sträcker sig efter den. Men rekommendationen är fortfarande att vänta med smakportioner till runt 6 månader.
            """,
            whatBabyDoes: [
                "Griper och undersöker saker med båda händerna",
                "Rullar från mage till rygg (och kanske tillbaka)",
                "Jollrar med konsonanter ('ba', 'ma', 'da')",
                "Visar stort intresse för mat och grejer runtomkring",
                "Känner igen kända ansikten och ler brett mot dem",
                "Stödjer sig på armarna i bukläge och tittar runt"
            ],
            milestones: [
                DuJustNuMilestone(title: "Rullning", description: "Bebisen kan rulla från mage till rygg – en stor motorisk milstolpe! Var nu extra vaksam vid skötbordet.", icon: "arrow.counterclockwise"),
                DuJustNuMilestone(title: "Konsonantjoller", description: "Nu kommer de första konsonantljuden – 'bababa', 'mamama'. Det låter kanske som ord men det är joller!", icon: "mouth.fill"),
                DuJustNuMilestone(title: "Sömnmognad", description: "Bebisens sömnmönster ändras fundamentalt – från nyföddsömn till mer vuxenlik sömn med tydliga faser.", icon: "moon.fill"),
                DuJustNuMilestone(title: "Ögon-hand-koordination", description: "Bebisen kan nu rikta handen mot ett föremål, gripa det och föra det till munnen – en imponerande koordination!", icon: "hand.point.up.left.fill")
            ],
            tips: [
                DuJustNuTip(title: "Säkra hemmet", body: "Bebisen börjar bli mobil. Börja barnsäkra hemmet: flytta farliga saker ur räckhåll, skaffa spislås och hörnskydd.", icon: "lock.shield.fill"),
                DuJustNuTip(title: "Etablera sömnrutiner", body: "Med den nya sömnmognaden är det extra viktigt med en tydlig kvällsrutin. Bad, bok, sång, sömn – varje kväll.", icon: "moon.stars.fill"),
                DuJustNuTip(title: "Leksaker att utforska", body: "Ge bebisen säkra leksaker med olika texturer, ljud och färger. Hen lär sig genom att stoppa saker i munnen.", icon: "teddybear.fill"),
                DuJustNuTip(title: "Golvet är bäst", body: "Låt bebisen ligga på golvet mycket (på en filt). Det ger utrymme att öva rullning och sträcka sig efter saker.", icon: "square.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "4-månadersregressionen",
                    description: "Bebisen som kanske börjat sova bra vaknar plötsligt var 1–2 timme igen. Det beror på att sömnmönstret mognar.",
                    advice: "Det är ingen regression utan en progression – bebisens hjärna utvecklas! Håll fast vid rutinerna, det brukar normaliseras inom 2–4 veckor. Undvik att skapa nya sömnvanor du inte vill ha långsiktigt."
                ),
                DuJustNuChallenge(
                    title: "Distraherad vid matning",
                    description: "Bebisen blir lätt distraherad under matning – tittar runt, slutar äta och vill se vad som händer.",
                    advice: "Mata i en lugn, mörk miljö om det behövs. Det är en fas som visar att bebisen blir mer medveten om sin omgivning. Hen kommer ändå få i sig tillräckligt."
                ),
                DuJustNuChallenge(
                    title: "Allt i munnen",
                    description: "Allt hamnar i munnen – leksaker, dina händer, blöjan, filten. Det kan verka äckligt men det är helt normalt.",
                    advice: "Munnen är det mest känsliga organet – det är så bebisen utforskar. Se till att det som är inom räckhåll är rent och tillräckligt stort att inte kunna sväljas."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Rullningsträning", description: "Lägg en spännande leksak bredvid bebisen i bukläge och locka hen att sträcka sig åt sidan. Det uppmuntrar rullning.", ageAppropriate: true),
                DuJustNuActivity(title: "Tittut!", description: "Den klassiska tittut-leken! Göm ditt ansikte bakom händerna och titta fram med ett 'tittut!'. Bebisen älskar det.", ageAppropriate: true),
                DuJustNuActivity(title: "Vattenlek", description: "Låt bebisen plaska i badkaret eller en balja med vatten (under uppsikt!). Vatten fascinerar och stimulerar alla sinnen.", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "13–15 timmar",
                nightSleep: "10–11 timmar (med 1–3 uppvaknanden)",
                daySleep: "3–5 timmar",
                wakeWindow: "1.5–2.5 timmar",
                naps: "3–4 tupplurer"
            ),
            feedingInfo: "Bebisen äter 5–7 gånger per dygn. Amningen eller flaskmatningen är fortfarande den primära näringsmattan. Vänta med smakportioner till ca 6 månader enligt Livsmedelsverkets rekommendationer. Om bebisen visar stort matintresse – prata med BVC.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 4-månadersåldern:",
                consensus: "4-månadersregressionen dominerar forumtrådarna – men de flesta föräldrar rapporterar att det går över och att bebisen sedan sover bättre än förut.",
                quotes: [
                    "\"4-månadersregressionen var brutal. Vi var zombier i tre veckor. Men det gick över!\" – Lina, 33",
                    "\"Han rullade för första gången och vi jublade som om det var OS. Alltså, man hade aldrig trott att en rullning kunde göra en så glad!\" – Patrik, 28",
                    "\"Tittut-leken funkar varje gång. Oändligt roligt – för henne OCH för oss.\" – Josefin, 31"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 7. 5 månader
        DuJustNuContent(
            id: "5-months",
            ageLabel: "5 månader",
            ageMinDays: 150,
            ageMaxDays: 179,
            headline: "Snart sitter jag själv!",
            introduction: """
            Fem månader – och bebisen blir starkare för varje dag! Många bebisar börjar nu sitta med stöd och en del kan till och med sitta kort stunder utan stöd. Balansen tränas intensivt och bebisen vill gärna stå i knät om du håller i hen.

            Bebisen är nu extremt social och älskar att vara med i allt som händer. Hen skrattar högt, jollrar intensivt och visar tydligt när hen är glad, ledsen eller frustrerad. Du märker att bebisen börjar förstå mer av vad du säger – kanske reagerar hen på sitt eget namn.

            Många föräldrar börjar nu fundera på att introducera smakportioner. Det är en spännande tid – men låt det ta den tid det behöver och följ bebisens signaler.
            """,
            whatBabyDoes: [
                "Sitter med stöd och försöker balansera själv",
                "Griper med hela handen och flyttar saker mellan händerna",
                "Reagerar på sitt namn",
                "Jollrar med långa serier av stavelser",
                "Sträcker armarna mot dig för att bli upplyft",
                "Rullar fritt åt båda hållen"
            ],
            milestones: [
                DuJustNuMilestone(title: "Sitter med stöd", description: "Bebisen kan sitta kort stund med stöd av dina händer eller kuddar runtomkring. Bålmusklerna blir starkare!", icon: "figure.seated.side.air.upper.body.and.arms"),
                DuJustNuMilestone(title: "Överföring hand till hand", description: "Bebisen kan nu flytta föremål från en hand till den andra – en viktig koordinationsförmåga.", icon: "hand.point.left.fill"),
                DuJustNuMilestone(title: "Reagerar på sitt namn", description: "Bebisen börjar reagera när du säger hens namn genom att vända sig om eller titta upp.", icon: "ear.fill"),
                DuJustNuMilestone(title: "Tydlig vilja", description: "Bebisen visar nu tydligt vad hen vill: sträcker sig mot saker, gnäller om något tas bort, skrattar åt det hen gillar.", icon: "star.fill")
            ],
            tips: [
                DuJustNuTip(title: "Stödjande sittande", body: "Sätt bebisen i din famn eller mellan dina ben med kuddar runt. Låt hen öva balans men var beredd att stötta!", icon: "figure.stand"),
                DuJustNuTip(title: "Namnlek", body: "Säg bebisens namn ofta och i olika sammanhang. 'Titta Ella, en hund!' Det hjälper hen att lära sig reagera på sitt namn.", icon: "textformat"),
                DuJustNuTip(title: "Introduktion av smak", body: "Om ni vill börja med smakportioner runt 5–6 månader: börja med moset grönsaker som potatis, morot eller avokado. En smak i taget.", icon: "carrot.fill"),
                DuJustNuTip(title: "Säker miljö på golvet", body: "Bebisen rör sig mer nu. Barnsäkra golvet – inga smådelar, sladdar eller farliga föremål inom räckhåll.", icon: "exclamationmark.triangle.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Frustration över att inte kunna",
                    description: "Bebisen ser saker hen vill ha men kan inte alltid nå dem. Det leder till frustration och gråt.",
                    advice: "Var stöttande utan att genast lösa problemet. Lite frustration driver utveckling. Lägg saker precis inom räckhåll så bebisen kan lyckas."
                ),
                DuJustNuChallenge(
                    title: "Tänder börjar göra sig påminda",
                    description: "Tandköttet kan vara svullet och bebisen kan vara gnälligare. Första tänderna kan komma nu eller om några månader.",
                    advice: "Kylda bitringar lindrar. Massera tandköttet med rent finger. Dropp kan hjälpa vid feber. Prata med BVC om bebisen verkar ha ont."
                ),
                DuJustNuChallenge(
                    title: "Separationsångest börjar",
                    description: "Bebisen kan börja protestera mer när du lämnar rummet. Hen börjar förstå att du finns även när hen inte ser dig.",
                    advice: "Det är ett tecken på trygg anknytning. Säg hejdå kort, le och visa att du kommer tillbaka. Försvinn inte smygande."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Sittbalanslek", description: "Sätt bebisen i sittställning med kuddar runt sig. Placera leksaker framför hen och låt hen sträcka sig. Tränar balans och koordination.", ageAppropriate: true),
                DuJustNuActivity(title: "Bubblor", description: "Blås såpbubblor och låt bebisen följa dem med blicken och försöka fånga dem. Fascinerande och bra för ögon-hand-koordination!", ageAppropriate: true),
                DuJustNuActivity(title: "Utforska naturen", description: "Ta med bebisen ut och låt hen känna på gräs, löv, stenar. Beskriv vad ni ser och känner. Alla sinnen stimuleras!", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "13–15 timmar",
                nightSleep: "10–11 timmar (med 0–2 uppvaknanden)",
                daySleep: "3–4 timmar",
                wakeWindow: "2–2.5 timmar",
                naps: "3 tupplurer"
            ),
            feedingInfo: "Bebisen äter 5–6 gånger per dygn. Vissa börjar nu med smakportioner – tunna puréer av grönsaker eller frukt. Bröstmjölk eller ersättning är fortfarande den huvudsakliga näringskällan. Låt bebisen utforska mat i sin egen takt.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 5-månadersåldern:",
                consensus: "En livlig period med mycket skratt och utforskande. Föräldrarna njuter av den ökade interaktionen.",
                quotes: [
                    "\"Hon sträcker armarna mot mig när hon vill upp. Mitt hjärta brister varje gång!\" – Malin, 30",
                    "\"Vi testade avokado som första smakportion. Han flinade och spottade ut det, men det var ändå roligt!\" – Carl, 32",
                    "\"Bebisen vände sig när jag sa hans namn! Första gången jag kände mig som en riktig förälder.\" – Nour, 27"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 8. 6 månader
        DuJustNuContent(
            id: "6-months",
            ageLabel: "6 månader",
            ageMinDays: 180,
            ageMaxDays: 209,
            headline: "Halvvägs till ett år – och maten kommer!",
            introduction: """
            Sex månader – halvårsdagen! Det här är en stor milstolpe på flera sätt. Bebisen börjar nu äta fast mat, sitter allt mer stabilt utan stöd och kommunicerar med hela kroppen. Det är en intensiv och spännande tid!

            Matintroduktionen är ett äventyr. Bebisen ska smaka allt möjligt de kommande månaderna – från puréer till fingermått. Ta det i lugn takt, introducera en ny smak i taget och låt bebisen utforska maten med alla sinnen. Det kommer bli kladdigt och kul!

            Bebisen börjar också förstå mer av vad du säger. Hen kanske reagerar på ord som 'nej', 'mamma' och 'pappa' även om hen inte kan säga dem själv ännu. Jollret blir mer varierat och melodiskt.
            """,
            whatBabyDoes: [
                "Sitter utan stöd kortare stunder",
                "Äter sina första smakportioner",
                "Jollrar med varierade stavelser ('bababada')",
                "Sträcker sig efter saker utom räckhåll och kan bli frustrerad",
                "Börjar förstå enkla ord och gester",
                "Kan börja krypa eller åla sig framåt"
            ],
            milestones: [
                DuJustNuMilestone(title: "Sitter utan stöd", description: "Bebisen kan sitta själv korta stunder! Balansen förbättras snabbt men hen kan fortfarande tippa – ha kuddar runt.", icon: "figure.stand"),
                DuJustNuMilestone(title: "Fast mat", description: "Nu är det dags att börja med smakportioner! Grönsaker, frukt, gröt – en helt ny värld öppnar sig.", icon: "fork.knife"),
                DuJustNuMilestone(title: "Pincettgrepp på gång", description: "Bebisen börjar öva på att plocka upp småsaker med tumme och pekfinger istället för hela handen.", icon: "hand.pinch"),
                DuJustNuMilestone(title: "Objektpermanens", description: "Bebisen börjar förstå att saker finns kvar även om hen inte ser dem. Därför blir tittut-leken nu extra rolig!", icon: "eye.slash.fill"),
                DuJustNuMilestone(title: "Framåtrörelse", description: "Många bebisar börjar nu röra sig framåt – krypande, ålande eller rullande. En del hittar helt egna tekniker!", icon: "figure.walk")
            ],
            tips: [
                DuJustNuTip(title: "BLW eller puré – du väljer", body: "Baby-Led Weaning (bebisen äter själv i bitar) eller puré – båda funkar. Det viktigaste är att mat ska vara kul, inte stressigt.", icon: "fork.knife"),
                DuJustNuTip(title: "Allergiförebyggande", body: "Introducera allergiframkallande livsmedel (jordnöt, ägg, fisk, mjölk, vete) tidigt i små mängder. Forskning visar att det kan minska risken för allergier.", icon: "allergens.fill"),
                DuJustNuTip(title: "Barnsäkring på allvar", body: "Nu när bebisen börjar röra sig på egen hand: täpp till eluttag, säkra bokhyllor, flytta kemikalier högt upp.", icon: "lock.shield.fill"),
                DuJustNuTip(title: "Vattenkopp", body: "Introducera en liten mugg med vatten vid måltiderna. Bebisen kommer mest leka med den i början, men det etablerar en bra vana.", icon: "cup.and.saucer.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Matvägran",
                    description: "Bebisen spyr ut maten, vänder bort huvudet eller verkar inte intresserad. Det kan vara frustrerande.",
                    advice: "Helt normalt! Det kan ta 10–15 exponeringar innan bebisen accepterar en ny smak. Tvinga aldrig. Prova igen om några dagar. Bröstmjölk/ersättning är fortfarande huvudnäringen."
                ),
                DuJustNuChallenge(
                    title: "Separationsångest",
                    description: "Bebisen klamrar sig fast och gråter när du lämnar rummet. Det kan göra det svårt att lämna hen hos andra.",
                    advice: "Det är ett tecken på trygg anknytning och helt normalt vid den här åldern. Var tydlig: 'Mamma går på toaletten, jag kommer strax.' Smyg aldrig iväg."
                ),
                DuJustNuChallenge(
                    title: "Nattsömn med mat",
                    description: "Nu när bebisen äter fast mat kan magen påverkas. En del bebisar sover sämre, andra bättre.",
                    advice: "Ge inte för mycket mat precis före läggdags. Magen behöver vänja sig. Undvik nya livsmedel på kvällen – testa nytt på morgonen/lunchen."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Matutforskning", description: "Lägg olika maträtter framför bebisen och låt hen utforska med händerna. Det blir kladdigt men det är så hen lär sig! Plast under stolen underlättar.", ageAppropriate: true),
                DuJustNuActivity(title: "Burkhämtning", description: "Göm en leksak under en mugg och visa bebisen hur du lyfter muggen. Hen börjar förstå objektpermanens och älskar överraskningen!", ageAppropriate: true),
                DuJustNuActivity(title: "Krypmotivation", description: "Lägg en favoritlelsak precis utom räckhåll och uppmuntra bebisen att ta sig dit. Fira stort när hen lyckas!", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "12–15 timmar",
                nightSleep: "10–11 timmar (med 0–2 uppvaknanden)",
                daySleep: "2.5–3.5 timmar",
                wakeWindow: "2–3 timmar",
                naps: "2–3 tupplurer"
            ),
            feedingInfo: "Nu introduceras fast mat! Börja med 1–2 mål per dag utöver bröstmjölk/ersättning. Prova grönsaker (morot, broccoli, potatis, sötpotatis), frukt (banan, päron, äpple) och järnrik mat (köttpuré, linser). Introducera allergiframkallande livsmedel tidigt. Bröstmjölk/ersättning är fortfarande den viktigaste näringskällan.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 6-månadersåldern:",
                consensus: "Matintroduktionen engagerar enormt. Föräldrarna delar bilder på kladdiga bebisar och tips om vad som fungerar.",
                quotes: [
                    "\"BLW är fantastiskt. Ja, det är kaos efter varje måltid, men att se honom utforska maten själv är underbart.\" – Klara, 29",
                    "\"Hon sitter själv och tittar så nöjd ut. Hela världen ser annorlunda ut när man sitter upp!\" – Ahmed, 34",
                    "\"Tips: plastmatta under barnstolen. Du behöver det. Lita på mig.\" – Elin, 31"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 9. 7 månader
        DuJustNuContent(
            id: "7-months",
            ageLabel: "7 månader",
            ageMinDays: 210,
            ageMaxDays: 239,
            headline: "Världen utforskas på alla fyra!",
            introduction: """
            Sju månader och din bebis är i full fart! Många bebisar kryper eller ålar sig framåt nu, och de som inte gör det hittar kreativa sätt att ta sig dit de vill – bakåtkrypning, rullning eller hopping på rumpan. Det finns inget fel sätt att förflytta sig!

            Personligheten lyser igenom allt tydligare. Du ser vad bebisen tycker om och inte tycker om. Hen kan vara bestämd och visa frustration när saker inte går som hen vill. Det är början på den egna viljan – förunderligt och ibland utmanande!

            Maten blir en allt viktigare del av vardagen. Bebisen äter nu 2–3 mål om dagen och smakar allt fler livsmedel. Det är spännande att se hur hen utvecklar sin smak och sina preferenser.
            """,
            whatBabyDoes: [
                "Kryper eller ålar sig framåt (eller bakåt!)",
                "Sitter stadigt utan stöd",
                "Klappar händerna och vinkar (eller försöker)",
                "Plockar upp småsaker med pincettgrepp",
                "Jollrar med dubbla stavelser ('mama', 'dada')",
                "Visar tydliga preferenser för vissa leksaker och personer"
            ],
            milestones: [
                DuJustNuMilestone(title: "Kryper", description: "De flesta bebisar börjar krypa eller röra sig framåt på något sätt nu. Vissa kryper klassiskt, andra hittar egna varianter!", icon: "figure.walk"),
                DuJustNuMilestone(title: "Pincettgrepp", description: "Bebisen kan nu plocka upp små föremål med tumme och pekfinger. Var extra vaksam med smådelar!", icon: "hand.pinch"),
                DuJustNuMilestone(title: "Klappar händerna", description: "Bebisen lär sig klappa händerna – både som lek och som uttryck för glädje. Klappa tillsammans!", icon: "hands.clap.fill"),
                DuJustNuMilestone(title: "Förstår 'nej'", description: "Bebisen börjar förstå innebörden av 'nej' även om hen inte alltid lyssnar. Tonen i din röst spelar stor roll.", icon: "hand.raised.fill")
            ],
            tips: [
                DuJustNuTip(title: "Fingermat", body: "Ge bebisen mjuk fingermat som bananstavar, kokad morot eller avokadoskivor. Hen älskar att äta själv och det tränar finmotoriken.", icon: "hand.raised.fingers.spread.fill"),
                DuJustNuTip(title: "Krypvänligt hem", body: "Se till att golven är rena och fria från smådelar. Spärra av trappor och farliga områden med säkerhetsgrind.", icon: "house.fill"),
                DuJustNuTip(title: "Vinkeleken", body: "Lär bebisen att vinka hejdå. Det tar ett tag men en dag vinkar hen tillbaka och alla smälter!", icon: "hand.wave.fill"),
                DuJustNuTip(title: "Böcker med klaffar", body: "Pek- och klaffböcker är perfekta nu. Bebisen älskar att öppna klaffarna och se vad som gömmer sig.", icon: "book.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Sätter allt i munnen",
                    description: "Med pincettgreppet kan bebisen nu plocka upp pyttelika saker – och allt hamnar i munnen.",
                    advice: "Gå ner på alla fyra och se rummet ur bebisens perspektiv. Plocka bort allt som kan vara farligt: mynt, knappar, smådelar. Var särskilt vaksam med äldre syskons leksaker."
                ),
                DuJustNuChallenge(
                    title: "Separation vid inskolning",
                    description: "Många börjar fundera på förskola. Tankarna kring separation kan väcka oro.",
                    advice: "Inskolning brukar gå bättre än man tror. Barn anpassar sig och knytar an till nya vuxna. Börja prata om det i god tid med partnern."
                ),
                DuJustNuChallenge(
                    title: "Nattliga uppvaknanden igen",
                    description: "Bebisen kryper i sömnen, sätter sig upp och kan inte lägga sig ner igen.",
                    advice: "Det är vanligt att nya motoriska färdigheter stör sömnen. Öva den nya färdigheten mycket dagtid så den 'sätter sig' snabbare."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Hinderbana", description: "Bygg en enkel hinderbana med kuddar och filtar. Låt bebisen krypa över och runt dem. Bra för motorik och problemlösning!", ageAppropriate: true),
                DuJustNuActivity(title: "Klappa-och-sjung", description: "Sjung klapplekar som 'Klappa händerna så blir mamma glad'. Bebisen försöker härma och det tränar koordination och social förmåga.", ageAppropriate: true),
                DuJustNuActivity(title: "Sorteringslek", description: "Ge bebisen en burk eller skål med föremål att ta ut och stoppa tillbaka i. Enkelt men fascinerande för en 7-månading!", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "12–14 timmar",
                nightSleep: "10–11 timmar (med 0–1 uppvaknanden)",
                daySleep: "2.5–3 timmar",
                wakeWindow: "2.5–3 timmar",
                naps: "2–3 tupplurer"
            ),
            feedingInfo: "Bebisen äter nu 2–3 mål mat per dag plus bröstmjölk/ersättning. Introducera fler livsmedel: kött, fisk, ägg, linser, pasta, ris, bröd. Konsistensen kan vara grövre nu – inte bara puré. Fingermat blir allt viktigare. Vatten i kopp till måltiderna.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 7-månadersåldern:",
                consensus: "Föräldrarna är fascinerade av den snabba motoriska utvecklingen men erkänner att de är trötta av att springa efter en krälande bebis!",
                quotes: [
                    "\"Han kryper rakt mot alla elkontakter. Jag har aldrig barnsäkrat så snabbt!\" – Fredrik, 36",
                    "\"Hon säger 'mama' och jag VET att hon menar mig, även om alla säger att det bara är joller.\" – Sandra, 28",
                    "\"Bästa leksaken just nu: en gammal kartong. Han kryper in, ut, slår på den. Dyra leksaker kan vi glömma.\" – Tobias, 33"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        ),

        // MARK: 10. 8 månader
        DuJustNuContent(
            id: "8-months",
            ageLabel: "8 månader",
            ageMinDays: 240,
            ageMaxDays: 269,
            headline: "Jag drar mig upp – och vill stå!",
            introduction: """
            Åtta månader – och bebisen drar sig upp till stående vid möbler, soffkanter och dina ben! Det är en spännande men nervkittlande tid. Bebisen vill stå och är stolt som en tupp när hen lyckas, men kan inte alltid sätta sig ner igen – då behövs din hjälp.

            Bebisen är nu en expert på att kommunicera utan ord. Hen pekar, vinkar, klappar, skakar på huvudet och använder hela kroppen för att visa vad hen vill. Förståelsen för språk ökar snabbt – hen förstår nu mycket mer än hen kan säga.

            Separationsångesten kan vara som starkast nu. Bebisen vill ha dig nära hela tiden och kan gråta intensivt om du lämnar rummet. Det är jobbigt men helt normalt – det visar att hen har en stark anknytning till dig.
            """,
            whatBabyDoes: [
                "Drar sig upp till stående vid möbler",
                "Pekar på saker hen vill ha",
                "Vinkar hejdå (eller försöker)",
                "Kryper snabbt och effektivt",
                "Förstår enkla ord och instruktioner ('Var är bollen?')",
                "Leker tittut själv genom att gömma ansiktet"
            ],
            milestones: [
                DuJustNuMilestone(title: "Drar sig upp", description: "Bebisen kan dra sig upp till stående vid möbler och soffkanter. Stor milstolpe på väg mot att gå!", icon: "arrow.up.to.line"),
                DuJustNuMilestone(title: "Pekar", description: "Bebisen pekar på saker hen vill ha eller visa dig. Det är ett viktigt kommunikationssteg!", icon: "hand.point.right.fill"),
                DuJustNuMilestone(title: "Förstår ord", description: "Bebisen förstår nu flera ord och kan svara med att titta mot det du nämner. 'Var är katten?' – och bebisen tittar mot katten!", icon: "text.bubble.fill"),
                DuJustNuMilestone(title: "Kryser", description: "Bebisen kan 'krysa' – gå sidledes längs möbler medan hen håller sig i dem. Nästa steg mot att gå!", icon: "figure.walk")
            ],
            tips: [
                DuJustNuTip(title: "Lär hen att sätta sig ner", body: "Visa bebisen hur hen kan böja knäna och sätta sig ner från stående. Hen drar sig upp men kan inte alltid komma ner!", icon: "arrow.down"),
                DuJustNuTip(title: "Namnge allt", body: "Peka och namnge saker: 'Titta, en hund! Hunden säger vov!' Det hjälper bebisens ordförståelse enormt.", icon: "text.bubble.fill"),
                DuJustNuTip(title: "Trygg avskiljning", body: "Lämna rummet kort och kom tillbaka. Visa att du alltid kommer tillbaka. Det bygger tillit trots separationsångest.", icon: "heart.fill"),
                DuJustNuTip(title: "Inga gåstolar", body: "Gåstolar (jolly jumpers, baby walkers) rekommenderas inte av barnläkare – de kan fördröja den naturliga gångutvecklingen och är en olycksrisk.", icon: "exclamationmark.triangle.fill")
            ],
            commonChallenges: [
                DuJustNuChallenge(
                    title: "Separationsångest på topp",
                    description: "Bebisen skriker desperately när du lämnar rummet, vill inte till andra, klamrar sig fast vid dig.",
                    advice: "Det är den mest intensiva perioden för separationsångest (8–12 månader). Det går över. Var trygg och konsekvent. Säg hejdå, visa att du kommer tillbaka. Smyg aldrig iväg."
                ),
                DuJustNuChallenge(
                    title: "Fallolyckor",
                    description: "Nu när bebisen drar sig upp och kryser händer det att hen ramlar. De flesta fall är ofarliga men skrämmande.",
                    advice: "Sätt mjuka mattor under där bebisen brukar stå. Fäst alla möbler vid väggen (byrå, bokhylla). Ta bort instabila möbler. Fall är en del av att lära sig – men gör det så säkert som möjligt."
                ),
                DuJustNuChallenge(
                    title: "Nattlig övning",
                    description: "Bebisen drar sig upp i spjälsängen och kan inte lägga sig ner igen. Hen står och gråter mitt i natten.",
                    advice: "Öva att sätta sig ner dagtid. Visa hur hen kan hålla i spjälorna och böja knäna. På natten: hjälp hen ner lugnt utan att göra en stor grej av det."
                )
            ],
            activities: [
                DuJustNuActivity(title: "Stå-och-lek", description: "Ställ leksaker på soffan eller ett lågt bord så bebisen har motivation att stå. Bra för benmusklerna och balansen.", ageAppropriate: true),
                DuJustNuActivity(title: "Peklek", description: "Bläddra i bilderböcker och peka på saker: 'Var är katten? Där!' Bebisen älskar att peka och identifiera saker.", ageAppropriate: true),
                DuJustNuActivity(title: "Trumma och musik", description: "Ge bebisen grytor och träslevar att slå på. Musik och rytm fascinerar och det är fantastisk motorikträning (och örondövande!).", ageAppropriate: true)
            ],
            sleepInfo: DuJustNuSleepInfo(
                totalHours: "12–14 timmar",
                nightSleep: "10–11 timmar (med 0–1 uppvaknanden)",
                daySleep: "2–3 timmar",
                wakeWindow: "2.5–3.5 timmar",
                naps: "2 tupplurer"
            ),
            feedingInfo: "Bebisen äter 3 mål mat per dag plus mellanmål, och fortfarande bröstmjölk/ersättning. Konsistensen kan nu vara grovhackad, inte bara puré. Fingermåltider är perfekta: kokta pastasnurror, mjuka fruktbitar, brödskivor, ostkuber. Bebisen äter allt mer själv.",
            forumSection: DuJustNuForumSection(
                intro: "Föräldrar om 8-månadersåldern:",
                consensus: "Separationsångesten diskuteras flitigt – det är en påfrestande period men alla säger att det går över.",
                quotes: [
                    "\"Han stod vid soffan och tittade på mig med ett sådant skitigt flin. Han visste precis att han gjort något stort!\" – Anton, 29",
                    "\"Separationsångesten är verklig. Jag kan inte ens gå på toaletten utan att hon skriker. Det går över, säger alla.\" – Julia, 33",
                    "\"Köp öronproppar. Leksakstrumman är det bästa OCH det värsta som hänt oss.\" – Martin, 35"
                ],
                source: "Föräldraforum & BVC-erfarenheter"
            )
        )
    ]
}
