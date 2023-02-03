# carregar o pacote quarto
library(quarto)

# caminho do arquivo que usaremos para iterar
caminho_qmd <- "pratica-aula-3.qmd"

# podemos renderizar com a funcao quarto_render
quarto::quarto_render(input = caminho_qmd)


# podemos renderizar com parametro!
quarto::quarto_render(input = caminho_qmd, 
                      execute_params = list(estado = "SP"))

# Cuidado com a questão dos caminhos!!
# definir nome do arquivo (output_file)
quarto::quarto_render(input = caminho_qmd, 
                      execute_params = list(estado = "SP"), 
                      output_file = "RELATORIO_sp.html", 
                      quiet = TRUE)





# ---- breve demonstracao do purrr
library(purrr)

# funcao principal: map
# recebe um vetor ou lista, e uma função. 
# aplica a funcao em cada item da lista/vetor
map(1:3, sqrt)

# map(.x, .f)


# ENTÃO PRECISAMOS DE 2 COISAS:
# VETOR DOS ESTADOS PARA ITERAR
# UMA FUNCAO QUE RECEBE O ESTADO!



# VAMOS CRIAR A FUNÇÃO!!

gerar_relatorio_por_uf <- function(uf){
  quarto::quarto_render(input = caminho_qmd, 
                        execute_params = list(estado = uf), 
                        output_file = paste0("RELATORIO_", uf, ".html"), 
                        quiet = TRUE)
}

# EXEMPLO DE COMO ELA FUNCIONA
gerar_relatorio_por_uf("PA")

# AGORA PRECISAMOS DOS ESTADOS
# ---- # ler a base SIGBM
sigbm <- readxl::read_excel("dados/sigbm.xlsx", skip = 4) |> 
  janitor::clean_names()

# buscar os estados que tem barragens
ufs_com_barragens <- unique(sigbm$uf)

ufs_com_barragens


# temos os estados e a função! podemos usar o map para
# aplicar a funcao em cada um dos estados

map(.x =  ufs_com_barragens, 
    .f = gerar_relatorio_por_uf)


# buscar a lista dos arquivos gerados
fs::dir_ls(glob = "RELATORIO_*.html") |> 
  tibble::as_tibble()
