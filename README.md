
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SMPD4

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7071092.svg)](https://doi.org/10.5281/zenodo.7071092)
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
heterogeneous and largely textual based.

Further isolated examples exist in other papers and case studies, which
have also been included (Bijarnia-Mahay et al. (2022), Ji et al. (2022),
Monies et al. (2019), Ravenscroft et al. (2020)).

This project aims to standardise and process this data into tidy format
[(Wickham (2014))](https://doi.org/10.1016/j.ajhg.2019.08.006) so it is
analysis-ready and extensible for other researchers to better understand
the relationship between clinical factors discovered in the literature.

## Installation

You can install the development version of SMPD4 from
[GitHub](https://github.com/deanmarchiori/SMPD4) with:

``` r
# install.packages("devtools")
devtools::install_github("deanmarchiori/SMPD4")
```

## Example

``` r
library(SMPD4)

data("magini_2019")
head(magini_2019[,1:20])
#>    study         id family individual deceased survival_time variant_type
#> 1 Magini Magini_1_1      1          1     TRUE            30   homozygote
#> 2 Magini Magini_1_2      1          2     TRUE            60   homozygote
#> 3 Magini Magini_1_3      1          3     TRUE            30   homozygote
#> 4 Magini Magini_1_4      1          4     TRUE          1095   homozygote
#> 5 Magini Magini_2_1      2          1     TRUE          2190   homozygote
#> 6 Magini Magini_2_2      2          2    FALSE          1825   homozygote
#>   locus_1 locus_2 gender ethnicity consanguineous termination birth_gestation
#> 1    1320      NA female   Turkish           TRUE       FALSE              39
#> 2    1320      NA   male   Turkish           TRUE       FALSE              37
#> 3    1320      NA   male   Turkish           TRUE       FALSE              36
#> 4    1320      NA female   Turkish           TRUE       FALSE              38
#> 5    1483      NA female   Morocco           TRUE       FALSE              37
#> 6    1483      NA   male   Morocco           TRUE       FALSE              37
#>   route_vaginal_vs_c_sect birth_weight birth_ofc birth_length age_at_demise
#> 1                     SVD         2175      30.5           NA            30
#> 2                      CS         1860      31.0           NA            60
#> 3                      CS         1955      30.0           NA             2
#> 4                      CS         2780      30.5           41          1095
#> 5                      CS         2045      29.0           39          2190
#> 6                      CS         2300        NA           NA            NA
#>   age_at_last_follow_up
#> 1                    30
#> 2                    60
#> 3                    30
#> 4                  1095
#> 5                    NA
#> 6                  1825
```

## References

Bijarnia-Mahay, S., Somashekar, P. H., Kaur, P., Kulshrestha, S.,
Ramprasad, V. L., Murugan, S., … & Shukla, A. (2022). Growth and
neurodevelopmental disorder with arthrogryposis, microcephaly and
structural brain anomalies caused by Bi-allelic partial deletion of
SMPD4 gene. Journal of human genetics, 67(3), 133-136.

Magini, P., Smits, D. J., Vandervore, L., Schot, R., Columbaro, M.,
Kasteleijn, E., … & Mancini, G. M. (2019). Loss of SMPD4 causes a
developmental disorder characterized by microcephaly and congenital
arthrogryposis. The American Journal of Human Genetics, 105(4), 689-705.

Ji, W., Kong, X., Yin, H., Xu, J., & Wang, X. (2022). Case Report: Novel
Biallelic Null Variants of SMPD4 Confirm Its Involvement in
Neurodevelopmental Disorder With Microcephaly, Arthrogryposis, and
Structural Brain Anomalies. Frontiers in Genetics, 13.

Ravenscroft, G., Clayton, J. S., Faiz, F., Sivadorai, P., Milnes, D.,
Cincotta, R., … & Davis, M. R. (2021). Neurogenetic fetal akinesia and
arthrogryposis: genetics, expanding genotype-phenotypes and functional
genomics. Journal of medical genetics, 58(9), 609-618.

Monies, D., Abouelhoda, M., Assoum, M., Moghrabi, N., Rafiullah, R.,
Almontashiri, N., … & Alkuraya, F. S. (2019). Lessons learned from
large-scale, first-tier clinical exome sequencing in a highly
consanguineous population. The American Journal of Human Genetics,
104(6), 1182-1201.

Wickham, H. . (2014). Tidy Data. Journal of Statistical Software,
59(10), 1–23. <https://doi.org/10.18637/jss.v059.i10>

## Data use and licencing

These data are Copyright 2019 American Society of Human Genetics. Data
is used under Elsevier user license
<https://www.elsevier.com/about/policies/open-access-licenses/elsevier-user-license>

Use permitted for read, download, text and data mining. Used for
Non-Commercial purposes. All outputs of this R package are data mining
related for non-commerical use.
