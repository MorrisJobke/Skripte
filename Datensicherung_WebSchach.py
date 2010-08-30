#!/usr/bin/python
import os
import time
# 1. Die Dateien und Verzeichnisse, die gesichert werden sollen,
# werden in der folgenden Liste angegeben:
quellen = ['/home/raxxor/webschach']
# Unter Windows muessen Sie die Pfade auf diese Weise angeben:
# quellen = ['C:\\Dokumente', 'D:\\Arbeit']
# 2. Die Sicherung muss in das folgende Hauptverzeichnis fuer
# Sicherungen gespeichert werden:
ziel_verzeichnis = '/backup/Webschach'
# Denken Sie daran, dies an Ihre Gegebenheiten anzupassen.
# 3. Die Dateien werden in einer ZIP-Datei gesichert.
# 4. Das Tagesdatum ist der Name des Unterverzeichnisses:
heute = ziel_verzeichnis + os.sep + time.strftime('%Y-%m-%d')
# Die aktuelle Uhrzeit ist der Name des ZIP-Archivs:
jetzt = time.strftime('%H-%M-%S')
# Eine Anmerkung als Benutzereingabe entgegennehmen,
# die fuer den Namen der ZIP-Datei verwendet wird:
ziel = heute + os.sep + jetzt + '.tar.gz'
# Erzeuge das Unterverzeichnis, wenn noch nicht vorhanden:
if not os.path.exists(ziel_verzeichnis):
        os.mkdir(ziel_verzeichnis) # erzeuge das Verzeichnis
        print 'Verzeichnis', ziel_verzeichnis, 'erfolgreich angelegt'
if not os.path.exists(heute):
        os.mkdir(heute) # erzeuge das Verzeichnis
        print 'Verzeichnis', heute, 'erfolgreich angelegt'
# 5. Wir benutzen den Befehl zip (unter Unix/Linux), um die Dateien
# zu einem ZIP-Archiv zu komprimieren:
tar = 'tar -cvzf %s %s' % (ziel, ' '.join(quellen))
# Windows-Benutzer koennen z.B. PKZIP oder Info-ZIP in das
# Windows-Systemverzeichnis kopieren, damit dies funktioniert.
# Sicherung starten
if os.system(tar) == 0:
        print 'Erfolgreiche Sicherung nach', ziel
else:
        print 'Sicherung fehlgeschlagen!', ziel


