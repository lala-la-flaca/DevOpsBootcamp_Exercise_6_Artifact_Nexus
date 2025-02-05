# Artifact Repository Manager with Nexus
## Description
This exercise, it is part of the Module 6 Exercise guide: Artifact Repository Manager with Nexus from Nana DevOps Bootcamp. It shows how to set up a Nexus Repository Manager to centralize and manage application artifacts for multiple teams. The goal is to ensure teams can store, access, and retrieve artifacts.
<br />

## 🚀 Technologies Used

- <b>Digital Ocean: Cloud provider for hosting Nexus Repository.</b>
- <b>Nexus: Artifact repository manager.</b>
- <b>Linux: Ubuntu for Server configuration and management.</b>
- <b>NodeJS / NPM: Nana's application and package manager.</b>

## 🎯 Features

- <b>Setup a droplet on Digital Ocean with security best practices.</b>
- <b>Setup **Nexus Repository Manager** on Digital ocean.</b>
- <b>Create a BlobStore.</b>
- <b>Setup users and roles to access Nexus.</b>
- <b>Deploy NodeJS artifact to Nexus.</b>

  

## 🏗 Project Architecture
<img src=""/>

## ⚙️ Project Configuration:

### Creating a Droplet on Digital Ocean and Installing Nexus
1. Use the Nexus server installed during Demo 6.

### Creating a npm-hosted repository with a new blob store

1. From the left panel, select Blob Store, and select Create New Blob Store.
2. Choose File as the file type.
3. Enter a name for the Blob store.
4. Verify the default path and save.
   
    <img src=""/> 

5. From the left panel, select Repository, then click Create an NPM-hosted.
6. Assign the previously created blob store to the repository.

   <img src=""/> 

### Creating a Nexus User for Team1 & Role
1. From the left panel in the Nexus WebUI, select Users, then click Create local user.
2. Enter the name and details for team 1.
3. From the left panel in the Nexus WebUI, select Roles, then click Create Role.

   <img src=""/> 

4. Select the Nexus role as a type.
5. Enter Role ID and Name.

    <img src=""/>

      
6. Click on Modify Applied Privileges and assign the least privileges to follow best practices.

   <img src=""/>



   <img src=""/>
  
7. Assign the role to the user.

   <img src=""/>

### Building and Publishing npm tar file in Nexus

1. Modify the package.json file to include the Nexus Repository as a registry.

   <img src=""/>
   
2. Encode the username and password in Base64 format.

   Example: If your username is admin and password is admin123, run:

    ```bash
    echo -n "your-username:your-password" | base64
    echo -n "admin:admin123" | base64
  
  Output: YWRtaW46YWRtaW4xMjM= 
  
3. Add the credentials to the ~/.npmrc file.

   ```bash
    registry=http://157.230.56.153:8081/repository/npmHosted/
    always-auth=true
    //157.230.56.153:8081/repository/npmHosted/:_auth=YWRtaW46YWRtaW4xMjM= 
    email=your.email.adddress@gmail.com
   ```
  <img src=""/>

 4. Verify that the credentials are working properly.

   ```bash
   npm whoami --registry=http://157.230.56.153:8081/repository/npmHosted/
   ```
   
5. Publish the artifact to the Nexus repository.

   ```bash
   npm publish --registry=http://157.230.56.153:8081/repository/npmHosted/
   ```
   
   <img src=""/>

 6. Verify that the artifact is available in the Nexus repository.
  
    <img src=""/>


### Creating a New Maven-Hosted Repository
  1. Create a New Maven-hosted Repository and ensure that the version policy aligns with the version of your app. In this example snapshot.

     <img src=""/>

### Creating a New Nexus User for Team 2 and Role

1. From the left panel in the Nexus WebUI, select Users, then click Create local user.
2. Enter the name and details for team 2.
3. From the left panel in the Nexus WebUI, select Roles, then click Create Role.

   <img src=""/> 

4. Select the Nexus role as a type.
5. Enter Role ID and Name.

    <img src=""/>

      
6. Click on Modify Applied Privileges and assign the least privileges to follow best practices.

   <img src=""/>



   <img src=""/>
  
7. Assign the role to the user.

   <img src=""/>

 ### Building and Publishing jar file to new Maven-Nexus repository using gradle.    

1. Modify the gradle.properties file to include the new credentials.

   <img src=""/>

2. Modify the build.gradle file to include the Nexus repository.

  <img src=""/>  

3. Publish the file using the gradle publish command.

    ```bash
    gradle publish
   ```
4. Verify that the JAR file has been successfully uploaded to Nexus.

   <img src=""/>

### Downloading Artifact from Nexus and Starting application.

1. Create a new user on the droplet server to access both repositories.

    ```bash
    adduser team1team2
   ```
2. Create the .ssh directory and add the public key to grant the new user access to the droplet.
3. Access the droplet using the new user account.

   ```bash
    ssh team1team2@157.230.56.153
   ```

   <img src=""/>
   
4. Use the Nexus REST API to retrieve the download URL for the Node.js artifact.

    ```bash
    curl -u <username:password> -X GET 'http://157.230.56.153:8081/service/rest/v1/components?repository=npmHosted&sort=version'
   ```

   <img src=""/>
   
5. Download the artifact using the URL obtained in the previous step.

    ```bash
    wget --user <XXX> --password <XXX> http://157.230.56.153:8081/repository/npmHosted/bootcamp-node-project/-/bootcamp-node-project-1.0.0.tgz
   ```

   <img src=""/>
   
6. Untar the artifact.

    ```bash
    tar -xvf bootcamp-node-project-1.0.0.tgz
    ```

   <img src=""/>
    
7. Update the package manager to ensure it has the latest version.

    ```bash
    apt update
    ```

    <img src=""/>
    
8. Navigate to the package directory and install dependencies with npm install command.

    ```bash
    cd package
    npm install
    ```

    <img src=""/>
    
9. Run the application on the server.

    ```bash
    node server.js &
    ```
    <img src=""/>
    
10. Modify the droplet firewall to open the necessary ports to access the application.

    <img src=""/>



### Automation on the droplet.
1. Create a file for the script.   
2. Add the rights to execute.   
3. Save the artifact details in a JSON file.
4. Grab the download URL from the JSON file.
5. Extract the name of the tar file from the JSON file.
6. Download the artifact from the Nexus repository.
7.  Untar the artifact.
8.  Navigate to package.
9.  Update the package manager.
10.  Install dependencies.
11.  Run the application on the server.

```bash
#Making an HTTP request to get the info and save it in artifact.json
curl -u team1:team1 -X GET 'http://157.230.56.153:8081/service/rest/v1/components?repository=npmHosted&sort=version' | jq "." > artifact.json

#Getting the DownloadURL from the artifact.json file previously saved using 'jq' json processor tool.
artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

# Downloading the artifact using the URL link obtained from the artifact.json file.
wget --user team1 --password team1 $artifactDownloadUrl

#Extracting tarfile from the URL link using cut and delimiter /
tarFile=$(echo $artifactDownloadUrl | cut -d '/' -f 8)  

echo
echo
echo "This is the artifact name: $tarFile"

#Extracting the AppName
appName=$(echo $tarFile | cut -d '.' -f 1)
echo
echo
echo "This is the app name: $appName"

#untar the artifact
tar -xvf $tarFile

#Deploying the nodejs app on the droplet.
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

```

