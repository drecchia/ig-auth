#!/bin/sh
# by ALASKA - 25/04/02 - #newlinux/#itapirados/#bhs/#m4f14/#linuxall/#slackware
# na hora q loga - IGauth.sh
# na hora q sai - IGauth.sh -out
cat << EOF

                  IGauth 1.0 - by ALASKA - alaska@fuckbillgates.org

       IGauth automatiza a identificacao da ig, qdo anexado ao kppp e/ou wvdial
fica ainda mais intuitivo e facil!! Uma entrada no crontab do usuario sera inserida
para que a cada hora, envie novamente a chave para ig, para nao haver quedas....
       O script automaticamente gera a entrada para o crontab, e auxilia voce
a adicionar a entrada no kppp e wvdial!!! 

ATENCAO: Todas as configuracoes feitas pelo script sao validas apenas para o usuario
         atual..... 
           Todas as mensagens serao reportadas para o log padrao do seu sistema

EOF
[ $(which links 2> /dev/null) ] && navg=links
[ $(which lynx 2> /dev/null) ] && navg=lynx
[ ! $navg ] && { echo 'Navegador nao encontrado..... instale o links ou lynx antes';exit;}
[ $(which logger 2> /dev/null) ] || { echo 'Binario logger nao encontrado.... ';exit;}
echo -n 'IG Login(Ex: alaska): ';read login
echo -n 'Senha: ';read senha
echo -n 'Telefone: ';read tel
mkdir ~/.IGauth 2> /dev/null
echo "$navg ${login:=ig} ${senha:=ig} ${tel:=0211938438000}" > ~/.IGauth/igauth
cp -f ./timelimit ./IGauth.sh ./usleep ./waiter.sh ~/.IGauth/
chmod +x ~/.IGauth/*
echo 'Adicionando entrada ao crontab......'
crontab -l > ./.cron.temp
if [ "$(cat ./.cron.temp|grep 'IGauth')" ];then 
rm -f ./.cron.temp
else
echo '# Inicio IGauth' >> ./.cron.temp
echo '1 * * * * $HOME/.IGauth/IGauth.sh -check' >> ./.cron.temp
echo '# Fim IGauth' >> ./.cron.temp
crontab ./.cron.temp && rm -f ./.cron.temp
fi
echo 'Deseja instalar Suporte para o wvdial usar o IGauth automaticamente?'
read mfoker
case $mfoker in
s|S|y|Y) ./IGauth.wvdial;;
*) : ;;
esac
echo -e '\nPara integrar com o kppp leia o README.kppp\n'

