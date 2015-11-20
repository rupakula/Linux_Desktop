curl -s   -u $1:$2 -H "Accept: application/xml" "Content-Type: application/xml"  GET https://$4:8443/$3 -k > /tmp/user.xml
tidy -xml -i /tmp/user.xml > /tmp/userinfo.xml
userid=($(egrep "<\/*id>" /tmp/userinfo.xml | sed "s/<\/*id>//ig"|sed s/" "//ig))
echo ${userid[0]}*




