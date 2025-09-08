# SINISA 2025 – Técnicas de Agrupamento

Este repositório apresenta análises exploratórias e comparativas sobre os **indicadores do Sistema Nacional de Informações sobre Saneamento (SINISA)**, com foco no ano de 2025. O documento em RMarkdown/Distill organiza os resultados em capítulos e subcapítulos para facilitar a leitura.

## Conteúdo do relatório

- **Introdução**  
  Contextualização do SINISA 2025, objetivos da análise e relevância dos indicadores de saneamento para o planejamento público.

- **Metodologia**  
  - Descrição das bases de dados utilizadas (SINISA, IBGE, geobr).  
  - Procedimentos de limpeza, transformação e integração dos dados.  
  - Técnicas de agrupamento aplicadas: *k-means*, *k-medoids*, *DBSCAN*, *HDBSCAN*, além de métodos probabilísticos/distribucionais.  
  - Métricas de avaliação de clusters: *Silhouette*, *Davies–Bouldin (DB)* e *Calinski–Harabasz*.

- **Resultados**  
  - Construção de clusters para diferentes variáveis-chave de saneamento.  
  - Apresentação de indicadores regionais (água e esgoto).  
  - Visualizações interativas (tabelas com `DT::datatable`, gráficos e mapas em `sf`).  

- **Discussão**  
  Interpretação dos agrupamentos, comparação entre métricas e implicações para políticas públicas de saneamento.

- **Conclusão**  
  Síntese dos achados e apontamentos para usos futuros do SINISA como ferramenta de avaliação e monitoramento.

## Objetivo

Oferecer um **panorama exploratório** do SINISA 2025 a partir de técnicas de análise de agrupamento, permitindo identificar padrões e diferenças regionais no acesso a serviços de saneamento no Brasil.
