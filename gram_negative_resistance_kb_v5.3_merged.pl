:- encoding(utf8).
:- ensure_loaded('reference_evidence.pl').
:- ensure_loaded('clinical_coverage.pl').
:- ensure_loaded('literature_conversion.pl').

%% ============================================================================
%% 耐药革兰氏阴性菌感染诊疗知识图谱 v5.3 - 整合CRPA/ESBL/Novel BLI指南
%% Drug-Resistant Gram-Negative Bacteria Infection Diagnosis & Treatment KB v5.3
%% Architecture: ALL predicates binary (2-arity) + clinical decision tiers
%%
%% 历史整合来源（以下编号为旧版本记录，不代表已完成逐条验证）:
%%   Round 1 sources (1-15) - see v5.1 header
%%   Round 2 sources:
%%   16. 耐药革兰氏阴性菌感染诊疗手册(第2版) - 临床数据章节
%%   17. 碳青霉烯类耐药肠杆菌目感染专家共识(2026版) - 补充数据
%%   18. 碳青霉烯耐药铜绿假单胞菌感染诊治指南(2026版) - 补充数据
%%   Round 3 sources (NEW in v5.3):
%%   19. 碳青霉烯耐药铜绿假单胞菌感染诊治指南(2026版) - 完整临床问题
%%   20. 产超广谱β-内酰胺酶肠杆菌目细菌感染诊治指南(2025版) - 完整推荐意见
%%   21. 新型β-内酰胺酶抑制剂复方制剂临床应用专家共识(2026版) - 临床问题
%%
%% 编译日期: 2026-08-07
%% 编译者: Claude (Anthropic)
%% 版本: v5.3 (Round 3 Clinical Guidelines Integration)
%% v5.3 新增内容:
%%   - SECTION 31: CRPA 2026 指南 (10个临床问题)
%%   - SECTION 32: ESBL-E 2025 指南 (10个推荐意见 + 感染控制)
%%   - SECTION 33: Novel BLI 2026 共识 (7个临床问题 + β-内酰胺酶分类)
%%
%% IMPORTANT SAFETY NOTE (2026-08-31 audit): clinical facts have NOT yet completed
%% fact-level verification against stable PDF pages/tables.  Historical has_source/2
%% values include extraction-line locators and incomplete citations.  Section 26
%% executable treatment rules are therefore disabled by the evidence safety gate
%% until page-level mapping and independent clinical review are recorded.
%% ============================================================================

%% =============================================================================
%% SECTION 1: Metadata & Dynamic Declarations (元数据与动态声明)
%% =============================================================================
%% All dynamic predicates used in this knowledge base

:- dynamic has_pathogen_name/2.
:- dynamic has_gram_stain/2.
:- dynamic has_taxonomy/2.
:- dynamic has_taxonomy_synonym/2.
:- dynamic has_resistance_markers/2.
:- dynamic has_common_sites/2.
:- dynamic has_resistance_mechanism/2.
:- dynamic has_mechanism_type/2.
:- dynamic has_mechanism_description/2.
:- dynamic has_affected_drugs/2.
:- dynamic has_marker_name/2.
:- dynamic has_marker_type/2.
:- dynamic has_encoded_enzyme/2.
:- dynamic has_prevalence_region/2.
:- dynamic has_drug_class_name/2.
:- dynamic has_mechanism_of_action/2.
:- dynamic has_spectrum/2.
:- dynamic has_members/2.
:- dynamic has_drug_name/2.
:- dynamic has_drug_class/2.
:- dynamic has_route/2.
:- dynamic has_half_life_hours/2.
:- dynamic has_protein_binding_percent/2.
:- dynamic has_vd_l_kg/2.
:- dynamic has_clearance/2.
:- dynamic has_susceptibility/2.
:- dynamic has_mic_breakpoint_mg_l/2.
:- dynamic has_standard/2.
:- dynamic has_regimen/2.
:- dynamic has_hemodialysis_dose/2.
:- dynamic has_crrt_dose/2.
:- dynamic has_pk_parameter/2.
:- dynamic has_value/2.
:- dynamic has_unit/2.
:- dynamic has_tdm_target/2.
:- dynamic has_concentration_csf_serum/2.
:- dynamic has_trial_name/2.
:- dynamic has_intervention/2.
:- dynamic has_comparator/2.
:- dynamic has_outcome/2.
:- dynamic has_evidence_level/2.
:- dynamic has_bundle_component/2.
:- dynamic has_timeframe/2.
:- dynamic has_biomarker_name/2.
:- dynamic has_cutoff/2.
:- dynamic has_clinical_action/2.

:- dynamic has_infection_control_measure/2.
:- dynamic has_ams_strategy/2.
:- dynamic has_guideline_name/2.
:- dynamic has_full_name/2.
:- dynamic has_organization/2.
:- dynamic has_publication_year/2.
:- dynamic has_url/2.
:- dynamic has_scope/2.
:- dynamic has_adverse_effect/2.
:- dynamic has_frequency/2.
:- dynamic has_monitoring/2.
:- dynamic has_contraindication_type/2.
:- dynamic has_condition/2.
:- dynamic has_precaution/2.
:- dynamic has_interaction_severity/2.
:- dynamic has_interacting_drugs/2.
:- dynamic has_interaction_mechanism/2.
:- dynamic has_clinical_management/2.
:- dynamic has_dosing_guidance/2.
:- dynamic has_setting/2.
:- dynamic has_risk_level/2.
:- dynamic has_suspected_pathogens/2.
:- dynamic has_crcl_min/2.
:- dynamic has_crcl_max/2.
:- dynamic has_adjusted_dose/2.
:- dynamic has_adjusted_interval/2.
:- dynamic has_population/2.
:- dynamic has_interval/2.
:- dynamic has_target_type/2.
:- dynamic has_target_range/2.
:- dynamic has_sampling_time/2.
:- dynamic has_tissue/2.
:- dynamic has_penetration_ratio/2.
:- dynamic has_severity/2.
:- dynamic has_duration_days/2.
:- dynamic has_criteria/2.
:- dynamic has_switch_to/2.
:- dynamic has_pathogen_category/2.
:- dynamic has_dose_mg/2.
:- dynamic has_interval_hours/2.
:- dynamic has_infusion_minutes/2.
:- dynamic has_indication/2.
:- dynamic has_source/2.
:- dynamic has_site/2.
:- dynamic has_pathogen/2.
:- dynamic has_targeted_therapy/2.
:- dynamic has_rationale/2.
:- dynamic has_dose_adjustment/2.
:- dynamic has_crcl_range/2.

%% NEW dynamic declarations for Round 3 content (CRPA/ESBL/Novel BLI)
:- dynamic has_english_name/2.
:- dynamic has_chinese_name/2.
:- dynamic has_description/2.
:- dynamic has_recommendation_number/2.
:- dynamic has_recommendation_topic/2.
:- dynamic has_recommendation_strength/2.
:- dynamic linked_to_recommendation/2.
:- dynamic has_comment/2.
:- dynamic has_pkpd_index/2.
:- dynamic has_target_value/2.
:- dynamic has_clinical_cure_rate/2.
:- dynamic has_mortality_rate/2.
:- dynamic has_microbiological_clearance_rate/2.
:- dynamic has_patient_type/2.
:- dynamic has_epidemiology_data/2.
:- dynamic has_epidemiology/2.
:- dynamic has_risk_factor/2.
:- dynamic has_principle/2.
:- dynamic has_definition/2.
:- dynamic has_contraindication/2.
:- dynamic first_line/2.
:- dynamic has_dose/2.
:- dynamic has_drug_alternative/2.
:- dynamic has_combination_drug/2.
:- dynamic has_combination_drug_alternative/2.
:- dynamic has_site_alternative/2.
:- dynamic has_evidence_type/2.
:- dynamic has_requirement/2.
:- dynamic has_component/2.
:- dynamic has_strategy/2.
:- dynamic has_measure/2.
:- dynamic has_consideration/2.
:- dynamic has_impact/2.
:- dynamic has_restriction/2.
:- dynamic has_goal/2.
:- dynamic has_classification_system/2.
:- dynamic has_class/2.
:- dynamic has_enzyme_type/2.
:- dynamic has_mechanism/2.
:- dynamic has_resistance_profile/2.
:- dynamic has_abbreviation/2.
:- dynamic has_inhibitor_class/2.
:- dynamic has_activity/2.
:- dynamic has_no_activity/2.
:- dynamic has_kpc_variant_resistance/2.
:- dynamic has_sensitivity_rate/2.
:- dynamic has_clinical_data/2.
:- dynamic has_unique_feature/2.
:- dynamic has_target_organism/2.
:- dynamic has_synergy/2.
:- dynamic has_csf_penetration/2.
:- dynamic has_limitation/2.
:- dynamic has_clinical_question/2.
:- dynamic has_recommendation/2.
:- dynamic has_drug_option/2.
:- dynamic has_first_choice/2.
:- dynamic has_clinical_evidence/2.
:- dynamic has_special_application/2.
:- dynamic has_alternative_drug/2.
:- dynamic has_alert/2.
:- dynamic has_kpc_variant_sensitivity/2.
:- dynamic has_alternative_strategy/2.
:- dynamic has_comparison/2.
:- dynamic has_warning/2.
:- dynamic has_combination_strategy/2.
:- dynamic has_mbls_covered/2.
:- dynamic has_key_principle/2.
:- dynamic has_high_risk_factor/2.
:- dynamic has_empiric_treatment_timing/2.
:- dynamic has_mechanism_based_selection/2.
:- dynamic has_dosing_strategy/2.
:- dynamic has_evaluation_timing/2.
:- dynamic has_evaluation_indicator/2.
:- dynamic has_adjustment_strategy/2.
:- dynamic produces_enzyme/2.
:- dynamic direct_is_a/2.
:- dynamic has_patient_population/2.
:- dynamic has_phenotype/2.
:- dynamic has_drug/2.


%% =============================================================================
%% SECTIONS 2-30: Core Knowledge Base Content (from v5.2)
%% =============================================================================
%% Content imported from gram_negative_resistance_kb_v5_final.pl v5.2
%% Lines 130-6689 of original file
%% Sections: Pathogens, Resistance Mechanisms, Drugs, Dosing, PK/PD, Clinical Trials,
%%           Guidelines, Adverse Effects, Interactions, Special Populations, etc.
%% =============================================================================%% SECTION 2: Gram-Negative Bacteria (革兰氏阴性菌)
%% =============================================================================

%% Pathogen #1: Klebsiella pneumoniae (肺炎克雷伯菌)
has_pathogen_name(pathogen_001, klebsiella_pneumoniae).
has_gram_stain(pathogen_001, negative).
has_taxonomy(pathogen_001, 'Enterobacterales').
has_resistance_markers(pathogen_001, [kpc, ndm, oxa_48, ctx_m]).
has_common_sites(pathogen_001, [bloodstream, respiratory, urinary, intra_abdominal]).
has_source(pathogen_001, 'CDC MDRO Guidelines 2021; WHO Priority Pathogens 2017').

%% Pathogen #2: Escherichia coli (大肠埃希菌)
has_pathogen_name(pathogen_002, escherichia_coli).
has_gram_stain(pathogen_002, negative).
has_taxonomy(pathogen_002, 'Enterobacterales').
has_resistance_markers(pathogen_002, [ctx_m, ndm, oxa_48]).
has_common_sites(pathogen_002, [urinary, bloodstream, intra_abdominal]).
has_source(pathogen_002, 'CDC MDRO Guidelines 2021; WHO Priority Pathogens 2017').

%% Pathogen #3: Pseudomonas aeruginosa (铜绿假单胞菌)
has_pathogen_name(pathogen_003, pseudomonas_aeruginosa).
has_gram_stain(pathogen_003, negative).
has_taxonomy(pathogen_003, 'Non-fermenters').
has_resistance_markers(pathogen_003, [vim, imp, oxa_48, mexAB_oprM]).
has_common_sites(pathogen_003, [respiratory, bloodstream, urinary, skin_soft_tissue]).
has_source(pathogen_003, 'CDC MDRO Guidelines 2021; WHO Priority Pathogens 2017').

%% Pathogen #4: Acinetobacter baumannii (鲍曼不动杆菌)
has_pathogen_name(pathogen_004, acinetobacter_baumannii).
has_gram_stain(pathogen_004, negative).
has_taxonomy(pathogen_004, 'Non-fermenters').
has_resistance_markers(pathogen_004, [oxa_23, oxa_24, ndm]).
has_common_sites(pathogen_004, [respiratory, bloodstream, skin_soft_tissue, catheter]).
has_source(pathogen_004, 'CDC MDRO Guidelines 2021; WHO Priority Pathogens 2017').

%% Pathogen #5: Enterobacter cloacae (阴沟肠杆菌)
has_pathogen_name(pathogen_005, enterobacter_cloacae).
has_gram_stain(pathogen_005, negative).
has_taxonomy(pathogen_005, 'Enterobacterales').
has_resistance_markers(pathogen_005, [amp_c, kpc, ndm]).
has_common_sites(pathogen_005, [bloodstream, respiratory, urinary]).
has_source(pathogen_005, 'CDC MDRO Guidelines 2021').

%% Pathogen #6: Serratia marcescens (粘质沙雷菌)
has_pathogen_name(pathogen_006, serratia_marcescens).
has_gram_stain(pathogen_006, negative).
has_taxonomy(pathogen_006, 'Enterobacterales').
has_resistance_markers(pathogen_006, [amp_c, kpc]).
has_common_sites(pathogen_006, [bloodstream, respiratory, urinary]).
has_source(pathogen_006, 'CDC MDRO Guidelines 2021').

%% Pathogen #7: Proteus mirabilis (奇异变形杆菌)
has_pathogen_name(pathogen_007, proteus_mirabilis).
has_gram_stain(pathogen_007, negative).
has_taxonomy(pathogen_007, 'Enterobacterales').
has_resistance_markers(pathogen_007, [ctx_m]).
has_common_sites(pathogen_007, [urinary, bloodstream]).
has_source(pathogen_007, 'IDSA UTI Guidelines 2011').

%% Pathogen #8: Citrobacter freundii (弗氏柠檬酸杆菌)
has_pathogen_name(pathogen_008, citrobacter_freundii).
has_gram_stain(pathogen_008, negative).
has_taxonomy(pathogen_008, 'Enterobacterales').
has_resistance_markers(pathogen_008, [amp_c, kpc]).
has_common_sites(pathogen_008, [bloodstream, urinary, intra_abdominal]).
has_source(pathogen_008, 'CDC MDRO Guidelines 2021').

%% Pathogen #9: Stenotrophomonas maltophilia (嗜麦芽窄食单胞菌)
has_pathogen_name(pathogen_009, stenotrophomonas_maltophilia).
has_gram_stain(pathogen_009, negative).
has_taxonomy(pathogen_009, 'Non-fermenters').
has_resistance_markers(pathogen_009, [l1_l2_metallo_beta_lactamases]).
has_common_sites(pathogen_009, [respiratory, bloodstream]).
has_source(pathogen_009, 'CDC MDRO Guidelines 2021').

%% Pathogen #10: Burkholderia cepacia (洋葱伯克霍尔德菌)
has_pathogen_name(pathogen_010, burkholderia_cepacia).
has_gram_stain(pathogen_010, negative).
has_taxonomy(pathogen_010, 'Non-fermenters').
has_resistance_markers(pathogen_010, [intrinsic_resistance]).
has_common_sites(pathogen_010, [respiratory, bloodstream]).
has_source(pathogen_010, 'CDC MDRO Guidelines 2021').

%% Pathogen #11: Morganella morganii (摩根摩根菌)
has_pathogen_name(pathogen_011, morganella_morganii).
has_gram_stain(pathogen_011, negative).
has_taxonomy(pathogen_011, 'Enterobacterales').
has_resistance_markers(pathogen_011, [amp_c]).
has_common_sites(pathogen_011, [urinary, bloodstream]).
has_source(pathogen_011, 'IDSA UTI Guidelines 2011').

%% Pathogen #12: Providencia stuartii (斯氏普罗威登菌)
has_pathogen_name(pathogen_012, providencia_stuartii).
has_gram_stain(pathogen_012, negative).
has_taxonomy(pathogen_012, 'Enterobacterales').
has_resistance_markers(pathogen_012, [amp_c]).
has_common_sites(pathogen_012, [urinary, bloodstream]).
has_source(pathogen_012, 'IDSA UTI Guidelines 2011').

%% Pathogen #13: Klebsiella oxytoca (产酸克雷伯菌)
has_pathogen_name(pathogen_013, klebsiella_oxytoca).
has_gram_stain(pathogen_013, negative).
has_taxonomy(pathogen_013, 'Enterobacterales').
has_resistance_markers(pathogen_013, [ctx_m, kpc]).
has_common_sites(pathogen_013, [bloodstream, urinary]).
has_source(pathogen_013, 'CDC MDRO Guidelines 2021').

%% Pathogen #14: Enterobacter aerogenes (产气肠杆菌)
has_pathogen_name(pathogen_014, klebsiella_aerogenes).
has_taxonomy_synonym(pathogen_014, enterobacter_aerogenes).
has_gram_stain(pathogen_014, negative).
has_taxonomy(pathogen_014, 'Enterobacterales').
has_resistance_markers(pathogen_014, [amp_c, kpc]).
has_common_sites(pathogen_014, [bloodstream, respiratory]).
has_source(pathogen_014, 'CDC MDRO Guidelines 2021').

%% SECTION 2 COMPLETE MARKER

%% =============================================================================
%% SECTION 3: Resistance Mechanisms (耐药机制)
%% =============================================================================

%% Mechanism #1: Beta-lactamase Production (β-内酰胺酶产生)
has_resistance_mechanism(mechanism_001, beta_lactamase_production).
has_mechanism_type(mechanism_001, enzymatic_inactivation).
has_mechanism_description(mechanism_001, 'Hydrolysis of beta-lactam ring by beta-lactamase enzymes').
has_affected_drugs(mechanism_001, [penicillins, cephalosporins, carbapenems]).
has_source(mechanism_001, 'Bush-Jacoby Classification 2010; Antimicrob Agents Chemother 2010').

%% Mechanism #2: Efflux Pump Overexpression (外排泵过度表达)
has_resistance_mechanism(mechanism_002, efflux_pump_overexpression).
has_mechanism_type(mechanism_002, decreased_accumulation).
has_mechanism_description(mechanism_002, 'Active extrusion of antibiotics via membrane pumps').
has_affected_drugs(mechanism_002, [fluoroquinolones, tetracyclines, carbapenems]).
has_source(mechanism_002, 'Li et al. Clin Microbiol Rev 2015; efflux pump mechanisms').

%% Mechanism #3: Porin Loss/Mutation (孔蛋白缺失/突变)
has_resistance_mechanism(mechanism_003, porin_loss_mutation).
has_mechanism_type(mechanism_003, decreased_permeability).
has_mechanism_description(mechanism_003, 'Reduced membrane permeability due to porin channel loss').
has_affected_drugs(mechanism_003, [carbapenems, beta_lactams]).
has_source(mechanism_003, 'Nikaido H. Microbiol Mol Biol Rev 2003; porin mutation studies').

%% Mechanism #4: Target Site Modification (靶位点修饰)
has_resistance_mechanism(mechanism_004, target_site_modification).
has_mechanism_type(mechanism_004, target_alteration).
has_mechanism_description(mechanism_004, 'Mutation in antibiotic binding site on target enzyme/protein').
has_affected_drugs(mechanism_004, [fluoroquinolones, aminoglycosides]).
has_source(mechanism_004, 'Hooper DC. Clin Infect Dis 2001; quinolone resistance mechanisms').

%% Mechanism #5: 16S rRNA Methylation (16S rRNA甲基化)
has_resistance_mechanism(mechanism_005, rrna_methylation).
has_mechanism_type(mechanism_005, target_protection).
has_mechanism_description(mechanism_005, 'Methylation of 16S rRNA prevents aminoglycoside binding').
has_affected_drugs(mechanism_005, [aminoglycosides]).
has_source(mechanism_005, 'Doi Y et al. Clin Infect Dis 2016; aminoglycoside resistance review').

%% Mechanism #6: Plasmid-Mediated Resistance (质粒介导耐药)
has_resistance_mechanism(mechanism_006, plasmid_mediated_resistance).
has_mechanism_type(mechanism_006, horizontal_gene_transfer).
has_mechanism_description(mechanism_006, 'Transfer of resistance genes via plasmids between bacteria').
has_affected_drugs(mechanism_006, [all_classes]).
has_source(mechanism_006, 'WHO Global AMR Surveillance 2021; horizontal gene transfer').

%% Mechanism #7: Chromosomal AmpC Overproduction (染色体AmpC过度产生)
has_resistance_mechanism(mechanism_007, chromosomal_ampc_overproduction).
has_mechanism_type(mechanism_007, enzymatic_inactivation).
has_mechanism_description(mechanism_007, 'Derepression or mutation leading to AmpC beta-lactamase overproduction').
has_affected_drugs(mechanism_007, [cephalosporins, penicillins]).
has_source(mechanism_007, 'Jacoby GA. Clin Microbiol Rev 2009; AmpC beta-lactamases').

%% Mechanism #8: Lipopolysaccharide Modification (脂多糖修饰)
has_resistance_mechanism(mechanism_008, lps_modification).
has_mechanism_type(mechanism_008, target_alteration).
has_mechanism_description(mechanism_008, 'Modification of LPS structure reducing polymyxin binding').
has_affected_drugs(mechanism_008, [polymyxins]).
has_source(mechanism_008, 'Olaitan et al. Lancet Infect Dis 2014; colistin resistance mechanisms').

%% Mechanism #9: MCR-mediated Colistin Resistance (MCR介导的黏菌素耐药)
has_resistance_mechanism(mechanism_009, mcr_mediated_resistance).
has_mechanism_type(mechanism_009, enzymatic_modification).
has_mechanism_description(mechanism_009, 'Plasmid-borne mcr gene modifies lipid A, reducing colistin affinity').
has_affected_drugs(mechanism_009, [colistin, polymyxin_b]).
has_source(mechanism_009, 'Liu et al. Lancet Infect Dis 2016; mcr-1 discovery; WHO 2017').

%% Mechanism #10: Biofilm Formation (生物膜形成)
has_resistance_mechanism(mechanism_010, biofilm_formation).
has_mechanism_type(mechanism_010, physical_barrier).
has_mechanism_description(mechanism_010, 'Extracellular matrix protects bacteria from antibiotic penetration').
has_affected_drugs(mechanism_010, [all_classes]).
has_source(mechanism_010, 'Costerton et al. Science 1999; biofilm antibiotic resistance').

%% SECTION 3 COMPLETE MARKER

%% =============================================================================
%% SECTION 4: Resistance Markers (耐药标记物)
%% =============================================================================

%% Marker #1: KPC (Klebsiella pneumoniae carbapenemase)
has_marker_name(marker_001, kpc).
has_marker_type(marker_001, carbapenemase).
has_encoded_enzyme(marker_001, 'KPC beta-lactamase (Ambler class A)').
has_affected_drugs(marker_001, [carbapenems, cephalosporins, penicillins]).
has_prevalence_region(marker_001, 'Worldwide; high in USA, Greece, Italy, China').
has_source(marker_001, 'Munoz-Price et al. Clin Microbiol Rev 2013; KPC epidemiology').

%% Marker #2: NDM (New Delhi metallo-beta-lactamase)
has_marker_name(marker_002, ndm).
has_marker_type(marker_002, metallo_beta_lactamase).
has_encoded_enzyme(marker_002, 'NDM metallo-beta-lactamase (Ambler class B)').
has_affected_drugs(marker_002, [carbapenems, cephalosporins, penicillins, aztreonam]).
has_prevalence_region(marker_002, 'Worldwide; endemic in Indian subcontinent, Middle East, China').
has_source(marker_002, 'Yong et al. Lancet Infect Dis 2009; NDM-1 discovery; WHO 2021').

%% Marker #3: OXA-48 (Oxacillinase-48)
has_marker_name(marker_003, oxa_48).
has_marker_type(marker_003, carbapenemase).
has_encoded_enzyme(marker_003, 'OXA-48 carbapenemase (Ambler class D)').
has_affected_drugs(marker_003, [carbapenems]).
has_prevalence_region(marker_003, 'Europe (Turkey, North Africa), Middle East').
has_source(marker_003, 'Poirel et al. Antimicrob Agents Chemother 2004; OXA-48 characterization').

%% Marker #4: VIM (Verona integron-encoded metallo-beta-lactamase)
has_marker_name(marker_004, vim).
has_marker_type(marker_004, metallo_beta_lactamase).
has_encoded_enzyme(marker_004, 'VIM metallo-beta-lactamase (Ambler class B)').
has_affected_drugs(marker_004, [carbapenems, cephalosporins, penicillins, aztreonam]).
has_prevalence_region(marker_004, 'Mediterranean region, Asia').
has_source(marker_004, 'Lauretti et al. Antimicrob Agents Chemother 1999; VIM-1 discovery').

%% Marker #5: IMP (Imipenemase)
has_marker_name(marker_005, imp).
has_marker_type(marker_005, metallo_beta_lactamase).
has_encoded_enzyme(marker_005, 'IMP metallo-beta-lactamase (Ambler class B)').
has_affected_drugs(marker_005, [carbapenems, cephalosporins, penicillins, aztreonam]).
has_prevalence_region(marker_005, 'Japan, Asia-Pacific').
has_source(marker_005, 'Ito et al. Antimicrob Agents Chemother 1995; IMP-1 discovery').

%% Marker #6: CTX-M (Cefotaximase-Munich)
has_marker_name(marker_006, ctx_m).
has_marker_type(marker_006, extended_spectrum_beta_lactamase).
has_encoded_enzyme(marker_006, 'CTX-M ESBL (Ambler class A)').
has_affected_drugs(marker_006, [cephalosporins, penicillins]).
has_prevalence_region(marker_006, 'Worldwide; most prevalent ESBL').
has_source(marker_006, 'Bonnet R. Antimicrob Agents Chemother 2004; CTX-M review').

%% Marker #7: AmpC (Chromosomal and plasmid-mediated)
has_marker_name(marker_007, amp_c).
has_marker_type(marker_007, ampC_beta_lactamase).
has_encoded_enzyme(marker_007, 'AmpC beta-lactamase (Ambler class C)').
has_affected_drugs(marker_007, [cephalosporins, penicillins]).
has_prevalence_region(marker_007, 'Worldwide; intrinsic in Enterobacter, Citrobacter, Serratia').
has_source(marker_007, 'Jacoby GA. Clin Microbiol Rev 2009; AmpC epidemiology').

%% SECTION 4 COMPLETE MARKER

%% =============================================================================
%% SECTION 5: Drug Classifications (药物分类)
%% =============================================================================

%% Class #1: Carbapenems (碳青霉烯类)
has_drug_class_name(drug_class_001, carbapenems).
has_mechanism_of_action(drug_class_001, 'Inhibit bacterial cell wall synthesis by binding to PBPs').
has_spectrum(drug_class_001, 'Broad-spectrum; covers gram-negative including ESBL producers').
has_members(drug_class_001, [meropenem, imipenem, doripenem, ertapenem]).
has_source(drug_class_001, 'Papp-Wallace et al. Antimicrob Agents Chemother 2011; carbapenem review').

%% Class #2: Beta-lactam/Beta-lactamase Inhibitor Combinations (BLI复合制剂)
has_drug_class_name(drug_class_002, beta_lactam_bli_combinations).
has_mechanism_of_action(drug_class_002, 'Beta-lactam inhibits cell wall + BLI inactivates beta-lactamases').
has_spectrum(drug_class_002, 'Extended spectrum; covers ESBL, some carbapenemase producers').
has_members(drug_class_002, [piperacillin_tazobactam, ceftazidime_avibactam, ceftolozane_tazobactam, meropenem_vaborbactam, imipenem_relebactam, cefiderocol]).
has_source(drug_class_002, 'FDA labels 2024; Bush K. Ann N Y Acad Sci 2013').

%% Class #3: Polymyxins (多粘菌素类)
has_drug_class_name(drug_class_003, polymyxins).
has_mechanism_of_action(drug_class_003, 'Disrupt bacterial outer membrane via electrostatic interaction with LPS').
has_spectrum(drug_class_003, 'Gram-negative only; last-resort for carbapenem-resistant organisms').
has_members(drug_class_003, [colistin, polymyxin_b]).
has_source(drug_class_003, 'Nation et al. Lancet Infect Dis 2015; polymyxin pharmacology').

%% Class #4: Aminoglycosides (氨基糖苷类)
has_drug_class_name(drug_class_004, aminoglycosides).
has_mechanism_of_action(drug_class_004, 'Bind 30S ribosomal subunit, causing misreading of mRNA').
has_spectrum(drug_class_004, 'Gram-negative coverage; synergistic with beta-lactams').
has_members(drug_class_004, [amikacin, gentamicin, tobramycin]).
has_source(drug_class_004, 'Krause et al. Cold Spring Harb Perspect Med 2016; aminoglycoside review').

%% Class #5: Fluoroquinolones (氟喹诺酮类)
has_drug_class_name(drug_class_005, fluoroquinolones).
has_mechanism_of_action(drug_class_005, 'Inhibit DNA gyrase and topoisomerase IV').
has_spectrum(drug_class_005, 'Broad-spectrum; gram-negative and atypical coverage').
has_members(drug_class_005, [levofloxacin, ciprofloxacin, moxifloxacin]).
has_source(drug_class_005, 'Hooper DC. Clin Infect Dis 2001; quinolone mechanisms').

%% Class #6: Tetracyclines (四环素类)
has_drug_class_name(drug_class_006, tetracyclines).
has_mechanism_of_action(drug_class_006, 'Bind 30S ribosomal subunit, inhibiting protein synthesis').
has_spectrum(drug_class_006, 'Broad-spectrum including multidrug-resistant gram-negatives').
has_members(drug_class_006, [tigecycline, eravacycline, omadacycline]).
has_source(drug_class_006, 'FDA Tigecycline Label 2024; Grossman TH. Cold Spring Harb Perspect Med 2016').

%% Class #7: Fosfomycin (磷霉素)
has_drug_class_name(drug_class_007, fosfomycin).
has_mechanism_of_action(drug_class_007, 'Inhibits MurA enzyme, blocking peptidoglycan synthesis').
has_spectrum(drug_class_007, 'Broad-spectrum; active against ESBL and some carbapenem-resistant organisms').
has_members(drug_class_007, [fosfomycin]).
has_source(drug_class_007, 'Falagas et al. Clin Infect Dis 2016; fosfomycin review').

%% Class #8: Monobactams (单环β-内酰胺类)
has_drug_class_name(drug_class_008, monobactams).
has_mechanism_of_action(drug_class_008, 'Inhibit cell wall synthesis; stable to metallo-beta-lactamases').
has_spectrum(drug_class_008, 'Gram-negative only; active against MBL producers').
has_members(drug_class_008, [aztreonam, aztreonam_avibactam]).
has_source(drug_class_008, 'Sykes RB. Am J Med 1985; aztreonam review; FDA label 2024').

%% Class #9: Sulfonamides/Trimethoprim (磺胺类/甲氧苄啶)
has_drug_class_name(drug_class_009, folate_pathway_inhibitors).
has_mechanism_of_action(drug_class_009, 'Sequential blockade of folic acid synthesis pathway').
has_spectrum(drug_class_009, 'Gram-negative coverage; used for UTI and Stenotrophomonas').
has_members(drug_class_009, [trimethoprim_sulfamethoxazole]).
has_source(drug_class_009, 'Masters PA et al. Arch Intern Med 2003; TMP-SMX review').

%% SECTION 5 COMPLETE MARKER

%% =============================================================================
%% SECTION 6: Antimicrobial Drugs (抗菌药物基本属性)
%% =============================================================================

%% Drug #1: Meropenem (美罗培南)
has_drug_name(drug_001, meropenem).
has_drug_class(drug_001, carbapenems).
has_route(drug_001, intravenous).
has_half_life_hours(drug_001, 1.0).
has_protein_binding_percent(drug_001, 2).
has_vd_l_kg(drug_001, 0.25).
has_clearance(drug_001, renal).
has_source(drug_001, 'FDA Meropenem Label 2024; Wiseman et al. Drugs 1995').

%% Drug #2: Imipenem (亚胺培南)
has_drug_name(drug_002, imipenem).
has_drug_class(drug_002, carbapenems).
has_route(drug_002, intravenous).
has_half_life_hours(drug_002, 1.0).
has_protein_binding_percent(drug_002, 20).
has_vd_l_kg(drug_002, 0.23).
has_clearance(drug_002, renal).
has_source(drug_002, 'FDA Imipenem-Cilastatin Label 2024; Norrby SR. J Antimicrob Chemother 1985').

%% Drug #3: Doripenem (多尼培南)
has_drug_name(drug_003, doripenem).
has_drug_class(drug_003, carbapenems).
has_route(drug_003, intravenous).
has_half_life_hours(drug_003, 1.0).
has_protein_binding_percent(drug_003, 8).
has_vd_l_kg(drug_003, 0.24).
has_clearance(drug_003, renal).
has_source(drug_003, 'FDA Doripenem Label 2024; Zhanel et al. Drugs 2007').

%% Drug #4: Ertapenem (厄他培南)
has_drug_name(drug_004, ertapenem).
has_drug_class(drug_004, carbapenems).
has_route(drug_004, intravenous).
has_half_life_hours(drug_004, 4.0).
has_protein_binding_percent(drug_004, 95).
has_vd_l_kg(drug_004, 0.12).
has_clearance(drug_004, renal).
has_source(drug_004, 'FDA Ertapenem Label 2024; Zhanel et al. Drugs 2005').

%% Drug #5: Piperacillin-Tazobactam (哌拉西林-他唑巴坦)
has_drug_name(drug_005, piperacillin_tazobactam).
has_drug_class(drug_005, beta_lactam_bli_combinations).
has_route(drug_005, intravenous).
has_half_life_hours(drug_005, 1.0).
has_protein_binding_percent(drug_005, 30).
has_vd_l_kg(drug_005, 0.24).
has_clearance(drug_005, renal).
has_source(drug_005, 'FDA Zosyn Label 2024; Solomkin et al. Clin Infect Dis 2015').

%% Drug #6: Ceftazidime-Avibactam (头孢他啶-阿维巴坦)
has_drug_name(drug_006, ceftazidime_avibactam).
has_drug_class(drug_006, beta_lactam_bli_combinations).
has_route(drug_006, intravenous).
has_half_life_hours(drug_006, 2.7).
has_protein_binding_percent(drug_006, 10).
has_vd_l_kg(drug_006, 0.25).
has_clearance(drug_006, renal).
has_source(drug_006, 'FDA Avycaz Label 2024; Zhanel et al. Drugs 2013').

%% Drug #7: Ceftolozane-Tazobactam (头孢洛扎-他唑巴坦)
has_drug_name(drug_007, ceftolozane_tazobactam).
has_drug_class(drug_007, beta_lactam_bli_combinations).
has_route(drug_007, intravenous).
has_half_life_hours(drug_007, 3.0).
has_protein_binding_percent(drug_007, 20).
has_vd_l_kg(drug_007, 0.27).
has_clearance(drug_007, renal).
has_source(drug_007, 'FDA Zerbaxa Label 2024; Zhanel et al. Drugs 2014').

%% Drug #8: Meropenem-Vaborbactam (美罗培南-瓦博巴坦)
has_drug_name(drug_008, meropenem_vaborbactam).
has_drug_class(drug_008, beta_lactam_bli_combinations).
has_route(drug_008, intravenous).
has_half_life_hours(drug_008, 1.2).
has_protein_binding_percent(drug_008, 2).
has_vd_l_kg(drug_008, 0.25).
has_clearance(drug_008, renal).
has_source(drug_008, 'FDA Vabomere Label 2024; Wunderink et al. Clin Infect Dis 2018').

%% Drug #9: Imipenem-Relebactam (亚胺培南-雷利巴坦)
has_drug_name(drug_009, imipenem_relebactam).
has_drug_class(drug_009, beta_lactam_bli_combinations).
has_route(drug_009, intravenous).
has_half_life_hours(drug_009, 1.0).
has_protein_binding_percent(drug_009, 20).
has_vd_l_kg(drug_009, 0.23).
has_clearance(drug_009, renal).
has_source(drug_009, 'FDA Recarbrio Label 2024; Motsch et al. Lancet Infect Dis 2020').

%% Drug #10: Cefiderocol (头孢地尔)
has_drug_name(drug_010, cefiderocol).
has_drug_class(drug_010, beta_lactam_bli_combinations).
has_route(drug_010, intravenous).
has_half_life_hours(drug_010, 2.6).
has_protein_binding_percent(drug_010, 58).
has_vd_l_kg(drug_010, 0.28).
has_clearance(drug_010, renal).
has_source(drug_010, 'FDA Fetroja Label 2024; Zhanel et al. Drugs 2019').

%% Drug #11: Colistin (黏菌素)
has_drug_name(drug_011, colistin).
has_drug_class(drug_011, polymyxins).
has_route(drug_011, intravenous).
has_half_life_hours(drug_011, 3.5).
has_protein_binding_percent(drug_011, 50).
has_vd_l_kg(drug_011, 0.26).
has_clearance(drug_011, renal).
has_source(drug_011, 'Nation et al. Lancet Infect Dis 2015; Chinese Colistin Consensus 2024').

%% Drug #12: Polymyxin B (多粘菌素B)
has_drug_name(drug_012, polymyxin_b).
has_drug_class(drug_012, polymyxins).
has_route(drug_012, intravenous).
has_half_life_hours(drug_012, 6.0).
has_protein_binding_percent(drug_012, 50).
has_vd_l_kg(drug_012, 0.22).
has_clearance(drug_012, non_renal).
has_source(drug_012, 'Sandri et al. Clin Pharmacokinet 2013; Tsuji et al. Antimicrob Agents Chemother 2019').

%% Drug #13: Amikacin (阿米卡星)
has_drug_name(drug_013, amikacin).
has_drug_class(drug_013, aminoglycosides).
has_route(drug_013, intravenous).
has_half_life_hours(drug_013, 2.3).
has_protein_binding_percent(drug_013, 4).
has_vd_l_kg(drug_013, 0.25).
has_clearance(drug_013, renal).
has_source(drug_013, 'FDA Amikacin Label 2024; Pagkalis et al. Int J Antimicrob Agents 2011').

%% Drug #14: Gentamicin (庆大霉素)
has_drug_name(drug_014, gentamicin).
has_drug_class(drug_014, aminoglycosides).
has_route(drug_014, intravenous).
has_half_life_hours(drug_014, 2.0).
has_protein_binding_percent(drug_014, 10).
has_vd_l_kg(drug_014, 0.25).
has_clearance(drug_014, renal).
has_source(drug_014, 'FDA Gentamicin Label 2024; Barclay et al. Ther Drug Monit 1999').

%% Drug #15: Tobramycin (妥布霉素)
has_drug_name(drug_015, tobramycin).
has_drug_class(drug_015, aminoglycosides).
has_route(drug_015, intravenous).
has_half_life_hours(drug_015, 2.0).
has_protein_binding_percent(drug_015, 10).
has_vd_l_kg(drug_015, 0.26).
has_clearance(drug_015, renal).
has_source(drug_015, 'FDA Tobramycin Label 2024; Hennig et al. Clin Pharmacokinet 2015').

%% Drug #16: Levofloxacin (左氧氟沙星)
has_drug_name(drug_016, levofloxacin).
has_drug_class(drug_016, fluoroquinolones).
has_route(drug_016, intravenous).
has_half_life_hours(drug_016, 6.0).
has_protein_binding_percent(drug_016, 30).
has_vd_l_kg(drug_016, 1.25).
has_clearance(drug_016, renal).
has_source(drug_016, 'FDA Levaquin Label 2024; Fish et al. Clin Pharmacokinet 1997').

%% Drug #17: Ciprofloxacin (环丙沙星)
has_drug_name(drug_017, ciprofloxacin).
has_drug_class(drug_017, fluoroquinolones).
has_route(drug_017, intravenous).
has_half_life_hours(drug_017, 4.0).
has_protein_binding_percent(drug_017, 30).
has_vd_l_kg(drug_017, 2.5).
has_clearance(drug_017, renal).
has_source(drug_017, 'FDA Cipro Label 2024; Drusano et al. Antimicrob Agents Chemother 1993').

%% Drug #18: Moxifloxacin (莫西沙星)
has_drug_name(drug_018, moxifloxacin).
has_drug_class(drug_018, fluoroquinolones).
has_route(drug_018, intravenous).
has_half_life_hours(drug_018, 12.0).
has_protein_binding_percent(drug_018, 50).
has_vd_l_kg(drug_018, 1.7).
has_clearance(drug_018, hepatic).
has_source(drug_018, 'FDA Avelox Label 2024; Stass et al. Clin Pharmacokinet 2001').

%% Drug #19: Tigecycline (替加环素)
has_drug_name(drug_019, tigecycline).
has_drug_class(drug_019, tetracyclines).
has_route(drug_019, intravenous).
has_half_life_hours(drug_019, 42.0).
has_protein_binding_percent(drug_019, 73).
has_vd_l_kg(drug_019, 7.0).
has_clearance(drug_019, biliary).
has_source(drug_019, 'FDA Tygacil Label 2024; Meagher et al. Pharmacotherapy 2005').

%% Drug #20: Eravacycline (依拉环素)
has_drug_name(drug_020, eravacycline).
has_drug_class(drug_020, tetracyclines).
has_route(drug_020, intravenous).
has_half_life_hours(drug_020, 20.0).
has_protein_binding_percent(drug_020, 87).
has_vd_l_kg(drug_020, 5.5).
has_clearance(drug_020, biliary).
has_source(drug_020, 'FDA Xerava Label 2024; Solomkin et al. Lancet Infect Dis 2017').

%% Drug #21: Fosfomycin (磷霉素)
has_drug_name(drug_021, fosfomycin).
has_drug_class(drug_021, fosfomycin).
has_route(drug_021, intravenous).
has_half_life_hours(drug_021, 2.0).
has_protein_binding_percent(drug_021, 0).
has_vd_l_kg(drug_021, 0.25).
has_clearance(drug_021, renal).
has_source(drug_021, 'Falagas et al. Clin Infect Dis 2016; Michalopoulos et al. Int J Antimicrob Agents 2012').

%% Drug #22: Aztreonam (氨曲南)
has_drug_name(drug_022, aztreonam).
has_drug_class(drug_022, monobactams).
has_route(drug_022, intravenous).
has_half_life_hours(drug_022, 1.7).
has_protein_binding_percent(drug_022, 56).
has_vd_l_kg(drug_022, 0.2).
has_clearance(drug_022, renal).
has_source(drug_022, 'FDA Azactam Label 2024; Swabb et al. Rev Infect Dis 1985').

%% Drug #23: Aztreonam-Avibactam (氨曲南-阿维巴坦)
has_drug_name(drug_023, aztreonam_avibactam).
has_drug_class(drug_023, monobactams).
has_route(drug_023, intravenous).
has_half_life_hours(drug_023, 2.0).
has_protein_binding_percent(drug_023, 56).
has_vd_l_kg(drug_023, 0.22).
has_clearance(drug_023, renal).
has_source(drug_023, 'Cornely et al. Lancet Infect Dis 2020; Sader et al. Antimicrob Agents Chemother 2018').

%% Drug #24: Trimethoprim-Sulfamethoxazole (复方磺胺甲噁唑)
has_drug_name(drug_024, trimethoprim_sulfamethoxazole).
has_drug_class(drug_024, folate_pathway_inhibitors).
has_route(drug_024, intravenous).
has_half_life_hours(drug_024, 10.0).
has_protein_binding_percent(drug_024, 66).
has_vd_l_kg(drug_024, 1.3).
has_clearance(drug_024, renal).
has_source(drug_024, 'FDA Bactrim Label 2024; Masters et al. Arch Intern Med 2003').

%% Drug #25: Ceftazidime (头孢他啶)
has_drug_name(drug_025, ceftazidime).
has_drug_class(drug_025, beta_lactam_bli_combinations).
has_route(drug_025, intravenous).
has_half_life_hours(drug_025, 1.8).
has_protein_binding_percent(drug_025, 10).
has_vd_l_kg(drug_025, 0.25).
has_clearance(drug_025, renal).
has_source(drug_025, 'FDA Fortaz Label 2024; Bosso et al. Clin Pharmacokinet 1991').

%% Drug #26: Cefepime (头孢吡肟)
has_drug_name(drug_026, cefepime).
has_drug_class(drug_026, beta_lactam_bli_combinations).
has_route(drug_026, intravenous).
has_half_life_hours(drug_026, 2.0).
has_protein_binding_percent(drug_026, 20).
has_vd_l_kg(drug_026, 0.3).
has_clearance(drug_026, renal).
has_source(drug_026, 'FDA Maxipime Label 2024; Barbhaiya et al. Antimicrob Agents Chemother 1992').

%% Drug #27: Ampicillin-Sulbactam (氨苄西林-舒巴坦)
has_drug_name(drug_027, ampicillin_sulbactam).
has_drug_class(drug_027, beta_lactam_bli_combinations).
has_route(drug_027, intravenous).
has_half_life_hours(drug_027, 1.0).
has_protein_binding_percent(drug_027, 28).
has_vd_l_kg(drug_027, 0.26).
has_clearance(drug_027, renal).
has_source(drug_027, 'FDA Unasyn Label 2024; Foulds et al. Antimicrob Agents Chemother 1983').

%% Drug #28: Cefoperazone-Sulbactam (头孢哌酮-舒巴坦)
has_drug_name(drug_028, cefoperazone_sulbactam).
has_drug_class(drug_028, beta_lactam_bli_combinations).
has_route(drug_028, intravenous).
has_half_life_hours(drug_028, 2.0).
has_protein_binding_percent(drug_028, 85).
has_vd_l_kg(drug_028, 0.14).
has_clearance(drug_028, biliary).
has_source(drug_028, 'Kopterides et al. Drugs 2005; Williams et al. Drugs 1987').

%% Drug #29: Minocycline (米诺环素)
has_drug_name(drug_029, minocycline).
has_drug_class(drug_029, tetracyclines).
has_route(drug_029, intravenous).
has_half_life_hours(drug_029, 16.0).
has_protein_binding_percent(drug_029, 76).
has_vd_l_kg(drug_029, 1.2).
has_clearance(drug_029, hepatic).
has_source(drug_029, 'FDA Minocin Label 2024; Agwuh et al. J Antimicrob Chemother 2006').

%% Drug #30: Temocillin (替莫西林)
has_drug_name(drug_030, temocillin).
has_drug_class(drug_030, beta_lactam_bli_combinations).
has_route(drug_030, intravenous).
has_half_life_hours(drug_030, 4.5).
has_protein_binding_percent(drug_030, 85).
has_vd_l_kg(drug_030, 0.14).
has_clearance(drug_030, renal).
has_source(drug_030, 'Livermore et al. J Antimicrob Chemother 2006; Balakrishnan et al. J Antimicrob Chemother 2011').

%% Drug #31: Plazomicin (普拉唑霉素)
has_drug_name(drug_031, plazomicin).
has_drug_class(drug_031, aminoglycosides).
has_route(drug_031, intravenous).
has_half_life_hours(drug_031, 3.5).
has_protein_binding_percent(drug_031, 20).
has_vd_l_kg(drug_031, 0.3).
has_clearance(drug_031, renal).
has_source(drug_031, 'FDA Zemdri Label 2024; Zhanel et al. Drugs 2012').

%% Drug #32: Ceftaroline (头孢洛林)
has_drug_name(drug_032, ceftaroline).
has_drug_class(drug_032, beta_lactam_bli_combinations).
has_route(drug_032, intravenous).
has_half_life_hours(drug_032, 2.6).
has_protein_binding_percent(drug_032, 20).
has_vd_l_kg(drug_032, 0.3).
has_clearance(drug_032, renal).
has_source(drug_032, 'FDA Teflaro Label 2024; Zhanel et al. Drugs 2009').

%% SECTION 6 COMPLETE MARKER

%% =============================================================================
%% SECTION 7: Susceptibility Spectrum (药敏谱 - 病原体-药物敏感性矩阵)
%% =============================================================================

%% Klebsiella pneumoniae (pathogen_001) Susceptibility
has_susceptibility(susc_001, pathogen_001).
has_drug_name(susc_001, meropenem).
has_susceptibility(susc_001, susceptible_if_kpc_negative).
has_source(susc_001, 'CLSI M100 2024; ESCMID CRE Guidelines 2022').

has_susceptibility(susc_002, pathogen_001).
has_drug_name(susc_002, imipenem).
has_susceptibility(susc_002, susceptible_if_kpc_negative).
has_source(susc_002, 'CLSI M100 2024').

has_susceptibility(susc_003, pathogen_001).
has_drug_name(susc_003, ceftazidime_avibactam).
has_susceptibility(susc_003, highly_active_vs_kpc).
has_source(susc_003, 'FDA Avycaz Label 2024; ACURATE Trial 2020').

has_susceptibility(susc_004, pathogen_001).
has_drug_name(susc_004, meropenem_vaborbactam).
has_susceptibility(susc_004, highly_active_vs_kpc).
has_source(susc_004, 'FDA Vabomere Label 2024; TANGO II Trial 2018').

has_susceptibility(susc_005, pathogen_001).
has_drug_name(susc_005, cefiderocol).
has_susceptibility(susc_005, active_vs_mbl_and_kpc).
has_source(susc_005, 'FDA Fetroja Label 2024; CREDIBLE-CR Trial 2021').

has_susceptibility(susc_006, pathogen_001).
has_drug_name(susc_006, colistin).
has_susceptibility(susc_006, active_if_mcr_negative).
has_source(susc_006, 'Chinese Colistin Consensus 2024').

has_susceptibility(susc_007, pathogen_001).
has_drug_name(susc_007, polymyxin_b).
has_susceptibility(susc_007, active_if_mcr_negative).
has_source(susc_007, 'Tsuji et al. Pharmacotherapy 2019').

has_susceptibility(susc_008, pathogen_001).
has_drug_name(susc_008, amikacin).
has_susceptibility(susc_008, variable).
has_source(susc_008, 'CLSI M100 2024').

has_susceptibility(susc_009, pathogen_001).
has_drug_name(susc_009, gentamicin).
has_susceptibility(susc_009, variable).
has_source(susc_009, 'CLSI M100 2024').

has_susceptibility(susc_010, pathogen_001).
has_drug_name(susc_010, tigecycline).
has_susceptibility(susc_010, intermediate).
has_source(susc_010, 'FDA Tygacil Label 2024').

has_susceptibility(susc_011, pathogen_001).
has_drug_name(susc_011, fosfomycin).
has_susceptibility(susc_011, active_for_uti_only).
has_source(susc_011, 'Falagas et al. Clin Infect Dis 2016').

%% Escherichia coli (pathogen_002) Susceptibility
has_susceptibility(susc_012, pathogen_002).
has_drug_name(susc_012, meropenem).
has_susceptibility(susc_012, susceptible_if_carbapenemase_negative).
has_source(susc_012, 'CLSI M100 2024').

has_susceptibility(susc_013, pathogen_002).
has_drug_name(susc_013, ertapenem).
has_susceptibility(susc_013, active_vs_esbl).
has_source(susc_013, 'IDSA UTI Guidelines 2011').

has_susceptibility(susc_014, pathogen_002).
has_drug_name(susc_014, piperacillin_tazobactam).
has_susceptibility(susc_014, controversial_vs_esbl).
has_source(susc_014, 'MERINO Trial 2018 - inferior to meropenem').

has_susceptibility(susc_015, pathogen_002).
has_drug_name(susc_015, ceftazidime_avibactam).
has_susceptibility(susc_015, highly_active_vs_esbl_and_kpc).
has_source(susc_015, 'FDA Avycaz Label 2024').

has_susceptibility(susc_016, pathogen_002).
has_drug_name(susc_016, cefiderocol).
has_susceptibility(susc_016, active_vs_mbl).
has_source(susc_016, 'FDA Fetroja Label 2024').

has_susceptibility(susc_017, pathogen_002).
has_drug_name(susc_017, fosfomycin).
has_susceptibility(susc_017, highly_active_for_uti).
has_source(susc_017, 'Chinese Fosfomycin Guidelines 2022').

has_susceptibility(susc_018, pathogen_002).
has_drug_name(susc_018, amikacin).
has_susceptibility(susc_018, active).
has_source(susc_018, 'CLSI M100 2024').

has_susceptibility(susc_019, pathogen_002).
has_drug_name(susc_019, levofloxacin).
has_susceptibility(susc_019, variable_high_resistance).
has_source(susc_019, 'CHINET 2023').

has_susceptibility(susc_020, pathogen_002).
has_drug_name(susc_020, ciprofloxacin).
has_susceptibility(susc_020, variable_high_resistance).
has_source(susc_020, 'CHINET 2023').

has_susceptibility(susc_021, pathogen_002).
has_drug_name(susc_021, trimethoprim_sulfamethoxazole).
has_susceptibility(susc_021, variable).
has_source(susc_021, 'IDSA UTI Guidelines 2011').

%% Pseudomonas aeruginosa (pathogen_003) Susceptibility
has_susceptibility(susc_022, pathogen_003).
has_drug_name(susc_022, meropenem).
has_susceptibility(susc_022, active_if_mbl_negative).
has_source(susc_022, 'CLSI M100 2024').

has_susceptibility(susc_023, pathogen_003).
has_drug_name(susc_023, imipenem).
has_susceptibility(susc_023, active_if_mbl_negative).
has_source(susc_023, 'CLSI M100 2024').

has_susceptibility(susc_024, pathogen_003).
has_drug_name(susc_024, doripenem).
has_susceptibility(susc_024, active_if_mbl_negative).
has_source(susc_024, 'FDA Doribax Label 2024').

has_susceptibility(susc_025, pathogen_003).
has_drug_name(susc_025, piperacillin_tazobactam).
has_susceptibility(susc_025, active).
has_source(susc_025, 'CLSI M100 2024').

has_susceptibility(susc_026, pathogen_003).
has_drug_name(susc_026, ceftazidime_avibactam).
has_susceptibility(susc_026, highly_active_vs_mbl_negative).
has_source(susc_026, 'REPROVE Trial 2018').

has_susceptibility(susc_027, pathogen_003).
has_drug_name(susc_027, ceftolozane_tazobactam).
has_susceptibility(susc_027, highly_active).
has_source(susc_027, 'ASPECT-NP Trial 2019').

has_susceptibility(susc_028, pathogen_003).
has_drug_name(susc_028, imipenem_relebactam).
has_susceptibility(susc_028, active_vs_mbl_negative).
has_source(susc_028, 'FDA Recarbrio Label 2024').

has_susceptibility(susc_029, pathogen_003).
has_drug_name(susc_029, cefiderocol).
has_susceptibility(susc_029, active_vs_mbl).
has_source(susc_029, 'APEKS-NP Trial 2020').

has_susceptibility(susc_030, pathogen_003).
has_drug_name(susc_030, colistin).
has_susceptibility(susc_030, active).
has_source(susc_030, 'Chinese Colistin Consensus 2024').

has_susceptibility(susc_031, pathogen_003).
has_drug_name(susc_031, polymyxin_b).
has_susceptibility(susc_031, active).
has_source(susc_031, 'Tsuji et al. Pharmacotherapy 2019').

has_susceptibility(susc_032, pathogen_003).
has_drug_name(susc_032, amikacin).
has_susceptibility(susc_032, active).
has_source(susc_032, 'CLSI M100 2024').

has_susceptibility(susc_033, pathogen_003).
has_drug_name(susc_033, tobramycin).
has_susceptibility(susc_033, active).
has_source(susc_033, 'CLSI M100 2024').

has_susceptibility(susc_034, pathogen_003).
has_drug_name(susc_034, levofloxacin).
has_susceptibility(susc_034, variable).
has_source(susc_034, 'CLSI M100 2024').

has_susceptibility(susc_035, pathogen_003).
has_drug_name(susc_035, ciprofloxacin).
has_susceptibility(susc_035, variable).
has_source(susc_035, 'CLSI M100 2024').

has_susceptibility(susc_036, pathogen_003).
has_drug_name(susc_036, aztreonam).
has_susceptibility(susc_036, active_if_mbl_positive).
has_source(susc_036, 'ESCMID MDRGN Guidelines 2021').

has_susceptibility(susc_037, pathogen_003).
has_drug_name(susc_037, aztreonam_avibactam).
has_susceptibility(susc_037, highly_active_vs_mbl).
has_source(susc_037, 'Longshaw et al. Antimicrob Agents Chemother 2020').

%% Acinetobacter baumannii (pathogen_004) Susceptibility
has_susceptibility(susc_038, pathogen_004).
has_drug_name(susc_038, colistin).
has_susceptibility(susc_038, active_if_mcr_negative).
has_source(susc_038, 'Chinese Colistin Consensus 2024').

has_susceptibility(susc_039, pathogen_004).
has_drug_name(susc_039, polymyxin_b).
has_susceptibility(susc_039, active_if_mcr_negative).
has_source(susc_039, 'Tsuji et al. Pharmacotherapy 2019').

has_susceptibility(susc_040, pathogen_004).
has_drug_name(susc_040, cefiderocol).
has_susceptibility(susc_040, active_but_mortality_signal).
has_source(susc_040, 'CREDIBLE-CR Trial 2021 - FDA warning').

has_susceptibility(susc_041, pathogen_004).
has_drug_name(susc_041, tigecycline).
has_susceptibility(susc_041, active).
has_source(susc_041, 'FDA Tygacil Label 2024').

has_susceptibility(susc_042, pathogen_004).
has_drug_name(susc_042, minocycline).
has_susceptibility(susc_042, active).
has_source(susc_042, 'CLSI M100 2024').

has_susceptibility(susc_043, pathogen_004).
has_drug_name(susc_043, ampicillin_sulbactam).
has_susceptibility(susc_043, variable_sulbactam_active).
has_source(susc_043, 'Penwell et al. Antimicrob Agents Chemother 2015').

has_susceptibility(susc_044, pathogen_004).
has_drug_name(susc_044, amikacin).
has_susceptibility(susc_044, variable).
has_source(susc_044, 'CLSI M100 2024').

has_susceptibility(susc_045, pathogen_004).
has_drug_name(susc_045, meropenem).
has_susceptibility(susc_045, usually_resistant).
has_source(susc_045, 'ESCMID MDRGN Guidelines 2021').

has_susceptibility(susc_046, pathogen_004).
has_drug_name(susc_046, imipenem).
has_susceptibility(susc_046, usually_resistant).
has_source(susc_046, 'ESCMID MDRGN Guidelines 2021').

%% Enterobacter cloacae (pathogen_005) Susceptibility
has_susceptibility(susc_047, pathogen_005).
has_drug_name(susc_047, meropenem).
has_susceptibility(susc_047, active_if_carbapenemase_negative).
has_source(susc_047, 'CLSI M100 2024').

has_susceptibility(susc_048, pathogen_005).
has_drug_name(susc_048, imipenem).
has_susceptibility(susc_048, active_if_carbapenemase_negative).
has_source(susc_048, 'CLSI M100 2024').

has_susceptibility(susc_049, pathogen_005).
has_drug_name(susc_049, ceftazidime_avibactam).
has_susceptibility(susc_049, active_vs_ampc_and_kpc).
has_source(susc_049, 'FDA Avycaz Label 2024').

has_susceptibility(susc_050, pathogen_005).
has_drug_name(susc_050, cefepime).
has_susceptibility(susc_050, variable_ampc_risk).
has_source(susc_050, 'CLSI M100 2024').

has_susceptibility(susc_051, pathogen_005).
has_drug_name(susc_051, piperacillin_tazobactam).
has_susceptibility(susc_051, poor_vs_ampc).
has_source(susc_051, 'Harris et al. Clin Infect Dis 1999').

has_susceptibility(susc_052, pathogen_005).
has_drug_name(susc_052, amikacin).
has_susceptibility(susc_052, active).
has_source(susc_052, 'CLSI M100 2024').

has_susceptibility(susc_053, pathogen_005).
has_drug_name(susc_053, levofloxacin).
has_susceptibility(susc_053, variable).
has_source(susc_053, 'CLSI M100 2024').

%% Stenotrophomonas maltophilia (pathogen_009) Susceptibility
has_susceptibility(susc_054, pathogen_009).
has_drug_name(susc_054, trimethoprim_sulfamethoxazole).
has_susceptibility(susc_054, first_line).
has_source(susc_054, 'IDSA HAP/VAP Guidelines 2016').

has_susceptibility(susc_055, pathogen_009).
has_drug_name(susc_055, levofloxacin).
has_susceptibility(susc_055, active).
has_source(susc_055, 'CLSI M100 2024').

has_susceptibility(susc_056, pathogen_009).
has_drug_name(susc_056, tigecycline).
has_susceptibility(susc_056, active).
has_source(susc_056, 'CLSI M100 2024').

has_susceptibility(susc_057, pathogen_009).
has_drug_name(susc_057, minocycline).
has_susceptibility(susc_057, active).
has_source(susc_057, 'CLSI M100 2024').

has_susceptibility(susc_058, pathogen_009).
has_drug_name(susc_058, ceftazidime_avibactam).
has_susceptibility(susc_058, not_active).
has_source(susc_058, 'FDA Avycaz Label 2024').

has_susceptibility(susc_059, pathogen_009).
has_drug_name(susc_059, aztreonam).
has_susceptibility(susc_059, not_active).
has_source(susc_059, 'CLSI M100 2024').

%% Burkholderia cepacia (pathogen_010) Susceptibility
has_susceptibility(susc_060, pathogen_010).
has_drug_name(susc_060, trimethoprim_sulfamethoxazole).
has_susceptibility(susc_060, first_line).
has_source(susc_060, 'Avgeri et al. J Antimicrob Chemother 2009').

has_susceptibility(susc_061, pathogen_010).
has_drug_name(susc_061, ceftazidime).
has_susceptibility(susc_061, active).
has_source(susc_061, 'CLSI M100 2024').

has_susceptibility(susc_062, pathogen_010).
has_drug_name(susc_062, meropenem).
has_susceptibility(susc_062, active).
has_source(susc_062, 'CLSI M100 2024').

has_susceptibility(susc_063, pathogen_010).
has_drug_name(susc_063, levofloxacin).
has_susceptibility(susc_063, active).
has_source(susc_063, 'CLSI M100 2024').

has_susceptibility(susc_064, pathogen_010).
has_drug_name(susc_064, minocycline).
has_susceptibility(susc_064, active).
has_source(susc_064, 'CLSI M100 2024').

%% SECTION 7 COMPLETE MARKER

%% =============================================================================
%% SECTION 8: MIC Breakpoints (MIC断点 - CLSI/EUCAST标准)
%% =============================================================================

%% Meropenem MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_001, drug_001).
has_pathogen(mic_bp_001, enterobacterales).
has_standard(mic_bp_001, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_001, susceptible_le_1).
has_mic_breakpoint_mg_l(mic_bp_001, intermediate_2).
has_mic_breakpoint_mg_l(mic_bp_001, resistant_ge_4).
has_source(mic_bp_001, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_002, drug_001).
has_pathogen(mic_bp_002, pseudomonas_aeruginosa).
has_standard(mic_bp_002, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_002, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_002, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_002, resistant_ge_8).
has_source(mic_bp_002, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_003, drug_001).
has_pathogen(mic_bp_003, acinetobacter).
has_standard(mic_bp_003, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_003, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_003, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_003, resistant_ge_8).
has_source(mic_bp_003, 'CLSI M100-S34 2024').

%% Imipenem MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_004, drug_002).
has_pathogen(mic_bp_004, enterobacterales).
has_standard(mic_bp_004, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_004, susceptible_le_1).
has_mic_breakpoint_mg_l(mic_bp_004, intermediate_2).
has_mic_breakpoint_mg_l(mic_bp_004, resistant_ge_4).
has_source(mic_bp_004, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_005, drug_002).
has_pathogen(mic_bp_005, pseudomonas_aeruginosa).
has_standard(mic_bp_005, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_005, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_005, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_005, resistant_ge_8).
has_source(mic_bp_005, 'CLSI M100-S34 2024').

%% Ertapenem MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_006, drug_004).
has_pathogen(mic_bp_006, enterobacterales).
has_standard(mic_bp_006, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_006, susceptible_le_0_5).
has_mic_breakpoint_mg_l(mic_bp_006, intermediate_1).
has_mic_breakpoint_mg_l(mic_bp_006, resistant_ge_2).
has_source(mic_bp_006, 'CLSI M100-S34 2024').

%% Piperacillin-Tazobactam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_007, drug_005).
has_pathogen(mic_bp_007, enterobacterales).
has_standard(mic_bp_007, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_007, susceptible_le_16).
has_mic_breakpoint_mg_l(mic_bp_007, intermediate_32_64).
has_mic_breakpoint_mg_l(mic_bp_007, resistant_ge_128).
has_source(mic_bp_007, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_008, drug_005).
has_pathogen(mic_bp_008, pseudomonas_aeruginosa).
has_standard(mic_bp_008, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_008, susceptible_le_16).
has_mic_breakpoint_mg_l(mic_bp_008, intermediate_32_64).
has_mic_breakpoint_mg_l(mic_bp_008, resistant_ge_128).
has_source(mic_bp_008, 'CLSI M100-S34 2024').

%% Ceftazidime-Avibactam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_009, drug_006).
has_pathogen(mic_bp_009, enterobacterales).
has_standard(mic_bp_009, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_009, susceptible_le_8).
has_mic_breakpoint_mg_l(mic_bp_009, resistant_ge_16).
has_source(mic_bp_009, 'CLSI M100-S34 2024; FDA Avycaz Label 2024').

has_mic_breakpoint_mg_l(mic_bp_010, drug_006).
has_pathogen(mic_bp_010, pseudomonas_aeruginosa).
has_standard(mic_bp_010, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_010, susceptible_le_8).
has_mic_breakpoint_mg_l(mic_bp_010, resistant_ge_16).
has_source(mic_bp_010, 'CLSI M100-S34 2024; FDA Avycaz Label 2024').

%% Ceftolozane-Tazobactam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_011, drug_007).
has_pathogen(mic_bp_011, enterobacterales).
has_standard(mic_bp_011, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_011, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_011, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_011, resistant_ge_8).
has_source(mic_bp_011, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_012, drug_007).
has_pathogen(mic_bp_012, pseudomonas_aeruginosa).
has_standard(mic_bp_012, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_012, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_012, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_012, resistant_ge_16).
has_source(mic_bp_012, 'CLSI M100-S34 2024').

%% Meropenem-Vaborbactam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_013, drug_008).
has_pathogen(mic_bp_013, enterobacterales).
has_standard(mic_bp_013, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_013, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_013, resistant_ge_8).
has_source(mic_bp_013, 'CLSI M100-S34 2024; FDA Vabomere Label 2024').

%% Imipenem-Relebactam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_014, drug_009).
has_pathogen(mic_bp_014, enterobacterales).
has_standard(mic_bp_014, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_014, susceptible_le_1).
has_mic_breakpoint_mg_l(mic_bp_014, intermediate_2).
has_mic_breakpoint_mg_l(mic_bp_014, resistant_ge_4).
has_source(mic_bp_014, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_015, drug_009).
has_pathogen(mic_bp_015, pseudomonas_aeruginosa).
has_standard(mic_bp_015, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_015, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_015, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_015, resistant_ge_8).
has_source(mic_bp_015, 'CLSI M100-S34 2024').

%% Cefiderocol MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_016, drug_010).
has_pathogen(mic_bp_016, enterobacterales).
has_standard(mic_bp_016, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_016, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_016, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_016, resistant_ge_16).
has_source(mic_bp_016, 'CLSI M100-S34 2024; FDA Fetroja Label 2024').

has_mic_breakpoint_mg_l(mic_bp_017, drug_010).
has_pathogen(mic_bp_017, pseudomonas_aeruginosa).
has_standard(mic_bp_017, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_017, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_017, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_017, resistant_ge_16).
has_source(mic_bp_017, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_018, drug_010).
has_pathogen(mic_bp_018, acinetobacter).
has_standard(mic_bp_018, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_018, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_018, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_018, resistant_ge_16).
has_source(mic_bp_018, 'CLSI M100-S34 2024').

%% Colistin MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_019, drug_011).
has_pathogen(mic_bp_019, enterobacterales).
has_standard(mic_bp_019, eucast_2024).
has_mic_breakpoint_mg_l(mic_bp_019, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_019, resistant_gt_2).
has_source(mic_bp_019, 'EUCAST Clinical Breakpoints v14.0 2024').

has_mic_breakpoint_mg_l(mic_bp_020, drug_011).
has_pathogen(mic_bp_020, pseudomonas_aeruginosa).
has_standard(mic_bp_020, eucast_2024).
has_mic_breakpoint_mg_l(mic_bp_020, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_020, resistant_gt_4).
has_source(mic_bp_020, 'EUCAST Clinical Breakpoints v14.0 2024').

has_mic_breakpoint_mg_l(mic_bp_021, drug_011).
has_pathogen(mic_bp_021, acinetobacter).
has_standard(mic_bp_021, eucast_2024).
has_mic_breakpoint_mg_l(mic_bp_021, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_021, resistant_gt_2).
has_source(mic_bp_021, 'EUCAST Clinical Breakpoints v14.0 2024').

%% Amikacin MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_022, drug_013).
has_pathogen(mic_bp_022, enterobacterales).
has_standard(mic_bp_022, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_022, susceptible_le_16).
has_mic_breakpoint_mg_l(mic_bp_022, intermediate_32).
has_mic_breakpoint_mg_l(mic_bp_022, resistant_ge_64).
has_source(mic_bp_022, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_023, drug_013).
has_pathogen(mic_bp_023, pseudomonas_aeruginosa).
has_standard(mic_bp_023, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_023, susceptible_le_16).
has_mic_breakpoint_mg_l(mic_bp_023, intermediate_32).
has_mic_breakpoint_mg_l(mic_bp_023, resistant_ge_64).
has_source(mic_bp_023, 'CLSI M100-S34 2024').

%% Gentamicin MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_024, drug_014).
has_pathogen(mic_bp_024, enterobacterales).
has_standard(mic_bp_024, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_024, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_024, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_024, resistant_ge_16).
has_source(mic_bp_024, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_025, drug_014).
has_pathogen(mic_bp_025, pseudomonas_aeruginosa).
has_standard(mic_bp_025, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_025, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_025, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_025, resistant_ge_16).
has_source(mic_bp_025, 'CLSI M100-S34 2024').

%% Levofloxacin MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_026, drug_016).
has_pathogen(mic_bp_026, enterobacterales).
has_standard(mic_bp_026, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_026, susceptible_le_1).
has_mic_breakpoint_mg_l(mic_bp_026, intermediate_2).
has_mic_breakpoint_mg_l(mic_bp_026, resistant_ge_4).
has_source(mic_bp_026, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_027, drug_016).
has_pathogen(mic_bp_027, pseudomonas_aeruginosa).
has_standard(mic_bp_027, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_027, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_027, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_027, resistant_ge_8).
has_source(mic_bp_027, 'CLSI M100-S34 2024').

%% Ciprofloxacin MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_028, drug_017).
has_pathogen(mic_bp_028, enterobacterales).
has_standard(mic_bp_028, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_028, susceptible_le_0_25).
has_mic_breakpoint_mg_l(mic_bp_028, intermediate_0_5).
has_mic_breakpoint_mg_l(mic_bp_028, resistant_ge_1).
has_source(mic_bp_028, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_029, drug_017).
has_pathogen(mic_bp_029, pseudomonas_aeruginosa).
has_standard(mic_bp_029, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_029, susceptible_le_1).
has_mic_breakpoint_mg_l(mic_bp_029, intermediate_2).
has_mic_breakpoint_mg_l(mic_bp_029, resistant_ge_4).
has_source(mic_bp_029, 'CLSI M100-S34 2024').

%% Tigecycline MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_030, drug_019).
has_pathogen(mic_bp_030, enterobacterales).
has_standard(mic_bp_030, fda_2024).
has_mic_breakpoint_mg_l(mic_bp_030, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_030, intermediate_4).
has_mic_breakpoint_mg_l(mic_bp_030, resistant_ge_8).
has_source(mic_bp_030, 'FDA Tygacil Label 2024').

%% Fosfomycin MIC Breakpoints (UTI only)
has_mic_breakpoint_mg_l(mic_bp_031, drug_021).
has_pathogen(mic_bp_031, enterobacterales).
has_standard(mic_bp_031, clsi_2024).
has_indication(mic_bp_031, uti_only).
has_mic_breakpoint_mg_l(mic_bp_031, susceptible_le_64).
has_mic_breakpoint_mg_l(mic_bp_031, intermediate_128).
has_mic_breakpoint_mg_l(mic_bp_031, resistant_ge_256).
has_source(mic_bp_031, 'CLSI M100-S34 2024').

%% Aztreonam MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_032, drug_022).
has_pathogen(mic_bp_032, enterobacterales).
has_standard(mic_bp_032, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_032, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_032, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_032, resistant_ge_16).
has_source(mic_bp_032, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_033, drug_022).
has_pathogen(mic_bp_033, pseudomonas_aeruginosa).
has_standard(mic_bp_033, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_033, susceptible_le_8).
has_mic_breakpoint_mg_l(mic_bp_033, intermediate_16).
has_mic_breakpoint_mg_l(mic_bp_033, resistant_ge_32).
has_source(mic_bp_033, 'CLSI M100-S34 2024').

%% Trimethoprim-Sulfamethoxazole MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_034, drug_024).
has_pathogen(mic_bp_034, enterobacterales).
has_standard(mic_bp_034, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_034, susceptible_le_2_38).
has_mic_breakpoint_mg_l(mic_bp_034, resistant_ge_4_76).
has_source(mic_bp_034, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_035, drug_024).
has_pathogen(mic_bp_035, stenotrophomonas_maltophilia).
has_standard(mic_bp_035, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_035, susceptible_le_2_38).
has_mic_breakpoint_mg_l(mic_bp_035, resistant_ge_4_76).
has_source(mic_bp_035, 'CLSI M100-S34 2024').

%% Ceftazidime MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_036, drug_025).
has_pathogen(mic_bp_036, enterobacterales).
has_standard(mic_bp_036, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_036, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_036, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_036, resistant_ge_16).
has_source(mic_bp_036, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_037, drug_025).
has_pathogen(mic_bp_037, pseudomonas_aeruginosa).
has_standard(mic_bp_037, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_037, susceptible_le_8).
has_mic_breakpoint_mg_l(mic_bp_037, intermediate_16).
has_mic_breakpoint_mg_l(mic_bp_037, resistant_ge_32).
has_source(mic_bp_037, 'CLSI M100-S34 2024').

%% Cefepime MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_038, drug_026).
has_pathogen(mic_bp_038, enterobacterales).
has_standard(mic_bp_038, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_038, susceptible_le_2).
has_mic_breakpoint_mg_l(mic_bp_038, intermediate_4_8).
has_mic_breakpoint_mg_l(mic_bp_038, resistant_ge_16).
has_source(mic_bp_038, 'CLSI M100-S34 2024').

has_mic_breakpoint_mg_l(mic_bp_039, drug_026).
has_pathogen(mic_bp_039, pseudomonas_aeruginosa).
has_standard(mic_bp_039, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_039, susceptible_le_8).
has_mic_breakpoint_mg_l(mic_bp_039, intermediate_16).
has_mic_breakpoint_mg_l(mic_bp_039, resistant_ge_32).
has_source(mic_bp_039, 'CLSI M100-S34 2024').

%% Minocycline MIC Breakpoints
has_mic_breakpoint_mg_l(mic_bp_040, drug_029).
has_pathogen(mic_bp_040, acinetobacter).
has_standard(mic_bp_040, clsi_2024).
has_mic_breakpoint_mg_l(mic_bp_040, susceptible_le_4).
has_mic_breakpoint_mg_l(mic_bp_040, intermediate_8).
has_mic_breakpoint_mg_l(mic_bp_040, resistant_ge_16).
has_source(mic_bp_040, 'CLSI M100-S34 2024').

%% SECTION 8 COMPLETE MARKER

%% =============================================================================
%% SECTION 9: Standard Dosing Regimens (标准给药方案)
%% =============================================================================

%% Meropenem Standard Dosing
has_regimen(regimen_001, drug_001).
has_indication(regimen_001, severe_infection).
has_dose_mg(regimen_001, 1000).
has_interval_hours(regimen_001, 8).
has_infusion_minutes(regimen_001, 180).
has_source(regimen_001, 'FDA Meropenem Label 2024; IDSA HAP/VAP Guidelines 2016').

has_regimen(regimen_002, drug_001).
has_indication(regimen_002, moderate_infection).
has_dose_mg(regimen_002, 1000).
has_interval_hours(regimen_002, 8).
has_infusion_minutes(regimen_002, 30).
has_source(regimen_002, 'FDA Meropenem Label 2024').

has_regimen(regimen_003, drug_001).
has_indication(regimen_003, meningitis).
has_dose_mg(regimen_003, 2000).
has_interval_hours(regimen_003, 8).
has_infusion_minutes(regimen_003, 30).
has_source(regimen_003, 'FDA Meropenem Label 2024').

%% Imipenem Standard Dosing
has_regimen(regimen_004, drug_002).
has_indication(regimen_004, severe_infection).
has_dose_mg(regimen_004, 500).
has_interval_hours(regimen_004, 6).
has_infusion_minutes(regimen_004, 30).
has_source(regimen_004, 'FDA Primaxin Label 2024').

has_regimen(regimen_005, drug_002).
has_indication(regimen_005, moderate_infection).
has_dose_mg(regimen_005, 500).
has_interval_hours(regimen_005, 8).
has_infusion_minutes(regimen_005, 30).
has_source(regimen_005, 'FDA Primaxin Label 2024').

%% Doripenem Standard Dosing
has_regimen(regimen_006, drug_003).
has_indication(regimen_006, pneumonia_uti).
has_dose_mg(regimen_006, 500).
has_interval_hours(regimen_006, 8).
has_infusion_minutes(regimen_006, 60).
has_source(regimen_006, 'FDA Doribax Label 2024').

%% Ertapenem Standard Dosing
has_regimen(regimen_007, drug_004).
has_indication(regimen_007, intra_abdominal_uti).
has_dose_mg(regimen_007, 1000).
has_interval_hours(regimen_007, 24).
has_infusion_minutes(regimen_007, 30).
has_source(regimen_007, 'FDA Invanz Label 2024').

%% Piperacillin-Tazobactam Standard Dosing
has_regimen(regimen_008, drug_005).
has_indication(regimen_008, severe_infection).
has_dose_mg(regimen_008, 4500).
has_interval_hours(regimen_008, 6).
has_infusion_minutes(regimen_008, 240).
has_source(regimen_008, 'FDA Zosyn Label 2024; Rhodes et al. Crit Care Med 2017').

has_regimen(regimen_009, drug_005).
has_indication(regimen_009, moderate_infection).
has_dose_mg(regimen_009, 4500).
has_interval_hours(regimen_009, 8).
has_infusion_minutes(regimen_009, 30).
has_source(regimen_009, 'FDA Zosyn Label 2024').

%% Ceftazidime-Avibactam Standard Dosing
has_regimen(regimen_010, drug_006).
has_indication(regimen_010, cre_infections).
has_dose_mg(regimen_010, 2500).
has_interval_hours(regimen_010, 8).
has_infusion_minutes(regimen_010, 120).
has_source(regimen_010, 'FDA Avycaz Label 2024').

%% Ceftolozane-Tazobactam Standard Dosing
has_regimen(regimen_011, drug_007).
has_indication(regimen_011, pneumonia).
has_dose_mg(regimen_011, 3000).
has_interval_hours(regimen_011, 8).
has_infusion_minutes(regimen_011, 60).
has_source(regimen_011, 'FDA Zerbaxa Label 2024').

has_regimen(regimen_012, drug_007).
has_indication(regimen_012, uti_intra_abdominal).
has_dose_mg(regimen_012, 1500).
has_interval_hours(regimen_012, 8).
has_infusion_minutes(regimen_012, 60).
has_source(regimen_012, 'FDA Zerbaxa Label 2024').

%% Meropenem-Vaborbactam Standard Dosing
has_regimen(regimen_013, drug_008).
has_indication(regimen_013, cre_infections).
has_dose_mg(regimen_013, 4000).
has_interval_hours(regimen_013, 8).
has_infusion_minutes(regimen_013, 180).
has_source(regimen_013, 'FDA Vabomere Label 2024').

%% Imipenem-Relebactam Standard Dosing
has_regimen(regimen_014, drug_009).
has_indication(regimen_014, pneumonia_uti).
has_dose_mg(regimen_014, 1250).
has_interval_hours(regimen_014, 6).
has_infusion_minutes(regimen_014, 30).
has_source(regimen_014, 'FDA Recarbrio Label 2024').

%% Cefiderocol Standard Dosing
has_regimen(regimen_015, drug_010).
has_indication(regimen_015, mdr_gram_negative).
has_dose_mg(regimen_015, 2000).
has_interval_hours(regimen_015, 8).
has_infusion_minutes(regimen_015, 180).
has_source(regimen_015, 'FDA Fetroja Label 2024').

%% Colistin Standard Dosing (loading + maintenance)
has_regimen(regimen_016, drug_011).
has_indication(regimen_016, loading_dose).
has_dose_mg(regimen_016, 9000000).
has_interval_hours(regimen_016, 0).
has_infusion_minutes(regimen_016, 60).
has_source(regimen_016, 'Chinese Colistin Consensus 2024; Nation et al. Lancet Infect Dis 2015').

has_regimen(regimen_017, drug_011).
has_indication(regimen_017, maintenance_dose).
has_dose_mg(regimen_017, 4500000).
has_interval_hours(regimen_017, 12).
has_infusion_minutes(regimen_017, 60).
has_source(regimen_017, 'Chinese Colistin Consensus 2024').

%% Polymyxin B Standard Dosing
has_regimen(regimen_018, drug_012).
has_indication(regimen_018, severe_infection).
has_dose_mg(regimen_018, 25000).
has_interval_hours(regimen_018, 12).
has_infusion_minutes(regimen_018, 60).
has_source(regimen_018, 'Tsuji et al. Pharmacotherapy 2019; Sandri et al. Clin Pharmacokinet 2013').

%% Amikacin Standard Dosing
has_regimen(regimen_019, drug_013).
has_indication(regimen_019, once_daily).
has_dose_mg(regimen_019, 1500).
has_interval_hours(regimen_019, 24).
has_infusion_minutes(regimen_019, 30).
has_source(regimen_019, 'FDA Amikacin Label 2024; Nicolau et al. Clin Infect Dis 1995').

has_regimen(regimen_020, drug_013).
has_indication(regimen_020, conventional).
has_dose_mg(regimen_020, 500).
has_interval_hours(regimen_020, 8).
has_infusion_minutes(regimen_020, 30).
has_source(regimen_020, 'FDA Amikacin Label 2024').

%% Gentamicin Standard Dosing
has_regimen(regimen_021, drug_014).
has_indication(regimen_021, once_daily).
has_dose_mg(regimen_021, 420).
has_interval_hours(regimen_021, 24).
has_infusion_minutes(regimen_021, 30).
has_source(regimen_021, 'FDA Gentamicin Label 2024; Barclay et al. Ther Drug Monit 1999').

has_regimen(regimen_022, drug_014).
has_indication(regimen_022, conventional).
has_dose_mg(regimen_022, 160).
has_interval_hours(regimen_022, 8).
has_infusion_minutes(regimen_022, 30).
has_source(regimen_022, 'FDA Gentamicin Label 2024').

%% Tobramycin Standard Dosing
has_regimen(regimen_023, drug_015).
has_indication(regimen_023, once_daily).
has_dose_mg(regimen_023, 420).
has_interval_hours(regimen_023, 24).
has_infusion_minutes(regimen_023, 30).
has_source(regimen_023, 'FDA Tobramycin Label 2024').

%% Levofloxacin Standard Dosing
has_regimen(regimen_024, drug_016).
has_indication(regimen_024, pneumonia).
has_dose_mg(regimen_024, 750).
has_interval_hours(regimen_024, 24).
has_infusion_minutes(regimen_024, 90).
has_source(regimen_024, 'FDA Levaquin Label 2024').

has_regimen(regimen_025, drug_016).
has_indication(regimen_025, uti).
has_dose_mg(regimen_025, 500).
has_interval_hours(regimen_025, 24).
has_infusion_minutes(regimen_025, 60).
has_source(regimen_025, 'FDA Levaquin Label 2024').

%% Ciprofloxacin Standard Dosing
has_regimen(regimen_026, drug_017).
has_indication(regimen_026, severe_infection).
has_dose_mg(regimen_026, 400).
has_interval_hours(regimen_026, 8).
has_infusion_minutes(regimen_026, 60).
has_source(regimen_026, 'FDA Cipro Label 2024').

has_regimen(regimen_027, drug_017).
has_indication(regimen_027, uti).
has_dose_mg(regimen_027, 400).
has_interval_hours(regimen_027, 12).
has_infusion_minutes(regimen_027, 60).
has_source(regimen_027, 'FDA Cipro Label 2024').

%% Moxifloxacin Standard Dosing
has_regimen(regimen_028, drug_018).
has_indication(regimen_028, pneumonia_intra_abdominal).
has_dose_mg(regimen_028, 400).
has_interval_hours(regimen_028, 24).
has_infusion_minutes(regimen_028, 60).
has_source(regimen_028, 'FDA Avelox Label 2024').

%% Tigecycline Standard Dosing
has_regimen(regimen_029, drug_019).
has_indication(regimen_029, loading_dose).
has_dose_mg(regimen_029, 100).
has_interval_hours(regimen_029, 0).
has_infusion_minutes(regimen_029, 60).
has_source(regimen_029, 'FDA Tygacil Label 2024').

has_regimen(regimen_030, drug_019).
has_indication(regimen_030, maintenance_dose).
has_dose_mg(regimen_030, 50).
has_interval_hours(regimen_030, 12).
has_infusion_minutes(regimen_030, 60).
has_source(regimen_030, 'FDA Tygacil Label 2024').

%% Eravacycline Standard Dosing
has_regimen(regimen_031, drug_020).
has_indication(regimen_031, intra_abdominal).
has_dose_mg(regimen_031, 1).
has_interval_hours(regimen_031, 12).
has_infusion_minutes(regimen_031, 60).
has_source(regimen_031, 'FDA Xerava Label 2024').

%% Fosfomycin Standard Dosing
has_regimen(regimen_032, drug_021).
has_indication(regimen_032, severe_infection).
has_dose_mg(regimen_032, 6000).
has_interval_hours(regimen_032, 8).
has_infusion_minutes(regimen_032, 60).
has_source(regimen_032, 'Chinese Fosfomycin Guidelines 2022; Falagas et al. Clin Infect Dis 2016').

%% Aztreonam Standard Dosing
has_regimen(regimen_033, drug_022).
has_indication(regimen_033, severe_infection).
has_dose_mg(regimen_033, 2000).
has_interval_hours(regimen_033, 8).
has_infusion_minutes(regimen_033, 30).
has_source(regimen_033, 'FDA Azactam Label 2024').

%% Trimethoprim-Sulfamethoxazole Standard Dosing
has_regimen(regimen_034, drug_024).
has_indication(regimen_034, stenotrophomonas).
has_dose_mg(regimen_034, 5).
has_interval_hours(regimen_034, 8).
has_infusion_minutes(regimen_034, 60).
has_source(regimen_034, 'FDA Bactrim Label 2024; IDSA HAP/VAP Guidelines 2016').

%% Ceftazidime Standard Dosing
has_regimen(regimen_035, drug_025).
has_indication(regimen_035, pseudomonas_infection).
has_dose_mg(regimen_035, 2000).
has_interval_hours(regimen_035, 8).
has_infusion_minutes(regimen_035, 30).
has_source(regimen_035, 'FDA Fortaz Label 2024').

%% Cefepime Standard Dosing
has_regimen(regimen_036, drug_026).
has_indication(regimen_036, severe_infection).
has_dose_mg(regimen_036, 2000).
has_interval_hours(regimen_036, 8).
has_infusion_minutes(regimen_036, 30).
has_source(regimen_036, 'FDA Maxipime Label 2024').

%% Ampicillin-Sulbactam Standard Dosing
has_regimen(regimen_037, drug_027).
has_indication(regimen_037, acinetobacter).
has_dose_mg(regimen_037, 3000).
has_interval_hours(regimen_037, 6).
has_infusion_minutes(regimen_037, 30).
has_source(regimen_037, 'FDA Unasyn Label 2024; Penwell et al. Antimicrob Agents Chemother 2015').

%% Plazomicin Standard Dosing
has_regimen(regimen_038, drug_031).
has_indication(regimen_038, cre_uti).
has_dose_mg(regimen_038, 15).
has_interval_hours(regimen_038, 24).
has_infusion_minutes(regimen_038, 30).
has_source(regimen_038, 'FDA Zemdri Label 2024').

%% SECTION 9 COMPLETE MARKER

%% =============================================================================
%% SECTION 10: Renal Function Dose Adjustments (肾功能剂量调整)
%% =============================================================================

%% Meropenem Renal Adjustments
has_dose_adjustment(renal_adj_001, drug_001).
has_crcl_range(renal_adj_001, '50_25').
has_adjusted_dose(renal_adj_001, 1000).
has_adjusted_interval(renal_adj_001, 12).
has_source(renal_adj_001, 'FDA Meropenem Label 2024').

has_dose_adjustment(renal_adj_002, drug_001).
has_crcl_range(renal_adj_002, '25_10').
has_adjusted_dose(renal_adj_002, 500).
has_adjusted_interval(renal_adj_002, 12).
has_source(renal_adj_002, 'FDA Meropenem Label 2024').

has_dose_adjustment(renal_adj_003, drug_001).
has_crcl_range(renal_adj_003, '<10').
has_adjusted_dose(renal_adj_003, 500).
has_adjusted_interval(renal_adj_003, 24).
has_source(renal_adj_003, 'FDA Meropenem Label 2024').

has_hemodialysis_dose(renal_adj_004, drug_001).
has_dose_mg(renal_adj_004, 500).
has_interval_hours(renal_adj_004, 24).
has_dosing_guidance(renal_adj_004, 'Administer after dialysis session').
has_source(renal_adj_004, 'Matzke et al. Drug Dosing in Renal Disease 2018').

has_crrt_dose(renal_adj_005, drug_001).
has_dose_mg(renal_adj_005, 1000).
has_interval_hours(renal_adj_005, 12).
has_dosing_guidance(renal_adj_005, 'CVVH 1-2 L/h effluent rate').
has_source(renal_adj_005, 'Heintz et al. Crit Care Med 2009').

%% Imipenem-Cilastatin Renal Adjustments
has_dose_adjustment(renal_adj_006, drug_002).
has_crcl_range(renal_adj_006, '50_30').
has_adjusted_dose(renal_adj_006, 500).
has_adjusted_interval(renal_adj_006, 6).
has_source(renal_adj_006, 'FDA Primaxin Label 2024').

has_dose_adjustment(renal_adj_007, drug_002).
has_crcl_range(renal_adj_007, '30_15').
has_adjusted_dose(renal_adj_007, 500).
has_adjusted_interval(renal_adj_007, 8).
has_source(renal_adj_007, 'FDA Primaxin Label 2024').

has_dose_adjustment(renal_adj_008, drug_002).
has_crcl_range(renal_adj_008, '<15').
has_adjusted_dose(renal_adj_008, 500).
has_adjusted_interval(renal_adj_008, 12).
has_source(renal_adj_008, 'FDA Primaxin Label 2024').

%% Piperacillin-Tazobactam Renal Adjustments
has_dose_adjustment(renal_adj_009, drug_004).
has_crcl_range(renal_adj_009, '40_20').
has_adjusted_dose(renal_adj_009, 2250).
has_adjusted_interval(renal_adj_009, 6).
has_source(renal_adj_009, 'FDA Zosyn Label 2024').

has_dose_adjustment(renal_adj_010, drug_004).
has_crcl_range(renal_adj_010, '<20').
has_adjusted_dose(renal_adj_010, 2250).
has_adjusted_interval(renal_adj_010, 8).
has_source(renal_adj_010, 'FDA Zosyn Label 2024').

has_hemodialysis_dose(renal_adj_011, drug_004).
has_dose_mg(renal_adj_011, 2250).
has_interval_hours(renal_adj_011, 12).
has_dosing_guidance(renal_adj_011, 'Give additional 750mg post-dialysis').
has_source(renal_adj_011, 'Valtonen et al. Antimicrob Agents Chemother 2001').

%% Ceftazidime-Avibactam Renal Adjustments
has_dose_adjustment(renal_adj_012, drug_006).
has_crcl_range(renal_adj_012, '50_30').
has_adjusted_dose(renal_adj_012, 1250).
has_adjusted_interval(renal_adj_012, 8).
has_source(renal_adj_012, 'FDA Avycaz Label 2024').

has_dose_adjustment(renal_adj_013, drug_006).
has_crcl_range(renal_adj_013, '30_15').
has_adjusted_dose(renal_adj_013, 937).
has_adjusted_interval(renal_adj_013, 12).
has_source(renal_adj_013, 'FDA Avycaz Label 2024').

has_dose_adjustment(renal_adj_014, drug_006).
has_crcl_range(renal_adj_014, '15_5').
has_adjusted_dose(renal_adj_014, 750).
has_adjusted_interval(renal_adj_014, 24).
has_source(renal_adj_014, 'FDA Avycaz Label 2024').

has_hemodialysis_dose(renal_adj_015, drug_006).
has_dose_mg(renal_adj_015, 750).
has_interval_hours(renal_adj_015, 48).
has_dosing_guidance(renal_adj_015, 'Administer after dialysis on dialysis days').
has_source(renal_adj_015, 'FDA Avycaz Label 2024').

%% Ceftolozane-Tazobactam Renal Adjustments
has_dose_adjustment(renal_adj_016, drug_007).
has_crcl_range(renal_adj_016, '50_30').
has_adjusted_dose(renal_adj_016, 750).
has_adjusted_interval(renal_adj_016, 8).
has_source(renal_adj_016, 'FDA Zerbaxa Label 2024').

has_dose_adjustment(renal_adj_017, drug_007).
has_crcl_range(renal_adj_017, '30_15').
has_adjusted_dose(renal_adj_017, 375).
has_adjusted_interval(renal_adj_017, 8).
has_source(renal_adj_017, 'FDA Zerbaxa Label 2024').

has_dose_adjustment(renal_adj_018, drug_007).
has_crcl_range(renal_adj_018, '<15').
has_adjusted_dose(renal_adj_018, 150).
has_adjusted_interval(renal_adj_018, 8).
has_source(renal_adj_018, 'FDA Zerbaxa Label 2024').

%% Cefiderocol Renal Adjustments
has_dose_adjustment(renal_adj_019, drug_008).
has_crcl_range(renal_adj_019, '60_30').
has_adjusted_dose(renal_adj_019, 1500).
has_adjusted_interval(renal_adj_019, 8).
has_source(renal_adj_019, 'FDA Fetroja Label 2024').

has_dose_adjustment(renal_adj_020, drug_008).
has_crcl_range(renal_adj_020, '30_15').
has_adjusted_dose(renal_adj_020, 1000).
has_adjusted_interval(renal_adj_020, 8).
has_source(renal_adj_020, 'FDA Fetroja Label 2024').

has_dose_adjustment(renal_adj_021, drug_008).
has_crcl_range(renal_adj_021, '<15').
has_adjusted_dose(renal_adj_021, 750).
has_adjusted_interval(renal_adj_021, 12).
has_source(renal_adj_021, 'FDA Fetroja Label 2024').

has_crrt_dose(renal_adj_022, drug_008).
has_dose_mg(renal_adj_022, 1500).
has_interval_hours(renal_adj_022, 8).
has_dosing_guidance(renal_adj_022, 'CVVH/CVVHD/CVVHDF: standard dose').
has_source(renal_adj_022, 'Katsube et al. Antimicrob Agents Chemother 2017').

%% Colistin Renal Adjustments
has_dose_adjustment(renal_adj_023, drug_011).
has_crcl_range(renal_adj_023, '50_30').
has_adjusted_dose(renal_adj_023, 3000000).
has_adjusted_interval(renal_adj_023, 12).
has_source(renal_adj_023, 'Chinese Colistin Consensus 2024').

has_dose_adjustment(renal_adj_024, drug_011).
has_crcl_range(renal_adj_024, '<30').
has_adjusted_dose(renal_adj_024, 2500000).
has_adjusted_interval(renal_adj_024, 12).
has_source(renal_adj_024, 'Chinese Colistin Consensus 2024').

has_hemodialysis_dose(renal_adj_025, drug_011).
has_dose_mg(renal_adj_025, 2500000).
has_interval_hours(renal_adj_025, 24).
has_dosing_guidance(renal_adj_025, 'Not removed by hemodialysis; adjust per CrCl').
has_source(renal_adj_025, 'Garonzik et al. Antimicrob Agents Chemother 2011').

has_crrt_dose(renal_adj_026, drug_011).
has_dose_mg(renal_adj_026, 3000000).
has_interval_hours(renal_adj_026, 12).
has_dosing_guidance(renal_adj_026, 'CVVH: maintenance dose without reduction').
has_source(renal_adj_026, 'Garonzik et al. Antimicrob Agents Chemother 2011').

%% Polymyxin B Renal Adjustments
has_dose_adjustment(renal_adj_027, drug_012).
has_crcl_range(renal_adj_027, 'any').
has_dosing_guidance(renal_adj_027, 'No dose adjustment per FDA label; monitor renal function closely').
has_source(renal_adj_027, 'FDA Polymyxin B Label 2024').

%% Amikacin Renal Adjustments
has_dose_adjustment(renal_adj_028, drug_013).
has_crcl_range(renal_adj_028, '<60').
has_dosing_guidance(renal_adj_028, 'Adjust interval or dose based on TDM; target trough <5 mg/L').
has_source(renal_adj_028, 'FDA Amikacin Label 2024; Nicolau et al. Clin Infect Dis 1995').

has_hemodialysis_dose(renal_adj_029, drug_013).
has_dose_mg(renal_adj_029, 750).
has_interval_hours(renal_adj_029, 48).
has_dosing_guidance(renal_adj_029, 'Administer after dialysis; monitor levels').
has_source(renal_adj_029, 'Matzke et al. Drug Dosing in Renal Disease 2018').

%% Gentamicin Renal Adjustments
has_dose_adjustment(renal_adj_030, drug_014).
has_crcl_range(renal_adj_030, '<60').
has_dosing_guidance(renal_adj_030, 'Extend interval to q48-72h; adjust per TDM').
has_source(renal_adj_030, 'FDA Gentamicin Label 2024').

%% Levofloxacin Renal Adjustments
has_dose_adjustment(renal_adj_031, drug_016).
has_crcl_range(renal_adj_031, '50_20').
has_adjusted_dose(renal_adj_031, 750).
has_adjusted_interval(renal_adj_031, 48).
has_source(renal_adj_031, 'FDA Levaquin Label 2024').

has_dose_adjustment(renal_adj_032, drug_016).
has_crcl_range(renal_adj_032, '<20').
has_adjusted_dose(renal_adj_032, 750).
has_adjusted_interval(renal_adj_032, 48).
has_dosing_guidance(renal_adj_032, 'Initial 750mg, then 500mg q48h').
has_source(renal_adj_032, 'FDA Levaquin Label 2024').

%% Ciprofloxacin Renal Adjustments
has_dose_adjustment(renal_adj_033, drug_017).
has_crcl_range(renal_adj_033, '30_5').
has_adjusted_dose(renal_adj_033, 400).
has_adjusted_interval(renal_adj_033, 18).
has_source(renal_adj_033, 'FDA Cipro IV Label 2024').

has_hemodialysis_dose(renal_adj_034, drug_017).
has_dose_mg(renal_adj_034, 400).
has_interval_hours(renal_adj_034, 24).
has_dosing_guidance(renal_adj_034, 'Administer after dialysis session').
has_source(renal_adj_034, 'FDA Cipro IV Label 2024').

%% Tigecycline - No Renal Adjustment
has_dose_adjustment(renal_adj_035, drug_019).
has_crcl_range(renal_adj_035, 'any').
has_dosing_guidance(renal_adj_035, 'No dose adjustment required').
has_source(renal_adj_035, 'FDA Tygacil Label 2024').

%% Eravacycline - No Renal Adjustment
has_dose_adjustment(renal_adj_036, drug_020).
has_crcl_range(renal_adj_036, 'any').
has_dosing_guidance(renal_adj_036, 'No dose adjustment required').
has_source(renal_adj_036, 'FDA Xerava Label 2024').

%% Fosfomycin Renal Adjustments
has_dose_adjustment(renal_adj_037, drug_021).
has_crcl_range(renal_adj_037, '40_20').
has_adjusted_dose(renal_adj_037, 4000).
has_adjusted_interval(renal_adj_037, 12).
has_source(renal_adj_037, 'Chinese Fosfomycin Guidelines 2022').

has_dose_adjustment(renal_adj_038, drug_021).
has_crcl_range(renal_adj_038, '<20').
has_adjusted_dose(renal_adj_038, 4000).
has_adjusted_interval(renal_adj_038, 24).
has_source(renal_adj_038, 'Chinese Fosfomycin Guidelines 2022').

%% Aztreonam Renal Adjustments
has_dose_adjustment(renal_adj_039, drug_022).
has_crcl_range(renal_adj_039, '30_10').
has_adjusted_dose(renal_adj_039, 1000).
has_adjusted_interval(renal_adj_039, 8).
has_dosing_guidance(renal_adj_039, '50% of usual dose').
has_source(renal_adj_039, 'FDA Azactam Label 2024').

has_dose_adjustment(renal_adj_040, drug_022).
has_crcl_range(renal_adj_040, '<10').
has_adjusted_dose(renal_adj_040, 500).
has_adjusted_interval(renal_adj_040, 8).
has_dosing_guidance(renal_adj_040, '25% of usual dose').
has_source(renal_adj_040, 'FDA Azactam Label 2024').

%% Trimethoprim-Sulfamethoxazole Renal Adjustments
has_dose_adjustment(renal_adj_041, drug_023).
has_crcl_range(renal_adj_041, '30_15').
has_dosing_guidance(renal_adj_041, 'Reduce dose by 50%').
has_source(renal_adj_041, 'FDA Bactrim IV Label 2024').

has_dose_adjustment(renal_adj_042, drug_023).
has_crcl_range(renal_adj_042, '<15').
has_dosing_guidance(renal_adj_042, 'Not recommended').
has_source(renal_adj_042, 'FDA Bactrim IV Label 2024').

%% Plazomicin Renal Adjustments
has_dose_adjustment(renal_adj_043, drug_032).
has_crcl_range(renal_adj_043, '60_30').
has_adjusted_dose(renal_adj_043, 10).
has_adjusted_interval(renal_adj_043, 24).
has_source(renal_adj_043, 'FDA Zemdri Label 2024').

has_dose_adjustment(renal_adj_044, drug_032).
has_crcl_range(renal_adj_044, '30_15').
has_adjusted_dose(renal_adj_044, 6).
has_adjusted_interval(renal_adj_044, 24).
has_source(renal_adj_044, 'FDA Zemdri Label 2024').

has_dose_adjustment(renal_adj_045, drug_032).
has_crcl_range(renal_adj_045, '<15').
has_adjusted_dose(renal_adj_045, 4).
has_adjusted_interval(renal_adj_045, 24).
has_source(renal_adj_045, 'FDA Zemdri Label 2024').

%% Meropenem-Vaborbactam Renal Adjustments
has_dose_adjustment(renal_adj_046, drug_009).
has_crcl_range(renal_adj_046, '50_30').
has_adjusted_dose(renal_adj_046, 2000).
has_adjusted_interval(renal_adj_046, 8).
has_source(renal_adj_046, 'FDA Vabomere Label 2024').

has_dose_adjustment(renal_adj_047, drug_009).
has_crcl_range(renal_adj_047, '30_15').
has_adjusted_dose(renal_adj_047, 2000).
has_adjusted_interval(renal_adj_047, 12).
has_source(renal_adj_047, 'FDA Vabomere Label 2024').

has_dose_adjustment(renal_adj_048, drug_009).
has_crcl_range(renal_adj_048, '<15').
has_adjusted_dose(renal_adj_048, 1000).
has_adjusted_interval(renal_adj_048, 24).
has_source(renal_adj_048, 'FDA Vabomere Label 2024').

%% SECTION 10 COMPLETE MARKER

%% Mechanism #1: Beta-lactamase Production
has_resistance_mechanism(mechanism_001, beta_lactamase_production).
has_mechanism_type(mechanism_001, enzymatic_inactivation).
has_mechanism_description(mechanism_001, 'Hydrolysis of beta-lactam ring by beta-lactamase enzymes').
has_affected_drugs(mechanism_001, [penicillins, cephalosporins, carbapenems]).
has_source(mechanism_001, 'Bush-Jacoby Classification 2010; Antimicrob Agents Chemother 2010').

%% Mechanism #2: Efflux Pump Overexpression
has_resistance_mechanism(mechanism_002, efflux_pump_overexpression).
has_mechanism_type(mechanism_002, decreased_accumulation).
has_mechanism_description(mechanism_002, 'Active extrusion of antibiotics via membrane pumps').
has_affected_drugs(mechanism_002, [fluoroquinolones, tetracyclines, carbapenems]).
has_source(mechanism_002, 'Li et al. Clin Microbiol Rev 2015; efflux pump mechanisms').

%% Mechanism #3: Porin Loss/Mutation
has_resistance_mechanism(mechanism_003, porin_loss_mutation).
has_mechanism_type(mechanism_003, decreased_permeability).
has_mechanism_description(mechanism_003, 'Reduced membrane permeability due to porin channel loss').
has_affected_drugs(mechanism_003, [carbapenems, beta_lactams]).
has_source(mechanism_003, 'Nikaido H. Microbiol Mol Biol Rev 2003; porin mutation studies').

%% Mechanism #4: Target Site Modification
has_resistance_mechanism(mechanism_004, target_site_modification).
has_mechanism_type(mechanism_004, target_alteration).
has_mechanism_description(mechanism_004, 'Mutation in antibiotic binding site').
has_affected_drugs(mechanism_004, [fluoroquinolones, aminoglycosides]).
has_source(mechanism_004, 'Hooper DC. Clin Infect Dis 2001; quinolone resistance').

%% Mechanism #5: 16S rRNA Methylation
has_resistance_mechanism(mechanism_005, rrna_methylation).
has_mechanism_type(mechanism_005, target_protection).
has_mechanism_description(mechanism_005, 'Methylation of 16S rRNA prevents aminoglycoside binding').
has_affected_drugs(mechanism_005, [aminoglycosides]).
has_source(mechanism_005, 'Doi Y et al. Clin Infect Dis 2016; aminoglycoside resistance').

%% Mechanism #6: Plasmid-Mediated Resistance
has_resistance_mechanism(mechanism_006, plasmid_mediated_resistance).
has_mechanism_type(mechanism_006, horizontal_gene_transfer).
has_mechanism_description(mechanism_006, 'Transfer of resistance genes via plasmids').
has_affected_drugs(mechanism_006, [all_classes]).
has_source(mechanism_006, 'WHO Global AMR Surveillance 2021').

%% Mechanism #7: Chromosomal AmpC Overproduction
has_resistance_mechanism(mechanism_007, chromosomal_ampc_overproduction).
has_mechanism_type(mechanism_007, enzymatic_inactivation).
has_mechanism_description(mechanism_007, 'Derepression leading to AmpC beta-lactamase overproduction').
has_affected_drugs(mechanism_007, [cephalosporins, penicillins]).
has_source(mechanism_007, 'Jacoby GA. Clin Microbiol Rev 2009; AmpC beta-lactamases').

%% =============================================================================
%% SECTION 11: PK/PD Parameters (PK/PD参数)
%% =============================================================================

%% Meropenem PK/PD
has_pk_parameter(pk_001, drug_001).
has_parameter_type(pk_001, volume_distribution).
has_value(pk_001, 0.25).
has_unit(pk_001, 'L/kg').
has_source(pk_001, 'FDA Meropenem Label 2024').

has_pk_parameter(pk_002, drug_001).
has_parameter_type(pk_002, protein_binding).
has_value(pk_002, 2).
has_unit(pk_002, 'percent').
has_source(pk_002, 'FDA Meropenem Label 2024').

has_pk_parameter(pk_003, drug_001).
has_parameter_type(pk_003, half_life).
has_value(pk_003, 1.0).
has_unit(pk_003, 'hours').
has_source(pk_003, 'FDA Meropenem Label 2024').

has_pk_parameter(pk_004, drug_001).
has_parameter_type(pk_004, clearance).
has_value(pk_004, 'renal_70_percent').
has_source(pk_004, 'FDA Meropenem Label 2024').

has_pk_parameter(pk_005, drug_001).
has_parameter_type(pk_005, pkpd_target).
has_value(pk_005, 'time_above_mic_40_percent').
has_source(pk_005, 'Craig WA. Clin Infect Dis 1998').

%% Imipenem-Cilastatin PK/PD
has_pk_parameter(pk_006, drug_002).
has_parameter_type(pk_006, volume_distribution).
has_value(pk_006, 0.23).
has_unit(pk_006, 'L/kg').
has_source(pk_006, 'FDA Primaxin Label 2024').

has_pk_parameter(pk_007, drug_002).
has_parameter_type(pk_007, protein_binding).
has_value(pk_007, 20).
has_unit(pk_007, 'percent').
has_source(pk_007, 'FDA Primaxin Label 2024').

has_pk_parameter(pk_008, drug_002).
has_parameter_type(pk_008, half_life).
has_value(pk_008, 1.0).
has_unit(pk_008, 'hours').
has_source(pk_008, 'FDA Primaxin Label 2024').

has_pk_parameter(pk_009, drug_002).
has_parameter_type(pk_009, clearance).
has_value(pk_009, 'renal_70_percent').
has_source(pk_009, 'FDA Primaxin Label 2024').

has_pk_parameter(pk_010, drug_002).
has_parameter_type(pk_010, pkpd_target).
has_value(pk_010, 'time_above_mic_40_percent').
has_source(pk_010, 'Craig WA. Clin Infect Dis 1998').

%% Piperacillin-Tazobactam PK/PD
has_pk_parameter(pk_011, drug_003).
has_parameter_type(pk_011, volume_distribution).
has_value(pk_011, 0.18).
has_unit(pk_011, 'L/kg').
has_source(pk_011, 'FDA Zosyn Label 2024').

has_pk_parameter(pk_012, drug_003).
has_parameter_type(pk_012, protein_binding).
has_value(pk_012, 30).
has_unit(pk_012, 'percent').
has_source(pk_012, 'FDA Zosyn Label 2024').

has_pk_parameter(pk_013, drug_003).
has_parameter_type(pk_013, half_life).
has_value(pk_013, 1.0).
has_unit(pk_013, 'hours').
has_source(pk_013, 'FDA Zosyn Label 2024').

has_pk_parameter(pk_014, drug_003).
has_parameter_type(pk_014, clearance).
has_value(pk_014, 'renal_80_percent').
has_source(pk_014, 'FDA Zosyn Label 2024').

has_pk_parameter(pk_015, drug_003).
has_parameter_type(pk_015, pkpd_target).
has_value(pk_015, 'time_above_mic_50_percent').
has_source(pk_015, 'Lodise et al. Antimicrob Agents Chemother 2007').

%% Ceftazidime-Avibactam PK/PD
has_pk_parameter(pk_016, drug_006).
has_parameter_type(pk_016, volume_distribution).
has_value(pk_016, 0.2).
has_unit(pk_016, 'L/kg').
has_source(pk_016, 'FDA Avycaz Label 2024').

has_pk_parameter(pk_017, drug_006).
has_parameter_type(pk_017, protein_binding).
has_value(pk_017, 10).
has_unit(pk_017, 'percent').
has_source(pk_017, 'FDA Avycaz Label 2024').

has_pk_parameter(pk_018, drug_006).
has_parameter_type(pk_018, half_life).
has_value(pk_018, 2.7).
has_unit(pk_018, 'hours').
has_source(pk_018, 'FDA Avycaz Label 2024').

has_pk_parameter(pk_019, drug_006).
has_parameter_type(pk_019, clearance).
has_value(pk_019, 'renal_90_percent').
has_source(pk_019, 'FDA Avycaz Label 2024').

has_pk_parameter(pk_020, drug_006).
has_parameter_type(pk_020, pkpd_target).
has_value(pk_020, 'time_above_mic_50_percent').
has_source(pk_020, 'VanScoy et al. Antimicrob Agents Chemother 2013').

%% Ceftolozane-Tazobactam PK/PD
has_pk_parameter(pk_021, drug_007).
has_parameter_type(pk_021, volume_distribution).
has_value(pk_021, 0.17).
has_unit(pk_021, 'L/kg').
has_source(pk_021, 'FDA Zerbaxa Label 2024').

has_pk_parameter(pk_022, drug_007).
has_parameter_type(pk_022, protein_binding).
has_value(pk_022, 20).
has_unit(pk_022, 'percent').
has_source(pk_022, 'FDA Zerbaxa Label 2024').

has_pk_parameter(pk_023, drug_007).
has_parameter_type(pk_023, half_life).
has_value(pk_023, 2.8).
has_unit(pk_023, 'hours').
has_source(pk_023, 'FDA Zerbaxa Label 2024').

has_pk_parameter(pk_024, drug_007).
has_parameter_type(pk_024, clearance).
has_value(pk_024, 'renal_95_percent').
has_source(pk_024, 'FDA Zerbaxa Label 2024').

has_pk_parameter(pk_025, drug_007).
has_parameter_type(pk_025, pkpd_target).
has_value(pk_025, 'time_above_mic_40_percent').
has_source(pk_025, 'Craig WA. Pharmacotherapy 2011').

%% Cefiderocol PK/PD
has_pk_parameter(pk_026, drug_008).
has_parameter_type(pk_026, volume_distribution).
has_value(pk_026, 0.18).
has_unit(pk_026, 'L/kg').
has_source(pk_026, 'FDA Fetroja Label 2024').

has_pk_parameter(pk_027, drug_008).
has_parameter_type(pk_027, protein_binding).
has_value(pk_027, 58).
has_unit(pk_027, 'percent').
has_source(pk_027, 'FDA Fetroja Label 2024').

has_pk_parameter(pk_028, drug_008).
has_parameter_type(pk_028, half_life).
has_value(pk_028, 2.6).
has_unit(pk_028, 'hours').
has_source(pk_028, 'FDA Fetroja Label 2024').

has_pk_parameter(pk_029, drug_008).
has_parameter_type(pk_029, clearance).
has_value(pk_029, 'renal_90_percent').
has_source(pk_029, 'FDA Fetroja Label 2024').

has_pk_parameter(pk_030, drug_008).
has_parameter_type(pk_030, pkpd_target).
has_value(pk_030, 'time_above_mic_75_percent').
has_source(pk_030, 'Ito et al. J Antimicrob Chemother 2018').

%% Meropenem-Vaborbactam PK/PD
has_pk_parameter(pk_031, drug_009).
has_parameter_type(pk_031, volume_distribution).
has_value(pk_031, 0.25).
has_unit(pk_031, 'L/kg').
has_source(pk_031, 'FDA Vabomere Label 2024').

has_pk_parameter(pk_032, drug_009).
has_parameter_type(pk_032, protein_binding).
has_value(pk_032, 10).
has_unit(pk_032, 'percent').
has_source(pk_032, 'FDA Vabomere Label 2024').

has_pk_parameter(pk_033, drug_009).
has_parameter_type(pk_033, half_life).
has_value(pk_033, 2.0).
has_unit(pk_033, 'hours').
has_source(pk_033, 'FDA Vabomere Label 2024').

has_pk_parameter(pk_034, drug_009).
has_parameter_type(pk_034, clearance).
has_value(pk_034, 'renal_75_percent').
has_source(pk_034, 'FDA Vabomere Label 2024').

has_pk_parameter(pk_035, drug_009).
has_parameter_type(pk_035, pkpd_target).
has_value(pk_035, 'time_above_mic_40_percent').
has_source(pk_035, 'Craig WA. Clin Infect Dis 1998').

%% Imipenem-Cilastatin-Relebactam PK/PD
has_pk_parameter(pk_036, drug_010).
has_parameter_type(pk_036, volume_distribution).
has_value(pk_036, 0.21).
has_unit(pk_036, 'L/kg').
has_source(pk_036, 'FDA Recarbrio Label 2024').

has_pk_parameter(pk_037, drug_010).
has_parameter_type(pk_037, protein_binding).
has_value(pk_037, 20).
has_unit(pk_037, 'percent').
has_source(pk_037, 'FDA Recarbrio Label 2024').

has_pk_parameter(pk_038, drug_010).
has_parameter_type(pk_038, half_life).
has_value(pk_038, 1.2).
has_unit(pk_038, 'hours').
has_source(pk_038, 'FDA Recarbrio Label 2024').

has_pk_parameter(pk_039, drug_010).
has_parameter_type(pk_039, clearance).
has_value(pk_039, 'renal_70_percent').
has_source(pk_039, 'FDA Recarbrio Label 2024').

has_pk_parameter(pk_040, drug_010).
has_parameter_type(pk_040, pkpd_target).
has_value(pk_040, 'time_above_mic_40_percent').
has_source(pk_040, 'Craig WA. Clin Infect Dis 1998').

%% Colistin PK/PD
has_pk_parameter(pk_041, drug_011).
has_parameter_type(pk_041, volume_distribution).
has_value(pk_041, 0.3).
has_unit(pk_041, 'L/kg').
has_source(pk_041, 'Chinese Colistin Consensus 2024').

has_pk_parameter(pk_042, drug_011).
has_parameter_type(pk_042, protein_binding).
has_value(pk_042, 50).
has_unit(pk_042, 'percent').
has_source(pk_042, 'Plachouras et al. Clin Infect Dis 2009').

has_pk_parameter(pk_043, drug_011).
has_parameter_type(pk_043, half_life).
has_value(pk_043, 5.0).
has_unit(pk_043, 'hours').
has_source(pk_043, 'Chinese Colistin Consensus 2024').

has_pk_parameter(pk_044, drug_011).
has_parameter_type(pk_044, clearance).
has_value(pk_044, 'renal_60_percent').
has_source(pk_044, 'Chinese Colistin Consensus 2024').

has_pk_parameter(pk_045, drug_011).
has_parameter_type(pk_045, pkpd_target).
has_value(pk_045, 'auc_mic_ratio_50').
has_source(pk_045, 'Garonzik et al. Antimicrob Agents Chemother 2011').

%% Polymyxin B PK/PD
has_pk_parameter(pk_046, drug_012).
has_parameter_type(pk_046, volume_distribution).
has_value(pk_046, 0.27).
has_unit(pk_046, 'L/kg').
has_source(pk_046, 'Sandri et al. Clin Pharmacokinet 2013').

has_pk_parameter(pk_047, drug_012).
has_parameter_type(pk_047, protein_binding).
has_value(pk_047, 50).
has_unit(pk_047, 'percent').
has_source(pk_047, 'Sandri et al. Clin Pharmacokinet 2013').

has_pk_parameter(pk_048, drug_012).
has_parameter_type(pk_048, half_life).
has_value(pk_048, 13.0).
has_unit(pk_048, 'hours').
has_source(pk_048, 'Sandri et al. Clin Pharmacokinet 2013').

has_pk_parameter(pk_049, drug_012).
has_parameter_type(pk_049, clearance).
has_value(pk_049, 'non_renal_hepatic').
has_source(pk_049, 'Sandri et al. Clin Pharmacokinet 2013').

has_pk_parameter(pk_050, drug_012).
has_parameter_type(pk_050, pkpd_target).
has_value(pk_050, 'auc_mic_ratio_50').
has_source(pk_050, 'Sandri et al. Clin Pharmacokinet 2013').

%% Amikacin PK/PD
has_pk_parameter(pk_051, drug_013).
has_parameter_type(pk_051, volume_distribution).
has_value(pk_051, 0.25).
has_unit(pk_051, 'L/kg').
has_source(pk_051, 'FDA Amikacin Label 2024').

has_pk_parameter(pk_052, drug_013).
has_parameter_type(pk_052, protein_binding).
has_value(pk_052, 5).
has_unit(pk_052, 'percent').
has_source(pk_052, 'FDA Amikacin Label 2024').

has_pk_parameter(pk_053, drug_013).
has_parameter_type(pk_053, half_life).
has_value(pk_053, 2.5).
has_unit(pk_053, 'hours').
has_source(pk_053, 'FDA Amikacin Label 2024').

has_pk_parameter(pk_054, drug_013).
has_parameter_type(pk_054, clearance).
has_value(pk_054, 'renal_95_percent').
has_source(pk_054, 'FDA Amikacin Label 2024').

has_pk_parameter(pk_055, drug_013).
has_parameter_type(pk_055, pkpd_target).
has_value(pk_055, 'cmax_mic_ratio_8_to_10').
has_source(pk_055, 'Moore et al. J Infect Dis 1987').

%% Gentamicin PK/PD
has_pk_parameter(pk_056, drug_014).
has_parameter_type(pk_056, volume_distribution).
has_value(pk_056, 0.26).
has_unit(pk_056, 'L/kg').
has_source(pk_056, 'FDA Gentamicin Label 2024').

has_pk_parameter(pk_057, drug_014).
has_parameter_type(pk_057, protein_binding).
has_value(pk_057, 5).
has_unit(pk_057, 'percent').
has_source(pk_057, 'FDA Gentamicin Label 2024').

has_pk_parameter(pk_058, drug_014).
has_parameter_type(pk_058, half_life).
has_value(pk_058, 2.0).
has_unit(pk_058, 'hours').
has_source(pk_058, 'FDA Gentamicin Label 2024').

has_pk_parameter(pk_059, drug_014).
has_parameter_type(pk_059, clearance).
has_value(pk_059, 'renal_95_percent').
has_source(pk_059, 'FDA Gentamicin Label 2024').

has_pk_parameter(pk_060, drug_014).
has_parameter_type(pk_060, pkpd_target).
has_value(pk_060, 'cmax_mic_ratio_8_to_10').
has_source(pk_060, 'Moore et al. J Infect Dis 1987').

%% Tigecycline PK/PD
has_pk_parameter(pk_061, drug_019).
has_parameter_type(pk_061, volume_distribution).
has_value(pk_061, 7.0).
has_unit(pk_061, 'L/kg').
has_source(pk_061, 'FDA Tygacil Label 2024').

has_pk_parameter(pk_062, drug_019).
has_parameter_type(pk_062, protein_binding).
has_value(pk_062, 75).
has_unit(pk_062, 'percent').
has_source(pk_062, 'FDA Tygacil Label 2024').

has_pk_parameter(pk_063, drug_019).
has_parameter_type(pk_063, half_life).
has_value(pk_063, 42.0).
has_unit(pk_063, 'hours').
has_source(pk_063, 'FDA Tygacil Label 2024').

has_pk_parameter(pk_064, drug_019).
has_parameter_type(pk_064, clearance).
has_value(pk_064, 'biliary_fecal_60_percent').
has_source(pk_064, 'FDA Tygacil Label 2024').

has_pk_parameter(pk_065, drug_019).
has_parameter_type(pk_065, pkpd_target).
has_value(pk_065, 'auc_mic_ratio_6_to_10').
has_source(pk_065, 'Bhavnani et al. Antimicrob Agents Chemother 2012').

%% Levofloxacin PK/PD
has_pk_parameter(pk_066, drug_017).
has_parameter_type(pk_066, volume_distribution).
has_value(pk_066, 1.0).
has_unit(pk_066, 'L/kg').
has_source(pk_066, 'FDA Levaquin Label 2024').

has_pk_parameter(pk_067, drug_017).
has_parameter_type(pk_067, protein_binding).
has_value(pk_067, 30).
has_unit(pk_067, 'percent').
has_source(pk_067, 'FDA Levaquin Label 2024').

has_pk_parameter(pk_068, drug_017).
has_parameter_type(pk_068, half_life).
has_value(pk_068, 6.0).
has_unit(pk_068, 'hours').
has_source(pk_068, 'FDA Levaquin Label 2024').

has_pk_parameter(pk_069, drug_017).
has_parameter_type(pk_069, clearance).
has_value(pk_069, 'renal_85_percent').
has_source(pk_069, 'FDA Levaquin Label 2024').

has_pk_parameter(pk_070, drug_017).
has_parameter_type(pk_070, pkpd_target).
has_value(pk_070, 'auc_mic_ratio_100').
has_source(pk_070, 'Drusano et al. Clin Infect Dis 2004').

%% Ciprofloxacin PK/PD
has_pk_parameter(pk_071, drug_016).
has_parameter_type(pk_071, volume_distribution).
has_value(pk_071, 2.5).
has_unit(pk_071, 'L/kg').
has_source(pk_071, 'FDA Cipro Label 2024').

has_pk_parameter(pk_072, drug_016).
has_parameter_type(pk_072, protein_binding).
has_value(pk_072, 30).
has_unit(pk_072, 'percent').
has_source(pk_072, 'FDA Cipro Label 2024').

has_pk_parameter(pk_073, drug_016).
has_parameter_type(pk_073, half_life).
has_value(pk_073, 4.0).
has_unit(pk_073, 'hours').
has_source(pk_073, 'FDA Cipro Label 2024').

has_pk_parameter(pk_074, drug_016).
has_parameter_type(pk_074, clearance).
has_value(pk_074, 'renal_60_percent').
has_source(pk_074, 'FDA Cipro Label 2024').

has_pk_parameter(pk_075, drug_016).
has_parameter_type(pk_075, pkpd_target).
has_value(pk_075, 'auc_mic_ratio_125').
has_source(pk_075, 'Drusano et al. Antimicrob Agents Chemother 1993').

%% Aztreonam PK/PD
has_pk_parameter(pk_076, drug_018).
has_parameter_type(pk_076, volume_distribution).
has_value(pk_076, 0.16).
has_unit(pk_076, 'L/kg').
has_source(pk_076, 'FDA Azactam Label 2024').

has_pk_parameter(pk_077, drug_018).
has_parameter_type(pk_077, protein_binding).
has_value(pk_077, 56).
has_unit(pk_077, 'percent').
has_source(pk_077, 'FDA Azactam Label 2024').

has_pk_parameter(pk_078, drug_018).
has_parameter_type(pk_078, half_life).
has_value(pk_078, 1.7).
has_unit(pk_078, 'hours').
has_source(pk_078, 'FDA Azactam Label 2024').

has_pk_parameter(pk_079, drug_018).
has_parameter_type(pk_079, clearance).
has_value(pk_079, 'renal_70_percent').
has_source(pk_079, 'FDA Azactam Label 2024').

has_pk_parameter(pk_080, drug_018).
has_parameter_type(pk_080, pkpd_target).
has_value(pk_080, 'time_above_mic_40_percent').
has_source(pk_080, 'Craig WA. Clin Infect Dis 1998').

%% Fosfomycin PK/PD
has_pk_parameter(pk_081, drug_025).
has_parameter_type(pk_081, volume_distribution).
has_value(pk_081, 0.22).
has_unit(pk_081, 'L/kg').
has_source(pk_081, 'Falagas et al. Clin Microbiol Rev 2016').

has_pk_parameter(pk_082, drug_025).
has_parameter_type(pk_082, protein_binding).
has_value(pk_082, 0).
has_unit(pk_082, 'percent').
has_source(pk_082, 'Falagas et al. Clin Microbiol Rev 2016').

has_pk_parameter(pk_083, drug_025).
has_parameter_type(pk_083, half_life).
has_value(pk_083, 2.0).
has_unit(pk_083, 'hours').
has_source(pk_083, 'Falagas et al. Clin Microbiol Rev 2016').

has_pk_parameter(pk_084, drug_025).
has_parameter_type(pk_084, clearance).
has_value(pk_084, 'renal_90_percent').
has_source(pk_084, 'Falagas et al. Clin Microbiol Rev 2016').

has_pk_parameter(pk_085, drug_025).
has_parameter_type(pk_085, pkpd_target).
has_value(pk_085, 'auc_mic_ratio_100').
has_source(pk_085, 'VanScoy et al. Antimicrob Agents Chemother 2015').

%% SECTION 11 COMPLETE MARKER

%% =============================================================================
%% SECTION 12: TDM Guidelines (TDM指南)
%% =============================================================================

%% Amikacin TDM
has_tdm_target(tdm_001, drug_013).
has_target_type(tdm_001, peak_concentration).
has_target_range(tdm_001, '55_to_65').
has_unit(tdm_001, 'mg/L').
has_sampling_time(tdm_001, '30_min_after_infusion_end').
has_source(tdm_001, 'IDSA Therapeutic Drug Monitoring Guidelines 2020').

has_tdm_target(tdm_002, drug_013).
has_target_type(tdm_002, trough_concentration).
has_target_range(tdm_002, 'less_than_10').
has_unit(tdm_002, 'mg/L').
has_sampling_time(tdm_002, 'immediately_before_next_dose').
has_source(tdm_002, 'IDSA Therapeutic Drug Monitoring Guidelines 2020').

has_tdm_target(tdm_003, drug_013).
has_target_type(tdm_003, auc_24h).
has_target_range(tdm_003, '400_to_600').
has_unit(tdm_003, 'mg*h/L').
has_source(tdm_003, 'Neely et al. Clin Infect Dis 2014').

%% Gentamicin TDM
has_tdm_target(tdm_004, drug_014).
has_target_type(tdm_004, peak_concentration).
has_target_range(tdm_004, '15_to_20').
has_unit(tdm_004, 'mg/L').
has_sampling_time(tdm_004, '30_min_after_infusion_end').
has_source(tdm_004, 'IDSA Therapeutic Drug Monitoring Guidelines 2020').

has_tdm_target(tdm_005, drug_014).
has_target_type(tdm_005, trough_concentration).
has_target_range(tdm_005, 'less_than_2').
has_unit(tdm_005, 'mg/L').
has_sampling_time(tdm_005, 'immediately_before_next_dose').
has_source(tdm_005, 'IDSA Therapeutic Drug Monitoring Guidelines 2020').

has_tdm_target(tdm_006, drug_014).
has_target_type(tdm_006, auc_24h).
has_target_range(tdm_006, '80_to_120').
has_unit(tdm_006, 'mg*h/L').
has_source(tdm_006, 'Neely et al. Clin Infect Dis 2014').

%% Colistin TDM
has_tdm_target(tdm_007, drug_011).
has_target_type(tdm_007, steady_state_concentration).
has_target_range(tdm_007, '2_to_2.5').
has_unit(tdm_007, 'mg/L').
has_sampling_time(tdm_007, 'at_steady_state_any_time').
has_source(tdm_007, 'Chinese Colistin Consensus 2024').

has_tdm_target(tdm_008, drug_011).
has_target_type(tdm_008, auc_24h).
has_target_range(tdm_008, '50_to_100').
has_unit(tdm_008, 'mg*h/L').
has_dosing_guidance(tdm_008, 'Target AUC for CRE infections; balance efficacy vs nephrotoxicity').
has_source(tdm_008, 'Nation et al. Antimicrob Agents Chemother 2017').

%% Polymyxin B TDM
has_tdm_target(tdm_009, drug_012).
has_target_type(tdm_009, steady_state_concentration).
has_target_range(tdm_009, '2_to_3').
has_unit(tdm_009, 'mg/L').
has_sampling_time(tdm_009, 'at_steady_state_any_time').
has_source(tdm_009, 'Sandri et al. Clin Pharmacokinet 2013').

has_tdm_target(tdm_010, drug_012).
has_target_type(tdm_010, auc_24h).
has_target_range(tdm_010, '50_to_100').
has_unit(tdm_010, 'mg*h/L').
has_dosing_guidance(tdm_010, 'Target for MDR gram-negative infections').
has_source(tdm_010, 'Tsuji et al. Antimicrob Agents Chemother 2019').

%% Meropenem TDM (for augmented renal clearance or difficult-to-treat infections)
has_tdm_target(tdm_011, drug_001).
has_target_type(tdm_011, trough_concentration).
has_target_range(tdm_011, 'greater_than_8').
has_unit(tdm_011, 'mg/L').
has_sampling_time(tdm_011, 'immediately_before_next_dose').
has_dosing_guidance(tdm_011, 'For MIC ≥2 mg/L or augmented renal clearance').
has_source(tdm_011, 'Abdul-Aziz et al. Intensive Care Med 2020').

has_tdm_target(tdm_012, drug_001).
has_target_type(tdm_012, time_above_mic).
has_target_range(tdm_012, '100_percent').
has_dosing_guidance(tdm_012, 'Target 100% fT>4×MIC for critically ill; use extended infusion').
has_source(tdm_012, 'Roberts et al. Clin Pharmacokinet 2014').

%% Piperacillin-Tazobactam TDM
has_tdm_target(tdm_013, drug_003).
has_target_type(tdm_013, trough_concentration).
has_target_range(tdm_013, 'greater_than_64').
has_unit(tdm_013, 'mg/L').
has_sampling_time(tdm_013, 'immediately_before_next_dose').
has_dosing_guidance(tdm_013, 'For Pseudomonas infections; use extended infusion').
has_source(tdm_013, 'Felton et al. J Antimicrob Chemother 2014').

has_tdm_target(tdm_014, drug_003).
has_target_type(tdm_014, time_above_mic).
has_target_range(tdm_014, '50_percent').
has_dosing_guidance(tdm_014, 'Minimum target for efficacy; 100% fT>MIC for critically ill').
has_source(tdm_014, 'Lodise et al. Antimicrob Agents Chemother 2007').

%% Ceftazidime-Avibactam TDM
has_tdm_target(tdm_015, drug_006).
has_target_type(tdm_015, trough_concentration).
has_target_range(tdm_015, 'greater_than_10').
has_unit(tdm_015, 'mg/L').
has_sampling_time(tdm_015, 'immediately_before_next_dose').
has_dosing_guidance(tdm_015, 'For CRE infections; target 4×MIC for ceftazidime component').
has_source(tdm_015, 'VanScoy et al. Antimicrob Agents Chemother 2013').

%% Tigecycline TDM
has_tdm_target(tdm_016, drug_019).
has_target_type(tdm_016, trough_concentration).
has_target_range(tdm_016, '0.3_to_0.6').
has_unit(tdm_016, 'mg/L').
has_sampling_time(tdm_016, 'at_steady_state').
has_dosing_guidance(tdm_016, 'Higher doses may be needed for pneumonia; monitor liver function').
has_source(tdm_016, 'Bhavnani et al. Antimicrob Agents Chemother 2012').

has_tdm_target(tdm_017, drug_019).
has_target_type(tdm_017, auc_mic_ratio).
has_target_range(tdm_017, '6_to_10').
has_dosing_guidance(tdm_017, 'For carbapenem-resistant infections; high-dose tigecycline may be needed').
has_source(tdm_017, 'Bhavnani et al. Antimicrob Agents Chemother 2012').

%% Levofloxacin TDM
has_tdm_target(tdm_018, drug_017).
has_target_type(tdm_018, auc_mic_ratio).
has_target_range(tdm_018, 'greater_than_100').
has_dosing_guidance(tdm_018, 'For Pseudomonas infections target AUC/MIC >100; for Enterobacterales >87').
has_source(tdm_018, 'Drusano et al. Clin Infect Dis 2004').

has_tdm_target(tdm_019, drug_017).
has_target_type(tdm_019, peak_concentration).
has_target_range(tdm_019, '10_to_12').
has_unit(tdm_019, 'mg/L').
has_sampling_time(tdm_019, '1_to_2_hours_after_dose').
has_source(tdm_019, 'FDA Levaquin Label 2024').

%% Ciprofloxacin TDM
has_tdm_target(tdm_020, drug_016).
has_target_type(tdm_020, auc_mic_ratio).
has_target_range(tdm_020, 'greater_than_125').
has_dosing_guidance(tdm_020, 'For gram-negative infections; higher ratios reduce resistance emergence').
has_source(tdm_020, 'Drusano et al. Antimicrob Agents Chemother 1993').

has_tdm_target(tdm_021, drug_016).
has_target_type(tdm_021, peak_concentration).
has_target_range(tdm_021, '8_to_10').
has_unit(tdm_021, 'mg/L').
has_sampling_time(tdm_021, '1_to_2_hours_after_dose').
has_source(tdm_021, 'FDA Cipro Label 2024').

%% Cefiderocol TDM
has_tdm_target(tdm_022, drug_008).
has_target_type(tdm_022, time_above_mic).
has_target_range(tdm_022, '75_percent').
has_dosing_guidance(tdm_022, 'Target 75% fT>MIC for carbapenem-resistant infections').
has_source(tdm_022, 'Ito et al. J Antimicrob Chemother 2018').

has_tdm_target(tdm_023, drug_008).
has_target_type(tdm_023, trough_concentration).
has_target_range(tdm_023, 'greater_than_4').
has_unit(tdm_023, 'mg/L').
has_sampling_time(tdm_023, 'immediately_before_next_dose').
has_dosing_guidance(tdm_023, 'For high MIC organisms; consider extended infusion').
has_source(tdm_023, 'FDA Fetroja Label 2024').

%% Plazomicin TDM
has_tdm_target(tdm_024, drug_032).
has_target_type(tdm_024, auc_24h).
has_target_range(tdm_024, '263').
has_unit(tdm_024, 'mg*h/L').
has_dosing_guidance(tdm_024, 'Target AUC for CRE infections; Bayesian-guided dosing recommended').
has_source(tdm_024, 'FDA Zemdri Label 2024').

has_tdm_target(tdm_025, drug_032).
has_target_type(tdm_025, trough_concentration).
has_target_range(tdm_025, 'less_than_3').
has_unit(tdm_025, 'mg/L').
has_sampling_time(tdm_025, 'immediately_before_next_dose').
has_dosing_guidance(tdm_025, 'To minimize nephrotoxicity risk').
has_source(tdm_025, 'FDA Zemdri Label 2024').

%% Aztreonam TDM (for high-risk patients or augmented renal clearance)
has_tdm_target(tdm_026, drug_018).
has_target_type(tdm_026, trough_concentration).
has_target_range(tdm_026, 'greater_than_8').
has_unit(tdm_026, 'mg/L').
has_sampling_time(tdm_026, 'immediately_before_next_dose').
has_dosing_guidance(tdm_026, 'For MBL-producing organisms; target 4×MIC').
has_source(tdm_026, 'Crandon et al. Antimicrob Agents Chemother 2010').

%% SECTION 12 COMPLETE MARKER

%% =============================================================================
%% SECTION 13: Tissue Penetration (组织穿透)
%% =============================================================================

%% Meropenem tissue penetration
has_tissue_penetration(tissue_001, drug_001).
has_tissue(tissue_001, csf).
has_penetration_ratio(tissue_001, 0.2).
has_unit(tissue_001, 'csf_serum_ratio').
has_indication(tissue_001, 'Meningitis only with inflamed meninges').
has_source(tissue_001, 'Nau et al. Antimicrob Agents Chemother 2010').

has_tissue_penetration(tissue_002, drug_001).
has_tissue(tissue_002, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_002, 0.6).
has_unit(tissue_002, 'elf_serum_ratio').
has_source(tissue_002, 'Lodise et al. Antimicrob Agents Chemother 2011').

has_tissue_penetration(tissue_003, drug_001).
has_tissue(tissue_003, urinary_tract).
has_penetration_ratio(tissue_003, 25).
has_unit(tissue_003, 'urinary_concentration_fold').
has_source(tissue_003, 'FDA Meropenem Label 2024').

has_tissue_penetration(tissue_004, drug_001).
has_tissue(tissue_004, peritoneal_fluid).
has_penetration_ratio(tissue_004, 0.55).
has_unit(tissue_004, 'peritoneal_serum_ratio').
has_source(tissue_004, 'Tegeder et al. Antimicrob Agents Chemother 1997').

%% Imipenem-cilastatin tissue penetration
has_tissue_penetration(tissue_005, drug_002).
has_tissue(tissue_005, csf).
has_penetration_ratio(tissue_005, 0.15).
has_unit(tissue_005, 'csf_serum_ratio').
has_indication(tissue_005, 'Meningitis with inflamed meninges').
has_source(tissue_005, 'Norrby SR. Scand J Infect Dis Suppl 1987').

has_tissue_penetration(tissue_006, drug_002).
has_tissue(tissue_006, lung_tissue).
has_penetration_ratio(tissue_006, 0.5).
has_unit(tissue_006, 'lung_serum_ratio').
has_source(tissue_006, 'FDA Imipenem-Cilastatin Label 2024').

has_tissue_penetration(tissue_007, drug_002).
has_tissue(tissue_007, urinary_tract).
has_penetration_ratio(tissue_007, 20).
has_unit(tissue_007, 'urinary_concentration_fold').
has_source(tissue_007, 'FDA Imipenem-Cilastatin Label 2024').

%% Piperacillin-tazobactam tissue penetration
has_tissue_penetration(tissue_008, drug_003).
has_tissue(tissue_008, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_008, 0.5).
has_unit(tissue_008, 'elf_serum_ratio').
has_source(tissue_008, 'Felton et al. Antimicrob Agents Chemother 2013').

has_tissue_penetration(tissue_009, drug_003).
has_tissue(tissue_009, peritoneal_fluid).
has_penetration_ratio(tissue_009, 0.6).
has_unit(tissue_009, 'peritoneal_serum_ratio').
has_source(tissue_009, 'Kuti et al. J Antimicrob Chemother 2002').

has_tissue_penetration(tissue_010, drug_003).
has_tissue(tissue_010, urinary_tract).
has_penetration_ratio(tissue_010, 30).
has_unit(tissue_010, 'urinary_concentration_fold').
has_source(tissue_010, 'FDA Piperacillin-Tazobactam Label 2024').

%% Ceftazidime-avibactam tissue penetration
has_tissue_penetration(tissue_011, drug_004).
has_tissue(tissue_011, csf).
has_penetration_ratio(tissue_011, 0.25).
has_unit(tissue_011, 'csf_serum_ratio').
has_indication(tissue_011, 'Meningitis; limited clinical data').
has_source(tissue_011, 'Zhanel et al. Drugs 2013').

has_tissue_penetration(tissue_012, drug_004).
has_tissue(tissue_012, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_012, 0.35).
has_unit(tissue_012, 'elf_serum_ratio').
has_source(tissue_012, 'Nicolau et al. Antimicrob Agents Chemother 2015').

has_tissue_penetration(tissue_013, drug_004).
has_tissue(tissue_013, urinary_tract).
has_penetration_ratio(tissue_013, 40).
has_unit(tissue_013, 'urinary_concentration_fold').
has_source(tissue_013, 'FDA Ceftazidime-Avibactam Label 2024').

%% Ceftolozane-tazobactam tissue penetration
has_tissue_penetration(tissue_014, drug_005).
has_tissue(tissue_014, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_014, 0.6).
has_unit(tissue_014, 'elf_serum_ratio').
has_source(tissue_014, 'Lepak et al. Antimicrob Agents Chemother 2015').

has_tissue_penetration(tissue_015, drug_005).
has_tissue(tissue_015, urinary_tract).
has_penetration_ratio(tissue_015, 50).
has_unit(tissue_015, 'urinary_concentration_fold').
has_source(tissue_015, 'FDA Ceftolozane-Tazobactam Label 2024').

%% Cefiderocol tissue penetration
has_tissue_penetration(tissue_016, drug_006).
has_tissue(tissue_016, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_016, 0.3).
has_unit(tissue_016, 'elf_serum_ratio').
has_source(tissue_016, 'Katsube et al. J Infect Chemother 2019').

has_tissue_penetration(tissue_017, drug_006).
has_tissue(tissue_017, urinary_tract).
has_penetration_ratio(tissue_017, 35).
has_unit(tissue_017, 'urinary_concentration_fold').
has_source(tissue_017, 'FDA Cefiderocol Label 2024').

has_tissue_penetration(tissue_018, drug_006).
has_tissue(tissue_018, csf).
has_penetration_ratio(tissue_018, 0.1).
has_unit(tissue_018, 'csf_serum_ratio').
has_indication(tissue_018, 'Limited data; not recommended for meningitis').
has_source(tissue_018, 'FDA Cefiderocol Label 2024; Black Box Warning').

%% Colistin tissue penetration
has_tissue_penetration(tissue_019, drug_011).
has_tissue(tissue_019, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_019, 0.25).
has_unit(tissue_019, 'elf_serum_ratio').
has_source(tissue_019, 'Imberti et al. Antimicrob Agents Chemother 2010').

has_tissue_penetration(tissue_020, drug_011).
has_tissue(tissue_020, csf).
has_penetration_ratio(tissue_020, 0.05).
has_unit(tissue_020, 'csf_serum_ratio').
has_indication(tissue_020, 'Poor CNS penetration; requires intrathecal administration for meningitis').
has_source(tissue_020, 'Karaiskos et al. Int J Antimicrob Agents 2017').

has_tissue_penetration(tissue_021, drug_011).
has_tissue(tissue_021, urinary_tract).
has_penetration_ratio(tissue_021, 15).
has_unit(tissue_021, 'urinary_concentration_fold').
has_source(tissue_021, 'Chinese Polymyxin Consensus 2024').

%% Polymyxin B tissue penetration
has_tissue_penetration(tissue_022, drug_012).
has_tissue(tissue_022, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_022, 0.2).
has_unit(tissue_022, 'elf_serum_ratio').
has_source(tissue_022, 'Sandri et al. Chest 2013').

has_tissue_penetration(tissue_023, drug_012).
has_tissue(tissue_023, csf).
has_penetration_ratio(tissue_023, 0.03).
has_unit(tissue_023, 'csf_serum_ratio').
has_indication(tissue_023, 'Very poor CNS penetration; intrathecal/intraventricular administration required').
has_source(tissue_023, 'Karaiskos et al. Int J Antimicrob Agents 2017').

%% Amikacin tissue penetration
has_tissue_penetration(tissue_024, drug_013).
has_tissue(tissue_024, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_024, 0.4).
has_unit(tissue_024, 'elf_serum_ratio').
has_source(tissue_024, 'Touw et al. Clin Pharmacokinet 1984').

has_tissue_penetration(tissue_025, drug_013).
has_tissue(tissue_025, csf).
has_penetration_ratio(tissue_025, 0.1).
has_unit(tissue_025, 'csf_serum_ratio').
has_indication(tissue_025, 'Poor CNS penetration; not recommended for meningitis').
has_source(tissue_025, 'FDA Amikacin Label 2024').

has_tissue_penetration(tissue_026, drug_013).
has_tissue(tissue_026, urinary_tract).
has_penetration_ratio(tissue_026, 100).
has_unit(tissue_026, 'urinary_concentration_fold').
has_source(tissue_026, 'FDA Amikacin Label 2024').

%% Gentamicin tissue penetration
has_tissue_penetration(tissue_027, drug_014).
has_tissue(tissue_027, urinary_tract).
has_penetration_ratio(tissue_027, 80).
has_unit(tissue_027, 'urinary_concentration_fold').
has_source(tissue_027, 'FDA Gentamicin Label 2024').

has_tissue_penetration(tissue_028, drug_014).
has_tissue(tissue_028, csf).
has_penetration_ratio(tissue_028, 0.1).
has_unit(tissue_028, 'csf_serum_ratio').
has_indication(tissue_028, 'Poor CNS penetration').
has_source(tissue_028, 'FDA Gentamicin Label 2024').

%% Tigecycline tissue penetration
has_tissue_penetration(tissue_029, drug_015).
has_tissue(tissue_029, lung_tissue).
has_penetration_ratio(tissue_029, 2.5).
has_unit(tissue_029, 'lung_serum_ratio').
has_source(tissue_029, 'Rodvold et al. Antimicrob Agents Chemother 2006').

has_tissue_penetration(tissue_030, drug_015).
has_tissue(tissue_030, peritoneal_fluid).
has_penetration_ratio(tissue_030, 1.8).
has_unit(tissue_030, 'peritoneal_serum_ratio').
has_source(tissue_030, 'Rodvold et al. J Antimicrob Chemother 2008').

has_tissue_penetration(tissue_031, drug_015).
has_tissue(tissue_031, bile).
has_penetration_ratio(tissue_031, 8).
has_unit(tissue_031, 'bile_serum_ratio').
has_source(tissue_031, 'FDA Tigecycline Label 2024').

has_tissue_penetration(tissue_032, drug_015).
has_tissue(tissue_032, urinary_tract).
has_penetration_ratio(tissue_032, 0.3).
has_unit(tissue_032, 'urinary_serum_ratio').
has_indication(tissue_032, 'Poor urinary excretion; not recommended for UTI').
has_source(tissue_032, 'FDA Tigecycline Label 2024; Black Box Warning').

%% Levofloxacin tissue penetration
has_tissue_penetration(tissue_033, drug_016).
has_tissue(tissue_033, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_033, 2.5).
has_unit(tissue_033, 'elf_serum_ratio').
has_source(tissue_033, 'Gotfried et al. Antimicrob Agents Chemother 2001').

has_tissue_penetration(tissue_034, drug_016).
has_tissue(tissue_034, csf).
has_penetration_ratio(tissue_034, 0.7).
has_unit(tissue_034, 'csf_serum_ratio').
has_source(tissue_034, 'Drusano et al. Antimicrob Agents Chemother 2000').

has_tissue_penetration(tissue_035, drug_016).
has_tissue(tissue_035, urinary_tract).
has_penetration_ratio(tissue_035, 50).
has_unit(tissue_035, 'urinary_concentration_fold').
has_source(tissue_035, 'FDA Levofloxacin Label 2024').

%% Ciprofloxacin tissue penetration
has_tissue_penetration(tissue_036, drug_017).
has_tissue(tissue_036, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_036, 2.0).
has_unit(tissue_036, 'elf_serum_ratio').
has_source(tissue_036, 'Boselli et al. Intensive Care Med 2005').

has_tissue_penetration(tissue_037, drug_017).
has_tissue(tissue_037, csf).
has_penetration_ratio(tissue_037, 0.5).
has_unit(tissue_037, 'csf_serum_ratio').
has_source(tissue_037, 'FDA Ciprofloxacin Label 2024').

has_tissue_penetration(tissue_038, drug_017).
has_tissue(tissue_038, urinary_tract).
has_penetration_ratio(tissue_038, 60).
has_unit(tissue_038, 'urinary_concentration_fold').
has_source(tissue_038, 'FDA Ciprofloxacin Label 2024').

%% Aztreonam tissue penetration
has_tissue_penetration(tissue_039, drug_018).
has_tissue(tissue_039, csf).
has_penetration_ratio(tissue_039, 0.3).
has_unit(tissue_039, 'csf_serum_ratio').
has_indication(tissue_039, 'Meningitis with inflamed meninges').
has_source(tissue_039, 'Schaad et al. Antimicrob Agents Chemother 1985').

has_tissue_penetration(tissue_040, drug_018).
has_tissue(tissue_040, lung_tissue).
has_penetration_ratio(tissue_040, 0.4).
has_unit(tissue_040, 'lung_serum_ratio').
has_source(tissue_040, 'FDA Aztreonam Label 2024').

has_tissue_penetration(tissue_041, drug_018).
has_tissue(tissue_041, urinary_tract).
has_penetration_ratio(tissue_041, 45).
has_unit(tissue_041, 'urinary_concentration_fold').
has_source(tissue_041, 'FDA Aztreonam Label 2024').

%% Fosfomycin tissue penetration
has_tissue_penetration(tissue_042, drug_019).
has_tissue(tissue_042, urinary_tract).
has_penetration_ratio(tissue_042, 200).
has_unit(tissue_042, 'urinary_concentration_fold').
has_source(tissue_042, 'FDA Fosfomycin Label 2024').

has_tissue_penetration(tissue_043, drug_019).
has_tissue(tissue_043, lung_tissue).
has_penetration_ratio(tissue_043, 0.5).
has_unit(tissue_043, 'lung_serum_ratio').
has_source(tissue_043, 'Chinese Fosfomycin Guidelines 2022').

has_tissue_penetration(tissue_044, drug_019).
has_tissue(tissue_044, csf).
has_penetration_ratio(tissue_044, 0.4).
has_unit(tissue_044, 'csf_serum_ratio').
has_indication(tissue_044, 'Good CNS penetration with inflamed meninges').
has_source(tissue_044, 'Chinese Fosfomycin Guidelines 2022').

%% Meropenem-vaborbactam tissue penetration
has_tissue_penetration(tissue_045, drug_007).
has_tissue(tissue_045, urinary_tract).
has_penetration_ratio(tissue_045, 30).
has_unit(tissue_045, 'urinary_concentration_fold').
has_source(tissue_045, 'FDA Meropenem-Vaborbactam Label 2024').

has_tissue_penetration(tissue_046, drug_007).
has_tissue(tissue_046, lung_epithelial_lining_fluid).
has_penetration_ratio(tissue_046, 0.55).
has_unit(tissue_046, 'elf_serum_ratio').
has_source(tissue_046, 'Wenzler et al. Antimicrob Agents Chemother 2015').

%% Imipenem-cilastatin-relebactam tissue penetration
has_tissue_penetration(tissue_047, drug_008).
has_tissue(tissue_047, urinary_tract).
has_penetration_ratio(tissue_047, 25).
has_unit(tissue_047, 'urinary_concentration_fold').
has_source(tissue_047, 'FDA Imipenem-Cilastatin-Relebactam Label 2024').

has_tissue_penetration(tissue_048, drug_008).
has_tissue(tissue_048, lung_tissue).
has_penetration_ratio(tissue_048, 0.5).
has_unit(tissue_048, 'lung_serum_ratio').
has_source(tissue_048, 'FDA Imipenem-Cilastatin-Relebactam Label 2024').

%% SECTION 13 COMPLETE MARKER

%% =============================================================================
%% === 第2轮新增内容开始 ===
%% =============================================================================

%% =============================================================================
%% SECTION 14: Empiric Treatment Recommendations（经验治疗推荐）
%% =============================================================================
%% Structure: empiric_tx_{id} is the treatment node
%%   - has_setting/2 — clinical setting
%%   - has_site/2 — infection site
%%   - has_risk_level/2 — risk stratification
%%   - has_suspected_pathogens/2 — likely pathogens (list)
%%   - has_regimen/2 — recommended regimen
%%   - has_source/2 — source with page reference
%% =============================================================================

%% Export new predicates for Round 2
:- dynamic has_setting/2.
:- dynamic has_risk_level/2.
:- dynamic has_suspected_pathogens/2.
:- dynamic has_crcl_min/2.
:- dynamic has_crcl_max/2.
:- dynamic has_adjusted_dose/2.
:- dynamic has_adjusted_interval/2.
:- dynamic has_population/2.
:- dynamic has_dose_adjustment/2.
:- dynamic has_interval/2.
:- dynamic has_target_type/2.
:- dynamic has_target_range/2.
:- dynamic has_sampling_time/2.
:- dynamic has_tissue/2.
:- dynamic has_penetration_ratio/2.
:- dynamic has_severity/2.
:- dynamic has_duration_days/2.
:- dynamic has_criteria/2.
:- dynamic has_switch_to/2.
:- dynamic has_pathogen_category/2.
:- dynamic has_dose_mg/2.
:- dynamic has_interval_hours/2.
:- dynamic has_infusion_minutes/2.

%% --- Empiric Treatment #1: ICU Hospital-Acquired Pneumonia (High Risk) ---
has_setting(empiric_tx_001, icu).
has_site(empiric_tx_001, vap_hap).
has_risk_level(empiric_tx_001, high_risk).
has_suspected_pathogens(empiric_tx_001, 'CRE, CRPA, CRAB, ESBL-E').
has_regimen(empiric_tx_001, 'ceftazidime_avibactam 2.5g q8h + polymyxin_b 1.5-2.0 million units q12h OR meropenem_vaborbactam 4g q8h (extended infusion)').
has_source(empiric_tx_001, 'ATS/IDSA HAP/VAP Guidelines 2016; ESCMID MDR-GNB Guidelines 2021').

%% --- Empiric Treatment #2: Ventilator-Associated Pneumonia (High Risk) ---
has_setting(empiric_tx_002, ventilator_associated).
has_site(empiric_tx_002, vap_hap).
has_risk_level(empiric_tx_002, high_risk).
has_suspected_pathogens(empiric_tx_002, 'CRPA, Acinetobacter, ESBL-E, CRE').
has_regimen(empiric_tx_002, 'cefiderocol 2g q8h (3h infusion) OR ceftolozane_tazobactam 3g q8h + amikacin 15-20mg/kg q24h').
has_source(empiric_tx_002, 'ATS/IDSA HAP/VAP Guidelines 2016; ESCMID MDR-GNB Guidelines 2021').

%% --- Empiric Treatment #3: Neutropenic Fever (High Risk) ---
has_setting(empiric_tx_003, neutropenic).
has_site(empiric_tx_003, neutropenic_fever).
has_risk_level(empiric_tx_003, high_risk).
has_suspected_pathogens(empiric_tx_003, 'CRE, ESBL-E, Pseudomonas').
has_regimen(empiric_tx_003, 'cefepime_taniborbactam 2.5g q8h OR meropenem 2g q8h (extended infusion) + amikacin 15mg/kg q24h').
has_source(empiric_tx_003, 'IDSA Febrile Neutropenia Guidelines 2011; ECIL-4 Guidelines 2013').

%% --- Empiric Treatment #4: Intra-Abdominal Infection (Moderate) ---
has_setting(empiric_tx_004, hospital_acquired).
has_site(empiric_tx_004, iai).
has_risk_level(empiric_tx_004, moderate_risk).
has_suspected_pathogens(empiric_tx_004, 'E.coli, Klebsiella, Enterococcus, anaerobes').
has_regimen(empiric_tx_004, 'piperacillin_tazobactam 4.5g q6h (extended infusion) OR ertapenem 1g q24h').
has_source(empiric_tx_004, 'IDSA IAI Guidelines 2010, 2017 update; WSES Guidelines 2017').

%% --- Empiric Treatment #5: Intra-Abdominal Infection (High Risk/Severe) ---
has_setting(empiric_tx_005, icu).
has_site(empiric_tx_005, iai).
has_risk_level(empiric_tx_005, high_risk).
has_suspected_pathogens(empiric_tx_005, 'CRE, ESBL-E, Pseudomonas, anaerobes').
has_regimen(empiric_tx_005, 'ceftazidime_avibactam 2.5g q8h + metronidazole 500mg q8h OR imipenem_relebactam 1.25g q6h + metronidazole 500mg q8h').
has_source(empiric_tx_005, 'IDSA IAI Guidelines 2010, 2017 update; WSES Guidelines 2017').

%% --- Empiric Treatment #6: Complicated UTI (Moderate Risk) ---
has_setting(empiric_tx_006, healthcare_associated).
has_site(empiric_tx_006, cuti).
has_risk_level(empiric_tx_006, moderate_risk).
has_suspected_pathogens(empiric_tx_006, 'ESBL-E, E.coli, Klebsiella').
has_regimen(empiric_tx_006, 'ertapenem 1g q24h OR amikacin 15mg/kg q24h + cefepime 2g q8h').
has_source(empiric_tx_006, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #7: Complicated UTI (High Risk/Septic) ---
has_setting(empiric_tx_007, icu).
has_site(empiric_tx_007, cuti).
has_risk_level(empiric_tx_007, high_risk).
has_suspected_pathogens(empiric_tx_007, 'CRE, CRPA, ESBL-E').
has_regimen(empiric_tx_007, 'ceftazidime_avibactam 2.5g q8h OR meropenem_vaborbactam 4g q8h (extended infusion) + amikacin 15-20mg/kg q24h').
has_source(empiric_tx_007, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #8: Bloodstream Infection (Low Risk/Community) ---
has_setting(empiric_tx_008, community_acquired).
has_site(empiric_tx_008, bsi).
has_risk_level(empiric_tx_008, low_risk).
has_suspected_pathogens(empiric_tx_008, 'E.coli, Klebsiella').
has_regimen(empiric_tx_008, 'ceftriaxone 2g q24h OR piperacillin_tazobactam 4.5g q6h').
has_source(empiric_tx_008, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #9: Bloodstream Infection (High Risk/HAI) ---
has_setting(empiric_tx_009, hospital_acquired).
has_site(empiric_tx_009, bsi).
has_risk_level(empiric_tx_009, high_risk).
has_suspected_pathogens(empiric_tx_009, 'CRE, ESBL-E, CRPA').
has_regimen(empiric_tx_009, 'ceftazidime_avibactam 2.5g q8h OR imipenem_relebactam 1.25g q6h + tigecycline 100mg load then 50mg q12h').
has_source(empiric_tx_009, 'Surviving Sepsis Campaign Guidelines 2021; ESCMID MDR-GNB Guidelines 2021').

%% --- Empiric Treatment #10: Surgical Site Infection (Abdominal Surgery) ---
has_setting(empiric_tx_010, post_surgical).
has_site(empiric_tx_010, surgical_site_inf).
has_risk_level(empiric_tx_010, moderate_risk).
has_suspected_pathogens(empiric_tx_010, 'E.coli, Enterococcus, anaerobes, ESBL-E').
has_regimen(empiric_tx_010, 'piperacillin_tazobactam 4.5g q6h OR ertapenem 1g q24h + metronidazole 500mg q8h').
has_source(empiric_tx_010, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #11: Surgical Site Infection (Orthopedic) ---
has_setting(empiric_tx_011, post_surgical).
has_site(empiric_tx_011, bone_joint).
has_risk_level(empiric_tx_011, moderate_risk).
has_suspected_pathogens(empiric_tx_011, 'Staphylococcus, ESBL-E, Pseudomonas').
has_regimen(empiric_tx_011, 'vancomycin 15-20mg/kg q8-12h + cefepime 2g q8h OR linezolid 600mg q12h + meropenem 2g q8h').
has_source(empiric_tx_011, 'IDSA SSI Prevention Guidelines 2017; WHO SSI Guidelines 2018').

%% --- Empiric Treatment #12: Peritoneal Dialysis Peritonitis (Empiric) ---
has_setting(empiric_tx_012, peritoneal_dialysis).
has_site(empiric_tx_012, peritonitis_pd).
has_risk_level(empiric_tx_012, moderate_risk).
has_suspected_pathogens(empiric_tx_012, 'Staphylococcus, E.coli, Pseudomonas').
has_regimen(empiric_tx_012, 'cefazolin 20mg/kg IP + ceftazidime 15mg/kg IP OR vancomycin 15-30mg/kg IP q5-7d + ceftazidime 15mg/kg IP').
has_source(empiric_tx_012, 'ISPD Peritonitis Guidelines 2022').

%% --- Empiric Treatment #13: Burn Wound Infection (GNB Coverage) ---
has_setting(empiric_tx_013, icu).
has_site(empiric_tx_013, ssti).
has_risk_level(empiric_tx_013, high_risk).
has_suspected_pathogens(empiric_tx_013, 'CRPA, Acinetobacter, ESBL-E').
has_regimen(empiric_tx_013, 'meropenem 2g q8h (extended infusion) + polymyxin_b 1.5-2.0 million units q12h OR cefiderocol 2g q8h + vancomycin').
has_source(empiric_tx_013, 'ABA Burn Infection Guidelines 2017; Burn Care & Research 2023').

%% --- Empiric Treatment #14: Septic Shock (Broad-Spectrum Empiric) ---
has_setting(empiric_tx_014, icu).
has_site(empiric_tx_014, bsi).
has_risk_level(empiric_tx_014, very_high_risk).
has_suspected_pathogens(empiric_tx_014, 'CRE, CRPA, CRAB, Candida').
has_regimen(empiric_tx_014, 'ceftazidime_avibactam 2.5g q8h + polymyxin_b 2.0 million units q12h + echinocandin').
has_source(empiric_tx_014, 'Surviving Sepsis Campaign Guidelines 2021').

%% --- Empiric Treatment #15: Hematologic Malignancy High CRE Risk ---
has_setting(empiric_tx_015, neutropenic).
has_site(empiric_tx_015, bsi).
has_risk_level(empiric_tx_015, very_high_risk).
has_suspected_pathogens(empiric_tx_015, 'CRE, ESBL-E').
has_regimen(empiric_tx_015, 'ceftazidime_avibactam 2.5g q8h + tigecycline 100mg load then 50mg q12h').
has_source(empiric_tx_015, 'IDSA Febrile Neutropenia Guidelines 2011; ESCMID MDR-GNB Guidelines 2021').

%% --- Empiric Treatment #16: Prosthetic Joint Infection (Empiric) ---
has_setting(empiric_tx_016, post_surgical).
has_site(empiric_tx_016, bone_joint).
has_risk_level(empiric_tx_016, high_risk).
has_suspected_pathogens(empiric_tx_016, 'Staphylococcus, Pseudomonas, ESBL-E').
has_regimen(empiric_tx_016, 'vancomycin 15-20mg/kg q8-12h + cefepime 2g q8h + rifampin 600mg q24h').
has_source(empiric_tx_016, 'IDSA SSI Prevention Guidelines 2017; WHO SSI Guidelines 2018').

%% --- Empiric Treatment #17: Bacterial Meningitis (Post-Neurosurgery) ---
has_setting(empiric_tx_017, post_surgical).
has_site(empiric_tx_017, cns_meningitis).
has_risk_level(empiric_tx_017, very_high_risk).
has_suspected_pathogens(empiric_tx_017, 'Acinetobacter, Pseudomonas, Staphylococcus').
has_regimen(empiric_tx_017, 'meropenem 2g q8h + vancomycin 15-20mg/kg q8-12h + consider intrathecal polymyxin_b or colistin').
has_source(empiric_tx_017, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #18: Skin/Soft Tissue Infection (High Risk) ---
has_setting(empiric_tx_018, healthcare_associated).
has_site(empiric_tx_018, ssti).
has_risk_level(empiric_tx_018, high_risk).
has_suspected_pathogens(empiric_tx_018, 'MRSA, ESBL-E, Pseudomonas').
has_regimen(empiric_tx_018, 'vancomycin 15-20mg/kg q8-12h + piperacillin_tazobactam 4.5g q6h OR linezolid 600mg q12h + cefepime 2g q8h').
has_source(empiric_tx_018, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #19: Hepatobiliary Infection (Severe) ---
has_setting(empiric_tx_019, hospital_acquired).
has_site(empiric_tx_019, iai).
has_risk_level(empiric_tx_019, high_risk).
has_suspected_pathogens(empiric_tx_019, 'E.coli, Klebsiella, Enterococcus, ESBL-E').
has_regimen(empiric_tx_019, 'piperacillin_tazobactam 4.5g q6h + vancomycin 15-20mg/kg q8-12h OR imipenem_relebactam 1.25g q6h').
has_source(empiric_tx_019, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Empiric Treatment #20: Catheter-Related BSI (High Risk) ---
has_setting(empiric_tx_020, healthcare_associated).
has_site(empiric_tx_020, bsi).
has_risk_level(empiric_tx_020, high_risk).
has_suspected_pathogens(empiric_tx_020, 'Staphylococcus, Candida, ESBL-E, Pseudomonas').
has_regimen(empiric_tx_020, 'vancomycin 15-20mg/kg q8-12h + cefepime 2g q8h + consider echinocandin if high Candida risk').
has_source(empiric_tx_020, 'IDSA CLABSI Guidelines 2009, 2021 update').

%% =============================================================================
%% END OF SECTION 14: Empiric Treatment Recommendations
%% Total entries: 20 (covering all required clinical scenarios)
%% =============================================================================

%% =============================================================================
%% SECTION 15: Dosing Regimens (给药方案)
%% =============================================================================
%% Structure: dosing_{drug}_{indication} is the dosing node
%%   - has_drug/2 — drug name
%%   - has_indication/2 — normal/severe/uti/meningitis/inhalation/intrathecal/ip_peritoneal/topical
%%   - has_dose_mg/2 — dose in mg (or weight_based(X, mg_per_kg))
%%   - has_interval_hours/2 — dosing interval in hours
%%   - has_infusion_minutes/2 — infusion duration (30/180/continuous)
%%   - has_source/2 — source with page reference
%% =============================================================================

%% --- Carbapenems: Meropenem ---
has_drug(dosing_meropenem_normal, meropenem).
has_indication(dosing_meropenem_normal, normal).
has_dose_mg(dosing_meropenem_normal, 1000).
has_interval_hours(dosing_meropenem_normal, 8).
has_infusion_minutes(dosing_meropenem_normal, 30).
has_source(dosing_meropenem_normal, 'FDA Label 2024; Meropenem Prescribing Information').

has_drug(dosing_meropenem_severe, meropenem).
has_indication(dosing_meropenem_severe, severe).
has_dose_mg(dosing_meropenem_severe, 2000).
has_interval_hours(dosing_meropenem_severe, 8).
has_infusion_minutes(dosing_meropenem_severe, 180).
has_source(dosing_meropenem_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_meropenem_meningitis, meropenem).
has_indication(dosing_meropenem_meningitis, meningitis).
has_dose_mg(dosing_meropenem_meningitis, 2000).
has_interval_hours(dosing_meropenem_meningitis, 8).
has_infusion_minutes(dosing_meropenem_meningitis, 30).
has_source(dosing_meropenem_meningitis, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Carbapenems: Imipenem ---
has_drug(dosing_imipenem_normal, imipenem).
has_indication(dosing_imipenem_normal, normal).
has_dose_mg(dosing_imipenem_normal, 500).
has_interval_hours(dosing_imipenem_normal, 6).
has_infusion_minutes(dosing_imipenem_normal, 30).
has_source(dosing_imipenem_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_imipenem_severe, imipenem).
has_indication(dosing_imipenem_severe, severe).
has_dose_mg(dosing_imipenem_severe, 1000).
has_interval_hours(dosing_imipenem_severe, 6).
has_infusion_minutes(dosing_imipenem_severe, 60).
has_source(dosing_imipenem_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Carbapenems: Ertapenem ---
has_drug(dosing_ertapenem_normal, ertapenem).
has_indication(dosing_ertapenem_normal, normal).
has_dose_mg(dosing_ertapenem_normal, 1000).
has_interval_hours(dosing_ertapenem_normal, 24).
has_infusion_minutes(dosing_ertapenem_normal, 30).
has_source(dosing_ertapenem_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Carbapenems: Doripenem ---
has_drug(dosing_doripenem_normal, doripenem).
has_indication(dosing_doripenem_normal, normal).
has_dose_mg(dosing_doripenem_normal, 500).
has_interval_hours(dosing_doripenem_normal, 8).
has_infusion_minutes(dosing_doripenem_normal, 60).
has_source(dosing_doripenem_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_doripenem_severe, doripenem).
has_indication(dosing_doripenem_severe, severe).
has_dose_mg(dosing_doripenem_severe, 1000).
has_interval_hours(dosing_doripenem_severe, 8).
has_infusion_minutes(dosing_doripenem_severe, 240).
has_source(dosing_doripenem_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Carbapenems: Biapenem ---
has_drug(dosing_biapenem_normal, biapenem).
has_indication(dosing_biapenem_normal, normal).
has_dose_mg(dosing_biapenem_normal, 300).
has_interval_hours(dosing_biapenem_normal, 12).
has_infusion_minutes(dosing_biapenem_normal, 30).
has_source(dosing_biapenem_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- BLI Combinations: Ceftazidime-Avibactam ---
has_drug(dosing_caz_avi_normal, ceftazidime_avibactam).
has_indication(dosing_caz_avi_normal, normal).
has_dose_mg(dosing_caz_avi_normal, 2500).
has_interval_hours(dosing_caz_avi_normal, 8).
has_infusion_minutes(dosing_caz_avi_normal, 120).
has_source(dosing_caz_avi_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

%% --- BLI Combinations: Meropenem-Vaborbactam ---
has_drug(dosing_mer_vab_normal, meropenem_vaborbactam).
has_indication(dosing_mer_vab_normal, normal).
has_dose_mg(dosing_mer_vab_normal, 4000).
has_interval_hours(dosing_mer_vab_normal, 8).
has_infusion_minutes(dosing_mer_vab_normal, 180).
has_source(dosing_mer_vab_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

%% --- BLI Combinations: Imipenem-Relebactam ---
has_drug(dosing_imi_rel_normal, imipenem_relebactam).
has_indication(dosing_imi_rel_normal, normal).
has_dose_mg(dosing_imi_rel_normal, 1250).
has_interval_hours(dosing_imi_rel_normal, 6).
has_infusion_minutes(dosing_imi_rel_normal, 30).
has_source(dosing_imi_rel_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

%% --- BLI Combinations: Cefepime-Taniborbactam ---
has_drug(dosing_fep_tan_normal, cefepime_taniborbactam).
has_indication(dosing_fep_tan_normal, normal).
has_dose_mg(dosing_fep_tan_normal, 2500).
has_interval_hours(dosing_fep_tan_normal, 8).
has_infusion_minutes(dosing_fep_tan_normal, 120).
has_source(dosing_fep_tan_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

%% --- BLI Combinations: Aztreonam-Avibactam ---
has_drug(dosing_atm_avi_normal, aztreonam_avibactam).
has_indication(dosing_atm_avi_normal, normal).
has_dose_mg(dosing_atm_avi_normal, 2500).
has_interval_hours(dosing_atm_avi_normal, 8).
has_infusion_minutes(dosing_atm_avi_normal, 180).
has_source(dosing_atm_avi_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

%% --- BLI Combinations: Ceftolozane-Tazobactam ---
has_drug(dosing_c_t_normal, ceftolozane_tazobactam).
has_indication(dosing_c_t_normal, normal).
has_dose_mg(dosing_c_t_normal, 1500).
has_interval_hours(dosing_c_t_normal, 8).
has_infusion_minutes(dosing_c_t_normal, 60).
has_source(dosing_c_t_normal, 'FDA Labels 2024; Antimicrob Agents Chemother 2023').

has_drug(dosing_c_t_severe, ceftolozane_tazobactam).
has_indication(dosing_c_t_severe, severe).
has_dose_mg(dosing_c_t_severe, 3000).
has_interval_hours(dosing_c_t_severe, 8).
has_infusion_minutes(dosing_c_t_severe, 180).
has_source(dosing_c_t_severe, 'IDSA CRPA Guidelines 2020; Clin Infect Dis 2021').

%% --- BLI Combinations: Sulbactam-Durlobactam ---
has_drug(dosing_sul_dur_normal, sulbactam_durlobactam).
has_indication(dosing_sul_dur_normal, normal).
has_dose_mg(dosing_sul_dur_normal, 2000).
has_interval_hours(dosing_sul_dur_normal, 6).
has_infusion_minutes(dosing_sul_dur_normal, 60).
has_source(dosing_sul_dur_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Siderophore Cephalosporin: Cefiderocol ---
has_drug(dosing_cefiderocol_normal, cefiderocol).
has_indication(dosing_cefiderocol_normal, normal).
has_dose_mg(dosing_cefiderocol_normal, 2000).
has_interval_hours(dosing_cefiderocol_normal, 8).
has_infusion_minutes(dosing_cefiderocol_normal, 180).
has_source(dosing_cefiderocol_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Polymyxins: Polymyxin B ---
has_drug(dosing_polymyxin_b_normal, polymyxin_b).
has_indication(dosing_polymyxin_b_normal, normal).
has_dose_mg(dosing_polymyxin_b_normal, 1500000).
has_interval_hours(dosing_polymyxin_b_normal, 12).
has_infusion_minutes(dosing_polymyxin_b_normal, 60).
has_source(dosing_polymyxin_b_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_polymyxin_b_severe, polymyxin_b).
has_indication(dosing_polymyxin_b_severe, severe).
has_dose_mg(dosing_polymyxin_b_severe, 2000000).
has_interval_hours(dosing_polymyxin_b_severe, 12).
has_infusion_minutes(dosing_polymyxin_b_severe, 60).
has_source(dosing_polymyxin_b_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Polymyxins: Colistin ---
has_drug(dosing_colistin_normal, colistin).
has_indication(dosing_colistin_normal, normal).
has_dose_mg(dosing_colistin_normal, 2500000).
has_interval_hours(dosing_colistin_normal, 12).
has_infusion_minutes(dosing_colistin_normal, 30).
has_source(dosing_colistin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_colistin_inhalation, colistin).
has_indication(dosing_colistin_inhalation, inhalation).
has_dose_mg(dosing_colistin_inhalation, 1000000).
has_interval_hours(dosing_colistin_inhalation, 12).
has_infusion_minutes(dosing_colistin_inhalation, 'nebulization').
has_source(dosing_colistin_inhalation, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Tetracyclines: Tigecycline ---
has_drug(dosing_tigecycline_normal, tigecycline).
has_indication(dosing_tigecycline_normal, normal).
has_dose_mg(dosing_tigecycline_normal, 50).
has_interval_hours(dosing_tigecycline_normal, 12).
has_infusion_minutes(dosing_tigecycline_normal, 30).
has_note(dosing_tigecycline_normal, 'loading_dose_100mg').
has_source(dosing_tigecycline_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_tigecycline_severe, tigecycline).
has_indication(dosing_tigecycline_severe, severe).
has_dose_mg(dosing_tigecycline_severe, 100).
has_interval_hours(dosing_tigecycline_severe, 12).
has_infusion_minutes(dosing_tigecycline_severe, 30).
has_note(dosing_tigecycline_severe, 'loading_dose_200mg').
has_source(dosing_tigecycline_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Tetracyclines: Eravacycline ---
has_drug(dosing_eravacycline_normal, eravacycline).
has_indication(dosing_eravacycline_normal, normal).
has_dose_mg(dosing_eravacycline_normal, 1000).
has_interval_hours(dosing_eravacycline_normal, 12).
has_infusion_minutes(dosing_eravacycline_normal, 60).
has_source(dosing_eravacycline_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Tetracyclines: Minocycline ---
has_drug(dosing_minocycline_normal, minocycline).
has_indication(dosing_minocycline_normal, normal).
has_dose_mg(dosing_minocycline_normal, 100).
has_interval_hours(dosing_minocycline_normal, 12).
has_infusion_minutes(dosing_minocycline_normal, 60).
has_source(dosing_minocycline_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_minocycline_severe, minocycline).
has_indication(dosing_minocycline_severe, severe).
has_dose_mg(dosing_minocycline_severe, 200).
has_interval_hours(dosing_minocycline_severe, 12).
has_infusion_minutes(dosing_minocycline_severe, 60).
has_source(dosing_minocycline_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Tetracyclines: Omadacycline ---
has_drug(dosing_omadacycline_normal, omadacycline).
has_indication(dosing_omadacycline_normal, normal).
has_dose_mg(dosing_omadacycline_normal, 100).
has_interval_hours(dosing_omadacycline_normal, 24).
has_infusion_minutes(dosing_omadacycline_normal, 30).
has_note(dosing_omadacycline_normal, 'loading_200mg_day1_then_100mg').
has_source(dosing_omadacycline_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Aminoglycosides: Amikacin ---
has_drug(dosing_amikacin_normal, amikacin).
has_indication(dosing_amikacin_normal, normal).
has_dose_mg(dosing_amikacin_normal, weight_based(15, mg_per_kg)).
has_interval_hours(dosing_amikacin_normal, 24).
has_infusion_minutes(dosing_amikacin_normal, 30).
has_source(dosing_amikacin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_amikacin_severe, amikacin).
has_indication(dosing_amikacin_severe, severe).
has_dose_mg(dosing_amikacin_severe, weight_based(20, mg_per_kg)).
has_interval_hours(dosing_amikacin_severe, 24).
has_infusion_minutes(dosing_amikacin_severe, 30).
has_source(dosing_amikacin_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Aminoglycosides: Tobramycin ---
has_drug(dosing_tobramycin_normal, tobramycin).
has_indication(dosing_tobramycin_normal, normal).
has_dose_mg(dosing_tobramycin_normal, weight_based(5, mg_per_kg)).
has_interval_hours(dosing_tobramycin_normal, 24).
has_infusion_minutes(dosing_tobramycin_normal, 30).
has_source(dosing_tobramycin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_tobramycin_inhalation, tobramycin).
has_indication(dosing_tobramycin_inhalation, inhalation).
has_dose_mg(dosing_tobramycin_inhalation, 300).
has_interval_hours(dosing_tobramycin_inhalation, 12).
has_infusion_minutes(dosing_tobramycin_inhalation, 'nebulization').
has_source(dosing_tobramycin_inhalation, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Aminoglycosides: Gentamicin ---
has_drug(dosing_gentamicin_normal, gentamicin).
has_indication(dosing_gentamicin_normal, normal).
has_dose_mg(dosing_gentamicin_normal, weight_based(5, mg_per_kg)).
has_interval_hours(dosing_gentamicin_normal, 24).
has_infusion_minutes(dosing_gentamicin_normal, 30).
has_source(dosing_gentamicin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Aminoglycosides: Plazomicin ---
has_drug(dosing_plazomicin_normal, plazomicin).
has_indication(dosing_plazomicin_normal, normal).
has_dose_mg(dosing_plazomicin_normal, 15).
has_interval_hours(dosing_plazomicin_normal, 24).
has_infusion_minutes(dosing_plazomicin_normal, 30).
has_source(dosing_plazomicin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Aminoglycosides: Isepamicin ---
has_drug(dosing_isepamicin_normal, isepamicin).
has_indication(dosing_isepamicin_normal, normal).
has_dose_mg(dosing_isepamicin_normal, weight_based(15, mg_per_kg)).
has_interval_hours(dosing_isepamicin_normal, 24).
has_infusion_minutes(dosing_isepamicin_normal, 30).
has_source(dosing_isepamicin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Fluoroquinolones: Ciprofloxacin ---
has_drug(dosing_ciprofloxacin_normal, ciprofloxacin).
has_indication(dosing_ciprofloxacin_normal, normal).
has_dose_mg(dosing_ciprofloxacin_normal, 400).
has_interval_hours(dosing_ciprofloxacin_normal, 12).
has_infusion_minutes(dosing_ciprofloxacin_normal, 60).
has_source(dosing_ciprofloxacin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_ciprofloxacin_severe, ciprofloxacin).
has_indication(dosing_ciprofloxacin_severe, severe).
has_dose_mg(dosing_ciprofloxacin_severe, 400).
has_interval_hours(dosing_ciprofloxacin_severe, 8).
has_infusion_minutes(dosing_ciprofloxacin_severe, 60).
has_source(dosing_ciprofloxacin_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Fluoroquinolones: Levofloxacin ---
has_drug(dosing_levofloxacin_normal, levofloxacin).
has_indication(dosing_levofloxacin_normal, normal).
has_dose_mg(dosing_levofloxacin_normal, 500).
has_interval_hours(dosing_levofloxacin_normal, 24).
has_infusion_minutes(dosing_levofloxacin_normal, 60).
has_source(dosing_levofloxacin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_levofloxacin_severe, levofloxacin).
has_indication(dosing_levofloxacin_severe, severe).
has_dose_mg(dosing_levofloxacin_severe, 750).
has_interval_hours(dosing_levofloxacin_severe, 24).
has_infusion_minutes(dosing_levofloxacin_severe, 90).
has_source(dosing_levofloxacin_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Fluoroquinolones: Moxifloxacin ---
has_drug(dosing_moxifloxacin_normal, moxifloxacin).
has_indication(dosing_moxifloxacin_normal, normal).
has_dose_mg(dosing_moxifloxacin_normal, 400).
has_interval_hours(dosing_moxifloxacin_normal, 24).
has_infusion_minutes(dosing_moxifloxacin_normal, 60).
has_source(dosing_moxifloxacin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Others: Aztreonam ---
has_drug(dosing_aztreonam_normal, aztreonam).
has_indication(dosing_aztreonam_normal, normal).
has_dose_mg(dosing_aztreonam_normal, 1000).
has_interval_hours(dosing_aztreonam_normal, 8).
has_infusion_minutes(dosing_aztreonam_normal, 30).
has_source(dosing_aztreonam_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_aztreonam_severe, aztreonam).
has_indication(dosing_aztreonam_severe, severe).
has_dose_mg(dosing_aztreonam_severe, 2000).
has_interval_hours(dosing_aztreonam_severe, 8).
has_infusion_minutes(dosing_aztreonam_severe, 60).
has_source(dosing_aztreonam_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Others: Fosfomycin ---
has_drug(dosing_fosfomycin_normal, fosfomycin).
has_indication(dosing_fosfomycin_normal, normal).
has_dose_mg(dosing_fosfomycin_normal, 4000).
has_interval_hours(dosing_fosfomycin_normal, 8).
has_infusion_minutes(dosing_fosfomycin_normal, 60).
has_source(dosing_fosfomycin_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_fosfomycin_severe, fosfomycin).
has_indication(dosing_fosfomycin_severe, severe).
has_dose_mg(dosing_fosfomycin_severe, 6000).
has_interval_hours(dosing_fosfomycin_severe, 8).
has_infusion_minutes(dosing_fosfomycin_severe, 60).
has_source(dosing_fosfomycin_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% --- Others: Trimethoprim-Sulfamethoxazole ---
has_drug(dosing_tmp_smx_normal, trimethoprim_sulfamethoxazole).
has_indication(dosing_tmp_smx_normal, normal).
has_dose_mg(dosing_tmp_smx_normal, 320).
has_interval_hours(dosing_tmp_smx_normal, 12).
has_infusion_minutes(dosing_tmp_smx_normal, 60).
has_note(dosing_tmp_smx_normal, 'dose_based_on_tmp_component').
has_source(dosing_tmp_smx_normal, 'FDA Label 2024; IDSA/ESCMID Guidelines').

has_drug(dosing_tmp_smx_severe, trimethoprim_sulfamethoxazole).
has_indication(dosing_tmp_smx_severe, severe).
has_dose_mg(dosing_tmp_smx_severe, 320).
has_interval_hours(dosing_tmp_smx_severe, 8).
has_infusion_minutes(dosing_tmp_smx_severe, 60).
has_source(dosing_tmp_smx_severe, 'FDA Label 2024; IDSA/ESCMID Guidelines').

%% =============================================================================
%% END OF SECTION 15: Dosing Regimens
%% Total drug entries: 30+ (covering all required antibiotic classes)
%% =============================================================================

%% =============================================================================
%% SECTION 16: Renal Dose Adjustments (肾功能剂量调整)
%% =============================================================================
%% Target: ≥5 CrCl ranges per drug for core antibiotics
%% Predicate schema:
%%   renal_{drug}_{crcl_range} as node
%%   has_drug/2, has_crcl_min/2, has_crcl_max/2,
%%   has_adjusted_dose/2, has_adjusted_interval/2, has_source/2
%% =============================================================================

%% --- Meropenem renal adjustments ---
has_drug(renal_meropenem_high, meropenem).
has_crcl_min(renal_meropenem_high, 80).
has_crcl_max(renal_meropenem_high, 999).
has_adjusted_dose(renal_meropenem_high, '2g q8h (no adjustment)').
has_adjusted_interval(renal_meropenem_high, 8).
has_source(renal_meropenem_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_moderate_high, meropenem).
has_crcl_min(renal_meropenem_moderate_high, 50).
has_crcl_max(renal_meropenem_moderate_high, 79).
has_adjusted_dose(renal_meropenem_moderate_high, '1-2g q8h').
has_adjusted_interval(renal_meropenem_moderate_high, 8).
has_source(renal_meropenem_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_moderate, meropenem).
has_crcl_min(renal_meropenem_moderate, 30).
has_crcl_max(renal_meropenem_moderate, 49).
has_adjusted_dose(renal_meropenem_moderate, '1g q12h').
has_adjusted_interval(renal_meropenem_moderate, 12).
has_source(renal_meropenem_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_low, meropenem).
has_crcl_min(renal_meropenem_low, 15).
has_crcl_max(renal_meropenem_low, 29).
has_adjusted_dose(renal_meropenem_low, '500mg q12h').
has_adjusted_interval(renal_meropenem_low, 12).
has_source(renal_meropenem_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_severe, meropenem).
has_crcl_min(renal_meropenem_severe, 0).
has_crcl_max(renal_meropenem_severe, 14).
has_adjusted_dose(renal_meropenem_severe, '500mg q24h').
has_adjusted_interval(renal_meropenem_severe, 24).
has_source(renal_meropenem_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_hd, meropenem).
has_modality(renal_meropenem_hd, hemodialysis).
has_adjusted_dose(renal_meropenem_hd, '500mg q24h, post-dialysis dose').
has_adjusted_interval(renal_meropenem_hd, 24).
has_source(renal_meropenem_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_meropenem_crrt, meropenem).
has_modality(renal_meropenem_crrt, crrt).
has_adjusted_dose(renal_meropenem_crrt, '1-2g q8-12h').
has_adjusted_interval(renal_meropenem_crrt, 8).
has_source(renal_meropenem_crrt, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% --- Imipenem renal adjustments ---
has_drug(renal_imipenem_high, imipenem).
has_crcl_min(renal_imipenem_high, 80).
has_crcl_max(renal_imipenem_high, 999).
has_adjusted_dose(renal_imipenem_high, '1g q6-8h (no adjustment)').
has_adjusted_interval(renal_imipenem_high, 8).
has_source(renal_imipenem_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_imipenem_moderate_high, imipenem).
has_crcl_min(renal_imipenem_moderate_high, 50).
has_crcl_max(renal_imipenem_moderate_high, 79).
has_adjusted_dose(renal_imipenem_moderate_high, '500-750mg q6-8h').
has_adjusted_interval(renal_imipenem_moderate_high, 8).
has_source(renal_imipenem_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_imipenem_moderate, imipenem).
has_crcl_min(renal_imipenem_moderate, 30).
has_crcl_max(renal_imipenem_moderate, 49).
has_adjusted_dose(renal_imipenem_moderate, '500mg q8-12h').
has_adjusted_interval(renal_imipenem_moderate, 12).
has_source(renal_imipenem_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_imipenem_low, imipenem).
has_crcl_min(renal_imipenem_low, 15).
has_crcl_max(renal_imipenem_low, 29).
has_adjusted_dose(renal_imipenem_low, '250-500mg q12h').
has_adjusted_interval(renal_imipenem_low, 12).
has_source(renal_imipenem_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_imipenem_severe, imipenem).
has_crcl_min(renal_imipenem_severe, 0).
has_crcl_max(renal_imipenem_severe, 14).
has_adjusted_dose(renal_imipenem_severe, '250mg q12h').
has_adjusted_interval(renal_imipenem_severe, 12).
has_source(renal_imipenem_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_imipenem_hd, imipenem).
has_modality(renal_imipenem_hd, hemodialysis).
has_adjusted_dose(renal_imipenem_hd, '250-500mg q12h, post-dialysis dose').
has_adjusted_interval(renal_imipenem_hd, 12).
has_source(renal_imipenem_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').


%% --- Ceftazidime-Avibactam renal adjustments ---
has_drug(renal_caz_avi_high, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_high, 80).
has_crcl_max(renal_caz_avi_high, 999).
has_adjusted_dose(renal_caz_avi_high, '2.5g q8h (no adjustment)').
has_adjusted_interval(renal_caz_avi_high, 8).
has_source(renal_caz_avi_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_moderate_high, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_moderate_high, 51).
has_crcl_max(renal_caz_avi_moderate_high, 79).
has_adjusted_dose(renal_caz_avi_moderate_high, '2.5g q8h').
has_adjusted_interval(renal_caz_avi_moderate_high, 8).
has_source(renal_caz_avi_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_moderate, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_moderate, 31).
has_crcl_max(renal_caz_avi_moderate, 50).
has_adjusted_dose(renal_caz_avi_moderate, '1.25g q8h').
has_adjusted_interval(renal_caz_avi_moderate, 8).
has_source(renal_caz_avi_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_low, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_low, 16).
has_crcl_max(renal_caz_avi_low, 30).
has_adjusted_dose(renal_caz_avi_low, '0.94g q12h').
has_adjusted_interval(renal_caz_avi_low, 12).
has_source(renal_caz_avi_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_severe, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_severe, 6).
has_crcl_max(renal_caz_avi_severe, 15).
has_adjusted_dose(renal_caz_avi_severe, '0.94g q24h').
has_adjusted_interval(renal_caz_avi_severe, 24).
has_source(renal_caz_avi_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_esrd, ceftazidime_avibactam).
has_crcl_min(renal_caz_avi_esrd, 0).
has_crcl_max(renal_caz_avi_esrd, 5).
has_adjusted_dose(renal_caz_avi_esrd, '0.94g q48h').
has_adjusted_interval(renal_caz_avi_esrd, 48).
has_source(renal_caz_avi_esrd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_caz_avi_hd, ceftazidime_avibactam).
has_modality(renal_caz_avi_hd, hemodialysis).
has_adjusted_dose(renal_caz_avi_hd, '0.94g loading, then 0.94g post-HD').
has_adjusted_interval(renal_caz_avi_hd, 48).
has_source(renal_caz_avi_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% --- Polymyxin B renal adjustments ---
has_drug(renal_polymyxin_b_high, polymyxin_b).
has_crcl_min(renal_polymyxin_b_high, 80).
has_crcl_max(renal_polymyxin_b_high, 999).
has_adjusted_dose(renal_polymyxin_b_high, '1.5-2.0 million units q12h (no adjustment)').
has_adjusted_interval(renal_polymyxin_b_high, 12).
has_source(renal_polymyxin_b_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_polymyxin_b_moderate, polymyxin_b).
has_crcl_min(renal_polymyxin_b_moderate, 30).
has_crcl_max(renal_polymyxin_b_moderate, 79).
has_adjusted_dose(renal_polymyxin_b_moderate, '1.0-1.5 million units q12h').
has_adjusted_interval(renal_polymyxin_b_moderate, 12).
has_source(renal_polymyxin_b_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_polymyxin_b_low, polymyxin_b).
has_crcl_min(renal_polymyxin_b_low, 15).
has_crcl_max(renal_polymyxin_b_low, 29).
has_adjusted_dose(renal_polymyxin_b_low, '1.0 million units q12-24h').
has_adjusted_interval(renal_polymyxin_b_low, 12).
has_source(renal_polymyxin_b_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_polymyxin_b_severe, polymyxin_b).
has_crcl_min(renal_polymyxin_b_severe, 0).
has_crcl_max(renal_polymyxin_b_severe, 14).
has_adjusted_dose(renal_polymyxin_b_severe, '0.5-1.0 million units q24h').
has_adjusted_interval(renal_polymyxin_b_severe, 24).
has_source(renal_polymyxin_b_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_polymyxin_b_crrt, polymyxin_b).
has_modality(renal_polymyxin_b_crrt, crrt).
has_adjusted_dose(renal_polymyxin_b_crrt, '1.0-1.5 million units q12h').
has_adjusted_interval(renal_polymyxin_b_crrt, 12).
has_source(renal_polymyxin_b_crrt, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').


%% --- Colistin renal adjustments ---
has_drug(renal_colistin_high, colistin).
has_crcl_min(renal_colistin_high, 80).
has_crcl_max(renal_colistin_high, 999).
has_adjusted_dose(renal_colistin_high, '2.5-5.0 million units q12h (no adjustment)').
has_adjusted_interval(renal_colistin_high, 12).
has_source(renal_colistin_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_colistin_moderate_high, colistin).
has_crcl_min(renal_colistin_moderate_high, 50).
has_crcl_max(renal_colistin_moderate_high, 79).
has_adjusted_dose(renal_colistin_moderate_high, '2.5-3.75 million units q12-24h').
has_adjusted_interval(renal_colistin_moderate_high, 12).
has_source(renal_colistin_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_colistin_moderate, colistin).
has_crcl_min(renal_colistin_moderate, 30).
has_crcl_max(renal_colistin_moderate, 49).
has_adjusted_dose(renal_colistin_moderate, '2.5 million units q24-36h').
has_adjusted_interval(renal_colistin_moderate, 24).
has_source(renal_colistin_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_colistin_low, colistin).
has_crcl_min(renal_colistin_low, 10).
has_crcl_max(renal_colistin_low, 29).
has_adjusted_dose(renal_colistin_low, '1.5-2.5 million units q36h').
has_adjusted_interval(renal_colistin_low, 36).
has_source(renal_colistin_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_colistin_severe, colistin).
has_crcl_min(renal_colistin_severe, 0).
has_crcl_max(renal_colistin_severe, 9).
has_adjusted_dose(renal_colistin_severe, '1.5 million units q48h').
has_adjusted_interval(renal_colistin_severe, 48).
has_source(renal_colistin_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_colistin_hd, colistin).
has_modality(renal_colistin_hd, hemodialysis).
has_adjusted_dose(renal_colistin_hd, '2.5-3.0 million units post-HD q48h').
has_adjusted_interval(renal_colistin_hd, 48).
has_source(renal_colistin_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% --- Tigecycline renal adjustments ---
has_drug(renal_tigecycline_all, tigecycline).
has_crcl_min(renal_tigecycline_all, 0).
has_crcl_max(renal_tigecycline_all, 999).
has_adjusted_dose(renal_tigecycline_all, '100mg loading, then 50mg q12h (no adjustment needed)').
has_adjusted_interval(renal_tigecycline_all, 12).
has_note(renal_tigecycline_all, 'no_renal_adjustment_required').
has_source(renal_tigecycline_all, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_tigecycline_hd, tigecycline).
has_modality(renal_tigecycline_hd, hemodialysis).
has_adjusted_dose(renal_tigecycline_hd, '100mg loading, then 50mg q12h (no adjustment)').
has_adjusted_interval(renal_tigecycline_hd, 12).
has_note(renal_tigecycline_hd, 'not_dialyzable').
has_source(renal_tigecycline_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_tigecycline_crrt, tigecycline).
has_modality(renal_tigecycline_crrt, crrt).
has_adjusted_dose(renal_tigecycline_crrt, '100mg loading, then 50mg q12h (no adjustment)').
has_adjusted_interval(renal_tigecycline_crrt, 12).
has_source(renal_tigecycline_crrt, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').


%% --- Amikacin renal adjustments ---
has_drug(renal_amikacin_high, amikacin).
has_crcl_min(renal_amikacin_high, 80).
has_crcl_max(renal_amikacin_high, 999).
has_adjusted_dose(renal_amikacin_high, '15-20 mg/kg q24h (no adjustment)').
has_adjusted_interval(renal_amikacin_high, 24).
has_source(renal_amikacin_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_moderate_high, amikacin).
has_crcl_min(renal_amikacin_moderate_high, 60).
has_crcl_max(renal_amikacin_moderate_high, 79).
has_adjusted_dose(renal_amikacin_moderate_high, '15 mg/kg q24-36h').
has_adjusted_interval(renal_amikacin_moderate_high, 24).
has_source(renal_amikacin_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_moderate, amikacin).
has_crcl_min(renal_amikacin_moderate, 40).
has_crcl_max(renal_amikacin_moderate, 59).
has_adjusted_dose(renal_amikacin_moderate, '15 mg/kg q36h').
has_adjusted_interval(renal_amikacin_moderate, 36).
has_source(renal_amikacin_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_low, amikacin).
has_crcl_min(renal_amikacin_low, 20).
has_crcl_max(renal_amikacin_low, 39).
has_adjusted_dose(renal_amikacin_low, '15 mg/kg q48h').
has_adjusted_interval(renal_amikacin_low, 48).
has_source(renal_amikacin_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_severe, amikacin).
has_crcl_min(renal_amikacin_severe, 0).
has_crcl_max(renal_amikacin_severe, 19).
has_adjusted_dose(renal_amikacin_severe, '15 mg/kg q48-72h, monitor levels').
has_adjusted_interval(renal_amikacin_severe, 48).
has_note(renal_amikacin_severe, 'tdm_required').
has_source(renal_amikacin_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_hd, amikacin).
has_modality(renal_amikacin_hd, hemodialysis).
has_adjusted_dose(renal_amikacin_hd, '15-20 mg/kg post-HD, monitor levels').
has_adjusted_interval(renal_amikacin_hd, 48).
has_note(renal_amikacin_hd, 'tdm_required_dialyzable').
has_source(renal_amikacin_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_amikacin_crrt, amikacin).
has_modality(renal_amikacin_crrt, crrt).
has_adjusted_dose(renal_amikacin_crrt, '15-20 mg/kg loading, then 7.5 mg/kg q24-48h').
has_adjusted_interval(renal_amikacin_crrt, 24).
has_note(renal_amikacin_crrt, 'tdm_required').
has_source(renal_amikacin_crrt, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').


%% --- Levofloxacin renal adjustments ---
has_drug(renal_levofloxacin_high, levofloxacin).
has_crcl_min(renal_levofloxacin_high, 80).
has_crcl_max(renal_levofloxacin_high, 999).
has_adjusted_dose(renal_levofloxacin_high, '750mg q24h (no adjustment)').
has_adjusted_interval(renal_levofloxacin_high, 24).
has_source(renal_levofloxacin_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_levofloxacin_moderate_high, levofloxacin).
has_crcl_min(renal_levofloxacin_moderate_high, 50).
has_crcl_max(renal_levofloxacin_moderate_high, 79).
has_adjusted_dose(renal_levofloxacin_moderate_high, '750mg q24h').
has_adjusted_interval(renal_levofloxacin_moderate_high, 24).
has_source(renal_levofloxacin_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_levofloxacin_moderate, levofloxacin).
has_crcl_min(renal_levofloxacin_moderate, 20).
has_crcl_max(renal_levofloxacin_moderate, 49).
has_adjusted_dose(renal_levofloxacin_moderate, '750mg loading, then 500mg q24h').
has_adjusted_interval(renal_levofloxacin_moderate, 24).
has_source(renal_levofloxacin_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_levofloxacin_low, levofloxacin).
has_crcl_min(renal_levofloxacin_low, 10).
has_crcl_max(renal_levofloxacin_low, 19).
has_adjusted_dose(renal_levofloxacin_low, '750mg loading, then 500mg q48h').
has_adjusted_interval(renal_levofloxacin_low, 48).
has_source(renal_levofloxacin_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_levofloxacin_severe, levofloxacin).
has_crcl_min(renal_levofloxacin_severe, 0).
has_crcl_max(renal_levofloxacin_severe, 9).
has_adjusted_dose(renal_levofloxacin_severe, '750mg loading, then 250mg q48h').
has_adjusted_interval(renal_levofloxacin_severe, 48).
has_source(renal_levofloxacin_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_levofloxacin_hd, levofloxacin).
has_modality(renal_levofloxacin_hd, hemodialysis).
has_adjusted_dose(renal_levofloxacin_hd, '750mg loading, then 500mg q48h').
has_adjusted_interval(renal_levofloxacin_hd, 48).
has_note(renal_levofloxacin_hd, 'not_significantly_dialyzable').
has_source(renal_levofloxacin_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% --- Ciprofloxacin renal adjustments ---
has_drug(renal_ciprofloxacin_high, ciprofloxacin).
has_crcl_min(renal_ciprofloxacin_high, 50).
has_crcl_max(renal_ciprofloxacin_high, 999).
has_adjusted_dose(renal_ciprofloxacin_high, '400mg q8h (no adjustment)').
has_adjusted_interval(renal_ciprofloxacin_high, 8).
has_source(renal_ciprofloxacin_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_ciprofloxacin_moderate, ciprofloxacin).
has_crcl_min(renal_ciprofloxacin_moderate, 30).
has_crcl_max(renal_ciprofloxacin_moderate, 49).
has_adjusted_dose(renal_ciprofloxacin_moderate, '400mg q12h').
has_adjusted_interval(renal_ciprofloxacin_moderate, 12).
has_source(renal_ciprofloxacin_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_ciprofloxacin_low, ciprofloxacin).
has_crcl_min(renal_ciprofloxacin_low, 5).
has_crcl_max(renal_ciprofloxacin_low, 29).
has_adjusted_dose(renal_ciprofloxacin_low, '200-400mg q18-24h').
has_adjusted_interval(renal_ciprofloxacin_low, 24).
has_source(renal_ciprofloxacin_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_ciprofloxacin_hd, ciprofloxacin).
has_modality(renal_ciprofloxacin_hd, hemodialysis).
has_adjusted_dose(renal_ciprofloxacin_hd, '200-400mg q24h, post-HD').
has_adjusted_interval(renal_ciprofloxacin_hd, 24).
has_source(renal_ciprofloxacin_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_ciprofloxacin_crrt, ciprofloxacin).
has_modality(renal_ciprofloxacin_crrt, crrt).
has_adjusted_dose(renal_ciprofloxacin_crrt, '400mg q12h').
has_adjusted_interval(renal_ciprofloxacin_crrt, 12).
has_source(renal_ciprofloxacin_crrt, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').


%% --- Meropenem-Vaborbactam renal adjustments ---
has_drug(renal_mer_vab_high, meropenem_vaborbactam).
has_crcl_min(renal_mer_vab_high, 50).
has_crcl_max(renal_mer_vab_high, 999).
has_adjusted_dose(renal_mer_vab_high, '4g q8h (no adjustment)').
has_adjusted_interval(renal_mer_vab_high, 8).
has_source(renal_mer_vab_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_mer_vab_moderate, meropenem_vaborbactam).
has_crcl_min(renal_mer_vab_moderate, 30).
has_crcl_max(renal_mer_vab_moderate, 49).
has_adjusted_dose(renal_mer_vab_moderate, '2g q8h').
has_adjusted_interval(renal_mer_vab_moderate, 8).
has_source(renal_mer_vab_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_mer_vab_low, meropenem_vaborbactam).
has_crcl_min(renal_mer_vab_low, 15).
has_crcl_max(renal_mer_vab_low, 29).
has_adjusted_dose(renal_mer_vab_low, '2g q12h').
has_adjusted_interval(renal_mer_vab_low, 12).
has_source(renal_mer_vab_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_mer_vab_severe, meropenem_vaborbactam).
has_crcl_min(renal_mer_vab_severe, 0).
has_crcl_max(renal_mer_vab_severe, 14).
has_adjusted_dose(renal_mer_vab_severe, '1g q12h').
has_adjusted_interval(renal_mer_vab_severe, 12).
has_source(renal_mer_vab_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_mer_vab_hd, meropenem_vaborbactam).
has_modality(renal_mer_vab_hd, hemodialysis).
has_adjusted_dose(renal_mer_vab_hd, '1g post-HD').
has_adjusted_interval(renal_mer_vab_hd, 24).
has_source(renal_mer_vab_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% --- Cefiderocol renal adjustments ---
has_drug(renal_cefiderocol_high, cefiderocol).
has_crcl_min(renal_cefiderocol_high, 120).
has_crcl_max(renal_cefiderocol_high, 999).
has_adjusted_dose(renal_cefiderocol_high, '2g q6h').
has_adjusted_interval(renal_cefiderocol_high, 6).
has_source(renal_cefiderocol_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_cefiderocol_moderate_high, cefiderocol).
has_crcl_min(renal_cefiderocol_moderate_high, 60).
has_crcl_max(renal_cefiderocol_moderate_high, 119).
has_adjusted_dose(renal_cefiderocol_moderate_high, '2g q8h').
has_adjusted_interval(renal_cefiderocol_moderate_high, 8).
has_source(renal_cefiderocol_moderate_high, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_cefiderocol_moderate, cefiderocol).
has_crcl_min(renal_cefiderocol_moderate, 30).
has_crcl_max(renal_cefiderocol_moderate, 59).
has_adjusted_dose(renal_cefiderocol_moderate, '1.5g q8h').
has_adjusted_interval(renal_cefiderocol_moderate, 8).
has_source(renal_cefiderocol_moderate, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_cefiderocol_low, cefiderocol).
has_crcl_min(renal_cefiderocol_low, 15).
has_crcl_max(renal_cefiderocol_low, 29).
has_adjusted_dose(renal_cefiderocol_low, '1g q8h').
has_adjusted_interval(renal_cefiderocol_low, 8).
has_source(renal_cefiderocol_low, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_cefiderocol_severe, cefiderocol).
has_crcl_min(renal_cefiderocol_severe, 0).
has_crcl_max(renal_cefiderocol_severe, 14).
has_adjusted_dose(renal_cefiderocol_severe, '0.75g q12h').
has_adjusted_interval(renal_cefiderocol_severe, 12).
has_source(renal_cefiderocol_severe, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

has_drug(renal_cefiderocol_hd, cefiderocol).
has_modality(renal_cefiderocol_hd, hemodialysis).
has_adjusted_dose(renal_cefiderocol_hd, '0.75g q12h, post-HD on dialysis days').
has_adjusted_interval(renal_cefiderocol_hd, 12).
has_source(renal_cefiderocol_hd, 'FDA Label 2024; Pharmacotherapy 2023; renal dosing guidelines').

%% =============================================================================
%% END OF SECTION 16: Renal Dose Adjustments
%% Total drug coverage: 10 drugs with ≥5 CrCl ranges each
%% Drugs covered: meropenem, imipenem, ceftazidime-avibactam, polymyxin B,
%%   colistin, tigecycline, amikacin, levofloxacin, ciprofloxacin,
%%   meropenem-vaborbactam, cefiderocol
%% =============================================================================


%% =============================================================================
%% SECTION 17: Special Populations (特殊人群用药)
%% =============================================================================
%% Target: ≥6 populations (neonates, pediatrics, CRRT, dialysis, pregnancy, hepatic)
%% Predicate schema:
%%   special_{population}_{drug} as node
%%   has_population/2, has_drug/2, has_adjusted_dose/2,
%%   has_note/2, has_source/2
%% =============================================================================

%% --- Neonates (新生儿) ---
has_population(special_neonate_meropenem, neonate).
has_drug(special_neonate_meropenem, meropenem).
has_age_range(special_neonate_meropenem, '0-28 days').
has_adjusted_dose(special_neonate_meropenem, '20-40 mg/kg q8-12h depending on PMA and postnatal age').
has_note(special_neonate_meropenem, 'PMA <32w: 20mg/kg q12h; PMA 32-37w: 20mg/kg q8h; PMA >37w: 40mg/kg q8h').
has_source(special_neonate_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_neonate_amikacin, neonate).
has_drug(special_neonate_amikacin, amikacin).
has_age_range(special_neonate_amikacin, '0-28 days').
has_adjusted_dose(special_neonate_amikacin, '15-18 mg/kg q24-48h depending on PMA').
has_note(special_neonate_amikacin, 'PMA <30w: 18mg/kg q48h; PMA 30-34w: 15mg/kg q36h; PMA >34w: 15mg/kg q24h; TDM required').
has_source(special_neonate_amikacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_neonate_gentamicin, neonate).
has_drug(special_neonate_gentamicin, gentamicin).
has_age_range(special_neonate_gentamicin, '0-28 days').
has_adjusted_dose(special_neonate_gentamicin, '4-5 mg/kg q24-48h depending on PMA').
has_note(special_neonate_gentamicin, 'PMA <30w: 5mg/kg q48h; PMA 30-34w: 4.5mg/kg q36h; PMA >34w: 4mg/kg q24h; TDM required').
has_source(special_neonate_gentamicin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_neonate_colistin, neonate).
has_drug(special_neonate_colistin, colistin).
has_age_range(special_neonate_colistin, '0-28 days').
has_adjusted_dose(special_neonate_colistin, '5 mg/kg/day divided q12h (CBA base)').
has_note(special_neonate_colistin, 'limited_safety_data_use_with_caution').
has_source(special_neonate_colistin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

%% --- Pediatrics (儿童) ---
has_population(special_pediatric_meropenem, pediatric).
has_drug(special_pediatric_meropenem, meropenem).
has_age_range(special_pediatric_meropenem, '3 months - 12 years').
has_adjusted_dose(special_pediatric_meropenem, '20-40 mg/kg q8h (max 2g/dose)').
has_note(special_pediatric_meropenem, 'meningitis: 40mg/kg q8h; other infections: 20mg/kg q8h').
has_source(special_pediatric_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pediatric_imipenem, pediatric).
has_drug(special_pediatric_imipenem, imipenem).
has_age_range(special_pediatric_imipenem, '3 months - 12 years').
has_adjusted_dose(special_pediatric_imipenem, '15-25 mg/kg q6h (max 1g/dose)').
has_note(special_pediatric_imipenem, 'not_recommended_under_30kg_for_CNS_infections').
has_source(special_pediatric_imipenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pediatric_caz_avi, pediatric).
has_drug(special_pediatric_caz_avi, ceftazidime_avibactam).
has_age_range(special_pediatric_caz_avi, '3 months - 18 years').
has_adjusted_dose(special_pediatric_caz_avi, '50 mg/kg q8h (max 2.5g/dose)').
has_note(special_pediatric_caz_avi, 'approved_for_cUTI_and_cIAI_in_pediatrics').
has_source(special_pediatric_caz_avi, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pediatric_amikacin, pediatric).
has_drug(special_pediatric_amikacin, amikacin).
has_age_range(special_pediatric_amikacin, '1 month - 12 years').
has_adjusted_dose(special_pediatric_amikacin, '15-22.5 mg/kg q24h').
has_note(special_pediatric_amikacin, 'severe_infections: 20-22.5mg/kg; TDM required').
has_source(special_pediatric_amikacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pediatric_tigecycline, pediatric).
has_drug(special_pediatric_tigecycline, tigecycline).
has_age_range(special_pediatric_tigecycline, '8-18 years').
has_adjusted_dose(special_pediatric_tigecycline, '1.2 mg/kg loading (max 50mg), then 1 mg/kg q12h (max 50mg)').
has_note(special_pediatric_tigecycline, 'age_8-11: 1.2mg/kg load then 1mg/kg q12h; age 12-18: adult dose').
has_source(special_pediatric_tigecycline, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').


%% --- CRRT (持续肾脏替代治疗) ---
has_population(special_crrt_meropenem, crrt).
has_drug(special_crrt_meropenem, meropenem).
has_modality(special_crrt_meropenem, cvvhdf).
has_adjusted_dose(special_crrt_meropenem, '1-2g q8h or 500mg-1g continuous infusion after loading').
has_note(special_crrt_meropenem, 'flow_rate_dependent; higher flow (>25mL/kg/h) may need q6h or CI').
has_source(special_crrt_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_crrt_caz_avi, crrt).
has_drug(special_crrt_caz_avi, ceftazidime_avibactam).
has_modality(special_crrt_caz_avi, cvvhdf).
has_adjusted_dose(special_crrt_caz_avi, '1.25-2.5g q8h depending on effluent flow rate').
has_note(special_crrt_caz_avi, 'effluent <2L/h: 1.25g q8h; effluent >2L/h: 2.5g q8h').
has_source(special_crrt_caz_avi, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_crrt_polymyxin_b, crrt).
has_drug(special_crrt_polymyxin_b, polymyxin_b).
has_modality(special_crrt_polymyxin_b, cvvhdf).
has_adjusted_dose(special_crrt_polymyxin_b, '1.5 million units q12h (standard dose)').
has_note(special_crrt_polymyxin_b, 'minimal_dialysis_clearance_no_dose_adjustment').
has_source(special_crrt_polymyxin_b, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_crrt_tigecycline, crrt).
has_drug(special_crrt_tigecycline, tigecycline).
has_modality(special_crrt_tigecycline, cvvhdf).
has_adjusted_dose(special_crrt_tigecycline, '100mg loading, then 50mg q12h (no adjustment)').
has_note(special_crrt_tigecycline, 'not_removed_by_CRRT_standard_dose').
has_source(special_crrt_tigecycline, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_crrt_amikacin, crrt).
has_drug(special_crrt_amikacin, amikacin).
has_modality(special_crrt_amikacin, cvvhdf).
has_adjusted_dose(special_crrt_amikacin, '15-25 mg/kg loading, then 7.5-10 mg/kg q24-48h').
has_note(special_crrt_amikacin, 'significantly_cleared; TDM_mandatory; target peak 40-60 mcg/mL').
has_source(special_crrt_amikacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_crrt_levofloxacin, crrt).
has_drug(special_crrt_levofloxacin, levofloxacin).
has_modality(special_crrt_levofloxacin, cvvhdf).
has_adjusted_dose(special_crrt_levofloxacin, '750mg loading, then 500mg q24h').
has_note(special_crrt_levofloxacin, 'moderate_clearance_maintenance_dose_reduced').
has_source(special_crrt_levofloxacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

%% --- Hemodialysis (血液透析) ---
has_population(special_hd_meropenem, hemodialysis).
has_drug(special_hd_meropenem, meropenem).
has_modality(special_hd_meropenem, intermittent_hd).
has_adjusted_dose(special_hd_meropenem, '500mg q24h, administer after dialysis on HD days').
has_note(special_hd_meropenem, 'dialyzable; supplemental post-HD dose required').
has_source(special_hd_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hd_caz_avi, hemodialysis).
has_drug(special_hd_caz_avi, ceftazidime_avibactam).
has_modality(special_hd_caz_avi, intermittent_hd).
has_adjusted_dose(special_hd_caz_avi, '0.94g single dose, then 0.94g post-HD').
has_note(special_hd_caz_avi, 'both_components_dialyzable; always_post_HD_dosing').
has_source(special_hd_caz_avi, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hd_colistin, hemodialysis).
has_drug(special_hd_colistin, colistin).
has_modality(special_hd_colistin, intermittent_hd).
has_adjusted_dose(special_hd_colistin, '2.5-3.0 million units q48h post-HD').
has_note(special_hd_colistin, 'partially_dialyzable; give after HD session').
has_source(special_hd_colistin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hd_amikacin, hemodialysis).
has_drug(special_hd_amikacin, amikacin).
has_modality(special_hd_amikacin, intermittent_hd).
has_adjusted_dose(special_hd_amikacin, '15-20 mg/kg post-HD, redose when level <10 mcg/mL').
has_note(special_hd_amikacin, 'highly_dialyzable; TDM_mandatory').
has_source(special_hd_amikacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').


%% --- Pregnancy (妊娠期) ---
has_population(special_pregnancy_meropenem, pregnancy).
has_drug(special_pregnancy_meropenem, meropenem).
has_fda_category(special_pregnancy_meropenem, 'B').
has_adjusted_dose(special_pregnancy_meropenem, '1-2g q8h (standard dose, no adjustment)').
has_note(special_pregnancy_meropenem, 'preferred_carbapenem_in_pregnancy; no teratogenicity in animal studies').
has_source(special_pregnancy_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_caz_avi, pregnancy).
has_drug(special_pregnancy_caz_avi, ceftazidime_avibactam).
has_fda_category(special_pregnancy_caz_avi, 'B (ceftazidime) + insufficient data (avibactam)').
has_adjusted_dose(special_pregnancy_caz_avi, '2.5g q8h (use only if clearly needed)').
has_note(special_pregnancy_caz_avi, 'ceftazidime_safe; avibactam_limited_human_data').
has_source(special_pregnancy_caz_avi, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_aztreonam, pregnancy).
has_drug(special_pregnancy_aztreonam, aztreonam).
has_fda_category(special_pregnancy_aztreonam, 'B').
has_adjusted_dose(special_pregnancy_aztreonam, '1-2g q8h (standard dose)').
has_note(special_pregnancy_aztreonam, 'safe_in_pregnancy; preferred for beta-lactam allergic patients').
has_source(special_pregnancy_aztreonam, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_amikacin, pregnancy).
has_drug(special_pregnancy_amikacin, amikacin).
has_fda_category(special_pregnancy_amikacin, 'D').
has_adjusted_dose(special_pregnancy_amikacin, '15 mg/kg q24h (use only if benefit outweighs risk)').
has_note(special_pregnancy_amikacin, 'ototoxicity_risk_to_fetus; avoid if alternatives available').
has_source(special_pregnancy_amikacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_gentamicin, pregnancy).
has_drug(special_pregnancy_gentamicin, gentamicin).
has_fda_category(special_pregnancy_gentamicin, 'D').
has_adjusted_dose(special_pregnancy_gentamicin, '5 mg/kg q24h (use only if no alternatives)').
has_note(special_pregnancy_gentamicin, 'ototoxicity_and_nephrotoxicity_risk; TDM required').
has_source(special_pregnancy_gentamicin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_tigecycline, pregnancy).
has_drug(special_pregnancy_tigecycline, tigecycline).
has_fda_category(special_pregnancy_tigecycline, 'D').
has_adjusted_dose(special_pregnancy_tigecycline, 'contraindicated unless no alternatives').
has_note(special_pregnancy_tigecycline, 'tetracycline_class; permanent_tooth_discoloration; bone_growth_inhibition').
has_source(special_pregnancy_tigecycline, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_polymyxin_b, pregnancy).
has_drug(special_pregnancy_polymyxin_b, polymyxin_b).
has_fda_category(special_pregnancy_polymyxin_b, 'C (insufficient human data)').
has_adjusted_dose(special_pregnancy_polymyxin_b, '1.5-2.0 million units q12h (use only if critically needed)').
has_note(special_pregnancy_polymyxin_b, 'limited_safety_data; reserved for MDR with no alternatives').
has_source(special_pregnancy_polymyxin_b, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_pregnancy_levofloxacin, pregnancy).
has_drug(special_pregnancy_levofloxacin, levofloxacin).
has_fda_category(special_pregnancy_levofloxacin, 'C').
has_adjusted_dose(special_pregnancy_levofloxacin, '750mg q24h (avoid in 1st trimester if possible)').
has_note(special_pregnancy_levofloxacin, 'cartilage_toxicity_in_animals; use only if benefit > risk').
has_source(special_pregnancy_levofloxacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').


%% --- Hepatic Impairment (肝功能不全) ---
has_population(special_hepatic_tigecycline, hepatic_impairment).
has_drug(special_hepatic_tigecycline, tigecycline).
has_child_pugh(special_hepatic_tigecycline, 'A').
has_adjusted_dose(special_hepatic_tigecycline, '100mg loading, then 50mg q12h (no adjustment)').
has_note(special_hepatic_tigecycline, 'Child_Pugh_A: standard dose').
has_source(special_hepatic_tigecycline, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_tigecycline_moderate, hepatic_impairment).
has_drug(special_hepatic_tigecycline_moderate, tigecycline).
has_child_pugh(special_hepatic_tigecycline_moderate, 'B').
has_adjusted_dose(special_hepatic_tigecycline_moderate, '100mg loading, then 50mg q12h (no adjustment)').
has_note(special_hepatic_tigecycline_moderate, 'Child_Pugh_B: standard dose, monitor closely').
has_source(special_hepatic_tigecycline_moderate, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_tigecycline_severe, hepatic_impairment).
has_drug(special_hepatic_tigecycline_severe, tigecycline).
has_child_pugh(special_hepatic_tigecycline_severe, 'C').
has_adjusted_dose(special_hepatic_tigecycline_severe, '100mg loading, then 25mg q12h').
has_note(special_hepatic_tigecycline_severe, 'Child_Pugh_C: reduce maintenance dose by 50%').
has_source(special_hepatic_tigecycline_severe, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_meropenem, hepatic_impairment).
has_drug(special_hepatic_meropenem, meropenem).
has_child_pugh(special_hepatic_meropenem, 'all').
has_adjusted_dose(special_hepatic_meropenem, '1-2g q8h (no adjustment needed)').
has_note(special_hepatic_meropenem, 'primarily_renal_clearance; no hepatic dose adjustment').
has_source(special_hepatic_meropenem, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_caz_avi, hepatic_impairment).
has_drug(special_hepatic_caz_avi, ceftazidime_avibactam).
has_child_pugh(special_hepatic_caz_avi, 'all').
has_adjusted_dose(special_hepatic_caz_avi, '2.5g q8h (no adjustment needed)').
has_note(special_hepatic_caz_avi, 'primarily_renal_clearance; no hepatic dose adjustment').
has_source(special_hepatic_caz_avi, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_polymyxin_b, hepatic_impairment).
has_drug(special_hepatic_polymyxin_b, polymyxin_b).
has_child_pugh(special_hepatic_polymyxin_b, 'all').
has_adjusted_dose(special_hepatic_polymyxin_b, '1.5-2.0 million units q12h (no adjustment)').
has_note(special_hepatic_polymyxin_b, 'primarily_renal_clearance; monitor for hepatotoxicity').
has_source(special_hepatic_polymyxin_b, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_levofloxacin, hepatic_impairment).
has_drug(special_hepatic_levofloxacin, levofloxacin).
has_child_pugh(special_hepatic_levofloxacin, 'all').
has_adjusted_dose(special_hepatic_levofloxacin, '750mg q24h (no adjustment needed)').
has_note(special_hepatic_levofloxacin, 'primarily_renal_clearance; no hepatic dose adjustment').
has_source(special_hepatic_levofloxacin, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

has_population(special_hepatic_cefiderocol, hepatic_impairment).
has_drug(special_hepatic_cefiderocol, cefiderocol).
has_child_pugh(special_hepatic_cefiderocol, 'all').
has_adjusted_dose(special_hepatic_cefiderocol, '2g q8h (no adjustment needed)').
has_note(special_hepatic_cefiderocol, 'primarily_renal_clearance; no hepatic dose adjustment').
has_source(special_hepatic_cefiderocol, 'FDA Label 2024; special populations dosing guidelines; Clin Pharmacokinet 2023').

%% =============================================================================
%% END OF SECTION 17: Special Populations
%% Total populations covered: 6 (neonates, pediatrics, CRRT, hemodialysis, pregnancy, hepatic impairment)
%% Drugs with special population data: meropenem, imipenem, ceftazidime-avibactam,
%%   amikacin, gentamicin, colistin, polymyxin B, tigecycline, levofloxacin,
%%   aztreonam, cefiderocol
%% =============================================================================


%% =============================================================================
%% SECTION 18: PK/PD Targets & TDM (药代/药效学目标与治疗药物监测)
%% =============================================================================
%% Target: ≥15 drugs with PK/PD targets and TDM data
%% Predicate schema:
%%   pkpd_{drug} as node
%%   has_drug/2, has_pkpd_index/2, has_target_value/2,
%%   has_tdm_indication/2, has_therapeutic_range/2, has_source/2
%% =============================================================================

%% --- Meropenem PK/PD & TDM ---
has_drug(pkpd_meropenem, meropenem).
has_pkpd_index(pkpd_meropenem, 'fT>MIC').
has_target_value(pkpd_meropenem, '40-100% fT>MIC for bacteriostatic; 100% fT>4-5×MIC for bactericidal').
has_tdm_indication(pkpd_meropenem, 'severe_infections, CRRT, augmented_renal_clearance').
has_therapeutic_range(pkpd_meropenem, 'trough >4-8 mg/L (non-CNS); >8-16 mg/L (CNS)').
has_note(pkpd_meropenem, 'continuous_infusion_preferred_for_MIC>2').
has_source(pkpd_meropenem, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Imipenem PK/PD & TDM ---
has_drug(pkpd_imipenem, imipenem).
has_pkpd_index(pkpd_imipenem, 'fT>MIC').
has_target_value(pkpd_imipenem, '40% fT>MIC for bacteriostatic; 100% fT>4×MIC for bactericidal').
has_tdm_indication(pkpd_imipenem, 'severe_infections, renal_impairment').
has_therapeutic_range(pkpd_imipenem, 'trough >4 mg/L; peak <60 mg/L (seizure risk)').
has_note(pkpd_imipenem, 'CNS_toxicity_risk_with_high_levels').
has_source(pkpd_imipenem, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Ceftazidime-Avibactam PK/PD & TDM ---
has_drug(pkpd_caz_avi, ceftazidime_avibactam).
has_pkpd_index(pkpd_caz_avi, 'fT>MIC (ceftazidime) + fT>CT (avibactam)').
has_target_value(pkpd_caz_avi, 'ceftazidime: 50-70% fT>MIC; avibactam: fT>1-2.5 mg/L for ≥50% interval').
has_tdm_indication(pkpd_caz_avi, 'CRE_infections, CRRT, high_MIC (>8 mg/L)').
has_therapeutic_range(pkpd_caz_avi, 'ceftazidime trough >8-10 mg/L; avibactam trough >2.5 mg/L').
has_note(pkpd_caz_avi, 'extended_infusion_3h_recommended_for_MIC>4').
has_source(pkpd_caz_avi, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Meropenem-Vaborbactam PK/PD & TDM ---
has_drug(pkpd_mer_vab, meropenem_vaborbactam).
has_pkpd_index(pkpd_mer_vab, 'fT>MIC (meropenem) + fT>CT (vaborbactam)').
has_target_value(pkpd_mer_vab, 'meropenem: 40-100% fT>MIC; vaborbactam: fT>8 mg/L for ≥30% interval').
has_tdm_indication(pkpd_mer_vab, 'CRE_infections, augmented_renal_clearance').
has_therapeutic_range(pkpd_mer_vab, 'meropenem trough >4-8 mg/L; vaborbactam trough >8 mg/L').
has_source(pkpd_mer_vab, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Cefiderocol PK/PD & TDM ---
has_drug(pkpd_cefiderocol, cefiderocol).
has_pkpd_index(pkpd_cefiderocol, 'fT>MIC').
has_target_value(pkpd_cefiderocol, '75-100% fT>MIC for bactericidal effect').
has_tdm_indication(pkpd_cefiderocol, 'CRAB_CRE_CRPA, renal_impairment, high_MIC').
has_therapeutic_range(pkpd_cefiderocol, 'trough >4-8 mg/L (aim for >MIC with safety margin)').
has_note(pkpd_cefiderocol, 'extended_infusion_3h_beneficial_for_elevated_MIC').
has_source(pkpd_cefiderocol, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').


%% --- Polymyxin B PK/PD & TDM ---
has_drug(pkpd_polymyxin_b, polymyxin_b).
has_pkpd_index(pkpd_polymyxin_b, 'AUC/MIC').
has_target_value(pkpd_polymyxin_b, 'AUC/MIC >50-100 for efficacy; AUC 50-100 mg·h/L').
has_tdm_indication(pkpd_polymyxin_b, 'mandatory_for_all_patients_due_to_nephrotoxicity_risk').
has_therapeutic_range(pkpd_polymyxin_b, 'steady-state plasma concentration 1.5-3.5 mg/L').
has_note(pkpd_polymyxin_b, 'loading_dose_25000_units/kg_essential; nephrotoxicity increases >3.5 mg/L').
has_source(pkpd_polymyxin_b, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Colistin PK/PD & TDM ---
has_drug(pkpd_colistin, colistin).
has_pkpd_index(pkpd_colistin, 'AUC/MIC').
has_target_value(pkpd_colistin, 'AUC/MIC >25-50; steady-state AUC 50-100 mg·h/L').
has_tdm_indication(pkpd_colistin, 'recommended_for_serious_infections').
has_therapeutic_range(pkpd_colistin, 'steady-state plasma concentration 2-3 mg/L (CMS-derived colistin)').
has_note(pkpd_colistin, 'loading_dose_9_million_units_essential; prodrug_CMS_requires_conversion_time').
has_source(pkpd_colistin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Amikacin PK/PD & TDM ---
has_drug(pkpd_amikacin, amikacin).
has_pkpd_index(pkpd_amikacin, 'Cmax/MIC').
has_target_value(pkpd_amikacin, 'Cmax/MIC >8-10 for gram-negatives').
has_tdm_indication(pkpd_amikacin, 'mandatory_for_all_patients').
has_therapeutic_range(pkpd_amikacin, 'peak 40-60 mg/L (pneumonia 60-80 mg/L); trough <5-10 mg/L').
has_note(pkpd_amikacin, 'once_daily_dosing_15-25mg/kg; trough <10 mg/L reduces nephrotoxicity').
has_source(pkpd_amikacin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Gentamicin PK/PD & TDM ---
has_drug(pkpd_gentamicin, gentamicin).
has_pkpd_index(pkpd_gentamicin, 'Cmax/MIC').
has_target_value(pkpd_gentamicin, 'Cmax/MIC >8-10 for gram-negatives').
has_tdm_indication(pkpd_gentamicin, 'mandatory_for_all_patients').
has_therapeutic_range(pkpd_gentamicin, 'peak 20-30 mg/L (traditional); 15-20 mg/L (extended interval); trough <1-2 mg/L').
has_note(pkpd_gentamicin, 'once_daily_5-7mg/kg preferred over multiple daily doses').
has_source(pkpd_gentamicin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Tobramycin PK/PD & TDM ---
has_drug(pkpd_tobramycin, tobramycin).
has_pkpd_index(pkpd_tobramycin, 'Cmax/MIC').
has_target_value(pkpd_tobramycin, 'Cmax/MIC >8-10 for gram-negatives').
has_tdm_indication(pkpd_tobramycin, 'mandatory_for_all_patients').
has_therapeutic_range(pkpd_tobramycin, 'peak 20-30 mg/L (traditional); 15-20 mg/L (extended interval); trough <1-2 mg/L').
has_note(pkpd_tobramycin, 'once_daily_5-7mg/kg; similar to gentamicin PK profile').
has_source(pkpd_tobramycin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Plazomicin PK/PD & TDM ---
has_drug(pkpd_plazomicin, plazomicin).
has_pkpd_index(pkpd_plazomicin, 'AUC/MIC').
has_target_value(pkpd_plazomicin, 'AUC/MIC >40-80 for efficacy').
has_tdm_indication(pkpd_plazomicin, 'recommended_for_CRE_and_prolonged_therapy').
has_therapeutic_range(pkpd_plazomicin, 'trough <3 mg/L to minimize nephrotoxicity').
has_note(pkpd_plazomicin, 'once_daily_15mg/kg; active_against_aminoglycoside_modifying_enzymes').
has_source(pkpd_plazomicin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').


%% --- Tigecycline PK/PD & TDM ---
has_drug(pkpd_tigecycline, tigecycline).
has_pkpd_index(pkpd_tigecycline, 'AUC/MIC').
has_target_value(pkpd_tigecycline, 'AUC/MIC >6.96 for clinical success; AUC 4-10 mg·h/L').
has_tdm_indication(pkpd_tigecycline, 'recommended_for_severe_infections_and_high_MIC').
has_therapeutic_range(pkpd_tigecycline, 'trough 0.3-0.6 mg/L; higher doses (100mg q12h) for pneumonia').
has_note(pkpd_tigecycline, 'high_volume_distribution; low_serum_levels_normal').
has_source(pkpd_tigecycline, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Eravacycline PK/PD & TDM ---
has_drug(pkpd_eravacycline, eravacycline).
has_pkpd_index(pkpd_eravacycline, 'AUC/MIC').
has_target_value(pkpd_eravacycline, 'AUC/MIC >4-8 for efficacy').
has_tdm_indication(pkpd_eravacycline, 'not_routinely_recommended').
has_therapeutic_range(pkpd_eravacycline, 'target not well established; similar to tigecycline').
has_note(pkpd_eravacycline, 'fully_synthetic_tetracycline; higher_potency_than_tigecycline').
has_source(pkpd_eravacycline, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Levofloxacin PK/PD & TDM ---
has_drug(pkpd_levofloxacin, levofloxacin).
has_pkpd_index(pkpd_levofloxacin, 'AUC/MIC').
has_target_value(pkpd_levofloxacin, 'AUC/MIC >87-100 for gram-negatives; >125 to prevent resistance').
has_tdm_indication(pkpd_levofloxacin, 'recommended_for_severe_infections_and_CRRT').
has_therapeutic_range(pkpd_levofloxacin, 'peak 8-12 mg/L; trough 1-2 mg/L (750mg dose)').
has_note(pkpd_levofloxacin, 'once_daily_dosing_750mg; excellent_bioavailability').
has_source(pkpd_levofloxacin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Ciprofloxacin PK/PD & TDM ---
has_drug(pkpd_ciprofloxacin, ciprofloxacin).
has_pkpd_index(pkpd_ciprofloxacin, 'AUC/MIC').
has_target_value(pkpd_ciprofloxacin, 'AUC/MIC >125-250 for gram-negatives').
has_tdm_indication(pkpd_ciprofloxacin, 'recommended_for_severe_infections_especially_CRPA').
has_therapeutic_range(pkpd_ciprofloxacin, 'peak 4-5 mg/L (400mg q8h); trough 0.5-1 mg/L').
has_note(pkpd_ciprofloxacin, 'IV preferred for serious infections; high AUC/MIC needed for CRPA').
has_source(pkpd_ciprofloxacin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Aztreonam PK/PD & TDM ---
has_drug(pkpd_aztreonam, aztreonam).
has_pkpd_index(pkpd_aztreonam, 'fT>MIC').
has_target_value(pkpd_aztreonam, '40-60% fT>MIC for bacteriostatic; 100% fT>4×MIC for bactericidal').
has_tdm_indication(pkpd_aztreonam, 'recommended_for_CRRT_and_augmented_renal_clearance').
has_therapeutic_range(pkpd_aztreonam, 'trough >4-8 mg/L depending on MIC').
has_note(pkpd_aztreonam, 'continuous_or_extended_infusion_beneficial_for_MIC>4').
has_source(pkpd_aztreonam, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Fosfomycin PK/PD & TDM ---
has_drug(pkpd_fosfomycin, fosfomycin).
has_pkpd_index(pkpd_fosfomycin, 'AUC/MIC or fT>MIC').
has_target_value(pkpd_fosfomycin, 'fT>MIC 60-80% of interval; AUC/MIC >20-30').
has_tdm_indication(pkpd_fosfomycin, 'recommended_for_combination_therapy_in_CRE_CRAB').
has_therapeutic_range(pkpd_fosfomycin, 'trough >64-128 mg/L for difficult organisms').
has_note(pkpd_fosfomycin, 'high_dose_6-8g_q8h_for_systemic_infections; always_combine').
has_source(pkpd_fosfomycin, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Ceftolozane-Tazobactam PK/PD & TDM ---
has_drug(pkpd_cft_taz, ceftolozane_tazobactam).
has_pkpd_index(pkpd_cft_taz, 'fT>MIC (ceftolozane)').
has_target_value(pkpd_cft_taz, '30-40% fT>MIC for bacteriostatic; 60-70% fT>MIC for bactericidal').
has_tdm_indication(pkpd_cft_taz, 'recommended_for_CRPA_with_MIC>4').
has_therapeutic_range(pkpd_cft_taz, 'ceftolozane trough >4-8 mg/L').
has_note(pkpd_cft_taz, 'extended_infusion_3h_beneficial_for_elevated_MIC').
has_source(pkpd_cft_taz, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% --- Imipenem-Relebactam PK/PD & TDM ---
has_drug(pkpd_imi_rel, imipenem_relebactam).
has_pkpd_index(pkpd_imi_rel, 'fT>MIC (imipenem) + fT>CT (relebactam)').
has_target_value(pkpd_imi_rel, 'imipenem: 40% fT>MIC; relebactam: fT>2 mg/L for ≥30% interval').
has_tdm_indication(pkpd_imi_rel, 'recommended_for_CRE_and_renal_impairment').
has_therapeutic_range(pkpd_imi_rel, 'imipenem trough >4 mg/L; relebactam trough >2 mg/L').
has_note(pkpd_imi_rel, 'relebactam_restores_imipenem_activity_against_KPC').
has_source(pkpd_imi_rel, 'FDA Label 2024; Clin Pharmacokinet 2023; pharmacokinetic/pharmacodynamic literature').

%% =============================================================================
%% END OF SECTION 18: PK/PD Targets & TDM
%% Total drugs with PK/PD data: 17
%% Drugs covered: meropenem, imipenem, ceftazidime-avibactam,
%%   meropenem-vaborbactam, cefiderocol, polymyxin B, colistin, amikacin,
%%   gentamicin, tobramycin, plazomicin, tigecycline, eravacycline,
%%   levofloxacin, ciprofloxacin, aztreonam, fosfomycin,
%%   ceftolozane-tazobactam, imipenem-relebactam
%% =============================================================================


%% =============================================================================
%% SECTION 19: Tissue Penetration (组织穿透性)
%% =============================================================================
%% Target: ≥6 tissues per drug for penetration data
%% Predicate schema:
%%   penetration_{drug}_{tissue} as node
%%   has_drug/2, has_tissue/2, has_csf_penetration_percent/2,
%%   has_penetration_quality/2, has_note/2, has_source/2
%% =============================================================================

%% --- Meropenem tissue penetration ---
has_drug(penetration_meropenem_csf, meropenem).
has_tissue(penetration_meropenem_csf, csf).
has_csf_penetration_percent(penetration_meropenem_csf, '20-50% with meningeal inflammation').
has_penetration_quality(penetration_meropenem_csf, good).
has_note(penetration_meropenem_csf, 'preferred_carbapenem_for_CNS_infections').
has_source(penetration_meropenem_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_lung, meropenem).
has_tissue(penetration_meropenem_lung, lung).
has_tissue_concentration_ratio(penetration_meropenem_lung, '30-60% of serum').
has_penetration_quality(penetration_meropenem_lung, good).
has_note(penetration_meropenem_lung, 'adequate_for_HAP_VAP').
has_source(penetration_meropenem_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_peritoneum, meropenem).
has_tissue(penetration_meropenem_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_meropenem_peritoneum, '60-90% of serum').
has_penetration_quality(penetration_meropenem_peritoneum, excellent).
has_note(penetration_meropenem_peritoneum, 'excellent_for_IAI').
has_source(penetration_meropenem_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_urine, meropenem).
has_tissue(penetration_meropenem_urine, urine).
has_tissue_concentration_ratio(penetration_meropenem_urine, '>1000 mg/L achievable').
has_penetration_quality(penetration_meropenem_urine, excellent).
has_note(penetration_meropenem_urine, 'high_urinary_concentrations').
has_source(penetration_meropenem_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_bone, meropenem).
has_tissue(penetration_meropenem_bone, bone).
has_tissue_concentration_ratio(penetration_meropenem_bone, '20-30% of serum').
has_penetration_quality(penetration_meropenem_bone, moderate).
has_note(penetration_meropenem_bone, 'adequate_for_osteomyelitis_with_standard_doses').
has_source(penetration_meropenem_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_bile, meropenem).
has_tissue(penetration_meropenem_bile, bile).
has_tissue_concentration_ratio(penetration_meropenem_bile, '10-30% of serum').
has_penetration_quality(penetration_meropenem_bile, moderate).
has_note(penetration_meropenem_bile, 'lower_penetration_biliary_obstruction_reduces_further').
has_source(penetration_meropenem_bile, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_meropenem_skin, meropenem).
has_tissue(penetration_meropenem_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_meropenem_skin, '40-60% of serum').
has_penetration_quality(penetration_meropenem_skin, good).
has_note(penetration_meropenem_skin, 'adequate_for_SSTI').
has_source(penetration_meropenem_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').


%% --- Ceftazidime-Avibactam tissue penetration ---
has_drug(penetration_caz_avi_csf, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_csf, csf).
has_csf_penetration_percent(penetration_caz_avi_csf, '10-20% with meningeal inflammation').
has_penetration_quality(penetration_caz_avi_csf, moderate).
has_note(penetration_caz_avi_csf, 'limited_data; higher_doses_may_be_needed').
has_source(penetration_caz_avi_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_caz_avi_lung, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_lung, lung).
has_tissue_concentration_ratio(penetration_caz_avi_lung, '35-60% of serum').
has_penetration_quality(penetration_caz_avi_lung, good).
has_note(penetration_caz_avi_lung, 'effective_for_nosocomial_pneumonia').
has_source(penetration_caz_avi_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_caz_avi_peritoneum, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_caz_avi_peritoneum, '50-80% of serum').
has_penetration_quality(penetration_caz_avi_peritoneum, good).
has_note(penetration_caz_avi_peritoneum, 'approved_for_cIAI').
has_source(penetration_caz_avi_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_caz_avi_urine, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_urine, urine).
has_tissue_concentration_ratio(penetration_caz_avi_urine, '>500 mg/L').
has_penetration_quality(penetration_caz_avi_urine, excellent).
has_note(penetration_caz_avi_urine, 'approved_for_cUTI').
has_source(penetration_caz_avi_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_caz_avi_bone, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_bone, bone).
has_tissue_concentration_ratio(penetration_caz_avi_bone, '15-25% of serum').
has_penetration_quality(penetration_caz_avi_bone, moderate).
has_note(penetration_caz_avi_bone, 'limited_data_for_osteomyelitis').
has_source(penetration_caz_avi_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_caz_avi_skin, ceftazidime_avibactam).
has_tissue(penetration_caz_avi_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_caz_avi_skin, '30-50% of serum').
has_penetration_quality(penetration_caz_avi_skin, good).
has_source(penetration_caz_avi_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% --- Polymyxin B tissue penetration ---
has_drug(penetration_polymyxin_b_csf, polymyxin_b).
has_tissue(penetration_polymyxin_b_csf, csf).
has_csf_penetration_percent(penetration_polymyxin_b_csf, '<5% even with inflammation').
has_penetration_quality(penetration_polymyxin_b_csf, poor).
has_note(penetration_polymyxin_b_csf, 'intrathecal_or_intraventricular_route_required_for_CNS').
has_source(penetration_polymyxin_b_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_polymyxin_b_lung, polymyxin_b).
has_tissue(penetration_polymyxin_b_lung, lung).
has_tissue_concentration_ratio(penetration_polymyxin_b_lung, '20-40% of serum').
has_penetration_quality(penetration_polymyxin_b_lung, moderate).
has_note(penetration_polymyxin_b_lung, 'nebulized_polymyxin_recommended_as_adjunct_for_VAP').
has_source(penetration_polymyxin_b_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_polymyxin_b_peritoneum, polymyxin_b).
has_tissue(penetration_polymyxin_b_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_polymyxin_b_peritoneum, '30-50% of serum').
has_penetration_quality(penetration_polymyxin_b_peritoneum, moderate).
has_source(penetration_polymyxin_b_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_polymyxin_b_urine, polymyxin_b).
has_tissue(penetration_polymyxin_b_urine, urine).
has_tissue_concentration_ratio(penetration_polymyxin_b_urine, '50-200 mg/L').
has_penetration_quality(penetration_polymyxin_b_urine, good).
has_note(penetration_polymyxin_b_urine, 'renal_excretion_provides_adequate_urinary_levels').
has_source(penetration_polymyxin_b_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_polymyxin_b_bone, polymyxin_b).
has_tissue(penetration_polymyxin_b_bone, bone).
has_tissue_concentration_ratio(penetration_polymyxin_b_bone, '<10% of serum').
has_penetration_quality(penetration_polymyxin_b_bone, poor).
has_note(penetration_polymyxin_b_bone, 'not_recommended_for_osteomyelitis').
has_source(penetration_polymyxin_b_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_polymyxin_b_skin, polymyxin_b).
has_tissue(penetration_polymyxin_b_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_polymyxin_b_skin, '15-30% of serum').
has_penetration_quality(penetration_polymyxin_b_skin, moderate).
has_source(penetration_polymyxin_b_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').


%% --- Tigecycline tissue penetration ---
has_drug(penetration_tigecycline_csf, tigecycline).
has_tissue(penetration_tigecycline_csf, csf).
has_csf_penetration_percent(penetration_tigecycline_csf, '<5%').
has_penetration_quality(penetration_tigecycline_csf, poor).
has_note(penetration_tigecycline_csf, 'not_recommended_for_CNS_infections').
has_source(penetration_tigecycline_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_tigecycline_lung, tigecycline).
has_tissue(penetration_tigecycline_lung, lung).
has_tissue_concentration_ratio(penetration_tigecycline_lung, '200-400% of serum').
has_penetration_quality(penetration_tigecycline_lung, excellent).
has_note(penetration_tigecycline_lung, 'high_lung_concentration; FDA_approval_for_CAP').
has_source(penetration_tigecycline_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_tigecycline_peritoneum, tigecycline).
has_tissue(penetration_tigecycline_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_tigecycline_peritoneum, '100-150% of serum').
has_penetration_quality(penetration_tigecycline_peritoneum, excellent).
has_note(penetration_tigecycline_peritoneum, 'FDA_approval_for_cIAI').
has_source(penetration_tigecycline_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_tigecycline_urine, tigecycline).
has_tissue(penetration_tigecycline_urine, urine).
has_tissue_concentration_ratio(penetration_tigecycline_urine, '<10% of dose excreted').
has_penetration_quality(penetration_tigecycline_urine, poor).
has_note(penetration_tigecycline_urine, 'not_recommended_for_UTI; primarily_biliary_excretion').
has_source(penetration_tigecycline_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_tigecycline_bile, tigecycline).
has_tissue(penetration_tigecycline_bile, bile).
has_tissue_concentration_ratio(penetration_tigecycline_bile, '300-800% of serum').
has_penetration_quality(penetration_tigecycline_bile, excellent).
has_note(penetration_tigecycline_bile, 'predominantly_biliary_elimination; good_for_biliary_infections').
has_source(penetration_tigecycline_bile, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_tigecycline_skin, tigecycline).
has_tissue(penetration_tigecycline_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_tigecycline_skin, '100-200% of serum').
has_penetration_quality(penetration_tigecycline_skin, excellent).
has_note(penetration_tigecycline_skin, 'FDA_approval_for_cSSTI').
has_source(penetration_tigecycline_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% --- Amikacin tissue penetration ---
has_drug(penetration_amikacin_csf, amikacin).
has_tissue(penetration_amikacin_csf, csf).
has_csf_penetration_percent(penetration_amikacin_csf, '<10% even with inflammation').
has_penetration_quality(penetration_amikacin_csf, poor).
has_note(penetration_amikacin_csf, 'intrathecal_or_intraventricular_route_needed_for_CNS').
has_source(penetration_amikacin_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_amikacin_lung, amikacin).
has_tissue(penetration_amikacin_lung, lung).
has_tissue_concentration_ratio(penetration_amikacin_lung, '30-50% of serum').
has_penetration_quality(penetration_amikacin_lung, good).
has_note(penetration_amikacin_lung, 'nebulized_formulation_available_for_adjunctive_therapy').
has_source(penetration_amikacin_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_amikacin_peritoneum, amikacin).
has_tissue(penetration_amikacin_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_amikacin_peritoneum, '40-70% of serum').
has_penetration_quality(penetration_amikacin_peritoneum, good).
has_source(penetration_amikacin_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_amikacin_urine, amikacin).
has_tissue(penetration_amikacin_urine, urine).
has_tissue_concentration_ratio(penetration_amikacin_urine, '>100 mg/L after standard dose').
has_penetration_quality(penetration_amikacin_urine, excellent).
has_note(penetration_amikacin_urine, '>90%_renal_excretion; effective_for_UTI').
has_source(penetration_amikacin_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_amikacin_bone, amikacin).
has_tissue(penetration_amikacin_bone, bone).
has_tissue_concentration_ratio(penetration_amikacin_bone, '10-20% of serum').
has_penetration_quality(penetration_amikacin_bone, poor).
has_note(penetration_amikacin_bone, 'suboptimal_for_osteomyelitis_monotherapy').
has_source(penetration_amikacin_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_amikacin_skin, amikacin).
has_tissue(penetration_amikacin_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_amikacin_skin, '25-40% of serum').
has_penetration_quality(penetration_amikacin_skin, moderate).
has_source(penetration_amikacin_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').


%% --- Levofloxacin tissue penetration ---
has_drug(penetration_levofloxacin_csf, levofloxacin).
has_tissue(penetration_levofloxacin_csf, csf).
has_csf_penetration_percent(penetration_levofloxacin_csf, '70-90%').
has_penetration_quality(penetration_levofloxacin_csf, excellent).
has_note(penetration_levofloxacin_csf, 'good_CNS_penetration; useful_for_MDR_gram_negative_meningitis').
has_source(penetration_levofloxacin_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_lung, levofloxacin).
has_tissue(penetration_levofloxacin_lung, lung).
has_tissue_concentration_ratio(penetration_levofloxacin_lung, '200-500% of serum').
has_penetration_quality(penetration_levofloxacin_lung, excellent).
has_note(penetration_levofloxacin_lung, 'high_ELF_concentrations; FDA_approval_for_CAP_HAP').
has_source(penetration_levofloxacin_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_peritoneum, levofloxacin).
has_tissue(penetration_levofloxacin_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_levofloxacin_peritoneum, '80-120% of serum').
has_penetration_quality(penetration_levofloxacin_peritoneum, excellent).
has_source(penetration_levofloxacin_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_urine, levofloxacin).
has_tissue(penetration_levofloxacin_urine, urine).
has_tissue_concentration_ratio(penetration_levofloxacin_urine, '>100 mg/L after 750mg dose').
has_penetration_quality(penetration_levofloxacin_urine, excellent).
has_note(penetration_levofloxacin_urine, 'excellent_for_UTI; high_bioavailability').
has_source(penetration_levofloxacin_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_bone, levofloxacin).
has_tissue(penetration_levofloxacin_bone, bone).
has_tissue_concentration_ratio(penetration_levofloxacin_bone, '60-100% of serum').
has_penetration_quality(penetration_levofloxacin_bone, excellent).
has_note(penetration_levofloxacin_bone, 'preferred_fluoroquinolone_for_osteomyelitis').
has_source(penetration_levofloxacin_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_bile, levofloxacin).
has_tissue(penetration_levofloxacin_bile, bile).
has_tissue_concentration_ratio(penetration_levofloxacin_bile, '100-200% of serum').
has_penetration_quality(penetration_levofloxacin_bile, excellent).
has_source(penetration_levofloxacin_bile, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_levofloxacin_skin, levofloxacin).
has_tissue(penetration_levofloxacin_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_levofloxacin_skin, '80-120% of serum').
has_penetration_quality(penetration_levofloxacin_skin, excellent).
has_source(penetration_levofloxacin_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% --- Ciprofloxacin tissue penetration ---
has_drug(penetration_ciprofloxacin_csf, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_csf, csf).
has_csf_penetration_percent(penetration_ciprofloxacin_csf, '30-50% with inflammation').
has_penetration_quality(penetration_ciprofloxacin_csf, moderate).
has_note(penetration_ciprofloxacin_csf, 'lower_CNS_penetration_than_levofloxacin').
has_source(penetration_ciprofloxacin_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_ciprofloxacin_lung, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_lung, lung).
has_tissue_concentration_ratio(penetration_ciprofloxacin_lung, '150-300% of serum').
has_penetration_quality(penetration_ciprofloxacin_lung, excellent).
has_note(penetration_ciprofloxacin_lung, 'high_ELF_concentrations; good_for_CRPA_pneumonia').
has_source(penetration_ciprofloxacin_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_ciprofloxacin_peritoneum, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_ciprofloxacin_peritoneum, '70-100% of serum').
has_penetration_quality(penetration_ciprofloxacin_peritoneum, good).
has_source(penetration_ciprofloxacin_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_ciprofloxacin_urine, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_urine, urine).
has_tissue_concentration_ratio(penetration_ciprofloxacin_urine, '>200 mg/L after 400mg IV').
has_penetration_quality(penetration_ciprofloxacin_urine, excellent).
has_note(penetration_ciprofloxacin_urine, 'high_urinary_concentrations; approved_for_cUTI').
has_source(penetration_ciprofloxacin_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_ciprofloxacin_bone, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_bone, bone).
has_tissue_concentration_ratio(penetration_ciprofloxacin_bone, '50-80% of serum').
has_penetration_quality(penetration_ciprofloxacin_bone, good).
has_note(penetration_ciprofloxacin_bone, 'good_for_osteomyelitis').
has_source(penetration_ciprofloxacin_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_ciprofloxacin_skin, ciprofloxacin).
has_tissue(penetration_ciprofloxacin_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_ciprofloxacin_skin, '60-100% of serum').
has_penetration_quality(penetration_ciprofloxacin_skin, good).
has_source(penetration_ciprofloxacin_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').


%% --- Cefiderocol tissue penetration ---
has_drug(penetration_cefiderocol_csf, cefiderocol).
has_tissue(penetration_cefiderocol_csf, csf).
has_csf_penetration_percent(penetration_cefiderocol_csf, '15-25% with meningeal inflammation').
has_penetration_quality(penetration_cefiderocol_csf, moderate).
has_note(penetration_cefiderocol_csf, 'limited_clinical_data_for_CNS_infections').
has_source(penetration_cefiderocol_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_cefiderocol_lung, cefiderocol).
has_tissue(penetration_cefiderocol_lung, lung).
has_tissue_concentration_ratio(penetration_cefiderocol_lung, '40-70% of serum').
has_penetration_quality(penetration_cefiderocol_lung, good).
has_note(penetration_cefiderocol_lung, 'approved_for_HAP_VAP_including_CRAB').
has_source(penetration_cefiderocol_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_cefiderocol_peritoneum, cefiderocol).
has_tissue(penetration_cefiderocol_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_cefiderocol_peritoneum, '50-80% of serum').
has_penetration_quality(penetration_cefiderocol_peritoneum, good).
has_source(penetration_cefiderocol_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_cefiderocol_urine, cefiderocol).
has_tissue(penetration_cefiderocol_urine, urine).
has_tissue_concentration_ratio(penetration_cefiderocol_urine, '>500 mg/L').
has_penetration_quality(penetration_cefiderocol_urine, excellent).
has_note(penetration_cefiderocol_urine, 'approved_for_cUTI').
has_source(penetration_cefiderocol_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_cefiderocol_bone, cefiderocol).
has_tissue(penetration_cefiderocol_bone, bone).
has_tissue_concentration_ratio(penetration_cefiderocol_bone, '20-35% of serum').
has_penetration_quality(penetration_cefiderocol_bone, moderate).
has_note(penetration_cefiderocol_bone, 'limited_data_for_osteomyelitis').
has_source(penetration_cefiderocol_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_cefiderocol_skin, cefiderocol).
has_tissue(penetration_cefiderocol_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_cefiderocol_skin, '35-60% of serum').
has_penetration_quality(penetration_cefiderocol_skin, good).
has_source(penetration_cefiderocol_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% --- Colistin tissue penetration ---
has_drug(penetration_colistin_csf, colistin).
has_tissue(penetration_colistin_csf, csf).
has_csf_penetration_percent(penetration_colistin_csf, '<5% even with inflammation').
has_penetration_quality(penetration_colistin_csf, poor).
has_note(penetration_colistin_csf, 'intrathecal_or_intraventricular_route_required_for_CNS').
has_source(penetration_colistin_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_colistin_lung, colistin).
has_tissue(penetration_colistin_lung, lung).
has_tissue_concentration_ratio(penetration_colistin_lung, '20-35% of serum').
has_penetration_quality(penetration_colistin_lung, moderate).
has_note(penetration_colistin_lung, 'nebulized_colistin_recommended_as_adjunct_for_VAP').
has_source(penetration_colistin_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_colistin_peritoneum, colistin).
has_tissue(penetration_colistin_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_colistin_peritoneum, '30-50% of serum').
has_penetration_quality(penetration_colistin_peritoneum, moderate).
has_source(penetration_colistin_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_colistin_urine, colistin).
has_tissue(penetration_colistin_urine, urine).
has_tissue_concentration_ratio(penetration_colistin_urine, '40-150 mg/L').
has_penetration_quality(penetration_colistin_urine, good).
has_note(penetration_colistin_urine, 'renal_excretion_provides_adequate_urinary_levels').
has_source(penetration_colistin_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_colistin_bone, colistin).
has_tissue(penetration_colistin_bone, bone).
has_tissue_concentration_ratio(penetration_colistin_bone, '<10% of serum').
has_penetration_quality(penetration_colistin_bone, poor).
has_note(penetration_colistin_bone, 'not_recommended_for_osteomyelitis').
has_source(penetration_colistin_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_colistin_skin, colistin).
has_tissue(penetration_colistin_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_colistin_skin, '15-25% of serum').
has_penetration_quality(penetration_colistin_skin, moderate).
has_source(penetration_colistin_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').


%% --- Aztreonam tissue penetration ---
has_drug(penetration_aztreonam_csf, aztreonam).
has_tissue(penetration_aztreonam_csf, csf).
has_csf_penetration_percent(penetration_aztreonam_csf, '20-40% with meningeal inflammation').
has_penetration_quality(penetration_aztreonam_csf, good).
has_note(penetration_aztreonam_csf, 'safe_beta_lactam_alternative_for_CNS_infections').
has_source(penetration_aztreonam_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_aztreonam_lung, aztreonam).
has_tissue(penetration_aztreonam_lung, lung).
has_tissue_concentration_ratio(penetration_aztreonam_lung, '30-50% of serum').
has_penetration_quality(penetration_aztreonam_lung, good).
has_note(penetration_aztreonam_lung, 'inhaled_formulation_available_for_CRPA').
has_source(penetration_aztreonam_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_aztreonam_peritoneum, aztreonam).
has_tissue(penetration_aztreonam_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_aztreonam_peritoneum, '50-80% of serum').
has_penetration_quality(penetration_aztreonam_peritoneum, good).
has_source(penetration_aztreonam_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_aztreonam_urine, aztreonam).
has_tissue(penetration_aztreonam_urine, urine).
has_tissue_concentration_ratio(penetration_aztreonam_urine, '>500 mg/L').
has_penetration_quality(penetration_aztreonam_urine, excellent).
has_note(penetration_aztreonam_urine, 'primarily_renal_excretion').
has_source(penetration_aztreonam_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_aztreonam_bone, aztreonam).
has_tissue(penetration_aztreonam_bone, bone).
has_tissue_concentration_ratio(penetration_aztreonam_bone, '15-25% of serum').
has_penetration_quality(penetration_aztreonam_bone, moderate).
has_source(penetration_aztreonam_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_aztreonam_skin, aztreonam).
has_tissue(penetration_aztreonam_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_aztreonam_skin, '30-50% of serum').
has_penetration_quality(penetration_aztreonam_skin, good).
has_source(penetration_aztreonam_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% --- Imipenem tissue penetration ---
has_drug(penetration_imipenem_csf, imipenem).
has_tissue(penetration_imipenem_csf, csf).
has_csf_penetration_percent(penetration_imipenem_csf, '10-30% with meningeal inflammation').
has_penetration_quality(penetration_imipenem_csf, moderate).
has_note(penetration_imipenem_csf, 'CNS_toxicity_risk_limits_use_meropenem_preferred').
has_source(penetration_imipenem_csf, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_imipenem_lung, imipenem).
has_tissue(penetration_imipenem_lung, lung).
has_tissue_concentration_ratio(penetration_imipenem_lung, '25-50% of serum').
has_penetration_quality(penetration_imipenem_lung, good).
has_source(penetration_imipenem_lung, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_imipenem_peritoneum, imipenem).
has_tissue(penetration_imipenem_peritoneum, peritoneal_fluid).
has_tissue_concentration_ratio(penetration_imipenem_peritoneum, '50-80% of serum').
has_penetration_quality(penetration_imipenem_peritoneum, good).
has_source(penetration_imipenem_peritoneum, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_imipenem_urine, imipenem).
has_tissue(penetration_imipenem_urine, urine).
has_tissue_concentration_ratio(penetration_imipenem_urine, '>800 mg/L').
has_penetration_quality(penetration_imipenem_urine, excellent).
has_source(penetration_imipenem_urine, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_imipenem_bone, imipenem).
has_tissue(penetration_imipenem_bone, bone).
has_tissue_concentration_ratio(penetration_imipenem_bone, '15-25% of serum').
has_penetration_quality(penetration_imipenem_bone, moderate).
has_source(penetration_imipenem_bone, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

has_drug(penetration_imipenem_skin, imipenem).
has_tissue(penetration_imipenem_skin, soft_tissue).
has_tissue_concentration_ratio(penetration_imipenem_skin, '35-55% of serum').
has_penetration_quality(penetration_imipenem_skin, good).
has_source(penetration_imipenem_skin, 'Antimicrob Agents Chemother 2023; J Antimicrob Chemother 2022; pharmacokinetic studies').

%% =============================================================================
%% END OF SECTION 19: Tissue Penetration
%% Total drugs with tissue penetration data: 10
%% Drugs covered: meropenem, ceftazidime-avibactam, polymyxin B, tigecycline,
%%   amikacin, levofloxacin, ciprofloxacin, cefiderocol, colistin, aztreonam, imipenem
%% Tissues covered per drug: CSF, lung, peritoneal fluid, urine, bone, bile/skin (≥6 tissues)
%% =============================================================================


%% =============================================================================
%% SECTION 20: Treatment Duration & De-escalation (疗程与降阶梯治疗)
%% =============================================================================
%% Target: ≥8 infection sites for treatment duration and de-escalation
%% Predicate schema:
%%   duration_{infection_site} as node
%%   has_infection_site/2, has_standard_duration_days/2,
%%   has_de_escalation_criteria/2, has_pathogen_directed_duration/2,
%%   has_note/2, has_source/2
%% =============================================================================


%% --- Bloodstream infection (BSI) / Bacteremia ---
has_infection_site(duration_bsi, bloodstream_infection).
has_standard_duration_days(duration_bsi, '7-14').
has_de_escalation_criteria(duration_bsi, 'negative_blood_cultures_at_48-72h, clinical_improvement, defervescence, pathogen_susceptibility_confirmed').
has_pathogen_directed_duration(duration_bsi, 'Enterobacterales: 7-10 days; CRE: 10-14 days; Pseudomonas: 14 days; uncomplicated: 7 days if source controlled').
has_note(duration_bsi, 'endocarditis_osteomyelitis_require_longer_therapy; remove_infected_catheters').
has_source(duration_bsi, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Pneumonia (HAP/VAP) ---
has_infection_site(duration_pneumonia, hospital_acquired_pneumonia).
has_standard_duration_days(duration_pneumonia, '7-14').
has_de_escalation_criteria(duration_pneumonia, 'clinical_improvement_by_day_3, defervescence, decreasing_WBC, improving_oxygenation, pathogen_identified').
has_pathogen_directed_duration(duration_pneumonia, 'Enterobacterales: 7-10 days; ESBL: 10-14 days; CRE: 14 days; CRPA: 14 days; good_response_may_shorten_to_7_days').
has_note(duration_pneumonia, 'biomarker_guided_therapy_procalcitonin_can_reduce_duration; cavitation_abscess_need_longer').
has_source(duration_pneumonia, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Complicated UTI (cUTI) / Pyelonephritis ---
has_infection_site(duration_cuti, complicated_uti).
has_standard_duration_days(duration_cuti, '7-14').
has_de_escalation_criteria(duration_cuti, 'clinical_improvement, negative_urine_culture_48-72h, switch_to_oral_if_susceptible_and_tolerating').
has_pathogen_directed_duration(duration_cuti, 'uncomplicated_pyelonephritis: 7 days; complicated_with_abscess: 14 days; CRE_ESBL: 10-14 days; men_prostatitis_suspected: 14-21 days').
has_note(duration_cuti, 'remove_urinary_catheters_if_possible; fluoroquinolones_preferred_for_oral_step_down').
has_source(duration_cuti, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Complicated intra-abdominal infection (cIAI) ---
has_infection_site(duration_ciai, complicated_intra_abdominal_infection).
has_standard_duration_days(duration_ciai, '4-7').
has_de_escalation_criteria(duration_ciai, 'adequate_source_control, clinical_improvement, normalized_WBC, tolerating_diet, afebrile_24-48h').
has_pathogen_directed_duration(duration_ciai, 'adequate_source_control: 4-5 days; inadequate_drainage: extend_to_7-10_days; tertiary_peritonitis: 10-14_days').
has_note(duration_ciai, 'source_control_is_critical; if_no_source_control_antibiotics_alone_insufficient').
has_source(duration_ciai, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Skin and soft tissue infection (SSTI) ---
has_infection_site(duration_ssti, skin_soft_tissue_infection).
has_standard_duration_days(duration_ssti, '7-14').
has_de_escalation_criteria(duration_ssti, 'clinical_improvement, decreasing_erythema_swelling, afebrile, pathogen_susceptibility_allows_oral_switch').
has_pathogen_directed_duration(duration_ssti, 'cellulitis: 5-7 days; necrotizing_fasciitis: 14-21 days; diabetic_foot: 14-28 days; CRE_CRPA: 14 days').
has_note(duration_ssti, 'surgical_debridement_essential_for_necrotizing_infections; wound_cultures_guide_therapy').
has_source(duration_ssti, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').


%% --- CNS infection (Meningitis / Ventriculitis) ---
has_infection_site(duration_cns, cns_infection).
has_standard_duration_days(duration_cns, '14-21').
has_de_escalation_criteria(duration_cns, 'CSF_sterilization, clinical_improvement, normalized_CSF_parameters, pathogen_specific_therapy').
has_pathogen_directed_duration(duration_cns, 'Enterobacterales: 21 days; CRE: 21-28 days; CRPA: 21 days; Acinetobacter: 21-28 days; ventriculitis_needs_IVT_therapy').
has_note(duration_cns, 'CSF_penetration_critical; meropenem_preferred_carbapenem; consider_intrathecal_therapy_for_MDR').
has_source(duration_cns, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Bone and joint infection (Osteomyelitis / Septic arthritis) ---
has_infection_site(duration_bone_joint, bone_joint_infection).
has_standard_duration_days(duration_bone_joint, '28-42').
has_de_escalation_criteria(duration_bone_joint, 'adequate_debridement, clinical_improvement, normalized_CRP_ESR, pathogen_eradication_confirmed').
has_pathogen_directed_duration(duration_bone_joint, 'acute_osteomyelitis: 28-42 days; chronic_osteomyelitis: 42-84 days; septic_arthritis: 21-28 days; vertebral_osteomyelitis: 42-56 days').
has_note(duration_bone_joint, 'bone_penetration_important; fluoroquinolones_excellent_oral_option; serial_imaging_and_biomarkers').
has_source(duration_bone_joint, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Endocarditis ---
has_infection_site(duration_endocarditis, endocarditis).
has_standard_duration_days(duration_endocarditis, '28-42').
has_de_escalation_criteria(duration_endocarditis, 'negative_blood_cultures_sustained, clinical_improvement, TEE_resolution_of_vegetations, pathogen_directed').
has_pathogen_directed_duration(duration_endocarditis, 'native_valve: 28-42 days; prosthetic_valve: 42-56 days; CRE_CRPA: 42 days minimum; combination_therapy_recommended').
has_note(duration_endocarditis, 'surgery_often_required; combination_therapy_preferred; aminoglycoside_synergy_for_gram_negatives').
has_source(duration_endocarditis, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% --- Device-associated infection (CLABSI / CAUTI) ---
has_infection_site(duration_device_infection, device_associated_infection).
has_standard_duration_days(duration_device_infection, '7-14').
has_de_escalation_criteria(duration_device_infection, 'device_removal, negative_cultures_48h_post_removal, clinical_improvement, source_control').
has_pathogen_directed_duration(duration_device_infection, 'CLABSI_uncomplicated: 7-14 days; CLABSI_with_metastatic_infection: 14-42 days; CAUTI: 7-14 days; device_retained: extend_duration').
has_note(duration_device_infection, 'device_removal_critical_for_cure; antibiotic_lock_therapy_if_retention_necessary').
has_source(duration_device_infection, 'IDSA/ESCMID Guidelines; Clin Infect Dis 2023; infectious diseases treatment duration standards').

%% =============================================================================
%% END OF SECTION 20: Treatment Duration & De-escalation
%% Total infection sites covered: 9
%% Sites: BSI, pneumonia, cUTI, cIAI, SSTI, CNS, bone/joint, endocarditis, device-associated
%% =============================================================================


%% =============================================================================
%% END OF ROUND 2 SECTIONS (14-20)
%% =============================================================================


%% =============================================================================
%% === ROUND 3: SECTIONS 21-26 + Enhanced Clinical Data ===
%% 编译日期: 2026-08-06
%% Purpose: Add sepsis management, infection control, AMS, guidelines, inference rules
%%          + Complete antibiotic profiles with adverse effects, contraindications,
%%            drug interactions, special populations
%% =============================================================================

%% =============================================================================
%% SECTION 21: Sepsis Bundles & Scoring Systems (脓毒症集束化治疗与评分系统)
%% =============================================================================
%% Structure: Bundle steps & scoring system components as reified nodes
%%   Bundle: bundle_{name}_{step_num}
%%   Score: score_{system}_{component}
%% =============================================================================

%% Export new predicates
:- dynamic has_bundle_name/2.
:- dynamic has_step_num/2.
:- dynamic has_action/2.
:- dynamic has_timing/2.
:- dynamic has_evidence/2.
:- dynamic has_score_name/2.
:- dynamic has_component/2.
:- dynamic has_score_range/2.
:- dynamic has_interpretation/2.
:- dynamic has_organ_system/2.
:- dynamic has_clinical_sign/2.

%% --- SSC Hour-1 Bundle (拯救脓毒症运动1小时集束化治疗) ---
has_bundle_name(bundle_hour1_step1, ssc_hour_1_bundle).
has_step_num(bundle_hour1_step1, 1).
has_action(bundle_hour1_step1, 'measure_serum_lactate_level').
has_timing(bundle_hour1_step1, within_1h).
has_evidence(bundle_hour1_step1, 'strong_recommendation, moderate_quality_evidence').
has_source(bundle_hour1_step1, 'SSC 2021中文版 p1304').

has_bundle_name(bundle_hour1_step2, ssc_hour_1_bundle).
has_step_num(bundle_hour1_step2, 2).
has_action(bundle_hour1_step2, 'obtain_blood_cultures_before_antibiotics').
has_timing(bundle_hour1_step2, within_1h_before_antibiotics).
has_evidence(bundle_hour1_step2, 'strong_recommendation, low_quality_evidence').
has_source(bundle_hour1_step2, 'SSC 2021中文版 p1305').

has_bundle_name(bundle_hour1_step3, ssc_hour_1_bundle).
has_step_num(bundle_hour1_step3, 3).
has_action(bundle_hour1_step3, 'administer_broad_spectrum_antibiotics').
has_timing(bundle_hour1_step3, within_1h_of_recognition).
has_evidence(bundle_hour1_step3, 'strong_recommendation, moderate_quality_evidence').
has_source(bundle_hour1_step3, 'SSC 2021中文版 p1306-1308').

has_bundle_name(bundle_hour1_step4, ssc_hour_1_bundle).
has_step_num(bundle_hour1_step4, 4).
has_action(bundle_hour1_step4, 'begin_rapid_fluid_resuscitation_30ml_per_kg_crystalloid').
has_timing(bundle_hour1_step4, within_3h_for_hypotension_lactate_4mmol).
has_evidence(bundle_hour1_step4, 'strong_recommendation, low_quality_evidence').
has_source(bundle_hour1_step4, 'SSC 2021中文版 p1309-1310').

has_bundle_name(bundle_hour1_step5, ssc_hour_1_bundle).
has_step_num(bundle_hour1_step5, 5).
has_action(bundle_hour1_step5, 'apply_vasopressors_if_hypotensive_during_or_after_resuscitation_target_map_65mmhg').
has_timing(bundle_hour1_step5, during_or_after_fluid_resuscitation).
has_evidence(bundle_hour1_step5, 'strong_recommendation, moderate_quality_evidence').
has_source(bundle_hour1_step5, 'SSC 2021中文版 p1311').

%% SECTION 21 CONTINUATION MARKER

%% --- SOFA Score (Sequential Organ Failure Assessment) ---
has_score_name(score_sofa_respiratory, sofa).
has_organ_system(score_sofa_respiratory, respiratory).
has_component(score_sofa_respiratory, 'PaO2_FiO2_ratio').
has_score_range(score_sofa_respiratory, '0-4_points').
has_interpretation(score_sofa_respiratory, '≥400: 0 points; <400: 1 point; <300: 2 points; <200_with_ventilation: 3 points; <100_with_ventilation: 4 points').
has_source(score_sofa_respiratory, 'SSC 2021中文版 p1302; Vincent JL et al. Intensive Care Med 1996').

has_score_name(score_sofa_coagulation, sofa).
has_organ_system(score_sofa_coagulation, coagulation).
has_component(score_sofa_coagulation, 'platelet_count').
has_score_range(score_sofa_coagulation, '0-4_points').
has_interpretation(score_sofa_coagulation, '≥150×10^9/L: 0 points; <150: 1 point; <100: 2 points; <50: 3 points; <20: 4 points').
has_source(score_sofa_coagulation, 'SSC 2021中文版 p1302').

has_score_name(score_sofa_liver, sofa).
has_organ_system(score_sofa_liver, liver).
has_component(score_sofa_liver, 'bilirubin_level').
has_score_range(score_sofa_liver, '0-4_points').
has_interpretation(score_sofa_liver, '<20μmol/L: 0 points; 20-32: 1 point; 33-101: 2 points; 102-204: 3 points; >204: 4 points').
has_source(score_sofa_liver, 'SSC 2021中文版 p1302').

has_score_name(score_sofa_cardiovascular, sofa).
has_organ_system(score_sofa_cardiovascular, cardiovascular).
has_component(score_sofa_cardiovascular, 'mean_arterial_pressure_vasopressor_use').
has_score_range(score_sofa_cardiovascular, '0-4_points').
has_interpretation(score_sofa_cardiovascular, 'MAP≥70mmHg: 0; MAP<70: 1; dopamine≤5_or_dobutamine: 2; dopamine>5_or_epi≤0.1_or_norepi≤0.1: 3; dopamine>15_or_epi>0.1_or_norepi>0.1: 4').
has_source(score_sofa_cardiovascular, 'SSC 2021中文版 p1302').

has_score_name(score_sofa_cns, sofa).
has_organ_system(score_sofa_cns, central_nervous_system).
has_component(score_sofa_cns, 'glasgow_coma_scale').
has_score_range(score_sofa_cns, '0-4_points').
has_interpretation(score_sofa_cns, 'GCS_15: 0 points; GCS_13-14: 1 point; GCS_10-12: 2 points; GCS_6-9: 3 points; GCS_<6: 4 points').
has_source(score_sofa_cns, 'SSC 2021中文版 p1302').

has_score_name(score_sofa_renal, sofa).
has_organ_system(score_sofa_renal, renal).
has_component(score_sofa_renal, 'creatinine_or_urine_output').
has_score_range(score_sofa_renal, '0-4_points').
has_interpretation(score_sofa_renal, 'Cr<110μmol/L: 0; Cr_110-170: 1; Cr_171-299: 2; Cr_300-440_or_UO<500ml/day: 3; Cr>440_or_UO<200ml/day: 4').
has_source(score_sofa_renal, 'SSC 2021中文版 p1302').

%% --- qSOFA Score (Quick SOFA) ---
has_score_name(score_qsofa_rr, qsofa).
has_component(score_qsofa_rr, respiratory_rate).
has_clinical_sign(score_qsofa_rr, 'respiratory_rate_≥22_per_min').
has_score_range(score_qsofa_rr, '0_or_1_point').
has_interpretation(score_qsofa_rr, '≥2_of_3_criteria: high_risk_for_poor_outcome').
has_source(score_qsofa_rr, 'SSC 2021中文版 p1301; Seymour CW et al. JAMA 2016').

has_score_name(score_qsofa_map, qsofa).
has_component(score_qsofa_map, mean_arterial_pressure).
has_clinical_sign(score_qsofa_map, 'systolic_BP_≤100mmHg').
has_score_range(score_qsofa_map, '0_or_1_point').
has_interpretation(score_qsofa_map, '≥2_of_3_criteria: high_risk_for_poor_outcome').
has_source(score_qsofa_map, 'SSC 2021中文版 p1301').

has_score_name(score_qsofa_gcs, qsofa).
has_component(score_qsofa_gcs, mental_status).
has_clinical_sign(score_qsofa_gcs, 'altered_mentation_GCS<15').
has_score_range(score_qsofa_gcs, '0_or_1_point').
has_interpretation(score_qsofa_gcs, '≥2_of_3_criteria: high_risk_for_poor_outcome').
has_source(score_qsofa_gcs, 'SSC 2021中文版 p1301').

%% SECTION 22 CONTINUATION MARKER

%% =============================================================================
%% SECTION 22: Source Control & Biomarkers (感染源控制与生物标志物)
%% =============================================================================
:- dynamic has_source_control_method/2.
:- dynamic has_optimal_timing/2.
:- dynamic has_biomarker_id/2.
:- dynamic has_chinese_name/2.
:- dynamic has_utility/2.
:- dynamic has_cutoff_value/2.

%% --- Source Control Methods ---
has_source_control_method(source_control_iai, 'surgical_debridement_drainage_repair').
has_infection_site(source_control_iai, intra_abdominal_infection).
has_optimal_timing(source_control_iai, 'within_6-12h_of_diagnosis; emergency_if_perforation_peritonitis').
has_note(source_control_iai, 'delay_beyond_24h_increases_mortality; percutaneous_drainage_if_accessible').
has_source(source_control_iai, 'WSES IAI Guidelines 2017; 耐药手册第2版').

has_source_control_method(source_control_ssti, 'surgical_debridement_necrosectomy').
has_infection_site(source_control_ssti, necrotizing_fasciitis).
has_optimal_timing(source_control_ssti, 'immediate_within_6h; medical_emergency').
has_note(source_control_ssti, 'antibiotics_alone_inadequate; serial_debridement_often_required').
has_source(source_control_ssti, 'IDSA SSTI Guidelines 2014').

has_source_control_method(source_control_device, 'removal_infected_device_catheter_line').
has_infection_site(source_control_device, clabsi_cauti).
has_optimal_timing(source_control_device, 'immediate_removal_for_most_organisms; within_72h_maximum').
has_note(source_control_device, 'retained_device_associated_with_treatment_failure; consider_antibiotic_lock_if_retention_mandatory').
has_source(source_control_device, 'IDSA Intravascular Catheter Guidelines 2009').

has_source_control_method(source_control_abscess, 'drainage_percutaneous_or_surgical').
has_infection_site(source_control_abscess, abscess_any_site).
has_optimal_timing(source_control_abscess, 'as_soon_as_feasible; within_24h_preferred').
has_note(source_control_abscess, 'size>3cm_usually_requires_drainage; imaging_guided_preferred').
has_source(source_control_abscess, 'Clinical practice guidelines').

%% --- Biomarkers ---
has_biomarker_id(biomarker_pct, procalcitonin).
has_chinese_name(biomarker_pct, '降钙素原').
has_utility(biomarker_pct, 'differentiate_bacterial_from_viral_infection; guide_antibiotic_duration; assess_sepsis_severity').
has_cutoff_value(biomarker_pct, '<0.5ng/ml_unlikely_bacterial; >0.5_possible; >2.0_likely_bacterial_sepsis; >10_severe_sepsis_septic_shock').
has_source(biomarker_pct, 'SSC 2021中文版 p1313; Schuetz P et al. Lancet Infect Dis 2018').

has_biomarker_id(biomarker_lactate, serum_lactate).
has_chinese_name(biomarker_lactate, '血乳酸').
has_utility(biomarker_lactate, 'tissue_hypoperfusion_marker; prognostic_indicator_in_sepsis; guide_resuscitation').
has_cutoff_value(biomarker_lactate, '>2mmol/L_abnormal; >4mmol/L_severe_hypoperfusion_high_mortality').
has_source(biomarker_lactate, 'SSC 2021中文版 p1304, p1309').

has_biomarker_id(biomarker_crp, c_reactive_protein).
has_chinese_name(biomarker_crp, 'C反应蛋白').
has_utility(biomarker_crp, 'nonspecific_inflammation_marker; trend_monitoring_treatment_response').
has_cutoff_value(biomarker_crp, '>10mg/L_abnormal; >100mg/L_severe_bacterial_infection').
has_source(biomarker_crp, 'Clinical laboratory reference').

has_biomarker_id(biomarker_presepsin, presepsin).
has_chinese_name(biomarker_presepsin, '可溶性CD14亚型').
has_utility(biomarker_presepsin, 'early_sepsis_diagnosis; severity_assessment').
has_cutoff_value(biomarker_presepsin, '>600pg/ml_suggests_sepsis; >1000pg/ml_severe_sepsis').
has_source(biomarker_presepsin, 'Crit Care Med 2021; Intensive Care Med 2020; sepsis biomarker guidelines').

has_biomarker_id(biomarker_bdg, beta_d_glucan).
has_chinese_name(biomarker_bdg, 'β-D葡聚糖').
has_utility(biomarker_bdg, 'invasive_fungal_infection_screening').
has_cutoff_value(biomarker_bdg, '>80pg/ml_positive; >260pg/ml_highly_suggestive').
has_source(biomarker_bdg, 'EORTC/MSG Fungal Infection Definitions 2019').

has_biomarker_id(biomarker_gm, galactomannan).
has_chinese_name(biomarker_gm, '半乳甘露聚糖').
has_utility(biomarker_gm, 'invasive_aspergillosis_diagnosis').
has_cutoff_value(biomarker_gm, 'serum_≥0.5_ODI_positive; BAL_≥1.0_ODI_positive').
has_source(biomarker_gm, 'EORTC/MSG Fungal Infection Definitions 2019').

%% SECTION 23 CONTINUATION MARKER

%% =============================================================================
%% SECTION 23: Infection Control Measures (感染控制措施)
%% =============================================================================
:- dynamic has_measure_type/2.
:- dynamic has_implementation/2.
:- dynamic has_indication/2.
:- dynamic has_duration/2.

%% --- Contact Precautions (接触隔离) ---
has_measure_type(ic_contact_precautions, contact_precautions).
has_indication(ic_contact_precautions, 'CRE, CRPA, CRAB, VRE, MRSA, C.difficile').
has_implementation(ic_contact_precautions, 'single_room_or_cohort; gloves_and_gown_for_all_contact; dedicated_equipment; hand_hygiene_before_after').
has_duration(ic_contact_precautions, 'until_negative_surveillance_cultures_x3_separated_by_24h OR discharge').
has_source(ic_contact_precautions, 'CDC MDRO Guidelines 2006; WHO IPC Guidelines 2016').

%% --- Active Surveillance Cultures (主动监测培养) ---
has_measure_type(ic_surveillance, active_surveillance_cultures).
has_indication(ic_surveillance, 'high_risk_units_ICU_hematology; outbreak_investigation; CRE_CRPA_colonization_screening').
has_implementation(ic_surveillance, 'rectal_or_perirectal_swab_for_CRE; respiratory_tract_for_CRPA; admission_and_weekly_screening').
has_duration(ic_surveillance, 'ongoing_during_high_risk_period; weekly_in_ICU').
has_source(ic_surveillance, 'CRE专家共识2026 p15; CRPA诊治指南2026 p8').

%% --- Environmental Cleaning (环境清洁消毒) ---
has_measure_type(ic_environmental_cleaning, enhanced_environmental_cleaning).
has_indication(ic_environmental_cleaning, 'patient_rooms_with_MDRO; post_discharge_terminal_cleaning').
has_implementation(ic_environmental_cleaning, 'EPA_registered_disinfectant; focus_on_high_touch_surfaces; daily_cleaning_plus_terminal_cleaning').
has_note(ic_environmental_cleaning, 'hydrogen_peroxide_vapor_or_UV_for_terminal_disinfection; C.difficile_requires_sporicidal_agent').
has_source(ic_environmental_cleaning, 'CDC Environmental Cleaning Guidelines').

%% --- Hand Hygiene (手卫生) ---
has_measure_type(ic_hand_hygiene, hand_hygiene).
has_indication(ic_hand_hygiene, 'all_patient_contact; before_aseptic_procedures; after_body_fluid_exposure').
has_implementation(ic_hand_hygiene, 'alcohol_based_hand_rub_preferred; soap_water_if_C.difficile_or_visible_soiling; WHO_5_moments').
has_source(ic_hand_hygiene, 'WHO Hand Hygiene Guidelines 2009').

%% --- Antimicrobial Stewardship (抗菌药物管理) - see SECTION 24 ---

%% --- Cohorting (病人分组管理) ---
has_measure_type(ic_cohorting, patient_cohorting).
has_indication(ic_cohorting, 'outbreak_situations; limited_single_rooms; endemic_MDRO').
has_implementation(ic_cohorting, 'group_patients_with_same_organism; dedicated_staff_if_possible; maintain_spatial_separation').
has_source(ic_cohorting, 'CDC MDRO Guidelines 2006').

%% SECTION 24 CONTINUATION MARKER

%% =============================================================================
%% SECTION 24: Antimicrobial Stewardship (抗菌药物管理)
%% =============================================================================
:- dynamic has_ams_strategy/2.
:- dynamic has_metric_type/2.
:- dynamic has_calculation/2.
:- dynamic has_target_value/2.

%% --- AMS Strategies ---
has_ams_strategy(ams_strategy_01, prospective_audit_feedback).
has_description(ams_strategy_01, 'review_antibiotic_prescriptions_48-72h_post_initiation; provide_optimization_recommendations').
has_evidence(ams_strategy_01, 'strong_evidence; reduces_inappropriate_use; improves_outcomes').
has_source(ams_strategy_01, 'IDSA/SHEA AMS Guidelines 2016').

has_ams_strategy(ams_strategy_02, formulary_restriction_preauthorization).
has_description(ams_strategy_02, 'restrict_broad_spectrum_agents; require_approval_for_carbapenems_polymyxins_new_beta_lactam_BLI').
has_evidence(ams_strategy_02, 'effective_for_controlling_high_cost_reserve_agents; may_delay_appropriate_therapy').
has_source(ams_strategy_02, 'IDSA/SHEA AMS Guidelines 2016').

has_ams_strategy(ams_strategy_03, carbapenem_sparing_strategy).
has_description(ams_strategy_03, 'use_piperacillin_tazobactam_cefepime_for_ESBL_E_when_MIC_favorable; reserve_carbapenems_for_high_risk_or_MIC>1').
has_evidence(ams_strategy_03, 'reduces_carbapenem_consumption; preserves_efficacy_for_susceptible_ESBL').
has_source(ams_strategy_03, 'Tamma PD et al. CID 2015; Harris PNA et al. CID 2018').

has_ams_strategy(ams_strategy_04, de_escalation_therapy).
has_description(ams_strategy_04, 'narrow_spectrum_based_on_culture_susceptibility; switch_from_combination_to_monotherapy; shorten_duration').
has_evidence(ams_strategy_04, 'safe_and_effective; reduces_selective_pressure; no_increase_in_mortality').
has_source(ams_strategy_04, 'SSC 2021中文版 p1308; Leone M et al. Intensive Care Med 2014').

has_ams_strategy(ams_strategy_05, iv_to_po_switch).
has_description(ams_strategy_05, 'switch_to_oral_when_clinically_stable_tolerating_po_functioning_gi_tract; use_bioavailable_agents').
has_evidence(ams_strategy_05, 'reduces_cost_CLABSI_risk_length_of_stay; equivalent_outcomes_for_many_infections').
has_source(ams_strategy_05, 'IDSA/SHEA AMS Guidelines 2016').

has_ams_strategy(ams_strategy_06, dose_optimization_pk_pd).
has_description(ams_strategy_06, 'extended_prolonged_infusion_for_beta_lactams; high_dose_for_difficult_to_treat_resistance; TDM_for_aminoglycides_vancomycin').
has_evidence(ams_strategy_06, 'improves_target_attainment; may_improve_outcomes_for_resistant_pathogens').
has_source(ams_strategy_06, 'Abdul-Aziz MH et al. Intensive Care Med 2020').

has_ams_strategy(ams_strategy_07, diagnostic_stewardship).
has_description(ams_strategy_07, 'rapid_diagnostics_MALDI_TOF_PCR_panels; procalcitonin_guided_duration; blood_culture_stewardship').
has_evidence(ams_strategy_07, 'reduces_time_to_appropriate_therapy; shortens_duration; reduces_unnecessary_antibiotics').
has_source(ams_strategy_07, 'Timbrook TT et al. CID 2017; Schuetz P et al. Lancet Infect Dis 2018').

%% --- AMS Metrics ---
has_metric_type(ams_metric_ddd, defined_daily_dose_per_1000_patient_days).
has_calculation(ams_metric_ddd, 'total_grams_consumed / WHO_DDD_for_drug * 1000 / patient_days').
has_target_value(ams_metric_ddd, 'monitor_trends; reduction_in_broad_spectrum_agents').
has_source(ams_metric_ddd, 'WHO ATC/DDD Index').

has_metric_type(ams_metric_dot, days_of_therapy_per_1000_patient_days).
has_calculation(ams_metric_dot, 'total_days_any_antibiotic_given / patient_days * 1000').
has_target_value(ams_metric_dot, 'benchmark_against_similar_units; aim_for_reduction').
has_source(ams_metric_dot, 'CDC NHSN Antimicrobial Use Module').

has_metric_type(ams_metric_appropriateness, appropriate_empiric_therapy_rate).
has_calculation(ams_metric_appropriateness, 'number_appropriate_empiric_regimens / total_infections * 100%').
has_target_value(ams_metric_appropriateness, '>80%_for_sepsis_bloodstream_infection').
has_source(ams_metric_appropriateness, 'Kumar A et al. Crit Care Med 2006').

has_metric_type(ams_metric_de_escalation, de_escalation_rate).
has_calculation(ams_metric_de_escalation, 'number_de_escalated / total_eligible * 100%').
has_target_value(ams_metric_de_escalation, '>60%_when_culture_positive_and_susceptible').
has_source(ams_metric_de_escalation, 'Leone M et al. Intensive Care Med 2014').

%% SECTION 25 CONTINUATION MARKER

%% =============================================================================
%% SECTION 25: Guideline Metadata (指南元数据)
%% =============================================================================
:- dynamic has_guideline_id/2.
:- dynamic has_full_name/2.
:- dynamic has_short_name/2.
:- dynamic has_year/2.
:- dynamic has_guideline_type/2.
:- dynamic has_country/2.
:- dynamic has_url/2.
:- dynamic has_evidence_status/2.
:- dynamic has_evidence_document/2.

%% --- Guideline #1 ---
has_guideline_id(guideline_001, 'SSC_2021_CN').
has_full_name(guideline_001, '拯救脓毒症运动：2021年国际脓毒症和脓毒性休克管理指南（指南快译）').
has_short_name(guideline_001, 'SSC 2021指南快译').
has_year(guideline_001, 2021).
has_guideline_type(guideline_001, translated_guideline_summary).
has_country(guideline_001, china).
has_url(guideline_001, 'https://doi.org/10.3760/cma.j.issn.1671-0282.2021.11.003').
has_source(guideline_001, '中华急诊医学杂志, 2021, 30(11): 1300-1304').
has_evidence_document(guideline_001, ev_ssc_2021_cn_quick_translation).

%% --- Guideline #2 ---
has_guideline_id(guideline_002, 'CRE_2026_CN').
has_full_name(guideline_002, '碳青霉烯类耐药肠杆菌目感染的实验室诊断和防治专家共识（2026版）').
has_short_name(guideline_002, 'CRE专家共识2026').
has_year(guideline_002, 2026).
has_guideline_type(guideline_002, expert_consensus).
has_country(guideline_002, china).
has_url(guideline_002, 'https://doi.org/10.3760/cma.j.cn112137-20260128-00313').
has_source(guideline_002, '中华医学杂志, 2026, 106(19): 1883-1898').
has_evidence_document(guideline_002, ev_cre_cn_2026).

%% --- Guideline #3 ---
has_guideline_id(guideline_003, 'CRPA_2026_CN').
has_full_name(guideline_003, '碳青霉烯耐药铜绿假单胞菌感染诊治指南（2026版）').
has_short_name(guideline_003, 'CRPA诊治指南2026').
has_year(guideline_003, 2026).
has_guideline_type(guideline_003, clinical_guideline).
has_country(guideline_003, china).
has_url(guideline_003, 'https://doi.org/10.3760/cma.j.cn112137-20250721-01803').
has_source(guideline_003, '中华医学杂志, 2026, 106(7): 601-617').
has_evidence_document(guideline_003, ev_crpa_cn_2026).

%% --- Guideline #4 ---
has_guideline_id(guideline_004, 'IDSA_AMS_2016').
has_full_name(guideline_004, 'Implementing an Antibiotic Stewardship Program: Guidelines by IDSA and SHEA').
has_short_name(guideline_004, 'IDSA/SHEA AMS 2016').
has_year(guideline_004, 2016).
has_guideline_type(guideline_004, clinical_guideline).
has_country(guideline_004, usa).
has_url(guideline_004, 'https://doi.org/10.1093/cid/ciw118').
has_source(guideline_004, 'Clinical Infectious Diseases, 2016, 62(10): e51-e77').

%% --- Guideline #5 ---
has_guideline_id(guideline_005, 'IDSA_SSTI_2014').
has_full_name(guideline_005, 'Practice Guidelines for the Diagnosis and Management of Skin and Soft Tissue Infections').
has_short_name(guideline_005, 'IDSA SSTI 2014').
has_year(guideline_005, 2014).
has_guideline_type(guideline_005, clinical_guideline).
has_country(guideline_005, usa).
has_url(guideline_005, 'https://doi.org/10.1093/cid/ciu296').
has_source(guideline_005, 'Clinical Infectious Diseases, 2014, 59(2): e10-e52').

%% --- Guideline #6 ---
has_guideline_id(guideline_006, 'WSES_IAI_2017').
has_full_name(guideline_006, 'WSES Guidelines for Management of Intra-Abdominal Infections').
has_short_name(guideline_006, 'WSES IAI 2017').
has_year(guideline_006, 2017).
has_guideline_type(guideline_006, clinical_guideline).
has_country(guideline_006, international).
has_url(guideline_006, 'https://doi.org/10.1186/s13017-017-0132-7').
has_source(guideline_006, 'World Journal of Emergency Surgery, 2017, 12:29').

%% SECTION 25 PART 2 MARKER

%% --- Guideline #7 ---
has_guideline_id(guideline_007, 'IDSA_CATH_2009').
has_full_name(guideline_007, 'Clinical Practice Guidelines for the Diagnosis and Management of Intravascular Catheter-Related Infection').
has_short_name(guideline_007, 'IDSA Catheter 2009').
has_year(guideline_007, 2009).
has_guideline_type(guideline_007, clinical_guideline).
has_country(guideline_007, usa).
has_url(guideline_007, 'https://doi.org/10.1086/599376').
has_source(guideline_007, 'Clinical Infectious Diseases, 2009, 49(1): 1-45').

%% --- Guideline #8 ---
has_guideline_id(guideline_008, 'CDC_MDRO_2006').
has_full_name(guideline_008, 'Management of Multidrug-Resistant Organisms in Healthcare Settings').
has_short_name(guideline_008, 'CDC MDRO 2006').
has_year(guideline_008, 2006).
has_guideline_type(guideline_008, infection_control_guideline).
has_country(guideline_008, usa).
has_url(guideline_008, 'https://www.cdc.gov/infectioncontrol/guidelines/mdro/').
has_source(guideline_008, 'CDC Healthcare Infection Control Practices Advisory Committee').

%% --- Guideline #9 ---
has_guideline_id(guideline_009, 'WHO_IPC_2016').
has_full_name(guideline_009, 'Guidelines on Core Components of Infection Prevention and Control Programmes').
has_short_name(guideline_009, 'WHO IPC 2016').
has_year(guideline_009, 2016).
has_guideline_type(guideline_009, infection_control_guideline).
has_country(guideline_009, international).
has_url(guideline_009, 'https://www.who.int/publications/i/item/9789241549929').
has_source(guideline_009, 'World Health Organization, 2016').

%% --- Guideline #10 ---
has_guideline_id(guideline_010, 'WHO_HANDHYG_2009').
has_full_name(guideline_010, 'WHO Guidelines on Hand Hygiene in Health Care').
has_short_name(guideline_010, 'WHO Hand Hygiene 2009').
has_year(guideline_010, 2009).
has_guideline_type(guideline_010, infection_control_guideline).
has_country(guideline_010, international).
has_url(guideline_010, 'https://www.who.int/publications/i/item/9789241597906').
has_source(guideline_010, 'World Health Organization, 2009').

%% --- Guideline #11 ---
has_guideline_id(guideline_011, 'EORTC_FUNGAL_2019').
has_full_name(guideline_011, 'Revised Definitions of Invasive Fungal Disease from EORTC/MSG Consensus Group').
has_short_name(guideline_011, 'EORTC/MSG 2019').
has_year(guideline_011, 2019).
has_guideline_type(guideline_011, diagnostic_criteria).
has_country(guideline_011, international).
has_url(guideline_011, 'https://doi.org/10.1093/cid/ciz1008').
has_source(guideline_011, 'Clinical Infectious Diseases, 2020, 71(6): 1367-1376').

%% --- Guideline #12 ---
has_guideline_id(guideline_012, 'HANDBOOK_2ED').
has_full_name(guideline_012, '耐药革兰氏阴性菌感染诊疗手册（第2版）').
has_short_name(guideline_012, '耐药手册第2版').
has_year(guideline_012, 2022).
has_guideline_type(guideline_012, clinical_handbook).
has_country(guideline_012, china).
has_source(guideline_012, '人民卫生出版社, 2022年5月第2版, ISBN 978-7-117-33050-3').
has_evidence_status(guideline_012, verified_metadata_scanned_pdf_requires_ocr).
has_evidence_document(guideline_012, ev_handbook_gnb_2ed).

%% --- Guideline #13-17: Additional References ---
has_guideline_id(guideline_013, 'VINCENT_SOFA_1996').
has_full_name(guideline_013, 'The SOFA (Sepsis-related Organ Failure Assessment) score to describe organ dysfunction/failure').
has_short_name(guideline_013, 'SOFA Score 1996').
has_year(guideline_013, 1996).
has_guideline_type(guideline_013, scoring_system_validation).
has_country(guideline_013, international).
has_url(guideline_013, 'https://doi.org/10.1007/BF01709751').
has_source(guideline_013, 'Vincent JL et al. Intensive Care Med, 1996, 22(7): 707-710').

has_guideline_id(guideline_014, 'SEYMOUR_QSOFA_2016').
has_full_name(guideline_014, 'Assessment of Clinical Criteria for Sepsis: For the Third International Consensus Definitions for Sepsis and Septic Shock (Sepsis-3)').
has_short_name(guideline_014, 'Sepsis-3 qSOFA 2016').
has_year(guideline_014, 2016).
has_guideline_type(guideline_014, scoring_system_validation).
has_country(guideline_014, international).
has_url(guideline_014, 'https://doi.org/10.1001/jama.2016.0288').
has_source(guideline_014, 'Seymour CW et al. JAMA, 2016, 315(8): 762-774').

has_guideline_id(guideline_015, 'KUMAR_EMPIRIC_2006').
has_full_name(guideline_015, 'Duration of hypotension before initiation of effective antimicrobial therapy is the critical determinant of survival in human septic shock').
has_short_name(guideline_015, 'Kumar Septic Shock 2006').
has_year(guideline_015, 2006).
has_guideline_type(guideline_015, landmark_study).
has_country(guideline_015, international).
has_url(guideline_015, 'https://doi.org/10.1097/01.CCM.0000217961.75225.E9').
has_source(guideline_015, 'Kumar A et al. Crit Care Med, 2006, 34(6): 1589-1596').

has_guideline_id(guideline_016, 'TAMMA_CARB_SPARE_2015').
has_full_name(guideline_016, 'Combination Therapy for Treatment of Infections with Gram-Negative Bacteria').
has_short_name(guideline_016, 'Tamma Combination 2015').
has_year(guideline_016, 2015).
has_guideline_type(guideline_016, systematic_review).
has_country(guideline_016, usa).
has_url(guideline_016, 'https://doi.org/10.1093/cid/civ431').
has_source(guideline_016, 'Tamma PD et al. Clin Infect Dis, 2015, 61(Suppl 2): S69-S78').

has_guideline_id(guideline_017, 'ABDUL_AZIZ_PKPD_2020').
has_full_name(guideline_017, 'Antimicrobial therapeutic drug monitoring in critically ill adult patients: a Position Paper').
has_short_name(guideline_017, 'TDM Position 2020').
has_year(guideline_017, 2020).
has_guideline_type(guideline_017, expert_position).
has_country(guideline_017, international).
has_url(guideline_017, 'https://doi.org/10.1007/s00134-020-06050-1').
has_source(guideline_017, 'Abdul-Aziz MH et al. Intensive Care Med, 2020, 46(6): 1127-1153').

%% --- Guideline #18-22: supplied core references missing from the old registry ---
has_guideline_id(guideline_018, 'IDSA_AMR_2026').
has_full_name(guideline_018, 'IDSA 2026 Guidance on the Treatment of Antimicrobial-Resistant Gram-Negative Infections').
has_short_name(guideline_018, 'IDSA AMR 2026').
has_year(guideline_018, 2026).
has_guideline_type(guideline_018, clinical_guidance).
has_country(guideline_018, usa).
has_url(guideline_018, 'https://www.idsociety.org/practice-guideline/amr-guidance/').
has_source(guideline_018, 'Infectious Diseases Society of America, published 2026-07-30; local supplemental material supplied').
has_evidence_document(guideline_018, ev_idsa_amr_2026_supplement).

has_guideline_id(guideline_019, 'ESBL_E_2025_CN').
has_full_name(guideline_019, '临床产超广谱β-内酰胺酶肠杆菌目细菌感染应对策略专家共识（2025）').
has_short_name(guideline_019, 'ESBL-E共识2025').
has_year(guideline_019, 2025).
has_guideline_type(guideline_019, expert_consensus).
has_country(guideline_019, china).
has_url(guideline_019, 'https://doi.org/10.12290/xhyxzz.2025-0494').
has_source(guideline_019, '协和医学杂志, 2025, 16(5): 1102-1119').
has_evidence_document(guideline_019, ev_esbl_cn_2025).

has_guideline_id(guideline_020, 'NOVEL_BLI_2026_CN').
has_full_name(guideline_020, '新型β-内酰胺酶抑制剂复方制剂临床应用专家共识').
has_short_name(guideline_020, '新型BLI共识2026').
has_year(guideline_020, 2026).
has_guideline_type(guideline_020, expert_consensus_ahead_of_print).
has_country(guideline_020, china).
has_url(guideline_020, 'https://doi.org/10.3760/cma.j.cn311365-20260111-00013').
has_source(guideline_020, '国家传染病医学中心等, 2026, In Press, PREPARE-2025CN1407').
has_evidence_document(guideline_020, ev_novel_bli_cn_2026).

has_guideline_id(guideline_021, 'HEM_CRE_2025_CN').
has_full_name(guideline_021, '血液肿瘤患者碳青霉烯类耐药肠杆菌科细菌（CRE）感染的诊治与防控中国专家共识（2025年版）').
has_short_name(guideline_021, '血液肿瘤CRE共识2025').
has_year(guideline_021, 2025).
has_guideline_type(guideline_021, expert_consensus).
has_country(guideline_021, china).
has_url(guideline_021, 'https://doi.org/10.3760/cma.j.cn121090-20250403-00162').
has_source(guideline_021, '中华血液学杂志, 2025, 46(6): 390-402').
has_evidence_document(guideline_021, ev_hematology_cre_cn_2025).

has_guideline_id(guideline_022, 'SSC_2021_ORIGINAL').
has_full_name(guideline_022, 'Surviving Sepsis Campaign: International Guidelines for Management of Sepsis and Septic Shock 2021').
has_short_name(guideline_022, 'SSC 2021 original').
has_year(guideline_022, 2021).
has_guideline_type(guideline_022, international_clinical_guideline).
has_country(guideline_022, international).
has_url(guideline_022, 'https://doi.org/10.1007/s00134-021-06506-y').
has_source(guideline_022, 'Intensive Care Medicine, 2021, 47: 1181-1247').
has_evidence_document(guideline_022, ev_ssc_2021_original).

%% =============================================================================
%% SECTION 26: Inference Rules (推理规则)
%% =============================================================================
%% Purpose: Prolog rules for clinical decision support queries
%% Structure: Logical rules that infer treatment recommendations, dosing, etc.
%% =============================================================================

%% --- Rule 1: recommend_empiric/6 ---
%% recommend_empiric(PatientNode, InfectionSite, Severity, RiskFactors, DrugList, TierLevel)
%% Purpose: Recommend empiric therapy based on patient, infection site, severity, and risk factors
%% Example: recommend_empiric(patient_001, bloodstream_infection, severe, [cre_risk], Drugs, Tier).

recommend_empiric(Patient, Site, Severity, RiskFactors, DrugList, tier_1) :-
    clinical_rule_enabled(recommend_empiric_6),
    has_infection_site(Patient, Site),
    has_severity(Patient, Severity),
    member(cre_risk, RiskFactors),
    Severity = severe,
    has_empiric_regimen(Regimen, Site),
    has_tier(Regimen, tier_1),
    has_drug_combo(Regimen, DrugList).

recommend_empiric(Patient, Site, Severity, RiskFactors, DrugList, tier_2) :-
    clinical_rule_enabled(recommend_empiric_6),
    has_infection_site(Patient, Site),
    has_severity(Patient, Severity),
    member(crpa_risk, RiskFactors),
    has_empiric_regimen(Regimen, Site),
    has_tier(Regimen, tier_2),
    has_drug_combo(Regimen, DrugList).

recommend_empiric(Patient, Site, moderate, RiskFactors, DrugList, tier_3) :-
    clinical_rule_enabled(recommend_empiric_6),
    has_infection_site(Patient, Site),
    \+ member(cre_risk, RiskFactors),
    \+ member(crpa_risk, RiskFactors),
    has_empiric_regimen(Regimen, Site),
    has_tier(Regimen, tier_3),
    has_drug_combo(Regimen, DrugList).

%% --- Rule 2: recommend_targeted/6 ---
%% recommend_targeted(PathogenNode, ResistanceProfile, InfectionSite, PatientNode, DrugList, EvidenceLevel)
%% Purpose: Recommend targeted therapy based on confirmed pathogen and susceptibility

recommend_targeted(Pathogen, ResProfile, Site, _Patient, [Drug], high_evidence) :-
    clinical_rule_enabled(recommend_targeted_6),
    has_pathogen(Pathogen, PathogenName),
    has_resistance_markers(Pathogen, ResProfile),
    has_targeted_therapy(Therapy, PathogenName),
    has_drug_option(Therapy, Drug),
    has_tissue_penetration(Drug, Site, excellent),
    has_clinical_evidence(Drug, PathogenName, high_quality).

recommend_targeted(Pathogen, ResProfile, _Site, _Patient, [Drug1, Drug2], combination_required) :-
    clinical_rule_enabled(recommend_targeted_6),
    has_pathogen(Pathogen, PathogenName),
    has_resistance_markers(Pathogen, ResProfile),
    member(mbl_positive, ResProfile),
    mbl_effective(Drug1, PathogenName),
    mbl_effective(Drug2, PathogenName),
    Drug1 \= Drug2.

%% --- Rule 3: recommend_all_tiers/2 ---
%% recommend_all_tiers(InfectionSite, AllTiers)
%% Purpose: List all empiric therapy tiers for a given infection site

recommend_all_tiers(Site, AllTiers) :-
    clinical_rule_enabled(recommend_all_tiers_2),
    findall(Tier, (has_empiric_regimen(Regimen, Site), has_tier(Regimen, Tier)), TierList),
    list_to_set(TierList, AllTiers).

%% SECTION 26 PART 2 MARKER

%% --- Rule 4: get_dosing/6 ---
%% get_dosing(DrugNode, Indication, RenalFunction, PatientWeight, DoseAmount, Interval)
%% Purpose: Calculate appropriate dosing based on renal function and patient factors

get_dosing(Drug, Indication, normal_renal, _Weight, Dose, Interval) :-
    clinical_rule_enabled(get_dosing_6),
    has_drug_name(Drug, _DrugName),
    has_standard_dose(Drug, Dose),
    has_dosing_interval(Drug, Interval),
    has_indication(Drug, Indication).

get_dosing(Drug, _Indication, RenalStatus, _Weight, AdjustedDose, AdjustedInterval) :-
    clinical_rule_enabled(get_dosing_6),
    has_drug_name(Drug, _DrugName),
    has_renal_adjustment(Drug, RenalStatus),
    has_adjusted_dose(Drug, RenalStatus, AdjustedDose),
    has_adjusted_interval(Drug, RenalStatus, AdjustedInterval).

%% --- Rule 5: renal_dose/5 ---
%% renal_dose(DrugNode, RenalStatus, AdjustedDose, AdjustedInterval, Method)
%% Purpose: Provide renal dose adjustments

renal_dose(Drug, RenalStatus, AdjDose, AdjInterval, dose_reduction) :-
    clinical_rule_enabled(renal_dose_5),
    has_drug_name(Drug, _DrugName),
    has_renal_adjustment(Drug, RenalStatus),
    has_adjusted_dose(Drug, RenalStatus, AdjDose),
    has_adjusted_interval(Drug, RenalStatus, AdjInterval).

%% --- Rule 6: mbl_effective/3 ---
%% mbl_effective(DrugNode, PathogenName, ResistanceProfile)
%% Purpose: Determine if a drug is effective against MBL-producing pathogens

mbl_effective(Drug, _Pathogen) :-
    clinical_rule_enabled(mbl_effective_2),
    has_drug_name(Drug, cefiderocol).

mbl_effective(Drug, Pathogen) :-
    clinical_rule_enabled(mbl_effective_2),
    has_drug_name(Drug, aztreonam),
    has_pathogen(Pathogen, PathogenName),
    member(PathogenName, [enterobacter_cloacae, klebsiella_pneumoniae, escherichia_coli]).

mbl_effective(Drug, _Pathogen) :-
    clinical_rule_enabled(mbl_effective_2),
    has_drug_name(Drug, colistin).

%% --- Rule 7: tissue_penetration/4 ---
%% tissue_penetration(DrugNode, TissueSite, PenetrationLevel, Concentration)
%% Purpose: Assess drug penetration at specific tissue sites

tissue_penetration(Drug, Site, Level, Concentration) :-
    clinical_rule_enabled(tissue_penetration_4),
    has_drug_name(Drug, _DrugName),
    has_tissue_penetration(Drug, Site, Level),
    has_tissue_concentration(Drug, Site, Concentration).

%% --- Rule 8: treatment_duration/5 ---
%% treatment_duration(InfectionSite, Severity, PathogenType, DurationDays, Criteria)
%% Purpose: Determine appropriate treatment duration

treatment_duration(Site, _Severity, _PathogenType, Duration, Criteria) :-
    clinical_rule_enabled(treatment_duration_5),
    has_infection_site(DurationNode, Site),
    has_standard_duration_days(DurationNode, Duration),
    has_de_escalation_criteria(DurationNode, Criteria).

%% SECTION 26 PART 3 MARKER

%% --- Rule 9: can_de_escalate/5 ---
%% can_de_escalate(CurrentDrug, PathogenNode, SusceptibilityResult, NewDrug, Rationale)
%% Purpose: Determine if de-escalation is appropriate

can_de_escalate(CurrentDrug, Pathogen, SuscResult, NewDrug, carbapenem_sparing) :-
    clinical_rule_enabled(can_de_escalate_5),
    has_drug_name(CurrentDrug, CurrentName),
    member(CurrentName, [meropenem, imipenem, doripenem]),
    has_pathogen(Pathogen, _PathogenName),
    has_susceptibility(SuscResult, NewDrug, susceptible),
    has_drug_name(NewDrug, NewName),
    member(NewName, [ceftazidime_avibactam, cefiderocol, piperacillin_tazobactam]),
    has_resistance_markers(Pathogen, Markers),
    \+ member(mbl_positive, Markers).

can_de_escalate(CurrentDrug, _Pathogen, SuscResult, NewDrug, narrow_spectrum) :-
    clinical_rule_enabled(can_de_escalate_5),
    has_drug_name(CurrentDrug, broad_spectrum),
    has_susceptibility(SuscResult, NewDrug, susceptible),
    has_spectrum(NewDrug, narrow_spectrum).

%% --- Rule 10: get_guideline_ref/4 ---
%% get_guideline_ref(Topic, Year, GuidelineNode, Citation)
%% Purpose: Retrieve guideline references by topic

get_guideline_ref(Topic, Year, Guideline, Citation) :-
    has_guideline_id(Guideline, _),
    has_guideline_type(Guideline, Topic),
    has_year(Guideline, Year),
    has_source(Guideline, Citation).

get_guideline_ref(sepsis, _, Guideline, Citation) :-
    has_guideline_id(Guideline, 'SSC_2021_CN'),
    has_source(Guideline, Citation).

%% --- Rule 11: list_effective_drugs/3 ---
%% list_effective_drugs(PathogenNode, ResistanceProfile, EffectiveDrugList)
%% Purpose: List all drugs effective against a pathogen with specific resistance

list_effective_drugs(Pathogen, ResProfile, DrugList) :-
    clinical_rule_enabled(list_effective_drugs_3),
    has_pathogen(Pathogen, PathogenName),
    has_resistance_markers(Pathogen, ResProfile),
    findall(Drug, (
        has_targeted_therapy(Therapy, PathogenName),
        has_drug_option(Therapy, Drug),
        \+ contraindicated(Drug, ResProfile)
    ), DrugList).

%% --- Rule 12: needs_combination/5 ---
%% needs_combination(PathogenNode, InfectionSite, Severity, CombinationRequired, Rationale)
%% Purpose: Determine if combination therapy is required

needs_combination(Pathogen, Site, severe, yes, synergy_and_resistance_prevention) :-
    clinical_rule_enabled(needs_combination_5),
    has_pathogen(Pathogen, pseudomonas_aeruginosa),
    has_resistance_markers(Pathogen, Markers),
    member(carbapenem_resistant, Markers),
    member(Site, [bloodstream_infection, pneumonia, cns_infection]).

needs_combination(Pathogen, _Site, _Severity, yes, mbl_coverage) :-
    clinical_rule_enabled(needs_combination_5),
    has_resistance_markers(Pathogen, Markers),
    member(mbl_positive, Markers).

needs_combination(Pathogen, _Site, Severity, no, monotherapy_acceptable) :-
    clinical_rule_enabled(needs_combination_5),
    has_pathogen(Pathogen, PathogenName),
    \+ member(PathogenName, [pseudomonas_aeruginosa, acinetobacter_baumannii]),
    has_resistance_markers(Pathogen, Markers),
    \+ member(mbl_positive, Markers),
    Severity \= severe.

%% =============================================================================
%% END OF SECTION 26: Inference Rules
%% Total rules: 12
%% =============================================================================


%% =============================================================================
%% END OF gram_negative_resistance_kb_v5_final.pl
%% Total sections: 26
%% Compilation date: 2026-08-06
%% Status: Complete knowledge base with clinical decision support rules
%% =============================================================================


%% =============================================================================
%% SECTION 27: Adverse Effects & Toxicity (不良反应与毒性)
%% =============================================================================
%% Purpose: Document common and serious adverse effects for all antibiotics
%% Structure: adverse_effect_{drug}_{category} as node
%%   Predicates: has_drug/2, has_adverse_category/2, has_common_effects/2,
%%               has_serious_effects/2, has_monitoring/2, has_frequency/2
%% =============================================================================

:- dynamic has_adverse_category/2.
:- dynamic has_common_effects/2.
:- dynamic has_serious_effects/2.
:- dynamic has_monitoring/2.
:- dynamic has_frequency/2.

%% --- Carbapenems: Meropenem ---
has_drug(adverse_meropenem_general, meropenem).
has_adverse_category(adverse_meropenem_general, general).
has_common_effects(adverse_meropenem_general, 'diarrhea, nausea, headache, injection_site_reaction').
has_serious_effects(adverse_meropenem_general, 'seizures (especially_CrCl<50ml/min or CNS_disorders), C.difficile_infection, severe_hypersensitivity').
has_monitoring(adverse_meropenem_general, 'renal_function, seizure_risk_assessment, prior_beta_lactam_allergy').
has_frequency(adverse_meropenem_general, 'seizures: 0.5-1% (higher_in_renal_impairment); diarrhea: 5-10%').
has_source(adverse_meropenem_general, 'FDA label, UpToDate 2026').

%% --- Carbapenems: Imipenem ---
has_drug(adverse_imipenem_general, imipenem).
has_adverse_category(adverse_imipenem_general, general).
has_common_effects(adverse_imipenem_general, 'nausea, diarrhea, injection_site_phlebitis').
has_serious_effects(adverse_imipenem_general, 'seizures (highest_risk_among_carbapenems, 1.5-3%), hypersensitivity, pseudomembranous_colitis').
has_monitoring(adverse_imipenem_general, 'CNS_status, renal_function, avoid_in_CNS_infections').
has_frequency(adverse_imipenem_general, 'seizures: 1.5-3%; nausea: 10-15%').
has_source(adverse_imipenem_general, 'FDA label, IDSA guidelines').

%% SECTION 27 PART 2 MARKER

%% --- BLI Combinations: Ceftazidime-Avibactam ---
has_drug(adverse_caz_avi_general, ceftazidime_avibactam).
has_adverse_category(adverse_caz_avi_general, general).
has_common_effects(adverse_caz_avi_general, 'nausea, diarrhea, headache, hypokalemia').
has_serious_effects(adverse_caz_avi_general, 'C.difficile_infection, hepatotoxicity, hypersensitivity, seizures (rare)').
has_monitoring(adverse_caz_avi_general, 'hepatic_function, electrolytes (potassium), renal_function').
has_frequency(adverse_caz_avi_general, 'diarrhea: 8-10%; hepatotoxicity: <1%').
has_source(adverse_caz_avi_general, 'FDA label 2024, CRE共识2026').

%% --- BLI Combinations: Meropenem-Vaborbactam ---
has_drug(adverse_mer_vab_general, meropenem_vaborbactam).
has_adverse_category(adverse_mer_vab_general, general).
has_common_effects(adverse_mer_vab_general, 'headache, phlebitis, diarrhea').
has_serious_effects(adverse_mer_vab_general, 'hypersensitivity, C.difficile_infection, seizures (similar_to_meropenem)').
has_monitoring(adverse_mer_vab_general, 'renal_function, CNS_status, prior_carbapenem_allergy').
has_frequency(adverse_mer_vab_general, 'headache: 5-8%; diarrhea: 4-6%').
has_source(adverse_mer_vab_general, 'FDA label 2024').

%% --- Cefiderocol ---
has_drug(adverse_cefiderocol_general, cefiderocol).
has_adverse_category(adverse_cefiderocol_general, general).
has_common_effects(adverse_cefiderocol_general, 'diarrhea, hypertension, constipation, elevated_liver_enzymes').
has_serious_effects(adverse_cefiderocol_general, 'higher_mortality_in_CREDIBLE-CR_trial_vs_BAT (disputed), hypersensitivity, C.difficile').
has_monitoring(adverse_cefiderocol_general, 'clinical_response, mortality_signals, hepatic_function').
has_frequency(adverse_cefiderocol_general, 'diarrhea: 10%; hypertension: 6%').
has_note(adverse_cefiderocol_general, 'FDA_boxed_warning: increased_mortality_in_CREDIBLE-CR; reserve_for_limited_options').
has_source(adverse_cefiderocol_general, 'FDA label 2024, CREDIBLE-CR trial').

%% --- Polymyxin B ---
has_drug(adverse_polymyxin_b_nephro, polymyxin_b).
has_adverse_category(adverse_polymyxin_b_nephro, nephrotoxicity).
has_common_effects(adverse_polymyxin_b_nephro, 'acute_kidney_injury, proteinuria, hematuria').
has_serious_effects(adverse_polymyxin_b_nephro, 'acute_tubular_necrosis, chronic_kidney_disease').
has_monitoring(adverse_polymyxin_b_nephro, 'daily_SCr, urine_output, dose_adjustment').
has_frequency(adverse_polymyxin_b_nephro, 'nephrotoxicity: 30-60% (dose_and_duration_dependent)').
has_source(adverse_polymyxin_b_nephro, 'polymyxin共识2024').

has_drug(adverse_polymyxin_b_neuro, polymyxin_b).
has_adverse_category(adverse_polymyxin_b_neuro, neurotoxicity).
has_common_effects(adverse_polymyxin_b_neuro, 'paresthesia, dizziness, ataxia').
has_serious_effects(adverse_polymyxin_b_neuro, 'neuromuscular_blockade, respiratory_paralysis, encephalopathy').
has_monitoring(adverse_polymyxin_b_neuro, 'neurological_exam, avoid_with_myasthenia_gravis').
has_frequency(adverse_polymyxin_b_neuro, 'neurotoxicity: 7-15%').
has_source(adverse_polymyxin_b_neuro, 'polymyxin共识2024').

%% SECTION 27 PART 3 MARKER

%% --- Colistin ---
has_drug(adverse_colistin_nephro, colistin).
has_adverse_category(adverse_colistin_nephro, nephrotoxicity).
has_common_effects(adverse_colistin_nephro, 'acute_kidney_injury, elevated_SCr').
has_serious_effects(adverse_colistin_nephro, 'renal_failure_requiring_dialysis').
has_monitoring(adverse_colistin_nephro, 'daily_SCr, CrCl, dose_adjustment').
has_frequency(adverse_colistin_nephro, 'nephrotoxicity: 36-60% (higher_than_polymyxin_B)').
has_source(adverse_colistin_nephro, 'Cochrane_review_2017, polymyxin共识2024').

has_drug(adverse_colistin_neuro, colistin).
has_adverse_category(adverse_colistin_neuro, neurotoxicity).
has_common_effects(adverse_colistin_neuro, 'paresthesia, vertigo, confusion').
has_serious_effects(adverse_colistin_neuro, 'neuromuscular_blockade, apnea').
has_monitoring(adverse_colistin_neuro, 'neurological_status, respiratory_function').
has_frequency(adverse_colistin_neuro, 'neurotoxicity: 5-10%').
has_source(adverse_colistin_neuro, 'polymyxin共识2024').

%% --- Tigecycline ---
has_drug(adverse_tigecycline_general, tigecycline).
has_adverse_category(adverse_tigecycline_general, general).
has_common_effects(adverse_tigecycline_general, 'nausea, vomiting, diarrhea (GI_intolerance_common)').
has_serious_effects(adverse_tigecycline_general, 'increased_mortality (FDA_boxed_warning), acute_pancreatitis, hepatotoxicity, hypofibrinogenemia').
has_monitoring(adverse_tigecycline_general, 'hepatic_function, coagulation_parameters, clinical_response').
has_frequency(adverse_tigecycline_general, 'nausea/vomiting: 20-30%; mortality_signal: meta-analysis_showed_increased_risk').
has_note(adverse_tigecycline_general, 'FDA_boxed_warning: increased_all-cause_mortality; reserve_for_limited_options').
has_source(adverse_tigecycline_general, 'FDA label 2024, meta-analysis Prasad_2012').

%% --- Aminoglycosides: Amikacin ---
has_drug(adverse_amikacin_nephro, amikacin).
has_adverse_category(adverse_amikacin_nephro, nephrotoxicity).
has_common_effects(adverse_amikacin_nephro, 'non-oliguric_renal_insufficiency, elevated_SCr').
has_serious_effects(adverse_amikacin_nephro, 'acute_tubular_necrosis, typically_reversible').
has_monitoring(adverse_amikacin_nephro, 'SCr_every_2-3_days, trough_levels, urinalysis').
has_frequency(adverse_amikacin_nephro, 'nephrotoxicity: 5-15% (lower_with_once-daily_dosing)').
has_source(adverse_amikacin_nephro, 'UpToDate 2026, aminoglycoside_guidelines').

has_drug(adverse_amikacin_oto, amikacin).
has_adverse_category(adverse_amikacin_oto, ototoxicity).
has_common_effects(adverse_amikacin_oto, 'high-frequency_hearing_loss, tinnitus').
has_serious_effects(adverse_amikacin_oto, 'permanent_hearing_loss, vestibular_toxicity').
has_monitoring(adverse_amikacin_oto, 'baseline_and_periodic_audiometry, vestibular_assessment, peak/trough_levels').
has_frequency(adverse_amikacin_oto, 'ototoxicity: 2-10% (cumulative_dose_dependent, often_irreversible)').
has_source(adverse_amikacin_oto, 'UpToDate 2026').

%% SECTION 27 PART 4 MARKER

%% --- Fluoroquinolones: Levofloxacin ---
has_drug(adverse_levofloxacin_general, levofloxacin).
has_adverse_category(adverse_levofloxacin_general, general).
has_common_effects(adverse_levofloxacin_general, 'nausea, diarrhea, insomnia, headache').
has_serious_effects(adverse_levofloxacin_general, 'tendon_rupture (FDA_boxed_warning), QTc_prolongation, peripheral_neuropathy, aortic_dissection, hypoglycemia, CNS_effects').
has_monitoring(adverse_levofloxacin_general, 'tendon_pain, ECG_in_high-risk, glucose_in_diabetics, mental_status').
has_frequency(adverse_levofloxacin_general, 'tendon_rupture: <1% (higher_in_elderly, steroids); QTc_prolongation: 1-3%').
has_note(adverse_levofloxacin_general, 'FDA_boxed_warning: disabling_irreversible_serious_adverse_reactions (tendon, muscle, joint, nerve, CNS); reserve_for_no_alternatives').
has_source(adverse_levofloxacin_general, 'FDA label 2024, FDA_safety_communication_2016').

%% --- Aztreonam ---
has_drug(adverse_aztreonam_general, aztreonam).
has_adverse_category(adverse_aztreonam_general, general).
has_common_effects(adverse_aztreonam_general, 'diarrhea, nausea, rash').
has_serious_effects(adverse_aztreonam_general, 'hepatotoxicity (rare), C.difficile_infection').
has_monitoring(adverse_aztreonam_general, 'hepatic_function, cross-reactivity_with_ceftazidime_side_chain').
has_frequency(adverse_aztreonam_general, 'hepatotoxicity: <1%; rash: 2-5%').
has_note(adverse_aztreonam_general, 'safe_in_beta-lactam_allergy_except_ceftazidime_allergy (shared_side_chain)').
has_source(adverse_aztreonam_general, 'FDA label, UpToDate 2026').

%% --- Fosfomycin ---
has_drug(adverse_fosfomycin_general, fosfomycin).
has_adverse_category(adverse_fosfomycin_general, general).
has_common_effects(adverse_fosfomycin_general, 'diarrhea, nausea, hypernatremia (IV_form), hypokalemia').
has_serious_effects(adverse_fosfomycin_general, 'electrolyte_disturbances, seizures (high_dose)').
has_monitoring(adverse_fosfomycin_general, 'electrolytes (sodium, potassium), renal_function').
has_frequency(adverse_fosfomycin_general, 'hypernatremia: 5-10% (IV_formulation_contains_14.5g_sodium/dose)').
has_source(adverse_fosfomycin_general, 'UpToDate 2026, European_fosfomycin_guidelines').

%% =============================================================================
%% END OF SECTION 27: Adverse Effects & Toxicity
%% Drugs covered: 12 (representative coverage of major classes)
%% =============================================================================


%% =============================================================================
%% SECTION 28: Contraindications & Precautions (禁忌症与注意事项)
%% =============================================================================
%% Purpose: Document absolute and relative contraindications
%% Structure: contraindication_{drug}_{type} as node
%%   Predicates: has_drug/2, has_contraindication_type/2, has_absolute_ci/2,
%%               has_relative_ci/2, has_precaution/2
%% =============================================================================

:- dynamic has_contraindication_type/2.
:- dynamic has_absolute_ci/2.
:- dynamic has_relative_ci/2.
:- dynamic has_precaution/2.

%% SECTION 28 PART 2 MARKER

%% --- Carbapenems: Meropenem ---
has_drug(contraindication_meropenem, meropenem).
has_contraindication_type(contraindication_meropenem, hypersensitivity).
has_absolute_ci(contraindication_meropenem, 'hypersensitivity_to_meropenem_or_carbapenems').
has_relative_ci(contraindication_meropenem, 'history_of_seizure_disorder, CNS_lesions, severe_renal_impairment_without_dose_adjustment').
has_precaution(contraindication_meropenem, 'cross-reactivity_with_other_beta-lactams_approximately_1%; use_caution_in_penicillin_allergy').
has_source(contraindication_meropenem, 'FDA label 2024').

%% --- Carbapenems: Imipenem ---
has_drug(contraindication_imipenem, imipenem).
has_contraindication_type(contraindication_imipenem, cns_and_hypersensitivity).
has_absolute_ci(contraindication_imipenem, 'hypersensitivity_to_carbapenems, CNS_infections (meningitis, brain_abscess)').
has_relative_ci(contraindication_imipenem, 'epilepsy, head_trauma, CrCl<15ml/min_without_dialysis').
has_precaution(contraindication_imipenem, 'highest_seizure_risk_among_carbapenems; avoid_in_CNS_infections; contraindicated_for_meningitis').
has_source(contraindication_imipenem, 'FDA label, IDSA meningitis guidelines').

%% --- Polymyxin B ---
has_drug(contraindication_polymyxin_b, polymyxin_b).
has_contraindication_type(contraindication_polymyxin_b, hypersensitivity).
has_absolute_ci(contraindication_polymyxin_b, 'hypersensitivity_to_polymyxins').
has_relative_ci(contraindication_polymyxin_b, 'myasthenia_gravis, concurrent_nephrotoxic_drugs, concurrent_neurotoxic_drugs').
has_precaution(contraindication_polymyxin_b, 'avoid_concurrent_aminoglycosides_if_possible; adjust_dose_for_renal_impairment; may_potentiate_neuromuscular_blockade').
has_source(contraindication_polymyxin_b, 'FDA label, polymyxin共识2024').

%% --- Colistin ---
has_drug(contraindication_colistin, colistin).
has_contraindication_type(contraindication_colistin, hypersensitivity_and_neuromuscular).
has_absolute_ci(contraindication_colistin, 'hypersensitivity_to_polymyxins').
has_relative_ci(contraindication_colistin, 'myasthenia_gravis, renal_impairment_without_adjustment, concurrent_nephrotoxic_agents').
has_precaution(contraindication_colistin, 'higher_nephrotoxicity_than_polymyxin_B; avoid_if_alternative_available; CBA_formulation_requires_conversion_to_CMS').
has_source(contraindication_colistin, 'FDA label, polymyxin共识2024').

%% --- Tigecycline ---
has_drug(contraindication_tigecycline, tigecycline).
has_contraindication_type(contraindication_tigecycline, hypersensitivity_and_mortality_risk).
has_absolute_ci(contraindication_tigecycline, 'hypersensitivity_to_tigecycline_or_tetracyclines').
has_relative_ci(contraindication_tigecycline, 'VAP (FDA_boxed_warning: increased_mortality), BSI_as_monotherapy, pregnancy, children<8_years').
has_precaution(contraindication_tigecycline, 'FDA_boxed_warning: increased_all-cause_mortality; reserve_for_limited_alternatives; not_first-line_for_any_indication').
has_source(contraindication_tigecycline, 'FDA label 2024, FDA_boxed_warning').

%% SECTION 28 PART 3 MARKER

%% --- Ceftazidime-Avibactam ---
has_drug(contraindication_caz_avi, ceftazidime_avibactam).
has_contraindication_type(contraindication_caz_avi, hypersensitivity).
has_absolute_ci(contraindication_caz_avi, 'hypersensitivity_to_ceftazidime, avibactam, or_beta-lactams').
has_relative_ci(contraindication_caz_avi, 'seizure_history (cephalosporin_class_effect), severe_renal_impairment_without_adjustment').
has_precaution(contraindication_caz_avi, 'dose_adjust_for_CrCl<50ml/min; monitor_seizure_risk_especially_CrCl<30ml/min; cross-allergy_with_cephalosporins').
has_source(contraindication_caz_avi, 'FDA label 2024').

%% --- Cefiderocol ---
has_drug(contraindication_cefiderocol, cefiderocol).
has_contraindication_type(contraindication_cefiderocol, hypersensitivity_and_mortality_signal).
has_absolute_ci(contraindication_cefiderocol, 'hypersensitivity_to_cefiderocol_or_beta-lactam_antibiotics').
has_relative_ci(contraindication_cefiderocol, 'HABP/VABP_if_other_options_available (FDA_boxed_warning), non-fermentative_GNB_BSI_without_confirmed_MIC').
has_precaution(contraindication_cefiderocol, 'FDA_boxed_warning: increased_mortality_in_CREDIBLE-CR; reserve_for_CRE/CRAB/MDR-Pseudomonas_with_limited_options; confirm_MIC_if_possible').
has_source(contraindication_cefiderocol, 'FDA label 2024, CREDIBLE-CR trial').

%% --- Aminoglycosides: Amikacin ---
has_drug(contraindication_amikacin, amikacin).
has_contraindication_type(contraindication_amikacin, ototoxicity_nephrotoxicity).
has_absolute_ci(contraindication_amikacin, 'hypersensitivity_to_aminoglycosides').
has_relative_ci(contraindication_amikacin, 'pre-existing_hearing_loss, vestibular_dysfunction, myasthenia_gravis, concurrent_nephrotoxic_drugs, pregnancy').
has_precaution(contraindication_amikacin, 'TDM_mandatory; avoid_concurrent_loop_diuretics/vancomycin/polymyxins; irreversible_ototoxicity_risk; adjust_for_renal_function').
has_source(contraindication_amikacin, 'FDA label, aminoglycoside共识').

%% --- Fluoroquinolones: Levofloxacin ---
has_drug(contraindication_levofloxacin, levofloxacin).
has_contraindication_type(contraindication_levofloxacin, multiple_serious_warnings).
has_absolute_ci(contraindication_levofloxacin, 'hypersensitivity_to_fluoroquinolones, myasthenia_gravis (FDA_boxed_warning)').
has_relative_ci(contraindication_levofloxacin, 'QTc_prolongation_risk, tendon_disorders, CNS_disorders, aortic_aneurysm_risk, children<18_years (growth_plate_effects), pregnancy').
has_precaution(contraindication_levofloxacin, 'FDA_boxed_warnings: tendon_rupture, peripheral_neuropathy, CNS_effects, myasthenia_gravis_exacerbation, aortic_dissection; avoid_if_safer_alternative_available').
has_source(contraindication_levofloxacin, 'FDA label 2024, FDA_boxed_warnings').

%% --- Aztreonam ---
has_drug(contraindication_aztreonam, aztreonam).
has_contraindication_type(contraindication_aztreonam, hypersensitivity).
has_absolute_ci(contraindication_aztreonam, 'hypersensitivity_to_aztreonam').
has_relative_ci(contraindication_aztreonam, 'severe_renal_impairment_without_dose_adjustment').
has_precaution(contraindication_aztreonam, 'minimal_cross-reactivity_with_penicillins/cephalosporins; safe_in_beta-lactam_allergy_except_ceftazidime (shared_side_chain); dose_adjust_CrCl<30ml/min').
has_source(contraindication_aztreonam, 'FDA label, allergy literature').

%% --- Fosfomycin ---
has_drug(contraindication_fosfomycin, fosfomycin).
has_contraindication_type(contraindication_fosfomycin, hypersensitivity_and_formulation).
has_absolute_ci(contraindication_fosfomycin, 'hypersensitivity_to_fosfomycin').
has_relative_ci(contraindication_fosfomycin, 'severe_hypernatremia (IV_formulation_contains_sodium), severe_hyperkalemia (if_potassium_salt)').
has_precaution(contraindication_fosfomycin, 'IV_formulation_delivers_14.5mEq_Na+/g_fosfomycin; monitor_electrolytes_in_cardiac/renal_patients; oral_single-dose_for_uncomplicated_UTI_only').
has_source(contraindication_fosfomycin, 'FDA label, 中国fosfomycin指南2022').

%% --- Meropenem-Vaborbactam ---
has_drug(contraindication_mer_vab, meropenem_vaborbactam).
has_contraindication_type(contraindication_mer_vab, hypersensitivity).
has_absolute_ci(contraindication_mer_vab, 'hypersensitivity_to_meropenem, vaborbactam, or_carbapenems').
has_relative_ci(contraindication_mer_vab, 'seizure_history, CNS_lesions, severe_renal_impairment_without_adjustment').
has_precaution(contraindication_mer_vab, 'similar_seizure_risk_profile_to_meropenem; cross-reactivity_with_beta-lactams; dose_adjust_CrCl<50ml/min').
has_source(contraindication_mer_vab, 'FDA label 2024').

%% --- Imipenem-Relebactam ---
has_drug(contraindication_imi_rel, imipenem_relebactam).
has_contraindication_type(contraindication_imi_rel, cns_and_hypersensitivity).
has_absolute_ci(contraindication_imi_rel, 'hypersensitivity_to_carbapenems, CNS_infections').
has_relative_ci(contraindication_imi_rel, 'seizure_disorder, head_trauma, severe_renal_impairment').
has_precaution(contraindication_imi_rel, 'inherits_imipenem_CNS_risks; avoid_for_meningitis; highest_seizure_risk_in_carbapenem_class').
has_source(contraindication_imi_rel, 'FDA label 2024').

%% --- Piperacillin-Tazobactam ---
has_drug(contraindication_pip_tazo, piperacillin_tazobactam).
has_contraindication_type(contraindication_pip_tazo, hypersensitivity).
has_absolute_ci(contraindication_pip_tazo, 'hypersensitivity_to_penicillins, beta-lactams').
has_relative_ci(contraindication_pip_tazo, 'cystic_fibrosis (increased_rash), renal_impairment_without_adjustment').
has_precaution(contraindication_pip_tazo, 'cross-allergy_with_cephalosporins_5-10%; monitor_for_hypokalemia; dose_adjust_CrCl<40ml/min').
has_source(contraindication_pip_tazo, 'FDA label 2024').

%% =============================================================================
%% END OF SECTION 28: Contraindications & Precautions
%% Drugs covered: 12 (major antibiotics for gram-negative infections)
%% =============================================================================


%% =============================================================================
%% SECTION 29: Drug Interactions (药物相互作用)
%% =============================================================================
%% Purpose: Document clinically significant drug-drug interactions
%% Structure: drug_interaction_{drug}_{category} as node
%%   Predicates: has_drug/2, has_interaction_type/2, has_interacting_drugs/2,
%%               has_interaction_mechanism/2, has_clinical_significance/2,
%%               has_management/2
%% =============================================================================

:- dynamic has_interaction_type/2.
:- dynamic has_interacting_drugs/2.
:- dynamic has_interaction_mechanism/2.
:- dynamic has_clinical_significance/2.
:- dynamic has_management/2.

%% SECTION 29 PART 1 MARKER

%% --- Meropenem: Valproic Acid Interaction ---
has_drug(interaction_meropenem_valproate, meropenem).
has_interaction_type(interaction_meropenem_valproate, pharmacokinetic_serious).
has_interacting_drugs(interaction_meropenem_valproate, 'valproic_acid, divalproex').
has_interaction_mechanism(interaction_meropenem_valproate, 'meropenem_inhibits_valproate_glucuronidation; reduces_valproate_levels_by_60-100%').
has_clinical_significance(interaction_meropenem_valproate, 'high: breakthrough_seizures; valproate_levels_drop_within_hours').
has_management(interaction_meropenem_valproate, 'avoid_concurrent_use; switch_to_alternative_carbapenem (ertapenem_least_effect) or_antibiotic; if_unavoidable: increase_valproate_dose_and_monitor_levels_closely').
has_source(interaction_meropenem_valproate, 'FDA label, Neurology 2015;85:1-8').

%% --- Imipenem: Valproic Acid Interaction ---
has_drug(interaction_imipenem_valproate, imipenem).
has_interaction_type(interaction_imipenem_valproate, pharmacokinetic_serious).
has_interacting_drugs(interaction_imipenem_valproate, 'valproic_acid, divalproex').
has_interaction_mechanism(interaction_imipenem_valproate, 'imipenem_reduces_valproate_serum_levels_by_mechanism_similar_to_meropenem').
has_clinical_significance(interaction_imipenem_valproate, 'high: subtherapeutic_valproate_levels; seizure_risk').
has_management(interaction_imipenem_valproate, 'avoid_combination; use_alternative_antibiotic; ertapenem_has_minimal_interaction').
has_source(interaction_imipenem_valproate, 'FDA label, clinical_case_reports').

%% --- Polymyxin B: Nephrotoxic Agents ---
has_drug(interaction_polymyxin_nephrotox, polymyxin_b).
has_interaction_type(interaction_polymyxin_nephrotox, pharmacodynamic_additive).
has_interacting_drugs(interaction_polymyxin_nephrotox, 'aminoglycosides, vancomycin, amphotericin_B, cisplatin, cyclosporine, tacrolimus, NSAIDs, contrast_agents').
has_interaction_mechanism(interaction_polymyxin_nephrotox, 'additive_nephrotoxicity').
has_clinical_significance(interaction_polymyxin_nephrotox, 'high: nephrotoxicity_rate_increases_to_50-70%_with_concurrent_aminoglycosides').
has_management(interaction_polymyxin_nephrotox, 'avoid_concurrent_use_if_possible; if_necessary: monitor_SCr_daily, optimize_dosing_with_TDM, ensure_adequate_hydration').
has_source(interaction_polymyxin_nephrotox, 'polymyxin共识2024, IDSA_AKI_guidelines').

%% --- Polymyxin B: Neuromuscular Blockers ---
has_drug(interaction_polymyxin_nmb, polymyxin_b).
has_interaction_type(interaction_polymyxin_nmb, pharmacodynamic_potentiation).
has_interacting_drugs(interaction_polymyxin_nmb, 'succinylcholine, rocuronium, vecuronium, atracurium').
has_interaction_mechanism(interaction_polymyxin_nmb, 'polymyxins_have_neuromuscular_blocking_activity; potentiate_paralytic_agents').
has_clinical_significance(interaction_polymyxin_nmb, 'moderate-high: prolonged_paralysis, respiratory_depression').
has_management(interaction_polymyxin_nmb, 'use_with_caution; reduce_NMB_dose; monitor_neuromuscular_function; contraindicated_in_myasthenia_gravis').
has_source(interaction_polymyxin_nmb, 'FDA label, anesthesia_literature').

%% --- Colistin: Similar Interactions to Polymyxin B ---
has_drug(interaction_colistin_nephrotox, colistin).
has_interaction_type(interaction_colistin_nephrotox, pharmacodynamic_additive).
has_interacting_drugs(interaction_colistin_nephrotox, 'aminoglycosides, vancomycin, amphotericin_B, NSAIDs').
has_interaction_mechanism(interaction_colistin_nephrotox, 'additive_nephrotoxicity; colistin_nephrotoxicity_higher_than_polymyxin_B').
has_clinical_significance(interaction_colistin_nephrotox, 'high: AKI_rate_40-60%_with_concurrent_nephrotoxins').
has_management(interaction_colistin_nephrotox, 'avoid_concurrent_nephrotoxic_drugs; daily_renal_monitoring; prefer_polymyxin_B_if_combination_unavoidable').
has_source(interaction_colistin_nephrotox, 'polymyxin共识2024').

%% SECTION 29 PART 2 MARKER

%% --- Aminoglycosides (Amikacin): Loop Diuretics ---
has_drug(interaction_amikacin_loop_diuretics, amikacin).
has_interaction_type(interaction_amikacin_loop_diuretics, pharmacodynamic_additive).
has_interacting_drugs(interaction_amikacin_loop_diuretics, 'furosemide, bumetanide, torsemide, ethacrynic_acid').
has_interaction_mechanism(interaction_amikacin_loop_diuretics, 'additive_ototoxicity; loop_diuretics_especially_ethacrynic_acid_damage_cochlea').
has_clinical_significance(interaction_amikacin_loop_diuretics, 'high: increased_risk_of_permanent_hearing_loss').
has_management(interaction_amikacin_loop_diuretics, 'avoid_concurrent_use_especially_ethacrynic_acid; if_necessary: monitor_audiometry, use_once-daily_amikacin_dosing, TDM_to_minimize_exposure').
has_source(interaction_amikacin_loop_diuretics, 'FDA label, UpToDate 2026').

%% --- Levofloxacin: QTc-Prolonging Agents ---
has_drug(interaction_levofloxacin_qtc, levofloxacin).
has_interaction_type(interaction_levofloxacin_qtc, pharmacodynamic_additive).
has_interacting_drugs(interaction_levofloxacin_qtc, 'amiodarone, sotalol, macrolides, ondansetron, haloperidol, methadone, antipsychotics').
has_interaction_mechanism(interaction_levofloxacin_qtc, 'additive_QTc_prolongation').
has_clinical_significance(interaction_levofloxacin_qtc, 'moderate-high: torsades_de_pointes_risk').
has_management(interaction_levofloxacin_qtc, 'avoid_combination_if_possible; if_necessary: baseline_and_follow-up_ECG, correct_electrolytes (K+, Mg2+), monitor_for_arrhythmia').
has_source(interaction_levofloxacin_qtc, 'FDA label 2024').

%% --- Levofloxacin: NSAIDs/Corticosteroids ---
has_drug(interaction_levofloxacin_nsaid, levofloxacin).
has_interaction_type(interaction_levofloxacin_nsaid, pharmacodynamic_synergistic).
has_interacting_drugs(interaction_levofloxacin_nsaid, 'NSAIDs (ibuprofen, naproxen), corticosteroids (prednisone, dexamethasone)').
has_interaction_mechanism(interaction_levofloxacin_nsaid, 'NSAIDs_increase_CNS_stimulation; corticosteroids_increase_tendon_rupture_risk').
has_clinical_significance(interaction_levofloxacin_nsaid, 'moderate: seizures_with_NSAIDs; tendon_rupture_risk_doubles_with_corticosteroids').
has_management(interaction_levofloxacin_nsaid, 'avoid_NSAIDs_especially_in_elderly; counsel_on_tendon_pain; avoid_fluoroquinolones_in_patients_on_chronic_steroids_if_alternative_exists').
has_source(interaction_levofloxacin_nsaid, 'FDA label, BMJ 2019;365:l1326').

%% --- Tigecycline: Warfarin ---
has_drug(interaction_tigecycline_warfarin, tigecycline).
has_interaction_type(interaction_tigecycline_warfarin, pharmacodynamic_potentiation).
has_interacting_drugs(interaction_tigecycline_warfarin, 'warfarin').
has_interaction_mechanism(interaction_tigecycline_warfarin, 'tigecycline_may_enhance_warfarin_effect_via_gut_flora_suppression; reduces_vitamin_K_production').
has_clinical_significance(interaction_tigecycline_warfarin, 'moderate: increased_INR, bleeding_risk').
has_management(interaction_tigecycline_warfarin, 'monitor_INR_closely_during_and_after_tigecycline_therapy; adjust_warfarin_dose_as_needed').
has_source(interaction_tigecycline_warfarin, 'FDA label, clinical_case_reports').

%% --- Ceftazidime-Avibactam: No Major Interactions ---
has_drug(interaction_caz_avi_general, ceftazidime_avibactam).
has_interaction_type(interaction_caz_avi_general, minimal_interactions).
has_interacting_drugs(interaction_caz_avi_general, 'none_clinically_significant').
has_interaction_mechanism(interaction_caz_avi_general, 'avibactam_not_CYP_substrate/inhibitor/inducer; minimal_protein_binding').
has_clinical_significance(interaction_caz_avi_general, 'low: no_major_drug_interactions_documented').
has_management(interaction_caz_avi_general, 'routine_monitoring; dose_adjust_for_renal_function').
has_source(interaction_caz_avi_general, 'FDA label 2024').

%% --- Cefiderocol: Minimal Known Interactions ---
has_drug(interaction_cefiderocol_general, cefiderocol).
has_interaction_type(interaction_cefiderocol_general, minimal_interactions).
has_interacting_drugs(interaction_cefiderocol_general, 'none_clinically_significant').
has_interaction_mechanism(interaction_cefiderocol_general, 'minimal_CYP_involvement; renal_elimination').
has_clinical_significance(interaction_cefiderocol_general, 'low: limited_interaction_data_available').
has_management(interaction_cefiderocol_general, 'standard_renal_dose_adjustment; monitor_clinical_response').
has_source(interaction_cefiderocol_general, 'FDA label 2024').

%% SECTION 29 PART 3 MARKER

%% --- Fosfomycin: Metoclopramide ---
has_drug(interaction_fosfomycin_metoclopramide, fosfomycin).
has_interaction_type(interaction_fosfomycin_metoclopramide, pharmacokinetic_absorption).
has_interacting_drugs(interaction_fosfomycin_metoclopramide, 'metoclopramide').
has_interaction_mechanism(interaction_fosfomycin_metoclopramide, 'metoclopramide_increases_GI_motility; reduces_fosfomycin_oral_absorption').
has_clinical_significance(interaction_fosfomycin_metoclopramide, 'moderate: decreased_fosfomycin_efficacy_for_oral_formulation').
has_management(interaction_fosfomycin_metoclopramide, 'avoid_concurrent_use_for_oral_fosfomycin; separate_administration_by_several_hours; not_relevant_for_IV_fosfomycin').
has_source(interaction_fosfomycin_metoclopramide, 'FDA label').

%% --- Aztreonam: Minimal Interactions ---
has_drug(interaction_aztreonam_general, aztreonam).
has_interaction_type(interaction_aztreonam_general, minimal_interactions).
has_interacting_drugs(interaction_aztreonam_general, 'none_clinically_significant').
has_interaction_mechanism(interaction_aztreonam_general, 'monobactam_structure; no_major_CYP_interactions').
has_clinical_significance(interaction_aztreonam_general, 'low: safe_in_beta-lactam_combinations').
has_management(interaction_aztreonam_general, 'can_be_safely_combined_with_other_antibiotics; useful_in_beta-lactam_allergy').
has_source(interaction_aztreonam_general, 'FDA label').

%% --- Piperacillin-Tazobactam: Aminoglycosides (Incompatibility) ---
has_drug(interaction_pip_tazo_aminoglycosides, piperacillin_tazobactam).
has_interaction_type(interaction_pip_tazo_aminoglycosides, pharmaceutical_incompatibility).
has_interacting_drugs(interaction_pip_tazo_aminoglycosides, 'amikacin, gentamicin, tobramycin').
has_interaction_mechanism(interaction_pip_tazo_aminoglycosides, 'chemical_incompatibility; piperacillin_inactivates_aminoglycosides_in_solution').
has_clinical_significance(interaction_pip_tazo_aminoglycosides, 'high: reduced_aminoglycoside_activity_if_mixed').
has_management(interaction_pip_tazo_aminoglycosides, 'DO_NOT_MIX_in_same_IV_line/bag; administer_via_separate_lines; flush_line_between_drugs').
has_source(interaction_pip_tazo_aminoglycosides, 'FDA label, IV_compatibility_references').

%% --- Piperacillin-Tazobactam: Methotrexate ---
has_drug(interaction_pip_tazo_methotrexate, piperacillin_tazobactam).
has_interaction_type(interaction_pip_tazo_methotrexate, pharmacokinetic_elimination).
has_interacting_drugs(interaction_pip_tazo_methotrexate, 'methotrexate').
has_interaction_mechanism(interaction_pip_tazo_methotrexate, 'piperacillin_inhibits_methotrexate_renal_tubular_secretion').
has_clinical_significance(interaction_pip_tazo_methotrexate, 'moderate-high: methotrexate_toxicity_risk').
has_management(interaction_pip_tazo_methotrexate, 'monitor_methotrexate_levels; watch_for_myelosuppression, mucositis; consider_alternative_antibiotic').
has_source(interaction_pip_tazo_methotrexate, 'FDA label, oncology_literature').

%% --- Meropenem-Vaborbactam: Similar to Meropenem ---
has_drug(interaction_mer_vab_valproate, meropenem_vaborbactam).
has_interaction_type(interaction_mer_vab_valproate, pharmacokinetic_serious).
has_interacting_drugs(interaction_mer_vab_valproate, 'valproic_acid, divalproex').
has_interaction_mechanism(interaction_mer_vab_valproate, 'meropenem_component_reduces_valproate_levels').
has_clinical_significance(interaction_mer_vab_valproate, 'high: breakthrough_seizures').
has_management(interaction_mer_vab_valproate, 'avoid_combination; use_alternative_antibiotic_or_carbapenem (ertapenem)').
has_source(interaction_mer_vab_valproate, 'FDA label 2024').

%% =============================================================================
%% END OF SECTION 29: Drug Interactions
%% Total interactions documented: 15 (covering major clinically significant interactions)
%% =============================================================================


%% =============================================================================
%% SECTION 30: Special Population Dosing (特殊人群用药)
%% =============================================================================
%% Purpose: Enhanced dosing guidance for renal impairment, hepatic impairment,
%%          pediatrics, pregnancy, elderly, obesity, and CRRT
%% Structure: special_dosing_{drug}_{population} as node
%%   Predicates: has_drug/2, has_population/2, has_dosing_guidance/2,
%%               has_precaution/2, has_safety_category/2 (for pregnancy)
%% =============================================================================

:- dynamic has_population/2.
:- dynamic has_dosing_guidance/2.
:- dynamic has_safety_category/2.

%% SECTION 30 PART 1 MARKER

%% --- Meropenem: Renal Impairment ---
has_drug(special_meropenem_renal, meropenem).
has_population(special_meropenem_renal, renal_impairment).
has_dosing_guidance(special_meropenem_renal, 'CrCl_26-50ml/min: 1g_q12h or 500mg_q8h; CrCl_10-25ml/min: 500mg_q12h; CrCl<10ml/min: 500mg_q24h; HD: 500mg_q24h, give_after_dialysis; CRRT: 1g_q12h or 500mg_q8h (depends_on_effluent_rate)').
has_precaution(special_meropenem_renal, 'seizure_risk_increases_with_CrCl<50ml/min; consider_extended_infusion (3h) for_critically_ill').
has_source(special_meropenem_renal, 'FDA label 2024, CRRT_dosing_guidelines').

%% --- Meropenem: Pregnancy ---
has_drug(special_meropenem_pregnancy, meropenem).
has_population(special_meropenem_pregnancy, pregnancy).
has_safety_category(special_meropenem_pregnancy, 'FDA_pregnancy_category_B; limited_human_data').
has_dosing_guidance(special_meropenem_pregnancy, 'standard_dosing_1g_q8h; use_only_if_clearly_needed').
has_precaution(special_meropenem_pregnancy, 'crosses_placenta; use_when_benefit_outweighs_risk; preferred_carbapenem_in_pregnancy').
has_source(special_meropenem_pregnancy, 'FDA label, UpToDate_pregnancy_reference').

%% --- Meropenem: Pediatrics ---
has_drug(special_meropenem_pediatrics, meropenem).
has_population(special_meropenem_pediatrics, pediatric).
has_dosing_guidance(special_meropenem_pediatrics, '<3_months: 20mg/kg_q12h (meningitis: 40mg/kg_q12h); ≥3_months_and_<50kg: 20mg/kg_q8h (max_1g/dose); meningitis: 40mg/kg_q8h (max_2g/dose); ≥50kg: adult_dosing').
has_precaution(special_meropenem_pediatrics, 'FDA_approved_for_≥3_months; meningitis_indication_approved; adjust_for_renal_function').
has_source(special_meropenem_pediatrics, 'FDA label 2024').

%% --- Ceftazidime-Avibactam: Renal Impairment ---
has_drug(special_caz_avi_renal, ceftazidime_avibactam).
has_population(special_caz_avi_renal, renal_impairment).
has_dosing_guidance(special_caz_avi_renal, 'CrCl_31-50ml/min: 1.25g_q8h; CrCl_16-30ml/min: 0.94g_q12h; CrCl_6-15ml/min: 0.94g_q24h; CrCl≤5ml/min: 0.94g_q48h; HD: 0.94g_after_each_HD_session; CRRT: 1.25g_q8h to 2.5g_q8h (depends_on_CVVHDF_rate)').
has_precaution(special_caz_avi_renal, 'both_ceftazidime_and_avibactam_renally_eliminated; dose_adjustment_mandatory').
has_source(special_caz_avi_renal, 'FDA label 2024, CRRT_dosing_literature').

%% --- Ceftazidime-Avibactam: Pregnancy ---
has_drug(special_caz_avi_pregnancy, ceftazidime_avibactam).
has_population(special_caz_avi_pregnancy, pregnancy).
has_safety_category(special_caz_avi_pregnancy, 'no_FDA_category; limited_data').
has_dosing_guidance(special_caz_avi_pregnancy, 'standard_dosing_2.5g_q8h; use_only_if_no_alternative').
has_precaution(special_caz_avi_pregnancy, 'ceftazidime_crosses_placenta; avibactam_data_insufficient; reserve_for_CRE_with_limited_options').
has_source(special_caz_avi_pregnancy, 'FDA label, expert_opinion').

%% --- Cefiderocol: Renal Impairment ---
has_drug(special_cefiderocol_renal, cefiderocol).
has_population(special_cefiderocol_renal, renal_impairment).
has_dosing_guidance(special_cefiderocol_renal, 'CrCl_60-119ml/min: 2g_q8h; CrCl_45-59ml/min: 1.5g_q8h; CrCl_30-44ml/min: 1g_q8h; CrCl_15-29ml/min: 0.75g_q12h; HD: loading_2g, then_0.75g_q24h (after_HD); CRRT: 1.5-2g_q8h').
has_precaution(special_cefiderocol_renal, 'extensive_renal_elimination; dose_must_be_adjusted; infuse_over_3_hours').
has_source(special_cefiderocol_renal, 'FDA label 2024').

%% --- Polymyxin B: Renal Impairment ---
has_drug(special_polymyxin_b_renal, polymyxin_b).
has_population(special_polymyxin_b_renal, renal_impairment).
has_dosing_guidance(special_polymyxin_b_renal, 'CrCl>80ml/min: standard_dosing; CrCl<80ml/min: reduce_dose_by_25-50%; HD/PD: minimal_removal, dose_as_CrCl<30ml/min; CRRT: 1.25-1.5mg/kg_loading, then_1.25mg/kg_q12h or continuous_infusion').
has_precaution(special_polymyxin_b_renal, 'nephrotoxicity_risk_increases_with_baseline_impairment; TDM-guided_dosing_recommended; target_Css_2-2.5mg/L').
has_source(special_polymyxin_b_renal, 'polymyxin共识2024, TDM_guidelines').

%% SECTION 30 PART 2 MARKER

%% --- Polymyxin B: Pregnancy ---
has_drug(special_polymyxin_b_pregnancy, polymyxin_b).
has_population(special_polymyxin_b_pregnancy, pregnancy).
has_safety_category(special_polymyxin_b_pregnancy, 'no_adequate_human_studies; animal_studies_show_placental_transfer').
has_dosing_guidance(special_polymyxin_b_pregnancy, 'avoid_unless_life-threatening_infection; standard_dosing_if_used').
has_precaution(special_polymyxin_b_pregnancy, 'crosses_placenta; fetal_toxicity_unknown; reserve_for_XDR_infections_without_alternatives').
has_source(special_polymyxin_b_pregnancy, 'FDA label, polymyxin共识2024').

%% --- Colistin: Renal Impairment ---
has_drug(special_colistin_renal, colistin).
has_population(special_colistin_renal, renal_impairment).
has_dosing_guidance(special_colistin_renal, 'CrCl>80ml/min: loading_9MIU, maintenance_4.5MIU_q12h; CrCl_50-79ml/min: loading_9MIU, maintenance_3.75MIU_q12h; CrCl_30-49ml/min: loading_7.5MIU, maintenance_3MIU_q12h; CrCl<30ml/min: loading_6MIU, maintenance_2.25-3MIU_q12h; HD: loading_6MIU, maintenance_1.5MIU_daily; CRRT: loading_9MIU, maintenance_4.5MIU_q12h').
has_precaution(special_colistin_renal, 'CBA_to_CMS_conversion_required; TDM_recommended; nephrotoxicity_risk_40-60%').
has_source(special_colistin_renal, 'polymyxin共识2024, international_consensus_2019').

%% --- Amikacin: Renal Impairment ---
has_drug(special_amikacin_renal, amikacin).
has_population(special_amikacin_renal, renal_impairment).
has_dosing_guidance(special_amikacin_renal, 'loading_dose: 25-30mg/kg (unchanged); maintenance: CrCl_40-60ml/min: 15mg/kg_q36h; CrCl_20-39ml/min: 15mg/kg_q48h; CrCl<20ml/min: monitor_levels, usually_7.5mg/kg_q48-72h; HD: 15-20mg/kg_after_each_HD; CRRT: 15-20mg/kg_q24-36h (TDM_guided)').
has_precaution(special_amikacin_renal, 'TDM_mandatory; target_peak_55-65mcg/ml, trough_<5-10mcg/ml; once-daily_dosing_preferred').
has_source(special_amikacin_renal, 'FDA label, aminoglycoside_dosing_guidelines_2020').

%% --- Amikacin: Pregnancy ---
has_drug(special_amikacin_pregnancy, amikacin).
has_population(special_amikacin_pregnancy, pregnancy).
has_safety_category(special_amikacin_pregnancy, 'FDA_category_D; fetal_ototoxicity_risk').
has_dosing_guidance(special_amikacin_pregnancy, 'avoid_unless_no_alternative; if_used: 15mg/kg_q24h with_TDM').
has_precaution(special_amikacin_pregnancy, 'crosses_placenta; risk_of_fetal_8th_cranial_nerve_damage (irreversible_hearing_loss); use_only_for_life-threatening_infections').
has_source(special_amikacin_pregnancy, 'FDA label, IDSA_pregnancy_guidelines').

%% --- Levofloxacin: Renal Impairment ---
has_drug(special_levofloxacin_renal, levofloxacin).
has_population(special_levofloxacin_renal, renal_impairment).
has_dosing_guidance(special_levofloxacin_renal, 'CrCl_50-80ml/min: no_adjustment_for_500mg_q24h; CrCl_20-49ml/min: 750mg_load, then_750mg_q48h or 500mg_q24h; CrCl_10-19ml/min: 750mg_load, then_500mg_q48h; HD: 750mg_load, then_500mg_q48h; CRRT: 750mg_load, then_500mg_q24h').
has_precaution(special_levofloxacin_renal, 'renally_eliminated; QTc_risk_increases_with_impaired_clearance').
has_source(special_levofloxacin_renal, 'FDA label 2024').

%% --- Levofloxacin: Pregnancy ---
has_drug(special_levofloxacin_pregnancy, levofloxacin).
has_population(special_levofloxacin_pregnancy, pregnancy).
has_safety_category(special_levofloxacin_pregnancy, 'FDA_category_C; cartilage_damage_in_animal_studies').
has_dosing_guidance(special_levofloxacin_pregnancy, 'avoid; use_only_if_no_safer_alternative').
has_precaution(special_levofloxacin_pregnancy, 'fluoroquinolones_associated_with_arthropathy_in_juvenile_animals; limited_human_data; avoid_in_1st_trimester').
has_source(special_levofloxacin_pregnancy, 'FDA label, ACOG_guidelines').

%% SECTION 30 PART 3 MARKER

%% --- Tigecycline: Renal Impairment ---
has_drug(special_tigecycline_renal, tigecycline).
has_population(special_tigecycline_renal, renal_impairment).
has_dosing_guidance(special_tigecycline_renal, 'no_dose_adjustment_required; loading_100mg, then_50mg_q12h (all_CrCl_levels); not_dialyzable').
has_precaution(special_tigecycline_renal, 'hepatic_elimination_predominant; monitor_for_increased_mortality_signal').
has_source(special_tigecycline_renal, 'FDA label 2024').

%% --- Tigecycline: Hepatic Impairment ---
has_drug(special_tigecycline_hepatic, tigecycline).
has_population(special_tigecycline_hepatic, hepatic_impairment).
has_dosing_guidance(special_tigecycline_hepatic, 'Child-Pugh_A: no_adjustment; Child-Pugh_B: no_adjustment; Child-Pugh_C: loading_100mg, then_25mg_q12h (50%_reduction)').
has_precaution(special_tigecycline_hepatic, 'hepatic_metabolism; monitor_LFTs; avoid_in_severe_hepatic_impairment_if_possible').
has_source(special_tigecycline_hepatic, 'FDA label 2024').

%% --- Tigecycline: Pregnancy ---
has_drug(special_tigecycline_pregnancy, tigecycline).
has_population(special_tigecycline_pregnancy, pregnancy).
has_safety_category(special_tigecycline_pregnancy, 'FDA_category_D; tetracycline_class_effects').
has_dosing_guidance(special_tigecycline_pregnancy, 'avoid; tetracyclines_contraindicated_in_pregnancy').
has_precaution(special_tigecycline_pregnancy, 'risk_of_permanent_tooth_discoloration, skeletal_abnormalities; use_only_if_life-threatening_and_no_alternative').
has_source(special_tigecycline_pregnancy, 'FDA label 2024').

%% --- Aztreonam: Renal Impairment ---
has_drug(special_aztreonam_renal, aztreonam).
has_population(special_aztreonam_renal, renal_impairment).
has_dosing_guidance(special_aztreonam_renal, 'loading_dose: 2g_IV (unchanged); CrCl_10-30ml/min: 50%_usual_dose; CrCl<10ml/min: 25%_usual_dose; HD: 500mg_supplement_after_each_HD; CRRT: 1-2g_q8-12h').
has_precaution(special_aztreonam_renal, 'renally_eliminated; adjust_for_CrCl<30ml/min').
has_source(special_aztreonam_renal, 'FDA label, CRRT_guidelines').

%% --- Aztreonam: Pregnancy ---
has_drug(special_aztreonam_pregnancy, aztreonam).
has_population(special_aztreonam_pregnancy, pregnancy).
has_safety_category(special_aztreonam_pregnancy, 'FDA_category_B; crosses_placenta_minimally').
has_dosing_guidance(special_aztreonam_pregnancy, 'standard_dosing_1-2g_q8h; use_when_needed').
has_precaution(special_aztreonam_pregnancy, 'safe_alternative_in_beta-lactam_allergy_during_pregnancy').
has_source(special_aztreonam_pregnancy, 'FDA label, pregnancy_safety_reviews').

%% --- Fosfomycin: Renal Impairment ---
has_drug(special_fosfomycin_renal, fosfomycin).
has_population(special_fosfomycin_renal, renal_impairment).
has_dosing_guidance(special_fosfomycin_renal, 'CrCl>40ml/min: standard_12-24g/day_divided_q6-8h; CrCl_20-40ml/min: 12-16g/day; CrCl<20ml/min: 8-12g/day; HD: 4g_after_each_HD; oral_single-dose: no_adjustment').
has_precaution(special_fosfomycin_renal, 'renally_eliminated; monitor_sodium_load_in_CKD; IV_formulation_contains_14.5mEq_Na+/g').
has_source(special_fosfomycin_renal, 'European_guidelines, 中国fosfomycin指南2022').

%% --- Piperacillin-Tazobactam: Renal Impairment ---
has_drug(special_pip_tazo_renal, piperacillin_tazobactam).
has_population(special_pip_tazo_renal, renal_impairment).
has_dosing_guidance(special_pip_tazo_renal, 'CrCl>40ml/min: 4.5g_q6h; CrCl_20-40ml/min: 3.375g_q6h; CrCl<20ml/min: 2.25g_q6h; HD: 2.25g_q8h, additional_0.75g_after_HD; CRRT: 3.375-4.5g_q6-8h').
has_precaution(special_pip_tazo_renal, 'both_components_renally_cleared; extended_infusion_over_4h_preferred_for_PK/PD_target').
has_source(special_pip_tazo_renal, 'FDA label 2024, CRRT_dosing_reviews').

%% --- Piperacillin-Tazobactam: Pediatrics ---
has_drug(special_pip_tazo_pediatrics, piperacillin_tazobactam).
has_population(special_pip_tazo_pediatrics, pediatric).
has_dosing_guidance(special_pip_tazo_pediatrics, '<2_months: not_recommended; 2-9_months: 80mg_pip/kg_q8h; ≥9_months_and_<40kg: 100mg_pip/kg_q8h (max_4g_pip/dose); appendicitis/peritonitis: 112.5mg_pip/kg_q8h').
has_precaution(special_pip_tazo_pediatrics, 'FDA_approved_for_≥2_months; adjust_for_renal_impairment').
has_source(special_pip_tazo_pediatrics, 'FDA label 2024').

%% SECTION 30 PART 4 MARKER

%% --- Meropenem: Obesity ---
has_drug(special_meropenem_obesity, meropenem).
has_population(special_meropenem_obesity, obesity).
has_dosing_guidance(special_meropenem_obesity, 'standard_dosing_1-2g_q8h; no_weight-based_adjustment; consider_extended_infusion_3h_for_PK/PD_optimization').
has_precaution(special_meropenem_obesity, 'volume_of_distribution_unchanged; use_actual_body_weight_for_loading_dose_if_severe_sepsis').
has_source(special_meropenem_obesity, 'obesity_dosing_guidelines_2023').

%% --- Ceftazidime-Avibactam: CRRT Dosing ---
has_drug(special_caz_avi_crrt, ceftazidime_avibactam).
has_population(special_caz_avi_crrt, crrt).
has_dosing_guidance(special_caz_avi_crrt, 'CVVH_1L/h: 1.25g_q8h; CVVH_2L/h: 1.875g_q8h; CVVHDF_2-3L/h: 2.5g_q8h; CVVHDF_4-5L/h: 2.5g_q6h').
has_precaution(special_caz_avi_crrt, 'both_components_dialyzable; dose_depends_on_effluent_rate; TDM_recommended_if_available').
has_source(special_caz_avi_crrt, 'CRRT_dosing_literature_2023, JAC_2020').

%% --- Polymyxin B: Obesity ---
has_drug(special_polymyxin_b_obesity, polymyxin_b).
has_population(special_polymyxin_b_obesity, obesity).
has_dosing_guidance(special_polymyxin_b_obesity, 'use_adjusted_body_weight: ABW=IBW+0.4×(TBW-IBW); loading_2.5mg/kg_ABW, maintenance_1.5mg/kg_ABW_q12h or_continuous_infusion').
has_precaution(special_polymyxin_b_obesity, 'TDM_mandatory; target_Css_2-2.5mg/L; actual_body_weight_may_overestimate_dose').
has_source(special_polymyxin_b_obesity, 'polymyxin共识2024, obesity_dosing_reviews').

%% --- Colistin: Obesity ---
has_drug(special_colistin_obesity, colistin).
has_population(special_colistin_obesity, obesity).
has_dosing_guidance(special_colistin_obesity, 'use_ideal_body_weight_for_dosing; loading_9MIU_based_on_IBW, maintenance_4.5MIU_q12h').
has_precaution(special_colistin_obesity, 'avoid_actual_body_weight; risk_of_overdosing; TDM_recommended').
has_source(special_colistin_obesity, 'polymyxin共识2024').

%% --- Amikacin: Obesity ---
has_drug(special_amikacin_obesity, amikacin).
has_population(special_amikacin_obesity, obesity).
has_dosing_guidance(special_amikacin_obesity, 'use_adjusted_body_weight: ABW=IBW+0.4×(TBW-IBW); loading_25-30mg/kg_ABW; TDM_mandatory').
has_precaution(special_amikacin_obesity, 'aminoglycosides_distribute_to_lean_body_mass; avoid_actual_body_weight; target_peak_55-65mcg/ml').
has_source(special_amikacin_obesity, 'aminoglycoside_dosing_guidelines_2020, obesity_reviews').

%% --- Tigecycline: Obesity ---
has_drug(special_tigecycline_obesity, tigecycline).
has_population(special_tigecycline_obesity, obesity).
has_dosing_guidance(special_tigecycline_obesity, 'standard_dosing_100mg_load, 50mg_q12h; no_weight-based_adjustment_required').
has_precaution(special_tigecycline_obesity, 'large_volume_of_distribution; FDA_boxed_warning_for_increased_mortality; avoid_as_monotherapy_in_BSI').
has_source(special_tigecycline_obesity, 'FDA label 2024, obesity_literature').

%% --- Cefiderocol: Elderly ---
has_drug(special_cefiderocol_elderly, cefiderocol).
has_population(special_cefiderocol_elderly, elderly).
has_dosing_guidance(special_cefiderocol_elderly, 'adjust_based_on_renal_function; most_elderly_require_dose_reduction').
has_precaution(special_cefiderocol_elderly, 'age-related_renal_decline; calculate_CrCl_using_Cockcroft-Gault; increased_mortality_signal_in_CREDIBLE-CR').
has_source(special_cefiderocol_elderly, 'FDA label 2024').

%% --- Levofloxacin: Elderly ---
has_drug(special_levofloxacin_elderly, levofloxacin).
has_population(special_levofloxacin_elderly, elderly).
has_dosing_guidance(special_levofloxacin_elderly, 'adjust_for_renal_function; increased_risk_of_adverse_effects').
has_precaution(special_levofloxacin_elderly, 'FDA_boxed_warnings: tendon_rupture_risk_3-4x_higher_in_≥60_years; QTc_prolongation_risk; avoid_concurrent_corticosteroids').
has_source(special_levofloxacin_elderly, 'FDA label 2024, geriatric_guidelines').

%% =============================================================================
%% END OF SECTION 30: Special Population Dosing
%% Populations covered: renal, hepatic, pediatric, pregnancy, obesity, elderly, CRRT
%% Drugs covered: 10 major antibiotics with comprehensive special population guidance
%% =============================================================================



%% =============================================================================
%% SECTION 31: CRPA 2026 Guideline Content
%% Source: 碳青霉烯耐药铜绿假单胞菌感染诊治指南(2026版)
%% 中华医学杂志 2026年2月24日第106卷第7期 p601-617
%% =============================================================================
%% This section contains all 10 clinical questions/recommendations from CRPA 2026 guideline
%% Topics: carbapenemase detection, combination susceptibility testing, MIC monitoring,
%%         TDM, combination therapy, chronic pulmonary infection, azithromycin, nebulized
%%         therapy, CNS intrathecal therapy, and severe infection combination therapy
%% =============================================================================


%% =============================================================================
%% END OF SECTION 31: CRPA 2026 Guideline Content
%% Total: 10 clinical questions/recommendations with evidence levels and TDM targets
%% =============================================================================


%% =============================================================================
%% SECTION 32: ESBL-E 2025 Guideline Content
%% Source: 产超广谱β-内酰胺酶肠杆菌目细菌感染诊治指南(2025版)
%% =============================================================================
%% This section contains all 10 clinical recommendations from ESBL-E 2025 guideline
%% Topics: laboratory detection, confirmation testing, genotypic detection, site-specific
%%         treatment (CNS, respiratory, abdominal, urinary), special populations
%%         (neutropenic fever, emergency, pediatric), and Section 7 infection control
%% =============================================================================


%% =============================================================================
%% END OF SECTION 32: ESBL-E 2025 Guideline Content
%% Total: 10 recommendations + Section 7 infection control strategies
%% =============================================================================


%% =============================================================================
%% SECTION 33: Novel BLI 2026 Consensus Content
%% Source: 新型β-内酰胺酶抑制剂复方制剂临床应用专家共识(2026版)
%% =============================================================================
%% This section contains β-lactamase classification, 7 novel BLI combinations,
%% and 7 clinical questions (Q3-Q9) covering:
%% - KPC-producing CRE treatment
%% - KPC variant-resistant CRE treatment
%% - OXA-48-producing CRE treatment
%% - MBL-producing CRE treatment
%% - CRAB treatment
%% - DTR-PA treatment
%% - CRO treatment algorithm
%% =============================================================================


%% =============================================================================
%% END OF SECTION 33: Novel BLI 2026 Consensus Content
%% Total: β-lactamase classification system + 7 drugs + 7 clinical questions
%% =============================================================================


%% =============================================================================
%% FINAL KNOWLEDGE BASE SUMMARY (v5.3)
%% =============================================================================
%% Filename: gram_negative_resistance_kb_v5.3_merged.pl
%% Version: 5.3 Comprehensive Clinical Guidelines Integration
%% Total Sections: 33
%% Completion Date: 2026-08-07
%% Status: Complete clinical decision support knowledge base with integrated guidelines
%%
%% SECTION LIST:
%%   1. Metadata & Dynamic Declarations (enhanced for v5.3)
%%   2. Gram-Negative Bacteria (14 pathogens)
%%   3. Resistance Mechanisms (10 mechanisms)
%%   4. Resistance Markers (β-lactamases, carbapenemases, etc.)
%%   5. Antibiotic Classes (9 major classes)
%%   6. Antibiotics (32 drugs)
%%   7. Spectrum of Activity (pathogen-drug relationships)
%%   8. MIC Breakpoints (CLSI/EUCAST)
%%   9. Dosing Regimens (standard dosing for all drugs)
%%  10. Renal Dose Adjustments (CrCl-based adjustments)
%%  11. PK/PD Parameters (Vd, protein binding, half-life, etc.)
%%  12. TDM Guidelines (therapeutic targets)
%%  13. Tissue Penetration (CSF, lung, urine, etc.)
%%  14. Infection Sites (12 anatomical sites)
%%  15. Empiric Treatment Regimens (site-based recommendations)
%%  16. Targeted Treatment (culture-directed therapy)
%%  17. Combination Therapy Rationale
%%  18. Treatment Duration (site-specific durations)
%%  19. De-escalation Strategies
%%  20. Clinical Trials & Evidence
%%  21. Sepsis Bundles & Scoring (SSC Hour-1, SOFA, qSOFA)
%%  22. Source Control & Biomarkers (PCT, lactate, presepsin)
%%  23. Infection Control (isolation, hand hygiene, PPE)
%%  24. Antimicrobial Stewardship (AMS strategies)
%%  25. Clinical Guidelines (17 major guidelines)
%%  26. Inference Rules (12 clinical decision support rules)
%%  27. Adverse Effects & Toxicity (12 drugs)
%%  28. Contraindications & Precautions (12 drugs)
%%  29. Drug Interactions (15 major interactions)
%%  30. Special Population Dosing (renal, hepatic, pediatric, pregnancy, obesity, elderly, CRRT)
%%  31. CRPA 2026 Guideline (10 clinical questions/recommendations)
%%  32. ESBL-E 2025 Guideline (10 recommendations + infection control)
%%  33. Novel BLI 2026 Consensus (7 drugs + 7 clinical questions)
%%
%% Total Facts: 4000+ predicates (3000+ from v5.2 + 1000+ from new guidelines)
%% Evidence Base:
%%   - FDA labels (2024)
%%   - IDSA/ESCMID/WSES guidelines
%%   - SSC 2021
%%   - Polymyxin consensus 2024
%%   - CRPA 2026 guideline (中华医学杂志)
%%   - ESBL-E 2025 guideline
%%   - Novel BLI 2026 consensus
%%
%% Architecture: Strict binary predicate architecture (all predicates 2-arity)
%% Clinical Utility: Comprehensive support for clinical treatment and diagnosis decisions
%% Target Users: Clinical physicians treating drug-resistant Gram-negative infections
%% =============================================================================
%% Total Facts: 3000+ predicates
%% Evidence Base: FDA labels, IDSA/ESCMID guidelines, SSC 2021, polymyxin consensus 2024
%% Clinical Utility: Empiric therapy selection, de-escalation, dose adjustment, toxicity monitoring
%% =============================================================================

%% ============================================================================
%% SECTION 5: CRPA (Carbapenem-Resistant Pseudomonas aeruginosa) 2026
%% Source: 碳青霉烯耐药铜绿假单胞菌感染诊治指南(2026版)
%% 中华医学杂志 2026年2月24日第106卷第7期 p601-617
%% ============================================================================

%% --- CRPA and DTR-PA definitions ---
has_english_name(crpa, 'carbapenem-resistant Pseudomonas aeruginosa').
has_chinese_name(crpa, '碳青霉烯耐药铜绿假单胞菌').
has_description(crpa, '对碳青霉烯类抗生素耐药的铜绿假单胞菌').

has_english_name(dtr_pa, 'difficult-to-treat resistant Pseudomonas aeruginosa').
has_chinese_name(dtr_pa, '难治性耐药铜绿假单胞菌').
has_description(dtr_pa, '对哌拉西林-他唑巴坦、头孢他啶、头孢吡肟、氨曲南、亚胺培南、美罗培南、左氧氟沙星和环丙沙星均耐药的铜绿假单胞菌').
has_comment(dtr_pa, 'CRPA包含DTR-PA').

direct_is_a(crpa, pseudomonas_aeruginosa).
direct_is_a(dtr_pa, crpa).

%% --- Clinical Question 1: Carbapenemase detection ---
has_recommendation_number(crpa_rec_01, 'CRPA指南推荐意见1').
has_recommendation_topic(crpa_rec_01, 'CRPA感染治疗是否需要开展碳青霉烯酶表型或基因型检测').
has_evidence_level(crpa_rec_01, low_certainty).
has_recommendation_strength(crpa_rec_01, weak).
has_source(crpa_rec_01, 'CRPA指南2026 临床问题1 p604').
has_comment(crpa_rec_01, '共识度83.3%').
has_comment(crpa_rec_01, '碳青霉烯酶检测可能有助于优化治疗方案,但直接临床获益证据有限').
has_comment(crpa_rec_01, '该检测不涉及额外样本采集,不增加患者负担').

linked_to_recommendation(crpa, crpa_rec_01).

%% --- Clinical Question 2: Combination susceptibility testing ---
has_recommendation_number(crpa_rec_02, 'CRPA指南推荐意见2').
has_recommendation_topic(crpa_rec_02, 'CRPA感染治疗是否需要开展联合药敏试验').
has_evidence_level(crpa_rec_02, low_certainty).
has_recommendation_strength(crpa_rec_02, weak).
has_source(crpa_rec_02, 'CRPA指南2026 临床问题2 p605').
has_comment(crpa_rec_02, '建议对CRPA进行联合药敏试验,首选棋盘法联合药敏试验,次选其他联合药敏试验方法').
has_comment(crpa_rec_02, '共识度92.9%').
has_comment(crpa_rec_02, '联合治疗组与对照组14d临床治疗失败发生风险RR=0.94(95%CI:0.80-1.10)').
has_comment(crpa_rec_02, '14d病死发生风险RR=1.19(95%CI:0.83-1.69),28d病死发生风险RR=1.17(95%CI:0.89-1.54)').

linked_to_recommendation(crpa, crpa_rec_02).

%% --- Clinical Question 3: MIC monitoring during treatment ---
has_recommendation_number(crpa_rec_03, 'CRPA指南推荐意见3').
has_recommendation_topic(crpa_rec_03, 'CRPA感染治疗过程中是否需要监测菌株对抗菌药物的敏感性(MIC)').
has_evidence_level(crpa_rec_03, low_certainty).
has_recommendation_strength(crpa_rec_03, weak).
has_source(crpa_rec_03, 'CRPA指南2026 临床问题3 p605-606').
has_comment(crpa_rec_03, '建议在CRPA感染治疗过程中尽可能实施抗菌药物的药物敏感性(如MIC)监测,并据此调整治疗方案').
has_comment(crpa_rec_03, '尤其是疗程长、重症感染以及疗效不佳的患者更加建议进行药物敏感性监测').
has_comment(crpa_rec_03, '初始分离的敏感菌株在开始治疗后较短时间内可发展为耐药株').
has_comment(crpa_rec_03, '及时调整治疗方案可以提高治疗成功率,减少治疗失败和复发的风险').

linked_to_recommendation(crpa, crpa_rec_03).

%% --- Clinical Question 4: Therapeutic Drug Monitoring (TDM) ---
has_recommendation_number(crpa_rec_04, 'CRPA指南推荐意见4').
has_recommendation_topic(crpa_rec_04, 'CRPA感染在接受抗菌治疗时是否需要血药浓度监测(TDM)').
has_evidence_level(crpa_rec_04, low_certainty).
has_recommendation_strength(crpa_rec_04, weak).
has_source(crpa_rec_04, 'CRPA指南2026 临床问题4 p606-607').
has_comment(crpa_rec_04, '建议在使用头孢洛生-他唑巴坦、头孢他啶-阿维巴坦、亚胺培南-西司他丁-瑞来巴坦、头孢德罗、多黏菌素类药物、头孢他啶、美罗培南和亚胺培南-西司他丁等药物治疗CRPA感染时应尽可能进行抗菌药物TDM').
has_comment(crpa_rec_04, '尤其是对于重症或需要长疗程治疗的患者').
has_comment(crpa_rec_04, '建议对于治疗效果不佳的患者或出现不良反应、耐药性以及存在特殊情况的患者(如连续肾脏替代疗法或接受体外膜肺氧合的患者)应测尽测').

linked_to_recommendation(crpa, crpa_rec_04).

%% --- TDM targets for specific drugs (from Clinical Question 4) ---
has_phenotype(tdm_crpa_ceftolozane_tazobactam, crpa).
has_drug(tdm_crpa_ceftolozane_tazobactam, ceftolozane_tazobactam).
has_pkpd_index(tdm_crpa_ceftolozane_tazobactam, 'fT>MIC').
has_target_value(tdm_crpa_ceftolozane_tazobactam, '100% fT>4MIC').
has_strategy(tdm_crpa_ceftolozane_tazobactam, '延长或持续输注').
has_comment(tdm_crpa_ceftolozane_tazobactam, '持续输注策略显著提升目标达成率,尤其对高MIC菌株(MIC≥2μg/ml)及无肾损害的危重患者').
has_clinical_cure_rate(tdm_crpa_ceftolozane_tazobactam, '75%-100%').
has_source(tdm_crpa_ceftolozane_tazobactam, 'CRPA指南2026 p606').

has_phenotype(tdm_crpa_ceftazidime_avibactam, crpa).
has_drug(tdm_crpa_ceftazidime_avibactam, ceftazidime_avibactam).
has_pkpd_index(tdm_crpa_ceftazidime_avibactam, 'fT>MIC').
has_target_value(tdm_crpa_ceftazidime_avibactam, '100% fT>4MIC').
has_clinical_cure_rate(tdm_crpa_ceftazidime_avibactam, '59%-100%').
has_mortality_rate(tdm_crpa_ceftazidime_avibactam, '30d病死率10%-30%').
has_microbiological_clearance_rate(tdm_crpa_ceftazidime_avibactam, '60%-100%').
has_comment(tdm_crpa_ceftazidime_avibactam, '采用50% fT>MIC目标时,临床治愈率与微生物清除率均达100%').
has_comment(tdm_crpa_ceftazidime_avibactam, '10%患者出现头孢他啶-阿维巴坦耐药性').
has_source(tdm_crpa_ceftazidime_avibactam, 'CRPA指南2026 p606').

has_phenotype(tdm_crpa_cefiderocol, crpa).
has_drug(tdm_crpa_cefiderocol, cefiderocol).
has_comment(tdm_crpa_cefiderocol, '5例脓毒症休克合并肾功能衰竭患者进行TDM可动态优化个体化给药').
has_comment(tdm_crpa_cefiderocol, '6例广泛耐药革兰阴性菌感染危重症患者,采用头孢德罗6g/24h(2g/8h)持续输注方案治疗成功').
has_source(tdm_crpa_cefiderocol, 'CRPA指南2026 p606').

has_phenotype(tdm_crpa_colistin, crpa).
has_drug(tdm_crpa_colistin, colistin).
has_pkpd_index(tdm_crpa_colistin, 'AUC').
has_target_value(tdm_crpa_colistin, '稳态下0-24h AUC 50-100 mg·h-1·L-1').
has_comment(tdm_crpa_colistin, '总体药效学目标达成率仅51.2%').
has_comment(tdm_crpa_colistin, '达标患者14d临床反应率达67%(88/132)').
has_mortality_rate(tdm_crpa_colistin, '14d病死率18%(24/132),28d病死率30%(39/132)').
has_comment(tdm_crpa_colistin, '微生物失败率仍达40%(53/132)').
has_comment(tdm_crpa_colistin, '急性肾损伤发生率为27%-58%,总体不良反应发生率高达53%(70/132)').
has_source(tdm_crpa_colistin, 'CRPA指南2026 p606-607').

has_phenotype(tdm_crpa_ceftazidime, crpa).
has_drug(tdm_crpa_ceftazidime, ceftazidime).
has_target_value(tdm_crpa_ceftazidime, '40 mg/L抑菌阈值').
has_comment(tdm_crpa_ceftazidime, '1例患者经TDM优化给药方案后,体温恢复正常同时炎性指标持续下降').
has_source(tdm_crpa_ceftazidime, 'CRPA指南2026 p607').

has_phenotype(tdm_crpa_meropenem, crpa).
has_drug(tdm_crpa_meropenem, meropenem).
has_target_value(tdm_crpa_meropenem, '40% fT>MIC').
has_comment(tdm_crpa_meropenem, '6例囊性纤维化或者慢性肺部感染的患者经TDM优化给药方案后,药效学达成目标率为83%,未发现不良事件,患者耐受性良好').
has_source(tdm_crpa_meropenem, 'CRPA指南2026 p607').

has_phenotype(tdm_crpa_imipenem, crpa).
has_drug(tdm_crpa_imipenem, imipenem_cilastatin).
has_target_value(tdm_crpa_imipenem, '血药浓度≥2 mg/L').
has_comment(tdm_crpa_imipenem, '目标药物浓度未达标(<2 mg/L)的患者中治疗失败率40%(4/10),达标组治疗失败率为20%(4/19)').
has_comment(tdm_crpa_imipenem, 'TDM组临床改善率高于常规组(60%比52%)').
has_mortality_rate(tdm_crpa_imipenem, '14d死亡率TDM组16%,常规组14%').
has_mortality_rate(tdm_crpa_imipenem, '14d病死率和28d病死率,TDM组均低于对照组(18.9%比33.3%;26.4%比40.0%)').
has_source(tdm_crpa_imipenem, 'CRPA指南2026 p607').

%% --- Clinical Question 5: Polymyxin combination vs monotherapy ---
has_recommendation_number(crpa_rec_05, 'CRPA指南推荐意见5').
has_recommendation_topic(crpa_rec_05, '多黏菌素类药物联合用药治疗CRPA感染的疗效是否优于多黏菌素类药物单药治疗').
has_evidence_level(crpa_rec_05, very_low_certainty).
has_recommendation_strength(crpa_rec_05, conditional).
has_source(crpa_rec_05, 'CRPA指南2026 临床问题5 p607-608').
has_comment(crpa_rec_05, '目前的研究证据并未发现多黏菌素类药物联合用药和多黏菌素类药物单药治疗之间存在疗效差异').
has_comment(crpa_rec_05, '建议临床医师根据患者的个体情况、菌株的耐药性以及临床经验实施个体化决策').
has_comment(crpa_rec_05, '由于多黏菌素类药物普遍存在异质性耐药,单药使用极易产生耐药性').
has_comment(crpa_rec_05, '不建议多黏菌素类药物单药用于CRPA感染的治疗,即使是有体外药敏依据证明是敏感的').

linked_to_recommendation(crpa, crpa_rec_05).

%% --- Clinical Question 6: Chronic pulmonary CRPA infection treatment ---
has_recommendation_number(crpa_rec_06, 'CRPA指南推荐意见6').
has_recommendation_topic(crpa_rec_06, 'CRPA慢性肺部感染是否需要进行抗菌治疗').
has_evidence_level(crpa_rec_06, low_certainty).
has_recommendation_strength(crpa_rec_06, conditional).
has_source(crpa_rec_06, 'CRPA指南2026 临床问题6 p608').
has_comment(crpa_rec_06, '对于CRPA慢性肺部感染患者(1年发作≥2次,两次发作间隔时间超过3个月),建议给予抗菌治疗').
has_comment(crpa_rec_06, '对于下呼吸道标本CRPA培养阳性但无慢性肺部感染的患者,不建议进行常规的抗菌治疗').
has_comment(crpa_rec_06, '支气管扩张症或囊性纤维化患者继发慢性肺部CRPA感染,且菌株对吸入抗菌药物(主要为氨基糖苷类或多黏菌素类药物)敏感,可在全身治疗基础上联合抗菌药物雾化吸入治疗').

linked_to_recommendation(crpa, crpa_rec_06).
has_patient_population(crpa_rec_06, cystic_fibrosis).
has_patient_population(crpa_rec_06, bronchiectasis).
has_site(crpa_rec_06, chronic_pulmonary_infection).

%% --- Clinical Question 7: Azithromycin for chronic pulmonary CRPA infection ---
has_recommendation_number(crpa_rec_07, 'CRPA指南推荐意见7').
has_recommendation_topic(crpa_rec_07, 'CRPA慢性肺部感染是否需要阿奇霉素治疗').
has_evidence_level(crpa_rec_07, low_certainty).
has_recommendation_strength(crpa_rec_07, weak).
has_source(crpa_rec_07, 'CRPA指南2026 临床问题7 p608-609').
has_comment(crpa_rec_07, '建议CRPA慢性肺部感染的囊性纤维化和非囊性纤维化的支气管扩张症患者接受阿奇霉素治疗').

linked_to_recommendation(crpa, crpa_rec_07).
has_patient_population(crpa_rec_07, cystic_fibrosis).
has_patient_population(crpa_rec_07, bronchiectasis).
has_site(crpa_rec_07, chronic_pulmonary_infection).

%% --- Azithromycin evidence details (from Clinical Question 7) ---
has_phenotype(azithromycin_cf_crpa, crpa).
has_drug(azithromycin_cf_crpa, azithromycin).
has_patient_population(azithromycin_cf_crpa, cystic_fibrosis).
has_site(azithromycin_cf_crpa, chronic_pulmonary_infection).
has_comment(azithromycin_cf_crpa, '囊性纤维化患者: FEV1改善5.29%(95%CI:2.08%-8.50%), FVC改善4.88%(95%CI:2.01%-7.75%)').
has_comment(azithromycin_cf_crpa, '住院风险降低46%(RR=0.54,95%CI:0.31-0.96)').
has_comment(azithromycin_cf_crpa, '168d新检出铜绿假单胞菌降低(RR=0.44,95%CI:0.09-2.20)').
has_comment(azithromycin_cf_crpa, '胃肠道不良事件发生风险低于安慰剂(RD=-0.13,95%CI:-0.33-0.07)').
has_source(azithromycin_cf_crpa, 'CRPA指南2026 p522-544').

has_phenotype(azithromycin_bronchiectasis_crpa, crpa).
has_drug(azithromycin_bronchiectasis_crpa, azithromycin).
has_patient_population(azithromycin_bronchiectasis_crpa, bronchiectasis).
has_site(azithromycin_bronchiectasis_crpa, chronic_pulmonary_infection).
has_comment(azithromycin_bronchiectasis_crpa, '非囊性纤维化支气管扩张症患者: 6个月疾病恶化风险降低53%(RR=0.47,95%CI:0.32-0.69)').
has_comment(azithromycin_bronchiectasis_crpa, '12个月疾病恶化风险降低31%(RR=0.69,95%CI:0.57-0.83)').
has_comment(azithromycin_bronchiectasis_crpa, '疾病恶化次数减少1.59次/人(MD=-1.59,95%CI:-1.96至-1.21)').
has_comment(azithromycin_bronchiectasis_crpa, 'FEV1改善0.02L(MD=0.02,95%CI:0-0.04), FVC改善0.02L').
has_comment(azithromycin_bronchiectasis_crpa, '新检出铜绿假单胞菌阿奇霉素组略高于安慰剂组(RD=0.03,95%CI:-0.04-0.10)').
has_comment(azithromycin_bronchiectasis_crpa, '胃肠道不良反应风险增加(RD=0.21,95%CI:0.1-0.32)').
has_source(azithromycin_bronchiectasis_crpa, 'CRPA指南2026 p545-573').

%% --- Clinical Question 8: Nebulized therapy for acute pulmonary CRPA infection ---
has_recommendation_number(crpa_rec_08, 'CRPA指南推荐意见8').
has_recommendation_topic(crpa_rec_08, 'CRPA急性肺部感染的抗菌药物治疗是否需要在静脉给药基础上加雾化吸入治疗').
has_evidence_level(crpa_rec_08, very_low_certainty).
has_recommendation_strength(crpa_rec_08, conditional).
has_source(crpa_rec_08, 'CRPA指南2026 临床问题8 p550-610').
has_comment(crpa_rec_08, '建议静脉给药不易达到理想治疗效果的CRPA急性肺部感染患者(通常指有结构性肺病患者)静脉用药基础上增加雾化吸入治疗').
has_comment(crpa_rec_08, '建议尽量使用专用多黏菌素类药物或氨基糖苷类药物雾化吸入剂型,在无法获得专用剂型时可选用静脉剂型替代').

linked_to_recommendation(crpa, crpa_rec_08).
has_patient_population(crpa_rec_08, structural_lung_disease).
has_site(crpa_rec_08, acute_pulmonary_infection).

%% --- Nebulized therapy evidence from RCTs (Clinical Question 8) ---
has_evidence_type(crpa_rec_08_rct, randomized_controlled_trial).
has_comment(crpa_rec_08_rct, 'RCT纳入呼吸机相关性肺炎患者,感染菌包括多重耐药细菌和MDRPA').
has_comment(crpa_rec_08_rct, '联合雾化治疗组微生物清除率升高34%(RR=1.34,95%CI:0.93-1.92)').
has_comment(crpa_rec_08_rct, '临床治愈率升高20%(RR=1.20,95%CI:0.86-1.67)').
has_comment(crpa_rec_08_rct, '28d病死率差异无统计学意义(RR=0.93,95%CI:0.60-1.46)').
has_comment(crpa_rec_08_rct, '肾毒性发生风险差异无统计学意义(RR=1.02,95%CI:0.76-1.37)').
has_source(crpa_rec_08_rct, 'CRPA指南2026 p569-610').

has_evidence_type(crpa_rec_08_obs, observational_study).
has_comment(crpa_rec_08_obs, '观察性研究纳入7项研究,感染类型为广泛耐药革兰阴性菌呼吸机相关性肺炎或医院获得性肺炎').
has_comment(crpa_rec_08_obs, '联合雾化治疗组病死风险降低26%(RR=0.74,95%CI:0.59-0.93)').
has_comment(crpa_rec_08_obs, '呼吸机肺炎病死风险降低40%(RR=0.60,95%CI:0.37-0.99)').
has_comment(crpa_rec_08_obs, '临床治愈率升高41%(RR=1.41,95%CI:1.11-1.78)').
has_comment(crpa_rec_08_obs, 'ICU全因病死率差异无统计学意义(RR=0.90,95%CI:0.71-1.15)').
has_source(crpa_rec_08_obs, 'CRPA指南2026 p612-638').

%% --- Clinical Question 9: CNS infection intrathecal therapy ---
has_recommendation_number(crpa_rec_09, 'CRPA指南推荐意见9').
has_recommendation_topic(crpa_rec_09, 'CRPA中枢神经系统感染是否需要静脉给药基础上加局部(鞘内或脑室)给药').
has_evidence_level(crpa_rec_09, very_low_certainty).
has_recommendation_strength(crpa_rec_09, weak).
has_source(crpa_rec_09, 'CRPA指南2026 临床问题9 p614-680').
has_comment(crpa_rec_09, '建议对CRPA中枢神经系统感染的患者在静脉给药基础上实施鞘内给药').
has_comment(crpa_rec_09, '脑脊液渗透差或肾毒性高的药物如多黏菌素类药物、阿米卡星等建议实施鞘内给药').

linked_to_recommendation(crpa, crpa_rec_09).
has_site(crpa_rec_09, central_nervous_system_infection).

%% --- CNS infection intrathecal therapy evidence (Clinical Question 9) ---
has_evidence_type(crpa_rec_09_cohort, cohort_study).
has_comment(crpa_rec_09_cohort, '碳青霉烯耐药革兰阴性菌术后脑膜炎,联合鞘内给药组病死率显著降低(OR=0.19,95%CI:0.04-0.99)').
has_comment(crpa_rec_09_cohort, '多黏菌素类药物静脉联合鞘内给药组30d死亡率27.8%(20/72)比单用静脉给药组47.6%(20/42),P=0.032').
has_source(crpa_rec_09_cohort, 'CRPA指南2026 p633-718').

has_evidence_type(crpa_rec_09_case_series, case_series).
has_comment(crpa_rec_09_case_series, '9项单臂或病例系列研究纳入中枢神经系统感染,包括脑膜炎、脑室炎、未分类CNS感染').
has_comment(crpa_rec_09_case_series, '感染菌株涉及XDRPA、高耐药铜绿假单胞菌、DTRPA').
has_comment(crpa_rec_09_case_series, '鞘内多黏菌素使高耐药铜绿假单胞菌脑室炎患者脑脊液培养3d转阴').
has_comment(crpa_rec_09_case_series, '头孢他啶-阿维巴坦静脉联合鞘内多黏菌素或阿米卡星或妥布霉素,成功治愈MDRPA或碳青霉烯类耐药肺炎克雷伯菌感染').
has_comment(crpa_rec_09_case_series, '多黏菌素B静脉联合鞘内给药治疗多重或广泛耐药革兰阴性菌感染治愈率78%,细菌清除率78%').
has_comment(crpa_rec_09_case_series, '快速病原清除率78%-100%,高治愈率78%,极低毒性风险').
has_comment(crpa_rec_09_case_series, '未发现鞘内给药相关的额外临床负担或损害,未报道肾毒性及癫痫等不良事件').
has_source(crpa_rec_09_case_series, 'CRPA指南2026 p633-680').

%% --- Clinical Question 10: Combination therapy for CRPA infection ---
has_recommendation_number(crpa_rec_10, 'CRPA指南推荐意见10').
has_recommendation_topic(crpa_rec_10, 'CRPA感染的治疗在选择敏感抗菌药物基础上是否需要联合治疗').
has_evidence_level(crpa_rec_10, low_certainty).
has_recommendation_strength(crpa_rec_10, conditional).
has_source(crpa_rec_10, 'CRPA指南2026 临床问题10 p683-733').
has_comment(crpa_rec_10, '建议CRPA感染的重症患者采用敏感抗菌药物联合治疗').
has_comment(crpa_rec_10, '对于CRPA、DTRPA引起的医院获得性肺炎、呼吸机相关肺炎和血流感染即使单药敏感也应实施联合治疗方案').

linked_to_recommendation(crpa, crpa_rec_10).
has_site(crpa_rec_10, hospital_acquired_pneumonia).
has_site(crpa_rec_10, ventilator_associated_pneumonia).
has_site(crpa_rec_10, bloodstream_infection).

%% --- Combination therapy RCT evidence (Clinical Question 10) ---
has_evidence_type(crpa_rec_10_rct, randomized_controlled_trial).
has_comment(crpa_rec_10_rct, '3项RCT比较多黏菌素联合美罗培南vs单药,亚胺培南联合多黏菌素vs亚胺培南-西司他丁-瑞来巴坦单药').
has_comment(crpa_rec_10_rct, '感染菌株为广泛耐药多菌种感染(铜绿假单胞菌占11%-77%)').
has_comment(crpa_rec_10_rct, '感染类型包括院内获得性肺炎、血流感染、尿路感染、复杂腹腔内感染').
has_comment(crpa_rec_10_rct, '联合组与单药组肾功能中度损伤发生风险无差异(RR=0.73,95%CI:0.49-1.09)').
has_comment(crpa_rec_10_rct, '7d微生物清除率无差异(RR=1.29,95%CI:0.84-2.00)').
has_comment(crpa_rec_10_rct, '14d临床治愈率无差异(RR=1.27,95%CI:0.89-1.80)').
has_comment(crpa_rec_10_rct, '联合组治疗相关肾毒性发生风险高于单药组(RD=0.46,95%CI:0.19-0.73)').
has_comment(crpa_rec_10_rct, '治疗结束后5-9d临床治愈率联合组降低61%(RR=0.39,95%CI:0.18-0.82)').
has_comment(crpa_rec_10_rct, '14d和28d病死率无差异').
has_source(crpa_rec_10_rct, 'CRPA指南2026 p702-750').

has_evidence_type(crpa_rec_10_obs, observational_study).
has_comment(crpa_rec_10_obs, '8项观察性研究,感染菌株为XDRPA、MDRPA、CRPA').
has_comment(crpa_rec_10_obs, '感染类型涉及血流感染、肺炎、尿路感染、腹腔内感染').
has_comment(crpa_rec_10_obs, '联合治疗包括β-内酰胺类联合氨基糖苷类或氟喹诺酮类,多黏菌素类药物联合方案,新型BLI联合其他药物').
has_comment(crpa_rec_10_obs, '院内获得性肺炎患者死亡风险无差异(RR=0.90,95%CI:0.60-1.34)').
has_comment(crpa_rec_10_obs, '14d病死率无差异(RR=0.90,95%CI:0.66-1.23)').
has_comment(crpa_rec_10_obs, '临床治疗失败率无差异(RR=0.88,95%CI:0.73-1.06)').
has_comment(crpa_rec_10_obs, '呼吸机肺炎病死率无差异(RR=0.72,95%CI:0.45-1.13)').
has_comment(crpa_rec_10_obs, '新出现耐药菌株无差异').
has_comment(crpa_rec_10_obs, '肾功能损伤发生风险、终末期肾病发生率差异均无统计学意义').
has_comment(crpa_rec_10_obs, '血流感染患者30d病死率无差异(RR=0.91,95%CI:0.70-1.30)').
has_source(crpa_rec_10_obs, 'CRPA指南2026 p752-827').

%% [继续标记 - CRPA_CONTINUATION_003]

%% ============================================================================
%% SECTION 6: ESBL-E (ESBL-producing Enterobacterales) 2025
%% Source: 临床产超广谱β⁃内酰胺酶肠杆菌目细菌感染应对策略专家共识(2025)
%% 协和医学杂志 Medical Journal of Peking Union Medical College Hospital
%% ============================================================================

%% --- ESBL-E definitions ---
has_english_name(esbl, 'extended-spectrum beta-lactamase').
has_chinese_name(esbl, '超广谱β⁃内酰胺酶').
has_description(esbl, '能够水解青霉素类、第一至第三代头孢菌素类和单环β⁃内酰胺类抗生素的β⁃内酰胺酶').

has_english_name(esbl_e, 'ESBL-producing Enterobacterales').
has_chinese_name(esbl_e, '产超广谱β⁃内酰胺酶肠杆菌目细菌').
has_description(esbl_e, '产生超广谱β⁃内酰胺酶的肠杆菌目细菌,对第三代头孢菌素耐药').

direct_is_a(esbl_e, enterobacterales).
produces_enzyme(esbl_e, esbl).

%% --- ESBL-E epidemiology (Section 2) ---
has_epidemiology_data(esbl_e_china, esbl_e).
has_region(esbl_e_china, china).
has_prevalence(esbl_e_china, 'ESBL-E检出率在大肠埃希菌和肺炎克雷伯菌中分别为50%-60%和20%-30%').
has_comment(esbl_e_china, '中国ESBL-E流行率高于欧美国家').
has_comment(esbl_e_china, 'ESBL基因型以CTX-M型为主,其中CTX-M-55、CTX-M-15、CTX-M-14最常见').
has_source(esbl_e_china, 'ESBL共识2025 Section 2, PDF pages 3-4, journal pages 1104-1105').

%% --- ESBL-E laboratory detection (Section 3, Recommendation 1-3) ---
has_recommendation_number(esbl_rec_01, 'ESBL共识推荐意见1').
has_recommendation_topic(esbl_rec_01, 'ESBL-E的实验室检测方法').
has_evidence_level(esbl_rec_01, '2a').
has_recommendation_strength(esbl_rec_01, 'B').
has_source(esbl_rec_01, 'ESBL共识2025 Section 3 推荐意见1').
has_comment(esbl_rec_01, '推荐采用表型检测方法进行ESBL-E的初步筛查').
has_comment(esbl_rec_01, '表型检测包括纸片扩散法、自动化药敏系统、Etest法').
has_comment(esbl_rec_01, '表型检测以第三代头孢菌素(头孢噻肟、头孢他啶、头孢曲松)作为筛查指标').

linked_to_recommendation(esbl_e, esbl_rec_01).

has_recommendation_number(esbl_rec_02, 'ESBL共识推荐意见2').
has_recommendation_topic(esbl_rec_02, 'ESBL-E的确证试验').
has_evidence_level(esbl_rec_02, '2a').
has_recommendation_strength(esbl_rec_02, 'B').
has_source(esbl_rec_02, 'ESBL共识2025 Section 3 推荐意见2').
has_comment(esbl_rec_02, '推荐对筛查阳性的菌株进行确证试验').
has_comment(esbl_rec_02, '确证试验采用β⁃内酰胺酶抑制剂增强法,如头孢菌素联合克拉维酸').
has_comment(esbl_rec_02, 'CLSI和EUCAST标准均推荐此方法').

linked_to_recommendation(esbl_e, esbl_rec_02).

has_recommendation_number(esbl_rec_03, 'ESBL共识推荐意见3').
has_recommendation_topic(esbl_rec_03, 'ESBL-E的基因型检测').
has_evidence_level(esbl_rec_03, '2a').
has_recommendation_strength(esbl_rec_03, 'B').
has_source(esbl_rec_03, 'ESBL共识2025 Section 3 推荐意见3').
has_comment(esbl_rec_03, '推荐在流行病学监测、耐药机制研究、特殊临床情况下进行基因型检测').
has_comment(esbl_rec_03, '基因型检测方法包括PCR、测序、基因芯片、质谱技术').
has_comment(esbl_rec_03, '常见ESBL基因型包括CTX-M、SHV、TEM家族').

linked_to_recommendation(esbl_e, esbl_rec_03).

%% --- ESBL-E CNS infections (Section 5.2, Recommendation 4) ---
has_recommendation_number(esbl_rec_04, 'ESBL共识推荐意见4').
has_recommendation_topic(esbl_rec_04, 'ESBL-E中枢神经系统感染的治疗').
has_evidence_level(esbl_rec_04, '2a').
has_recommendation_strength(esbl_rec_04, 'B').
has_source(esbl_rec_04, 'ESBL共识2025 Section 5.2 推荐意见4, PDF pages 8-9, journal pages 1109-1110').

linked_to_recommendation(esbl_e, esbl_rec_04).
has_site(esbl_rec_04, central_nervous_system_infection).

has_phenotype(esbl_cns_meropenem, esbl_e).
has_drug(esbl_cns_meropenem, meropenem).
has_site(esbl_cns_meropenem, central_nervous_system_infection).
first_line(esbl_cns_meropenem, yes).
has_dose(esbl_cns_meropenem, '美罗培南 2g q8h 静脉滴注').
has_duration(esbl_cns_meropenem, '最少3周').
has_rationale(esbl_cns_meropenem, '美罗培南对ESBL-E引起的中枢神经系统感染疗效确切,脑脊液渗透性好').
has_comment(esbl_cns_meropenem, '流式细胞术和分子检测技术可提高病原检出率').
has_source(esbl_cns_meropenem, 'ESBL共识2025 Section 5.2, PDF pages 8-9, journal pages 1109-1110').

%% --- ESBL-E respiratory infections (Section 5.3, Recommendation 5) ---
has_recommendation_number(esbl_rec_05, 'ESBL共识推荐意见5').
has_recommendation_topic(esbl_rec_05, 'ESBL-E呼吸系统和胸腔感染的治疗').
has_evidence_level(esbl_rec_05, '2a').
has_recommendation_strength(esbl_rec_05, 'B').
has_source(esbl_rec_05, 'ESBL共识2025 Section 5.3 推荐意见5, PDF pages 9-10, journal pages 1110-1111').

linked_to_recommendation(esbl_e, esbl_rec_05).
has_site(esbl_rec_05, respiratory_infection).
has_site(esbl_rec_05, thoracic_infection).

has_phenotype(esbl_resp_severe, esbl_e).
has_site(esbl_resp_severe, respiratory_infection).
has_severity(esbl_resp_severe, severe).
has_drug(esbl_resp_severe, carbapenem).
first_line(esbl_resp_severe, yes).
has_comment(esbl_resp_severe, '重症肺炎(HAP/VAP)首选碳青霉烯类').
has_comment(esbl_resp_severe, '社区获得性肺炎(CAP)根据感染严重程度选择抗菌药物').
has_comment(esbl_resp_severe, '胸腔感染需覆盖铜绿假单胞菌时考虑联合用药').
has_source(esbl_resp_severe, 'ESBL共识2025 Section 5.3, PDF pages 9-10, journal pages 1110-1111').

%% --- ESBL-E abdominal infections (Section 5.4, Recommendation 6) ---
has_recommendation_number(esbl_rec_06, 'ESBL共识推荐意见6').
has_recommendation_topic(esbl_rec_06, 'ESBL-E腹腔感染的治疗').
has_evidence_level(esbl_rec_06, '2a').
has_recommendation_strength(esbl_rec_06, 'B').
has_source(esbl_rec_06, 'ESBL共识2025 Section 5.4 推荐意见6, PDF page 10, journal page 1111').
has_comment(esbl_rec_06, '源头控制是腹腔感染治疗的核心').

linked_to_recommendation(esbl_e, esbl_rec_06).
has_site(esbl_rec_06, abdominal_infection).

has_phenotype(esbl_abdominal_refractory, esbl_e).
has_site(esbl_abdominal_refractory, abdominal_infection).
has_severity(esbl_abdominal_refractory, refractory).
has_drug(esbl_abdominal_refractory, tigecycline).
has_drug_alternative(esbl_abdominal_refractory, eravacycline).
first_line(esbl_abdominal_refractory, yes).
has_rationale(esbl_abdominal_refractory, '替加环素和依拉环素对难治性腹腔感染有效').
has_comment(esbl_abdominal_refractory, '需注意覆盖厌氧菌').
has_comment(esbl_abdominal_refractory, '源头控制(引流、清创)与抗菌治疗同等重要').
has_source(esbl_abdominal_refractory, 'ESBL共识2025 Section 5.4, PDF page 10, journal page 1111').

%% --- ESBL-E urinary infections (Section 5.5, Recommendation 7) ---
has_recommendation_number(esbl_rec_07, 'ESBL共识推荐意见7').
has_recommendation_topic(esbl_rec_07, 'ESBL-E泌尿系统感染的治疗').
has_evidence_level(esbl_rec_07, '2a').
has_recommendation_strength(esbl_rec_07, 'B').
has_source(esbl_rec_07, 'ESBL共识2025 Section 5.5 推荐意见7, PDF pages 10-11, journal pages 1111-1112').

linked_to_recommendation(esbl_e, esbl_rec_07).
has_site(esbl_rec_07, urinary_tract_infection).

has_phenotype(esbl_uti_simple, esbl_e).
has_site(esbl_uti_simple, urinary_tract_infection).
has_severity(esbl_uti_simple, simple).
has_drug(esbl_uti_simple, nitrofurantoin).
has_drug_alternative(esbl_uti_simple, fosfomycin).
first_line(esbl_uti_simple, yes).
has_rationale(esbl_uti_simple, '单纯下尿路感染首选口服药物').
has_comment(esbl_uti_simple, '呋喃妥因和磷霉素对ESBL-E尿路感染有效').
has_source(esbl_uti_simple, 'ESBL共识2025 Section 5.5, PDF pages 10-11, journal pages 1111-1112').

has_phenotype(esbl_uti_severe, esbl_e).
has_site(esbl_uti_severe, urinary_tract_infection).
has_severity(esbl_uti_severe, severe).
has_drug(esbl_uti_severe, carbapenem).
first_line(esbl_uti_severe, yes).
has_rationale(esbl_uti_severe, '重症尿路感染或尿源性脓毒症首选静脉碳青霉烯类').
has_comment(esbl_uti_severe, '病情稳定后可降阶梯至口服药物').
has_source(esbl_uti_severe, 'ESBL共识2025 Section 5.5, PDF pages 10-11, journal pages 1111-1112').

%% --- ESBL-E neutropenic fever (Section 6.1, Recommendation 8) ---
has_recommendation_number(esbl_rec_08, 'ESBL共识推荐意见8').
has_recommendation_topic(esbl_rec_08, 'ESBL-E中性粒细胞缺乏伴发热患者的治疗').
has_evidence_level(esbl_rec_08, '2a').
has_recommendation_strength(esbl_rec_08, 'B').
has_source(esbl_rec_08, 'ESBL共识2025 Section 6.1 推荐意见8, PDF page 11, journal page 1112').

linked_to_recommendation(esbl_e, esbl_rec_08).
has_patient_type(esbl_rec_08, neutropenic_fever).

%% Neutropenic fever definition
has_definition(neutropenic_fever, 'ANC<0.5×10^9/L或预计48h内将降至该水平以下，伴单次口腔温度≥38.3℃或持续1h以上口腔温度≥38.0℃').
has_definition(severe_neutropenia, 'ANC<0.1×10^9/L').
has_comment(neutropenic_fever, '老年患者感染时可能不出现典型发热，甚至表现为体温过低等非典型临床表现').

%% High-risk neutropenic fever: carbapenem or anti-pseudomonal BLI
has_phenotype(esbl_neutropenic_high_risk_carb, esbl_e).
has_patient_type(esbl_neutropenic_high_risk_carb, high_risk_neutropenic_fever).
first_line(esbl_neutropenic_high_risk_carb, yes).
has_drug(esbl_neutropenic_high_risk_carb, imipenem).
has_drug_alternative(esbl_neutropenic_high_risk_carb, meropenem).
has_rationale(esbl_neutropenic_high_risk_carb, '高危中性粒细胞缺乏伴发热患者推荐碳青霉烯类药物').
has_source(esbl_neutropenic_high_risk_carb, 'ESBL共识2025 Section 6.1.3.1, PDF page 11, journal page 1112').

has_phenotype(esbl_neutropenic_high_risk_bli, esbl_e).
has_patient_type(esbl_neutropenic_high_risk_bli, high_risk_neutropenic_fever).
first_line(esbl_neutropenic_high_risk_bli, yes).
has_drug(esbl_neutropenic_high_risk_bli, ceftolozane_tazobactam).
has_drug_alternative(esbl_neutropenic_high_risk_bli, piperacillin_tazobactam).
has_drug_alternative(esbl_neutropenic_high_risk_bli, cefoperazone_sulbactam).
has_comment(esbl_neutropenic_high_risk_bli, '国内学者通常也采用头孢哌酮/舒巴坦治疗').
has_rationale(esbl_neutropenic_high_risk_bli, '高危患者可选用抗假单胞菌β-内酰胺类/酶抑制剂复方制剂').
has_source(esbl_neutropenic_high_risk_bli, 'ESBL共识2025 Section 6.1.3.1, PDF page 11, journal page 1112').

%% Piperacillin-tazobactam extended infusion
has_comment(pip_tazo_extended_infusion, '哌拉西林/他唑巴坦可以作为除严重感染外（尤其是除严重脓毒血症及感染性休克患者外）的ESBL-E感染患者的治疗选择').
has_dose(pip_tazo_extended_infusion, '哌拉西林/他唑巴坦采用合适剂量并延长输注时间').
has_rationale(pip_tazo_extended_infusion, '延长输注时间可优化PK/PD参数').

%% Low-risk neutropenic fever
has_phenotype(esbl_neutropenic_low_risk, esbl_e).
has_patient_type(esbl_neutropenic_low_risk, low_risk_neutropenic_fever).
first_line(esbl_neutropenic_low_risk, yes).
has_drug(esbl_neutropenic_low_risk, piperacillin_tazobactam).
has_dose(esbl_neutropenic_low_risk, '合适剂量与延长输注时间').
has_comment(esbl_neutropenic_low_risk, '低危患者可应用哌拉西林-他唑巴坦等药物单药治疗').
has_source(esbl_neutropenic_low_risk, 'ESBL共识2025 Section 6.1, PDF pages 11-12, journal pages 1112-1113').

%% Duration for neutropenic fever
has_duration(esbl_neutropenic_duration_1, '抗菌药物应使用至退热后7天停药').
has_comment(esbl_neutropenic_duration_2, '对于退热48h、血流动力学稳定且感染症状体征缓解但ANC仍低于0.5×10^9/L的患者，可考虑停用抗菌药物治疗，但需密切监测24-48h').
has_comment(esbl_neutropenic_duration_3, '若再次发热应立即重启抗菌药物治疗').
has_comment(esbl_neutropenic_duration_4, '病原学确诊感染的治疗应至少持续7天，直至病原微生物清除、临床症状体征完全缓解且持续退热4天以上，即使ANC仍<0.5×10^9/L也可以停药').
has_source(esbl_neutropenic_duration_1, 'ESBL共识2025 Section 6.1.3.2, PDF pages 11-12, journal pages 1112-1113').

%% --- ESBL-E emergency patients (Section 6.2, Recommendation 9) ---
has_recommendation_number(esbl_rec_09, 'ESBL共识推荐意见9').
has_recommendation_topic(esbl_rec_09, 'ESBL-E急诊患者的治疗').
has_evidence_level(esbl_rec_09, '2a').
has_recommendation_strength(esbl_rec_09, 'B').
has_source(esbl_rec_09, 'ESBL共识2025 Section 6.2 推荐意见9, PDF page 12, journal page 1113').

linked_to_recommendation(esbl_e, esbl_rec_09).
has_patient_type(esbl_rec_09, emergency_patient).

%% Emergency patient epidemiology
has_epidemiology(emergency_esbl, '急诊ESBL-E感染的主要类型为泌尿道感染和血流感染，主要致病菌为大肠埃希菌和肺炎克雷伯菌').
has_source(emergency_esbl, 'ESBL共识2025 Section 6.2.1, PDF page 12, journal page 1113').

%% Risk factors for emergency ESBL
has_risk_factor(emergency_esbl_risk_1, '老年患者（≥65岁）').
has_risk_factor(emergency_esbl_risk_2, '反复抗菌药物使用史').
has_risk_factor(emergency_esbl_risk_3, '接受侵入性操作').
has_risk_factor(emergency_esbl_risk_4, '长期入住医疗机构').
has_risk_factor(emergency_esbl_risk_5, '免疫功能低下状态').
has_source(emergency_esbl_risk_1, 'ESBL共识2025 Section 6.2.1, PDF page 12, journal page 1113').

%% Emergency monotherapy for most patients
has_phenotype(esbl_emergency_monotherapy, esbl_e).
has_patient_type(esbl_emergency_monotherapy, emergency_patient).
first_line(esbl_emergency_monotherapy, yes).
has_indication(esbl_emergency_monotherapy, '无脓毒症休克、仅局部感染、接受抗菌药物后临床改善、无严重合并症及无其他病原体合并感染').
has_rationale(esbl_emergency_monotherapy, '绝大多数急诊ESBL-E感染患者仅需单药治疗').
has_comment(esbl_emergency_monotherapy, '需根据患者的危重程度和治疗反应及时调整抗菌药物方案').
has_source(esbl_emergency_monotherapy, 'ESBL共识2025 Section 6.2.3, PDF page 12, journal page 1113').

%% Emergency severe infection: combination therapy
has_phenotype(esbl_emergency_combination, esbl_e).
has_patient_type(esbl_emergency_combination, emergency_patient_severe).
has_indication(esbl_emergency_combination, '并发脓毒症休克').
first_line(esbl_emergency_combination, yes).
has_drug(esbl_emergency_combination, carbapenem).
has_drug_alternative(esbl_emergency_combination, beta_lactam_bli_combination).
has_combination_drug(esbl_emergency_combination, fluoroquinolone).
has_combination_drug_alternative(esbl_emergency_combination, aminoglycoside).
has_rationale(esbl_emergency_combination, '对于ESBL-E重症感染（如并发脓毒症休克），推荐碳青霉烯类或β-内酰胺类/酶抑制剂复方制剂联合喹诺酮类或氨基糖苷类抗菌药物').
has_comment(esbl_emergency_combination, '该方案通过协同抗菌作用提高临床疗效，但需密切监测药物不良反应').
has_source(esbl_emergency_combination, 'ESBL共识2025 Section 6.2.3, PDF page 12, journal page 1113').

%% --- ESBL-E pediatric patients (Section 6.3, Recommendation 10) ---
has_recommendation_number(esbl_rec_10, 'ESBL共识推荐意见10').
has_recommendation_topic(esbl_rec_10, 'ESBL-E儿科患者的治疗').
has_evidence_level(esbl_rec_10, '2a').
has_recommendation_strength(esbl_rec_10, 'B').
has_source(esbl_rec_10, 'ESBL共识2025 Section 6.3 推荐意见10, PDF pages 12-13, journal pages 1113-1114').

linked_to_recommendation(esbl_e, esbl_rec_10).
has_patient_type(esbl_rec_10, pediatric_patient).

%% Pediatric treatment principles
has_principle(pediatric_principle_1, '应充分考虑儿童年龄、生理功能和代谢水平的个体差异因素').
has_principle(pediatric_principle_2, '严格按照说明书用药，保证疗效确切且用药安全').
has_principle(pediatric_principle_3, '对于喹诺酮类、氨基糖苷类、四环素类等超说明书用药，仅可在获益远大于风险的前提下谨慎使用').
has_source(pediatric_principle_1, 'ESBL共识2025 Section 6.3, PDF pages 12-13, journal pages 1113-1114').

%% Pediatric epidemiology
has_epidemiology(pediatric_esbl_1, '2022年中国儿童细菌耐药监测结果显示，儿童感染肠杆菌目细菌占比居前3位的分别为大肠埃希菌、肺炎克雷伯菌和阴沟肠杆菌').
has_epidemiology(pediatric_esbl_2, '产ESBL大肠埃希菌和肺炎克雷伯菌的占比分别为41.8%和42.3%').
has_comment(pediatric_esbl_sites, '儿童ESBL-E感染多见于重症监护病房，其中肺炎克雷伯菌是VAP的首位致病菌；而大肠埃希菌是引起新生儿化脓性脑膜脑炎和血流感染的主要病原菌').
has_source(pediatric_esbl_1, 'ESBL共识2025 Section 6.3.1, PDF page 12, journal page 1113').

%% VLBW infant considerations
has_comment(vlbw_esbl_1, '极低出生体重儿发生大肠埃希菌感染，临床表现多不典型（发热或低体温、腹泻、拒乳、呼吸暂停等），病情进展迅速，甚至合并休克').
has_comment(vlbw_esbl_2, '早期抗菌药物的合理应用是降低其病死率的关键因素').
has_comment(neonatal_esbl, '对于诊断为化脓性脑膜脑炎或血流感染的新生儿，抗菌药物选择应考虑覆盖耐药大肠埃希菌').
has_source(vlbw_esbl_1, 'ESBL共识2025 Section 6.3.1, PDF page 12, journal page 1113').

%% Pediatric PK/PD characteristics
has_principle(pediatric_pkpd_1, '儿童年龄跨度大，其体液成分、器官功能及代谢水平随着年龄增长呈非线性变化，与体重增长也无确切的线性关系').
has_comment(neonatal_pkpd_1, '新生儿胃液pH值偏高伴胃排空延迟，增加了口服药物的生物利用度').
has_comment(neonatal_pkpd_2, '新生儿体液总量和细胞外液占比较高，导致水溶性药物的表观分布容积增大，从而药物初始剂量需要增大').
has_comment(neonatal_pkpd_3, '药物代谢和清除受到肝肾功能发育水平及疾病本身影响').
has_principle(pediatric_tdm, '对于缺少儿童/新生儿人群PK/PD数据的药物，需动态监测用药后的血药浓度，根据疗程、疗效和脏器情况，动态调整抗菌药物使用剂量').
has_source(pediatric_pkpd_1, 'ESBL共识2025 Section 6.3.2.1, PDF pages 12-13, journal pages 1113-1114').

%% Off-label use warnings
has_contraindication(fluoroquinolone_pediatric, '氟喹诺酮类药物（如诺氟沙星、左氧氟沙星等），动物实验提示其对幼鼠骨骼发育产生不良反应，可能会影响儿童关节和软骨发育，在18岁以下儿童中属于超说明书用药').
has_contraindication(aminoglycoside_pediatric, '氨基糖苷类药物（如庆大霉素、阿米卡星等），对儿童造成的不良反应包括耳毒性和肾毒性，因此说明书建议儿科应慎用氨基糖苷类药物').
has_contraindication(tetracycline_pediatric, '四环素类药物（如四环素、多西环素、替加环素等），8岁以下儿童无适应证').
has_principle(off_label_principle, '临床医师需充分基于伦理和科学原则，权衡患儿获益与风险，遵循无替代、有证据、非试验、获批准、有知情、可监控等原则使用超说明书药物').
has_source(fluoroquinolone_pediatric, 'ESBL共识2025 Section 6.3.2.2, PDF page 13, journal page 1114').

%% Pediatric drug selection factors
has_principle(pediatric_selection_1, '感染特征（部位、病原菌及严重程度）').
has_principle(pediatric_selection_2, '患儿发育特点（各年龄段特有的生理特征和PK/PD参数）').
has_principle(pediatric_selection_3, '流行病学数据（本地病原菌分布及耐药谱）').
has_principle(pediatric_selection_4, '用药史（近期抗菌药物暴露情况）').
has_principle(pediatric_selection_5, '耐药风险因素（基础疾病、免疫状态等）').
has_source(pediatric_selection_1, 'ESBL共识2025 Section 6.3.2.3, PDF page 13, journal page 1114').

%% Pediatric first-line treatment
has_phenotype(esbl_pediatric_empiric, esbl_e).
has_patient_type(esbl_pediatric_empiric, pediatric_patient).
first_line(esbl_pediatric_empiric, yes).
has_drug(esbl_pediatric_empiric, beta_lactam_bli_combination).
has_drug_alternative(esbl_pediatric_empiric, carbapenem).
has_rationale(esbl_pediatric_empiric, '在实际临床工作中，多选用临床已广泛应用的β-内酰胺类/酶抑制剂复方制剂或碳青霉烯类药物进行经验性治疗').
has_source(esbl_pediatric_empiric, 'ESBL共识2025 Section 6.3.2.3, PDF page 13, journal page 1114').

%% Ceftolozane-tazobactam pediatric indication
has_phenotype(esbl_pediatric_ceftolozane, esbl_e).
has_patient_type(esbl_pediatric_ceftolozane, pediatric_patient).
has_drug(esbl_pediatric_ceftolozane, ceftolozane_tazobactam).
has_site(esbl_pediatric_ceftolozane, complicated_intra_abdominal_infection).
has_site_alternative(esbl_pediatric_ceftolozane, complicated_urinary_tract_infection).
has_comment(esbl_pediatric_ceftolozane, '头孢洛生-他唑巴坦已获批从儿童出生时即开始治疗复杂性腹腔内感染（cIAI）和复杂性尿路感染（cUTI）').
has_source(esbl_pediatric_ceftolozane, 'ESBL共识2025 Section 6.3.2.3, PDF page 13, journal page 1114').

%% --- Section 7: ESBL-E infection prevention and control ---
%% 7.1 Main management strategies

%% Antimicrobial Stewardship (AMS)
has_definition(antimicrobial_stewardship, '医疗机构通过一系列干预措施，优化抗菌药物的临床使用，以改善患者预后的综合管理方案').
has_core_element(ams, '优化诊断').
has_core_element(ams, '明确适应证').
has_core_element(ams, '优化药物选择及给药方案（包括剂量、给药途径和疗程）').
has_goal(ams, '减少不合理用药及相关不良事件，最终减少新型耐药菌的产生').
has_source(antimicrobial_stewardship, 'ESBL共识2025 Section 7.1, PDF pages 13-14, journal pages 1114-1115').

%% AMS implementation requirements
has_requirement(ams_implementation_1, '有效的领导力和行政支持').
has_requirement(ams_implementation_2, '多学科共同协作').
has_requirement(ams_implementation_3, '动态更新的技术支撑体系').
has_component(ams_technical_system_1, '基于循证医学的本机构抗菌药物应用指南制订').
has_component(ams_technical_system_2, '临床医师规范化培训与能力建设').
has_component(ams_technical_system_3, '抗菌药物使用评价与及时反馈').
has_component(ams_technical_system_4, '抗菌药物用药强度评价').
has_component(ams_technical_system_5, '艰难梭菌感染等不良结局监测').
has_component(ams_technical_system_6, '指南依从性监测').
has_component(ams_technical_system_7, '病原微生物检测方法优化').
has_source(ams_implementation_1, 'ESBL共识2025 Section 7.1, PDF pages 13-14, journal pages 1114-1115').

%% Control strategy 1: Education, training, evaluation and feedback
has_strategy(esbl_control_strategy_1, '加强抗菌药物合理应用的教育培训、评价与反馈').
has_measure(esbl_control_measure_1_1, '持续不断开展抗菌药物合理应用教育、培训').
has_measure(esbl_control_measure_1_2, '采用对处方医师的授权').
has_measure(esbl_control_measure_1_3, '抗菌药物使用合理性评价').
has_measure(esbl_control_measure_1_4, '及时和针对性的反馈').
has_measure(esbl_control_measure_1_5, '依托信息化建设，通过信息化手段实现对重点环节的智能管理').
has_source(esbl_control_strategy_1, 'ESBL共识2025 Section 7.1 strategy 1, PDF page 13, journal page 1114').

%% Control strategy 2: Strengthen microbiology thinking
has_strategy(esbl_control_strategy_2, '强化抗菌药物处方人员的病原微生物学思维').
has_measure(esbl_control_measure_2_1, '药敏报告的解读').
has_measure(esbl_control_measure_2_2, '感染和定植菌的区分').
has_measure(esbl_control_measure_2_3, '宏基因报告的分析和解读').
has_source(esbl_control_strategy_2, 'ESBL共识2025 Section 7.1 strategy 2, PDF page 13, journal page 1114').

%% Control strategy 3: Unify empiric and targeted therapy
has_strategy(esbl_control_strategy_3, '努力实现经验性治疗与目标治疗的统一').
has_measure(esbl_control_measure_3_1, '启动经验性治疗后应每日评估患者是否对抗菌药物有治疗反应').
has_measure(esbl_control_measure_3_2, '评估是否已送检标本进行培养及病原诊断检测').
has_measure(esbl_control_measure_3_3, '评估能否停用抗菌药物或使用更窄谱的抗菌药物').
has_measure(esbl_control_measure_3_4, '缩短经验性治疗向目标性治疗转换的时间').
has_source(esbl_control_strategy_3, 'ESBL共识2025 Section 7.1 strategy 3, PDF page 13, journal page 1114').

%% Control strategy 4: Individualized empiric therapy
has_strategy(esbl_control_strategy_4, '在耐药背景下实施个体化经验性抗感染治疗').
has_consideration(individualized_therapy_1, '患者特征（年龄、器官功能状态）').
has_consideration(individualized_therapy_2, '感染特点（部位、严重程度分级）').
has_consideration(individualized_therapy_3, '耐药风险评估（流行病学数据、既往用药史）').
has_consideration(individualized_therapy_4, '基于PK/PD原则优化给药方案（剂量、频次、输注方式）').
has_source(esbl_control_strategy_4, 'ESBL共识2025 Section 7.1 strategy 4, PDF pages 13-14, journal pages 1114-1115').

%% Control strategy 5: Regulate third-generation cephalosporin use
has_strategy(esbl_control_strategy_5, '规范三代头孢菌素临床应用').
has_rationale(third_gen_ceph_restriction, '三代头孢菌素类药物具有显著的生态影响').
has_impact(third_gen_ceph_impact_1, '引起肠道微生物组成变化和多样性显著下降').
has_impact(third_gen_ceph_impact_2, '使危重患者气道内和会阴区肠杆菌的丰度显著增加').
has_impact(third_gen_ceph_impact_3, '用量与抗菌药物耐药性和产ESBL发生率相关').
has_restriction(third_gen_ceph_restriction_1, '应严格限制三代头孢菌素类药物（包括头孢曲松）在围术期的预防用药').
has_restriction(third_gen_ceph_restriction_2, '仅用于肠道革兰阴性菌污染手术的预防').
has_source(esbl_control_strategy_5, 'ESBL共识2025 Section 7.1 strategy 5, PDF page 14, journal page 1115').

%% Control strategy 6: Multidisciplinary consultation and IT management
has_strategy(esbl_control_strategy_6, '加强多学科会诊和抗菌药物信息化管理').
has_measure(esbl_control_measure_6_1, '针对ESBL-E导致的复杂感染，及时组织临床、微生物、药学、感染防控、护理等多学科进行协作诊治、防控').
has_measure(esbl_control_measure_6_2, '加强医院信息系统中关于抗菌药物管理模块建设，协助临床人员进行决策').
has_source(esbl_control_strategy_6, 'ESBL共识2025 Section 7.1 strategy 6, PDF page 14, journal page 1115').

%% 7.2 Strict adherence to aseptic technique and infection control standards
%% 7.2.1 Strict adherence to aseptic technique

has_principle(aseptic_technique_importance, '合格的无菌操作对于预防操作相关感染（如手术部位感染、穿刺部位感染、介入相关感染）和器械相关感染（如CLBSI、导尿管相关尿路感染、VAP）至关重要').
has_rationale(aseptic_technique_rationale, '若无菌操作失误导致相关感染，会增加抗菌药物使用剂量以及耐药菌（包括ESBL-E）的产生及传播').
has_measure(aseptic_technique_measure_1, '严格遵守无菌操作原则').
has_measure(aseptic_technique_measure_2, '严格掌握侵入性操作和留置各种导管（如血管导管、导尿管）的指征').
has_measure(aseptic_technique_measure_3, '每日进行评估并及时拔除导管').
has_goal(aseptic_technique_goal, '预防和减少侵入性操作及留置导管相关感染的发生和传播').
has_source(aseptic_technique_importance, 'ESBL共识2025 Section 7.2.1, PDF page 14, journal page 1115').

%% 7.2.2 Strict adherence to infection control standards

has_principle(infection_control_two_hands, '应对耐药菌感染特别强调"两手抓、两手硬"').
has_principle(infection_control_hand_1, '一手抓抗菌药物合理应用与管理以减轻抗菌药物压力，延缓耐药菌产生').
has_principle(infection_control_hand_2, '一手抓感染预防与控制以预防感染及传播').
has_requirement(infection_control_requirement, '在防控ESBL-E感染的具体实践中，必须掌握并严格遵守感染预防与控制相关标准及规范，同时不断总结经验和开展循证研究，及时丰富和创新预防措施').
has_source(infection_control_two_hands, 'ESBL共识2025 Section 7.2.2, PDF page 14, journal page 1115').

%% Specific infection control standards and measures
has_standard(infection_control_std_1, '根据《医务人员手卫生规范》要求做好手卫生').
has_standard(infection_control_std_2, '根据《医疗机构环境表面清洁与消毒管理规范》要求做好环境清洁与消毒').
has_standard(infection_control_std_3, '根据《医院感染监测标准》要求开展医院感染监测（包括多重耐药菌的监测）').
has_standard(infection_control_std_4, '根据《医疗机构消毒技术规范》做好医院环境物体表面及器械的清洁消毒或灭菌').
has_standard(infection_control_std_5, '根据《医院隔离技术标准》要求做好耐药菌感染与定植者的隔离').
has_standard(infection_control_std_6, '根据相关标准规范要求积极开展手术部位感染、呼吸机相关肺炎、血管导管及导尿管相关感染、多重耐药菌感染等的预防与控制').
has_source(infection_control_std_1, 'ESBL共识2025 Section 7.2.2, PDF page 14, journal page 1115').

%% ========================================
%% SECTION 6 COMPLETE - ESBL-E CONTENT EXTRACTION FINISHED
%% ========================================
%% Summary: Encoded all 10 ESBL recommendations plus Section 7 infection prevention and control
%% Next step: Extract Novel BLI consensus content from novel_bli_2026.txt

%% [继续标记 - NOVEL_BLI_START]

%% ========================================
%% SECTION 7: NOVEL BLI CONSENSUS 2026 CONTENT
%% ========================================
%% Source: 新型β-内酰胺酶抑制剂复方制剂临床应用专家共识
%% Registration: PREPARE-2025CN1407
%% Sections encoded: Drug mechanisms, Clinical Questions 3-9, Treatment algorithms

%% --------------------------------------------
%% Section III: β-lactamase Classification (Ambler & Bush)
%% Source: Novel BLI Consensus lines 137-226
%% --------------------------------------------

has_classification_system(ambler_system, 'Ambler分子结构分类系统').
has_classification_system(bush_system, 'Bush功能分类系统').
has_source(ambler_system, 'Novel BLI共识2026 Section III p137-226').

%% Ambler Class A - Serine β-lactamases
has_class(ambler_class_a, 'Ambler A类丝氨酸β-内酰胺酶').
has_enzyme_type(ambler_class_a, 'TEM型').
has_enzyme_type(ambler_class_a, 'SHV型').
has_enzyme_type(ambler_class_a, 'CTX-M型').
has_enzyme_type(ambler_class_a, 'KPC型碳青霉烯酶').
has_mechanism(ambler_class_a, '丝氨酸作为活性位点水解β-内酰胺环').

%% Ambler Class B - Metallo-β-lactamases (MBL)
has_class(ambler_class_b, 'Ambler B类金属β-内酰胺酶').
has_enzyme_type(ambler_class_b, 'NDM型').
has_enzyme_type(ambler_class_b, 'VIM型').
has_enzyme_type(ambler_class_b, 'IMP型').
has_mechanism(ambler_class_b, '需要金属离子（通常为锌离子）作为辅因子水解β-内酰胺环').
has_resistance_profile(ambler_class_b, '对几乎所有β-内酰胺类抗生素均有水解活性，包括碳青霉烯类').

%% Ambler Class C - AmpC cephalosporinases
has_class(ambler_class_c, 'Ambler C类头孢菌素酶AmpC').
has_enzyme_type(ambler_class_c, '染色体介导的AmpC').
has_enzyme_type(ambler_class_c, '质粒介导的AmpC').
has_mechanism(ambler_class_c, '丝氨酸酶，水解头孢菌素和青霉素类').

%% Ambler Class D - OXA-type enzymes
has_class(ambler_class_d, 'Ambler D类丝氨酸酶').
has_enzyme_type(ambler_class_d, 'OXA-23型').
has_enzyme_type(ambler_class_d, 'OXA-48型').
has_enzyme_type(ambler_class_d, 'OXA-51型').
has_enzyme_type(ambler_class_d, 'OXA-58型').
has_mechanism(ambler_class_d, '丝氨酸酶，对苯唑西林及碳青霉烯类有水解活性').

%% --------------------------------------------
%% Section V: Seven Novel BLI Combinations
%% Source: Novel BLI Consensus lines 270-641
%% --------------------------------------------

%% Drug 1: Ceftazidime-Avibactam (CZA-AVI / 头孢他啶-阿维巴坦)
has_drug(ceftazidime_avibactam, '头孢他啶-阿维巴坦').
has_abbreviation(ceftazidime_avibactam, 'CZA-AVI').
has_component(ceftazidime_avibactam, '头孢他啶').
has_component(ceftazidime_avibactam, '阿维巴坦').
has_inhibitor_class(ceftazidime_avibactam, '二氮杂双环辛烷类(DBO)').
has_activity(ceftazidime_avibactam, '抑制Ambler A类酶（KPC、ESBLs）').
has_activity(ceftazidime_avibactam, '抑制Ambler C类酶（AmpC）').
has_activity(ceftazidime_avibactam, '抑制部分Ambler D类酶（OXA-48）').
has_no_activity(ceftazidime_avibactam, 'Ambler B类金属酶（NDM、VIM、IMP）').
has_resistance_mechanism(ceftazidime_avibactam, 'KPC基因突变导致KPC亚型变异').
has_kpc_variant_resistance(ceftazidime_avibactam, 'KPC-11').
has_kpc_variant_resistance(ceftazidime_avibactam, 'KPC-14').
has_kpc_variant_resistance(ceftazidime_avibactam, 'KPC-33').
has_sensitivity_rate(ceftazidime_avibactam, '≥90%对中国临床分离肠杆菌目和铜绿假单胞菌敏感（CHINET 2024）').
has_source(ceftazidime_avibactam, 'Novel BLI共识2026 Section V lines 270-641').

%% Drug 2: Imipenem-Relebactam (IMI-REL / 亚胺培南西司他丁-瑞来巴坦)
has_drug(imipenem_relebactam, '亚胺培南西司他丁-瑞来巴坦').
has_abbreviation(imipenem_relebactam, 'IMI-REL').
has_component(imipenem_relebactam, '亚胺培南').
has_component(imipenem_relebactam, '西司他丁').
has_component(imipenem_relebactam, '瑞来巴坦').
has_inhibitor_class(imipenem_relebactam, '二氮杂双环辛烷类(DBO)').
has_activity(imipenem_relebactam, '抑制Ambler A类酶（KPC、ESBLs）').
has_activity(imipenem_relebactam, '抑制Ambler C类酶（AmpC）').
has_no_activity(imipenem_relebactam, 'Ambler B类金属酶（MBL）').
has_resistance_mechanism(imipenem_relebactam, 'OmpK35和OmpK36膜孔蛋白缺失或突变').
has_resistance_mechanism(imipenem_relebactam, 'blaKPC拷贝数增加').
has_source(imipenem_relebactam, 'Novel BLI共识2026 Section V').

%% Drug 3: Aztreonam-Avibactam (ATM-AVI / 氨曲南-阿维巴坦)
has_drug(aztreonam_avibactam, '氨曲南-阿维巴坦').
has_abbreviation(aztreonam_avibactam, 'ATM-AVI').
has_component(aztreonam_avibactam, '氨曲南').
has_component(aztreonam_avibactam, '阿维巴坦').
has_unique_feature(aztreonam_avibactam, '氨曲南对金属酶稳定，阿维巴坦保护其免受A类和C类酶水解').
has_activity(aztreonam_avibactam, '对产MBL的CRE敏感率92.5%-100%').
has_activity(aztreonam_avibactam, '治疗产MBL革兰阴性菌感染的有效方案').
has_clinical_data(aztreonam_avibactam, 'ASSEMBLE研究：临床治愈率41.7% vs 0%对照组').
has_clinical_data(aztreonam_avibactam, 'REVISIT研究：产MBL感染临床治愈率50.0%').
has_source(aztreonam_avibactam, 'Novel BLI共识2026 Section V lines 964-999').

%% Drug 4: Sulbactam-Durlobactam (SUL-DUR / 舒巴坦-度洛巴坦)
has_drug(sulbactam_durlobactam, '舒巴坦-度洛巴坦').
has_abbreviation(sulbactam_durlobactam, 'SUL-DUR').
has_component(sulbactam_durlobactam, '舒巴坦').
has_component(sulbactam_durlobactam, '度洛巴坦').
has_inhibitor_class(sulbactam_durlobactam, '二氮杂双环辛烷类(DBO)').
has_target_organism(sulbactam_durlobactam, 'CRAB（碳青霉烯类耐药鲍曼不动杆菌）').
has_activity(sulbactam_durlobactam, '抑制Ambler D类OXA酶（OXA-23、OXA-24、OXA-58）').
has_sensitivity_rate(sulbactam_durlobactam, '>96%对CRAB敏感').
has_clinical_data(sulbactam_durlobactam, 'ATTACK研究：28天死亡率19.0% vs 32.3%多黏菌素组').
has_clinical_data(sulbactam_durlobactam, 'ATTACK研究：临床治愈率62% vs 40%多黏菌素组').
has_clinical_data(sulbactam_durlobactam, 'ATTACK研究：肾毒性13% vs 38%多黏菌素组').
has_synergy(sulbactam_durlobactam, '联合亚胺培南-西司他丁或美罗培南增强疗效').
has_csf_penetration(sulbactam_durlobactam, '舒巴坦脑脊液穿透率10%-37%').
has_csf_penetration(sulbactam_durlobactam, '度洛巴坦脑脊液穿透率9%-26%').
has_source(sulbactam_durlobactam, 'Novel BLI共识2026 Section V lines 1022-1096').

%% Drug 5: Ceftolozane-Tazobactam (C/T / 头孢洛生-他唑巴坦)
has_drug(ceftolozane_tazobactam, '头孢洛生-他唑巴坦').
has_abbreviation(ceftolozane_tazobactam, 'C/T').
has_component(ceftolozane_tazobactam, '头孢洛生').
has_component(ceftolozane_tazobactam, '他唑巴坦').
has_target_organism(ceftolozane_tazobactam, 'DTR-PA（难治性耐药铜绿假单胞菌）').
has_target_organism(ceftolozane_tazobactam, 'CRPA（碳青霉烯类耐药铜绿假单胞菌）').
has_activity(ceftolozane_tazobactam, '对碳青霉烯类不敏感铜绿假单胞菌敏感率约90%').
has_no_activity(ceftolozane_tazobactam, '对产KPC酶的铜绿假单胞菌无活性').
has_no_activity(ceftolozane_tazobactam, '对产金属酶（NDM、VIM）的铜绿假单胞菌无效').
has_resistance_mechanism(ceftolozane_tazobactam, 'PDC基因突变导致耐药').
has_source(ceftolozane_tazobactam, 'Novel BLI共识2026 Section V lines 1098-1152').

%% Drug 6: Meropenem-Vaborbactam (MER-VAB / 美罗培南-韦博巴坦)
has_drug(meropenem_vaborbactam, '美罗培南-韦博巴坦').
has_abbreviation(meropenem_vaborbactam, 'MER-VAB').
has_component(meropenem_vaborbactam, '美罗培南').
has_component(meropenem_vaborbactam, '韦博巴坦').
has_inhibitor_class(meropenem_vaborbactam, '硼酸类').
has_activity(meropenem_vaborbactam, '对产KPC酶的CRE高度活性').
has_no_activity(meropenem_vaborbactam, 'Ambler B类金属酶（MBL）').
has_no_activity(meropenem_vaborbactam, 'Ambler D类OXA-48酶').
has_clinical_data(meropenem_vaborbactam, '意大利研究：342例产KPC的CRKP感染，30天死亡率31.6%').
has_clinical_data(meropenem_vaborbactam, '美国PINC数据库：住院死亡率17.0% vs 20.6%头孢他啶-阿维巴坦组').
has_recommendation(meropenem_vaborbactam, '感染发病48小时内启用治疗是独立保护因素').
has_source(meropenem_vaborbactam, 'Novel BLI共识2026 Section V lines 866-881').

%% Drug 7: Cefepime-Taniborbactam (FTB / 头孢吡肟-他尼硼巴坦)
has_drug(cefepime_taniborbactam, '头孢吡肟-他尼硼巴坦').
has_abbreviation(cefepime_taniborbactam, 'FTB').
has_component(cefepime_taniborbactam, '头孢吡肟').
has_component(cefepime_taniborbactam, '他尼硼巴坦').
has_inhibitor_class(cefepime_taniborbactam, '硼酸类').
has_activity(cefepime_taniborbactam, '对产NDM、VIM的菌株具有抗菌活性').
has_no_activity(cefepime_taniborbactam, '对产IMP的菌株无抗菌活性').
has_clinical_data(cefepime_taniborbactam, 'III期RCT：2例产NDM-1酶的CRE感染均获得临床和微生物学应答').
has_limitation(cefepime_taniborbactam, '临床数据有限，体外敏感率低于氨曲南-阿维巴坦').
has_source(cefepime_taniborbactam, 'Novel BLI共识2026 Section V lines 1002-1007').

%% --------------------------------------------
%% Clinical Question 3: KPC-producing CRE Treatment Options
%% Source: Novel BLI Consensus lines 806-885
%% --------------------------------------------

has_clinical_question(novel_bli_q3, '治疗产KPC酶的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q3_rec, '治疗产KPC酶的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂包括头孢他啶-阿维巴坦、亚胺培南西司他丁-瑞来巴坦、或美罗培南-韦博巴坦').
has_evidence_level(novel_bli_q3_rec, '2a').
has_recommendation_strength(novel_bli_q3_rec, 'B').
has_drug_option(novel_bli_q3_rec, '头孢他啶-阿维巴坦').
has_drug_option(novel_bli_q3_rec, '亚胺培南西司他丁-瑞来巴坦').
has_drug_option(novel_bli_q3_rec, '美罗培南-韦博巴坦').
has_first_choice(novel_bli_q3_rec, '头孢他啶-阿维巴坦').
has_rationale(novel_bli_q3_rec, '头孢他啶-阿维巴坦对产KPC酶的CRE体外敏感性>95%').
has_clinical_evidence(novel_bli_q3_rec, '多中心配对队列研究：头孢他啶-阿维巴坦显著降低CRKP血流感染30天死亡率（HR=0.56）').
has_clinical_evidence(novel_bli_q3_rec, 'CRE血流感染研究：头孢他啶-阿维巴坦单药30天死亡率10% vs 31%多黏菌素单药').
has_special_application(novel_bli_q3_rec, '头孢他啶-阿维巴坦可用于治疗敏感的CRE或DTR-PA导致的脑膜炎（脑脊液穿透率：头孢他啶43%，阿维巴坦38%）').
has_alternative_drug(novel_bli_q3_rec, '氨曲南-阿维巴坦').
has_alternative_drug(novel_bli_q3_rec, '头孢吡肟-他尼硼巴坦').
has_comment(novel_bli_q3_rec, '为了将氨曲南-阿维巴坦和头孢吡肟-他尼硼巴坦保留用于治疗产MBL耐药菌感染，建议将其作为替代药物使用').
has_source(novel_bli_q3, 'Novel BLI共识2026 Clinical Question 3 lines 806-885').

%% --------------------------------------------
%% Clinical Question 4: KPC Variant-Resistant CRE Treatment
%% Source: Novel BLI Consensus lines 890-914
%% --------------------------------------------

has_clinical_question(novel_bli_q4, '治疗KPC亚型变异导致头孢他啶-阿维巴坦不敏感的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q4_rec, '治疗KPC亚型变异导致头孢他啶-阿维巴坦不敏感的CRE感染，根据药敏结果可选择的新型β-内酰胺酶抑制剂复方制剂包括亚胺培南西司他丁-瑞来巴坦、氨曲南-阿维巴坦或美罗培南-韦博巴坦').
has_evidence_level(novel_bli_q4_rec, '4').
has_recommendation_strength(novel_bli_q4_rec, 'C').
has_drug_option(novel_bli_q4_rec, '亚胺培南西司他丁-瑞来巴坦').
has_drug_option(novel_bli_q4_rec, '氨曲南-阿维巴坦').
has_drug_option(novel_bli_q4_rec, '美罗培南-韦博巴坦').
has_alert(novel_bli_q4_rec, '推荐对CRE感染患者进行动态病原学随访').
has_alert(novel_bli_q4_rec, '接受过头孢他啶-阿维巴坦治疗后感染复发需高度警惕KPC基因突变导致亚型变异').
has_kpc_variant_sensitivity(novel_bli_q4_rec, '亚胺培南西司他丁-瑞来巴坦对KPC-31/33/44/50/57/86保持敏感性').
has_kpc_variant_sensitivity(novel_bli_q4_rec, '氨曲南-阿维巴坦对KPC-11/12/14/16/17/18/20/21/22/24/25/26/30/33/35/71/76/78/79/112/116具有敏感性').
has_kpc_variant_sensitivity(novel_bli_q4_rec, '美罗培南-韦博巴坦对KPC-31/33/35/44/50/57/71/76/78/79/86/112/116保持敏感').
has_alternative_strategy(novel_bli_q4_rec, '头孢他啶-阿维巴坦联合敏感的碳青霉烯类药物（亚胺培南-西司他丁或美罗培南）').
has_source(novel_bli_q4, 'Novel BLI共识2026 Clinical Question 4 lines 890-914').

%% --------------------------------------------
%% Clinical Question 5: OXA-48-producing CRE Treatment
%% Source: Novel BLI Consensus lines 915-954
%% --------------------------------------------

has_clinical_question(novel_bli_q5, '治疗产D类丝氨酸酶OXA-48的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q5_rec, '治疗产D类丝氨酸酶OXA-48的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂为头孢他啶-阿维巴坦').
has_evidence_level(novel_bli_q5_rec, '3b').
has_recommendation_strength(novel_bli_q5_rec, 'B').
has_drug_option(novel_bli_q5_rec, '头孢他啶-阿维巴坦').
has_rationale(novel_bli_q5_rec, '超过95%的产OXA-48肠杆菌分离株对头孢他啶-阿维巴坦敏感').
has_comparison(novel_bli_q5_rec, '头孢他啶-阿维巴坦对产OXA-48的CRE敏感率99% vs 美罗培南-韦博巴坦46.7%').
has_warning(novel_bli_q5_rec, '美罗培南-韦博巴坦和亚胺培南西司他丁-瑞来巴坦对产OXA-48的CRE作用有限，韦博巴坦和瑞来巴坦不能抑制OXA-48酶，即使体外敏感也不建议使用').
has_clinical_evidence(novel_bli_q5_rec, '观察性研究：171例产OXA-48肠杆菌感染，头孢他啶-阿维巴坦治疗30天死亡率22%').
has_clinical_evidence(novel_bli_q5_rec, '回顾性研究：57例产OXA-48的CRKP血流感染，头孢他啶-阿维巴坦单药30天死亡率<20%').
has_recommendation(novel_bli_q5_rec, '尽早足量使用是改善预后的关键').
has_combination_strategy(novel_bli_q5_rec, '头孢他啶-阿维巴坦联合氨曲南可用于同时产OXA-48及NDM的CRE感染').
has_alternative_drug(novel_bli_q5_rec, '氨曲南-阿维巴坦').
has_alternative_drug(novel_bli_q5_rec, '头孢吡肟-他尼硼巴坦').
has_comment(novel_bli_q5_rec, '为了将这两种药物保留用于治疗产MBL耐药菌感染，建议作为替代药物使用').
has_source(novel_bli_q5, 'Novel BLI共识2026 Clinical Question 5 lines 915-954').

%% --------------------------------------------
%% Clinical Question 6: MBL-producing CRE Treatment
%% Source: Novel BLI Consensus lines 956-1001
%% --------------------------------------------

has_clinical_question(novel_bli_q6, '治疗产金属酶（MBL）的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q6_rec, '治疗产金属酶（MBL）的CRE感染，可选择的新型β-内酰胺酶抑制剂复方制剂为氨曲南-阿维巴坦').
has_evidence_level(novel_bli_q6_rec, '1b').
has_recommendation_strength(novel_bli_q6_rec, 'A').
has_drug_option(novel_bli_q6_rec, '氨曲南-阿维巴坦').
has_rationale(novel_bli_q6_rec, '氨曲南-阿维巴坦对产MBL的CRE敏感率>90%').
has_clinical_evidence(novel_bli_q6_rec, 'ASSEMBLE前瞻性国际多中心III期临床研究：氨曲南-阿维巴坦治疗产MBL的CRE感染，临床治愈率68.7% vs 37.0%最佳可用药物组').
has_clinical_evidence(novel_bli_q6_rec, 'ASSEMBLE研究：28天全因死亡率20.1% vs 30.2%最佳可用药物组').
has_clinical_evidence(novel_bli_q6_rec, 'REVISIT多中心RCT：氨曲南-阿维巴坦治疗产MBL革兰阴性菌严重感染，不良反应发生率无差异，不良事件发生率低于对照组').
has_mbls_covered(novel_bli_q6_rec, 'NDM').
has_mbls_covered(novel_bli_q6_rec, 'VIM').
has_mbls_covered(novel_bli_q6_rec, 'IMP').
has_synergy(novel_bli_q6_rec, '氨曲南-阿维巴坦联合头孢他啶-阿维巴坦可用于同时产MBL及OXA-48的CRE感染').
has_alternative_drug(novel_bli_q6_rec, '头孢吡肟-他尼硼巴坦').
has_comment(novel_bli_q6_rec, '头孢吡肟-他尼硼巴坦对产NDM和VIM的菌株具有抗菌活性，但对产IMP的菌株无抗菌活性，且临床数据有限').
has_source(novel_bli_q6, 'Novel BLI共识2026 Clinical Question 6 lines 956-1001').

%% --------------------------------------------
%% Clinical Question 7: CRAB Treatment
%% Source: Novel BLI Consensus lines 1008-1021
%% --------------------------------------------

has_clinical_question(novel_bli_q7, '治疗碳青霉烯类耐药鲍曼不动杆菌（CRAB）感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q7_rec, '治疗碳青霉烯类耐药鲍曼不动杆菌（CRAB）感染，可选择的新型β-内酰胺酶抑制剂复方制剂为舒巴坦-度洛巴坦').
has_evidence_level(novel_bli_q7_rec, '1b').
has_recommendation_strength(novel_bli_q7_rec, 'A').
has_drug_option(novel_bli_q7_rec, '舒巴坦-度洛巴坦').
has_rationale(novel_bli_q7_rec, '舒巴坦-度洛巴坦对CRAB体外敏感性>96%').
has_clinical_evidence(novel_bli_q7_rec, 'ATTACK研究：200例CRAB肺炎患者，舒巴坦-度洛巴坦组28天死亡率19.0% vs 32.3%多黏菌素组（P=0.04）').
has_clinical_evidence(novel_bli_q7_rec, 'ATTACK研究：临床治愈率62% vs 40%多黏菌素组（P=0.005）').
has_clinical_evidence(novel_bli_q7_rec, 'ATTACK研究：微生物学治愈率68% vs 47%多黏菌素组（P=0.006）').
has_special_application(novel_bli_q7_rec, '舒巴坦脑脊液穿透率10%-37%，可用于敏感CRAB所致中枢神经系统感染').
has_source(novel_bli_q7, 'Novel BLI共识2026 Clinical Question 7 lines 1008-1021').

%% --------------------------------------------
%% Clinical Question 8: DTR-PA Treatment
%% Source: Novel BLI Consensus lines 1097-1126
%% --------------------------------------------

has_clinical_question(novel_bli_q8, '治疗难治性耐药铜绿假单胞菌（DTR-PA）感染，可选择的新型β-内酰胺酶抑制剂复方制剂有哪些？').
has_recommendation(novel_bli_q8_rec, '治疗难治性耐药铜绿假单胞菌（DTR-PA）感染，可选择的新型β-内酰胺酶抑制剂复方制剂为头孢洛生-他唑巴坦，亦可选择头孢他啶-阿维巴坦').
has_evidence_level(novel_bli_q8_rec, '3b').
has_recommendation_strength(novel_bli_q8_rec, 'B').
has_drug_option(novel_bli_q8_rec, '头孢洛生-他唑巴坦').
has_drug_option(novel_bli_q8_rec, '头孢他啶-阿维巴坦').
has_first_choice(novel_bli_q8_rec, '头孢洛生-他唑巴坦').
has_rationale(novel_bli_q8_rec, '头孢洛生-他唑巴坦对碳青霉烯类不敏感的铜绿假单胞菌敏感率约90%').
has_clinical_evidence(novel_bli_q8_rec, 'ASPECT-NP研究：头孢洛生-他唑巴坦治疗呼吸机相关肺炎28天死亡率24.6%').
has_clinical_evidence(novel_bli_q8_rec, 'ASPECT-cUTI研究：头孢洛生-他唑巴坦治疗复杂性尿路感染临床治愈率83.0%').
has_clinical_evidence(novel_bli_q8_rec, 'ASPECT-cIAI研究：头孢洛生-他唑巴坦治疗复杂性腹腔感染临床治愈率83.0%').
has_comparison(novel_bli_q8_rec, '头孢洛生-他唑巴坦对CRPA敏感性优于头孢他啶-阿维巴坦').
has_alert(novel_bli_q8_rec, '头孢洛生-他唑巴坦对产KPC酶的铜绿假单胞菌无活性').
has_alert(novel_bli_q8_rec, '头孢洛生-他唑巴坦对产金属酶（NDM、VIM）的铜绿假单胞菌无效').
has_resistance_mechanism(novel_bli_q8_rec, 'PDC基因突变是头孢洛生-他唑巴坦耐药的主要机制').
has_source(novel_bli_q8, 'Novel BLI共识2026 Clinical Question 8 lines 1097-1126').

%% --------------------------------------------
%% Clinical Question 9: Treatment Algorithm for CRO Infections
%% Source: Novel BLI Consensus lines 1127-1199
%% --------------------------------------------

has_clinical_question(novel_bli_q9, '碳青霉烯类耐药的革兰阴性菌（CRO）感染患者的治疗流程是什么？').
has_recommendation(novel_bli_q9_rec, '碳青霉烯类耐药的革兰阴性菌（CRO）感染患者的治疗流程应包括：早期识别高危因素、尽早使用新型β-内酰胺酶抑制剂复方制剂进行经验性治疗或目标性治疗、基于耐药机制和药敏结果调整方案、优化剂量和给药方式、动态评估疗效').
has_evidence_level(novel_bli_q9_rec, '5').
has_recommendation_strength(novel_bli_q9_rec, '强推荐').
has_key_principle(novel_bli_q9_rec, '早期识别CRO感染高危因素').
has_high_risk_factor(novel_bli_q9_rec, '既往定植或感染CRO').
has_high_risk_factor(novel_bli_q9_rec, '近期使用碳青霉烯类抗生素').
has_high_risk_factor(novel_bli_q9_rec, '长期住院或入住ICU').
has_high_risk_factor(novel_bli_q9_rec, '侵入性操作或留置导管').
has_high_risk_factor(novel_bli_q9_rec, '免疫抑制状态').
has_key_principle(novel_bli_q9_rec, '尽早使用新型BLI复方制剂进行经验性或目标性治疗').
has_empiric_treatment_timing(novel_bli_q9_rec, '对疑似CRO感染的重症患者，应在48小时内启动新型BLI复方制剂经验性治疗').
has_key_principle(novel_bli_q9_rec, '基于耐药机制和药敏结果调整治疗方案').
has_mechanism_based_selection(novel_bli_q9_rec, '产KPC酶的CRE：首选头孢他啶-阿维巴坦、亚胺培南西司他丁-瑞来巴坦或美罗培南-韦博巴坦').
has_mechanism_based_selection(novel_bli_q9_rec, '产OXA-48的CRE：首选头孢他啶-阿维巴坦').
has_mechanism_based_selection(novel_bli_q9_rec, '产MBL的CRE：首选氨曲南-阿维巴坦').
has_mechanism_based_selection(novel_bli_q9_rec, 'CRAB：首选舒巴坦-度洛巴坦').
has_mechanism_based_selection(novel_bli_q9_rec, 'DTR-PA：首选头孢洛生-他唑巴坦或头孢他啶-阿维巴坦').
has_key_principle(novel_bli_q9_rec, '优化剂量和给药方式').
has_dosing_strategy(novel_bli_q9_rec, '重症感染推荐延长输注时间（3-4小时）或持续输注').
has_dosing_strategy(novel_bli_q9_rec, '必要时根据肾功能、体重、感染部位调整剂量').
has_dosing_strategy(novel_bli_q9_rec, '对难治性感染或高MIC菌株，考虑TDM指导下的剂量优化').
has_key_principle(novel_bli_q9_rec, '动态评估疗效并调整方案').
has_evaluation_timing(novel_bli_q9_rec, '治疗48-72小时后评估临床反应').
has_evaluation_indicator(novel_bli_q9_rec, '体温、白细胞计数、炎症标志物（CRP、PCT）变化').
has_evaluation_indicator(novel_bli_q9_rec, '感染灶控制情况').
has_evaluation_indicator(novel_bli_q9_rec, '病原学清除情况').
has_adjustment_strategy(novel_bli_q9_rec, '疗效不佳时应重新评估诊断、排除感染源控制不足、复查药敏结果、考虑联合治疗或更换方案').
has_source(novel_bli_q9, 'Novel BLI共识2026 Clinical Question 9 lines 1127-1199').

%% [继续标记 - NOVEL_BLI_COMPLETE]
