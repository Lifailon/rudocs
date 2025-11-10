FROM alpine:latest

# WORKDIR /app
# ADD https://github.com/kubetail-org/kubetail/releases/download/cli%2Fv0.10.0/kubetail-linux-amd64 kubetail
# RUN chmod +x kubetail
# ENTRYPOINT ["./kubetail", "serve"]

# Install dependencies
RUN apk add --no-cache curl git

# Install kubectl
RUN curl -fsSL https://cdn.dl.k8s.io/release/$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# Install krew
RUN ( \
        set -x; cd "$(mktemp -d)" && \
        OS="$(uname | tr '[:upper:]' '[:lower:]')" && \
        ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" && \
        KREW="krew-${OS}_${ARCH}" && \
        curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" && \
        tar zxvf "${KREW}.tar.gz" && \
        ./"${KREW}" install krew \
    )

ENV PATH="/root/.krew/bin:${PATH}"

# Install kubetail via krew
RUN kubectl krew install kubetail

ENV PORT=7500

ENTRYPOINT kubectl kubetail serve --host 0.0.0.0 --port $PORT