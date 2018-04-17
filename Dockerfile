FROM python:3.5-slim

#initialize the apt cache to enable pulling 
RUN apt-get update

# install git and ssh
RUN apt-get -y install git ssh

#create a user admin who will be the git user
RUN useradd admin

#make an ssh directory for root, this will enable root to update
#the local copy of the repo via git
RUN mkdir -p /root/.ssh/

#Disable localhost authentication so the root can ssh to localhost 
#without a prompt
RUN echo "NoHostAuthenticationForLocalhost yes" > /root/.ssh/config

#create the user directory for admin
RUN mkdir -p /home/admin/admin

#create the ssh directory for admin
RUN mkdir -p /home/admin/.ssh/

#change admin's password to the default
RUN echo "admin:empiredidnothingwrong" | chpasswd

#make admin the owner of /home/admin
RUN chown -R admin:admin /home/admin/

WORKDIR /home/admin/admin/ 

#create the git repo
RUN su admin -c "git init --bare"

#create the local web app folder, and move to it
WORKDIR /app

#place the app in the web app folder
ADD . /app

#install all dependencies
RUN pip3 install -r Requirements.txt

#open up port 443 for HTTPS
EXPOSE 443

#open up port 22 for SSH
EXPOSE 22

ENV NAME World

#execute the web app
CMD ["python3", "app.py"]
