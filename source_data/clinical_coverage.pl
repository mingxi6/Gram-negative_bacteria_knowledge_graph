:- encoding(utf8).

%% =============================================================================
%% Clinical coverage ontology and completeness contract
%%
%% Purpose:
%%   1. Define what a hospital-facing Gram-negative infection knowledge base
%%      must cover, even when fact-level clinical content is not yet available.
%%   2. Represent missing information explicitly instead of treating absence as
%%      susceptibility, safety, or permission to recommend treatment.
%%   3. Keep legacy descriptive facts separate from executable clinical logic.
%%
%% This file contains scope and safety metadata, not patient treatment advice.
%% =============================================================================

:- dynamic clinical_case_datum/3.
:- dynamic clinician_review_status/3.
:- dynamic discharge_element_status/3.
:- dynamic local_implementation_status/2.

%% --- Four-part ontology ------------------------------------------------------

coverage_object(pathogen_or_phenotype).
coverage_object(infection_syndrome).
coverage_object(patient_context).
coverage_object(care_setting).
coverage_object(workflow_stage).
coverage_object(diagnostic_result).
coverage_object(treatment_option).
coverage_object(monitoring_event).
coverage_object(discharge_plan).
coverage_object(evidence_document).

coverage_attribute(canonical_name).
coverage_attribute(synonym).
coverage_attribute(taxonomy_identifier).
coverage_attribute(resistance_phenotype).
coverage_attribute(resistance_mechanism).
coverage_attribute(specimen_and_collection_time).
coverage_attribute(ast_method_standard_version_and_date).
coverage_attribute(jurisdiction_and_formulary_availability).
coverage_attribute(evidence_locator_and_certainty).
coverage_attribute(last_reviewed_and_superseded_status).

coverage_relationship(is_a).
coverage_relationship(causes_syndrome).
coverage_relationship(detected_by).
coverage_relationship(has_ast_result).
coverage_relationship(has_resistance_mechanism).
coverage_relationship(treated_with_candidate).
coverage_relationship(contraindicated_in).
coverage_relationship(requires_dose_adjustment_in).
coverage_relationship(requires_monitoring).
coverage_relationship(supported_by_evidence).
coverage_relationship(supersedes).
coverage_relationship(requires_source_control).
coverage_relationship(eligible_for_iv_to_oral_transition).
coverage_relationship(has_discharge_requirement).

%% --- AMR priority scope ------------------------------------------------------

%% Exact Gram-negative entries from the WHO BPPL 2024.  This is a scope and
%% research-priority list; it must not be used as a treatment guideline.
amr_priority_requirement(who_bppl_crab, acinetobacter_baumannii, carbapenem_resistant, critical, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_3gcr_enterobacterales, enterobacterales, third_generation_cephalosporin_resistant, critical, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_cre, enterobacterales, carbapenem_resistant, critical, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_fq_salmonella_typhi, salmonella_typhi, fluoroquinolone_resistant, high, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_fq_shigella, shigella_spp, fluoroquinolone_resistant, high, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_crpa, pseudomonas_aeruginosa, carbapenem_resistant, high, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_fq_nts, non_typhoidal_salmonella, fluoroquinolone_resistant, high, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_dr_ng, neisseria_gonorrhoeae, third_generation_cephalosporin_or_fluoroquinolone_resistant, high, ev_who_bppl_2024).
amr_priority_requirement(who_bppl_ampicillin_hi, haemophilus_influenzae, ampicillin_resistant, medium, ev_who_bppl_2024).

%% Additional resistant Gram-negative phenotypes explicitly covered by the
%% supplied IDSA 2026 guidance.
amr_management_scope(esbl_enterobacterales, ev_idsa_amr_2026_guidance).
amr_management_scope(ampc_enterobacterales, ev_idsa_amr_2026_guidance).
amr_management_scope(carbapenem_resistant_enterobacterales, ev_idsa_amr_2026_guidance).
amr_management_scope(dtr_pseudomonas_aeruginosa, ev_idsa_amr_2026_guidance).
amr_management_scope(carbapenem_resistant_acinetobacter_baumannii, ev_idsa_amr_2026_guidance).
amr_management_scope(stenotrophomonas_maltophilia, ev_idsa_amr_2026_guidance).

%% Organism groups with dedicated tables in the supplied EUCAST v16.1
%% breakpoint document.  Inclusion means AST mapping is required; it does not
%% imply that a breakpoint exists for every agent or indication.
ast_scope_requirement(enterobacterales, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(pseudomonas_spp, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(stenotrophomonas_maltophilia, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(acinetobacter_spp, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(haemophilus_influenzae, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(moraxella_catarrhalis, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(neisseria_gonorrhoeae, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(neisseria_meningitidis, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(gram_negative_anaerobes, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(helicobacter_pylori, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(pasteurella_spp, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(campylobacter_jejuni_coli, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(kingella_kingae, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(aeromonas_spp, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(achromobacter_xylosoxidans, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(vibrio_spp, ev_eucast_breakpoints_v16_1_2026).
ast_scope_requirement(brucella_melitensis, ev_eucast_breakpoints_v16_1_2026).

%% Hospital-relevant organism families not represented by one universal AST
%% table still require identity, syndrome, diagnostic, IPC and evidence nodes.
extended_clinical_pathogen_scope(burkholderia_cepacia_complex).
extended_clinical_pathogen_scope(burkholderia_pseudomallei).
extended_clinical_pathogen_scope(legionella_pneumophila).
extended_clinical_pathogen_scope(bordetella_pertussis).
extended_clinical_pathogen_scope(francisella_tularensis).
extended_clinical_pathogen_scope(capnocytophaga_canimorsus).
extended_clinical_pathogen_scope(bacteroides_fragilis_group).
extended_clinical_pathogen_scope(prevotella_spp).
extended_clinical_pathogen_scope(fusobacterium_spp).
extended_clinical_pathogen_scope(yersinia_enterocolitica).
extended_clinical_pathogen_scope(yersinia_pestis).

required_clinical_pathogen(Pathogen) :-
    amr_priority_requirement(_, Pathogen, _, _, _).
required_clinical_pathogen(Pathogen) :-
    ast_scope_requirement(Pathogen, _).
required_clinical_pathogen(Pathogen) :-
    extended_clinical_pathogen_scope(Pathogen).

clinical_pathogen_scope_status(Pathogen, scope_node_present_fact_mapping_pending) :-
    required_clinical_pathogen(Pathogen).

%% --- Clinical syndromes and care settings ----------------------------------

required_syndrome(sepsis_or_septic_shock).
required_syndrome(bloodstream_infection).
required_syndrome(endovascular_or_endocarditis).
required_syndrome(hospital_acquired_or_ventilator_associated_pneumonia).
required_syndrome(community_acquired_pneumonia_with_gnb_risk).
required_syndrome(complicated_urinary_tract_infection_or_pyelonephritis).
required_syndrome(intra_abdominal_or_biliary_infection).
required_syndrome(cns_infection_or_ventriculitis).
required_syndrome(skin_soft_tissue_burn_or_wound_infection).
required_syndrome(bone_joint_or_prosthetic_joint_infection).
required_syndrome(surgical_site_infection).
required_syndrome(catheter_or_device_associated_infection).
required_syndrome(febrile_neutropenia).
required_syndrome(peritoneal_dialysis_peritonitis).
required_syndrome(enteric_infection).
required_syndrome(gonococcal_infection).

required_care_setting(emergency_department).
required_care_setting(inpatient_ward).
required_care_setting(intensive_care_unit).
required_care_setting(neonatal_or_pediatric_unit).
required_care_setting(hematology_oncology_or_transplant_unit).
required_care_setting(burn_unit).
required_care_setting(dialysis_unit).
required_care_setting(long_term_care_facility).
required_care_setting(outpatient_or_opat).

required_patient_context(adult).
required_patient_context(older_adult_and_frailty).
required_patient_context(neonate).
required_patient_context(child_or_adolescent).
required_patient_context(pregnancy).
required_patient_context(lactation).
required_patient_context(obesity_or_extreme_body_weight).
required_patient_context(renal_impairment).
required_patient_context(augmented_renal_clearance).
required_patient_context(intermittent_hemodialysis).
required_patient_context(crrt).
required_patient_context(hepatic_impairment).
required_patient_context(ecmo).
required_patient_context(immunocompromised_or_neutropenic).
required_patient_context(solid_organ_or_stem_cell_transplant).
required_patient_context(cystic_fibrosis_or_bronchiectasis).
required_patient_context(beta_lactam_and_other_serious_drug_allergy).
required_patient_context(seizure_or_cns_disorder).
required_patient_context(qt_prolongation_risk).
required_patient_context(myasthenia_gravis_or_neuromuscular_risk).
required_patient_context(g6pd_deficiency_when_relevant).

%% --- End-to-end workflow -----------------------------------------------------

workflow_stage(triage_and_severity_assessment).
workflow_stage(infection_vs_colonization_assessment).
workflow_stage(specimen_selection_and_collection_before_antibiotics_when_safe).
workflow_stage(initial_imaging_and_source_identification).
workflow_stage(empiric_antimicrobial_selection).
workflow_stage(source_control_and_device_management).
workflow_stage(organism_identification_and_rapid_diagnostics).
workflow_stage(ast_and_resistance_mechanism_interpretation).
workflow_stage(targeted_therapy_and_de_escalation).
workflow_stage(dose_optimization_pk_pd_and_tdm).
workflow_stage(response_toxicity_and_microbiology_reassessment).
workflow_stage(duration_and_iv_to_oral_or_opat_transition).
workflow_stage(discharge_readiness_and_medication_reconciliation).
workflow_stage(pending_result_ownership_and_follow_up).
workflow_stage(patient_carer_education_and_readmission_red_flags).
workflow_stage(infection_prevention_reporting_and_stewardship_feedback).

workflow_coverage_status(Stage, required_uniform_contract) :-
    workflow_stage(Stage).

%% --- Decision input contracts ----------------------------------------------

decision_required_field(empiric_selection, age_group).
decision_required_field(empiric_selection, body_weight_kg).
decision_required_field(empiric_selection, care_setting).
decision_required_field(empiric_selection, suspected_syndrome_and_site).
decision_required_field(empiric_selection, severity_and_hemodynamics).
decision_required_field(empiric_selection, specimen_collection_status).
decision_required_field(empiric_selection, renal_function_value_unit_and_time).
decision_required_field(empiric_selection, hepatic_function_status).
decision_required_field(empiric_selection, allergy_history_and_reaction_type).
decision_required_field(empiric_selection, pregnancy_and_lactation_status).
decision_required_field(empiric_selection, immune_and_transplant_status).
decision_required_field(empiric_selection, devices_and_source_control_status).
decision_required_field(empiric_selection, prior_microbiology_and_ast_12_months).
decision_required_field(empiric_selection, antimicrobial_exposure_3_months).
decision_required_field(empiric_selection, local_antibiogram_and_formulary_version).

decision_required_field(targeted_selection, infection_vs_colonization_assessment).
decision_required_field(targeted_selection, organism_identification_method).
decision_required_field(targeted_selection, specimen_source_and_collection_time).
decision_required_field(targeted_selection, mic_or_zone_and_test_method).
decision_required_field(targeted_selection, ast_authority_version_and_interpretation_date).
decision_required_field(targeted_selection, resistance_mechanism_result_and_method).
decision_required_field(targeted_selection, syndrome_site_and_source_control_status).
decision_required_field(targeted_selection, patient_specific_safety_context).

decision_required_field(dose_selection, selected_agent_and_indication).
decision_required_field(dose_selection, age_and_body_weight).
decision_required_field(dose_selection, renal_function_and_rrt_modality).
decision_required_field(dose_selection, hepatic_function).
decision_required_field(dose_selection, critical_illness_arc_ecmo_and_fluid_status).
decision_required_field(dose_selection, formulation_route_and_infusion_capability).
decision_required_field(dose_selection, nmpa_label_or_documented_jurisdiction_basis).
decision_required_field(dose_selection, tdm_plan_when_indicated).

decision_required_field(reassessment, reassessment_timepoint).
decision_required_field(reassessment, clinical_and_hemodynamic_response).
decision_required_field(reassessment, culture_ast_and_pending_results).
decision_required_field(reassessment, renal_hepatic_and_hematologic_trend).
decision_required_field(reassessment, drug_specific_toxicity_screen).
decision_required_field(reassessment, source_control_status).
decision_required_field(reassessment, de_escalation_or_stop_assessment).
decision_required_field(reassessment, planned_duration_and_stop_date).

decision_missing_field(Case, Decision, Field) :-
    decision_required_field(Decision, Field),
    \+ clinical_case_datum(Case, Field, _).

decision_blocker(Case, Decision, missing_required_field(Field)) :-
    decision_missing_field(Case, Decision, Field).

decision_input_complete(Case, Decision) :-
    decision_required_field(Decision, _),
    \+ decision_missing_field(Case, Decision, _).

%% Recommendations may be displayed to clinicians only after inputs are
%% complete and a clinician has explicitly reviewed the decision instance.
decision_release_allowed(Case, Decision) :-
    decision_input_complete(Case, Decision),
    clinician_review_status(Case, Decision, approved).

%% --- Discharge and follow-up contract --------------------------------------

discharge_required_element(hemodynamic_and_clinical_stability).
discharge_required_element(source_control_complete_or_documented_plan).
discharge_required_element(active_agent_route_dose_and_stop_date).
discharge_required_element(iv_to_oral_or_opat_eligibility_assessment).
discharge_required_element(renal_hepatic_toxicity_and_tdm_monitoring_plan).
discharge_required_element(line_device_and_wound_care_plan).
discharge_required_element(pending_culture_ast_and_pathology_result_owner).
discharge_required_element(follow_up_clinician_date_and_contact_route).
discharge_required_element(medication_reconciliation_and_interaction_check).
discharge_required_element(patient_carer_adherence_and_adverse_effect_education).
discharge_required_element(infection_control_isolation_and_public_health_plan).
discharge_required_element(return_precautions_and_readmission_red_flags).

discharge_blocker(Case, missing_element(Element)) :-
    discharge_required_element(Element),
    \+ discharge_element_status(Case, Element, complete).

discharge_contract_complete(Case) :-
    \+ discharge_blocker(Case, _).

discharge_release_allowed(Case) :-
    discharge_contract_complete(Case),
    clinician_review_status(Case, discharge, approved).

%% --- Agent response and governance contract ---------------------------------

agent_output_required_section(observed_patient_data).
agent_output_required_section(missing_critical_data).
agent_output_required_section(problem_representation_and_severity).
agent_output_required_section(infection_vs_colonization_reasoning).
agent_output_required_section(differential_diagnosis_and_noninfectious_mimics).
agent_output_required_section(recommended_tests_with_timing_and_rationale).
agent_output_required_section(source_control_and_device_actions_for_review).
agent_output_required_section(empiric_or_targeted_options_with_conditions).
agent_output_required_section(patient_specific_dose_constraints_and_monitoring).
agent_output_required_section(contraindications_interactions_and_adverse_effects).
agent_output_required_section(reassessment_time_and_escalation_triggers).
agent_output_required_section(duration_iv_to_oral_opat_and_stop_criteria).
agent_output_required_section(discharge_follow_up_and_return_precautions).
agent_output_required_section(evidence_citations_jurisdiction_version_and_date).
agent_output_required_section(uncertainty_conflicts_and_clinician_decisions_needed).

agent_governance_requirement(no_autonomous_prescribing).
agent_governance_requirement(no_autonomous_discharge_or_isolation_clearance).
agent_governance_requirement(human_clinician_signoff_for_each_released_recommendation).
agent_governance_requirement(immutable_audit_log_of_inputs_rules_evidence_and_output).
agent_governance_requirement(versioned_knowledge_snapshot_and_rollback).
agent_governance_requirement(patient_data_minimization_deidentification_and_access_control).
agent_governance_requirement(role_based_access_and_separation_of_test_and_production).
agent_governance_requirement(conflict_resolution_prefers_current_local_label_and_policy).
agent_governance_requirement(fail_closed_on_missing_conflicting_or_expired_evidence).
agent_governance_requirement(incident_reporting_and_postdeployment_monitoring).

%% --- Evidence acquisition matrix -------------------------------------------

required_evidence_domain(china_regulatory_labels_and_review_reports).
required_evidence_domain(china_national_and_local_antimicrobial_surveillance).
required_evidence_domain(local_cumulative_antibiogram_by_unit_and_specimen).
required_evidence_domain(preanalytic_microbiology_and_specimen_quality).
required_evidence_domain(rapid_diagnostics_and_genotype_phenotype_discordance).
required_evidence_domain(hap_vap_and_respiratory_infection).
required_evidence_domain(bloodstream_endovascular_and_catheter_infection).
required_evidence_domain(urinary_tract_infection).
required_evidence_domain(intra_abdominal_and_biliary_infection).
required_evidence_domain(cns_and_neurosurgical_infection).
required_evidence_domain(bone_joint_prosthetic_joint_and_surgical_site_infection).
required_evidence_domain(burn_wound_and_skin_soft_tissue_infection).
required_evidence_domain(febrile_neutropenia_transplant_and_immunocompromised_host).
required_evidence_domain(neonatal_pediatric_pregnancy_and_lactation).
required_evidence_domain(renal_hepatic_rrt_arc_ecmo_and_obesity_dosing).
required_evidence_domain(pk_pd_tdm_stability_compatibility_and_opat).
required_evidence_domain(source_control_iv_to_oral_duration_and_discharge).
required_evidence_domain(infection_prevention_outbreak_reporting_and_environmental_control).

evidence_domain_status(china_regulatory_labels_and_review_reports, acquisition_in_progress_no_complete_mapping).
evidence_domain_status(china_national_and_local_antimicrobial_surveillance, missing_versioned_machine_readable_dataset).
evidence_domain_status(local_cumulative_antibiogram_by_unit_and_specimen, unavailable_until_hospital_collaboration).
evidence_domain_status(preanalytic_microbiology_and_specimen_quality, missing_primary_guideline_mapping).
evidence_domain_status(rapid_diagnostics_and_genotype_phenotype_discordance, partial_historical_eucast_mapping_only).
evidence_domain_status(hap_vap_and_respiratory_infection, partial_unverified_legacy_content).
evidence_domain_status(bloodstream_endovascular_and_catheter_infection, partial_unverified_legacy_content).
evidence_domain_status(urinary_tract_infection, partial_unverified_legacy_content).
evidence_domain_status(intra_abdominal_and_biliary_infection, partial_unverified_legacy_content).
evidence_domain_status(cns_and_neurosurgical_infection, partial_unverified_legacy_content).
evidence_domain_status(bone_joint_prosthetic_joint_and_surgical_site_infection, partial_unverified_legacy_content).
evidence_domain_status(burn_wound_and_skin_soft_tissue_infection, partial_unverified_legacy_content).
evidence_domain_status(febrile_neutropenia_transplant_and_immunocompromised_host, partial_unverified_legacy_content).
evidence_domain_status(neonatal_pediatric_pregnancy_and_lactation, partial_and_label_mapping_incomplete).
evidence_domain_status(renal_hepatic_rrt_arc_ecmo_and_obesity_dosing, partial_and_label_mapping_incomplete).
evidence_domain_status(pk_pd_tdm_stability_compatibility_and_opat, partial_unverified_legacy_content).
evidence_domain_status(source_control_iv_to_oral_duration_and_discharge, partial_with_new_contract_no_fact_level_completion).
evidence_domain_status(infection_prevention_outbreak_reporting_and_environmental_control, partial_cdc_and_consensus_mapping).

%% --- Evaluation and translation requirements --------------------------------

evaluation_requirement(ontology_competency_questions_for_each_domain).
evaluation_requirement(schema_constraint_and_duplicate_conflict_tests).
evaluation_requirement(citation_locator_accuracy_audit).
evaluation_requirement(expert_annotated_guideline_extraction_precision_and_recall).
evaluation_requirement(synthetic_vignette_safety_before_real_cases).
evaluation_requirement(clinician_rated_relevance_completeness_and_actionability).
evaluation_requirement(contraindication_interaction_and_missing_data_blocker_recall).
evaluation_requirement(rule_conflict_and_guideline_update_regression_tests).
evaluation_requirement(prospective_silent_mode_validation_before_clinical_display).
evaluation_requirement(clinical_impact_workflow_burden_and_equity_assessment).

evaluation_status(ontology_competency_questions_for_each_domain, missing).
evaluation_status(schema_constraint_and_duplicate_conflict_tests, partial).
evaluation_status(citation_locator_accuracy_audit, partial_esbl_only).
evaluation_status(expert_annotated_guideline_extraction_precision_and_recall, missing).
evaluation_status(synthetic_vignette_safety_before_real_cases, missing).
evaluation_status(clinician_rated_relevance_completeness_and_actionability, missing).
evaluation_status(contraindication_interaction_and_missing_data_blocker_recall, partial_blocker_tests_only).
evaluation_status(rule_conflict_and_guideline_update_regression_tests, missing).
evaluation_status(prospective_silent_mode_validation_before_clinical_display, unavailable_until_hospital_collaboration).
evaluation_status(clinical_impact_workflow_burden_and_equity_assessment, unavailable_until_hospital_collaboration).

%% --- Explicit legacy safety classifications --------------------------------

legacy_predicate_safety_status(has_susceptibility/2, aggregate_or_descriptive_only_not_isolate_ast).
legacy_predicate_safety_status(has_mic_breakpoint_mg_l/2, malformed_legacy_schema_pending_clsi_eucast_row_reconciliation).
legacy_predicate_safety_status(has_resistance_markers/2, possible_association_not_universal_species_property).
legacy_predicate_safety_status(has_common_sites/2, descriptive_not_diagnostic_probability).
legacy_predicate_safety_status(has_standard_dose/2, unsafe_without_label_indication_and_patient_context).
legacy_predicate_safety_status(gram_neg_antibiotic_profile/4, teaching_summary_not_clinical_susceptibility).
legacy_dataset_safety_status(merged_section_7_susceptibility, blocked_from_patient_specific_ast).
legacy_dataset_safety_status(merged_section_8_breakpoints, blocked_pending_ed36_and_v16_1_reconciliation).
legacy_dataset_safety_status(merged_sections_9_19_dosing_pk_tdm, blocked_pending_label_and_fact_level_mapping).
legacy_dataset_safety_status(bacteria_ontology_reference_appendix, bibliographic_verification_required_before_clinical_use).

%% --- Automatically queryable registry gaps ---------------------------------

legacy_pathogen_present(Pathogen) :-
    current_predicate(has_pathogen_name/2),
    has_pathogen_name(_, Pathogen).

coverage_gap(pathogen_registry, Pathogen, missing_from_merged_core_registry) :-
    required_clinical_pathogen(Pathogen),
    \+ legacy_pathogen_present(Pathogen).

coverage_gap(ast_mapping, OrganismGroup, pending_agent_method_row_mapping) :-
    ast_scope_requirement(OrganismGroup, _).

coverage_gap(workflow, Stage, uniform_case_contract_not_yet_populated) :-
    workflow_stage(Stage).

coverage_gap(patient_context, Context, explicit_rules_and_label_mapping_required) :-
    required_patient_context(Context).

coverage_gap(syndrome, Syndrome, syndrome_specific_fact_level_audit_required) :-
    required_syndrome(Syndrome).

%% --- Research and deployment blockers --------------------------------------

research_readiness_blocker(no_deidentified_real_case_validation_yet).
research_readiness_blocker(no_local_antibiogram_versioned_dataset_yet).
research_readiness_blocker(no_complete_nmpa_label_and_review_report_mapping_yet).
research_readiness_blocker(no_complete_clsi_ed36_row_reconciliation_yet).
research_readiness_blocker(no_complete_eucast_v16_1_row_reconciliation_yet).
research_readiness_blocker(scanned_handbook_requires_ocr_and_page_verification).
research_readiness_blocker(no_prospective_clinician_usability_validation_yet).
research_readiness_blocker(no_external_infectious_diseases_microbiology_pharmacy_review_yet).
research_readiness_blocker(no_calibration_discrimination_or_safety_outcome_evaluation_yet).

clinical_deployment_allowed :-
    \+ research_readiness_blocker(_),
    local_implementation_status(governance_approval, approved),
    local_implementation_status(clinical_safety_case, approved).

%% --- Audit helpers -----------------------------------------------------------

list_coverage_gaps(Dimension, Gaps) :-
    findall(Item-Reason, coverage_gap(Dimension, Item, Reason), Raw),
    sort(Raw, Gaps).

coverage_gap_count(Dimension, Count) :-
    list_coverage_gaps(Dimension, Gaps),
    length(Gaps, Count).
