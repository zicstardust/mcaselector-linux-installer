#!/bin/sh
export version=$(wget github.com/Querz/mcaselector/releases/latest -q -O - | grep "<title>" | grep -o '[0-9]*[.][0-9]*[.]*[0-9]*\+')

cd /tmp
wget https://github.com/Querz/mcaselector/releases/download/${version}/mcaselector-${version}.jar
wget https://cdn.azul.com/zulu/bin/zulu17.30.15-ca-fx-jre17.0.1-linux_x64.tar.gz
wget https://raw.githubusercontent.com/Querz/mcaselector/master/installer/img/small.bmp
tar -xvzf zulu17.30.15-ca-fx-jre17.0.1-linux_x64.tar.gz
mkdir -p ${home}/.local/share/mcaselector
mv zulu17.30.15-ca-fx-jre17.0.1-linux_x64 ${home}/.local/share/mcaselector/jre
mv mcaselector-${version}.jar ${home}/.local/share/mcaselector/mcaselector.jar
mv small.bmp ${home}/.local/share/mcaselector/icon.bmp
echo $version > ${home}/.local/share/mcaselector/version

echo "[Desktop Entry]" > mcaselector.desktop
echo "version=${version}" >> mcaselector.desktop
echo "Name=MCA Selector" >> mcaselector.desktop
echo "Comment=A tool to select chunks from Minecraft worlds for deletion or export." >> mcaselector.desktop
echo "Type=Application" >> mcaselector.desktop
echo "Terminal=false" >> mcaselector.desktop
echo "Exec=${home}/.local/share/mcaselector/jre/bin/java -jar ${home}/.local/share/mcaselector/mcaselector.jar" >> mcaselector.desktop
echo "StartupNotify=true" >> mcaselector.desktop
echo "Icon=${home}/.local/share/mcaselector/icon.bmp" >> mcaselector.desktop
echo "Categories=Game;ActionGame;AdventureGame;Simulation;" >> mcaselector.desktop
echo "Keywords=game;minecraft;mc;tool;mca;" >> mcaselector.desktop
echo "StartupWMClass=McaSelector" >> mcaselector.desktop
mv mcaselector.desktop ${home}/.local/share/applications/
chmod 775 ${home}/.local/share/applications/