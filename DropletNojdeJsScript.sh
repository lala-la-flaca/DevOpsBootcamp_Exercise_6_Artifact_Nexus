#!/bin/sh

#obtain link and redirect the output to  artifact.json file
#curl makes HTTP requests
# authentication to get the info from the repo
#Specifies the HTTP method --> get
curl -u team1:team1 -X GET 'http://157.230.56.153:8081/service/rest/v1/components?repository=npmHosted&sort=version' | jq "." > artifact.json

#Getting the DownloadURL from the saved artifact details using 'jq' json processor tool
#Access the downloadURL value from artifact.json file
#Ensures that the output is a raw string rather than a JSON-formatted string. (Removes quotes)
artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

#download artifact using the link
wget --user team1 --password team1 $artifactDownloadUrl

#gettingTarFile
#tar file name is included  in the artifactDownloadUrl variable
#the Url follows this structure:
#http://157.230.56.153:8081/repository/npmHosted/bootcamp-node-project/-/bootcamp-node-project-1.0.0.tgz
#prints the content of the URL
#pipe the print to the cut to extract fields from the string.
#-d '/': specifies the delimiter to split the URL
#-f 8: extracts the position 8 form the split URL

tarFile=$(echo $artifactDownloadUrl | cut -d '/' -f 8)  

echo
echo
echo "This is the artifact name: $tarFile"


#gettingAppName
appName=$(echo $tarFile | cut -d '.' -f 1)
echo
echo
echo "This is the app name: $appName"

#untar the artifact
tar -xvf $tarFile

#deploy the app
cd ~/package
apt update

echo
echo "Installing dependencies: "
echo
npm install

echo
echo "Starting the App: "
echo
node server.js &
