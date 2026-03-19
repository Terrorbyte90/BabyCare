// Sources/BabyCare/VaccinationData.swift
import Foundation

struct VaccinationEntry: Identifiable {
    let id: String
    let ageInDays: Int
    let ageLabel: String       // e.g. "3 månader"
    let vaccineName: String    // Swedish brand name
    let diseases: String       // diseases protected against
    let notes: String
}

struct VaccinationData {
    static let schedule: [VaccinationEntry] = [
        // Hepatit B — dos 1 (nyfödda med förhöjd risk, annars vid 3 mån)
        VaccinationEntry(
            id: "hepb-1",
            ageInDays: 0,
            ageLabel: "Nyfödda",
            vaccineName: "Engerix-B / Twinrix",
            diseases: "Hepatit B",
            notes: "Ges vid födseln till barn med förhöjd risk (mamma HBsAg-positiv). Ingår annars i Infanrix Hexa vid 3 månader."
        ),

        // Rotavirus — dos 1
        VaccinationEntry(
            id: "rotavirus-1",
            ageInDays: 42,
            ageLabel: "6 veckor",
            vaccineName: "Rotarix",
            diseases: "Rotavirusinfektion (magsjuka)",
            notes: "Oral vaccination. Dos 1 av 2. Ges senast vid 12 veckors ålder."
        ),

        // DTaP-IPV-Hib + HepB — dos 1 (3 månader)
        VaccinationEntry(
            id: "dtap-ipv-hib-1",
            ageInDays: 90,
            ageLabel: "3 månader",
            vaccineName: "Infanrix Hexa",
            diseases: "Difteri, stelkramp, kikhosta, polio, Hib, hepatit B",
            notes: "Kombinationsvaccin. Dos 1 av 3. Ges vid BVC-besöket vid 3 månader."
        ),

        // PCV13 — dos 1
        VaccinationEntry(
            id: "pcv-1",
            ageInDays: 90,
            ageLabel: "3 månader",
            vaccineName: "Prevenar 13",
            diseases: "Pneumokockinfektioner (lunginflammation, hjärnhinneinflammation, öroninflammation)",
            notes: "Dos 1 av 3. Ges vid samma besök som Infanrix Hexa."
        ),

        // Rotavirus — dos 2
        VaccinationEntry(
            id: "rotavirus-2",
            ageInDays: 112,
            ageLabel: "16 veckor",
            vaccineName: "Rotarix",
            diseases: "Rotavirusinfektion (magsjuka)",
            notes: "Oral vaccination. Dos 2 av 2. Ges senast vid 24 veckors ålder."
        ),

        // DTaP-IPV-Hib + HepB — dos 2 (5 månader)
        VaccinationEntry(
            id: "dtap-ipv-hib-2",
            ageInDays: 150,
            ageLabel: "5 månader",
            vaccineName: "Infanrix Hexa",
            diseases: "Difteri, stelkramp, kikhosta, polio, Hib, hepatit B",
            notes: "Kombinationsvaccin. Dos 2 av 3."
        ),

        // PCV13 — dos 2
        VaccinationEntry(
            id: "pcv-2",
            ageInDays: 150,
            ageLabel: "5 månader",
            vaccineName: "Prevenar 13",
            diseases: "Pneumokockinfektioner",
            notes: "Dos 2 av 3. Ges vid samma besök som Infanrix Hexa."
        ),

        // DTaP-IPV-Hib + HepB — dos 3 (12 månader)
        VaccinationEntry(
            id: "dtap-ipv-hib-3",
            ageInDays: 365,
            ageLabel: "12 månader",
            vaccineName: "Infanrix Hexa",
            diseases: "Difteri, stelkramp, kikhosta, polio, Hib, hepatit B",
            notes: "Kombinationsvaccin. Dos 3 av 3. Slutdos i grundserien."
        ),

        // PCV13 — dos 3
        VaccinationEntry(
            id: "pcv-3",
            ageInDays: 365,
            ageLabel: "12 månader",
            vaccineName: "Prevenar 13",
            diseases: "Pneumokockinfektioner",
            notes: "Dos 3 av 3. Slutdos i grundserien."
        ),

        // MMR — dos 1 (18 månader)
        VaccinationEntry(
            id: "mmr-1",
            ageInDays: 540,
            ageLabel: "18 månader",
            vaccineName: "Priorix",
            diseases: "Mässling, påssjuka, röda hund",
            notes: "Dos 1 av 2. Ges vid BVC-besöket vid 18 månader."
        ),

        // dTap-IPV booster (4 år)
        VaccinationEntry(
            id: "dtap-ipv-booster",
            ageInDays: 1460,
            ageLabel: "4 år",
            vaccineName: "Tetravac / Infanrix-IPV",
            diseases: "Difteri, stelkramp, kikhosta, polio",
            notes: "Boosterdos. Ges i förskolan vid 4-årskontrollen."
        ),

        // MMR — dos 2 (6–8 år)
        VaccinationEntry(
            id: "mmr-2",
            ageInDays: 2190,
            ageLabel: "6–8 år",
            vaccineName: "Priorix",
            diseases: "Mässling, påssjuka, röda hund",
            notes: "Dos 2 av 2. Ges i årskurs 1–2 i grundskolan."
        ),

        // HPV — dos 1 (10–12 år)
        VaccinationEntry(
            id: "hpv-1",
            ageInDays: 3650,
            ageLabel: "10–12 år",
            vaccineName: "Gardasil 9",
            diseases: "Humant papillomvirus (HPV) — skyddar mot livmoderhalscancer och könsvårtor",
            notes: "Dos 1 av 2. Ges i årskurs 4–6 (från 10 år). Gäller alla kön sedan 2020."
        ),

        // HPV — dos 2 (10–12 år, 6 månader efter dos 1)
        VaccinationEntry(
            id: "hpv-2",
            ageInDays: 3835,
            ageLabel: "10–12 år (+6 mån)",
            vaccineName: "Gardasil 9",
            diseases: "Humant papillomvirus (HPV)",
            notes: "Dos 2 av 2. Ges 6 månader efter dos 1. Om dos 1 ges efter 15 år krävs 3 doser."
        ),
    ]
}
