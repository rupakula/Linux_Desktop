#echo $1 $2 $3
curl -s  -i  -u $1:$2 -H "Accept: application/xml" "Content-Type: application/xml"  https://$4:8443/$3 -k > my.xml

response1=$(cat my.xml | head -n1)
echo $response1
