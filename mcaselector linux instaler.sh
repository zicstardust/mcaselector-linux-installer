#!/bin/sh
export version=$(wget github.com/Querz/mcaselector/releases/latest -q -O - | grep "<title>" | grep -o '[0-9]*[.][0-9]*[.]*[0-9]*\+')

mkdir -p ${HOME}/.local/share/mcaselector
cd /tmp
wget https://github.com/Querz/mcaselector/releases/download/${version}/mcaselector-${version}.jar
wget https://raw.githubusercontent.com/Querz/mcaselector/master/installer/img/small.bmp
wget https://cdn.azul.com/zulu/bin/zulu17.30.15-ca-fx-jre17.0.1-linux_x64.tar.gz
tar -xvzf zulu17.30.15-ca-fx-jre17.0.1-linux_x64.tar.gz
mv small.bmp ${HOME}/.local/share/mcaselector/icon.bmp
mv mcaselector-${version}.jar ${HOME}/.local/share/mcaselector/mcaselector.jar
mv zulu17.30.15-ca-fx-jre17.0.1-linux_x64 ${HOME}/.local/share/mcaselector/jre
rm -f zulu17.30.15-ca-fx-jre17.0.1-linux_x64.tar.gz
echo $version > ${HOME}/.local/share/mcaselector/version

#Create start.sh
echo '#''!'/bin/sh > ${HOME}/.local/share/mcaselector/start.sh
echo "export current_version=\$(wget github.com/Querz/mcaselector/releases/latest -q -O - | grep \"<title>\" | grep -o '[0-9]*[.][0-9]*[.]*[0-9]*\+')" >> ${HOME}/.local/share/mcaselector/start.sh
echo "export local_version=\$(cat \${HOME}/.local/share/mcaselector/version)" >> ${HOME}/.local/share/mcaselector/start.sh
echo "if [ \${current_version} == \${local_version} ] || [ \${current_version} == \"\" ]; then" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    \${HOME}/.local/share/mcaselector/jre/bin/java -jar \${HOME}/.local/share/mcaselector/mcaselector.jar" >> ${HOME}/.local/share/mcaselector/start.sh
echo "else" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    cd /tmp" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    rm -f \"/tmp/mcaselector linux instaler.sh\"" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    wget https://github.com/zicstardust/mcaselector-linux-installer/blob/main/mcaselector%20linux%20instaler.sh" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    sh \"mcaselector linux instaler.sh\"" >> ${HOME}/.local/share/mcaselector/start.sh
echo "    \${HOME}/.local/share/mcaselector/jre/bin/java -jar \${HOME}/.local/share/mcaselector/mcaselector.jar" >> ${HOME}/.local/share/mcaselector/start.sh
echo "fi" >> ${HOME}/.local/share/mcaselector/start.sh
chmod +x ${HOME}/.local/share/mcaselector/start.sh

#Create .Desktop
echo "[Desktop Entry]" > ${HOME}/.local/share/applications/mcaselector.desktop
echo "version=${version}" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Name=MCA Selector" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Comment=A tool to select chunks from Minecraft worlds for deletion or export." >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Type=Application" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Terminal=false" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Exec= sh \${HOME}/.local/share/mcaselector/start.sh" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "StartupNotify=true" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Icon=\${HOME}/.local/share/mcaselector/icon.bmp" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Categories=Game;ActionGame;AdventureGame;Simulation;" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "Keywords=game;minecraft;mc;tool;mca;" >> ${HOME}/.local/share/applications/mcaselector.desktop
echo "StartupWMClass=McaSelector" >> ${HOME}/.local/share/applications/mcaselector.desktop
chmod +x ${HOME}/.local/share/applications/mcaselector.desktop