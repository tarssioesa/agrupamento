### Library: 

require(tidyverse)
require(readxl)
require(beeswarm)

### Inserir um resumo sobre SINISA 2025: 

### Load: 

# Lista dos arquivos na pasta data
files <- list.files("data", pattern = "\\.xlsx$", full.names = TRUE)

# Função para processar cada arquivo
process_one_file <- function(arquivo) {
  # Definir o valor de skip com base no nome do arquivo
  skip_value <- case_when(
    grepl("Indicadores", arquivo) ~ 9,  # Para arquivos 1 e 2
    grepl("Administrativo", arquivo) ~ 10,  # Para o terceiro arquivo
    TRUE ~ 9  # Valor default
  )
  
  sheets <- setdiff(excel_sheets(arquivo), "Nota metodológica")
  
  df_final <- tibble(cod_IBGE = 1232131231) # código fictício para o join
  
  # Ler todas as abas
  for (sh in sheets) {
    df <- read_excel(arquivo, sheet = sh, skip = skip_value)
    df_final <- left_join(df, df_final)
  }
  
  df_final
}

# Aplicar a função a todos os arquivos e juntar os resultados
lista_df <- map(files, process_one_file)

# Juntar todos os arquivos
df_final <- reduce(lista_df, ~ left_join(.x, .y))

### Selecionando algumas variáveis sobre saneamento

df_resumido <- df_final |> 
  select(cod_IBGE, 
         `Macrorregião`, 
         UF, 
         `Município`, 
         CAD0002, # Natureza Jurídica
         IAG0001, # Atendimento de água total (pop)
         IAG0002, # Atendimento de água urbano (pop)
         IAG0003, # Atendimento de água rural (pop)
         IAG1001, # Extensao da rede por ligacao
         IAG2002, # Micromedição de água
         IAG2007, # Consumo percapita de água
         IAG2012, # Perdas de faturamento
         IAG2013, # Perdas totais de água 
         IFA0001, # produtividade do pessoal total em relacao as ligacoes
         IFA2009, # despesa pessoal nas despesas de exploracao de agua
         IFA2010) # Despesas de energia elétrica

### Ajustando para numerico os dados:

df_resumido <- df_resumido |> 
  mutate(across(6:16, as.numeric))

### Vamos primeiro explorar as variáveis: 

df_resumido |>
  ggplot(aes(x = IAG0001, y = Macrorregião)) +
  geom_violin(fill = "skyblue", alpha = 0.6, trim = FALSE) +
  stat_summary(fun = median, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    x = "Indicador IAG0001",
    y = "Macrorregião",
    title = "Distribuição do IAG0001 por Macrorregião"
  ) +
  theme_minimal()

# Comentário: É interessante observar que a mediana para Sul, Sudeste e Centroeste são acima 
# da cobertura de água de 75% dos domícilios. Tendo modas de mais de 90% nos dois primeiros e 80% para 
# o Centro Oeste. Porém no Nordeste, a mediana é 50% e no norte inferior a este valor. Estes 
# valores mostram o quanto a questão do saneamento ainda apresenta grandes desigualdades entre regiões.

# Olhando para a perda de água:

df_resumido |>
  ggplot(aes(x =  IAG2013, y = Macrorregião)) +
  geom_violin(fill = "skyblue", alpha = 0.6, trim = FALSE) +
  stat_summary(fun = median, geom = "point", shape = 23, size = 3, fill = "red") +
  labs(
    x = "Indicador IAG2013",
    y = "Macrorregião",
    title = "Distribuição de IAG2013 por Macrorregião"
  ) +
  theme_minimal()

# Comentários: A questão das perdas de água ainda são relevantes no Brasi, as perdas colocadas 
# se apresentam em algumas regiões com mediana de 30%, chegando a 40%. Porém, é interessante
# observar que nestes gráficos apresentam valores negativos o que pode indicar erro no preenchimento de água.
# Estes dados, inclusive, são muito criticados e se debate se representam a realidade.


###### Técnicas de agrupamento: 

#O que é clustering? Agrupar observações sem rótulos.
#Diferença entre supervisionado e não supervisionado.
#Noções de distância (euclidiana, Manhattan, cosseno) e métrica de avaliação (Silhouette, Davies–Bouldin, Calinski–Harabasz).

# Explorando métodos particionais: 

#### Kmeans:

#### K-mediods