#  SupportOPS - Ferramenta de Suporte Profissional

**Autor:** Caua Philip Silva
**Versão:** Agosto de 2025
**Contato:** [cphil.silva@outlook.com](mailto:cphil.silva@outlook.com)

---

##  Descrição

O **SupportOPS** é um utilitário de linha de comando (.BAT) voltado para analistas de suporte técnico, infraestrutura, redes e cibersegurança. Ele oferece um **painel de automação profissional** com dezenas de funcionalidades de diagnóstico, manutenção, segurança e administração de sistemas Windows, centralizadas em um único script interativo e modular.

---

##  Objetivo

* Automatizar tarefas comuns de suporte e infraestrutura
* Reduzir tempo de atendimento e intervenção manual
* Padronizar procedimentos técnicos
* Oferecer uma ferramenta portátil, prática e robusta
* Funcionar sem necessidade de dependências externas

---

##  Requisitos

* Windows 10/11 (com permissões administrativas)
* PowerShell 5.0+ (pré-instalado por padrão no Windows)
* `winget` instalado (para funcionalidades de gerenciamento de aplicativos)
* Acesso à rede (para algumas funções como instalação de impressoras remotas)

---

##  Menu Principal

Ao executar o script, você verá um menu com 25 opções. Cada item ativa uma função específica:

| Código | Função                             | Descrição                                                             |
| ------ | ---------------------------------- | --------------------------------------------------------------------- |
| 01     | Verificar e Reparar Disco (CHKDSK) | Executa `chkdsk C: /f /r`                                             |
| 02     | Reparar Arquivos de Sistema (SFC)  | Executa `sfc /scannow`                                                |
| 03     | Limpar Arquivos Temporários        | Remove arquivos em `%TEMP%`                                           |
| 04     | Diagnóstico de Memória             | Abre o diagnóstico do Windows (`mdsched.exe`)                         |
| 05     | Restaurar Sistema                  | Abre a ferramenta de restauração (`rstrui.exe`)                       |
| 06     | Testar Conectividade de Rede       | Pinga `google.com` e exibe gateway                                    |
| 07     | Gerenciar Processos                | Abre o Gerenciador de Tarefas                                         |
| 08     | Backup de Drivers                  | Exporta drivers via `DISM` para `C:\DriverBackup`                     |
| 09     | Verificar Atualizações do Windows  | Força verificação via `wuauclt`                                       |
| 10     | Informações do Sistema             | Mostra `systeminfo`                                                   |
| 11     | Limpar Cache DNS                   | Executa `ipconfig /flushdns`                                          |
| 12     | Reiniciar Serviços de Rede         | Reinicia `Winsock` e `IP Stack`                                       |
| 13     | Desfragmentar Disco                | Executa `defrag C: /O`                                                |
| 14     | Gerenciar Usuários Locais          | Abre `lusrmgr.msc`                                                    |
| 15     | Verificar Integridade com DISM     | Executa `dism /online /cleanup-image /restorehealth`                  |
| 16     | Ativar/Desativar Firewall          | Abre `firewall.cpl`                                                   |
| 17     | Ver Logs de Eventos                | Abre o Visualizador de Eventos (`eventvwr.msc`)                       |
| 18     | Testar Velocidade do Disco         | Executa `winsat disk -drive C`                                        |
| 19     | Criar Ponto de Restauração         | Cria restore point via `wmic`                                         |
| 20     | Executar Comando Personalizado     | Abre `cmd.exe`                                                        |
| 21     | Gerenciar Aplicativos com Winget   | Interface para instalar, listar, buscar e atualizar apps via `winget` |
| 22     | Instalar Impressora Remota         | Instala impressoras compartilhadas de um servidor de rede             |
| 23     | Abrir Política de Segurança Local  | Abre `secpol.msc`                                                     |
| 24     | Permitir ou Negar Logon Local      | Ativa ou desativa conta para logon local (`net user /active`)         |
| 25     | Reiniciar o Spooler de Impressão   | Ativa ou desativa o spooler de impressão                              |
| 26     | Sair                               | Encerra o utilitário                                                  |

---

##  Impressora Remota - Instalação

Este recurso permite listar e instalar impressoras de um servidor de impressão remoto:

**Passos:**

1. Informe o nome do servidor (ex: `PrinterServer`)
2. O script verifica a conectividade
3. Lista os compartilhamentos ativos
4. Solicita o nome da impressora (ex: `HP-Laser`)
5. Executa a instalação automática via `rundll32 printui.dll`

Logs são gerados em segundo plano para rastreabilidade e depuração.

---

##  Winget - Gerenciador de Aplicações

Se o `winget` estiver disponível, você poderá:

* **Listar** aplicativos instalados
* **Buscar** por novos apps
* **Instalar** via ID ou nome
* **Atualizar** todos os apps (`--all`)
* **Desinstalar** aplicativos existentes

> Caso o `winget` não esteja instalado, o script notificará e voltará ao menu principal.

---

##  Permitir ou Negar Logon Local

Uma funcionalidade essencial para ambientes corporativos. Ela permite:

* Ativar (`/active:yes`) ou desativar (`/active:no`) o login de um usuário local
* Listar todos os usuários do sistema

---

##  Logs (planejado)

Trechos do script fazem uso de uma função `:log`, que pode ser implementada para gravar logs de atividades em arquivos `.log`, caso deseje versionar ou auditar os comandos executados.

Exemplo de implementação futura:

```batch
:log
echo [%date% %time%] %~1 >> "%~dp0\logs\SupportOPS.log"
exit /b
```

---

##  Customizações Futuras

* Integração com PowerShell para funcionalidades mais avançadas
* Modo "Diagnóstico Completo"
* Log de sessão automática
* Interface com GUI (usando PowerShell ou Python)
* Suporte a rede corporativa (Active Directory, GPO, etc.)

---

##  Considerações

* Execute o script como **Administrador**
* Algumas funções exigem conectividade com a internet
* Uso recomendado por profissionais de TI, suporte, redes e segurança

---

##  Execução

Para rodar o script:

1. Salve como `SupportOPS.bat`
2. Clique com o botão direito e selecione **"Executar como administrador"**

---

##  Licença

Este projeto é de uso pessoal e profissional livre, desde que mantidos os créditos ao autor original.
