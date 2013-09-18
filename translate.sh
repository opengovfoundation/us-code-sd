#!/bin/sh
for file in `ls *.xml`; do
	echo "translating $file"
	java -Xmx4096m -jar /usr/local/Cellar/saxon/9.5.0.2/libexec/saxon9he.jar -s:$file -xsl:translate.xsl
done