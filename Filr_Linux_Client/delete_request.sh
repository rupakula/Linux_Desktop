

#curl -s  I  -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  https://$4:8443/$3 -k -X POST -data '{"title":'"/'"$5"'/"'}'> /tmp/header1.json
#curl -k -u  val1:novell https://164.99.117.92:8443/rest/folders/49/library_folders -H "Content-Type: application/json" -d '{"title":"test"}'>my.json

curl  -i -u $1:$2 -H "Content-Type: application/json"   https://$4:8443/$3 -k   -X DELETE  > /tmp/header1.json


status=$(cat /tmp/header1.json|head -n1)
sed -i "/^$5,/d" /tmp/ids.csv
echo $status
#echostring="no"
#echo $1 $2 $3 $4

#curl -s   -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  https://$4:8443/$3 -k  -d '{"title":"'"$5"'"}'> /tmp/response.json

