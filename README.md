
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SMPD4

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
<!-- badges: end -->

The goal of SMPD4 is to provide analysis ready data sets on SMPD4 data.

Sphingomyelin Phosphodiesterase 4 (SMPD4) is a type of sphinogmyelinase
protein encoded by the SMPD4 gene. Patients with a bi-allelic loss of
function variants in this gene are associated with a condition known as
neurodevelopmental disorder with microcephaly, arthrogryposis, and
structural brain anomalies (NEDMABA;
[618622](https://omim.org/entry/618622)).

Few cases exist in the scientific literature with [Magini et
al. (2019)](https://doi.org/10.1016/j.ajhg.2019.08.006) reporting 23
members of 12 unrelated families. The genotype-phenotype relationship of
NEDMABA is heterogeneous and aside from case-reports, little data is
available for statistical analysis. Magini et al. (2019) offer a
supplementary table with summarised clinical phenotype data of the
included subjects. Unfortunately these data are non standardised,
heterogeneous and largely textual based. This project aims to
standardise and process this data into tidy format [(Wickham
(2014))](https://doi.org/10.1016/j.ajhg.2019.08.006) so it is
analysis-ready and extensible for other researchers to better understand
the relationship between clinical factors discovered in the literature.

## Installation

You can install the development version of SMPD4 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("deanmarchiori/SMPD4")
```

## Example

``` r
library(SMPD4)

data("smpd4_phenotype")
head(smpd4_phenotype[,1:20])
#>    id family individual deceased survival_time variant_type locus_1 locus_2
#> 1 1_1      1          1     TRUE            30   homozygote    1320      NA
#> 2 1_2      1          2     TRUE            60   homozygote    1320      NA
#> 3 1_3      1          3     TRUE            30   homozygote    1320      NA
#> 4 1_4      1          4     TRUE          1095   homozygote    1320      NA
#> 5 2_1      2          1     TRUE          2190   homozygote    1483      NA
#> 6 2_2      2          2    FALSE          1825   homozygote    1483      NA
#>   gender ethnicity consanguineous termination birth_gestation
#> 1 female   Turkish           TRUE       FALSE              39
#> 2   male   Turkish           TRUE       FALSE              37
#> 3   male   Turkish           TRUE       FALSE              36
#> 4 female   Turkish           TRUE       FALSE              38
#> 5 female   Morocco           TRUE       FALSE              37
#> 6   male   Morocco           TRUE       FALSE              37
#>   route_vaginal_vs_c_sect birth_weight birth_ofc birth_length age_at_demise
#> 1                     SVD         2175      30.5           NA            30
#> 2                      CS         1860      31.0           NA            60
#> 3                      CS         1955      30.0           NA             2
#> 4                      CS         2780      30.5           41          1095
#> 5                      CS         2045      29.0           39          2190
#> 6                      CS         2300        NA           NA            NA
#>   age_at_last_follow_up microcephaly_ind
#> 1                    30                1
#> 2                    60                1
#> 3                    30                1
#> 4                  1095                1
#> 5                    NA                1
#> 6                  1825                1
```

## References

Magini, P., Smits, D. J., Vandervore, L., Schot, R., Columbaro, M.,
Kasteleijn, E., … & Mancini, G. M. (2019). Loss of SMPD4 causes a
developmental disorder characterized by microcephaly and congenital
arthrogryposis. The American Journal of Human Genetics, 105(4), 689-705.
<https://doi.org/10.1016/j.ajhg.2019.08.006>

Wickham, H. . (2014). Tidy Data. Journal of Statistical Software,
59(10), 1–23. <https://doi.org/10.18637/jss.v059.i10>

## Data use and licencing

These data are Copyright 2019 American Society of Human Genetics. Data
is used under Elsevier user license
<https://www.elsevier.com/about/policies/open-access-licenses/elsevier-user-license>

Use permitted for read, download, text and data mining. Used for
Non-Commercial purposes. All outputs of this R package are data mining
related for non-commerical use.
