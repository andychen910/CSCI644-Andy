FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git gnupg openssh-client \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
       | gpg --dearmor -o /etc/apt/keyrings/cloud.google.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
       > /etc/apt/sources.list.d/google-cloud-sdk.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends google-cloud-cli \
    && pip install --no-cache-dir ansible google-auth google-api-python-client \
    && ansible-galaxy collection install google.cloud \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY ansible/ /workspace/ansible/

CMD ["ansible-playbook", "/workspace/ansible/playbook.yml"]
