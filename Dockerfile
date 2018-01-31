FROM ubuntu

# UPDATE OS
RUN apt-get update && apt-get install -yq

# INSTALL RUBY (https://www.ruby-lang.org/en/documentation/installation/)
RUN apt-get install ruby-full -yq 

## ----- SSH SETUP
RUN apt-get install openssh-server -yq
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
## ----- END SSH SETUP

# CREATE APP DIRECTORY
RUN mkdir -p /app/bin/

# SET CURRENT WORKING DIRECTORY (cwd)
WORKDIR /app/bin/

# MOVE EXECUTABLE INTO APP DIRECTORY
COPY etl ./

# RUN SSHD IN BACKGROUND
CMD ["/usr/sbin/sshd", "-D"]