arquivo_semana_1 <- "~/Downloads/Verao2023_IPAED_Presenças_20230129-2206.xlsx"

presenca_bruto_semana_1 <- readxl::read_excel(arquivo_semana_1, skip = 2)


arquivo_semana_2 <- "~/Downloads/Verao2023_IPAED_Presenças_20230129-2207.xlsx"

presenca_bruto_semana_2 <- readxl::read_excel(arquivo_semana_2, skip = 2)



tratar_presenca <- function(x){
  dplyr::case_when(x == "?" ~ FALSE,
                   stringr::str_starts(x, "P ") ~ TRUE,
                   stringr::str_starts(x, "L ") ~ TRUE,
                   stringr::str_starts(x, "Inscrição de usuários inicia") ~ TRUE,
                   
                   )
}

semana_1 <- presenca_bruto_semana_1 |> 
  janitor::clean_names() |> 
  dplyr::select(-grupos) |> 
  dplyr::select(1:8) |> 
  dplyr::rename(aula_1 = 6,
                aula_2 = 7,
                aula_3 = 8,
                ) 


semana_2 <- presenca_bruto_semana_2 |> 
  janitor::clean_names() |> 
  dplyr::select(-grupos) |> 
  dplyr::select(1:8) |> 
  dplyr::rename(aula_4 = 6,
                aula_5 = 7,
                aula_6 = 8,
  ) 


presenca_tratado <- dplyr::full_join(semana_1, semana_2) |>
  dplyr::mutate(
    dplyr::across(
      .cols = tidyselect::starts_with("aula_"),
      .fns = tratar_presenca
        
    )
  ) |>
  dplyr::mutate(nome_completo = paste(nome, sobrenome), .before = everything()) |> 
  dplyr::rowwise() |> 
  dplyr::mutate(
    quantidade_aulas_assistidas = sum(aula_1, aula_2, aula_3, aula_4, aula_5, aula_6, na.rm = TRUE),
    presencas_necessarias = quantidade_aulas_assistidas >= 6*0.75
  ) |> 
  dplyr::ungroup()


presenca_tratado |> 
  writexl::write_xlsx("presenca_python.xlsx")
