@echo off
title SupportOPS - AIO
color 0B
setlocal EnableDelayedExpansion

rem ********************************************************
rem * Criado por Caua Philip Silva                         *
rem * SupportOPS -AIO - Professional                       *
rem * Data de criacao: Agosto de 2025                      *
rem * Contato: cphil.silva@outlook.com                     *
rem ********************************************************

set "driverBackupPath=C:\DriverBackup"
set "logPath=C:\SwissKnifeLogs"
if not exist "%logPath%" mkdir "%logPath%"
set "logFile=%logPath%\log_%DATE:/=-%_%TIME::=-%.log"

:menu
cls
echo =======================================================
echo           SupportOPS - AIO  - Ferramentas de TI
echo             Criado por Caua Philip Silva
echo =======================================================
echo  1.  Verificar e Reparar Disco (CHKDSK)
echo  2.  Reparar Arquivos de Sistema (SFC)
echo  3.  Limpar Arquivos Temporarios
echo  4.  Verificar Erros de Memoria (Diagnostico)
echo  5.  Restaurar Sistema
echo  6.  Verificar Conectividade de Rede (Ping/Teste)
echo  7.  Gerenciar Processos
echo  8.  Backup de Drivers
echo  9.  Verificar Atualizacoes do Windows
echo 10.  Informacoes do Sistema
echo 11.  Limpar Cache DNS 
echo 12.  Reiniciar Servicos de Rede
echo 13.  Desfragmentar Disco
echo 14.  Gerenciar Usuarios Locais
echo 15.  Verificar Integridade de Arquivos (DISM)
echo 16.  Ativar/Desativar Firewall do Windows
echo 17.  Verificar Logs de Eventos
echo 18.  Testar Velocidade de Disco
echo 19.  Criar Ponto de Restauracao
echo 20.  Executar Comando Personalizado (CMD)
echo 21.  Gerenciar Aplicativos com Winget
echo 22.  Sair
echo =======================================================

set /p opcao=Escolha uma opcao (1-22): 
if not defined opcao goto menu

if %opcao%==1 goto chkdsk
if %opcao%==2 goto sfc
if %opcao%==3 goto cleanup
if %opcao%==4 goto memory
if %opcao%==5 goto restore
if %opcao%==6 goto network
if %opcao%==7 goto taskmgr
if %opcao%==8 goto driverbackup
if %opcao%==9 goto updates
if %opcao%==10 goto sysinfo
if %opcao%==11 goto dnscache
if %opcao%==12 goto netrestart
if %opcao%==13 goto defrag
if %opcao%==14 goto usermgmt
if %opcao%==15 goto dism
if %opcao%==16 goto firewall
if %opcao%==17 goto eventlog
if %opcao%==18 goto disktest
if %opcao%==19 goto restorepoint
if %opcao%==20 goto customcmd
if %opcao%==21 goto winget
if %opcao%==22 goto exit
echo Opcao invalida! Tente Novamente.
pause
goto menu

:chkdsk
cls
call :log "Executando CHKDSK na unidade C:"
chkdsk C: /f /r
call :log "CHKDSK finalizado"
pause
goto menu

:sfc
cls
call :log "Executando SFC para reparar arquivos de sistema"
sfc /scannow
call :log "SFC concluído"
pause
goto menu

:cleanup
cls
call :log "Limpando arquivos temporários"
del /q /f "%TEMP%\*" >nul 2>&1
echo Limpeza concluida!
call :log "Arquivos temporários removidos"
pause
goto menu

:memory
cls
call :log "Executando Diagnóstico de Memória"
mdsched.exe
pause
goto menu

:restore
cls
call :log "Abrindo ferramenta de Restauração do Sistema"
start rstrui.exe
pause
goto menu

:network
cls
call :log "Verificando conectividade de rede"
ping google.com -n 4
ipconfig | findstr "Gateway"
call :log "Teste de rede finalizado"
pause
goto menu

:taskmgr
cls
call :log "Abrindo Gerenciador de Tarefas"
start taskmgr.exe
pause
goto menu

:driverbackup
cls
call :log "Iniciando backup de drivers"
mkdir "%driverBackupPath%" >nul 2>&1
dism /online /export-driver /destination:"%driverBackupPath%"
call :log "Backup de drivers concluído em %driverBackupPath%"
pause
goto menu

:updates
cls
call :log "Verificando atualizações do Windows"
wuauclt /detectnow /updatenow
call :log "Verificação de atualização iniciada"
pause
goto menu

:sysinfo
cls
call :log "Obtendo informações do sistema"
systeminfo
pause
goto menu

:dnscache
cls
call :log "Limpando cache DNS"
ipconfig /flushdns
call :log "Cache DNS limpo"
pause
goto menu

:netrestart
cls
call :log "Reiniciando serviços de rede"
netsh winsock reset 
netsh int ip reset
call :log "Serviços de rede reiniciados"
pause
goto menu

:defrag
cls
call :log "Executando desfragmentação do disco"
defrag C: /O
call :log "Desfragmentação finalizada"
pause
goto menu

:usermgmt
cls
call :log "Abrindo Gerenciador de Usuários Locais"
start lusrmgr.msc
pause
goto menu

:dism
cls
call :log "Executando DISM para restaurar integridade do sistema"
dism /online /cleanup-image /restorehealth
call :log "DISM finalizado"
pause
goto menu

:firewall
cls
call :log "Abrindo configurações do Firewall do Windows"
start firewall.cpl
pause
goto menu

:eventlog
cls
call :log "Abrindo Visualizador de Eventos"
start eventvwr.msc
pause
goto menu

:disktest
cls
call :log "Executando teste de velocidade do disco com WINSAT"
winsat disk -drive C
call :log "Teste de disco finalizado"
pause
goto menu

:restorepoint
cls
call :log "Criando ponto de restauração"
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "SwissKnife_Ponto" , 100, 7
call :log "Ponto de restauração criado com sucesso"
pause
goto menu

:customcmd
cls
call :log "Executando CMD manual pelo usuário"
cmd.exe
call :log "CMD finalizado"
pause
goto menu

:winget
cls
where winget >nul 2>&1 || (
    call :log "Winget não encontrado"
    echo Winget nao encontrado. Instale-o pela Microsoft Store ou habilite o App Installer.
    pause
    goto menu
)
:wingetmenu
cls
echo ======================================================
echo       GERENCIADOR DE APLICATIVOS COM WINGET
echo ======================================================
echo 1. Listar aplicativos instalados
echo 2. Procurar por um aplicativo
echo 3. Instalar um aplicativo 
echo 4. Atualizar todos os aplicativos 
echo 5. Desinstalar um aplicativo
echo 6. Voltar ao Menu Principal
echo ======================================================
set /p wingetopcao=Escolha uma opcao (1-6):
if not defined wingetopcao goto wingetmenu

if %wingetopcao%==1 goto wingetlist
if %wingetopcao%==2 goto wingetsearch
if %wingetopcao%==3 goto wingetinstall
if %wingetopcao%==4 goto wingetupgrade
if %wingetopcao%==5 goto wingetuninstall
if %wingetopcao%==6 goto menu
echo Opcao invalida! Tente novamente.
pause
goto wingetmenu

:wingetlist
cls
call :log "Listando aplicativos via Winget"
winget list
pause
goto wingetmenu

:wingetsearch
cls
set /p appsearch=Digite o nome do aplicativo para procurar: 
if not defined appsearch goto wingetmenu
call :log "Procurando aplicativo: %appsearch%"
winget search "%appsearch%"
pause
goto wingetmenu

:wingetinstall
cls
set /p appinstall=Digite o ID ou nome do aplicativo para instalar:
if not defined appinstall goto wingetmenu
call :log "Instalando aplicativo: %appinstall%"
winget install "%appinstall%"
call :log "Instalação de %appinstall% finalizada"
pause
goto wingetmenu

:wingetupgrade
cls
call :log "Atualizando todos os aplicativos via Winget"
winget upgrade --all
call :log "Atualização concluída"
pause
goto wingetmenu

:wingetuninstall
cls
set /p appuninstall=Digite o ID ou nome do aplicativo para desinstalar:
if not defined appuninstall goto wingetmenu
call :log "Desinstalando aplicativo: %appuninstall%"
winget uninstall "%appuninstall%"
call :log "Desinstalação de %appuninstall% finalizada"
pause
goto wingetmenu

:exit
cls
call :log "Usuário saiu do SupportOPS - AIO"
echo Obrigado por usar o SupportOPS - AIO!
echo Suporte profissional com um toque de automacao.
pause
exit /b

:log
rem %1 = mensagem para log
setlocal EnableDelayedExpansion
set "timestamp=!DATE! !TIME!"
echo [!timestamp!] %~1 >> "!logFile!"
endlocal
goto :eof
