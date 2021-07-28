#!/usr/bin/env bash

# get_certificate.sh
export i18n_ADD_DOMAIN_NAME=("Specify the domain for which you want to create a certificate. If it is a wildcard cert, add *. in front of the domain name:" "Geben Sie die Domain an, für die Sie ein Zertifikat erstellen möchten. Sollte es sich um ein Wildcard-Zertifikat handeln, fügen Sie *. vor den Domain-Namen:")
export i18n_ADD_ANOTHER_DOMAIN_NAME=("Do you want to add another domain? [Y/n]" "Wollen Sie noch eine Domain hinzufügen? [J/n]")
export i18n_ERROR_NO_DNS_ENTRIES=("There are no DNS entries for the following domains:" "Für die folgenden Domänen gibt es keine DNS-Einträge:")
export i18n_ERROR_CREATE_CERTIFICATE=("Error while creating a certificate with the command: '{}'" "Fehler beim Erstellen eines Zertifikates mit dem Befehl: '{}'")
export i18n_INFO_EMPTY_DOMAIN=("You have entered an empty domain which will not be add to the certificate!" "Sie haben eine leere Domain eingegeben, die nicht zum Zertifikat hinzugefügt wird!")

# revoke_certificate.sh
export i18n_HEADLINE_REVOKE_REASON_MENU=("What is the reason for this certificate deletion?" "Welchen Grund hat die Löschung des Zertifikates?")
export i18n_INFO_REVOKE_REASON=("For more information about certificate revoke reasons look at: https://docs.microsoft.com/en-us/previous-versions/tn-archive/cc700843(v=technet.10)#revocation-reasons" "Für weitere Informationen über Zertifikat-Lösungsgründe siehe: https://docs.microsoft.com/en-us/previous-versions/tn-archive/cc700843(v=technet.10)?redirectedfrom=MSDN#revocation-reasons")
export i18n_OPTION_KEY_COMPROMISE=("The computer was stolen, the smart card was lost or someone has unauthorized access to the certificates private key." "Der Computer wurde gestohlen, die Smartcard ging verloren oder jemand hat unberechtigten Zugriff auf den private key des Zertifikats.")
export i18n_OPTION_AFFILIATION_CHANGED=("The issuer of the certificate has terminated her/his relationship with the organization." "Der Aussteller des Zertifikats hat seine Beziehung zu der Organisation beendet.")
export i18n_OPTION_SUPERSEDED=("Other reasons related with the issuer which are not covered in other reasons. For example when a smart card fails, the password is forgotten or the issuer has changed her/his legal name." "Andere Gründe, die mit dem Aussteller zusammenhängen und nicht unter andere Gründe fallen. Zum Beispiel, wenn eine Smartcard fehlschlägt, das Passwort vergessen wurde oder der Aussteller seinen rechtlichen Namen geändert hat.")
export i18n_OPTION_CESSATION_OF_OPERATION=("If the certificate is a CA which is no longer in use." "Wenn es sich bei dem Zertifikat um eine CA handelt, das nicht mehr in Gebrauch ist.")
export i18n_OPTION_MISCELLANEOUS=("Miscellaneous reasons" "Sonstige Gründe")
export i18n_ERROR_REVOKE_CERTIFICATE=("Error while revoking a certificate with the command: '{}'" "Fehler beim Widerrufen eines Zertifikates mit dem Befehl: '{}'")
export i18n_SUCCESS_REVOKE_CERTIFICATE=("{} was successfully revoked and deleted." "{} wurde erfolgreich widerrufen und gelöscht.")

# show_certificates.sh
export i18n_ERROR_SHOW_CERTIFICATE=("Error while showing the certificate with the command: '{}'" "Fehler beim Anzeigen des Zertifikates mit dem Befehl: '{}'")
export i18n_ERROR_SHOW_ALL_CERTIFICATES=("Error while showing all certificates with the command: '{}'" "Fehler beim Anzeigen aller Zertifikate mit dem Befehl: '{}'")

# show_history.sh
export i18n_HEADLINE_HISTORY_MENU=("[History Selection Menu] -- Which history do you want to see?" "[Historie-Auswahl Menü] -- Welche Historie wollen Sie sich anschauen?")
export i18n_OPTION_SHOW_CREATION_HISTORY=("Certificate Creation History" "Historie der Zertifikatserstellungen")
export i18n_OPTION_SHOW_UPDATE_HISTORY=("Certificate Update/Expand History" "Historie der Zertifikatsaktualisierungen/-erweiterungen")
export i18n_OPTION_SHOW_REVOCATION_HISTORY=("Certificate Revocation History" "Historie der Zertifikatswiderrufe")
export i18n_OPTION_EXIT_HISTORY_MENU=("Exit History Selection Menu" "Historie-Auswahl verlassen")
export i18n_INFO_CREATION_HISTORY_NOT_EXISTS=("No certificates have been created yet." "Bisher wurden keine Zertifikate erstellt.")
export i18n_INFO_UPDATE_HISTORY_NOT_EXISTS=("No certificates have been updated/expanded yet." "Bisher wurden keine Zertifikate aktualisiert/erweitert.")
export i18n_INFO_REVOKE_HISTORY_NOT_EXISTS=("No certificates have been revoked yet." "Bisher wurden keine Zertifikate widerrufen.")

# update_certificate.sh
export i18n_SUCCESS_UPDATE_CERTIFICATE=("{} was successfully updated." "{} wurde erfolgreich aktualisiert.")
export i18n_ERROR_UPDATE_CERTIFICATE=("Error while updating the certificate with the command: '{}'" "Fehler beim Aktualisieren des Zertifikates mit dem Befehl: '{}'")
export i18n_HEADLINE_CHOOSE_UPDATED_DOMAINS=("Which domains should be in the updated certificate?" "Welche Domains sollen im aktualisierten Zertifikat eingetragen sein?")
export i18n_CURRENT_DOMAINS=("Current domains in certificate are: {}" "Momentan sind folgende Domains im Zertifikat eingetragen: {}")
export i18n_NEW_DOMAINS=("Domains in updated certificate: {}" "Domains im aktualisierten Zertifikat: {}")
export i18n_ENTER_DOMAIN_NAME=("Please enter the name of one domain you want to add to the updated certificate, or [A/a] to add all domains from the current certificate:" "Bitte geben Sie den Namen einer Domain ein, die Sie dem aktualisierten Zertifikat hinzufügen möchten, oder [A/a], um alle Domains aus dem aktuellen Zertifikat hinzuzufügen:")
export i18n_QUESTION_ADD_ANOTHER=("Do you want to add another domain? [Y/n]" "Wollen Sie eine weitere Domain hinzufügen? [J/n]")
export i18n_INFO_EMPTY_DOMAIN=("You have entered an empty domain which will not be add to the certificate!" "Sie haben eine leere Domain eingegeben, die nicht zum Zertifikat hinzugefügt wird!")

# utils.sh
export i18n_HEADLINE_SPECIFIC_CERTIFICATE_MENU=("[Certificate Selection Menu] -- What certificate do you want to choose?" "[Zertifikat-Auswahl Menü] -- Welches Zertifikat möchten Sie auswählen?")
export i18n_INFO_NO_CERTIFICATES=("You do not have any certificates!" "Sie besitzen keine Zertifikate!")
