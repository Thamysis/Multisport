# 🏀 **Multisport – Onde Cada Jogo Importa**
**Plataforma de streaming para esportes alternativos.**

---

## **Descrição do Projeto**
**Multisport** é uma plataforma de streaming projetada para democratizar o acesso a esportes alternativos e modalidades pouco exibidas na TV aberta, como vôlei, handebol, natação, atletismo, esportes radicais e e-sports. O objetivo é oferecer uma experiência acessível e personalizada para fãs, atletas, clubes, escolas e ligas esportivas. Além disso, o sistema incentiva a prática esportiva e promove estilos de vida saudáveis.

O projeto implementa um banco de dados relacional robusto que centraliza informações sobre transmissões, eventos esportivos, usuários e outras entidades relacionadas. Ele foi desenvolvido utilizando **PostgreSQL** como sistema de gerenciamento de banco de dados e **Python** para a interface de interação.

---

## **Recursos Principais**

### **Usuários**
- Realizar auto-cadastro, consultar e atualizar informações pessoais.
- Diferenciação entre usuários:
  - **Comuns**: Assistem transmissões com anúncios personalizados.
  - **Premium**: Assistem transmissões sem anúncios.
  - **Administradores**: Gerenciam transmissões, usuários e comentários.

### **Transmissões**
- Associadas a esportes, eventos e qualidade (ex.: 720p, 1080p, 4K).
- Comentários de usuários, com remoção moderada por administradores.
- Disponíveis para busca com filtros como esporte, data, qualidade e popularidade.

### **Eventos Esportivos**
- Relacionados a instalações esportivas e esportes específicos.
- Associados a equipes e atletas.

### **Consultas Implementadas**
1. Lista de transmissões de vôlei.
2. Últimos 3 eventos assistidos por um usuário específico.
3. Próximas 3 transmissões de eventos esportivos de um time.
4. Usuários que assistiram a todas as transmissões.
5. Locais com maior número de eventos realizados.

---

## **Arquitetura do Banco de Dados**

### **Entidades Principais**
- **Usuário**: Inclui nome, e-mail, data de nascimento e tipo de conta (comum, premium, admin).
- **Transmissão**: Inclui número, link de vídeo, horário de início, duração, esporte e evento associado.
- **Evento Esportivo**: Inclui nome, data/hora e instalação esportiva.
- **Instalação Esportiva**: Inclui nome e localização (cidade, estado, país).
- **Comentário**: Associado a transmissões e usuários.
- **Time e Atleta**: Relacionam atletas a suas respectivas equipes.

### **Relações Importantes**
- **Transmissão-Usuário**: Relaciona transmissões assistidas por usuários.
- **Anúncio-Transmissão-Usuário**: Registra anúncios vistos por usuários.
- **Evento-Time**: Relaciona times aos eventos que disputam.

---

## **Requisitos do Sistema**
- **Banco de Dados**: PostgreSQL 17.2
- **Aplicação**: Python 3.11.0
- **Sistema Operacional**: Windows 10 ou superior
- **Dependências**: Biblioteca `psycopg2` para comunicação entre Python e PostgreSQL.
