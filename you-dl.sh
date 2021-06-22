#!/data/data/com.termux/files/usr/bin/zsh

#Author: l0gg3r
#Source: https://github.com/damian1421/youdl-bash
clear
LOG=$HOME/.youdl.log
if [ -f $LOG ]
then
	 touch $LOG
fi
PREVFOLDER=`pwd` #Define la ruta desde la cual se ha invocado youdl.
#Verificar si se ha declarado la ruta de descarga. || La declara en caso que no se haya definido.
if [ -f $HOME/.youdl.conf ]
then
	echo "No se ha detectado el archivo de configuración"
	echo "¿Cuál es tu sistema operativo?"
	echo "1- Termux"
	echo "2- Linux: Ubuntu, Debian, ..."
	echo "3- Windows + WSL"
	read OS
		case $OS in
			1)
			clear
			echo "Tus descargas se guardarán en:"
			echo "OUTFOLDER=/data/data/com.termux/files/home/storage/shared/YouDL" >> $HOME/.youdl.conf
			sh $HOME/.youdl.conf
			mkdir $OUTFOLDER
			echo $OUTFOLDER
			;;
			2)
			clear
			USER=`whoami`
			echo "Tus descargas se guardarán en:"
			echo "OUTFOLDER=/home/$USER/YouDL" >> $HOME/.youdl.conf
			sh $HOME/.youdl.conf
			mkdir $OUTFOLDER
			echo $OUTFOLDER
			;;
			3)
			clear
			USER=`whoami`
			echo "Tus descargas se guardarán en:"
			echo "OUTFOLDER=/mnt/c/Users/$USER/YouDL" >> $HOME/.youdl.conf
			sh $HOME/.youdl.conf
			mkdir $OUTFOLDER
			echo $OUTFOLDER
			;;
		esac
fi
DIA=`date +"%d/%m/%Y"`
HORA=`date +"%H:%M"`

#Set colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LGREY='\033[0;37m'
DGREY='\033[1;30m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LBLUE='\033[1;34m'
LPURPLE='\033[1;35m'
LCYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m' #No color

Title(){ #Sección título
echo ${YELLOW}"Descargar video/música de YOUTUBE (...y muchos sitios más)"${NC}
}

InfoAyuda(){ #Sección info ayuda, informa como abrir la ayuda
echo ${LGREY}"--help = Muestra la ayuda"${LBLUE}
}

#Help
if [ -z "$1" ]
then
	clear
	Title
	InfoAyuda
	echo Escribir el link del video:
	read link
else
	case $1 in
	--help)
		clear
		Title
        echo ""
        echo "*Para utilizar el modo ágil:"
        echo "Primero, registrar el alias en .bashrc"
        echo "alias youdl='$HOME/.you-dl.sh'"
        echo "Segundo, ejecutar el comando de este modo"
        echo "----------------------"
        echo "youdl 'link' 'formato'"
        echo "----------------------"
        echo "Formatos:"
        echo "1 = Descarga el video en MP4"
        echo "2 = Descarga solo el audio en MP3"
        echo "3 = Playlist: Descarga solo la canción actual"
        echo "4 = Playlist: Descarga la playlist completa"
		echo "5 = Actualizar"
		echo "6 = Instalar"
		echo "q = Salir"
	    sleep 20
		;;
	[qQ])
		clear
		echo "Se ha cancelado la descarga"
		echo "Saliendo..."
		exit 0
		;;
	esac
fi

#Verifies format included when you'd launched the program
if [ -z "$2" ]
then
	clear
	Title
	echo Elegir una opción:
	echo 1 = Descarga el video en MP4
	echo 2 = Descarga solo el audio en MP3
	echo 3 = Playlist: Descarga solo la canción actual
	echo 4 = Playlist: Descarga la playlist completa
	echo 5 = Actualizar aplicación
	echo 6 = Instalar YouDL
	echo --help = Ver ayuda
	echo q = Salir
	read INPUT
	case $INPUT in
		[qQ])
			clear
			echo "Saliendo del programa..."
			echo "Se ha cancelado la descarga!"
			exit 0
	esac
else
	INPUT=$2
fi

#Proceed to download link in selected format
case $INPUT in
	1)
		cd $OUTFOLDER
		youtube-dl $link -i --recode-video mp4
		cd $PREFOLDER
		;;
	2)
		cd $OUTFOLDER
		youtube-dl $link -i --extract-audio --audio-format mp3
		cd $PREVFOLDER
		;;
	3)
		cd $OUTFOLDER
		youtube-dl $link --no-playlist -i  --extract-audio --audio-format mp3 --audio-quality 0
		cd $PREVFOLDER
		;;
	4)
		cd $OUTFOLDER
		youtube-dl $link --yes-playlist -i  --extract-audio --audio-format mp3 --audio-quality 0
		cd $PREVFOLDER
		;;
	5)
		clear
		echo "Updating Youtube Downloader"
		youtube-dl -U
		;;
	6)
		clear
		echo "Installing Youtube Downloader"
		echo "Installing all prerrequisites"
		apt-get -y install zsh python ffmpeg python git wget
		STEP="Prerrequisites"
		echo [$?] $STEP
		echo [$?] $STEP >> $LOG
		pip install youtube-dl
		STEP="Install youtube-dl"
		echo [$?] $STEP
		echo [$?] $STEP >> $LOG
		echo "Cloning repository of YouDL"
        	git clone https://github.com/damian1421/youdl-bash
		STEP="Clone repository YouDL"
		echo [$?] $STEP
		echo [$?] $STEP >> $LOG
		echo "Setting up alias"
		echo "alias youdl=`pwd`/youdl-bash/you-dl.sh >> $HOME/.zshrc"
		STEP="Setting up .zshrc"
		echo [$?] $STEP
		echo [$?] $STEP >> $LOG
		echo "alias youdl=`pwd`/youdl-bash/you-dl.sh >> $HOME/.bashrc"
		STEP="Setting up .bashrc"
		echo [$?] $STEP
		echo [$?] $STEP >> $LOG
		echo "Installation finished!"
		;;
esac
