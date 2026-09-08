:- encoding(utf8).

%% =============================================================================
%% Reference evidence ontology and clinical-rule safety gate
%% Generated from the locally supplied reference corpus on 2026-08-31.
%%
%% Four ontology views:
%%   object:       evidence_document/1
%%   attribute:    evidence_title/2, evidence_type/2, evidence_year/2, ...
%%   relationship: evidence_relation/3, supports_domain/2
%%   instance:     each ev_* atom below is one evidence-document instance
%%
%% IMPORTANT: verified_metadata means that the bibliographic fields were located
%% in the supplied document.  It does NOT mean that every clinical fact in the
%% main knowledge base has been verified against the document.
%% =============================================================================

:- dynamic evidence_review_status/2.
:- dynamic clinical_rule_review_status/2.
:- dynamic clinical_rule_enabled_override/1.
:- discontiguous evidence_document/1.
:- discontiguous evidence_type/2.
:- discontiguous evidence_title/2.
:- discontiguous evidence_year/2.
:- discontiguous evidence_version/2.
:- discontiguous evidence_effective_date/2.
:- discontiguous evidence_doi/2.
:- discontiguous evidence_url/2.
:- discontiguous evidence_isbn/2.
:- discontiguous evidence_publisher/2.
:- discontiguous evidence_license_status/2.
:- discontiguous evidence_accessed_date/2.
:- discontiguous evidence_registration/2.
:- discontiguous evidence_source_file/2.
:- discontiguous evidence_metadata_status/2.
:- discontiguous evidence_content_status/2.
:- discontiguous evidence_relation/3.
:- discontiguous supports_domain/2.
:- discontiguous not_authoritative_for/2.

%% --- Evidence class hierarchy ------------------------------------------------

evidence_class(clinical_guideline, evidence_document).
evidence_class(expert_consensus, evidence_document).
evidence_class(standard, evidence_document).
evidence_class(surveillance_report, evidence_document).
evidence_class(validation_study, evidence_document).
evidence_class(translation, evidence_document).
evidence_class(handbook, evidence_document).
evidence_class(bibliography, evidence_document).
evidence_class(link_registry, evidence_document).
evidence_class(priority_list, evidence_document).
evidence_class(reference_book, evidence_document).
evidence_class(web_guidance, evidence_document).

%% --- Locally supplied evidence instances ------------------------------------

evidence_document(ev_ssc_2021_original).
evidence_type(ev_ssc_2021_original, clinical_guideline).
evidence_title(ev_ssc_2021_original, 'Surviving Sepsis Campaign: International Guidelines for Management of Sepsis and Septic Shock 2021').
evidence_year(ev_ssc_2021_original, 2021).
evidence_doi(ev_ssc_2021_original, '10.1007/s00134-021-06506-y').
evidence_source_file(ev_ssc_2021_original, 'International guidelines for management of sepsis and septic .pdf').
evidence_metadata_status(ev_ssc_2021_original, verified_metadata).
evidence_content_status(ev_ssc_2021_original, pending_fact_level_mapping).
supports_domain(ev_ssc_2021_original, sepsis_workflow).
not_authoritative_for(ev_ssc_2021_original, pathogen_specific_regimen_without_ast).

evidence_document(ev_ssc_2021_cn_quick_translation).
evidence_type(ev_ssc_2021_cn_quick_translation, translation).
evidence_title(ev_ssc_2021_cn_quick_translation, '拯救脓毒症运动：2021年国际脓毒症和脓毒性休克管理指南（指南快译）').
evidence_year(ev_ssc_2021_cn_quick_translation, 2021).
evidence_doi(ev_ssc_2021_cn_quick_translation, '10.3760/cma.j.issn.1671-0282.2021.11.003').
evidence_source_file(ev_ssc_2021_cn_quick_translation, '拯救脓毒症运动：2021年国际脓毒症和脓毒性休克管理指南.pdf').
evidence_metadata_status(ev_ssc_2021_cn_quick_translation, verified_metadata).
evidence_content_status(ev_ssc_2021_cn_quick_translation, secondary_translation_use_original_for_rules).
evidence_relation(ev_ssc_2021_cn_quick_translation, translation_of, ev_ssc_2021_original).
supports_domain(ev_ssc_2021_cn_quick_translation, sepsis_workflow_reference_only).

evidence_document(ev_idsa_amr_2026_supplement).
evidence_type(ev_idsa_amr_2026_supplement, clinical_guideline_supplement).
evidence_title(ev_idsa_amr_2026_supplement, 'IDSA 2026 Guidance on the Treatment of Antimicrobial-Resistant Gram-Negative Infections: Supplemental Material').
evidence_year(ev_idsa_amr_2026_supplement, 2026).
evidence_url(ev_idsa_amr_2026_supplement, 'https://www.idsociety.org/practice-guideline/amr-guidance/').
evidence_source_file(ev_idsa_amr_2026_supplement, 'amr-guidance-supplemental-material.pdf').
evidence_metadata_status(ev_idsa_amr_2026_supplement, verified_metadata).
evidence_content_status(ev_idsa_amr_2026_supplement, pending_fact_level_mapping).
supports_domain(ev_idsa_amr_2026_supplement, amr_dosing_with_normal_renal_and_hepatic_function).
not_authoritative_for(ev_idsa_amr_2026_supplement, individualized_dose_without_patient_and_tdm_data).

evidence_document(ev_idsa_amr_2026_guidance).
evidence_type(ev_idsa_amr_2026_guidance, clinical_guideline).
evidence_title(ev_idsa_amr_2026_guidance, 'Infectious Diseases Society of America 2026 Guidance on the Treatment of Antimicrobial-Resistant Gram-Negative Infections').
evidence_year(ev_idsa_amr_2026_guidance, 2026).
evidence_version(ev_idsa_amr_2026_guidance, current_as_of_2026_03_01).
evidence_url(ev_idsa_amr_2026_guidance, 'https://www.idsociety.org/practice-guideline/amr-guidance/').
evidence_source_file(ev_idsa_amr_2026_guidance, 'amr-guidance-update.pdf').
evidence_metadata_status(ev_idsa_amr_2026_guidance, verified_metadata).
evidence_content_status(ev_idsa_amr_2026_guidance, partial_general_process_mapping_pending_domain_review).
evidence_relation(ev_idsa_amr_2026_supplement, supplements, ev_idsa_amr_2026_guidance).
supports_domain(ev_idsa_amr_2026_guidance, esbl_ampc_cre_dtr_pa_crab_stenotrophomonas_treatment).
not_authoritative_for(ev_idsa_amr_2026_guidance, unadapted_use_outside_united_states).
not_authoritative_for(ev_idsa_amr_2026_guidance, empiric_regimen_selection).

%% Antimicrobial susceptibility testing standards.  The uploaded standards are
%% registered here as versioned evidence; their tables have not yet been copied
%% into executable breakpoint facts.
evidence_document(ev_clsi_m100_ed36_2026).
evidence_type(ev_clsi_m100_ed36_2026, standard).
evidence_title(ev_clsi_m100_ed36_2026, 'Performance Standards for Antimicrobial Susceptibility Testing').
evidence_year(ev_clsi_m100_ed36_2026, 2026).
evidence_version(ev_clsi_m100_ed36_2026, 'CLSI M100-Ed36').
evidence_isbn(ev_clsi_m100_ed36_2026, '978-1-68440-306-6').
evidence_publisher(ev_clsi_m100_ed36_2026, 'Clinical and Laboratory Standards Institute').
evidence_source_file(ev_clsi_m100_ed36_2026, 'CLSI-M-100-Ed-36-2026-1.pdf').
evidence_metadata_status(ev_clsi_m100_ed36_2026, verified_metadata).
evidence_content_status(ev_clsi_m100_ed36_2026, pending_breakpoint_table_reconciliation).
evidence_license_status(ev_clsi_m100_ed36_2026, licensed_copy_no_bulk_reproduction).
supports_domain(ev_clsi_m100_ed36_2026, antimicrobial_susceptibility_interpretation).

evidence_document(ev_eucast_breakpoints_v16_1_2026).
evidence_type(ev_eucast_breakpoints_v16_1_2026, standard).
evidence_title(ev_eucast_breakpoints_v16_1_2026, 'EUCAST Breakpoint Tables for Interpretation of MICs and Zone Diameters').
evidence_year(ev_eucast_breakpoints_v16_1_2026, 2026).
evidence_version(ev_eucast_breakpoints_v16_1_2026, '16.1').
evidence_effective_date(ev_eucast_breakpoints_v16_1_2026, date(2026, 6, 24)).
evidence_url(ev_eucast_breakpoints_v16_1_2026, 'https://www.eucast.org/clinical_breakpoints').
evidence_source_file(ev_eucast_breakpoints_v16_1_2026, 'v_16.1_Breakpoint_Tables.pdf').
evidence_metadata_status(ev_eucast_breakpoints_v16_1_2026, verified_metadata).
evidence_content_status(ev_eucast_breakpoints_v16_1_2026, pending_breakpoint_table_reconciliation).
supports_domain(ev_eucast_breakpoints_v16_1_2026, antimicrobial_susceptibility_interpretation).

evidence_document(ev_eucast_resistance_mechanisms_v2_01_2017).
evidence_type(ev_eucast_resistance_mechanisms_v2_01_2017, standard).
evidence_title(ev_eucast_resistance_mechanisms_v2_01_2017, 'EUCAST Guidelines for Detection of Resistance Mechanisms and Specific Resistances of Clinical and/or Epidemiological Importance').
evidence_year(ev_eucast_resistance_mechanisms_v2_01_2017, 2017).
evidence_version(ev_eucast_resistance_mechanisms_v2_01_2017, '2.01').
evidence_source_file(ev_eucast_resistance_mechanisms_v2_01_2017, 'EUCAST_detection_of_resistance_mechanisms_170711.pdf').
evidence_metadata_status(ev_eucast_resistance_mechanisms_v2_01_2017, verified_metadata).
evidence_content_status(ev_eucast_resistance_mechanisms_v2_01_2017, historical_method_guidance_requires_current_version_check).
supports_domain(ev_eucast_resistance_mechanisms_v2_01_2017, resistance_mechanism_detection).
not_authoritative_for(ev_eucast_resistance_mechanisms_v2_01_2017, current_clinical_breakpoints).

evidence_document(ev_eucast_expert_rules_v3_3_2024_enterobacterales).
evidence_type(ev_eucast_expert_rules_v3_3_2024_enterobacterales, standard).
evidence_title(ev_eucast_expert_rules_v3_3_2024_enterobacterales, 'EUCAST Expert Rules on Enterobacterales').
evidence_year(ev_eucast_expert_rules_v3_3_2024_enterobacterales, 2024).
evidence_version(ev_eucast_expert_rules_v3_3_2024_enterobacterales, '3.3').
evidence_source_file(ev_eucast_expert_rules_v3_3_2024_enterobacterales, 'ExpertRules_V3.3_20240630_Enterobacterales.pdf').
evidence_metadata_status(ev_eucast_expert_rules_v3_3_2024_enterobacterales, verified_metadata).
evidence_content_status(ev_eucast_expert_rules_v3_3_2024_enterobacterales, pending_rule_level_mapping).
supports_domain(ev_eucast_expert_rules_v3_3_2024_enterobacterales, enterobacterales_ast_expert_rules).

evidence_document(ev_eucast_screening_2021).
evidence_type(ev_eucast_screening_2021, standard).
evidence_title(ev_eucast_screening_2021, 'EUCAST Phenotypic Screening Tests to Detect or Exclude Resistance of Clinical Relevance').
evidence_year(ev_eucast_screening_2021, 2021).
evidence_version(ev_eucast_screening_2021, first_published_2021_12_01).
evidence_source_file(ev_eucast_screening_2021, 'Screening_to_detect_and_exclude_resistance_2022_08_22.pdf').
evidence_metadata_status(ev_eucast_screening_2021, verified_metadata).
evidence_content_status(ev_eucast_screening_2021, pending_rule_level_mapping).
supports_domain(ev_eucast_screening_2021, phenotypic_resistance_screening).

evidence_document(ev_eucast_expected_resistant_v1_2_2023).
evidence_type(ev_eucast_expected_resistant_v1_2_2023, standard).
evidence_title(ev_eucast_expected_resistant_v1_2_2023, 'EUCAST Expected Resistant Phenotypes').
evidence_year(ev_eucast_expected_resistant_v1_2_2023, 2023).
evidence_version(ev_eucast_expected_resistant_v1_2_2023, '1.2').
evidence_source_file(ev_eucast_expected_resistant_v1_2_2023, 'Expected_Resistant_Phenotypes_v1.2_20230113.pdf').
evidence_metadata_status(ev_eucast_expected_resistant_v1_2_2023, verified_metadata).
evidence_content_status(ev_eucast_expected_resistant_v1_2_2023, pending_species_agent_mapping).
supports_domain(ev_eucast_expected_resistant_v1_2_2023, ast_result_validation).

evidence_document(ev_eucast_expected_susceptible_v1_1_2022).
evidence_type(ev_eucast_expected_susceptible_v1_1_2022, standard).
evidence_title(ev_eucast_expected_susceptible_v1_1_2022, 'EUCAST Expected Susceptible Phenotypes').
evidence_year(ev_eucast_expected_susceptible_v1_1_2022, 2022).
evidence_version(ev_eucast_expected_susceptible_v1_1_2022, '1.1').
evidence_source_file(ev_eucast_expected_susceptible_v1_1_2022, 'Expected_Susceptible_Phenotypes_Tables_v1.1_20220325.pdf').
evidence_metadata_status(ev_eucast_expected_susceptible_v1_1_2022, verified_metadata).
evidence_content_status(ev_eucast_expected_susceptible_v1_1_2022, pending_species_agent_mapping).
supports_domain(ev_eucast_expected_susceptible_v1_1_2022, ast_result_validation).

evidence_document(ev_who_bppl_2024).
evidence_type(ev_who_bppl_2024, priority_list).
evidence_title(ev_who_bppl_2024, 'WHO Bacterial Priority Pathogens List, 2024').
evidence_year(ev_who_bppl_2024, 2024).
evidence_isbn(ev_who_bppl_2024, '978-92-4-009346-1').
evidence_publisher(ev_who_bppl_2024, 'World Health Organization').
evidence_url(ev_who_bppl_2024, 'https://www.who.int/publications/i/item/9789240093461').
evidence_metadata_status(ev_who_bppl_2024, verified_official_online_metadata).
evidence_content_status(ev_who_bppl_2024, verified_scope_framework_not_treatment_guidance).
evidence_license_status(ev_who_bppl_2024, 'CC BY-NC-SA 3.0 IGO').
evidence_accessed_date(ev_who_bppl_2024, date(2026, 8, 31)).
supports_domain(ev_who_bppl_2024, global_amr_pathogen_prioritization).
not_authoritative_for(ev_who_bppl_2024, patient_specific_treatment).

evidence_document(ev_who_aware_book_2022).
evidence_type(ev_who_aware_book_2022, reference_book).
evidence_title(ev_who_aware_book_2022, 'The WHO AWaRe (Access, Watch, Reserve) Antibiotic Book').
evidence_year(ev_who_aware_book_2022, 2022).
evidence_publisher(ev_who_aware_book_2022, 'World Health Organization').
evidence_url(ev_who_aware_book_2022, 'https://www.who.int/publications/i/item/9789240062382').
evidence_metadata_status(ev_who_aware_book_2022, verified_official_online_metadata).
evidence_content_status(ev_who_aware_book_2022, pending_syndrome_and_fact_level_mapping).
evidence_accessed_date(ev_who_aware_book_2022, date(2026, 8, 31)).
supports_domain(ev_who_aware_book_2022, common_infection_antibiotic_selection_route_and_duration).
not_authoritative_for(ev_who_aware_book_2022, resistant_pathogen_targeted_regimen_without_ast).

evidence_document(ev_cdc_mdro_management_2024_web).
evidence_type(ev_cdc_mdro_management_2024_web, web_guidance).
evidence_title(ev_cdc_mdro_management_2024_web, 'Management of Multidrug-Resistant Organisms in Healthcare Settings').
evidence_year(ev_cdc_mdro_management_2024_web, 2024).
evidence_publisher(ev_cdc_mdro_management_2024_web, 'US Centers for Disease Control and Prevention').
evidence_url(ev_cdc_mdro_management_2024_web, 'https://www.cdc.gov/infection-control/hcp/mdro-management/').
evidence_metadata_status(ev_cdc_mdro_management_2024_web, verified_official_online_metadata).
evidence_content_status(ev_cdc_mdro_management_2024_web, current_web_wrapper_contains_legacy_and_containment_guidance_requires_section_mapping).
evidence_accessed_date(ev_cdc_mdro_management_2024_web, date(2026, 8, 31)).
supports_domain(ev_cdc_mdro_management_2024_web, healthcare_mdro_prevention_and_containment).
not_authoritative_for(ev_cdc_mdro_management_2024_web, patient_specific_antimicrobial_regimen).

evidence_document(ev_cre_cn_2026).
evidence_type(ev_cre_cn_2026, expert_consensus).
evidence_title(ev_cre_cn_2026, '碳青霉烯类耐药肠杆菌目感染的实验室诊断和防治专家共识（2026版）').
evidence_year(ev_cre_cn_2026, 2026).
evidence_doi(ev_cre_cn_2026, '10.3760/cma.j.cn112137-20260128-00313').
evidence_registration(ev_cre_cn_2026, 'PREPARE-2026CN561').
evidence_source_file(ev_cre_cn_2026, '碳青霉烯类耐药肠杆菌目感染的实验室诊断和防治专家共识（2026版）.pdf').
evidence_metadata_status(ev_cre_cn_2026, verified_metadata).
evidence_content_status(ev_cre_cn_2026, pending_fact_level_mapping).
supports_domain(ev_cre_cn_2026, cre_diagnosis_treatment_prevention).

evidence_document(ev_crpa_cn_2026).
evidence_type(ev_crpa_cn_2026, clinical_guideline).
evidence_title(ev_crpa_cn_2026, '碳青霉烯耐药铜绿假单胞菌感染诊治指南（2026版）').
evidence_year(ev_crpa_cn_2026, 2026).
evidence_doi(ev_crpa_cn_2026, '10.3760/cma.j.cn112137-20250721-01803').
evidence_source_file(ev_crpa_cn_2026, '碳青霉烯耐药铜绿假单胞菌感染诊治指南（2026版）.pdf').
evidence_metadata_status(ev_crpa_cn_2026, verified_metadata).
evidence_content_status(ev_crpa_cn_2026, pending_fact_level_mapping).
supports_domain(ev_crpa_cn_2026, crpa_diagnosis_and_treatment).

evidence_document(ev_esbl_cn_2025).
evidence_type(ev_esbl_cn_2025, expert_consensus).
evidence_title(ev_esbl_cn_2025, '临床产超广谱β-内酰胺酶肠杆菌目细菌感染应对策略专家共识（2025）').
evidence_year(ev_esbl_cn_2025, 2025).
evidence_doi(ev_esbl_cn_2025, '10.12290/xhyxzz.2025-0494').
evidence_source_file(ev_esbl_cn_2025, '临床产超广谱β-内酰胺酶肠杆菌目细菌感染应对策略专家共识(2025).pdf').
evidence_metadata_status(ev_esbl_cn_2025, verified_metadata).
evidence_content_status(ev_esbl_cn_2025, pending_fact_level_mapping).
supports_domain(ev_esbl_cn_2025, esbl_enterobacterales_full_pathway).

evidence_document(ev_novel_bli_cn_2026).
evidence_type(ev_novel_bli_cn_2026, expert_consensus).
evidence_title(ev_novel_bli_cn_2026, '新型β-内酰胺酶抑制剂复方制剂临床应用专家共识').
evidence_year(ev_novel_bli_cn_2026, 2026).
evidence_doi(ev_novel_bli_cn_2026, '10.3760/cma.j.cn311365-20260111-00013').
evidence_registration(ev_novel_bli_cn_2026, 'PREPARE-2025CN1407').
evidence_source_file(ev_novel_bli_cn_2026, '新型β-内酰胺酶抑制剂复方制剂临床应用专家共识.pdf').
evidence_metadata_status(ev_novel_bli_cn_2026, verified_metadata).
evidence_content_status(ev_novel_bli_cn_2026, ahead_of_print_pending_fact_level_mapping).
supports_domain(ev_novel_bli_cn_2026, mechanism_directed_bli_selection).

evidence_document(ev_hematology_cre_cn_2025).
evidence_type(ev_hematology_cre_cn_2025, expert_consensus).
evidence_title(ev_hematology_cre_cn_2025, '血液肿瘤患者碳青霉烯类耐药肠杆菌科细菌（CRE）感染的诊治与防控中国专家共识（2025年版）').
evidence_year(ev_hematology_cre_cn_2025, 2025).
evidence_doi(ev_hematology_cre_cn_2025, '10.3760/cma.j.cn121090-20250403-00162').
evidence_source_file(ev_hematology_cre_cn_2025, '血液肿瘤患者碳青霉烯类耐药肠杆菌科细菌（CRE）感染的诊治与防控中国专家共识（2025年版）.pdf').
evidence_metadata_status(ev_hematology_cre_cn_2025, verified_metadata).
evidence_content_status(ev_hematology_cre_cn_2025, pending_fact_level_mapping).
supports_domain(ev_hematology_cre_cn_2025, hematologic_malignancy_cre).

evidence_document(ev_wses_score_validation_2015).
evidence_type(ev_wses_score_validation_2015, validation_study).
evidence_title(ev_wses_score_validation_2015, 'Global validation of the WSES Sepsis Severity Score for patients with complicated intra-abdominal infections: a prospective multicentre study').
evidence_year(ev_wses_score_validation_2015, 2015).
evidence_doi(ev_wses_score_validation_2015, '10.1186/s13017-015-0055-0').
evidence_source_file(ev_wses_score_validation_2015, 'Global validation of the WSES Sepsis Severity Score for patients withcomplicated intra-abdominal infectionsa prospective multicentre study.pdf.pdf').
evidence_metadata_status(ev_wses_score_validation_2015, verified_metadata).
evidence_content_status(ev_wses_score_validation_2015, validation_study_only).
supports_domain(ev_wses_score_validation_2015, intra_abdominal_severity_stratification).
not_authoritative_for(ev_wses_score_validation_2015, antimicrobial_regimen_selection).

evidence_document(ev_ispd_pediatric_peritonitis_2024_cn_translation).
evidence_type(ev_ispd_pediatric_peritonitis_2024_cn_translation, translation).
evidence_title(ev_ispd_pediatric_peritonitis_2024_cn_translation, '儿童腹膜透析相关感染预防与管理临床实践指南：2024年更新版（中文翻译）').
evidence_year(ev_ispd_pediatric_peritonitis_2024_cn_translation, 2024).
evidence_doi(ev_ispd_pediatric_peritonitis_2024_cn_translation, '10.1177/08968608241274096').
evidence_source_file(ev_ispd_pediatric_peritonitis_2024_cn_translation, 'ISPD-儿童腹膜炎指南2024-Pediatric-peritonitis-guideline-2024中文-Chinese-翻译.pdf').
evidence_metadata_status(ev_ispd_pediatric_peritonitis_2024_cn_translation, verified_metadata).
evidence_content_status(ev_ispd_pediatric_peritonitis_2024_cn_translation, unofficial_translation_use_original_for_rules).
supports_domain(ev_ispd_pediatric_peritonitis_2024_cn_translation, pediatric_peritoneal_dialysis_peritonitis).

evidence_document(ev_orthopedic_ssi_cn_2026).
evidence_type(ev_orthopedic_ssi_cn_2026, expert_consensus).
evidence_title(ev_orthopedic_ssi_cn_2026, '骨科手术部位感染创面预防与治疗的专家共识（2026版）').
evidence_year(ev_orthopedic_ssi_cn_2026, 2026).
evidence_doi(ev_orthopedic_ssi_cn_2026, '10.3760/cma.j.cn501225-20250515-00228').
evidence_source_file(ev_orthopedic_ssi_cn_2026, '骨科手术部位感染创面预防与治疗的专家共识2026.pdf').
evidence_metadata_status(ev_orthopedic_ssi_cn_2026, verified_metadata).
evidence_content_status(ev_orthopedic_ssi_cn_2026, pending_fact_level_mapping).
supports_domain(ev_orthopedic_ssi_cn_2026, orthopedic_ssi_workflow).
not_authoritative_for(ev_orthopedic_ssi_cn_2026, gnb_specific_regimen_without_microbiology).

evidence_document(ev_pediatric_mpp_cn_2025).
evidence_type(ev_pediatric_mpp_cn_2025, clinical_guideline).
evidence_title(ev_pediatric_mpp_cn_2025, '儿童肺炎支原体肺炎诊疗指南（2025年版）').
evidence_year(ev_pediatric_mpp_cn_2025, 2025).
evidence_source_file(ev_pediatric_mpp_cn_2025, '儿童肺炎支原体肺炎诊疗指南（2025年版）.pdf').
evidence_metadata_status(ev_pediatric_mpp_cn_2025, verified_metadata).
evidence_content_status(ev_pediatric_mpp_cn_2025, out_of_scope_for_gram_negative_bacteria_core).
not_authoritative_for(ev_pediatric_mpp_cn_2025, gram_negative_bacteria_treatment).

evidence_document(ev_burn_fungal_cn_2024).
evidence_type(ev_burn_fungal_cn_2024, clinical_guideline).
evidence_title(ev_burn_fungal_cn_2024, '烧伤侵袭性真菌感染诊断与防治实践指南（2024版）').
evidence_year(ev_burn_fungal_cn_2024, 2024).
evidence_doi(ev_burn_fungal_cn_2024, '10.3760/cma.j.cn501225-20240103-00003').
evidence_source_file(ev_burn_fungal_cn_2024, '烧伤侵袭性真菌感染诊断与防治实践指南（2024版）.pdf').
evidence_metadata_status(ev_burn_fungal_cn_2024, verified_metadata).
evidence_content_status(ev_burn_fungal_cn_2024, out_of_scope_for_gram_negative_bacteria_core).
not_authoritative_for(ev_burn_fungal_cn_2024, antibacterial_regimen_selection).

evidence_document(ev_handbook_gnb_2ed).
evidence_type(ev_handbook_gnb_2ed, handbook).
evidence_title(ev_handbook_gnb_2ed, '耐药革兰氏阴性菌感染诊疗手册（第2版）').
evidence_year(ev_handbook_gnb_2ed, 2022).
evidence_version(ev_handbook_gnb_2ed, second_edition).
evidence_isbn(ev_handbook_gnb_2ed, '978-7-117-33050-3').
evidence_publisher(ev_handbook_gnb_2ed, '人民卫生出版社').
evidence_source_file(ev_handbook_gnb_2ed, '耐药革兰氏阴性菌感染诊疗手册第2版.pdf').
evidence_metadata_status(ev_handbook_gnb_2ed, verified_metadata_and_toc).
evidence_content_status(ev_handbook_gnb_2ed, scanned_pdf_requires_ocr_for_fact_mapping).
supports_domain(ev_handbook_gnb_2ed, gnb_resistance_ast_drugs_targeted_treatment_syndromes_infection_control).
not_authoritative_for(ev_handbook_gnb_2ed, any_clinical_rule_until_ocr_and_page_verification).

%% Verified from the printed table of contents only.  These locators support
%% targeted OCR scheduling; they do not assert the clinical content of a page.
handbook_toc_locator(ev_handbook_gnb_2ed, resistance_evolution_and_mechanisms, printed_page(1)).
handbook_toc_locator(ev_handbook_gnb_2ed, laboratory_testing, printed_page(23)).
handbook_toc_locator(ev_handbook_gnb_2ed, esbl_laboratory_detection, printed_page(39)).
handbook_toc_locator(ev_handbook_gnb_2ed, ampc_laboratory_detection, printed_page(40)).
handbook_toc_locator(ev_handbook_gnb_2ed, carbapenemase_laboratory_detection, printed_page(41)).
handbook_toc_locator(ev_handbook_gnb_2ed, common_antibacterials_and_dosing, printed_page(49)).
handbook_toc_locator(ev_handbook_gnb_2ed, pk_pd_principles, printed_page(93)).
handbook_toc_locator(ev_handbook_gnb_2ed, combination_therapy_principles, printed_page(97)).
handbook_toc_locator(ev_handbook_gnb_2ed, targeted_treatment, printed_page(102)).
handbook_toc_locator(ev_handbook_gnb_2ed, esbl_enterobacterales_treatment, printed_page(104)).
handbook_toc_locator(ev_handbook_gnb_2ed, ampc_enterobacterales_treatment, printed_page(106)).
handbook_toc_locator(ev_handbook_gnb_2ed, carbapenemase_enterobacterales_treatment, printed_page(107)).
handbook_toc_locator(ev_handbook_gnb_2ed, resistant_acinetobacter_baumannii_treatment, printed_page(112)).
handbook_toc_locator(ev_handbook_gnb_2ed, resistant_pseudomonas_aeruginosa_treatment, printed_page(117)).
handbook_toc_locator(ev_handbook_gnb_2ed, resistant_stenotrophomonas_maltophilia_treatment, printed_page(120)).
handbook_toc_locator(ev_handbook_gnb_2ed, lower_respiratory_tract_infection, printed_page(127)).
handbook_toc_locator(ev_handbook_gnb_2ed, bloodstream_infection, printed_page(138)).
handbook_toc_locator(ev_handbook_gnb_2ed, intra_abdominal_infection, printed_page(146)).
handbook_toc_locator(ev_handbook_gnb_2ed, febrile_neutropenia, printed_page(152)).
handbook_toc_locator(ev_handbook_gnb_2ed, urinary_tract_infection, printed_page(159)).
handbook_toc_locator(ev_handbook_gnb_2ed, skin_and_soft_tissue_infection, printed_page(164)).
handbook_toc_locator(ev_handbook_gnb_2ed, meningitis, printed_page(171)).
handbook_toc_locator(ev_handbook_gnb_2ed, infection_prevention_and_control, printed_page(179)).

evidence_document(ev_user_bibliography_docx).
evidence_type(ev_user_bibliography_docx, bibliography).
evidence_title(ev_user_bibliography_docx, '革兰氏阴性菌参考文献').
evidence_source_file(ev_user_bibliography_docx, '革兰氏阴性菌参考文献.docx').
evidence_metadata_status(ev_user_bibliography_docx, extracted_not_source_verified).
evidence_content_status(ev_user_bibliography_docx, bibliography_only).
not_authoritative_for(ev_user_bibliography_docx, clinical_or_ontology_fact_until_each_citation_verified).

evidence_document(ev_official_link_registry).
evidence_type(ev_official_link_registry, link_registry).
evidence_title(ev_official_link_registry, '官方原文链接').
evidence_source_file(ev_official_link_registry, '官方原文链接.txt').
evidence_metadata_status(ev_official_link_registry, extracted).
evidence_content_status(ev_official_link_registry, navigation_only).
not_authoritative_for(ev_official_link_registry, clinical_fact).

%% --- AST provenance contract ------------------------------------------------

%% A breakpoint is not a timeless property of a drug.  Every future executable
%% AST fact must carry the authority, document version, organism/group, method,
%% specimen or indication context where applicable, and interpretation date.
ast_required_field(authority).
ast_required_field(standard_version).
ast_required_field(organism_or_group).
ast_required_field(agent).
ast_required_field(test_method).
ast_required_field(breakpoint_type).
ast_required_field(interpretation_date).

ast_standard_registered(clsi, 'M100-Ed36', ev_clsi_m100_ed36_2026).
ast_standard_registered(eucast, '16.1', ev_eucast_breakpoints_v16_1_2026).

%% Section 8 of the merged legacy KB predates this provenance contract.  Its
%% MIC/breakpoint rows remain non-executable until reconciled row by row against
%% one named standard; CLSI and EUCAST values must never be silently combined.
ast_dataset_status(merged_kb_section_8, pending_row_level_standard_reconciliation).
ast_dataset_prohibition(merged_kb_section_8, no_clinical_interpretation).
ast_dataset_prohibition(merged_kb_section_8, no_cross_standard_value_merging).

%% --- Safety gate ------------------------------------------------------------

%% No supplied document is automatically approved for executable treatment
%% rules. A document becomes usable only after fact-level page/table mapping and
%% independent domain review have both been recorded.
safe_for_clinical_rule(Evidence) :-
    evidence_content_status(Evidence, Status),
    Status == fact_level_verified,
    evidence_review_status(Evidence, approved_by_domain_expert).

clinical_rule_enabled(Rule) :-
    clinical_rule_evidence_status(Rule, Status),
    Status == fact_level_verified,
    clinical_rule_review_status(Rule, approved_by_domain_expert),
    clinical_rule_enabled_override(Rule).

clinical_rule_evidence_status(recommend_empiric_6, pending_fact_level_mapping).
clinical_rule_evidence_status(recommend_targeted_6, pending_fact_level_mapping).
clinical_rule_evidence_status(recommend_all_tiers_2, pending_fact_level_mapping).
clinical_rule_evidence_status(get_dosing_6, pending_patient_and_label_contract).
clinical_rule_evidence_status(renal_dose_5, pending_patient_and_label_contract).
clinical_rule_evidence_status(mbl_effective_2, unsafe_without_ast_and_site_context).
clinical_rule_evidence_status(tissue_penetration_4, pending_pk_source_mapping).
clinical_rule_evidence_status(treatment_duration_5, pending_syndrome_source_mapping).
clinical_rule_evidence_status(can_de_escalate_5, pending_fact_level_mapping).
clinical_rule_evidence_status(list_effective_drugs_3, pending_fact_level_mapping).
clinical_rule_evidence_status(needs_combination_5, pending_fact_level_mapping).

clinical_rule_blocked(Rule, Status) :-
    clinical_rule_evidence_status(Rule, Status),
    Status \= fact_level_verified.

%% --- Contracts for predicates referenced by Section 26 ---------------------

:- dynamic contraindicated/2.
:- dynamic has_adjusted_dose/3.
:- dynamic has_adjusted_interval/3.
:- dynamic has_clinical_evidence/3.
:- dynamic has_dosing_interval/2.
:- dynamic has_drug_combo/2.
:- dynamic has_empiric_regimen/2.
:- dynamic has_renal_adjustment/2.
:- dynamic has_standard_dose/2.
:- dynamic has_susceptibility/3.
:- dynamic has_tier/2.
:- dynamic has_tissue_concentration/3.
:- dynamic has_tissue_penetration/3.

predicate_contract(contraindicated/2, [drug, patient_or_resistance_context], boolean_relation, missing_definition).
predicate_contract(has_adjusted_dose/3, [drug, renal_status, dose], data_relation, missing_definition).
predicate_contract(has_adjusted_interval/3, [drug, renal_status, interval], data_relation, missing_definition).
predicate_contract(has_clinical_evidence/3, [drug, pathogen, quality], evidence_relation, arity_mismatch_with_existing_2).
predicate_contract(has_dosing_interval/2, [drug, interval], data_relation, missing_definition).
predicate_contract(has_drug_combo/2, [regimen, drug_list], data_relation, missing_definition).
predicate_contract(has_empiric_regimen/2, [regimen, infection_site], data_relation, missing_definition).
predicate_contract(has_renal_adjustment/2, [drug, renal_status], data_relation, missing_definition).
predicate_contract(has_standard_dose/2, [drug, dose], data_relation, missing_definition).
predicate_contract(has_susceptibility/3, [result_or_isolate, drug, interpretation], ast_relation, arity_mismatch_with_existing_2).
predicate_contract(has_tier/2, [regimen, tier], classification_relation, missing_definition).
predicate_contract(has_tissue_concentration/3, [drug, site, concentration], pk_relation, missing_definition).
predicate_contract(has_tissue_penetration/3, [drug, site, level], pk_relation, missing_definition).
