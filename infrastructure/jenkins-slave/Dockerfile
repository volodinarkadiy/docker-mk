FROM docker:1.12.3-dind

ENV JENKINS_HOME /home/jenkins
ENV JENKINS_REMOTNG_VERSION 2.7.1

ENV DOCKER_HOST tcp://0.0.0.0:2375

# Install requirements
RUN apk --update add \
    curl \
    bash \
    git \
    openjdk8-jre \
    sudo

# Add jenkins user
RUN adduser -D -h $JENKINS_HOME -s /bin/sh jenkins jenkins \
    && chmod a+rwx $JENKINS_HOME

# Allow jenkins user to run docker as root
RUN echo "jenkins ALL=(ALL) NOPASSWD: /usr/local/bin/docker" > /etc/sudoers.d/00jenkins \
    && chmod 440 /etc/sudoers.d/00jenkins

# Install docker compose
RUN     apk -U add \
            python \
            py-pip
COPY    requirements.txt /code/requirements.txt
RUN     pip install -r /code/requirements.txt

ADD     compose_dist/compose-1.8.1.tar.gz /code/docker-compose
RUN     pip install --no-deps /code/docker-compose/compose-*

# Install Jenkins Remoting agent
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar http://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/2.52/remoting-2.52.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

USER jenkins
COPY jenkins-slave /usr/local/bin/jenkins-slave

USER root
RUN mkdir .docker
COPY certs .docker/
RUN chown -R jenkins:jenkins /.docker

RUN chmod +x /usr/local/bin/jenkins-slave
RUN chown root:jenkins /usr/local/bin/docker


USER jenkins
VOLUME $JENKINS_HOME
WORKDIR $JENKINS_HOME

ENTRYPOINT ["/usr/local/bin/jenkins-slave"]
