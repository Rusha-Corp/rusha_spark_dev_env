FROM europe-west1-docker.pkg.dev/owa-gemini/docker-registry/spark-master:latest

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install Docker
RUN curl -fsSL https://test.docker.com -o test-docker.sh && \
    sh test-docker.sh && \
    rm -f test-docker.sh

RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update && apt-get install google-cloud-cli -y \
    && apt-get install google-cloud-cli-gke-gcloud-auth-plugin -y