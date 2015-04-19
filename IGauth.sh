#!/bin/sh
# by ALASKA - 25/04/02 - #newlinux/#itapirados/#bhs/#m4f14/#linuxall/#slackware
# version 1.0
# Altamente recomendado ter o lynx... mas o links tb eh possivel, vai da uns pau ehhe... 
# Na prox versao vo por a opcao de postar por perl tb....

[ ! -e ~/.IGauth ] && { echo 'Execute o script de instalacao e tente novamente!';exit;}

# Tempo limite para tentar autenticar
timetw='10'

filel=(`cat ~/.IGauth/igauth`)
navg=${filel[0]}
login=${filel[1]}
senha=${filel[2]}

np='Conexao PPP nao encontrada.... Desativando IGauth+Crontab....'
if [ "$1" = '-out' ];then
[ -e /tmp/IGauth.pid ] && { logger "IGauth: Desativado";rm -f /tmp/IGauth.pid;}
[ -e $HOME/.ppprc ] && { rm -f ~/.ppprc;}
exit
fi
# problema q user no conectiva nao acessa o ifconfig 
#if [ "$(ifconfig ppp0 2> /dev/null)" ];then
if [ "$(cat /proc/net/dev|grep ppp0 2> /dev/null)" ];then
ac='Autenticacao Completa.....'
te="Tempo limite para a Autenticacao de $timetw Estourado...." 
cx='Chamada de identificacao executada pelo Crontab....'
if [ "$1" = '-check' ];then
[ -e /tmp/IGauth.pid ] && { logger "IGauth: $cx";} || { exit;}
fi
if [ $navg = lynx ];then
$HOME/.IGauth/timelimit $timetw lynx -dump "http://auth.ig.com.br:8000/servlets/autentica?action=login&url=&username=$login&password=$senha&x=0&y=0" 1> /dev/null && { logger "IGauth: $ac";touch /tmp/IGauth.pid;} || { logger $te;} 
exit
else
$HOME/.IGauth/timelimit $timetw links "http://auth.ig.com.br:8000/servlets/autentica?action=login&url=&username=$login&password=$senha&x=0&y=0" && { logger "IGauth: $ac";touch /tmp/IGauth.pid;} || { logger $te;}
exit
fi
else
logger "IGauth: $np"
rm -f /tmp/IGauth.pid
fi
