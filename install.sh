#!/usr/bin/env bash
install_dir=${HOME}/.local/share/mcaselector
jre_version=zulu17.44.53-ca-fx-jre17.0.8.1
mcaselector_latest_version=$(wget github.com/Querz/mcaselector/releases/latest -q -O - | grep "<title>" | grep -o '[0-9]*[.][0-9]*[.]*[0-9]*\+')

mkdir -p ${install_dir}
cd /tmp
wget https://github.com/Querz/mcaselector/releases/download/${mcaselector_latest_version}/mcaselector-${mcaselector_latest_version}.jar
wget https://raw.githubusercontent.com/Querz/mcaselector/master/installer/img/small.bmp
wget https://cdn.azul.com/zulu/bin/${jre_version}-linux_x64.tar.gz

if [ -f small.bmp ];then
    rm -f ${install_dir}/icon.bmp
    mv small.bmp ${install_dir}/icon.bmp
fi
if [ -f mcaselector-${mcaselector_latest_version}.jar ];then
    rm -f ${install_dir}/mcaselector.jar
    mv mcaselector-${mcaselector_latest_version}.jar ${install_dir}/mcaselector.jar
fi
if [ -f ${jre_version}-linux_x64.tar.gz ];then
    tar -xvzf ${jre_version}-linux_x64.tar.gz
    rm -Rf ${install_dir}/jre
    mv ${jre_version}-linux_x64 ${install_dir}/jre
    rm -f ${jre_version}-linux_x64.tar.gz
fi
echo ${mcaselector_latest_version} > ${install_dir}/version

#Create update.sh
cat > ${install_dir}/update.sh <<UPDATESH
#!/usr/bin/env bash
current_version=\$(wget github.com/Querz/mcaselector/releases/latest -q -O - | grep "<title>" | grep -o '[0-9]*[.][0-9]*[.]*[0-9]*\+')
local_version=\$(cat ${install_dir}/version)
if [ \${current_version} == \${local_version} ] || [ \${current_version} == \"\" ]; then
    notify-send "Latest version installed!"
else
    notify-send "Download new version...!"
    cd /tmp
    rm -f \"/tmp/install.sh\"
    wget https://github.com/zicstardust/mcaselector-linux-installer/blob/main/install.sh
    sh \"install.sh\"
    notify-send "New version installed!"
fi
UPDATESH
chmod +x ${install_dir}/update.sh

#Create .Desktop
cat > ${HOME}/.local/share/applications/mcaselector.desktop <<DESKTOPENTRY
[Desktop Entry]
version=${mcaselector_latest_version}
Name=MCA Selector
Comment=A tool to select chunks from Minecraft worlds for deletion or export.
Type=Application
Terminal=false
Exec=${install_dir}/jre/bin/java -jar ${install_dir}/mcaselector.jar
StartupNotify=true
Icon=${install_dir}/icon.bmp
Categories=Game;ActionGame;AdventureGame;Simulation;
Keywords=game;minecraft;mc;tool;mca;
StartupWMClass=McaSelector
Actions=Configure;
[Desktop Action Configure]
Name=Check Update
Exec=${install_dir}/update.sh
DESKTOPENTRY
chmod +x ${HOME}/.local/share/applications/mcaselector.desktop

echo ""
echo "mcaselector ${mcaselector_latest_version} installed!"
