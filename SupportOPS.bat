@echo off
title SupportOPS - Ferramenta de Suporte Profissional
color 0E
setlocal enabledelayedexpansion


:: ==========================================================
::            SupportOPS - Ferramenta Profissional
:: ==========================================================
:: Criado por:     Caua Philip Silva
:: Contato:        cphil.silva@outlook.com
:: Versão:         Agosto de 2025
:: ==========================================================

set "driverBackupPath=C:\DriverBackup"

:menu
cls
echo ============================================================
echo          Suporte Profissional - by Caua Philip Silva
echo ============================================================
echo [01] Verificar e Reparar Disco (CHKDSK)
echo [02] Reparar Arquivos de Sistema (SFC)
echo [03] Limpar Arquivos Temporarios
echo [04] Verificar Erros de Memoria (Diagnostico)
echo [05] Restaurar Sistema
echo [06] Testar Conectividade de Rede
echo [07] Gerenciar Processos
echo [08] Backup de Drivers
echo [09] Verificar Atualizacoes do Windows
echo [10] Informacoes do Sistema
echo [11] Limpar Cache DNS
echo [12] Reiniciar Servicos de Rede
echo [13] Desfragmentar Disco
echo [14] Gerenciar Usuarios Locais
echo [15] Verificar Integridade com DISM
echo [16] Ativar/Desativar Firewall
echo [17] Ver Logs de Eventos
echo [18] Testar Velocidade do Disco
echo [19] Criar Ponto de Restauracao
echo [20] Executar Comando Personalizado
echo [21] Gerenciar Aplicativos (Winget)
echo [22] Instalar Impressora pela Rede
echo [23] Abrir Politica de Seguranca Local
echo [24] Permitir/Negar Logon Local
echo [25] Reiniciar Spooler de Impressao
echo [S] Sair
echo ============================================================
set /p opcao="Digite a opcao desejada (1-25): "

if not defined opcao (
    echo.
    echo [ERRO] Nenhuma opcao selecionada. Digite um numero entre 1 e 25 ou 'S' para sair.
    pause
    set "opcao="
    goto menu
)

:: Chamar a função correspondente
if %opcao%==1  goto chkdsk
if %opcao%==2  goto sfc
if %opcao%==3  goto cleanup
if %opcao%==4  goto memory
if %opcao%==5  goto restore
if %opcao%==6  goto network
if %opcao%==7  goto taskmgr
if %opcao%==8  goto driverbackup
if %opcao%==9  goto updates
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
if %opcao%==22 goto addprinter
if %opcao%==23 goto secpol
if %opcao%==24 goto netuserlogon
if %opcao%==25 goto restartspooler
if /i "%opcao%"=="s" goto exit
if /i "%opcao%"=="S" goto exit

echo.
echo [ERRO] Opcao invalida! Digite um numero entre 1 e 25 ou 'S' para sair.
pause
set "opcao="
goto menu

:chkdsk
cls
echo Executando verificacao e reparo de disco...
chkdsk C: /f /r
pause
goto menu

:sfc
cls
echo Executando reparo de arquivos de sistema...
sfc /scannow
pause
goto menu

:cleanup
cls
echo Limpando arquivos temporarios...
del /q /f "%TEMP%\*" >nul 2>&1
echo Limpeza concluida!
pause
goto menu

:memory
cls
echo Abrindo Diagnostico de Memoria do Windows...
mdsched.exe
pause
goto menu

:restore
cls
echo Abrindo ferramenta de Restauracao do Sistema...
rstrui.exe
pause
goto menu

:network
cls
echo Verificando conectividade de rede...
ping google.com -n 4
echo.
echo Testando gateway padrao:
ipconfig | findstr "Gateway"
pause
goto menu

:taskmgr
cls
echo Abrindo Gerenciador de Tarefas...
taskmgr.exe
pause
goto menu

:driverbackup
cls
echo Realizando backup de drivers...
mkdir "%driverBackupPath%" >nul 2>&1
dism /online /export-driver /destination:"%driverBackupPath%"
echo Backup concluido em %driverBackupPath%
pause
goto menu

:updates
cls
echo Verificando atualizacoes do Windows...
wuauclt /detectnow /updatenow
echo Verificacao iniciada. Verifique no Windows Update.
pause
goto menu

:sysinfo
cls
echo Informacoes do sistema:
systeminfo
pause
goto menu

:dnscache
cls
echo Limpando Cache DNS...
ipconfig /flushdns
echo Cache DNS limpo com sucesso!
pause
goto menu

:netrestart
cls
echo Reiniciando servicos de rede...
netsh winsock reset
netsh int ip reset
echo Reinicio concluido! Reinicie o computador se necessario.
pause
goto menu

:defrag
cls
echo Executando desfragmentacao de disco...
defrag C: /O
pause
goto menu

:usermgmt
cls
echo Abrindo Gerenciador de Usuarios Locais...
lusrmgr.msc
pause
goto menu

:dism
cls
echo Verificando integridade da imagem do Windows...
dism /online /cleanup-image /restorehealth
pause
goto menu

:firewall
cls
echo Abrindo configuracoes do Firewall do Windows...
firewall.cpl
pause
goto menu

:eventlog
cls
echo Abrindo Visualizador de Eventos...
eventvwr.msc
pause
goto menu

:disktest
cls
echo Testando velocidade de disco...
winsat disk -drive C
pause
goto menu

:restorepoint
cls
echo Criando ponto de restauracao...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "SwissKnife_Ponto" , 100, 7
echo Ponto de restauracao criado com sucesso!
pause
goto menu

:customcmd
cls
echo Abrindo prompt de comando...
cmd.exe
pause
goto menu

:winget
where winget >nul 2>&1 || (
    echo Winget nao encontrado. Instale-o pela Microsoft Store ou habilite o App Installer.
    pause
    goto menu
)
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
set /p wingetopcao="Escolha uma opcao (1-5): "
if not defined wingetopcao goto winget

if %wingetopcao%==1 goto wingetlist
if %wingetopcao%==2 goto wingetsearch
if %wingetopcao%==3 goto wingetinstall
if %wingetopcao%==4 goto wingetupgrade
if %wingetopcao%==5 goto wingetuninstall
if %wingetopcao%==6 goto menu

echo Opcao invalida! Tente novamente.
pause
goto winget

:wingetlist
cls
echo Listando aplicativos instalados...
winget list
pause
goto winget

:wingetsearch
set /p appsearch="Digite o nome do aplicativo para procurar: "
if not defined appsearch goto winget
winget search "%appsearch%"
pause
goto winget

:wingetinstall
set /p appinstall="Digite o ID ou nome do aplicativo para instalar: "
if not defined appinstall goto winget
winget install "%appinstall%"
pause
goto winget

:wingetupgrade
cls
echo Atualizando todos os aplicativos...
winget upgrade --all
pause
goto winget

:wingetuninstall
set /p appuninstall="Digite o ID ou nome do aplicativo para desinstalar: "
if not defined appuninstall goto winget
winget uninstall "%appuninstall%"
pause
goto winget

:addprinter
cls
echo =======================================================
echo        INSTALACAO DE IMPRESSORA REMOTA - LISTAGEM     
echo =======================================================
set /p server="Digite o nome ou IP do servidor de impressao (ex: PrinterServer): "

if not defined server (
    echo Servidor invalido.
    call :log "Tentativa de instalação de impressora com nome de servidor vazio"
    pause
    goto menu
)

:: Testa conexão com o servidor
call :log "Testando acesso ao servidor \\%server%"
net view \\%server% >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Não foi possível acessar \\%server%.
    echo Verifique se o nome está correto ou se o servidor está acessível.
    call :log "Falha ao acessar \\%server% via net view"
    pause
    goto menu
)

:: Lista os compartilhamentos
call :log "Listando compartilhamentos do servidor \\%server%"
echo Compartilhamentos disponíveis em \\%server%:
net view \\%server% | findstr /R /C:"^[A-Za-z]"

echo.
set /p printername="Digite o nome da impressora compartilhada para instalar (ex: HP-Laser): "
if not defined printername (
    echo Nome de impressora invalido.
    call :log "Tentativa de instalação com nome de impressora vazio"
    pause
    goto menu
)

set "printerpath=\\%server%\%printername%"
call :log "Tentando instalar impressora: %printerpath%"
rundll32 printui.dll,PrintUIEntry /in /n "%printerpath%" >nul 2>&1

if !errorlevel! EQU 0 (
    echo Impressora instalada com sucesso: %printerpath%
    call :log "Impressora %printerpath% instalada com sucesso"
) else (
    echo [ERRO] Falha ao instalar impressora: %printerpath%
    echo Verifique se o nome está correto ou se você tem permissão.
    call :log "Erro ao instalar impressora: %printerpath%"
)

pause
goto menu

:secpol
cls
echo Politica de Seguranca Local
secpol.msc
pause
goto menu

:netuserlogon
cls
echo ===========================
echo Permitir/Negar Logon Local
echo ===========================
echo 1. Permitir Logon Local
echo 2. Negar Logon Local
echo 3. Listar Usuarios
echo 4. Voltar ao Menu Principal
echo ===========================
set /p logonopcao="Escolha uma opcao (1-3): "
if not defined logonopcao goto netuserlogon

if %logonopcao%== 1 goto allowllogonlocal
if %logonopcao%== 2 goto denylogonlocal
if %logonopcao%== 3 goto listusers
if %logonopcao%== 4 goto menu

echo Opcao invalida! Tente novamente.
pause
goto netuserlogon

:allowllogonlocal
cls
echo ========================================================================
set /p user="Digite o usuario que deseja permitir o logon local (ex: user1): "
echo ========================================================================
if not defined user goto netuserlogon
net user %user% /active:yes
echo Usuario agora pode logar de forma local
pause
goto netuserlogon

:denylogonlocal
cls
echo ===========================================================================
set /p user="Digite o usuario que deseja negar o logon local (ex: user1): "
echo ===========================================================================
if not defined user goto netuserlogon
net user %user% /active:no
echo Usuario negado para logar de forma local
pause
goto netuserlogon

:listusers
cls
echo =====================================================
echo                Usuarios Listados:
echo =====================================================
net user
pause
goto netuserlogon

:restartspooler
cls
echo =========================================================
echo             Reiniciar Spooler de Impressao
echo =========================================================
echo [1] Parar Spooler
echo [2] Iniciar Spooler
echo [3] Voltar
set /p spool="Opcao: "
if "%spool%"=="1" (
    net stop spooler
    call :log "Spooler parado"
) else if "%spool%"=="2" (
    net start spooler
    call :log "Spooler iniciado"
)
pause
goto menu
:exit
cls
echo Obrigado por usar o SupportOPS!
echo Suporte profissional com um toque de automacao.
pause
exit /b




