# youdl-sh
GUI para youtube-dl (Linux/Termux)

#Prerrequisites & Installation
*Instalar youtube-dl:
sudo apt install youtube-dl
*Instalar ffmpeg (permite convertir formatos tras la descarga):
sudo apt install ffmpeg
*Crear alias para usarlo desde cualquier carpeta:
	dirigirse a la carpeta donde se encuentre el script y verificar la ruta completa con el comando:
	pwd
	(Cómo registar el Alias)
	Ejemplo de alias en Termux con la terminal bash:
	echo alias youdl=/data/data/com.termux/files/home/youdl.sh >> .bashrc
	Ejemplo de alias en Linux con la terminal zsh:
	echo alias youdl=$HOME/youdl.sh >> .zshrc

#Usage:
La descarga quedara en la carpeta actual.

Ejecutar en modo normal:
youdl

Ejecutar en modo agil:
youdl "link" "formato"

Formatos:
1 = Descarga el video en MP4
2 = Descarga solo el audio en MP3
3 = Playlist: Descarga solo la cancion actual
4 = Playlist: Descarga la playlist completa
