curl -s  I  -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  https://$4:8443/$3 -k > /tmp/header.json
curl -s   -u $1:$2 -H "Accept: application/json" "Content-Type: application/json"  GET https://$4:8443/$3  -k > /tmp/response.json
cat /tmp/response.json | python -mjson.tool > /tmp/output1.json
response1=$3
if [[ $response1  =~ "_folders" ]] 
then
i=0
j=0
old_IFS=$IFS
IFS=$'\n'
array_folders=($(grep '"title":' /tmp/output1.json | sed s/'"title": "'//ig|sed s/'"'//ig|sed s/' '//ig))
len_folders=${#array_folders[@]}
len_type1=$len_folders
i=0
j=0
IFS=${old_IFS}
while [ $i -lt $len_type1 ]
do
nfname=${array_folders[$i]}
if [[ $#  -eq  4 ]]
then
echo $nfname*
fi
array_binderid=($(egrep "*binderId" /tmp/output1.json|sed s/'"permalink".*binderId=//ig' |  sed "s/\&.*//ig"|sed s/' '//ig))
binderid=${array_binderid[$i]}
i=$(( $i + 1 ))
arraytype="D"
j=$(( $j + 1 ))

echo $nfname,$arraytype,$binderid, >> /tmp/ids.csv

done
fi

if [[ $response1  =~ "files" ]] 
then
i=0
j=0
old_IFS=$IFS
IFS=$'\n'
array_files=($(grep '"name":' /tmp/output1.json | sed s/'"name": "'//ig|sed s/'"'//ig|sed s/','//ig| sed s/' '//ig |sed s/' '//ig))
old_IFS=$IFS
len_files=${#array_files[@]}
len_type1=$len_files
k=1
l=0
while [ $i -lt $len_type1 ]
do


nfname=${array_files[$i]}
nflen=`echo -n $nfname | wc -c `
nflen=$(($nflen + 1))
if [[ $#  -eq  4 ]]
then
echo $nfname*
fi


entry=($(egrep "readFile\/folderEntry" /tmp/output1.json| sed "s/https.*readFile\/folderEntry//ig"|  sed s/'"href": '//ig |sed s/'"'//ig |tr '\/' '\n'|sed s/' '//ig))

fileentryid=${entry[$k]}
i=$(( $i + 1 ))
array_type1="F"
j=$(( $j + 1 ))
k=$(( $k + 5 ))
size=($(grep '"length":' /tmp/output1.json | sed s/'"length": '//ig|sed s/','//ig|sed s/' '//ig))
sizel=${size[$l]}
echo $nfname,$array_type1,$fileentryid,$sizel,  >> /tmp/ids.csv
l=$(($l + 1))
done
fi



if [[ $response1  =~ "children" ]] 
then
i=0
j=0
old_IFS=$IFS
IFS=$'\n'
array_files=($(grep '"name":' /tmp/output1.json | sed s/'"name": "'//ig|sed s/'"'//ig |sed s/','//ig|sed s/' '//ig))
old_IFS=$IFS
len_files=${#array_files[@]}
len_type1=$len_files
k=1
l=0
while [ $i -lt $len_type1 ]
do


nfname=${array_files[$i]}
nflen=`echo -n $nfname | wc -c `
nflen=$(($nflen + 1))
echo $nfname*
entry=($(egrep "readFile\/folderEntry" /tmp/output1.json| sed "s/https.*readFile\/folderEntry//ig"|  sed s/'"href": '//ig |sed s/'"'//ig |tr '\/' '\n' |sed s/' '//ig))

fileentryid=${entry[$k]}
i=$(( $i + 1 ))
array_type1="F"
j=$(( $j + 1 ))
k=$(( $k + 5 ))
size=($(grep '"length":' /tmp/output1.json | sed s/'"length": '//ig|sed s/','//ig|sed s/' '//ig))
sizel=${size[$l]}
echo $nfname,$array_type1,$fileentryid,$sizel, >> /tmp/ids.csv
l=$(($l + 1))
done
i=0
j=0
old_IFS=$IFS
IFS=$'\n'
array_folders=($(grep '"title":' /tmp/output1.json | sed s/'"title": "'//ig|sed s/'"'//ig|sed s/' '//ig))
old_IFS=$IFS
len_folders=${#array_folders[@]}
len_type1=$len_folders
while [ $i -lt $len_type1 ]
do
nfname=${array_folders[$i]}
nflen=`echo -n $nfname | wc -c `
nflen=$(($nflen + 1))
echo $nfname*

array_type2="D"
j=$(( $j + 1 ))
array_binderid=($(egrep "*binderId" /tmp/output1.json|sed s/'"permalink".*binderId=//ig' |  sed "s/\&.*//ig"|sed s/' '//ig))
#array_binderid=($(egrep "*binderId" /tmp/output1.json|sed s/'"permalink".*binderId=//ig' |  sed "s/\&.*//ig"))

 binderid=${array_binderid[$i]}
echo $nfname,$array_type2,$binderid, >>/tmp/ids.csv
i=$(( $i + 1 ))
done
fi

