## code to prepare `CADD` dataset goes here

CADD <- tibble::tribble(
  ~study,      ~family,   ~variant_type, ~cadd,
  "Magini",       "1",        "splice", 10.92,
  "Magini",       "2",        "splice",  29.4,
  "Magini",       "3",        "splice",  26.1,
  "Magini",       "3",      "nonsense",    36,
  "Magini",       "4",      "nonsense",    39,
  "Magini",       "5",      "deletion",    32,
  "Magini",       "6",        "splice",  26.2,
  "Magini",       "7",      "missense",  23.5,
  "Magini",       "7", "gene deletion",    NA,
  "Magini",       "8",      "nonsense",    37,
  "Magini",       "9",      "missense",  25.5,
  "Magini",       "10",      "deletion",    33,
  "Magini",       "11",      "missense",  26.2,
  "Magini",       "11",        "splice", 0.916,
  "Magini",       "12",      "deletion",  24.9,
  "Magini",       "12",        "splice",    26,
  "Monies_2019",  "1",        "splice",    NA,
  "Monies_2019",  "2",      "deletion",    NA,
  "Ravenscroft_2020", "1",      "missense",  22.8,
  "Ji_2022",       "1",      "nonsense",    NA,
  "Bijarnia-Mahay_2022", "1", "deletion", NA
) 

usethis::use_data(CADD, overwrite = TRUE)


