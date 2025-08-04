#  SupportOPS - AIO

**Versão atual: v1.0**  
**Autor:** Caua Philip Silva  
**Contato:** cphil.silva@outlook.com  
**Data de criação:** Agosto de 2025  

---

##  Sobre o Projeto

O **SupportOPS - AIO** é um script `.bat` profissional e automatizado que centraliza ferramentas críticas de suporte técnico em um único painel interativo de linha de comando. Inspirado no conceito de um *canivete suíço para TI*, este projeto visa **otimizar tarefas rotineiras**, **padronizar ações de suporte** e **registrar logs de cada operação** para maior rastreabilidade.

---

##  Objetivo

Automatizar e facilitar a vida do analista de suporte técnico — especialmente em ambientes de campo, help desk, service desk ou infraestrutura — com **comandos seguros, rápidos e eficazes**.

---

##  Funcionalidades

| Nº | Função                                         | Descrição |
|----|------------------------------------------------|-----------|
| 1  | Verificar e Reparar Disco (`CHKDSK`)           | Corrige setores defeituosos no HD/SSD. |
| 2  | Reparar Arquivos de Sistema (`SFC`)            | Verifica e repara arquivos corrompidos do Windows. |
| 3  | Limpeza de Temporários                         | Remove arquivos temporários do sistema. |
| 4  | Diagnóstico de Memória                         | Abre a ferramenta `mdsched.exe`. |
| 5  | Restaurar Sistema                              | Abre o restaurador padrão do Windows. |
| 6  | Teste de Rede                                  | Faz ping e exibe gateway atual. |
| 7  | Abrir Gerenciador de Tarefas                   | Acesso rápido ao `taskmgr.exe`. |
| 8  | Backup de Drivers                              | Exporta drivers via `DISM`. |
| 9  | Buscar Atualizações do Windows                 | Força o Windows Update. |
| 10 | Informações do Sistema                         | Exibe `systeminfo`. |
| 11 | Limpar Cache DNS                               | Comando `ipconfig /flushdns`. |
| 12 | Reiniciar Serviços de Rede                     | Executa `netsh` para correção de rede. |
| 13 | Desfragmentação de Disco                       | Otimiza discos com `defrag`. |
| 14 | Gerenciar Usuários Locais                      | Abre o `lusrmgr.msc`. |
| 15 | Verificar Integridade com `DISM`               | Executa `DISM /restorehealth`. |
| 16 | Gerenciar Firewall                             | Acesso ao painel do Firewall do Windows. |
| 17 | Ver Logs de Eventos                            | Abre o `eventvwr.msc`. |
| 18 | Testar Velocidade de Disco                     | Usa `winsat disk` para benchmark. |
| 19 | Criar Ponto de Restauração                     | Cria snapshot do sistema. |
| 20 | Executar CMD Manual                            | Shell administrativa personalizada. |
| 21 | Gerenciar Aplicativos com Winget               | Instalar, atualizar e remover apps via `winget`. |
| 22 | Sair                                           | Encerra o script com log. |

---

##  Estrutura de Pastas e Logs

- Os logs de cada execução são salvos automaticamente em:  
  `C:\SwissKnifeLogs\log_DATA-HORA.log`  

- Diretório de backup de drivers (padrão):  
  `C:\DriverBackup`

---

##  Requisitos

- Sistema: **Windows 10/11 (com privilégios de administrador)**
- Winget habilitado para funcionalidades de gerenciamento de aplicativos
- Execução via terminal com **elevado (Run as Administrator)**

---

##  Como Usar

1. Clique com o botão direito no script `SupportOPS-AIO.bat` e selecione **Executar como Administrador**.
2. Navegue pelo menu numérico conforme necessidade.
3. Toda operação é registrada em log automaticamente.
4. Para comandos personalizados, use a opção 20.

---

##  Segurança

- O script não realiza alterações destrutivas sem confirmação explícita.
- Recomendado para ambientes corporativos, técnicos de suporte e profissionais autônomos de TI.

---

##  Roadmap (Futuras Implementações)

- [ ] Modo silencioso para execução via linha de comando (parâmetros CLI)
- [ ] Validação de integridade de arquivos de log
- [ ] Exportação em `.txt` ou `.csv` das informações do sistema

---

##  Diferenciais

 Interface clara e objetiva  
 Modular e fácil de manter  
 Log automático de todas as execuções  
 Otimizado para analistas de suporte e infraestrutura  
 100% offline — não depende de scripts externos

---

##  Contribuição

Se desejar contribuir com melhorias, novas funções ou internacionalização do script, sinta-se à vontade para abrir uma issue ou pull request.

---

##  Licença

Este projeto é de código aberto, licenciado sob os termos da **MIT License**.

---

##  Agradecimentos

Este projeto foi idealizado para auxiliar profissionais de TI que, como eu, vivem na linha de frente resolvendo problemas antes mesmo que o usuário perceba.

_"Automatizar não é substituir — é multiplicar sua produtividade."_  
— **Caua Philip Silva**

---

