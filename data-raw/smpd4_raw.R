## code to prepare `smpd4` dataset goes here

library(janitor)
library(readxl)
library(tidyr)
library(stringr)
library(tibble)
library(forcats)
library(readr)
library(purrr)

smpd4_phenotype <- readxl::read_excel('data-raw/mmc2.xlsx', n_max = 66, col_names = FALSE) |>
  tidyr::unite("feature", 1:2) |>
  dplyr::mutate(feature = stringr::str_remove(feature, "_NA|NA_|NA")) |>
  t() |>
  tibble::as_tibble() |>
  janitor::row_to_names(row_number = 1) |>
  janitor::clean_names() |>
  dplyr::mutate(across(tidyr::everything(), ~ stringr::str_replace(., "n\\.a\\.", NA_character_))) |>
  # MAKE UNIQUE IDS
  dplyr::mutate(
    family = stringr::str_extract(family_contributing_institute, "(?<=Family )\\d+"),
    individual = stringr::str_extract(
      family_contributing_institute,
      "(?<=Individual |[T|t]win |Sibling )\\d+"
    )
  ) |>
  tidyr::replace_na(list(individual = 1)) |>
  tidyr::unite("id", family, individual, remove = FALSE) |>
  dplyr::mutate(
    gender = tolower(gender),
    gender = forcats::fct_recode(gender, female = "female fetus"),
    consanguineous = ifelse(
      stringr::str_detect(family_hx, "[N|n]on-consanguineous|not related"),
      FALSE,
      TRUE
    ),
    termination = stringr::str_detect(birth_gestation, "TOP"),
    birth_gestation = ifelse(
      stringr::str_detect(birth_gestation, "term"),
      40,
      readr::parse_number(birth_gestation)
    ),
    route_vaginal_vs_c_sect = ifelse(stringr::str_detect(route_vaginal_vs_c_sect, "vaginal"), "SVD", "CS"),
    variant_type = tolower(
      stringr::str_extract(
        smpd4_variant,
        "[H|h]omozygo[te|us]+|[C|c]ompound heterozygote"
      )
    ),
    variant_type = tidyr::replace_na(variant_type, "compound heterozygote"),
    locus = stringr::str_extract_all(smpd4_variant, "(?<=c.)\\d+"),
    locus_1 = as.numeric(purrr::map_chr(locus, ~ purrr::pluck(.x, 1, .default = NA_character_))),
    locus_2 = as.numeric(purrr::map_chr(locus, ~ purrr::pluck(.x, 2, .default = NA_character_))),
    birth_weight = ifelse(
      readr::parse_number(birth_weight) < 1000,
      1000 * readr::parse_number(birth_weight),
      readr::parse_number(birth_weight)
    ),
    birth_ofc = ifelse(
      readr::parse_number(birth_ofc) > 100,
      readr::parse_number(birth_ofc) / 10,
      readr::parse_number(birth_ofc)
    ),
    birth_length = readr::parse_number(birth_length, na = c("nd", "NA", "not available")),
    age_at_demise = dplyr::case_when(
      stringr::str_detect(age_at_demise, "deceased") ~ 180,
      termination == TRUE ~ 0,
      stringr::str_detect(age_at_demise, "month") ~ readr::parse_number(age_at_demise) * 30,
      stringr::str_detect(age_at_demise, "day|pp") ~ readr::parse_number(age_at_demise),
      stringr::str_detect(age_at_demise, "y|yr") ~ readr::parse_number(age_at_demise) * 365
    ),
    deceased = dplyr::case_when(
      termination == TRUE ~ TRUE,
      stringr::str_detect(age_at_demise, "alive") ~ FALSE,
      is.na(age_at_demise) ~ FALSE,
      TRUE ~ TRUE
    ),
    age_at_last_follow_up = dplyr::case_when(
      stringr::str_detect(age_at_last_follow_up, "month") ~ readr::parse_number(age_at_last_follow_up) * 30,
      stringr::str_detect(age_at_last_follow_up, "day") ~ readr::parse_number(age_at_last_follow_up),
      stringr::str_detect(age_at_last_follow_up, "week") ~ readr::parse_number(age_at_last_follow_up) * 7,
      stringr::str_detect(age_at_last_follow_up, "y|yr") ~ readr::parse_number(age_at_last_follow_up) * 365
    ),
    survival_time = pmax(age_at_last_follow_up, age_at_demise, na.rm = TRUE),
    seizure = !stringr::str_detect(seizures_age_started, "[N|n]one|no "),
    other_neurologic_dysfunction = tidyr::replace_na(other_neurologic_dysfunction, "no"),
    sleeping_problem = forcats::fct_recode(sleeping_problem,
                                  yes = "yes, supination increases stridor",
                                  no = "nd")
  ) |>
  # SEPARATE TEXT
  tidyr::separate_rows(pregnancy, sep = ", |and ") |>
  tidyr::pivot_wider(
    names_from = pregnancy,
    values_from = pregnancy,
    values_fn = \(x) 1L,
    values_fill = 0
  ) |>
  
  tidyr::separate_rows(other_neurologic_dysfunction, sep = ", ") |>
  tidyr::pivot_wider(
    names_from = other_neurologic_dysfunction,
    values_from = other_neurologic_dysfunction,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  tidyr::separate_rows(neonatal_issues, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = neonatal_issues,
    values_from = neonatal_issues,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  tidyr::separate_rows(facial_dysmorphisms, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = facial_dysmorphisms,
    values_from = facial_dysmorphisms,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  dplyr::mutate(other_organ_defects = stringr::str_squish(other_organ_defects)) |>
  tidyr::separate_rows(other_organ_defects, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = other_organ_defects,
    values_from = other_organ_defects,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  dplyr::mutate(other_medical_issues = stringr::str_squish(other_medical_issues)) |>
  tidyr::separate_rows(other_medical_issues, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = other_medical_issues,
    values_from = other_medical_issues,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  dplyr::mutate(MRI_brain = stringr::str_squish(na_4)) |>
  tidyr::separate_rows(MRI_brain, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = MRI_brain,
    values_from = MRI_brain,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  dplyr::mutate(other = stringr::str_squish(other)) |>
  tidyr::separate_rows(other, sep = ", |\\. ") |>
  tidyr::pivot_wider(
    names_from = other,
    values_from = other,
    values_fn = \(x) 1L,
    values_fill = 0,
    names_repair = "unique"
  ) |>
  
  janitor::clean_names() |>
  dplyr::mutate(widely_spaced_nipples = widely_spaced_nipples_and_rocker_bottom_feet,
         rocker_bottom_feet = widely_spaced_nipples_and_rocker_bottom_feet) |>
  # COMBINE BINARY INDICATORS WHICH ARE DUPLICATES
  dplyr::mutate(
    microcephaly_ind = pmax(
      microcephaly_74,
      microcephaly_110,
      microcephaly_194,
      microcephaly_with_simplified_gyral_pattern,
      microcephaly_with_sgp,
      head_ct_2_mo_microcephaly,
      microcephaly_with_moderate_sgp_and_relative_small_cerebellum_and_at_lesser_degree_brainstem,
      mri_microcephaly_with_sgp,
      microcephaly_with_sgp_and_small_cerebrum,
      na.rm = TRUE
    ),
    sgp_ind = pmax(
      microcephaly_with_simplified_gyral_pattern,
      microcephaly_with_sgp,
      microcephaly_with_moderate_sgp_and_relative_small_cerebellum_and_at_lesser_degree_brainstem,
      mri_microcephaly_with_sgp,
      microcephaly_with_sgp_and_small_cerebrum,
      abnormal_gyral_pattern_dysgyria,
      na.rm = TRUE
    ),
    iugr_ind = pmax(iugr,
                    iugr_2,
                    mild_iugr,
                    na.rm = TRUE),
    talipes_ind = pmax(
      g7p5_1l2_at_37_3_previous_4_cs_antenatal_us_showed_bilateral_talipes,
      bilateral_clubfoot,
      contractures_of_hands_and_club_feet_2,
      bilateral_talipes,
      contractures_of_hands_and_club_feet,
      bilateral_lower_limbs_talipes_and_joint_contractures,
      flexion_contractures_of_the_joints_and_club_feet,
      talipus_bilaterally,
      talipus_bilaterally_2,
      bilateral_clubfeed,
      na.rm = TRUE
    ),
    rocker_bottom_feet_ind = pmax(
      rocker_bottom_feet_90,
      rocker_bottom_feet_125,
      rocker_bottom_feet,
      rocker_bottom_feet_184,
      bilaterally_adducted_thumbs_and_rocker_bottom_feet,
      congenital_vertical_talus,
      vertical_talus,
      widely_spaced_nipples_and_rocker_bottom_feet,
      rocker_bottom_feet_295,
      na.rm = TRUE
    ),
    contractures_feet_ind = pmax(
      contractures_of_fingers_and_feet,
      contractures_of_hands_and_feet,
      contractures_of_hands_and_feet_and_hypercapnia,
      contractures_of_hands_and_club_feet_2,
      bilateral_lower_limbs_talipes_and_joint_contractures,
      flexion_contractures_of_the_joints_and_club_feet,
      na.rm = TRUE
    ),
    contractures_hands_deform_ind = pmax(
      clenched_hands_85,
      long_2nd_finger,
      suspected_syndactyly,
      contractures_of_fingers_and_feet,
      contractures_of_hands,
      contractures_of_hands_and_feet,
      contractures_of_hands_and_feet_and_hypercapnia,
      hypertonic_fingers_and_toes,
      contractures_of_hands_and_club_feet,
      found_with_mild_dysmorphic_features_and_contractures_after_birth,
      clenched_hands_153,
      contractures_of_hands_and_club_feet_2,
      clenched_hands_and_contractures,
      contractures_and_bilateral_camptodactyly_of_fingers_and_toes,
      adducted_thumbs,
      bilaterally_adducted_thumbs_and_rocker_bottom_feet,
      clenched_fist,
      overlapping_fingers,
      contractures_and_camptodactyly_of_the_left_hand,
      syndactyly_between_2nd_and_3rd_toes,
      contractures_and_camptodactyly_of_fingers_and_toes,
      contractures_of_fingers,
      na.rm = TRUE
    ),
    vocal_cord_palsy_ind = pmax(
      partial_vocal_cord_paresis,
      bilateral_vocal_cord_paralysis,
      feeding_intolerance_and_vocal_cord_paralysis,
      na.rm = TRUE
    ),
    arthrogryposis_contractures_other_ind = pmax(
      arthrogryposis_76,
      arthrogryposis_100,
      arthrogryposis_196,
      contractures_145,
      arthrogryposis_246,
      contractures_299,
      limb_hypotrophy,
      contractures_at_knees_and_elbows,
      micrognathia_flexed_deform_lower_limb_at_knee,
      multiple_joint_contractures,
      flexion_deformity_of_all_4_limbs,
      na.rm = TRUE
    ),
    hypercapnia_ind = pmax(
      contractures_of_hands_and_feet_and_hypercapnia,
      hypercapnia,
      na.rm = TRUE
    ),
    cleft_lip_ind = pmax(
      bilateral_cleft_lips,
      bilateral_cleft_lip,
      cleft_lip_b_l,
      na.rm = TRUE
    ),
    inspiratory_stridor_ind = pmax(
      inspiratory_stridor,
      inspiratory_stridor_2,
      inspiratory_stridor_3,
      na.rm = TRUE
    ),
    polyhydramnios_ind = pmax(
      polyhydramnios,
      monochorionic_diamniotic_twin_pregnancy_polyhydramnios,
      na.rm = TRUE
    ),
    coarse_facial_features_ind = pmax(
      coarse_facial_features,
      course_features,
      coarse_facial_features_2,
      na.rm = TRUE
    ),
    oligohydramnios_ind = pmax(
      x22_days_in_nicu_10_days_intubated_respiratory_distress_oligohydramnios,
      oligohydramnios,
      na.rm = TRUE
    ),
    respiratory_distress_ind = pmax(
      respiratory,
      required_n_cpap,
      respiratory_failure,
      on_and_off_on_oxygen,
      x22_days_in_nicu_10_days_intubated_respiratory_distress_oligohydramnios,
      tracheostomy_and_ventilatory_dependence,
      respiratory_distress,
      na.rm = TRUE
    ),
    hypotonia_ind = pmax(hypotonia_104,
                         hypotonia_118,
                         minimal_body_movements,
                         na.rm = TRUE),
    tracheostomy_ind = pmax(
      tracheostomy_and_ventilatory_dependence,
      s_p_tracheostomy,
      na.rm = TRUE
    ),
    prominent_ears_ind = pmax(large_ears,
                              prominent_ears,
                              protruding_ears,
                              na.rm = TRUE),
    posteriorly_angulated_ears_ind = pmax(
      low_set_and_posteriorly_rotated_ears,
      posteriorly_angulated_ears,
      na.rm = TRUE
    ),
    prominent_philtrum_ind = pmax(
      long_philtrum,
      prominent_pillars_of_philtrum,
      prominent_philtrum,
      na.rm = TRUE
    ),
    upper_lip_dysmorph_ind = pmax(
      thin_upper_lip,
      upper_lip_tenting,
      thin_lips_2,
      v_shaped_upper_lip,
      na.rm = TRUE
    ),
    hypomyelination_ind = pmax(
      suspect_hypomyelination,
      delayed_myelination,
      hypomyelination_on_repeat_mri,
      severe_global_hypomyelination,
      nearly_absent_myelination,
      na.rm = TRUE
    ),
    hypertonia_ind = pmax(hypertonia,
                          hypertonicity,
                          na.rm = TRUE),
    cerebellar_hypoplasia_ind = pmax(
      cerebellar_hypoplasia_93,
      cerebellar_hypoplasia_and_smooth_brain,
      brainstem_and_cerebellar_hypoplasia,
      cerebellar_hypoplasia_267,
      na.rm = TRUE
    ),
    short_palpebral_fissures_ind = pmax(
      short_palpebral_fissures,
      down_slanting_and_short_palpebral_fissures,
      na.rm = TRUE
    ),
    epicanthal_folds_ind = pmax(epicanthal_folds,
                                epicanthic_folds,
                                na.rm = TRUE),
    tube_feed_ind = pmax(
      fed_through_ng_tube_then_gastrostomy_tube_placed,
      tube_feeding,
      na.rm = TRUE
    ),
    dysmorphic_features_ind = pmax(dysmorphic_features,
                                   dysmorphism,
                                   na.rm = TRUE),
    patent_ductus_arteriosus_ind = pmax(
      patent_ductus_arteriosus,
      patent_ductus_arteriosus_and_interatrial_defect_requiring_catheterism,
      persistent_ductus_arteriosus_at_birth,
      cvs_pda,
      na.rm = TRUE
    ),
    small_anterior_fontanel_ind = pmax(small_anterior_fontanel,
                                       small_af,
                                       na.rm = TRUE),
    receding_forehead_ind = pmax(receding_forehead,
                                 high_forehead,
                                 na.rm = TRUE),
    tracheo_laryngomalacia_ind = pmax(tracheo_laryngomalacia,
                                      laryngomalacia,
                                      na.rm = TRUE),
    respiratory_infections = pmax(
      recidivating_respiratory_infections,
      recurrent_respiratory_and_urinary_tract_infections,
      na.rm = TRUE
    ),
    gerd_ind = pmax(gerd,
                    ger,
                    na.rm = TRUE),
    enlarged_ventricles = pmax(
      enlarged_lateral_ventricles_and_extra_axial_fluid_spaces,
      mild_dilatation_of_the_ventricles_and_enlargement_of_extra_axial_fluid_spaces,
      prominent_fourth_ventricle_and_cisterna_magna,
      na.rm = TRUE
    ),
    thin_corpus_collosum_ind = pmax(
      thin_cc,
      thin_corpus_callosum,
      thin_corpus_callosum_2,
      under_developed_cerebellar_inferior_vermis_and_thinning_of_corpus_callosum,
      na.rm = TRUE
    )
  ) |>
  dplyr::mutate(
    eeg_normal = stringr::str_detect(eeg, "(?<![A|a]b)normal"),
    feeding_swallow_dysfxn_ind = as.factor(dplyr::case_when(
      feeding_swallow_dysfxn == "none" ~ 0,
      feeding_swallow_dysfxn == "not done" ~ NA_real_,
      is.na(feeding_swallow_dysfxn) ~ NA_real_,
      TRUE ~ 1
    )),
    tone = dplyr::case_when(hypertonia_ind == 1 ~ "high",
                     hypotonia_ind == 1 ~ "low",
                     TRUE ~ tone),
    tone = forcats::fct_recode(tone,
                      low = "hypotonia"),
    dtr = ifelse(
      severely_diminished_dt_rs_in_lower_extremities == 1,
      "reduced",
      dtr
    ),
    dtr = forcats::fct_recode(
      dtr,
      reduced = "decreased",
      brisk = "brisk?",
      normal = "present",
      reduced = "hyporeflexia"
    ),
    bifid_uvula = and_bifid_uvula,
    under_developed_cerebellar_inferior_vermis = under_developed_cerebellar_inferior_vermis_and_thinning_of_corpus_callosum
  ) |>
  dplyr::select(-starts_with("na")) |>
  dplyr::select(-starts_with("apgar")) |>
  dplyr::select(
    -c(
      microcephaly_74,
      microcephaly_110,
      microcephaly_194,
      and_bifid_uvula,
      microcephaly_with_simplified_gyral_pattern,
      microcephaly_with_sgp,
      head_ct_2_mo_microcephaly,
      microcephaly_with_moderate_sgp_and_relative_small_cerebellum_and_at_lesser_degree_brainstem,
      under_developed_cerebellar_inferior_vermis_and_thinning_of_corpus_callosum,
      mri_microcephaly_with_sgp,
      microcephaly_with_sgp_and_small_cerebrum,
      abnormal_gyral_pattern_dysgyria,
      rocker_bottom_feet,
      iugr,
      iugr_2,
      cvs_pda,
      mild_iugr,
      g7p5_1l2_at_37_3_previous_4_cs_antenatal_us_showed_bilateral_talipes,
      bilateral_clubfoot,
      contractures_of_hands_and_club_feet_2,
      bilateral_talipes,
      contractures_of_hands_and_club_feet,
      bilateral_lower_limbs_talipes_and_joint_contractures,
      flexion_contractures_of_the_joints_and_club_feet,
      talipus_bilaterally,
      talipus_bilaterally_2,
      bilateral_clubfeed,
      rocker_bottom_feet_295,
      enlarged_lateral_ventricles_and_extra_axial_fluid_spaces,
      mild_dilatation_of_the_ventricles_and_enlargement_of_extra_axial_fluid_spaces,
      prominent_fourth_ventricle_and_cisterna_magna,
      height,
      hypercapnia,
      current_weight,
      current_ofc,
      current_length,
      brain_imaging_mri_age_age,
      normal,
      not_available,
      twin_1_of_dichorionic_diamniotic_pregnancy_after_clomid_induction,
      twin_2_of_dichorionic_diamniotic_pregnancy_after_clomid_induction,
      abnormal_prenatal_us,
      rocker_bottom_feet_90,
      family_contributing_institute,
      rocker_bottom_feet_125,
      bilaterally_adducted_thumbs_and_rocker_bottom_feet,
      congenital_vertical_talus,
      vertical_talus,
      rocker_bottom_feet_184,
      contractures_of_fingers_and_feet,
      contractures_of_hands_and_feet,
      contractures_of_hands_and_feet_and_hypercapnia,
      contractures_of_hands_and_club_feet_2,
      bilateral_lower_limbs_talipes_and_joint_contractures,
      flexion_contractures_of_the_joints_and_club_feet,
      clenched_hands_85,
      long_2nd_finger,
      suspected_syndactyly,
      contractures_of_fingers_and_feet,
      contractures_of_hands,
      contractures_of_hands_and_feet,
      contractures_of_hands_and_feet_and_hypercapnia,
      hypertonic_fingers_and_toes,
      contractures_of_hands_and_club_feet,
      found_with_mild_dysmorphic_features_and_contractures_after_birth,
      clenched_hands_153,
      contractures_of_hands_and_club_feet_2,
      clenched_hands_and_contractures,
      contractures_and_bilateral_camptodactyly_of_fingers_and_toes,
      adducted_thumbs,
      bilaterally_adducted_thumbs_and_rocker_bottom_feet,
      clenched_fist,
      medical_hospitalizations,
      medications,
      hypertonia_ind,
      hypotonia_ind,
      overlapping_fingers,
      contractures_and_camptodactyly_of_the_left_hand,
      syndactyly_between_2nd_and_3rd_toes,
      contractures_and_camptodactyly_of_fingers_and_toes,
      contractures_of_fingers,
      partial_vocal_cord_paresis,
      recidivating_respiratory_infections,
      recurrent_respiratory_and_urinary_tract_infections,
      post_mortem_brain,
      bilateral_vocal_cord_paralysis,
      feeding_intolerance_and_vocal_cord_paralysis,
      arthrogryposis_76,
      arthrogryposis_100,
      arthrogryposis_196,
      contractures_145,
      arthrogryposis_246,
      smpd4_variant,
      contractures_299,
      limb_hypotrophy,
      contractures_at_knees_and_elbows,
      micrognathia_flexed_deform_lower_limb_at_knee,
      multiple_joint_contractures,
      flexion_deformity_of_all_4_limbs,
      bilateral_cleft_lips,
      bilateral_cleft_lip,
      severely_diminished_dt_rs_in_lower_extremities,
      cleft_lip_b_l,
      family_hx,
      widely_spaced_nipples_and_rocker_bottom_feet,
      inspiratory_stridor,
      inspiratory_stridor_2,
      inspiratory_stridor_3,
      polyhydramnios,
      monochorionic_diamniotic_twin_pregnancy_polyhydramnios,
      coarse_facial_features,
      course_features,
      coarse_facial_features_2,
      x22_days_in_nicu_10_days_intubated_respiratory_distress_oligohydramnios,
      oligohydramnios,
      respiratory,
      required_n_cpap,
      respiratory_failure,
      on_and_off_on_oxygen,
      x22_days_in_nicu_10_days_intubated_respiratory_distress_oligohydramnios,
      tracheostomy_and_ventilatory_dependence,
      respiratory_distress,
      hypotonia_104,
      hypotonia_118,
      minimal_body_movements,
      tracheostomy_and_ventilatory_dependence,
      s_p_tracheostomy,
      large_ears,
      simple_helices,
      prominent_ears,
      low_set_ears,
      protruding_ears,
      low_set_and_posteriorly_rotated_ears,
      dysmorphic_low_set_ears,
      posteriorly_angulated_ears,
      large_ears,
      prominent_ears,
      protruding_ears,
      low_set_and_posteriorly_rotated_ears,
      posteriorly_angulated_ears,
      long_philtrum,
      prominent_pillars_of_philtrum,
      prominent_philtrum,
      thin_upper_lip,
      upper_lip_tenting,
      thin_lips_2,
      v_shaped_upper_lip,
      suspect_hypomyelination,
      delayed_myelination,
      hypomyelination_on_repeat_mri,
      severe_global_hypomyelination,
      nearly_absent_myelination,
      hypertonia,
      hypertonicity,
      cerebellar_hypoplasia_93,
      cerebellar_hypoplasia_and_smooth_brain,
      brainstem_and_cerebellar_hypoplasia,
      cerebellar_hypoplasia_267,
      short_palpebral_fissures,
      down_slanting_and_short_palpebral_fissures,
      epicanthal_folds,
      epicanthic_folds,
      fed_through_ng_tube_then_gastrostomy_tube_placed,
      tube_feeding,
      terminated,
      locus,
      no_98,
      apgas_scores_5_7_7_dyspnea,
      seizures,
      dysmorphic_features,
      dysmorphism,
      patent_ductus_arteriosus,
      patent_ductus_arteriosus_and_interatrial_defect_requiring_catheterism,
      persistent_ductus_arteriosus_at_birth,
      small_anterior_fontanel,
      small_af,
      receding_forehead,
      high_forehead,
      no_223,
      tracheo_laryngomalacia,
      laryngomalacia,
      large,
      gerd,
      ger,
      standard_chromosome_analysis_47_xyy,
      no_focal_changes_in_brain,
      thin_cc,
      thin_corpus_callosum,
      thin_corpus_callosum_2
    )
  ) |>
  dplyr::select(
    id,
    family,
    individual,
    deceased,
    survival_time,
    variant_type,
    locus_1,
    locus_2,
    gender,
    ethnicity,
    consanguineous,
    termination,
    birth_gestation,
    route_vaginal_vs_c_sect,
    birth_weight,
    birth_ofc,
    birth_length,
    age_at_demise,
    age_at_last_follow_up,
    ends_with('ind'),
    everything()
  ) |> 
  dplyr::mutate(across(where(is.character), as.factor),
                across(c(1, 54:85), as.character),
                across(where(is.integer), as.factor))

usethis::use_data(smpd4_phenotype, overwrite = TRUE)
