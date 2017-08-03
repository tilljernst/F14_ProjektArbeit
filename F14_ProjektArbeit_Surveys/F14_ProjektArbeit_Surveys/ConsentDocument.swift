//
//  ConsentDocument.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument{
    let consentDocument = ORKConsentDocument()
    
    /*
     This is the title of the document, displayed both for review and in
     the generated PDF.
     */
    consentDocument.title = "Einverständniserklärung"
    
    // This is the title of the signature page in the generated document.
    consentDocument.signaturePageTitle = "Unterschrift Einverständniserklärung"
    /*
     This is the line shown on the signature page of the generated document,
     just above the signatures.
     */
    consentDocument.signaturePageContent = NSLocalizedString("Durch das Klicken auf „ich erkläre mich einverstanden“ bezeugen Sie, dass Sie den oben genannten Text der Einverständniserklärung gelesen und verstanden haben.", comment: "")
    
    
    
    // overview
    let overviewSection = ORKConsentSection(type: ORKConsentSectionType.overview)
    overviewSection.title = "Einführung"
    overviewSection.summary = "Besten Dank, dass Sie an unserer Studie teilnehmen. Die Befragung dauert insgesamt während 36 Stunden an. Die Daten werden vollständig anonym erfasst. Es sind keine Rückschlüsse auf einzelne Probanden möglich. Wichtig ist, dass Sie alle Fragen ehrlich beantworten. Bei den meisten Fragen gibt es keine richtigen oder falschen Antworten, das heisst, es ist kein Leistungstest, sondern es geht um Ihre persönliche Meinung."
    
    overviewSection.htmlContent = "<p>Die Studie wird von der ZHAW Zürcher Hochschule für Angewandte Wissenschaften durchgeführt.</p><p>Die Befragung dauert insgesamt während 36 Stunden an.</p><p>Die Daten werden vollständig anonym erfasst.</p><p>Es sind keine Rückschlüsse auf einzelne Probanden möglich.</p><p>Wichtig ist, dass Sie alle Fragen ehrlich beantworten.</p><p>Bei den meisten Fragen gibt es keine richtigen oder falschen Antworten, das heisst, es ist kein Leistungstest, sondern es geht um Ihre persönliche Meinung.</p><p>Info-Mail: wal@zhaw.ch</p>"
    
    // custom consent -> overview
    let customSection = ORKConsentSection(type: ORKConsentSectionType.custom)
    customSection.title = "Einverständnis- erklärung"
    customSection.summary = "Um an dieser Studie teilnehmen zu können, ist es notwendig, dass Sie ihr Einverständnis geben Bevor Sie dieses geben, lesen Sie bitte folgende Punkte durch:"
    
    // data section
    let dataSection = ORKConsentSection(type: ORKConsentSectionType.dataGathering)
    dataSection.title = "Datenerfassung"
    dataSection.summary = "Ich nehme zur Kenntnis, dass ich an einer wissenschaftlichen Studie teilnehme."
    dataSection.htmlContent = "<p>Ich nehme zur Kenntnis, dass ich an einer wissenschaftlichen Studie teilnehme.</p><p>Meine Daten werden vertraulich behandelt. Die Auswertung meiner Daten erfolgt ausschliesslich zu statistischen Zwecken und anonym.</p>"
    
    // Privacy
    let privacySection = ORKConsentSection(type: ORKConsentSectionType.privacy)
    privacySection.title = "Privatsphäre"
    privacySection.summary = "Mein Name wird in keiner Publikation erwähnt."
    privacySection.htmlContent = "Mein Name wird in keiner Publikation erwähnt. Die Weitergabe meiner Daten für Publikationen erfolgt anonym."
    
    // date use
    let dataUseSection = ORKConsentSection(type: ORKConsentSectionType.dataUse)
    dataUseSection.title = "Datenverwendung"
    dataUseSection.summary = "Meine Daten aus der Studie dürfen für weitere Forschungsprojekte verwendet werden."
    dataUseSection.htmlContent = "Die Daten, welche im Rahmen der Studie über mich erhoben werden, dürfen für weitere Forschungsprojekte verwendet werden. Auch für diese weiteren Forschungsprojekte gilt die Zusicherung der Anonymität."
    
    // study survey
    let studySurveySection = ORKConsentSection(type: ORKConsentSectionType.studySurvey)
    studySurveySection.title = "Inhalt und Zweck der Studie"
    studySurveySection.summary = "Ich erkläre hiermit, dass ich über Inhalt und Zweck der Studie informiert worden bin."
    studySurveySection.htmlContent = "<p>Ich erkläre hiermit, dass ich über Inhalt und Zweck der Studie informiert worden bin</p><p>Ich bin damit einverstanden, dass mir vor der Teilnahme an der Studie noch gewisse Fakten vorenthalten werden können. Der wahre Grund wird mir jedoch unmittelbar nach Beendigung meiner Teilnahme an der Studie mitgeteilt.</p><p>Mir wurde eine Kontaktperson angegeben, der ich jederzeit Fragen zur Studie stellen kann.</p>"
    
    // withdraw
    let withdrawSection = ORKConsentSection(type: ORKConsentSectionType.withdrawing)

    withdrawSection.title = "Widerrufsrecht"
    withdrawSection.summary = "Die Teilnahme an der Studie ist freiwillig."
    withdrawSection.htmlContent = "<p>Die Teilnahme an der Studie ist freiwillig.</p><p>Ich habe das Recht, jederzeit und ohne Angaben von Gründen die Teilnahme zu widerrufen, ohne dass mir dadurch Nachteile entstehen.</p>"
    
    
    consentDocument.sections = [overviewSection, customSection, dataSection, privacySection, dataUseSection, studySurveySection, withdrawSection]
    
    // signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}

