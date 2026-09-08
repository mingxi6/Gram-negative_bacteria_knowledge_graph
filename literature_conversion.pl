:- encoding(utf8).

%% =============================================================================
%% Literature conversion registry and verified general clinical-process facts
%% Corpus audit date: 2026-08-31
%%
%% This file distinguishes file ingestion from clinical fact conversion.
%% A readable PDF is NOT treated as a fully converted clinical source.
%% No document in the supplied corpus currently satisfies all completion gates.
%% =============================================================================

:- discontiguous conversion_document/1.
:- discontiguous conversion_inventory/6.
:- discontiguous conversion_disposition/2.
:- discontiguous conversion_stage_completed/2.
:- discontiguous conversion_blocker/2.
:- discontiguous clinical_process_fact/1.
:- discontiguous process_fact_stage/2.
:- discontiguous process_fact_value/2.
:- discontiguous process_fact_evidence/3.

%% conversion_inventory(Evidence, Format, TotalPages, NonemptyTextPages,
%%                      ExtractedCharacters, Sha256).

conversion_document(ev_clsi_m100_ed36_2026).
conversion_inventory(ev_clsi_m100_ed36_2026, pdf, 436, 436, 831150, 'd95bf1075a01a7830015a85687d8f771844b3d7c57d39ff7040fcef37fe3acac').
conversion_disposition(ev_clsi_m100_ed36_2026, in_scope_not_fact_mapped).

conversion_document(ev_eucast_resistance_mechanisms_v2_01_2017).
conversion_inventory(ev_eucast_resistance_mechanisms_v2_01_2017, pdf, 43, 43, 124738, 'ca70a9343a371e6d73f2c6fcbc4a05ce4d65191947ac5e03e8f68293c76061c8').
conversion_disposition(ev_eucast_resistance_mechanisms_v2_01_2017, historical_source_requires_current_version_check).

conversion_document(ev_eucast_expected_resistant_v1_2_2023).
conversion_inventory(ev_eucast_expected_resistant_v1_2_2023, pdf, 8, 8, 11349, '7ff65909135b95e136c24bfd2d47c300cae78e5282ae3d0602d69770dcc27727').
conversion_disposition(ev_eucast_expected_resistant_v1_2_2023, in_scope_not_fact_mapped).

conversion_document(ev_eucast_expected_susceptible_v1_1_2022).
conversion_inventory(ev_eucast_expected_susceptible_v1_1_2022, pdf, 5, 5, 6349, '61ac13d9e8558e7d136ed2d4a605294ffeb16b5227e2fb290a17982d671226b8').
conversion_disposition(ev_eucast_expected_susceptible_v1_1_2022, in_scope_not_fact_mapped).

conversion_document(ev_eucast_expert_rules_v3_3_2024_enterobacterales).
conversion_inventory(ev_eucast_expert_rules_v3_3_2024_enterobacterales, pdf, 6, 6, 14054, 'd9a95d5525ac9dbb11a8797d2c02e5326ae3239c4bea17119425d6172631263d').
conversion_disposition(ev_eucast_expert_rules_v3_3_2024_enterobacterales, in_scope_not_fact_mapped).

conversion_document(ev_wses_score_validation_2015).
conversion_inventory(ev_wses_score_validation_2015, pdf, 8, 8, 38708, 'fd39330745b49df61b33237a78671d7e9bbd8568450f7c299820a2d869f8361c').
conversion_disposition(ev_wses_score_validation_2015, scope_limited_validation_study_not_treatment_guidance).

conversion_document(ev_ispd_pediatric_peritonitis_2024_cn_translation).
conversion_inventory(ev_ispd_pediatric_peritonitis_2024_cn_translation, pdf, 88, 88, 161463, '61ecf14cad5510fe7cf197f1b787f3237f96ba2eee38b3dd87971c77c6f9837c').
conversion_disposition(ev_ispd_pediatric_peritonitis_2024_cn_translation, translation_reference_only).
conversion_blocker(ev_ispd_pediatric_peritonitis_2024_cn_translation, original_authoritative_document_not_supplied).

conversion_document(ev_ssc_2021_original).
conversion_inventory(ev_ssc_2021_original, pdf, 67, 67, 356330, 'a078c9b64b7d1cb426cbb300208be220138078edfd6cfb8a10aefd81bef41ccd').
conversion_disposition(ev_ssc_2021_original, in_scope_not_fact_mapped).

conversion_document(ev_eucast_screening_2021).
conversion_inventory(ev_eucast_screening_2021, pdf, 3, 3, 6441, 'c0f7153f4a525f829a4bdba8f9d5029cf8c225358ba4b090b4afb9b78f33f4b7').
conversion_disposition(ev_eucast_screening_2021, in_scope_not_fact_mapped).

conversion_document(ev_idsa_amr_2026_supplement).
conversion_inventory(ev_idsa_amr_2026_supplement, pdf, 5, 5, 13928, 'd43dbff7b1d8c272bd1990b38438fbc3db929a2ac14b2c8ab84d6913ea587854').
conversion_disposition(ev_idsa_amr_2026_supplement, in_scope_not_fact_mapped).

conversion_document(ev_idsa_amr_2026_guidance).
conversion_inventory(ev_idsa_amr_2026_guidance, pdf, 140, 140, 362478, '00c8af8fb551fd1094e6d0f23c9198702f8cf5eb3437b9ef46a395806994df2a').
conversion_disposition(ev_idsa_amr_2026_guidance, partial_general_process_mapping_only).

conversion_document(ev_eucast_breakpoints_v16_1_2026).
conversion_inventory(ev_eucast_breakpoints_v16_1_2026, pdf, 123, 123, 303786, '925098e165792fed6c5a7476e649177fb2b75116db103f1a8068fc2f69a45de9').
conversion_disposition(ev_eucast_breakpoints_v16_1_2026, in_scope_not_fact_mapped).

conversion_document(ev_esbl_cn_2025).
conversion_inventory(ev_esbl_cn_2025, pdf, 18, 18, 48821, 'c7e79e5d707c8b00bd6374a26b1ea78ce62ef3f2f0662a70f156c0701c6c8f11').
conversion_disposition(ev_esbl_cn_2025, partial_legacy_mapping_requires_fact_review).

conversion_document(ev_pediatric_mpp_cn_2025).
conversion_inventory(ev_pediatric_mpp_cn_2025, pdf, 32, 32, 17915, '452e1442cbcae7231e1bac8f23031f84085a7e75aef347fac6d9a04162575b32').
conversion_disposition(ev_pediatric_mpp_cn_2025, excluded_not_gram_negative_bacteria_core).

conversion_document(ev_official_link_registry).
conversion_inventory(ev_official_link_registry, text, 0, 0, 447, '66f8f84a3bfc1e900b1b16068cd28367ee7c2e1d41381d791f2cd85a0ed701cd').
conversion_disposition(ev_official_link_registry, navigation_only_not_a_clinical_source).

conversion_document(ev_ssc_2021_cn_quick_translation).
conversion_inventory(ev_ssc_2021_cn_quick_translation, pdf, 5, 5, 10122, 'd3c279a75595349650cb93954647793eceb193742843a941a8f2feace063d0ed').
conversion_disposition(ev_ssc_2021_cn_quick_translation, translation_reference_only).

conversion_document(ev_novel_bli_cn_2026).
conversion_inventory(ev_novel_bli_cn_2026, pdf, 49, 49, 102905, '2cebd3f663b7fb2d79ab634485ae72daea3489ce6180a1342483e6a83b9459d0').
conversion_disposition(ev_novel_bli_cn_2026, ahead_of_print_not_fact_mapped).

conversion_document(ev_burn_fungal_cn_2024).
conversion_inventory(ev_burn_fungal_cn_2024, pdf, 14, 14, 60186, 'ef0820442289312e85530da95bf14342526896c19522334445a94b22bd2d12e6').
conversion_disposition(ev_burn_fungal_cn_2024, excluded_fungal_not_antibacterial_core).

conversion_document(ev_cre_cn_2026).
conversion_inventory(ev_cre_cn_2026, pdf, 16, 16, 57703, 'abc3d20d49c95e99b9fa7d1fc86f0e8929c14b0f8968c469ed188af479a6c4c4').
conversion_disposition(ev_cre_cn_2026, in_scope_not_fact_mapped).

conversion_document(ev_crpa_cn_2026).
conversion_inventory(ev_crpa_cn_2026, pdf, 17, 17, 63411, '8595b1e4f7a4e8bb188797ccc471752f137bf2042a7464f35852b4006ce6c9a4').
conversion_disposition(ev_crpa_cn_2026, in_scope_not_fact_mapped).

conversion_document(ev_handbook_gnb_2ed).
conversion_inventory(ev_handbook_gnb_2ed, scanned_pdf, 207, 0, 5274, '163931765e11be6e1ae07c414ae2f2ee3b366ece3ca8483768ac9c91f5c5be85').
conversion_disposition(ev_handbook_gnb_2ed, blocked_scanned_document).
conversion_blocker(ev_handbook_gnb_2ed, full_ocr_and_page_level_visual_verification_required).

conversion_document(ev_hematology_cre_cn_2025).
conversion_inventory(ev_hematology_cre_cn_2025, pdf, 13, 13, 45495, '144aead642b6d96c7267a3e5d260fc2ed9aebdfa27245deb7e615968383aa68b').
conversion_disposition(ev_hematology_cre_cn_2025, in_scope_not_fact_mapped).

conversion_document(ev_user_bibliography_docx).
conversion_inventory(ev_user_bibliography_docx, docx, 0, 0, 1247, '40df1a7272b6b107df7d19b5547f1664ccdf9612ad48e6c89881276de094b05d').
conversion_disposition(ev_user_bibliography_docx, bibliography_only_each_citation_requires_verification).

conversion_document(ev_orthopedic_ssi_cn_2026).
conversion_inventory(ev_orthopedic_ssi_cn_2026, pdf, 18, 18, 70795, 'f3b4250938df03daf5a0e3a080223ff1cd9e3cd6d487c357bfa16edb24977d98').
conversion_disposition(ev_orthopedic_ssi_cn_2026, in_scope_for_workflow_not_fact_mapped).

%% --- Completion contract ----------------------------------------------------

conversion_required_stage(local_file_registered).
conversion_required_stage(metadata_verified).
conversion_required_stage(text_or_ocr_verified).
conversion_required_stage(section_inventory_complete).
conversion_required_stage(fact_level_page_mapping_complete).
conversion_required_stage(conflict_and_supersession_review_complete).
conversion_required_stage(independent_domain_review_complete).
conversion_required_stage(regression_tests_passed).

conversion_stage_completed(Evidence, local_file_registered) :-
    conversion_document(Evidence).
conversion_stage_completed(Evidence, metadata_verified) :-
    evidence_metadata_status(Evidence, Status),
    memberchk(Status, [verified_metadata, verified_metadata_and_toc]).
conversion_stage_completed(Evidence, text_or_ocr_verified) :-
    conversion_inventory(Evidence, pdf, Pages, NonemptyPages, _, _),
    Pages > 0,
    Pages =:= NonemptyPages.
conversion_stage_completed(ev_official_link_registry, text_or_ocr_verified).
conversion_stage_completed(ev_user_bibliography_docx, text_or_ocr_verified).

conversion_missing_stage(Evidence, Stage) :-
    conversion_document(Evidence),
    conversion_required_stage(Stage),
    \+ conversion_stage_completed(Evidence, Stage).

literature_fully_converted(Evidence) :-
    conversion_document(Evidence),
    \+ conversion_missing_stage(Evidence, _).

literature_not_fully_converted(Evidence) :-
    conversion_document(Evidence),
    conversion_missing_stage(Evidence, _).

%% --- Verified IDSA 2026 general clinical-process facts ---------------------
%% These facts record what the cited pages state. They are not executable drug
%% recommendations and remain blocked pending independent clinical review.

clinical_process_fact(idsa_2026_scope_resistant_pathogens).
process_fact_stage(idsa_2026_scope_resistant_pathogens, scope_definition).
process_fact_value(idsa_2026_scope_resistant_pathogens,
                   pathogens([esbl_enterobacterales, ampc_enterobacterales,
                              carbapenem_resistant_enterobacterales,
                              dtr_pseudomonas_aeruginosa,
                              carbapenem_resistant_acinetobacter_baumannii,
                              stenotrophomonas_maltophilia])).
process_fact_evidence(idsa_2026_scope_resistant_pathogens, ev_idsa_amr_2026_guidance, pdf_pages(2, 4)).

clinical_process_fact(idsa_2026_targeted_treatment_prerequisites).
process_fact_stage(idsa_2026_targeted_treatment_prerequisites, targeted_treatment).
process_fact_value(idsa_2026_targeted_treatment_prerequisites,
                   requires([causative_pathogen_identified, in_vitro_susceptibility_confirmed])).
process_fact_evidence(idsa_2026_targeted_treatment_prerequisites, ev_idsa_amr_2026_guidance, pdf_page(4)).

clinical_process_fact(idsa_2026_empiric_core_inputs).
process_fact_stage(idsa_2026_empiric_core_inputs, empiric_treatment).
process_fact_value(idsa_2026_empiric_core_inputs,
                   requires([likely_pathogens, illness_severity, suspected_infection_source,
                             severe_beta_lactam_allergy_history, profound_immunosuppression,
                             underlying_renal_disease])).
process_fact_evidence(idsa_2026_empiric_core_inputs, ev_idsa_amr_2026_guidance, pdf_pages(4, 5)).

clinical_process_fact(idsa_2026_empiric_history_windows).
process_fact_stage(idsa_2026_empiric_history_windows, empiric_treatment).
process_fact_value(idsa_2026_empiric_history_windows,
                   requires([prior_microbiology_and_ast_within_months(12),
                             antibiotic_exposure_within_months(3),
                             local_epidemiology, cumulative_ast_for_probable_pathogens])).
process_fact_evidence(idsa_2026_empiric_history_windows, ev_idsa_amr_2026_guidance, pdf_page(5)).

clinical_process_fact(idsa_2026_reassess_after_identification).
process_fact_stage(idsa_2026_reassess_after_identification, reassessment).
process_fact_value(idsa_2026_reassess_after_identification,
                   refine_empiric_regimen_using([pathogen_identity, ast, clinically_relevant_beta_lactamases_when_available])).
process_fact_evidence(idsa_2026_reassess_after_identification, ev_idsa_amr_2026_guidance, pdf_page(5)).

clinical_process_fact(idsa_2026_infection_colonization_gate).
process_fact_stage(idsa_2026_infection_colonization_gate, diagnostic_interpretation).
process_fact_value(idsa_2026_infection_colonization_gate,
                   requires_distinguishing(infection, colonization)).
process_fact_evidence(idsa_2026_infection_colonization_gate, ev_idsa_amr_2026_guidance, pdf_page(5)).

clinical_process_fact(idsa_2026_resistant_pathogen_targeting_individualized).
process_fact_stage(idsa_2026_resistant_pathogen_targeting_individualized, empiric_treatment).
process_fact_value(idsa_2026_resistant_pathogen_targeting_individualized,
                   individualize_using([prior_cultures, host_risk_factors, clinical_presentation,
                                        antibiotic_toxicity_risk])).
process_fact_evidence(idsa_2026_resistant_pathogen_targeting_individualized, ev_idsa_amr_2026_guidance, pdf_page(5)).

clinical_process_fact(idsa_2026_duration_not_longer_by_resistance_alone).
process_fact_stage(idsa_2026_duration_not_longer_by_resistance_alone, duration_review).
process_fact_value(idsa_2026_duration_not_longer_by_resistance_alone,
                   resistance_alone_does_not_require_longer_duration).
process_fact_evidence(idsa_2026_duration_not_longer_by_resistance_alone, ev_idsa_amr_2026_guidance, pdf_page(5)).

clinical_process_fact(idsa_2026_duration_patient_factors).
process_fact_stage(idsa_2026_duration_patient_factors, duration_review).
process_fact_value(idsa_2026_duration_patient_factors,
                   consider([immune_status, source_control_adequacy, clinical_response])).
process_fact_evidence(idsa_2026_duration_patient_factors, ev_idsa_amr_2026_guidance, pdf_page(6)).

clinical_process_fact(idsa_2026_cuti_inactive_empiric_reset).
process_fact_stage(idsa_2026_cuti_inactive_empiric_reset, targeted_treatment).
process_fact_value(idsa_2026_cuti_inactive_empiric_reset,
                   if_inactive_empiric_then([switch_to_susceptible_agent,
                                             count_duration_from_active_therapy_start])).
process_fact_evidence(idsa_2026_cuti_inactive_empiric_reset, ev_idsa_amr_2026_guidance, pdf_page(6)).

clinical_process_fact(idsa_2026_iv_to_oral_criteria).
process_fact_stage(idsa_2026_iv_to_oral_criteria, route_transition).
process_fact_value(idsa_2026_iv_to_oral_criteria,
                   requires([susceptible_appropriate_oral_agent,
                             hemodynamic_stability,
                             adequate_concentration_at_infection_site,
                             sufficient_gastrointestinal_absorption])).
process_fact_evidence(idsa_2026_iv_to_oral_criteria, ev_idsa_amr_2026_guidance, pdf_page(6)).

process_fact_mapping_status(Fact, page_mapped_machine_extracted_pending_domain_review) :-
    clinical_process_fact(Fact).
process_fact_execution_status(Fact, blocked_pending_domain_review) :-
    clinical_process_fact(Fact).

%% Drug selection, dose, breakpoint, and patient-specific duration are never
%% enabled by the process facts above.
process_fact_not_authoritative_for(Fact, patient_specific_drug_selection) :- clinical_process_fact(Fact).
process_fact_not_authoritative_for(Fact, patient_specific_dose) :- clinical_process_fact(Fact).
process_fact_not_authoritative_for(Fact, ast_breakpoint_interpretation) :- clinical_process_fact(Fact).

%% --- Remaining content queue ------------------------------------------------

clinical_conversion_gap(pre_analytic_microbiology, critical,
                        specimen_selection_quality_transport_and_contamination_rules_not_fully_mapped).
clinical_conversion_gap(diagnostic_interpretation, critical,
                        colonization_contamination_and_true_infection_rules_need_syndrome_specific_mapping).
clinical_conversion_gap(rapid_diagnostics, high,
                        molecular_and_phenotypic_test_turnaround_limits_and_discordance_not_fully_mapped).
clinical_conversion_gap(ast_interpretation, critical,
                        clsi_and_eucast_breakpoint_rows_not_reconciled_by_version_method_and_context).
clinical_conversion_gap(severity_and_source_control, critical,
                        syndrome_specific_severity_imaging_and_source_control_triggers_not_fully_mapped).
clinical_conversion_gap(empiric_therapy, critical,
                        syndrome_local_ecology_and_patient_risk_rules_not_fully_mapped).
clinical_conversion_gap(targeted_therapy, critical,
                        mechanism_site_ast_and_evidence_ranked_regimens_not_fully_mapped).
clinical_conversion_gap(dose_optimization, critical,
                        label_renal_hepatic_pk_pd_infusion_tdm_and_interaction_rules_not_fully_mapped).
clinical_conversion_gap(response_monitoring, high,
                        clinical_microbiologic_toxicity_and_resistance_emergence_checkpoints_not_fully_mapped).
clinical_conversion_gap(treatment_failure, critical,
                        failure_definition_repeat_testing_source_control_and_rescue_pathway_not_fully_mapped).
clinical_conversion_gap(de_escalation_and_iv_oral, high,
                        syndrome_specific_transition_and_stop_criteria_not_fully_mapped).
clinical_conversion_gap(discharge_and_follow_up, high,
                        stability_pending_result_owner_opat_red_flags_and_follow_up_rules_not_fully_mapped).
clinical_conversion_gap(infection_prevention, high,
                        isolation_screening_environmental_cleaning_outbreak_and_reporting_rules_not_fully_mapped).
clinical_conversion_gap(special_populations, critical,
                        pediatric_pregnancy_obesity_burn_transplant_neutropenia_rrt_crrt_ecmo_rules_not_fully_mapped).
clinical_conversion_gap(governance_and_validation, critical,
                        jurisdiction_supersession_human_review_external_validation_and_audit_not_complete).
