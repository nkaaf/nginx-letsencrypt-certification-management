#!/usr/bin/env bash

# certification_management.sh
export i18n_HEADLINE_CERTIFICATION_MENU=("[Certification Menu] -- What do you want to do?" "[Zertifikat Menü] -- Was wollen Sie machen?")
export i18n_OPTION_SHOW_ALL_CERTIFICATES=("Show all certificates" "Alle Zertifikate anzeigen")
export i18n_OPTION_SHOW_SPECIFIC_CERTIFICATE=("Show specific certificate" "Spezifisches Zertifikat anzeigen")
export i18n_OPTION_CREATE_CERTIFICATE=("Create (wildcard-)certificate" "(Wildcard-)Zertifikat erstellen")
export i18n_OPTION_REVOKE_CERTIFICATE=("Revoke specific certificate" "Spezifisches Zertifikat widerrufen")
export i18n_OPTION_UPDATE_CERTIFICATE=("Update/Expand specific certificate" "Spezifisches Zertifikat aktualisieren/erweitern")
export i18n_OPTION_SHOW_HISTORY=("Show Certificate History" "Zertifikat Historie anzeigen")
export i18n_OPTION_EXIT_CERTIFICATION_MENU=("Exit Certification Menu" "Zertifikat Menü verlassen")

# docker.sh
export i18n_ERROR_FAILED_START_WITH_DOCKER_COMPOSE=("{} cannot be started with Docker Compose. Log path: {}" "{} konnte nicht mit Docker Compose gestartet werden. Log Pfad: {}")
export i18n_DEBUG_STARTING_WITH_DOCKER_COMPOSE=("{} is starting with Docker Compose..." "{} wird mit Docker Compose gestartet...")
export i18n_DEBUG_RECREATE_WITH_DOCKER_COMPOSE=("{} is recreating with Docker Compose..." "{} wird mit Docker Compose neu erstellt...")
export i18n_DEBUG_CONTAINER_HEALTHY=("{} is healthy!" "{} ist gesund!")
export i18n_ERROR_DOCKER_CONTAINER_START_LOOP=("Docker container {} is restarting in a loop. Log path: {}" "Docker container {} wird in einer Schleife neu gestartet. Log Pfad: {}")
export i18n_DEBUG_CHECKING_ALL_CONTAINER_UP=("Checking if all Docker containers are up..." "Prüfen ob alle Docker container gestartet sind...")
export i18n_DEBUG_ALL_CONTAINER_UP=("All Docker containers are up!" "Alle Docker container sind erfolgreich gestartet!")

# installation.sh
export i18n_ERROR_INTERNET_CONNECTION_REQUIRED=("Your machine requires an internet connection!" "Es wird eine Internet Verbindung benötigt!")
export i18n_ERROR_APT_IS_MISSING=("apt is missing. Please install it on your system." "apt fehlt. Bitte installieren Sie apt.")
export i18n_INFO_INSTALL_NOW=("'{}' is not installed and will be installed now." "'{}' ist nicht vorhanden und wird deshalb jetzt installiert.")
export i18n_INSTALL_WITH_PACKAGE_MANAGER=("'{}' will be installed with apt..." "'{}' wird mit apt installiert...")
export i18n_INSTALL_WITH_PIP=("'{}' will be installed with pip..." "'{}' wird mit pip installiert...")
export i18n_ERROR_WHILE_INSTALLING_PACKAGE_MANAGER=("Error while installing '{}' with apt." "Fehler beim Installieren von '{}' mit pip.")
export i18n_ERROR_WHILE_INSTALLING_WITH_PIP=("Error while installing '{}' with pip." "Fehler beim Installieren von '{}' mit pip.")
export i18n_SUCCESS_INSTALLATION=("{} installed successfully." "{} wurde erfolgreich installiert.")
export i18n_EMAIL_REQUIRED=("For the Let's Encrypt Certification Creation, your Email-Address is required. You will normally receive expiring notes for your certificates (https://letsencrypt.org/docs/expiration-emails/), but with this program, your certificates will automatically renew, that you won't get any Emails, but Let's Encrypt need it nevertheless. Please enter your Email-Address:" "Für die Let's Encrypt Zertifikatserstellung wird Ihre Email-Adresse benötigt. Normalerweise erhalten Sie Auslaufhinweise für Ihre Zertifikate (https://letsencrypt.org/docs/expiration-emails/), aber mit diesem Programm werden Ihre Zertifikate automatisch erneuert, so dass Sie keine Emails erhalten. Trotzdem benötigt Let's Encrypt Ihre Email-Adresse. Bitte geben Sie Ihre Email-Adresse ein:")
export i18n_DEBUG_CHECKING_INTERNET_CONNECTION=("Checking if internet connection exists..." "Prüfe ob eine Internet Verbindung besteht...")
export i18n_DEBUG_SUCCESS_INTERNET_CONNECTION=("Internet connection exists!" "Es besteht eine Internet Verbindung!")
export i18n_DEBUG_CHECKING_REQUIRED_SOFTWARE_INSTALLED=("Checking if required software is installed..." "Prüfe ob die benötigte Software installiert ist...")
export i18n_DEBUG_SUCCESS_REQUIRED_SOFTWARE_INSTALLED=("The required software is installed!" "Die benötigte Software ist installiert!")
export i18n_DEBUG_CHECKING_ENVIRONMENT_VARIABLES=("Checking environment variables..." "Prüfe die Umgebungsvariablen")
export i18n_DEBUG_SUCCESS_ENVIRONMENT_VARIABLES=("Required Environment variables are set!" "Alle benötigten Umgebungsvariablen sind gesetzt!")

# menu.sh
export i18n_HEADLINE_MAIN_MENU=("[Main Menu] -- What do you want to do?" "[Hauptmenü] -- Was wollen Sie machen?")
export i18n_OPTION_MANAGE_CERTIFICATES=("Manage certificates" "Zertifikate verwalten")
export i18n_OPTION_RESTART_NGINX=("Restart nginx" "nginx neustarten")
export i18n_OPTION_CHANGE_LANGUAGE=("Change Language:" "Sprache ändern:")
export i18n_OPTION_EXIT_PROGRAM=("Exit program" "Programm beenden")
export i18n_EXIT_PROGRAM=("Exiting program..." "Programm wird beendet...")

# nginx_management.sh
export i18n_DEBUG_RESTARTING_NGINX=("Restarting nginx..." "nginx wird neugestartet...")
export i18n_ERROR_RESTARTING_NGINX=("nginx could not be restarted." "nginx konnte nicht neugestartet werden.")
export i18n_SUCCESS_RESTARTING_NGINX=("nginx restarted!" "nginx wurde neugestartet!")

# utils.sh
export i18n_ERROR_INVALID_EMAIL=("You have entered an invalid Email-Address. Please enter a valid one:" "Sie haben eine ungültige Email-Adresse angegeben. Bitte geben Sie eine gütige an:")

# main.sh
export i18n_DEBUG_MODE_ACTIVE=("Debug mode is active" "Debug modus ist aktiv")
export i18n_WARNING_NOT_PARSING=("Not parsing: {}" "Wird nicht verarbeitet: {}")
export i18n_PREPARATION=("Prepare system for execution..." "Das System wird für die Ausführung vorbereitet...")
export i18n_SUCCESS_PREPARATION=("Preparation done!" "Vorbereitung erledigt!")
