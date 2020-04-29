FROM alpine:3.10

# install base packages
RUN apk add curl bash groff less python py-pip coreutils openssl && \
    apk add ncurses --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# install helm
RUN wget -q https://get.helm.sh/helm-v3.2.0-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
        && chmod +x /usr/local/bin/helm

# install AWS CLI
RUN pip install awscli

# install aws-iam-authenticator
RUN curl -LO https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && \
    mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# install kubens
RUN wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens && \
chmod +x ./kubens && \
mv ./kubens /usr/local/bin/kubens

# install kubectx
RUN wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx && \
chmod +x ./kubectx && \
mv ./kubectx /usr/local/bin/kubectx

COPY scripts/docker-entrypoint.sh docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["/bin/bash"]
