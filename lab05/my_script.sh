#!/bin/sh

echo "Content-­type: text/html"
echo ""
echo "<HTML><HEAD><TITLE>Sample CGI Output</TITLE></HEAD>"
echo "<BODY><p>"
echo ­-n "Generated "

date

echo "</BODY></HTML>"

