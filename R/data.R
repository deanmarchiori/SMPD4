#' SMPD4-Related Clinical Phenotype Data Set from Magini et al.(2019)
#'
#' A dataset of clical features and phenotypes of Neurodevelopmental Disorder with Arthrogryposis, Microcephaly and Structural Brain Anomalies Caused by Bi-allelic Partial Deletion of SMPD4 gene.
#' 
#' This data has been transformed into an analysis-ready tidy data set from Table S2 of Magini, Pamela, et al. "Loss of SMPD4 causes a 
#' developmental disorder characterized by microcephaly and congenital arthrogryposis." The American Journal of Human 
#' Genetics 105.4 (2019): 689-705.  
#'
#' @format A tibble: 21 x 152
#' 
#' \describe{
#'   \item{_ind}{columns ending in _ind are indicator columns created by merging duplicate tokenised terms into one feature.}
#' }
#' 
#' @source \url{https://doi.org/10.1016/j.ajhg.2019.08.006}
"magini_2019"

#' SMPD4-Related Clinical Phenotype Data Set from Bijarnia-Mahay et al. (2022)
#'
#' A dataset of clical features and phenotypes of Neurodevelopmental Disorder with Arthrogryposis, Microcephaly and Structural Brain Anomalies Caused by Bi-allelic Partial Deletion of SMPD4 gene.
#' 
#' This data has been transformed into an analysis-ready tidy data set from Bijarnia-Mahay, S., Somashekar, P. H., Kaur, P., Kulshrestha, S., Ramprasad, V. L., Murugan, S., ... & Shukla, A. (2022). Growth and neurodevelopmental disorder with arthrogryposis, microcephaly and structural brain anomalies caused by Bi-allelic partial deletion of SMPD4 gene. Journal of human genetics, 67(3), 133-136.  
#'
#' @format A tibble: 1 x 152
#' 
#' \describe{
#'   \item{_ind}{columns ending in _ind are indicator columns created by merging duplicate tokenised terms into one feature.}
#' }
#' 
#' @source \url{https://doi.org/10.1038%2Fs10038-021-00981-3}
"bijarnia_mahay_2022"

#' SMPD4-Related Clinical Phenotype Data Set from Ji et al. (2022)
#'
#' A dataset of clical features and phenotypes of Neurodevelopmental Disorder with Arthrogryposis, Microcephaly and Structural Brain Anomalies Caused by Bi-allelic Partial Deletion of SMPD4 gene.
#' 
#' This data has been transformed into an analysis-ready tidy data set from Ji, W., Kong, X., Yin, H., Xu, J., & Wang, X. (2022). Case Report: Novel Biallelic Null Variants of SMPD4 Confirm Its Involvement in Neurodevelopmental Disorder With Microcephaly, Arthrogryposis, and Structural Brain Anomalies. Frontiers in Genetics, 13.
#'
#' @format A tibble: 1 x 152
#' 
#' \describe{
#'   \item{_ind}{columns ending in _ind are indicator columns created by merging duplicate tokenised terms into one feature.}
#' }
#' 
#' @source \url{https://doi.org/10.3389%2Ffgene.2022.872264}
"ji_2022"

#' SMPD4-Related Clinical Phenotype Data Set from Monies et al. (2019)
#'
#' A dataset of clical features and phenotypes of Neurodevelopmental Disorder with Arthrogryposis, Microcephaly and Structural Brain Anomalies Caused by Bi-allelic Partial Deletion of SMPD4 gene.
#' 
#' This data has been transformed into an analysis-ready tidy data set from Monies, D., Abouelhoda, M., Assoum, M., Moghrabi, N., Rafiullah, R., Almontashiri, N., ... & Alkuraya, F. S. (2019). Lessons learned from large-scale, first-tier clinical exome sequencing in a highly consanguineous population. The American Journal of Human Genetics, 104(6), 1182-1201.
#'
#' @format A tibble: 2 x 152
#' 
#' \describe{
#'   \item{_ind}{columns ending in _ind are indicator columns created by merging duplicate tokenised terms into one feature.}
#' }
#' 
#' @source \url{https://doi.org/10.1016%2Fj.ajhg.2019.04.011}
"monies_2019"

#' SMPD4-Related Clinical Phenotype Data Set from Ravenscroft et al. (2020)
#'
#' A dataset of clical features and phenotypes of Neurodevelopmental Disorder with Arthrogryposis, Microcephaly and Structural Brain Anomalies Caused by Bi-allelic Partial Deletion of SMPD4 gene.
#' 
#' This data has been transformed into an analysis-ready tidy data set from Ravenscroft, G., Clayton, J. S., Faiz, F., Sivadorai, P., Milnes, D., Cincotta, R., ... & Davis, M. R. (2021). Neurogenetic fetal akinesia and arthrogryposis: genetics, expanding genotype-phenotypes and functional genomics. Journal of medical genetics, 58(9), 609-618.
#'
#' @format A tibble: 3 x 152
#' 
#' \describe{
#'   \item{_ind}{columns ending in _ind are indicator columns created by merging duplicate tokenised terms into one feature.}
#' }
#' 
#' @source \url{https://doi.org/10.1136%2Fjmedgenet-2020-106901}
"ravenscroft_2020"


#' Variant and CADD data
#'
#' Combined Annoation Dependent Depletion (CADD) data and Single Nucleotide Variant
#' type aggregated from studies on SMPD4 related variants.  
#' 
#' Data are manually aggregated from:  
#' 
#' Bijarnia-Mahay, S., Somashekar, P. H., Kaur, P., Kulshrestha, S., Ramprasad, V. L., Murugan, S., ... & Shukla, A. (2022). Growth and neurodevelopmental disorder with arthrogryposis, microcephaly and structural brain anomalies caused by Bi-allelic partial deletion of SMPD4 gene. Journal of human genetics, 67(3), 133-136.  
#' 
#' Magini, P., Smits, D. J., Vandervore, L., Schot, R., Columbaro, M., Kasteleijn, E., ... & Mancini, G. M. (2019). Loss of SMPD4 causes a developmental disorder characterized by microcephaly and congenital arthrogryposis. The American Journal of Human Genetics, 105(4), 689-705.  
#' 
#' Ji, W., Kong, X., Yin, H., Xu, J., & Wang, X. (2022). Case Report: Novel Biallelic Null Variants of SMPD4 Confirm Its Involvement in Neurodevelopmental Disorder With Microcephaly, Arthrogryposis, and Structural Brain Anomalies. Frontiers in Genetics, 13.  
#' 
#' Ravenscroft, G., Clayton, J. S., Faiz, F., Sivadorai, P., Milnes, D., Cincotta, R., ... & Davis, M. R. (2021). Neurogenetic fetal akinesia and arthrogryposis: genetics, expanding genotype-phenotypes and functional genomics. Journal of medical genetics, 58(9), 609-618.  
#' 
#' Monies, D., Abouelhoda, M., Assoum, M., Moghrabi, N., Rafiullah, R., Almontashiri, N., ... & Alkuraya, F. S. (2019). Lessons learned from large-scale, first-tier clinical exome sequencing in a highly consanguineous population. The American Journal of Human Genetics, 104(6), 1182-1201.  
#' 
#'
#' @format A tibble: 20 x 3
#' 
#' \describe{
#' \item{\code{family}}{Patient family identifier from study}
#'  \item{\code{variant_type}}{Type of SNV}
#'  \item{\code{cadd}}{Combined Annoation Dependent Depletion CADD score where available}
#' }
#' 
"CADD"