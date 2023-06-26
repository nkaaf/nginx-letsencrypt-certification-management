# Let's Encrypt - nginx Certification Management

Did you ever try to set up nginx and the certbot for Let's Encrypt Certificates? Was the installation, configuration and
usage easy? In common cases, there is no proper way to archive a good, compact and easy to use solution for such deep
integration of two different programs.

This project integrates a whole highly secure pre-configured nginx with the certbot in a modern way. The best is, this
is all managed, installed and used with only ONE script.

No more need to install these programs on your own or write complex nginx configurations for common cases!

## Features

- i18n (Internationalization) for German and English.
- highly secure TLS configurations for nginx (see [sources](#security-sources))
- pre-configured but also customizable nginx
- modern deployment with docker containers and docker compose
- automatically renewal of certificates
- integrated history functions for certificate creation/update/revocation
- possibility to inform own programs/scripts at a change of certificates (see "Own Integrations" in Wiki)
- easy logging/information gathering at errors

## What do you have to do?

1. Clone/Download the sources:

> git clone https://github.com/nkaaf/nginx-letsencrypt-certification-management.git
>
> Suggest using a released version: https://github.com/nkaaf/nginx-letsencrypt-certification-management/releases

2. Be sure that bash is installed!
3. Run the main.sh script

> ./main.sh

4. The script will check if the required software is installed and if the environment is set up correctly
5. Normally you have to enter your email for Let's encrypt.
6. If you are familiar with docker and docker-compose you can change the environment variables of the .env file by
   yourself. This project is tested and rely on the latest versions of the components unless there is any good reason to
   use another version! Any changes to the versions of the programs can end up with unintended changes and eventually
   bugs, remember that!

## Why Bash???

Bash is the most widely used script language on Linux systems and well-advanced development of sh with many more
practical features.

The language is interesting because its scripts don't have to be compiled or interpreted in a more complex way. Bash
and its built-ins have many features that can be used and that can save time in comparison to program them by yourself.
Furthermore, the usage of these scripts is quite easy.

## (Security) Sources

### BSI (Bundesamt für Sicherheit in der Informationstechnik) (German)

* Overview: https://www.bsi.bund.de/DE/Themen/Oeffentliche-Verwaltung/Mindeststandards/TLS-Protokoll/TLS-Protokoll_node.html
* Changelog: https://www.bsi.bund.de/DE/Themen/Oeffentliche-Verwaltung/Mindeststandards/TLS-Protokoll/Aenderungsuebersicht_MST_TLS/Aenderungsuebersicht_TLS_node.html
* TR-02102: https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr02102/tr02102_node.html
* TR-03116: https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr03116/TR-03116_node.html

#### Documents

* APP.3.2 Webserver: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Grundschutz/IT-GS-Kompendium_Einzel_PDFs_2023/06_APP_Anwendungen/APP_3_2_Webserver_Edition_2023.pdf?__blob=publicationFile&v=3 (Edition 2023)
* TR-02102-1 Kryptografische Verfahren - Empfehlungen und Schlüssellängen: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR02102/BSI-TR-02102.pdf?__blob=publicationFile&v=8 (Version 2023-01, Stand: 09. Januar 2023)
* TR-02102-2 Kryptografische Verfahren - Verwendung von Transport Layer Security (TLS): https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR02102/BSI-TR-02102-2.pdf?__blob=publicationFile (Version 2023-01)
* Mindeststandard des BSI zur Verwendung von Transport Layer Security: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Mindeststandards/Mindeststandard_BSI_TLS_Version_2_4.pdf?__blob=publicationFile&v=4 (Version 2.4 vom 25.05.2023)
* Hilfsdokument zum Mindeststandard des BSI zur Verwendung von Transport Layer Security V2.4: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Mindeststandards/Hilfsdokument_Mindeststandard_BSI_TLS_Version_2_4.pdf?__blob=publicationFile&v=3 (Version 2.4 vom 25.05.2023)

#### Information for projects for the German Government

* TR-03116-4 Kryptografische Vorgaben für Projekte der Bundesregierung - Kommunikationsverfahren in Anwendungen: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR03116/BSI-TR-03116-4.pdf?__blob=publicationFile (Version 07.03.2023)
* TLS-Checkliste 2023: https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/Publikationen/TechnischeRichtlinien/TR03116/TLS-Checkliste.pdf?__blob=publicationFile&v=5 (Stand 2023, Datum: 7. März 2023)
