FROM jenkins:2.19.3

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JENKINS_OPTS --argumentsRealm.passwd.admin=dockermk --argumentsRealm.roles.user=admin
RUN /usr/local/bin/install-plugins.sh build-pipeline-plugin:1.5.4 dockerhub-notification:2.2.0 \
		github-branch-source:1.10 workflow-aggregator:2.4 docker-workflow:1.9 \
		pipeline-stage-view:2.2 github:1.23.1 docker-build-publish:1.3.2 blueocean:1.0.0-b11

ADD JENKINS_HOME /usr/share/jenkins/ref
