FROM python:3.9-slim

# RUN apt-get update && \
#     apt-get install -y --no-install-recommends git && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# RUN git clone --depth 1 --branch master --single-branch https://github.com/ssebastianoo/yt-dlp-telegram /bot && \
#     rm -rf /bot/.git
# RUN mkdir -p /download

COPY . /bot
WORKDIR /bot
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["python", "main.py"]