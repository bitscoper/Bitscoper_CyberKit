# By Abdullah As-Sadeed

FROM archlinux:latest

RUN pacman -Syu --noconfirm gtk3 unzip wget

RUN wget https://github.com/bitscoper/Bitscoper_Cyber_ToolBox/releases/latest/download/Linux_x64_Executable.zip -O /tmp/Linux_x64_Executable.zip

RUN unzip /tmp/Linux_x64_Executable.zip -d /opt/

WORKDIR /opt/Linux_x64_Executable

RUN chmod +x Bitscoper_Cyber_ToolBox

CMD ["./Bitscoper_Cyber_ToolBox"]
