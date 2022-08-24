## code to prepare `CADD` dataset goes here

CADD <- tibble::tribble(
      ~family,   ~variant_type, ~cadd,
          "1",        "splice", 10.92,
          "2",        "splice",  29.4,
          "3",        "splice",  26.1,
          "3",      "nonsense",    36,
          "4",      "nonsense",    39,
          "5",      "deletion",    32,
          "6",        "splice",  26.2,
          "7",      "missense",  23.5,
          "7", "gene deletion",    NA,
          "8",      "nonsense",    37,
          "9",      "missense",  25.5,
         "10",      "deletion",    33,
         "11",      "missense",  26.2,
         "11",        "splice", 0.916,
         "12",      "deletion",  24.9,
         "12",        "splice",    26,
   "UPN-0877",        "splice",    NA,
   "UPN-1246",      "deletion",    NA,
  "Melbourne",      "missense",  22.8,
      "China",      "nonsense",    NA,
  "Bijarnia-Mahay_study", "deletion", NA
  ) 

usethis::use_data(CADD, overwrite = TRUE)
