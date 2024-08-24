 #!/bin/bash

#Pause function
function pause()
{
        printf -- "\n\n"
        read -s -n 1 -p "Press any button to continue setup or ctrl+c to quit..."
        printf -- "\n\n"
}

#Check for available updates
printf --  "\nInitializing Server and Checking for updates\n"
pause
sudo yum check-update


#Make a folder for dependencies
printf --  "\nMaking a folder for dependencies\n"
pause
mkdir ~/ora_dependencies
cd ~/ora_dependencies

#Install Oracle Preinstall package (ONLY WORKS ON ORACLE)
#printf --  "\nRunning Oracle Preinstall Package\n"
#sudo yum install -y oracle-database-preinstall-19c.x86_64
#Future Use/Testing for 64-bit
#sudo yum install -y oracle-database-preinstall-21c.x86_64

#Set SELinux to Permissive
printf --  "\nSetting SELinux to permissive\n"
pause
sudo setenforce Permissive
sudo systemctl stop firewalld
sudo systemctl disable firewalld

#Download and install java (be sure to check Azul for the latest 32-bit Java 11 for SWG and 64-bit for sqldeveloper)
printf --  "\nDownloading and installing Azul Java 17\n"
pause

wget https://cdn.azul.com/zulu/bin/zulu17.50.19-ca-jdk17.0.11-linux.i686.rpm
sudo yum install ./zulu17.50.19-ca-jdk17.0.11-linux.i686.rpm -y

printf --  "\nInstalling additional dependencies for 32bit\n"
sudo yum install libXext.i686 libXrender.i686 libXtst.i686 -y

printf --  "\nInstalling Python and Pip\n"
#Install Python (This command could vary by distro)
sudo yum install python39 -y
sudo yum install python39-pip -y
sudo yum install python39-ply -y

#Download Oracle 19.3.0 Database and Preinstall pack
printf --  "\nQueing Oracle Database for download\n"
pause
~/swg-prepare/oracle_downloads.sh

#Make directories and extract
printf --  "\nQue Oracle DB Extract\n"
pause
~/swg-prepare/oracle_extract.sh


echo "Setting password for Oracle user"
pause
#set Oracle User Password
printf -- "oracle:swg" | sudo chpasswd
