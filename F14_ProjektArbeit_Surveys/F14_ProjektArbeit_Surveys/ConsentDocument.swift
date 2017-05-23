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
    consentDocument.title = NSLocalizedString("Einverständniserklärung", comment: "")
    
    // This is the title of the signature page in the generated document.
    consentDocument.signaturePageTitle = NSLocalizedString("Consent Signature", comment: "")
    
    /*
     This is the line shown on the signature page of the generated document,
     just above the signatures.
     */
    consentDocument.signaturePageContent = NSLocalizedString("Durch das Klicken auf „ich erkläre mich einverstanden“ bezeugen Sie, dass Sie den oben genannten Text der Einverständniserklärung gelesen und verstanden haben.", comment: "")
    
    /*
     Add the participant signature, which will be filled in during the
     consent review process. This signature initially does not have a
     signature image or a participant name; these are collected during
     the consent review step.
     */
    let participantSignatureTitle = NSLocalizedString("Participant", comment: "")
    let participantSignature = ORKConsentSignature(forPersonWithTitle: participantSignatureTitle, dateFormatString: nil, identifier: String(describing:Identifier.consentDocumentParticipantSignature))
    
    consentDocument.addSignature(participantSignature)
    
    
    // overview
    let overviewSection = ORKConsentSection(type: ORKConsentSectionType.overview)
    overviewSection.title = "Einführung"
    overviewSection.summary = "Besten Dank, dass Sie an unserer Studie teilnehmen... (für den ganzen Text bitte unten auf \"Learn more about the study first\" klicken)"
    
    overviewSection.content = "Besten Dank, dass Sie an unserer Studie teilnehmen. Die Befragung dauert insgesamt während 36 Stunden an. Die Daten werden vollständig anonym erfasst. Es sind keine Rückschlüsse auf einzelne Probanden möglich. Wichtig ist, dass Sie alle Fragen ehrlich beantworten. Bei den meisten Fragen gibt es keine richtigen oder falschen Antworten, das heisst, es ist kein Leistungstest, sondern es geht um Ihre persönliche Meinung. Die Studie wird von der ZHAW Zürcher Hochschule für Angewandte Wissenschaften durchgeführt."
    
    
    // custom consent
    let customSection = ORKConsentSection(type: ORKConsentSectionType.custom)
    customSection.title = "Einverständniserkärung"
    customSection.summary = "Um an dieser Studie teilnehmen zu können, ist es notwendig, dass Sie ihr Einverständnis geben (bitte auf \"Learn more\" klicken)"
    customSection.htmlContent = "<p>Um an dieser Studie teilnehmen zu können, ist es notwendig, dass Sie ihr Einverständnis geben. Bevor Sie dieses geben, lesen Sie bitte folgende Punkte durch:</p><ul><li>Ich nehme zur Kenntnis, dass ich an einer wissenschaftlichen Studie teilnehme.</li><li>Meine Daten werden vertraulich behandelt. Die Auswertung meiner Daten erfolgt</li><li>ausschliesslich zu statistischen Zwecken und anonym.</li><li>Mein Name wird in keiner Publikation erwähnt. Die Weitergabe meiner Daten für Publikationen erfolgt anonym</li><li>Die Daten, welche im Rahmen der Studie über mich erhoben werden, dürfen für weitere Forschungsprojekte verwendet werden. Auch für diese weiteren Forschungsprojekte gilt die Zusicherung der Anonymität.</li><li>Ich erkläre hiermit, dass ich über Inhalt und Zweck der Studie informiert worden bin</li><li>Ich bin damit einverstanden, dass mir vor der Teilnahme an der Studie noch gewisse Fakten vorenthalten werden können. Der wahre Grund wird mir jedoch unmittelbar nach Beendigung meiner Teilnahme an der Studie mitgeteilt.</li><li>Mir wurde eine Kontaktperson angegeben, der ich jederzeit Fragen zur Studie stellen kann</li><li>Die Teilnahme an der Studie ist freiwillig. Ich habe das Recht, jederzeit und ohne Angaben von Gründen die Teilnahme zu widerrufen, ohne dass mir dadurch Nachteile entstehen.</li></ul>"
    
    consentDocument.sections = [overviewSection, customSection]
    
    // signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}

