# ANOTAÇÕES SOBRE BOAS PRÁTICAS ------

# Dúvidas: o que é o pipe?
# O pipe permite encadear funções!

library(tidyverse) # carregar tidyverse
starwars # ver a base de dados starwars

# %>% pipe do tidyverse/magrittr
starwars %>%
  filter(mass >= 100) %>%
  arrange(desc(mass))


# |> pipe do R base! versão 4.1 do R em diante.
starwars |> 
  filter(mass >= 100) |> 
  arrange(desc(mass))

# Boas práticas: AS FUNÇÕES PODEM SER ALTERADAS AO LONGO DO TEMPO!
# Por isso é interessante registrar a versão que estamos usando.

# exemplo de código que dá erro agora, mas não dava antes!
str_detect(starwars$name, "")

# Boas práticas: PODEMOS USAR :: PARA REFERENCIAR DE QUAL PACOTE USAMOS
# ALGUMA FUNÇÃO

# Exemplo:

# estamos usando a função str_detect() da função stringr
# stringr::str_detect()

# QUATRO PONTOS --------------------------------
# Ao usar ::, não é necessário usar o library()

# evita conflito de funções, usar uma função de um pacote X quando
# queria usar de um pacote Y.

dplyr::select()
raster::select()

dplyr::filter()
stats::filter()


# CAMINHOS ----------
# minha analise
getwd() # permite ver qual é o diretório de trabalho

# salvar um objeto em um arquivo:
write.csv(mtcars, "mtcars2108.csv")

# ler esse objeto:
mtcars2 <- read.csv("mtcars2108.csv")


# DÚVIDA: PODEMOS USAR = PARA ATRIBUICAO?
# Também funciona, não costuma ser recomendado.
# é a forma usada no python

mtcars2 <- read.csv("mtcars2108.csv")

mtcars3 = read.csv("mtcars2108.csv")


# o igual é usado em outros contextos, por isso não costuma ser recomendado.
library(tidyverse)

starwars |> 
  mutate(altura_m = height/100) |>
  View()



# CAMINHOS ------------------------

# salvar os dados do mtcars em uma pasta chamada dados
dir.create("dados")
write.csv(mtcars, "dados/mtcars.csv")



# caminho relativo - parte da pasta principal do projeto
mtcars2 <- read.csv("dados/mtcars.csv") 

# caminho absoluto - parte da pasta principal do computador
mtcars3 <- read.csv("~/Documents/anotacoes-curso-relatorios-2023/dados/mtcars.csv")

# pacote que ajuda com caminhos!
here::here("dados/mtcars.csv")


# SALVAR ARQUIVOS INTERMEDIÁRIOS: RDS ---------
# RDS são arquivos binários do R.
# Podem salvar qualquer objeto em um arquivo (até um gráfico!)
# não perde as propriedades do objeto

# PARA SALVAR ARQUIVOS
# versao do tidyverse
readr::write_rds()
# versão do base R
saveRDS()

# PARA LER ARQUIVOS
# versao do tidyverse
readr::read_rds()
# versão do base R
readRDS()


