# Ljusglimt — App Store Metadata

## App-namn
Ljusglimt

## Subtitle (max 30 tecken)
Din graviditet & babys resa

## Beskrivning (4000 tecken, svenska)

Ljusglimt är din personliga följeslagare genom hela föräldraresans — från drömmen om ett barn, genom graviditeten, till barnets femte år och bortom det.

Oavsett om du precis börjat försöka bli gravid, räknar ned dagarna till barnets ankomst eller försöker förstå varför din fyramånading inte vill sova längre — Ljusglimt finns vid din sida varje dag med verktyg, kunskap och värme.

**Fertilitet & cykelövervakning**
Följ din menscykel med precision. Logga basaltemperatur (BBT) och visualisera kurvan för att hitta ditt fertila fönster. Registrera LH-tester och cervixslemförändringar för en fullständig bild av din cykelhälsa. Ljusglimt beräknar automatiskt dina fruktbara dagar och det troliga ägglossningsdatumet baserat på dina egna data — inte ett genomsnitt av andras.

**Graviditet vecka för vecka (v. 4–42)**
Följ bebisens utveckling med detaljerade beskrivningar för alla 38 veckor. Varje vecka berättar vi vad som händer i kroppen, hur bebisen växer och vad du kan förvänta dig härnäst. Checklista för BVC-besök, förlossningsplanering och samtalspunkter för mödravården ingår.

**Sömnanalys & wake windows**
Nyfödda och spädbarn sover annorlunda — och det förändras hela tiden. Ljusglimt hjälper dig förstå barnets sömnmönster med automatisk wake window-beräkning anpassad för barnets ålder. Appen varnar dig när ett sömnregression troligtvis är på gång och ger konkreta tips för att hantera de svåraste nätterna. Logga sovtider och vakentider enkelt med ett enda tryck.

**Vaccinationsschema**
Hela Folkhälsomyndighetens rekommenderade vaccinationsprogram för 2026 finns inbyggt. Håll koll på vilka vaccinationer som är gjorda, boka påminnelser inför nästa BVC-besök och läs tydliga förklaringar om vad varje vaccin skyddar mot.

**Tillväxtkurvor & BVC-data**
Mata in längd och vikt efter varje BVC-besök och se barnets tillväxt plottat mot svenska percentilkurvor. Dela enkelt med barnets läkare eller BVC-sjuksköterska. Inga konstiga enhetsomvandlingar — allt är i centimeter och kilo.

**Milstolpar & minnen**
Registrera barnets första leende, första steget och alla de stora och lilla ögonblicken däremellan. Knyt foton till milstolparna och skapa ett digitalt minne som varar.

**70+ svenska sagor**
En inbyggd sagosamling med berättelser speciellt utvalda för svenska barn. Lyssna på upplästa sagor när det är dags för kvällsrutinen — perfekt för den trötta föräldern som vill göra sagostunden enkel och mysig.

**9 kurser om föräldraskap**
Djupdyk i ämnen som sömnträning, amning, anknytning, introduktion av fast föda och hantering av kolik. Kurserna är skrivna av svenska barnläkare, BVC-sköterskor och psykologer och presenteras i korta, läsbara avsnitt anpassade för den sömniga förälderns koncentrationsförmåga.

**Community & forum**
50+ kurerade diskussionstrådar där du kan läsa om andras erfarenheter och ställa egna frågor. Allt innehåll är på svenska.

**Integritet i centrum**
All din data stannar på din enhet. Ljusglimt samlar inte in personuppgifter, skickar inte data till tredjepartsservrar och säljer ingenting till annonsörer. Ingen inloggning krävs. Du äger dina data helt och hållet.

Ljusglimt — ett litet ljus i en stor resa.

## Nyckelord (max 100 tecken)
graviditet,baby,fertilitet,förälder,sömn,amning,BVC,barnvikt,graviditetsapp,babyapp,LH

## Vad är nytt — Version 1.0.0
Välkommen till Ljusglimt!

Ljusglimt är din nya följeslagare genom livet som förälder — från fertilitet och graviditet till barnets första år och framåt.

Version 1.0 innehåller:
• Fertilitetsspårning med BBT-kurva och LH-testloggning
• Graviditetsguide vecka för vecka (v.4–v.42)
• Sömnanalys med wake window-beräkning och regressionsvarning
• Vaccinationsschema (Folkhälsomyndigheten 2026)
• Tillväxtkurvor med svenska BVC-percentiler
• 70+ svenska sagor med lyssningsläge
• 9 kurser om föräldraskap, sömn och amning
• Community-forum med 50+ kurerade trådar

## Support URL
https://github.com/tedsvard/ljusglimt/issues

## Marketing URL (optional)
(leave blank)

## Copyright
© 2026 Ted Svård. Alla rättigheter förbehålls.

## Age Rating
4+

## Privacy Policy URL
(leave blank — add before submission)

## App Store Category
Primary: Health & Fitness
Secondary: Lifestyle

## Content Rights
Does not contain, show or access third-party material: YES

---

## Entitlements-status (granskning 2026-03-19)

Ingen `.entitlements`-fil hittades i projektet. Appen använder:
- **UserNotifications** — kräver inga entitlements (tillstånd begärs vid körtid)
- **SwiftData** — kräver inga entitlements (lokal lagring)
- **CloudKit / iCloud** — används EJ i nuläget

Slutsats: Avsaknaden av entitlements-fil är korrekt för appens nuvarande funktionalitet. Om iCloud-synk eller push-notiser via APNs läggs till i framtiden behövs en entitlements-fil med `com.apple.developer.icloud-container-identifiers` respektive `aps-environment`.

## Övriga observationer

- `CFBundleDisplayName` i Info.plist är fortfarande `BabyCare` — bör uppdateras till `Ljusglimt` manuellt i Xcode
- Bundle ID i pbxproj är `se.tedsvard.ljusglimt` (korrekt)
- `NSHealthUpdateUsageDescription` refererar till "BabyCare" — bör uppdateras till "Ljusglimt"
- HealthKit-import hittades ej i källkoden — `NSHealthUpdateUsageDescription` i Info.plist kan tas bort om HealthKit inte används
