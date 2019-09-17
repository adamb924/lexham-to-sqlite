lexham-to-sqlite
=======================================

This is an overview of how I made the Lexham English Bible available as an SQLite database.

The XML version of the Lexham English Bible is here: 
https://lexhamenglishbible.com/download/)

sqlite3 is here:
https://www.sqlite.org/

xsltproc is here:
http://xmlsoft.org/XSLT/xsltproc2.html

To begin, I pulled out a list of all of the paths of the elements in the XML file. 

    xsltproc  -o "LEB tags.txt" "list-paths.xsl" "LEB.xml"

My notes from this process are given in “Notes on tags.txt”. (I do not claim that they will be useful.)

Next I generate a stripped-down version of the translation, removing paratextual information, and also formatting divisions.

    xsltproc  -o "LEB.stripped.xml" "strip-meta.xsl" "LEB.xml"

(One minor thing: I just eliminated the <i> tag from the text. It seems that outside of the notes, it is used only to highlight the word Rabboni.)

Then I convert this into a tab delimited format, suitable to import into SQLite. This also converts book names like "1 Ch" into "1Ch", to make it easier to parse later.

    xsltproc  -o "LEB.tabs.txt" "to-tab-delimited.xsl" "LEB.stripped.xml"

SQLite script to create lexham.sqlite:

    sqlite3 lexham.sqlite ".read import.sql"
