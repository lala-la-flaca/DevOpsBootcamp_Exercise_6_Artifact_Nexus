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
   
    <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/npmBlobStore1.png"/> 

5. From the left panel, select Repository, then click Create an NPM-hosted repository.
6. Assign the previously created blob store to the repository.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/npmRepo.png"/> 

### Creating a Nexus User for Team1 & Role
1. From the left panel in the Nexus WebUI, select Users, then click Create local user.
2. Enter the name and details for team 1.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/CreatingUserTeam1.png"/> 
 
4. Select Roles from the left panel on the Nexus WebUI, then click Create Role.
5. Select the Nexus role as a type.
6. Enter Role ID and Name.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/CreatingRole.png"/>
      
7. Click on Modify Applied Privileges and assign the least privileges to follow best practices.

   <img src=""/>
  
8. Assign the role to the user.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Assigning%20Role%20to%20Team1.png"/>

### Building and Publishing npm tar file in Nexus

1. Modify the package.json file to include the Nexus Repository as a registry.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/AddingNExusToPackageJsonFile.png"/>
   
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
   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/AddingCredentialstonpmrc%20file%202.png"/>

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
  
    <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Artifact%20in%20Nexus%20repo.png"/>


### Creating a New Maven-Hosted Repository
  1. Create a New Maven-hosted Repository and ensure that the version policy aligns with the version of your app. In this example snapshot.

     <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/NewMavenRepo.png"/>

### Creating a New Nexus User for Team 2 and Role

1. From the left panel in the Nexus WebUI, select Users, then click Create local user.
2. Enter the name and details for team 2.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/CreatinguserForTeam2.png"/>
   
4. From the left panel in the Nexus WebUI, select Roles, then click Create Role. 
5. Select the Nexus role as a type.
6. Enter Role ID and Name.      
7. Click on Modify Applied Privileges and assign the least privileges to follow best practices.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/NewMavenRole.png"/> 

8. Assign the role to the user.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Assigninf%20Role%20to%20user2.png"/>

 ### Building and Publishing jar file to the new Maven-Nexus repository using gradle.    

1. Modify the gradle.properties file to include the new credentials.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Modifying%20Java-app%20for%20the%20new%20user%20team2.png"/>

2. Modify the build.gradle file to include the Nexus repository.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Modyfing%20buildgradle%20file.png"/>  

4. Publish the file using the gradle publish command.

    ```bash
    gradle publish
   ```
5. Verify that the JAR file has been successfully uploaded to Nexus.

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/MyappPublishedNexus.png"/>

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
   
4. Use the Nexus REST API to retrieve the download URL for the Node.js artifact.

    ```bash
    curl -u <username:password> -X GET 'http://157.230.56.153:8081/service/rest/v1/components?repository=npmHosted&sort=version'
   ```

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/DownloadURL.png"/>
   
5. Download the artifact using the URL obtained in the previous step.

    ```bash
    wget --user <XXX> --password <XXX> http://157.230.56.153:8081/repository/npmHosted/bootcamp-node-project/-/bootcamp-node-project-1.0.0.tgz
   ```

   <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/Downloading%20tgz%20file%20from%20repo.png"/>
   
6. Untar the artifact.

    ```bash
    tar -xvf bootcamp-node-project-1.0.0.tgz
    ```
    
7. Update the package manager to ensure it has the latest version.

    ```bash
    apt update
    ```
    
8. Navigate to the package directory and install dependencies with the npm install command.

    ```bash
    cd package
    npm install
    ```
    <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/InstalllingDependencies.png"/>
    
9. Run the application on the server.

    ```bash
    node server.js &
    ```
    <img src="https://github.com/lala-la-flaca/DevOpsBootcamp_Exercise_6_Artifact_Nexus/blob/main/ImgEx/runningNodeJsAppOnDroplet.png"/>
    
10. Modify the droplet firewall to open the necessary ports to access the application.




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


