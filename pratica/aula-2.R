# informações sobre a sessão e pacotes carregados
devtools::session_info()

# informações sobre a sessão e pacotes instalado
devtools::session_info(pkgs = "installed")

# instalar um pacote e instalar as dependencias sugeridas e obrigatorias
install.packages("nomepacote", dependencies = "Suggests")

# criar pastas usando código
dir.create("dados/")

# criar nome da pasta compondo informacoes
nome_da_pasta <- paste0("dados/", Sys.Date(), "/")

fs::dir_create(nome_da_pasta)

# importar os dados: USE ASPAS, E TAB.

pinguins <- readr::read_csv("dados/pinguins.csv")

