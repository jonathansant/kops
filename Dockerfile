FROM ubuntu:16.04

RUN apt-get -qq update \
&& apt-get -qq -y install curl \
&& apt-get -qq -y install nano

RUN curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64 \
&& chmod +x kops-linux-amd64 \
&& mv kops-linux-amd64 /usr/local/bin/kops

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
&& curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.9.0/bin/linux/amd64/kubectl \
&& chmod +x ./kubectl \
&& mv ./kubectl /usr/local/bin/kubectl

RUN apt-get -y -qq install apt-transport-https ca-certificates software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" \
&& apt-get -qq update \
&& apt-cache search docker-ce \
&& apt-get -y -qq install docker-ce

RUN mkdir ~/.kube && touch /kops.sh && chmod +x /kops.sh