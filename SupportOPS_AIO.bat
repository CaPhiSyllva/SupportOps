@echo off
title SupportOPS - AIO - Infra, Redes & CyberSec Jr.
color 0B
setlocal EnableDelayedExpansion

:: ===================== VERIFICAÇÃO DE ADMIN =====================
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERRO CRITICO] Execute como Administrador!
    echo Abra o CMD/PowerShell como admin e execute novamente.
    pause
    exit /b 1
)

:: ===================== CONTROLE DE CONCORRÊNCIA =====================
tasklist /FI "WINDOWTITLE eq SupportOPS*" | findstr /I "cmd.exe" >nul && (
    echo [ERRO] Programa ja em execucao!
    timeout 3
    exit
)

:: ===================== CONFIGURAÇÃO INICIAL =====================
set "driverBackupRoot=C:\DriverBackup"
set "logDir=C:\SupportOPS_AIOLogs"
set "tempOutput=%temp%\SupportOPS_temp.txt"

if not exist "%logDir%" mkdir "%logDir%"
if not exist "%driverBackupRoot%" mkdir "%driverBackupRoot%"

rem ---------------------- Sanitizar Data e Hora --------------------------
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
    set "dia=%%a"
    set "mes=%%b"
    set "ano=%%c"
)
set "logDate=%ano%-%mes%-%dia%"

set "hora=%time:~0,2%"
if "%hora:~0,1%"==" " set "hora=0%hora:~1,1%"
set "minuto=%time:~3,2%"
set "segundo=%time:~6,2%"
set "logTime=%hora%-%minuto%-%segundo%"

set "logFile=%logDir%\log_%logDate%_%logTime%.log"

call :log "=== SESSION STARTED ==="
call :log "Usuario: %USERNAME%"
call :log "Computador: %COMPUTERNAME%"

:: ===================== MENU PRINCIPAL =====================
:menu
cls
echo =======================================================
echo      SupportOPS - AIO - Ferramentas Corporativas de TI
echo             Infraestrutura - Redes - CyberSec
echo =======================================================
echo [DIAGNOSTICO]
echo  01. Verificar e Reparar Disco (CHKDSK)
echo  02. Reparar Arquivos do Sistema (SFC)
echo  03. Diagnostico de Memoria RAM
echo  04. Teste de Velocidade de Disco (WINSAT)
echo  05. Verificar Integridade com DISM
echo  06. Informacoes do Sistema

echo [REDES]
echo  07. Teste de Conectividade de Rede
echo  08. Limpar Cache DNS
echo  09. Reiniciar Stack de Rede (Winsock/IP)
echo  10. Instalar Impressora de Rede

echo [MANUTENCAO]
echo  11. Limpar Arquivos Temporarios
echo  12. Backup de Drivers (DISM)
echo  13. Buscar Atualizacoes do Windows
echo  14. Desfragmentar Disco (HDD apenas)
echo  15. Criar Ponto de Restauracao
echo  16. Restauracao do Sistema

echo [SEGURANCA]
echo  17. Hardening Avancado
echo  18. Configuracoes de Firewall
echo  19. Auditoria de Seguranca

echo [UTILITARIOS]
echo  20. Gerenciador de Tarefas
echo  21. Visualizar Logs de Eventos
echo  22. Gerenciar Usuarios Locais
echo  23. Gerenciar Softwares (WINGET)
echo  24. Abrir Terminal CMD (Manual)

echo [SAIR]
echo  25. Sair do Programa
echo =======================================================
set /p opcao=Escolha uma opcao (1-25): 
if not defined opcao goto menu

rem Redirecionamento
for /L %%i in (1,1,25) do (
    if "!opcao!"=="%%i" goto op%%i
)
echo [ERRO] Opcao invalida!
pause
goto menu

:: ===================== OPERAÇÕES =====================

:op1
cls
call :log "Executando CHKDSK na unidade C:"
echo [ATENCAO] Esta operacao requer reinicio. Agendar verificacao? (S/N)
set /p confirm=>
if /i "!confirm!"=="S" (
    chkdsk C: /f /r
    call :log "CHKDSK agendado para proximo boot"
    echo Verificacao agendada para o proximo reinicio.
) else (
    call :log "CHKDSK cancelado pelo usuario"
)
pause
goto menu

:op2
cls
call :log "Executando verificacao SFC (System File Checker)"
sfc /scannow
if %errorlevel% neq 0 (
    call :log "ERRO durante execucao do SFC"
    echo [FALHA] Problemas encontrados. Verifique log.
) else (
    call :log "SFC finalizado com sucesso"
)
pause
goto menu

:op3
cls
call :log "Diagnostico de RAM: mdsched"
start mdsched.exe
goto menu

:op4
cls
call :log "Teste de disco: winsat"
winsat disk -drive C: -v > "%logDir%\%computername%_diskspeed_%logDate%.log"
call :log "Resultado salvo em: %logDir%\%computername%_diskspeed_%logDate%.log"
echo Teste concluido. Resultados salvos nos logs.
pause
goto menu

:op5
cls
call :log "Executando DISM para integridade do sistema"
dism /online /cleanup-image /restorehealth
if %errorlevel% neq 0 (
    call :log "ERRO durante execucao do DISM"
    echo [FALHA] Problemas encontrados na imagem do sistema
) else (
    call :log "DISM executado com sucesso"
)
pause
goto menu

:op6
cls
call :log "Coletando informacoes do sistema"
systeminfo | more
pause
goto menu

:op7
cls
call :log "Executando teste de rede"
echo Testando conectividade basica:
ping google.com -n 4
echo.
echo Configuracao IP:
ipconfig | findstr /R /C:"IPv4" /C:"Gateway"
echo.
echo Testando DNS:
nslookup google.com
call :log "Teste de rede concluido"
pause
goto menu

:op8
cls
call :log "Limpando cache DNS"
ipconfig /flushdns
call :log "DNS flush realizado"
echo Cache DNS limpo com sucesso.
pause
goto menu

:op9
cls
call :log "Resetando stack de rede"
netsh winsock reset catalog
netsh int ip reset reset.log
call :log "Reset de rede completo"
echo Stack de rede reiniciada. Reinicie o computador.
pause
goto menu

:op10
goto op22

:op11
cls
call :log "Limpando arquivos temporarios"
del /q /f "%TEMP%\*" >nul 2>&1
del /q /f "%WINDIR%\Temp\*" >nul 2>&1
cleanmgr /sagerun:1 >nul
call :log "Limpeza de temporarios completa"
echo Arquivos temporarios removidos.
pause
goto menu

:op12
cls
call :log "Iniciando backup de drivers"
set "driverBackupPath=%driverBackupRoot%\Backup_%logDate%_%logTime%"
mkdir "%driverBackupPath%" >nul 2>&1
dism /online /export-driver /destination:"%driverBackupPath%"
if %errorlevel% neq 0 (
    call :log "ERRO no backup de drivers"
    echo [FALHA] Backup falhou! Verifique permissões.
) else (
    call :log "Backup salvo em: %driverBackupPath%"
    echo Backup concluido: %driverBackupPath%
)
pause
goto menu

:op13
cls
call :log "Forcando verificacao de atualizacoes"
wuauclt /detectnow /updatenow
call :log "Solicitacao de atualizacoes enviada"
echo Verificando atualizacoes... Confirme no Windows Update.
pause
goto menu

:op14
cls
call :log "Verificando tipo de disco para desfragmentacao"
fsutil fsinfo drivetype C: | find "SSD" >nul && (
    echo [INFO] SSD detectado! Desfragmentacao nao recomendada.
    call :log "Operacao cancelada: SSD detectado"
    pause
    goto menu
)
call :log "Iniciando desfragmentacao HDD"
defrag C: /O /U
call :log "Desfragmentacao concluida"
pause
goto menu

:op15
cls
call :log "Verificando espaco para ponto de restauracao"
for /f "tokens=3" %%a in ('fsutil volume diskfree C: ^| find "livre"') do set free=%%a
set /a freeMB=!free:~0,-6! / 1048576
if !freeMB! LSS 1024 (
    echo [ERRO] Espaco insuficiente (menos de 1GB livre)
    call :log "Espaco insuficiente para ponto de restauracao"
    pause
    goto menu
)
call :log "Criando ponto de restauracao"
wmic /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "SupportOPS_Ponto_%logDate%", 100, 7
if %errorlevel% neq 0 (
    call :log "FALHA ao criar ponto de restauracao"
    echo [ERRO] Nao foi possivel criar ponto de restauracao.
) else (
    call :log "Ponto de restauracao criado com sucesso"
    echo Ponto de restauracao criado!
)
pause
goto menu

:op16
cls
call :log "Abrindo restauracao do sistema"
start rstrui.exe
goto menu

:op17
goto op23

:op18
cls
call :log "Abrindo firewall"
start firewall.cpl
goto menu

:op19
goto audit_security

:op20
cls
call :log "Abrindo Gerenciador de Tarefas"
start taskmgr
goto menu

:op21
cls
call :log "Abrindo Visualizador de Eventos"
start eventvwr.msc
goto menu

:op22
cls
call :log "Abrindo Gerenciador de Usuarios"
start lusrmgr.msc
goto menu

:: ===================== MÓDULO WINGET =====================
:op23
cls
:winget_check
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo Winget nao encontrado. Instalando via Microsoft Store...
    call :log "Winget ausente - Abrindo Microsoft Store"
    start ms-windows-store://pdp/?productid=9NBLGGH4NNS1
    timeout 5
    goto winget_check
)

:winget_menu
cls
echo ========== WINGET - Gerenciador de Aplicativos ==========
echo 1. Listar Aplicativos Instalados
echo 2. Procurar Aplicativo Online
echo 3. Instalar Aplicativo
echo 4. Atualizar Todos os Aplicativos
echo 5. Desinstalar Aplicativo
echo 6. Voltar ao Menu Principal
echo ==========================================================
set /p wingetopcao=Escolha: 
if not defined wingetopcao goto winget_menu

if %wingetopcao%==1 (
    call :log "Listando apps via winget"
    winget list
    pause
    goto winget_menu
)

if %wingetopcao%==2 (
    set /p appsearch="Nome do app: "
    call :log "Pesquisando: %appsearch%"
    winget search "%appsearch%"
    pause
    goto winget_menu
)

if %wingetopcao%==3 (
    set /p appinstall="ID ou nome do app: "
    call :log "Instalando: %appinstall%"
    winget install --id "%appinstall%" --silent --accept-package-agreements
    if %errorlevel% neq 0 (
        call :log "FALHA na instalacao: %appinstall%"
        echo [ERRO] Instalacao falhou. Verifique o ID.
    ) else (
        call :log "Instalado com sucesso: %appinstall%"
    )
    pause
    goto winget_menu
)

if %wingetopcao%==4 (
    call :log "Atualizando todos os apps"
    winget upgrade --all --silent
    pause
    goto winget_menu
)

if %wingetopcao%==5 (
    set /p appuninstall="Nome do app: "
    call :log "Desinstalando: %appuninstall%"
    winget uninstall "%appuninstall%"
    pause
    goto winget_menu
)

if %wingetopcao%==6 goto menu
echo Opcao invalida!
pause
goto winget_menu

:: ===================== IMPRESSORA REMOTA =====================
:op22
cls
echo ========== Instalacao de Impressora de Rede ==========
:get_server
set /p "server=Nome/IP do servidor (ex: SRV-PRN01): "
echo %server% | findstr /R /C:"[;&|<>]" >nul && (
    echo [ERRO] Caracteres invalidos detectados!
    goto get_server
)

call :log "Testando acesso a \\%server%"
ping -n 2 %server% >nul || (
    call :log "Falha de ping em %server%"
    echo [ERRO] Servidor inacessivel!
    pause
    goto menu
)

echo Compartilhamentos disponiveis:
net view \\%server% | findstr /R /C:"^ [A-Z]"

:get_printer
set /p "printername=Nome da impressora (ex: HP-LaserJET): "
echo %printername% | findstr /R /C:"[;&|<>]" >nul && (
    echo [ERRO] Caracteres invalidos!
    goto get_printer
)

set "printerpath=\\%server%\%printername%"
call :log "Instalando: %printerpath%"
rundll32 printui.dll,PrintUIEntry /in /n "%printerpath%" /q

if %errorlevel% neq 0 (
    call :log "FALHA na instalacao: %printerpath%"
    echo [ERRO] Verifique nome e permissões!
) else (
    call :log "Impressora instalada: %printerpath%"
    echo Instalacao concluida!
)
pause
goto menu

:: ===================== HARDENING AVANÇADO =====================
:op23
cls
echo ================== Hardening Avancado ==================
echo 1. Politicas de Senha e Contas
echo 2. Desabilitar Servicos Vulneraveis
echo 3. Configurar Firewall Restritivo
echo 4. Ativar Auditoria de Seguranca
echo 5. Configuracoes Adicionais de Seguranca
echo 6. Voltar
echo =========================================================
set /p hardop=Escolha: 
if not defined hardop goto op23

if "%hardop%"=="1" goto hard_password
if "%hardop%"=="2" goto hard_services
if "%hardop%"=="3" goto hard_firewall
if "%hardop%"=="4" goto audit_security
if "%hardop%"=="5" goto hard_additional
if "%hardop%"=="6" goto menu

echo Opcao invalida!
pause
goto op23

:hard_password
call :log "Aplicando politicas de senha"
(
    echo [Unicode]
    echo Unicode=yes
    echo [System Access]
    echo MinimumPasswordLength = 12
    echo PasswordComplexity = 1
    echo MaximumPasswordAge = 30
    echo MinimumPasswordAge = 1
    echo PasswordHistorySize = 5
    echo LockoutBadCount = 5
    echo ResetLockoutCount = 30
    echo LockoutDuration = 30
    echo [Registry Values]
    echo MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableCAD=4,0
) > %temp%\secedit.inf

secedit /configure /db %temp%\secedit.sdb /cfg %temp%\secedit.inf /areas SECURITYPOLICY
del %temp%\secedit.inf
del %temp%\secedit.sdb

net accounts /minpwlen:12 /maxpwage:30 /minpwage:1 /uniquepw:5
call :log "Politicas de senha aplicadas"
echo Politicas atualizadas com sucesso!
pause
goto op23

:hard_services
call :log "Desabilitando servicos vulneraveis"
sc config TlntSvr start= disabled >nul
sc stop TlntSvr >nul 2>&1
sc config SessionEnv start= disabled >nul
sc config RemoteRegistry start= disabled >nul
sc stop RemoteRegistry >nul 2>&1
sc config SSDPSRV start= disabled >nul
sc config upnphost start= disabled >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f >nul

call :log "Servicos desabilitados: Telnet, Remote Registry, UPnP, RDP"
echo Servicos vulneraveis desativados!
pause
goto op23

:hard_firewall
call :log "Configurando firewall restritivo"
netsh advfirewall set allprofiles state on
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound
netsh advfirewall set allprofiles logging filename %SystemRoot%\system32\LogFiles\Firewall\pfirewall.log
netsh advfirewall set allprofiles logging maxfilesize 32767
netsh advfirewall set allprofiles logging droppedconnections enable
netsh advfirewall set allprofiles logging allowedconnections enable

call :log "Firewall configurado: Block Inbound/Allow Outbound"
echo Firewall restritivo aplicado!
pause
goto op23

:audit_security
call :log "Configurando auditoria de seguranca"
auditpol /clear /y
auditpol /set /subcategory:"Logon" /success:enable /failure:enable
auditpol /set /subcategory:"Account Management" /success:enable /failure:enable
auditpol /set /subcategory:"Detailed Tracking" /success:enable
auditpol /set /subcategory:"Policy Change" /success:enable /failure:enable
auditpol /set /subcategory:"Privilege Use" /failure:enable
auditpol /set /subcategory:"System" /failure:enable

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v VerboseStatus /t REG_DWORD /d 1 /f
call :log "Politicas de auditoria configuradas"
echo Auditoria de seguranca ativada!
pause
goto op23

:hard_additional
call :log "Aplicando hardening adicional"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymous /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer" /v AlwaysInstallElevated /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 255 /f

call :log "Hardening adicional aplicado"
echo Configuracoes de seguranca adicionais aplicadas!
pause
goto op23

:op24
call :log "Abrindo prompt CMD (modo manual)"
cmd.exe
call :log "Prompt CMD encerrado"
pause
goto menu
:: ===================== SAIR =====================
:op25
cls
call :log "=== SESSION ENDED ==="
echo Obrigado por utilizar o SupportOPS - AIO.
echo Suporte Profissional com Automacao e Rastreamento.
echo Logs disponiveis em: %logDir%
pause
exit /b

:: ===================== LOGGING AVANÇADO =====================
:log
setlocal
set "timestamp=%date% %time%"
>> "%logFile%" echo [!timestamp!] [%COMPUTERNAME%] [%USERNAME%] %~1
endlocal
goto :eof