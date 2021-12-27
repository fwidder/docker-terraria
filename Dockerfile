FROM ubuntu

ARG version="1432"
LABEL maintainer="github@aram.nubmail.ca"

ADD "https://terraria.org/api/download/pc-dedicated-server/terraria-server-${version}.zip" /tmp/terraria.zip
RUN \
 echo "**** install terraria ****" && \
 apt-get update && \
 apt-get install -y unzip && \
 mkdir -p /root/.local/share/Terraria && \
 echo "{}" > /root/.local/share/Terraria/favorites.json && \
 mkdir -p /app/terraria/bin && \
 unzip /tmp/terraria.zip ${version}'/Linux/*' -d /tmp/terraria && \
 mv /tmp/terraria/${version}/Linux/* /app/terraria/bin && \
 echo "**** creating user ****" && \
 mkdir /config && \
 useradd -u 911 -U -d /config -s /bin/false terraria && \
 usermod -G users terraria && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/tmp/*

COPY conf.sh /usr/local/bin/conf.sh
COPY start.sh /usr/local/bin/start.sh
RUN \
 chmod +x /usr/local/bin/conf.sh && \
 chmod +x /usr/local/bin/start.sh 

# ports and volumes
EXPOSE 7777
VOLUME ["/world","/config"]

CMD ["/bin/bash", "/usr/local/bin/start.sh"]
