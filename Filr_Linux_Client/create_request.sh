

#curl -s  I  -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  https://$4:8443/$3 -k -X POST -data '{"title":'"/'"$5"'/"'}'> /tmp/header1.json
#curl -k -u  val1:novell https://164.99.117.92:8443/rest/folders/49/library_folders -H "Content-Type: application/json" -d '{"title":"test"}'>my.json

 
curl  -i -u $1:$2 -H "Content-Type: application/json"   https://$4:8443/$3 -k   -X POST -d '{"title":"'"$5"'"}' > /tmp/header1.json
status=$(cat /tmp/header1.json|head -n1)

echostring="no"
#echo $1 $2 $3 $4

if [[ $status =~ "200" ]]
then
if [[ $6 =~ "folder" ]]
then
bash /root/Filr_Linux_Client/getattr.sh $1 $2 $3 $4 $5
fi
if [[ $6 =~ "file" ]]
then 
bash /root/Filr_Linux_Client/getattr.sh $1 $2 $7 $4 $5
fi
fi
echo $status
#curl -s   -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  https://$4:8443/$3 -k  -d '{"title":"'"$5"'"}'> /tmp/response.json

