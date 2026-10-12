# 🏥 Hospital Data Platform (HDP) - dbt Core & Snowflake

## 📌 Contexto de Negócio e Desafio

Você foi contratado  pelo corpo diretivo de uma grande rede hospitalar internacional. Historicamente, o hospital armazena todo o histórico de internações, prontuários, dados de faturamento e informações do corpo clínico em sistemas legados altamente fragmentados. 

Recentemente, a equipe de TI realizou o carregamento da tabela bruta consolidada de registros de saúde (`RAW_HEALTHCARE_DATA`) diretamente na camada de *Landing Zone* do **Snowflake** (proveniente do ecossistema [Kaggle Healthcare Dataset](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)).

O grande desafio da instituição é que os dados brutos chegaram de forma completamente "achatada" (tabela única), com sérios problemas de qualidade de dados (nomes de pacientes e médicos com letras maiúsculas e minúsculas misturadas, ausência de IDs únicos e inconsistências de tipos de dados, como campos financeiros e datas armazenados como texto) e posteriormente automtizar essa ingestão de dados. 

---

## 🎯 O Propósito do Projeto e Benefícios 

Para mitigar esses riscos e estruturar uma arquitetura moderna de dados, foi solicitada a implementação do **dbt Core (Data Build Tool)** acoplado ao Snowflake. O objetivo do dbt neste projeto é garantir:

* **Modularidade e Arquitetura Limpa:** Divisão clara do pipeline em camadas lógicas: *Staging* (limpeza), *Intermediate* (transformação e enriquecimento) e *Marts* (tabelas de negócio prontas para consumo).
* **Idempotência e Performance:** Migração da carga pesada de recriação de tabelas para uma estratégia **Incremental**, otimizando o tempo de processamento e reduzindo os custos operacionais de créditos no Snowflake.
* **Cultura DRY (Don't Repeat Yourself):** Utilização de macros reaproveitáveis (como `dbt_utils`) para geração automática de chaves substitutas (*Surrogate Keys* via criptografia MD5), eliminando códigos redundantes.
* **Garantia e Governança de Dados:** Implementação de testes automatizados (singulares e genéricos) para barrar dados corrompidos antes que eles cheguem aos tomadores de decisão.

---

## 🏗️ Arquitetura e Linhagem de Dados (Data Lineage)

A arquitetura do projeto segue rigorosamente a modelagem dimensional (*Star Schema*) recomendada pela dbt Labs:

1. **Source (HOSPITAL_DB.RAW):** Ingestão do arquivo CSV bruto com registros estruturados de saúde.
2. **Staging Layer (`stg_`):** Views responsáveis pelo *casting* explícito de tipos (datas, inteiros e decimais financeiros), aplicação de `TRIM` para remoção de ruídos textuais e criação das chaves primárias.
3. **Marts Layer (`dim_` / `fct_`):** Tabelas físicas otimizadas para ferramentas de BI. A tabela fato (`fct_admissions`) atua como o motor central conectando-se às dimensões de pacientes e médicos.

---

## 📊 Perguntas de Negócio Respondidas (Analytics Ready)

Esta modelagem robusta foi desenhada especificamente para que as ferramentas de visualização. consumam dados agregados performáticos e respondam a três vertentes críticas do hospital:

### 1. Vertente Clínica: Eficiência Operacional
* *Pergunta:* Qual é a gravidade das doenças tratadas e como isso impacta o tempo de internação dos pacientes?
* *Solução:* Cruzamento da tabela fato com dados de mapeamento estático (*Seeds*) para identificar o nível de severidade e cálculo dinâmico da métrica **Length of Stay (LOS)** em dias.

### 2. Vertente Financeira: Auditoria e Receita
* *Pergunta:* Qual operadora de plano de saúde (*Insurance Provider*) gera o maior faturamento para o hospital e qual a média de gasto por paciente?
* *Solução:* Modelagem da métrica `billing_amount` com alta precisão decimal e classificação automática das contas em faixas de custo (Alto, Médio e Baixo) via macros customizadas.

### 3. Vertente de Qualidade e Compliance (Auditoria Médica)
* *Pergunta:* Existem falhas operacionais ou erros de input de dados no sistema, como pacientes que receberam alta antes da data de internação?
* *Solução:* Criação de testes singulares de negócios no dbt (`assert_discharge_is_after_admission`) que barram e notificam o time de engenharia caso o Snowflake encontre anomalias cronológicas de internação.

---

## 🚀 Como Executar o Projeto

1. Instale as dependências e pacotes necessários:
   ```bash
   dbt deps



   ## 🚀 Visão de Futuro: Data Intelligence & IA Generativa com Governança

O próximo marco evolutivo desta plataforma de dados é a integração de um motor de **IA Generativa (LLM)** via Snowflake Cortex ou LangChain, permitindo que diretores e médicos façam perguntas em linguagem natural (ex: *"Qual foi o faturamento do plano da Aetna no mês passado?"*) e recebam respostas imediatas em texto e gráficos.

Para garantir um nível de governança corporativa de excelência, a IA será acoplada diretamente à estrutura do dbt, respeitando os seguintes pilares:

1. **Contexto Baseado no Usuário Logado (Row-Level Security):** A IA identificará dinamicamente as credenciais do usuário do hospital que está interagindo com o chat. Se um médico do setor de Oncologia fizer uma pergunta, a IA terá acesso estritamente aos dados de sua especialidade. Se um Diretor Financeiro perguntar, ela abrirá o escopo do `billing_amount`.
2. **Prevenção de Alucinações via dbt Semantic Layer:**
   A LLM não fará consultas diretas na tabela bruta. Ela utilizará a camada semântica do dbt como sua "única fonte da verdade". Isso garante que quando o usuário perguntar por "Tempo de Internação", a IA usará exatamente a métrica `length_of_stay_days` já calculada e testada por nós na `fct_admissions`.
3. **Trilha de Auditoria de Prompts:**
   Cada pergunta feita à IA e a query SQL gerada por ela serão salvas em uma tabela de auditoria dentro do Snowflake, garantindo total conformidade com leis de proteção de dados de saúde (como LGPD e HIPAA).