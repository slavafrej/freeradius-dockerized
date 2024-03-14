# Preparation
## Install Docker
__Basically, on all modern linux distributions, Docker is in the repositories.__


But if you are lucky enough to have a distribution that does not have Docker, follow these instructions.
If you already have Docker installed, you can proceed to the next step.

1. Update the repositories.
```
sudo apt update
```


2. Install the missing components.
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```

3. Add the GPG key to your system.
   
   - For Ubuntu-based:
   ```
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   ```
   - For Debian-based:
   ```
   curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
   ```

4. Add Docker repo to apt.
   
   - For Ubuntu-based (Where <version> specify your version of Ubuntu):
   ```
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu <version> stable"
   ```
   - For Debian-based:
   ```
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian <version> stable"
   ```

5. Finally, install Docker.
   ```
   sudo apt install docker-ce
   ```
## Setting up
1. Clone this repo.
   ```
   git clone https://github.com/slavafrej/freeradius-dockerized.git
   ```

2. Go to it.
   ```
   cd freeradius-dockerized
   ```
3. You will have 7 files in front of you. 5 of which are configuration files
   ```
   authorize  ca.cnf  clients.conf  Dockerfile  radiusd.conf  README.md  server.cnf
   ```

   - First of all, open the clients.conf file in your favorite text editor.
<img width="270" alt="Screenshot 2024-03-14 at 20 33 18" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/20ff590c-5289-4c44-9825-1fa803209cd5">

   - In this file you need to specify FreeRADIUS clients (e.g. router). In my case, I will specify the client as an OpenWRT router.
<img width="286" alt="Screenshot 2024-03-14 at 20 36 30" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/0cb5720f-8f3c-40b3-86e2-01cb8a718923">
    
    * Here it is important to specify the correct ip-address, and set a strong password (secret).
   __Then save it and close.__
   - Open users file in text editor.
     
   * Then scroll to the very bottom of the file.
<img width="501" alt="Screenshot 2024-03-14 at 20 40 06" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/c9bf97b7-ea13-4012-b349-026d70488434">


  - __Instead of Alice, set the name of your client (e.g WiFi client).__
  
  - __Instead bob123alice123, set the strong password of your client.__


4. In front of you are also the files ca.cnf and server.cnf. These are the configuration files for the EAP-TLS certificates. Open ca.cnf first and fill in the following fields.

<img width="404" alt="Screenshot 2024-03-14 at 23 03 08" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/8139ccfd-9777-45dc-b724-2d263dbd11f3">
<img width="465" alt="Screenshot 2024-03-14 at 23 03 20" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/d3c56b6e-b9c5-4505-9c8e-fae6c5e97969">

5. Then open server.cnf and fill in the following fields.

<img width="397" alt="Screenshot 2024-03-14 at 23 04 35" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/27ec06fb-a485-4ec5-a398-1456d6854390">
<img width="403" alt="Screenshot 2024-03-14 at 23 04 45" src="https://github.com/slavafrej/freeradius-dockerized/assets/75539739/735a8327-401e-4afe-81c9-f940f42bac25">

  *You're great. Let's move on to building.*
# Building
1. __In the folder where you cloned this repository__, run the following command:
```
docker build -t freeradius-dockerized:v1 .
```

2. When the build is complete, you can run this container.
   - ❗❗❗**If you have any errors during the build, please write to Issue**❗❗❗
   - Run:
```
docker run -p 1812:1812/udp -p 1813:1813/udp --name freeradius-dockerized -d freeradius-dockerized:v1
```
