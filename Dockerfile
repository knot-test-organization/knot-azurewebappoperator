FROM bitnami/kubectl:1.20.9 as kubectl

FROM quay.io/operator-framework/ansible-operator:v1.25.1

COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

COPY requirements.yml ${HOME}/requirements.yml
RUN pip install ansible[azure]
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

# RUN pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/
