FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends git openssh-client \
    && pip install --no-cache-dir ansible google-auth google-api-python-client \
    && ansible-galaxy collection install google.cloud \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY ansible/ /workspace/ansible/

CMD ["ansible-playbook", "/workspace/ansible/playbook.yml"]
