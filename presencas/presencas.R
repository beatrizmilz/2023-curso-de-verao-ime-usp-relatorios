arquivo <- "~/Downloads/Verao2023_RRR_Presenças_20230131-0811.xlsx"
aulas_oferecidas <- 3

presenca_bruto <- readxl::read_excel(arquivo, skip = 2)

tratar_presenca <- function(x) {
  dplyr::case_when(
    x == "?" ~ FALSE,
    stringr::str_starts(x, "P ") ~ TRUE,
    stringr::str_starts(x, "L ") ~ TRUE,
    stringr::str_starts(x, "Inscrição de usuários inicia") ~ TRUE
  )
}

presenca_tratado <- presenca_bruto |> 
  janitor::clean_names() |> 
  dplyr::select(1:10) |> 
  dplyr::rename(aula_1 = 6,
                aula_2 = 7,
                aula_3 = 8,
                aula_4 = 9,
                aula_5 = 10
                ) |>
  dplyr::mutate(
    dplyr::across(
      .cols = tidyselect::starts_with("aula_"),
      .fns = tratar_presenca
        
    )
  ) |>
  dplyr::rowwise() |> 
  dplyr::mutate(
    nome_completo = paste(nome, sobrenome),
    quantidade_aulas_assistidas = sum(aula_1, aula_2, aula_3, aula_4,
                                      aula_5, na.rm = TRUE),
    porc = quantidade_aulas_assistidas/5*100, 

    
  ) 


presenca_tratado |> 
  dplyr::filter(quantidade_aulas_assistidas == 1) |> 
  dplyr::mutate() |> 
  dplyr::pull(nome_completo) |> 
  writeLines()
  
