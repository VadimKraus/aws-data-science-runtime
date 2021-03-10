FROM python:3.9.0-buster as base

# Install NodeJS
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ADD https://deb.nodesource.com/setup_15.x .
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
# hadolint ignore=DL3008
RUN apt-get install -y --no-install-recommends nodejs && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip -q awscliv2.zip \
 && ./aws/install \
 && rm -r ./aws \
 && rm awscliv2.zip

WORKDIR /opt/ml/processing/analysis/

# Install some common dependencies
COPY requirements.txt ./
RUN pip3 install --no-cache-dir -r requirements.txt
