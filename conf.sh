#!/usr/bin/env bash
#update user
PUID=${PUID:-911}
PGID=${PGID:-911}

groupmod -o -g "$PGID" terraria
usermod -o -u "$PUID" terraria
echo "UID: $PUID"
echo "GID: $PGID"
# permissions
chmod -R a+X /root
chown -R terraria:terraria /root/.local/share/Terraria
chown -R terraria \
	/app/terraria/bin
chmod a+x /app/terraria/bin/TerrariaServer.bin.x86_64
if [[ ! -r /config/serverconfig.txt ]]; then
	echo "No serverconfig.txt found. Creating a default one"
	echo "world=/world/World.wld" > /config/serverconfig.txt
	echo "worldpath=/world" >> /config/serverconfig.txt
        echo "worldname=Terraria"
	echo "autocreate=2" >> /config/serverconfig.txt
	chown "$PUID:$PGID" /config/serverconfig.txt
fi
