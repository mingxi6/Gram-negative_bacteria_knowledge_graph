% ==============================================
% Modules: 1. Taxonomy Ontology 2. Cell Structure Composition 3. Pathogenesis & Host Interaction
%          4. Drug-Bacteria Interaction 5. Antibacterial Drug Core Structures 6. Phenotypic Differences Between Species
% References: Medical Microbiology (9th ed.), International Committee on Systematics of Prokaryotes,
%             Guiding Principles for Clinical Application of Antibacterial Drugs,
%             Consensus on Diagnosis and Treatment of Multidrug-Resistant Gram-Negative Bacterial Infections
% ==============================================
% Module 1: Taxonomy Ontology (Global Unique Classification System)
% Contains: Bacterial taxonomic hierarchy | Clinical functional classification of bacteria | Antibacterial drug classification system
% ------------------------------
% 1.1 Bacterial Taxonomic Hierarchy (direct_is_a/2: direct subsumption)
% Levels: Prokaryotes -> Phylum -> Class -> Order -> Family -> Genus -> Species
% ------------------------------
% Top-level classification
direct_is_a(gram_negative_bacteria, prokaryotes).

% Phylum level
direct_is_a(proteobacteria, gram_negative_bacteria).
direct_is_a(bacteroidetes, gram_negative_bacteria).
direct_is_a(fusobacteria, gram_negative_bacteria).
direct_is_a(spirochaetes, gram_negative_bacteria).
direct_is_a(chlamydiae, gram_negative_bacteria).

% Proteobacteria -> Class level
direct_is_a(alphaproteobacteria, proteobacteria).
direct_is_a(betaproteobacteria, proteobacteria).
direct_is_a(gammaproteobacteria, proteobacteria).
direct_is_a(epsilonproteobacteria, proteobacteria).

% Gammaproteobacteria -> Order level
direct_is_a(enterobacterales, gammaproteobacteria).
direct_is_a(pseudomonadales, gammaproteobacteria).
direct_is_a(vibrionales, gammaproteobacteria).
direct_is_a(pasteurellales, gammaproteobacteria).
direct_is_a(legionellales, gammaproteobacteria).
direct_is_a(xanthomonadales, gammaproteobacteria).
direct_is_a(aeromonadales, gammaproteobacteria).

% Enterobacterales -> Enterobacteriaceae -> Genus -> Species
direct_is_a(enterobacteriaceae, enterobacterales).
direct_is_a(escherichia, enterobacteriaceae).
direct_is_a(klebsiella, enterobacteriaceae).
direct_is_a(enterobacter, enterobacteriaceae).
direct_is_a(serratia, enterobacteriaceae).
direct_is_a(proteus, enterobacteriaceae).
direct_is_a(salmonella, enterobacteriaceae).
direct_is_a(shigella, enterobacteriaceae).
direct_is_a(citrobacter, enterobacteriaceae).
direct_is_a(morganella, enterobacteriaceae).
direct_is_a(providencia, enterobacteriaceae).
direct_is_a(yersinia, enterobacteriaceae).
direct_is_a(escherichia_coli, escherichia).
direct_is_a(klebsiella_pneumoniae, klebsiella).
direct_is_a(klebsiella_oxytoca, klebsiella).
direct_is_a(klebsiella_aerogenes, klebsiella).
taxonomic_synonym(enterobacter_aerogenes, klebsiella_aerogenes).
direct_is_a(enterobacter_cloacae, enterobacter).
direct_is_a(serratia_marcescens, serratia).
direct_is_a(proteus_mirabilis, proteus).
direct_is_a(proteus_vulgaris, proteus).
direct_is_a(salmonella_typhi, salmonella).
direct_is_a(salmonella_typhimurium, salmonella).
direct_is_a(shigella_dysenteriae, shigella).
direct_is_a(shigella_flexneri, shigella).
direct_is_a(shigella_sonnei, shigella).
direct_is_a(yersinia_pestis, yersinia).
direct_is_a(yersinia_enterocolitica, yersinia).
direct_is_a(citrobacter_freundii, citrobacter).
direct_is_a(morganella_morganii, morganella).
direct_is_a(providencia_alcalifaciens, providencia).

% Pseudomonadales -> Family -> Genus -> Species
direct_is_a(pseudomonadaceae, pseudomonadales).
direct_is_a(moraxellaceae, pseudomonadales).

direct_is_a(pseudomonas, pseudomonadaceae).
direct_is_a(acinetobacter, moraxellaceae).
direct_is_a(moraxella, moraxellaceae).

direct_is_a(pseudomonas_aeruginosa, pseudomonas).
direct_is_a(pseudomonas_fluorescens, pseudomonas).
direct_is_a(acinetobacter_baumannii, acinetobacter).
direct_is_a(acinetobacter_calcoaceticus, acinetobacter).
direct_is_a(moraxella_catarrhalis, moraxella).

% Xanthomonadales -> Family -> Genus -> Species (corrected: Stenotrophomonas belongs here)
direct_is_a(xanthomonadaceae, xanthomonadales).
direct_is_a(stenotrophomonas, xanthomonadaceae).
direct_is_a(stenotrophomonas_maltophilia, stenotrophomonas).

% Aeromonadales -> Family -> Genus -> Species (corrected: separate order from Vibrionales)
direct_is_a(aeromonadaceae, aeromonadales).
direct_is_a(aeromonas, aeromonadaceae).
direct_is_a(aeromonas_hydrophila, aeromonas).

% Vibrionales -> Family -> Genus -> Species
direct_is_a(vibrionaceae, vibrionales).
direct_is_a(vibrio, vibrionaceae).

direct_is_a(vibrio_cholerae, vibrio).
direct_is_a(vibrio_parahaemolyticus, vibrio).

% Pasteurellales -> Family -> Genus -> Species
direct_is_a(pasteurellaceae, pasteurellales).
direct_is_a(haemophilus, pasteurellaceae).
direct_is_a(pasteurella, pasteurellaceae).

direct_is_a(haemophilus_influenzae, haemophilus).
direct_is_a(pasteurella_multocida, pasteurella).

% Legionellales -> Family -> Genus -> Species
direct_is_a(legionellaceae, legionellales).
direct_is_a(legionella, legionellaceae).
direct_is_a(legionella_pneumophila, legionella).

% Betaproteobacteria -> Order/Family/Genus/Species
direct_is_a(neisseriales, betaproteobacteria).
direct_is_a(burkholderiales, betaproteobacteria).
direct_is_a(neisseriaceae, neisseriales).
direct_is_a(burkholderiaceae, burkholderiales).
direct_is_a(alcaligenaceae, burkholderiales).
direct_is_a(neisseria, neisseriaceae).
direct_is_a(burkholderia, burkholderiaceae).
direct_is_a(bordetella, alcaligenaceae).
direct_is_a(alcaligenes, alcaligenaceae).

direct_is_a(neisseria_meningitidis, neisseria).
direct_is_a(neisseria_gonorrhoeae, neisseria).
direct_is_a(burkholderia_cepacia_complex, burkholderia).
direct_is_a(bordetella_pertussis, bordetella).
direct_is_a(alcaligenes_faecalis, alcaligenes).

% Alphaproteobacteria -> Order/Family/Genus/Species
direct_is_a(rickettsiales, alphaproteobacteria).
direct_is_a(rhizobiales, alphaproteobacteria).
direct_is_a(rickettsiaceae, rickettsiales).
direct_is_a(orientiaceae, rickettsiales).
direct_is_a(brucellaceae, rhizobiales).
direct_is_a(rickettsia, rickettsiaceae).
direct_is_a(orientia, orientiaceae).
direct_is_a(brucella, brucellaceae).

direct_is_a(rickettsia_prowazekii, rickettsia).
direct_is_a(orientia_tsutsugamushi, orientia).
direct_is_a(brucella_melitensis, brucella).

% Epsilonproteobacteria -> Order/Family/Genus/Species
direct_is_a(campylobacterales, epsilonproteobacteria).
direct_is_a(helicobacteraceae, campylobacterales).
direct_is_a(campylobacteraceae, campylobacterales).
direct_is_a(helicobacter, helicobacteraceae).
direct_is_a(campylobacter, campylobacteraceae).

direct_is_a(helicobacter_pylori, helicobacter).
direct_is_a(campylobacter_jejuni, campylobacter).

% Bacteroidetes
direct_is_a(bacteroidia, bacteroidetes).
direct_is_a(bacteroidales, bacteroidia).
direct_is_a(bacteroidaceae, bacteroidales).
direct_is_a(prevotellaceae, bacteroidales).
direct_is_a(porphyromonadaceae, bacteroidales).
direct_is_a(bacteroides, bacteroidaceae).
direct_is_a(prevotella, prevotellaceae).
direct_is_a(porphyromonas, porphyromonadaceae).

direct_is_a(bacteroides_fragilis, bacteroides).
direct_is_a(prevotella_intermedia, prevotella).
direct_is_a(porphyromonas_gingivalis, porphyromonas).

% Fusobacteria
direct_is_a(fusobacteriia, fusobacteria).
direct_is_a(fusobacteriales, fusobacteriia).
direct_is_a(fusobacteriaceae, fusobacteriales).
direct_is_a(fusobacterium, fusobacteriaceae).

direct_is_a(fusobacterium_nucleatum, fusobacterium).
direct_is_a(fusobacterium_necrophorum, fusobacterium).

% Spirochaetes
direct_is_a(spirochaetia, spirochaetes).
direct_is_a(spirochaetales, spirochaetia).
direct_is_a(spirochaetaceae, spirochaetales).
direct_is_a(leptospiraceae, spirochaetales).
direct_is_a(treponema, spirochaetaceae).
direct_is_a(borrelia, spirochaetaceae).
direct_is_a(leptospira, leptospiraceae).

direct_is_a(treponema_pallidum, treponema).
direct_is_a(borrelia_burgdorferi, borrelia).
direct_is_a(leptospira_interrogans, leptospira).

% Chlamydiae
direct_is_a(chlamydiae_class, chlamydiae).
direct_is_a(chlamydiales, chlamydiae_class).
direct_is_a(chlamydiaceae, chlamydiales).
direct_is_a(chlamydia, chlamydiaceae).

direct_is_a(chlamydia_trachomatis, chlamydia).
direct_is_a(chlamydia_pneumoniae, chlamydia).

% ------------------------------
% 1.2 Clinical Functional Classification of Bacteria (non-strict taxonomy, for clinical scenario reasoning)
% ------------------------------
% By morphology
direct_is_a(gram_negative_cocci, gram_negative_bacteria).
direct_is_a(gram_negative_rods, gram_negative_bacteria).
direct_is_a(spiral_forms, gram_negative_bacteria).
direct_is_a(neisseria, gram_negative_cocci).
direct_is_a(moraxella, gram_negative_cocci).
direct_is_a(enterobacteriaceae, gram_negative_rods).
direct_is_a(pseudomonas, gram_negative_rods).
direct_is_a(acinetobacter, gram_negative_rods).
direct_is_a(bacteroides, gram_negative_rods).
direct_is_a(treponema, spiral_forms).
direct_is_a(leptospira, spiral_forms).
direct_is_a(borrelia, spiral_forms).

% By oxygen requirement
direct_is_a(aerobic_gram_negative, gram_negative_bacteria).
direct_is_a(facultative_anaerobic_gn, gram_negative_bacteria).
direct_is_a(anaerobic_gram_negative, gram_negative_bacteria).
direct_is_a(microaerophilic_gn, gram_negative_bacteria).
direct_is_a(pseudomonas, aerobic_gram_negative).
direct_is_a(acinetobacter, aerobic_gram_negative).
direct_is_a(legionella, aerobic_gram_negative).
direct_is_a(enterobacteriaceae, facultative_anaerobic_gn).
direct_is_a(vibrio, facultative_anaerobic_gn).
direct_is_a(bacteroides, anaerobic_gram_negative).
direct_is_a(fusobacterium, anaerobic_gram_negative).
direct_is_a(prevotella, anaerobic_gram_negative).
direct_is_a(helicobacter, microaerophilic_gn).
direct_is_a(campylobacter, microaerophilic_gn).

% Common clinical: Non-fermentative Gram-negative rods
direct_is_a(non_fermentative_gn_rods, gram_negative_rods).
direct_is_a(pseudomonas, non_fermentative_gn_rods).
direct_is_a(acinetobacter, non_fermentative_gn_rods).
direct_is_a(burkholderia, non_fermentative_gn_rods).
direct_is_a(stenotrophomonas, non_fermentative_gn_rods).

% Common clinical: Fastidious Gram-negative bacteria
direct_is_a(fastidious_gram_negative, gram_negative_bacteria).
direct_is_a(haemophilus, fastidious_gram_negative).
direct_is_a(legionella, fastidious_gram_negative).
direct_is_a(bordetella, fastidious_gram_negative).
direct_is_a(neisseria, fastidious_gram_negative).

% Clinical resistance phenotype classification
direct_is_a(carbapenem_resistant_enterobacteriaceae, enterobacteriaceae).
direct_is_a(mdr_pseudomonas_aeruginosa, pseudomonas_aeruginosa).
direct_is_a(carbapenem_resistant_acinetobacter, acinetobacter_baumannii).

% ------------------------------
% 1.3 Antibacterial Drug Classification System
% ------------------------------
direct_is_a(antibacterial_agents, drug_category).

% Beta-Lactam major class
direct_is_a(beta_lactam_antibiotics, antibacterial_agents).
direct_is_a(penicillins, beta_lactam_antibiotics).
direct_is_a(cephalosporins, beta_lactam_antibiotics).
direct_is_a(carbapenems, beta_lactam_antibiotics).
direct_is_a(monobactams, beta_lactam_antibiotics).
direct_is_a(cephamycins, beta_lactam_antibiotics).
direct_is_a(beta_lactamase_inhibitors, antibacterial_agents).

direct_is_a(antipseudomonal_penicillins, penicillins).
direct_is_a(first_generation_cephalosporins, cephalosporins).
direct_is_a(second_generation_cephalosporins, cephalosporins).
direct_is_a(third_generation_cephalosporins, cephalosporins).
direct_is_a(fourth_generation_cephalosporins, cephalosporins).

direct_is_a(meropenem, carbapenems).
direct_is_a(imipenem, carbapenems).
direct_is_a(ertapenem, carbapenems).
direct_is_a(ceftriaxone, third_generation_cephalosporins).
direct_is_a(ceftazidime, third_generation_cephalosporins).
direct_is_a(cefepime, fourth_generation_cephalosporins).
direct_is_a(aztreonam, monobactams).
direct_is_a(clavulanic_acid, beta_lactamase_inhibitors).
direct_is_a(sulbactam, beta_lactamase_inhibitors).
direct_is_a(tazobactam, beta_lactamase_inhibitors).
direct_is_a(amoxicillin, penicillins).
direct_is_a(piperacillin, antipseudomonal_penicillins).
direct_is_a(benzathine_penicillin_g, penicillins).

% Other major antibacterial drug classes
direct_is_a(fluoroquinolones, antibacterial_agents).
direct_is_a(aminoglycosides, antibacterial_agents).
direct_is_a(tetracyclines, antibacterial_agents).
direct_is_a(polymyxins, antibacterial_agents).
direct_is_a(sulfonamides, antibacterial_agents).
direct_is_a(nitroimidazoles, antibacterial_agents).
direct_is_a(glycopeptides, antibacterial_agents).
direct_is_a(macrolides, antibacterial_agents).
direct_is_a(lincosamides, antibacterial_agents).
direct_is_a(oxazolidinones, antibacterial_agents).
direct_is_a(chloramphenicol_class, antibacterial_agents).
direct_is_a(daptomycin, antibacterial_agents).
direct_is_a(tigecycline, tetracyclines).
direct_is_a(levofloxacin, fluoroquinolones).
direct_is_a(ciprofloxacin, fluoroquinolones).
direct_is_a(moxifloxacin, fluoroquinolones).
direct_is_a(gentamicin, aminoglycosides).
direct_is_a(amikacin, aminoglycosides).
direct_is_a(doxycycline, tetracyclines).
direct_is_a(colistin, polymyxins).
direct_is_a(polymyxin_b, polymyxins).
direct_is_a(trimethoprim_sulfamethoxazole, sulfonamides).
direct_is_a(metronidazole, nitroimidazoles).
direct_is_a(clarithromycin, macrolides).
direct_is_a(azithromycin, macrolides).
direct_is_a(clindamycin, lincosamides).
direct_is_a(bismuth_preparations, antibacterial_agents).
direct_is_a(cefiderocol, cephalosporins).

% ------------------------------
% 1.4 Global Unified Taxonomic Inference Rules (unique is_a definition)
% ------------------------------
% Direct subsumption counts as is_a
is_a(X, Y) :-
    direct_is_a(X, Y).

% Transitive closure: multi-level indirect subsumption inheritance
is_a(X, Z) :-
    direct_is_a(X, Y),
    is_a(Y, Z),
    X \= Y,
    Y \= Z.

% Taxonomy-specific query utilities
all_ancestors(X, AncestorList) :-
    findall(A, is_a(X, A), AncestorList).
all_direct_children(Parent, ChildList) :-
    findall(C, direct_is_a(C, Parent), ChildList).
all_descendants(Parent, DescendantList) :-
    findall(D, is_a(D, Parent), DescendantList).

% ==============================================
% Module 2: Cell Structure Composition Relations
% Layers: Shared core structures -> Group-specific structures -> Species-specific fine structures
% ------------------------------
% 2.1 Shared Core Structures of Gram-Negative Bacteria (universal for all groups, auto-inherited)
% ------------------------------
% Cell envelope overall hierarchy
has_component(gram_negative_bacteria, cell_envelope).
has_component(cell_envelope, inner_membrane).
has_component(cell_envelope, periplasmic_space).
has_component(cell_envelope, peptidoglycan_layer).
has_component(cell_envelope, outer_membrane).

% Inner membrane substructures
has_component(inner_membrane, phospholipid_bilayer).
has_component(inner_membrane, respiratory_chain_complex).
has_component(inner_membrane, atp_synthase_complex).
has_component(inner_membrane, nutrient_transporter_protein).
has_component(inner_membrane, signal_transduction_receptor).
has_component(inner_membrane, secretion_system_inner_unit).

% Peptidoglycan layer substructures
has_component(peptidoglycan_layer, glycan_backbone_chain).
has_component(peptidoglycan_layer, tetrapeptide_side_chain).
has_component(peptidoglycan_layer, dap_crosslink).

% Periplasmic space components
has_component(periplasmic_space, periplasmic_binding_protein).
has_component(periplasmic_space, hydrolytic_enzyme).
has_component(periplasmic_space, molecular_chaperone).
has_component(periplasmic_space, detoxification_enzyme).
has_component(periplasmic_space, chemoreceptor_protein).

% Outer membrane substructures
has_component(outer_membrane, asymmetric_lipid_bilayer).
has_component(outer_membrane, lipopolysaccharide).
has_component(outer_membrane, outer_membrane_porin).
has_component(outer_membrane, outer_membrane_structural_protein).
has_component(outer_membrane, braun_lipoprotein).
has_component(outer_membrane, outer_membrane_vesicle).

% LPS three-level fine structure
has_component(lipopolysaccharide, lipid_a).
has_component(lipopolysaccharide, core_polysaccharide).
has_component(lipopolysaccharide, o_specific_side_chain).

% Shared intracellular structures
has_component(gram_negative_bacteria, cytoplasm).
has_component(cytoplasm, nucleoid).
has_component(cytoplasm, ribosome_70s).
has_component(cytoplasm, cytoplasmic_inclusion_granule).
has_component(cytoplasm, metabolic_enzyme_system).

% Cytoplasmic granule subtypes
has_component(cytoplasmic_inclusion_granule, glycogen_granule).
has_component(cytoplasmic_inclusion_granule, polyphosphate_granule).
has_component(cytoplasmic_inclusion_granule, phb_granule).

% ------------------------------
% 2.2 Group-Specific Structures (family/genus level, exclusive to the group)
% ------------------------------
% Enterobacteriaceae specific
has_component(enterobacteriaceae, type_1_common_pilus).
has_component(enterobacteriaceae, sex_pilus_F_plasmid).
has_component(enterobacteriaceae, peritrichous_flagellum).
has_component(enterobacteriaceae, constitutive_beta_lactamase).
has_component(enterobacteriaceae, type_ii_secretion_system).
has_component(enterobacteriaceae, lps_o_antigen_variant).

% Pseudomonas specific
has_component(pseudomonas, single_polar_flagellum).
has_component(pseudomonas, type_iv_pilus).
has_component(pseudomonas, type_iii_secretion_system).
has_component(pseudomonas, type_vi_secretion_system).
has_component(pseudomonas, mex_family_efflux_pump).
has_component(pseudomonas, alginate_biosynthesis_system).
has_component(pseudomonas, pyocyanin_synthesis_pathway).

% Acinetobacter specific
has_component(acinetobacter, polysaccharide_microcapsule).
has_component(acinetobacter, biofilm_synthesis_system).
has_component(acinetobacter, ade_family_efflux_pump).

% Klebsiella specific
has_component(klebsiella, thick_polysaccharide_capsule).
has_component(klebsiella, hypermucoviscosity_capsule).

% Vibrio specific
has_component(vibrio, sheathed_polar_flagellum).
has_component(vibrio, type_iv_pilus).
has_component(vibrio, cholera_toxin_secretion_apparatus).

% Haemophilus specific
has_component(haemophilus, serotype_specific_capsule).
has_component(haemophilus, filamentous_hemagglutinin).

% Neisseria specific
has_component(neisseria, type_iv_pilus).
has_component(neisseria, opa_outer_membrane_protein).
has_component(neisseria, iga_protease).

% Bacteroides specific
has_component(bacteroides, complex_polysaccharide_capsule).
has_component(bacteroides, anaerobic_respiratory_complex).
has_component(bacteroides, polysaccharide_degrading_enzyme).

% Spirochaetes specific
has_component(spirochaetes, endoflagellum_axial_filament).
has_component(spirochaetes, outer_membrane_sheath).
has_component(spirochaetes, protoplasmic_cylinder).

% Chlamydiae specific
has_component(chlamydia, elementary_body_infectious).
has_component(chlamydia, reticulate_body_reproductive).
has_component(chlamydia, inclusion_membrane_protein).

% Epsilonproteobacteria specific
has_component(epsilonproteobacteria, sheathed_polar_flagella).
has_component(helicobacter, urease_enzyme_complex).

% Burkholderia specific
has_component(burkholderia, type_iii_secretion_system).
has_component(burkholderia, cable_pilus).

% ------------------------------
% 2.3 Species-Specific Fine Structures of Clinically Common Bacteria
% ------------------------------
% Pseudomonas aeruginosa
has_component(pseudomonas_aeruginosa, mucoid_alginate_capsule).
has_component(pseudomonas_aeruginosa, exoenzyme_S_secretion_system).
has_component(pseudomonas_aeruginosa, las_rhl_quorum_sensing).

% Klebsiella pneumoniae
has_component(klebsiella_pneumoniae, k_antigen_capsular_polysaccharide).
has_component(klebsiella_pneumoniae, aerobactin_iron_uptake_system).

% Escherichia coli
has_component(escherichia_coli, type_1_fimbriae_adhesin).
has_component(escherichia_coli, o_antigen_serotype_determinant).
has_component(uropathogenic_escherichia_coli, p_pilus_adhesin).
has_component(enteropathogenic_escherichia_coli, eae_intimin_protein).

% Acinetobacter baumannii
has_component(acinetobacter_baumannii, ompA_outer_membrane_protein).
has_component(acinetobacter_baumannii, csu_pilus_biofilm).

% Helicobacter pylori
has_component(helicobacter_pylori, cag_pathogenicity_island).
has_component(helicobacter_pylori, vacuolating_cytotoxin_vaca).
has_component(helicobacter_pylori, urease_gene_cluster).
has_component(helicobacter_pylori, babA_adhesin).

% Vibrio cholerae
has_component(vibrio_cholerae, toxin_coregulated_pilus_tcp).
has_component(vibrio_cholerae, cholera_toxin_ab5_complex).

% Treponema pallidum
has_component(treponema_pallidum, endoflagellar_motor_complex).
has_component(treponema_pallidum, tpr_outer_membrane_repeat_protein).

% Bacteroides fragilis
has_component(bacteroides_fragilis, capsular_polysaccharide_a).
has_component(bacteroides_fragilis, cepA_chromosomal_beta_lactamase).

% Neisseria gonorrhoeae
has_component(neisseria_gonorrhoeae, pilC_adhesin).
has_component(neisseria_gonorrhoeae, por_porin_protein).

% Neisseria meningitidis
has_component(neisseria_meningitidis, serogroup_capsular_polysaccharide).

% ------------------------------
% 2.4 Structure-Specific Inference Rules
% ------------------------------
% Taxonomic inheritance of structural properties: subclasses inherit all structures from parent classes
has_component(Entity, Part) :-
    is_a(Entity, Parent),
    has_component(Parent, Part),
    Entity \= Parent.

% Structure-specific query utilities
all_structures_of(Bacterium, StructureList) :-
    findall(S, has_component(Bacterium, S), StructureList).
all_whole_of(Part, WholeList) :-
    findall(W, has_component(W, Part), WholeList).
all_subcomponents(Whole, SubList) :-
    findall(S, has_component(Whole, S), SubList).

% ==============================================
% Module 3: Pathogenesis & Host Interaction Relations
% Layers: Shared pathogenic effects -> Group-specific interactions -> Species-specific interactions
% ------------------------------
% 3.1 Shared Pathogenic Effects of Gram-Negative Bacteria (universal for all groups)
% ------------------------------
% Shared endotoxin pathogenic effects
toxin_effect(gram_negative_bacteria, lipid_a, host_tlr4_receptor, proinflammatory_cascade_activation).
toxin_effect(gram_negative_bacteria, lipid_a, host_vascular_endothelium, increased_vascular_permeability).
toxin_effect(gram_negative_bacteria, lipid_a, host_coagulation_system, disseminated_intravascular_coagulation_risk).

% Shared virulence vector interactions
virulence_mediates(gram_negative_bacteria, outer_membrane_vesicle, long_distance_virulence_factor_delivery).
virulence_mediates(gram_negative_bacteria, outer_membrane_vesicle, host_cell_membrane_fusion).
virulence_mediates(gram_negative_bacteria, outer_membrane_vesicle, interbacterial_material_exchange).

% Shared basic immune evasion
immune_evasion(gram_negative_bacteria, host_complement_lysis, lps_lipid_a_structure_modification).
immune_evasion(gram_negative_bacteria, host_antibody_recognition, o_antigen_phase_variation).
immune_evasion(gram_negative_bacteria, host_antimicrobial_peptide, outer_membrane_negative_charge_repulsion).

% ------------------------------
% 3.2 Group-Specific Pathogenic Interactions (family/genus level)
% ------------------------------
% Enterobacteriaceae
colonizes(enterobacteriaceae, human_gastrointestinal_tract).
adhesion_target(enterobacteriaceae, type_1_common_pilus, host_epithelial_mannose_receptor).
invades_cell(enterobacteriaceae, host_intestinal_epithelial_cell, trigger_uptake_mechanism).
virulence_mediates(enterobacteriaceae, peritrichous_flagellum, chemotactic_mucosa_colonization).
immune_evasion(enterobacteriaceae, host_phagocytic_killing, o_antigen_side_chain_shielding).
toxin_effect(enterobacteriaceae, chromosomal_beta_lactamase, host_antibiotic_molecule, drug_inactivation).

% Pseudomonas
colonizes(pseudomonas, hospital_moist_surfaces).
colonizes(pseudomonas, human_respiratory_mucosa).
adhesion_target(pseudomonas, type_iv_pilus, host_epithelial_glycolipid_receptor).
invades_cell(pseudomonas, host_epithelial_cell, type_iii_secretion_system_injection).
virulence_mediates(pseudomonas, single_polar_flagellum, directional_motility_toward_nutrients).
immune_evasion(pseudomonas, host_phagocytic_clearance, alginate_biofilm_physical_barrier).
immune_evasion(pseudomonas, host_oxidative_burst, catalase_superoxide_dismutase_system).

% Acinetobacter
colonizes(acinetobacter, human_skin_mucosa).
colonizes(acinetobacter, medical_implant_surfaces).
adhesion_target(acinetobacter, csu_pilus, abiotic_surface_initial_adhesion).
virulence_mediates(acinetobacter, polysaccharide_microcapsule, desiccation_resistance).
immune_evasion(acinetobacter, host_neutrophil_killing, biofilm_matrix_entrapment).
induces_disease(acinetobacter, catheter_related_infection, nosocomial_setting).

% Vibrio
colonizes(vibrio, human_small_intestinal_lumen).
adhesion_target(vibrio, type_iv_pilus, host_intestinal_mucosal_receptor).
virulence_mediates(vibrio, sheathed_polar_flagellum, intestinal_mucus_layer_penetration).

% Helicobacter
colonizes(helicobacter, human_gastric_mucous_layer).
virulence_mediates(helicobacter, urease_enzyme_complex, gastric_acid_neutralization).
virulence_mediates(helicobacter, sheathed_polar_flagella, gastric_mucus_burrowing).
adhesion_target(helicobacter, babA_adhesin, host_gastric_lewis_b_antigen).

% Neisseria
colonizes(neisseria, human_mucosal_surface).
adhesion_target(neisseria, type_iv_pilus, host_epithelial_cd46_receptor).
immune_evasion(neisseria, host_antibody_binding, opa_protein_phase_variation).

% Spirochaetes
colonizes(spirochaetes, host_connective_tissue).
virulence_mediates(spirochaetes, endoflagellum_axial_filament, corkscrew_tissue_penetration).
immune_evasion(spirochaetes, host_antibody_binding, outer_membrane_protein_low_immunogenicity).
invades_cell(spirochaetes, host_endothelial_cell, transendothelial_migration).

% Chlamydiae
colonizes(chlamydia, host_columnar_epithelial_cell).
virulence_mediates(chlamydia, elementary_body, extracellular_infectious_transmission).
invades_cell(chlamydia, host_epithelial_cell, endocytosis_parasitophorous_vacuole).
immune_evasion(chlamydia, host_lysosomal_degradation, inclusion_membrane_modification).

% Bacteroides
colonizes(bacteroides, human_colon_normal_flora).
virulence_mediates(bacteroides, polysaccharide_capsule, abscess_formation_induction).
immune_evasion(bacteroides, host_complement_activation, capsule_sialic_acid_mimicry).

% ------------------------------
% 3.3 Species-Specific Pathogenic Interactions of Clinically Common Bacteria
% ------------------------------
% Escherichia coli
adhesion_target(uropathogenic_escherichia_coli, p_pilus, host_uroepithelial_gal_gal_receptor).
induces_disease(uropathogenic_escherichia_coli, acute_cystitis, community_setting).
induces_disease(uropathogenic_escherichia_coli, acute_pyelonephritis, complicated_setting).
toxin_effect(enterotoxigenic_escherichia_coli, heat_labile_toxin_lt, host_intestinal_adenylate_cyclase, secretory_watery_diarrhea).
toxin_effect(enterotoxigenic_escherichia_coli, heat_stable_toxin_st, host_intestinal_guanylate_cyclase, electrolyte_secretion_imbalance).
induces_disease(enterotoxigenic_escherichia_coli, traveler_diarrhea, tropical_travel_setting).
adhesion_target(enteropathogenic_escherichia_coli, eae_intimin_protein, host_intestinal_cell_tir_receptor).
induces_disease(enteropathogenic_escherichia_coli, infantile_watery_diarrhea, pediatric_setting).
toxin_effect(enterohemorrhagic_escherichia_coli, shiga_like_toxin, host_endothelial_cell_ribosome, protein_synthesis_inhibition).
induces_disease(enterohemorrhagic_escherichia_coli, hemorrhagic_colitis, foodborne_outbreak_setting).
induces_disease(enterohemorrhagic_escherichia_coli, hemolytic_uremic_syndrome, pediatric_complication).
invades_cell(enteroinvasive_escherichia_coli, host_colonic_epithelial_cell, intracellular_actin_based_spread).
induces_disease(enteroinvasive_escherichia_coli, bacillary_dysentery_like_syndrome, developing_region_setting).
induces_disease(escherichia_coli, primary_bacteremia, nosocomial_setting).
induces_disease(escherichia_coli, neonatal_meningitis, perinatal_setting).

% Klebsiella pneumoniae
adhesion_target(klebsiella_pneumoniae, type_3_pilus, host_respiratory_epithelial_receptor).
immune_evasion(klebsiella_pneumoniae, host_macrophage_phagocytosis, thick_polysaccharide_capsule_shielding).
induces_disease(klebsiella_pneumoniae, hospital_acquired_pneumonia, icu_setting).
induces_disease(klebsiella_pneumoniae, urinary_tract_infection, catheter_associated_setting).
induces_disease(hypervirulent_klebsiella_pneumoniae, pyogenic_liver_abscess, community_setting).
induces_disease(hypervirulent_klebsiella_pneumoniae, metastatic_meningitis, invasive_complication).
virulence_mediates(hypervirulent_klebsiella_pneumoniae, aerobactin_iron_uptake_system, in_vivo_high_iron_acquisition).

% Pseudomonas aeruginosa
toxin_effect(pseudomonas_aeruginosa, exotoxin_a, host_elongation_factor_2, protein_synthesis_inhibition).
toxin_effect(pseudomonas_aeruginosa, pyocyanin, host_respiratory_epithelium, oxidative_tissue_damage).
virulence_regulation(pseudomonas_aeruginosa, las_quorum_sensing_system, biofilm_maturation).
virulence_regulation(pseudomonas_aeruginosa, rhl_quorum_sensing_system, virulence_factor_coordinated_expression).
induces_disease(pseudomonas_aeruginosa, ventilator_associated_pneumonia, icu_nosocomial_setting).
induces_disease(pseudomonas_aeruginosa, chronic_lung_infection, cystic_fibrosis_patient_setting).
induces_disease(pseudomonas_aeruginosa, burn_wound_infection, burn_unit_setting).
induces_disease(pseudomonas_aeruginosa, otitis_externa, swimmer_population_setting).

% Acinetobacter baumannii
induces_disease(acinetobacter_baumannii, ventilator_associated_pneumonia, icu_setting).
induces_disease(acinetobacter_baumannii, catheter_related_bloodstream_infection, nosocomial_setting).
induces_disease(acinetobacter_baumannii, surgical_site_infection, trauma_patient_setting).
virulence_mediates(acinetobacter_baumannii, ompA_outer_membrane_protein, host_cell_apoptosis_induction).

% Salmonella typhi
invades_cell(salmonella_typhi, host_ileal_m_cell, pathogen_triggered_uptake).
invades_cell(salmonella_typhi, host_macrophage, intracellular_survival_replication).
induces_disease(salmonella_typhi, enteric_fever, systemic_infection_setting).
toxin_effect(salmonella_typhi, typhoid_toxin, host_neuronal_endothelial_target, systemic_toxicity).

% Shigella dysenteriae
invades_cell(shigella_dysenteriae, host_colonic_epithelial_cell, actin_based_intercellular_spread).
toxin_effect(shigella_dysenteriae, shiga_toxin, host_colonic_vascular_endothelium, mucosal_hemorrhage).
induces_disease(shigella_dysenteriae, bacillary_dysentery, fecal_oral_transmission_setting).

% Vibrio cholerae
adhesion_target(vibrio_cholerae, toxin_coregulated_pilus_tcp, host_small_intestinal_receptor).
toxin_effect(vibrio_cholerae, cholera_toxin_ab5_complex, host_intestinal_epithelial_gs_protein, massive_chloride_secretion).
induces_disease(vibrio_cholerae, cholera_severe_watery_diarrhea, epidemic_setting).
virulence_regulation(vibrio_cholerae, toxT_regulon, toxin_pilus_coordinated_expression).

% Helicobacter pylori
toxin_effect(helicobacter_pylori, vacuolating_cytotoxin_vaca, host_gastric_epithelial_cell, cytoplasmic_vacuolization).
virulence_mediates(helicobacter_pylori, cag_pathogenicity_island, type_iv_secretion_system_assembly).
toxin_effect(helicobacter_pylori, cagA_effector_protein, host_cell_cytoskeleton, abnormal_cell_proliferation).
induces_disease(helicobacter_pylori, chronic_active_gastritis, persistent_infection_setting).
induces_disease(helicobacter_pylori, duodenal_gastric_ulcer, peptic_ulcer_disease_setting).
induces_disease(helicobacter_pylori, gastric_adenocarcinoma, long_term_carcinogenesis_setting).
induces_disease(helicobacter_pylori, malt_lymphoma, lymphoproliferative_setting).

% Haemophilus influenzae
adhesion_target(haemophilus_influenzae, filamentous_hemagglutinin, host_respiratory_mucosa).
immune_evasion(haemophilus_influenzae_type_b, host_phagocytosis, type_b_polysaccharide_capsule).
induces_disease(haemophilus_influenzae_type_b, bacterial_meningitis, pediatric_setting).
induces_disease(haemophilus_influenzae_type_b, epiglottitis, pediatric_emergency_setting).
induces_disease(nontypeable_haemophilus_influenzae, acute_otitis_media, pediatric_setting).
induces_disease(nontypeable_haemophilus_influenzae, chronic_bronchitis_exacerbation, copd_setting).

% Neisseria meningitidis
invades_cell(neisseria_meningitidis, host_nasopharyngeal_epithelium, transcytosis).
immune_evasion(neisseria_meningitidis, host_complement_killing, serogroup_capsule_sialic_acid).
induces_disease(neisseria_meningitidis, meningococcal_meningitis, epidemic_setting).
induces_disease(neisseria_meningitidis, meningococcal_septicemia, fulminant_infection_setting).

% Neisseria gonorrhoeae
adhesion_target(neisseria_gonorrhoeae, pilC_adhesin, host_urogenital_epithelial_receptor).
immune_evasion(neisseria_gonorrhoeae, host_antibody_recognition, pilin_antigenic_variation).
induces_disease(neisseria_gonorrhoeae, gonorrhea_urethritis, sexually_transmitted_setting).
induces_disease(neisseria_gonorrhoeae, pelvic_inflammatory_disease, ascending_infection_setting).

% Treponema pallidum
invades_cell(treponema_pallidum, host_mucosal_epithelium, trans_epithelial_penetration).
induces_disease(treponema_pallidum, primary_syphilis_hard_chancre, early_local_infection).
induces_disease(treponema_pallidum, secondary_syphilis_systemic_rash, hematogenous_dissemination).
induces_disease(treponema_pallidum, tertiary_syphilis_gumma, late_tissue_destruction).
immune_evasion(treponema_pallidum, host_immune_surveillance, outer_membrane_rare_transmembrane_protein).

% Chlamydia trachomatis
induces_disease(chlamydia_trachomatis, trachoma_chronic_conjunctivitis, endemic_blindness_setting).
induces_disease(chlamydia_trachomatis, nongonococcal_urethritis, sexually_transmitted_setting).
induces_disease(chlamydia_trachomatis, pelvic_inflammatory_disease, female_upper_genital_setting).
virulence_mediates(chlamydia_trachomatis, inclusion_membrane_protein, host_golgi_apparatus_hijack).

% Bacteroides fragilis
induces_disease(bacteroides_fragilis, intra_abdominal_abscess, perforated_appendix_complication).
induces_disease(bacteroides_fragilis, pelvic_inflammatory_abscess, gynecologic_infection_setting).
immune_evasion(bacteroides_fragilis, host_immune_regulation, capsular_polysaccharide_a_treg_induction).

% Bordetella pertussis
adhesion_target(bordetella_pertussis, filamentous_hemagglutinin, host_ciliated_respiratory_epithelium).
toxin_effect(bordetella_pertussis, pertussis_toxin, host_gi_protein, adenylate_cyclase_dysregulation).
induces_disease(bordetella_pertussis, whooping_cough, pediatric_respiratory_setting).

% Legionella pneumophila
invades_cell(legionella_pneumophila, host_alveolar_macrophage, dot_icm_type_iv_secretion).
immune_evasion(legionella_pneumophila, host_phagolysosome_fusion, legionella_containing_vacuole).
induces_disease(legionella_pneumophila, legionnaires_disease, contaminated_water_aerosol_setting).

% ------------------------------
% 3.4 Pathogenesis Interaction Inference Rules (unified and merged)
% ------------------------------
% All pathogenic properties are inherited uniformly via the taxonomy system
colonizes(B, Niche) :- is_a(B, Parent), colonizes(Parent, Niche), B \= Parent.
adhesion_target(B, Adh, Rec) :- is_a(B, Parent), adhesion_target(Parent, Adh, Rec), B \= Parent.
invades_cell(B, CellType, Mech) :- is_a(B, Parent), invades_cell(Parent, CellType, Mech), B \= Parent.
toxin_effect(B, Toxin, Target, Patho) :- is_a(B, Parent), toxin_effect(Parent, Toxin, Target, Patho), B \= Parent.
immune_evasion(B, Attack, Strategy) :- is_a(B, Parent), immune_evasion(Parent, Attack, Strategy), B \= Parent.
induces_disease(B, Disease, Setting) :- is_a(B, Parent), induces_disease(Parent, Disease, Setting), B \= Parent.
virulence_mediates(B, Factor, Effect) :- is_a(B, Parent), virulence_mediates(Parent, Factor, Effect), B \= Parent.
virulence_regulation(B, Regulator, Effect) :- is_a(B, Parent), virulence_regulation(Parent, Regulator, Effect), B \= Parent.

% Pathogenesis-specific query utilities
all_colonization_sites(Bacterium, SiteList) :-
    findall(S, colonizes(Bacterium, S), SiteList).
all_induced_diseases(Bacterium, DiseaseList) :-
    findall(D, induces_disease(Bacterium, D, _), DiseaseList).
pathogens_of_disease(Disease, PathogenList) :-
    findall(P, induces_disease(P, Disease, _), PathogenList).
all_immune_evasions(Bacterium, EvasionList) :-
    findall(S, immune_evasion(Bacterium, _, S), EvasionList).
factor_caused_disease(Factor, Bacterium, Disease) :-
    virulence_mediates(Bacterium, Factor, _),
    induces_disease(Bacterium, Disease, _).

% ==============================================
% Module 4: Drug-Bacteria Interaction Relations
% ------------------------------
% 4.1 Basic Properties of Antibacterial Drugs
% ------------------------------
% Bactericidal/bacteriostatic type
bactericidal_type(beta_lactam_antibiotics, bactericidal).
bactericidal_type(fluoroquinolones, bactericidal).
bactericidal_type(aminoglycosides, bactericidal).
bactericidal_type(polymyxins, bactericidal).
bactericidal_type(tetracyclines, bacteriostatic).
bactericidal_type(chloramphenicol_class, bacteriostatic).
bactericidal_type(sulfonamides, bacteriostatic).
bactericidal_type(glycopeptides, bactericidal).
bactericidal_type(nitroimidazoles, bactericidal).
bactericidal_type(macrolides, bacteriostatic).

% Action targets and molecular mechanisms
drug_action_target(beta_lactam_antibiotics, penicillin_binding_proteins, "Inhibits peptidoglycan transpeptidase, blocks cell wall cross-linking synthesis.").
drug_action_target(fluoroquinolones, dna_gyrase_topoisomerase_iv, "Inhibits DNA gyrase and topoisomerase IV, blocks nucleic acid replication.").
drug_action_target(aminoglycosides, ribosome_30s_subunit, "Binds to 30S ribosomal subunit, causes mistranslation and protein synthesis arrest.").
drug_action_target(tetracyclines, ribosome_30s_subunit, "Blocks aminoacyl-tRNA binding, inhibits peptide chain elongation.").
drug_action_target(chloramphenicol_class, ribosome_50s_subunit, "Inhibits peptidyl transferase activity, blocks peptide bond formation.").
drug_action_target(polymyxins, lipopolysaccharide_outer_membrane, "Binds LPS and displaces divalent cations, disrupts outer membrane permeability barrier.").
drug_action_target(sulfonamides, dihydropteroate_synthase, "Competitively inhibits folate synthesis, blocks nucleic acid precursor production.").
drug_action_target(glycopeptides, peptidoglycan_precursor, "Binds D-Ala-D-Ala of peptidoglycan precursor, blocks cell wall synthesis.").
drug_action_target(nitroimidazoles, bacterial_dna, "Reduced nitro group generates free radicals that damage DNA under anaerobic conditions.").
drug_action_target(macrolides, ribosome_50s_subunit, "Binds 23S rRNA of 50S subunit, blocks translocation step of protein synthesis.").

% Outer membrane penetration mechanism
penetration_mechanism(beta_lactam_antibiotics, outer_membrane_porin_diffusion, "Passive diffusion into the periplasmic space through hydrophilic channels of outer membrane porins.").
penetration_mechanism(fluoroquinolones, lipid_bilayer_passive_diffusion, "Lipophilic property, directly penetrates the outer membrane through the lipid bilayer.").
penetration_mechanism(aminoglycosides, energy_dependent_active_transport, "Energy-dependent active transport, enters cells through porins.").
penetration_mechanism(polymyxins, self_promoted_uptake_pathway, "Binds LPS and disrupts the outer membrane, mediates its own transmembrane transport.").
penetration_mechanism(tetracyclines, porin_mediated_diffusion, "Passive diffusion into the cell through hydrophilic channels of outer membrane porins.").
penetration_mechanism(glycopeptides, no_outer_membrane_permeation, "Large molecular weight, cannot pass outer membrane pores, intrinsically inactive against GNB.").
penetration_mechanism(macrolides, poor_outer_membrane_permeability, "Insufficient lipophilicity, very low outer membrane permeability, intrinsically resistant in GNB.").

% ------------------------------
% 4.2 Shared Drug Action Patterns in Gram-Negative Bacteria
% ------------------------------
% Intrinsically resistant drugs
intrinsic_resistant_to(gram_negative_bacteria, glycopeptides).
intrinsic_resistant_to(gram_negative_bacteria, macrolides).
intrinsic_resistant_to(gram_negative_bacteria, lincosamides).
intrinsic_resistant_to(gram_negative_bacteria, oxazolidinones).
intrinsic_resistant_to(gram_negative_bacteria, daptomycin).

% Generally susceptible drugs
generally_susceptible(gram_negative_bacteria, fluoroquinolones).
generally_susceptible(gram_negative_bacteria, aminoglycosides).
generally_susceptible(gram_negative_bacteria, tetracyclines).
generally_susceptible(gram_negative_bacteria, polymyxins).

% Shared acquired resistance mechanisms
common_acquired_resistance(gram_negative_bacteria, beta_lactam_antibiotics, beta_lactamase_production).
common_acquired_resistance(gram_negative_bacteria, fluoroquinolones, target_gene_point_mutation).
common_acquired_resistance(gram_negative_bacteria, aminoglycosides, modifying_enzyme_expression).
common_acquired_resistance(gram_negative_bacteria, multiple_antibiotics, efflux_pump_overexpression).
common_acquired_resistance(gram_negative_bacteria, multiple_antibiotics, porin_expression_downregulation).

% ------------------------------
% 4.3 Group-Specific Susceptibility and Resistance Features
% ------------------------------
% Enterobacteriaceae
generally_susceptible(enterobacteriaceae, third_generation_cephalosporins).
generally_susceptible(enterobacteriaceae, carbapenems).
generally_susceptible(enterobacteriaceae, beta_lactam_inhibitor_combinations).
generally_susceptible(enterobacteriaceae, trimethoprim_sulfamethoxazole).
intrinsic_resistant_to(enterobacteriaceae, penicillin_g).
acquired_resistance(enterobacteriaceae, third_gen_cephalosporins, esbl_production).
acquired_resistance(enterobacteriaceae, cephamycins, ampc_chromosomal_enzyme).
acquired_resistance(enterobacteriaceae, carbapenems, carbapenemase_gene_acquisition).
acquired_resistance(enterobacteriaceae, fluoroquinolones, gyrA_parC_target_mutation).
clinical_first_line(enterobacteriaceae, uncomplicated_urinary_tract_infection, trimethoprim_sulfamethoxazole).
clinical_first_line(enterobacteriaceae, severe_nosocomial_infection, carbapenems).
clinical_first_line(esbl_positive_enterobacteriaceae, severe_infection, carbapenems).

% Pseudomonas
intrinsic_resistant_to(pseudomonas, penicillin_g).
intrinsic_resistant_to(pseudomonas, first_generation_cephalosporins).
intrinsic_resistant_to(pseudomonas, second_generation_cephalosporins).
intrinsic_resistant_to(pseudomonas, ceftriaxone).
intrinsic_resistant_to(pseudomonas, ertapenem).
intrinsic_resistant_to(pseudomonas, trimethoprim_sulfamethoxazole).
intrinsic_resistant_to(pseudomonas, tetracyclines).
generally_susceptible(pseudomonas, antipseudomonal_penicillins).
generally_susceptible(pseudomonas, ceftazidime).
generally_susceptible(pseudomonas, cefepime).
generally_susceptible(pseudomonas, imipenem).
generally_susceptible(pseudomonas, meropenem).
generally_susceptible(pseudomonas, ciprofloxacin).
generally_susceptible(pseudomonas, aminoglycosides).
generally_susceptible(pseudomonas, polymyxins).
acquired_resistance(pseudomonas, carbapenems, oprD_porin_gene_deletion).
acquired_resistance(pseudomonas, multiple_antibiotics, mex_family_efflux_pump_upregulation).
acquired_resistance(pseudomonas, carbapenems, metallo_beta_lactamase_production).
clinical_first_line(pseudomonas_aeruginosa, hospital_acquired_pneumonia, antipseudomonal_beta_lactam_combined_aminoglycoside).

% Acinetobacter
intrinsic_resistant_to(acinetobacter, penicillin_g).
intrinsic_resistant_to(acinetobacter, first_generation_cephalosporins).
intrinsic_resistant_to(acinetobacter, ertapenem).
generally_susceptible(acinetobacter, carbapenems).
generally_susceptible(acinetobacter, sulbactam_compound_preparations).
generally_susceptible(acinetobacter, polymyxins).
generally_susceptible(acinetobacter, tigecycline).
acquired_resistance(acinetobacter, carbapenems, oxa_class_carbapenemase_production).
acquired_resistance(acinetobacter, multiple_antibiotics, ade_family_efflux_pump_overexpression).
acquired_resistance(acinetobacter, carbapenems, outer_membrane_porin_downregulation).
clinical_first_line(acinetobacter_baumannii, severe_nosocomial_infection, sulbactam_combined_polymyxin).

% Stenotrophomonas maltophilia
intrinsic_resistant_to(stenotrophomonas_maltophilia, carbapenems).
intrinsic_resistant_to(stenotrophomonas_maltophilia, aminoglycosides).
intrinsic_resistance_mechanism(stenotrophomonas_maltophilia, carbapenems, constitutive_L1_metallo_beta_lactamase).
intrinsic_resistance_mechanism(stenotrophomonas_maltophilia, carbapenems, constitutive_L2_serine_beta_lactamase).
generally_susceptible(stenotrophomonas_maltophilia, trimethoprim_sulfamethoxazole).
generally_susceptible(stenotrophomonas_maltophilia, levofloxacin).

% Burkholderia cepacia complex
intrinsic_resistant_to(burkholderia_cepacia_complex, polymyxins).
intrinsic_resistant_to(burkholderia_cepacia_complex, aminoglycosides).
generally_susceptible(burkholderia_cepacia_complex, trimethoprim_sulfamethoxazole).
generally_susceptible(burkholderia_cepacia_complex, meropenem).

% Vibrio
generally_susceptible(vibrio, tetracyclines).
generally_susceptible(vibrio, fluoroquinolones).
generally_susceptible(vibrio, third_generation_cephalosporins).
clinical_first_line(vibrio_cholerae, severe_cholera, doxycycline).

% Helicobacter pylori
generally_susceptible(helicobacter_pylori, amoxicillin).
generally_susceptible(helicobacter_pylori, clarithromycin).
generally_susceptible(helicobacter_pylori, metronidazole).
generally_susceptible(helicobacter_pylori, bismuth_preparations).
clinical_first_line(helicobacter_pylori, eradication_therapy, bismuth_containing_quadruple_therapy).

% Anaerobic Gram-negative bacteria (Bacteroides)
intrinsic_resistant_to(bacteroides, aminoglycosides).
intrinsic_resistant_to(bacteroides, fluoroquinolones).
generally_susceptible(bacteroides, metronidazole).
generally_susceptible(bacteroides, clindamycin).
generally_susceptible(bacteroides, beta_lactam_inhibitor_combinations).
generally_susceptible(bacteroides, carbapenems).
clinical_first_line(bacteroides_fragilis, intra_abdominal_abscess, metronidazole).

% Chlamydia
intrinsic_resistant_to(chlamydia, beta_lactam_antibiotics).
generally_susceptible(chlamydia, tetracyclines).
generally_susceptible(chlamydia, macrolides).
generally_susceptible(chlamydia, fluoroquinolones).
clinical_first_line(chlamydia_trachomatis, genital_infection, doxycycline).

% Spirochaetes
intrinsic_resistant_to(spirochaetes, aminoglycosides).
generally_susceptible(spirochaetes, penicillins).
generally_susceptible(spirochaetes, tetracyclines).
generally_susceptible(spirochaetes, macrolides).
clinical_first_line(treponema_pallidum, syphilis, benzathine_penicillin_g).

% Neisseria
generally_susceptible(neisseria, third_generation_cephalosporins).
generally_susceptible(neisseria, fluoroquinolones).
clinical_first_line(neisseria_gonorrhoeae, gonorrhea, ceftriaxone).
clinical_first_line(neisseria_meningitidis, meningococcal_meningitis, third_generation_cephalosporins).

% Bordetella
generally_susceptible(bordetella, macrolides).
clinical_first_line(bordetella_pertussis, whooping_cough, azithromycin).

% Legionella
intrinsic_resistant_to(legionella, beta_lactam_antibiotics).
generally_susceptible(legionella, fluoroquinolones).
generally_susceptible(legionella, macrolides).
clinical_first_line(legionella_pneumophila, legionnaires_disease, levofloxacin).

% ------------------------------
% 4.4 Multidrug-Resistant Strain Phenotypes and Molecular Markers
% ------------------------------
% Carbapenem-Resistant Enterobacteriaceae (CRE)
resistant_phenotype(carbapenem_resistant_enterobacteriaceae, carbapenems, high_level_resistance).
resistant_phenotype(carbapenem_resistant_enterobacteriaceae, most_beta_lactams, cross_resistance).
resistant_phenotype(carbapenem_resistant_enterobacteriaceae, fluoroquinolones, frequent_co_resistance).
resistant_phenotype(carbapenem_resistant_enterobacteriaceae, aminoglycosides, frequent_co_resistance).
resistance_marker(carbapenem_resistant_enterobacteriaceae, kpc_gene, class_A_serine_carbapenemase).
resistance_marker(carbapenem_resistant_enterobacteriaceae, ndm_gene, class_B_metallo_beta_lactamase).
resistance_marker(carbapenem_resistant_enterobacteriaceae, oxa48_gene, class_D_carbapenemase).
clinical_last_resort(carbapenem_resistant_enterobacteriaceae, polymyxins).
clinical_last_resort(carbapenem_resistant_enterobacteriaceae, cefiderocol).

% Carbapenem-Resistant Acinetobacter baumannii (CRAB)
resistant_phenotype(carbapenem_resistant_acinetobacter, carbapenems, high_level_resistance).
resistant_phenotype(carbapenem_resistant_acinetobacter, most_antibiotics, extensive_drug_resistance).
resistance_marker(carbapenem_resistant_acinetobacter, oxa23_gene, class_D_carbapenemase).
resistance_marker(carbapenem_resistant_acinetobacter, oxa24_gene, class_D_carbapenemase).
clinical_last_resort(carbapenem_resistant_acinetobacter, polymyxins).
clinical_last_resort(carbapenem_resistant_acinetobacter, tigecycline).

% Multidrug-Resistant Pseudomonas aeruginosa (MDR-PA)
resistant_phenotype(mdr_pseudomonas_aeruginosa, antipseudomonal_cephalosporins, resistance).
resistant_phenotype(mdr_pseudomonas_aeruginosa, carbapenems, resistance).
resistant_phenotype(mdr_pseudomonas_aeruginosa, fluoroquinolones, resistance).
resistant_phenotype(mdr_pseudomonas_aeruginosa, aminoglycosides, resistance).
clinical_last_resort(mdr_pseudomonas_aeruginosa, polymyxins).
clinical_last_resort(mdr_pseudomonas_aeruginosa, cefiderocol).

% Colistin-resistant Gram-negative bacteria
resistant_phenotype(colistin_resistant_gram_negative, polymyxins, high_level_resistance).
resistance_marker(colistin_resistant_gram_negative, mcr_gene, lipid_a_phosphoethanolamine_modification).

% ------------------------------
% 4.5 Drug Action Inference Rules
% ------------------------------
% Uniform inheritance of susceptibility and resistance properties
intrinsic_resistant_to(Bacterium, Drug) :-
    is_a(Bacterium, Parent),
    intrinsic_resistant_to(Parent, Drug),
    Bacterium \= Parent.
generally_susceptible(Bacterium, Drug) :-
    is_a(Bacterium, Parent),
    generally_susceptible(Parent, Drug),
    Bacterium \= Parent.
acquired_resistance(Bacterium, Drug, Mechanism) :-
    is_a(Bacterium, Parent),
    acquired_resistance(Parent, Drug, Mechanism),
    Bacterium \= Parent.

% Drug action specific query utilities
all_intrinsic_resistances(Bacterium, DrugList) :-
    findall(D, intrinsic_resistant_to(Bacterium, D), DrugList).
all_susceptible_drugs(Bacterium, DrugList) :-
    findall(D, generally_susceptible(Bacterium, D), DrugList).
all_resistance_mechanisms(Bacterium, Drug, MechList) :-
    findall(M, acquired_resistance(Bacterium, Drug, M), MechList).
effective_bacteria(Drug, BacteriaList) :-
    findall(B, generally_susceptible(B, Drug), BacteriaList).
all_resistance_markers(Phenotype, MarkerList) :-
    findall(M, resistance_marker(Phenotype, M, _), MarkerList).

% ==============================================
% Module 5: Antibacterial Drug Core Structures
% ------------------------------
% 5.1 Core Structure Entities and Hierarchical Classification
% ------------------------------
% Core structure of beta-lactams
core_structure(beta_lactam_four_membered_ring, "Beta-Lactam four-membered ring core").
core_structure_belongs_to(beta_lactam_four_membered_ring, antibacterial_core_structure).

% Subclass core structures of beta-lactams
core_structure(penam_6_apa_core, "Penam core (6-aminopenicillanic acid, 6-APA)").
core_structure(cephem_7_aca_core, "Cephem core (7-aminocephalosporanic acid, 7-ACA)").
core_structure(carbapenem_bicyclic_core, "Carbapenem bicyclic core").
core_structure(monobactam_single_ring_core, "Monobactam single-ring core").
core_structure(cephamycin_methoxy_core, "7-Methoxy cephamycin core").
core_structure(oxapenam_clavulanic_core, "Oxapenam core (beta-lactamase inhibitor type)").
core_structure(penicillinate_sulfone_core, "Penicillinate sulfone core (beta-lactamase inhibitor type)").

core_structure_belongs_to(penam_6_apa_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(cephem_7_aca_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(carbapenem_bicyclic_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(monobactam_single_ring_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(cephamycin_methoxy_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(oxapenam_clavulanic_core, beta_lactam_four_membered_ring).
core_structure_belongs_to(penicillinate_sulfone_core, beta_lactam_four_membered_ring).

% Core structures of other antibacterial drugs
core_structure(quinolone_carboxylic_acid_core, "4-Quinolone-3-carboxylic acid core").
core_structure(aminocyclitol_aminoglycoside_core, "Aminocyclitol core (2-deoxystreptamine skeleton)").
core_structure(tetracycline_naphthacene_core, "Hydrogenated naphthacene tetracyclic core").
core_structure(polymyxin_cyclic_heptapeptide_core, "Cyclic heptapeptide-fatty acid chain core").
core_structure(sulfanilamide_core, "Sulfanilamide core").
core_structure(nitroimidazole_5_core, "5-Nitroimidazole core (specific for anaerobic Gram-negative bacteria)").

core_structure_belongs_to(quinolone_carboxylic_acid_core, antibacterial_core_structure).
core_structure_belongs_to(aminocyclitol_aminoglycoside_core, antibacterial_core_structure).
core_structure_belongs_to(tetracycline_naphthacene_core, antibacterial_core_structure).
core_structure_belongs_to(polymyxin_cyclic_heptapeptide_core, antibacterial_core_structure).
core_structure_belongs_to(sulfanilamide_core, antibacterial_core_structure).
core_structure_belongs_to(nitroimidazole_5_core, antibacterial_core_structure).

% ------------------------------
% 5.2 Drug-Core Structure Mapping
% ------------------------------
has_core_structure(beta_lactam_antibiotics, beta_lactam_four_membered_ring).

has_core_structure(penicillins, penam_6_apa_core).
has_core_structure(cephalosporins, cephem_7_aca_core).
has_core_structure(carbapenems, carbapenem_bicyclic_core).
has_core_structure(monobactams, monobactam_single_ring_core).
has_core_structure(cephamycins, cephamycin_methoxy_core).

has_core_structure(clavulanic_acid, oxapenam_clavulanic_core).
has_core_structure(sulbactam, penicillinate_sulfone_core).
has_core_structure(tazobactam, penicillinate_sulfone_core).

has_core_structure(fluoroquinolones, quinolone_carboxylic_acid_core).
has_core_structure(aminoglycosides, aminocyclitol_aminoglycoside_core).
has_core_structure(tetracyclines, tetracycline_naphthacene_core).
has_core_structure(polymyxins, polymyxin_cyclic_heptapeptide_core).
has_core_structure(sulfonamides, sulfanilamide_core).
has_core_structure(nitroimidazoles, nitroimidazole_5_core).

% ------------------------------
% 5.3 Detailed Structure and Activity Properties of Each Core
% ------------------------------
% Beta-Lactam four-membered ring core
core_structure_property(beta_lactam_four_membered_ring, core_ring, "Core is a nitrogen-containing four-membered amide ring with high ring strain due to bond angles deviating from normal sp2 hybridization.").
core_structure_property(beta_lactam_four_membered_ring, active_mechanism, "The carbonyl carbon on the ring covalently binds to the serine hydroxyl of penicillin-binding proteins (PBPs), inhibiting peptidoglycan cross-linking.").
core_structure_property(beta_lactam_four_membered_ring, resistance_target, "Bacterial beta-lactamases hydrolyze the amide bond of the ring to inactivate the drug, which is the main resistance target in Gram-negative bacteria.").
core_structure_property(beta_lactam_four_membered_ring, structure_activity_rule, "Higher ring strain leads to stronger antibacterial activity but worse chemical stability and easier hydrolytic inactivation.").

% Penam core
core_structure_property(penam_6_apa_core, ring_combination, "Beta-Lactam ring fused with a five-membered thiazolidine ring to form a bicyclic skeleton, with an amide side chain attached at position 6.").
core_structure_property(penam_6_apa_core, side_chain_effect, "Substituents on the 6-position side chain directly determine the antibacterial spectrum, beta-lactamase stability, and oral acid stability of the drug.").
core_structure_property(penam_6_apa_core, gram_negative_feature, "Natural penicillins have weak activity against Gram-negative bacteria; introduction of polar groups on the side chain enhances outer membrane penetration.").

% Cephem core
core_structure_property(cephem_7_aca_core, ring_combination, "Beta-Lactam ring fused with a six-membered dihydrothiazine ring to form a bicyclic skeleton, with an amide side chain at position 7 and modifiable substituents at position 3.").
core_structure_property(cephem_7_aca_core, stability, "The six-membered ring has lower strain than the five-membered ring of penicillins, with better chemical stability and generally stronger tolerance to beta-lactamases.").
core_structure_property(cephem_7_aca_core, spectrum_evolution, "With generation upgrades, electron-withdrawing groups introduced on the 7-position side chain gradually enhance anti-Gram-negative activity and enzyme stability.").

% Carbapenem bicyclic core
core_structure_property(carbapenem_bicyclic_core, ring_combination, "Beta-Lactam ring fused with a five-membered dihydropyrrole ring; the sulfur atom at position 1 is replaced by a carbon atom.").
core_structure_property(carbapenem_bicyclic_core, steric_feature, "No bulky side chain at C4, low steric hindrance, can smoothly pass through the outer membrane porin channels of Gram-negative bacteria.").
core_structure_property(carbapenem_bicyclic_core, enzyme_stability, "The core structure is highly stable against most serine beta-lactamases, including extended-spectrum beta-lactamases (ESBLs).").
core_structure_property(carbapenem_bicyclic_core, clinical_value, "Strong penetration and bactericidal activity against Gram-negative bacteria, serving as the core first-line drug for severe infections.").

% Monobactam single-ring core
core_structure_property(monobactam_single_ring_core, structure_feature, "Contains only a single beta-lactam ring without a fused bicyclic structure, with a sulfonic acid group attached at position N1.").
core_structure_property(monobactam_single_ring_core, spectrum_specificity, "Good outer membrane penetration against aerobic Gram-negative bacteria, narrow spectrum, no activity against Gram-positive bacteria and anaerobes.").
core_structure_property(monobactam_single_ring_core, cross_allergy, "No cross-allergic reaction with penicillins, can be used for Gram-negative infections in patients with beta-lactam allergy.").

% 7-Methoxy cephamycin core
core_structure_property(cephamycin_methoxy_core, structure_feature, "A methoxy group is introduced at position 7 of the cephem core, significantly increasing steric hindrance.").
core_structure_property(cephamycin_methoxy_core, enzyme_stability, "The 7-methoxy group blocks beta-lactamases from accessing the active ring, with better stability against AmpC enzymes and most ESBLs.").

% Beta-Lactamase inhibitor cores
core_structure_property(oxapenam_clavulanic_core, activity_feature, "Very weak intrinsic antibacterial activity, can irreversibly bind to beta-lactamases and protect co-administered beta-lactam drugs.").
core_structure_property(penicillinate_sulfone_core, inhibitor_feature, "The sulfone structure enhances binding affinity to enzymes, with a broader enzyme inhibition spectrum than oxapenams.").

% 4-Quinolone-3-carboxylic acid core
core_structure_property(quinolone_carboxylic_acid_core, ring_combination, "Based on 4-oxo-3-quinolinecarboxylic acid skeleton; introduction of fluorine atom at position 6 significantly enhances antibacterial activity and membrane penetration.").
core_structure_property(quinolone_carboxylic_acid_core, active_group, "The 3-carboxyl and 4-oxo groups are essential for binding to DNA gyrase/topoisomerase IV and cannot be modified.").
core_structure_property(quinolone_carboxylic_acid_core, permeability, "Moderate lipophilicity, penetrates the Gram-negative outer membrane via lipid diffusion, resulting in high intracellular drug concentration.").
core_structure_property(quinolone_carboxylic_acid_core, resistance_mechanism, "Target mutations in bacterial gyrA/parC genes are the main resistance mechanism; overexpression of efflux pumps can mediate multidrug resistance.").

% Aminocyclitol core
core_structure_property(aminocyclitol_aminoglycoside_core, structure_feature, "Centered on an aminocyclitol ring, connected to multiple amino sugar molecules via glycosidic bonds, forming polycationic compounds.").
core_structure_property(aminocyclitol_aminoglycoside_core, membrane_binding, "Multiple amino groups carry positive charges under physiological conditions, electrostatically bind to negatively charged outer membrane LPS.").
core_structure_property(aminocyclitol_aminoglycoside_core, active_mechanism, "After entering the cell, binds to the 30S ribosomal subunit, causing codon mistranslation and protein synthesis arrest.").
core_structure_property(aminocyclitol_aminoglycoside_core, resistance_mechanism, "Modifying enzymes can phosphorylate, acetylate, or adenylate the drug, which is the main clinical resistance mechanism.").

% Hydrogenated naphthacene core
core_structure_property(tetracycline_naphthacene_core, ring_combination, "Four six-membered rings linearly fused to form a naphthacene skeleton, with multiple dissociable phenolic hydroxyl and enol groups.").
core_structure_property(tetracycline_naphthacene_core, transport_feature, "Can chelate with divalent metal ions and pass through Gram-negative outer membrane porins via metal ion transport systems.").
core_structure_property(tetracycline_naphthacene_core, active_site, "Binds to the A site of the 30S ribosomal subunit, blocks aminoacyl-tRNA entry, and inhibits peptide chain elongation.").

% Cyclic heptapeptide core
core_structure_property(polymyxin_cyclic_heptapeptide_core, structure_feature, "Composed of a seven-membered cationic polypeptide ring and an N-terminal fatty acid chain, with multiple positive charges.").
core_structure_property(polymyxin_cyclic_heptapeptide_core, target_binding, "Positive charges bind to negatively charged phosphate groups on the LPS, displacing divalent cations that maintain membrane stability.").
core_structure_property(polymyxin_cyclic_heptapeptide_core, bactericidal_mechanism, "Disrupts the outer membrane permeability barrier, leading to leakage of intracellular substances, with fast and strong bactericidal action.").
core_structure_property(polymyxin_cyclic_heptapeptide_core, clinical_position, "Last-line treatment for multidrug/extensively drug-resistant Gram-negative bacterial infections.").

% Sulfanilamide core
core_structure_property(sulfanilamide_core, structure_feature, "Amino and sulfonamide groups attached to para positions of benzene ring, highly similar in structure to p-aminobenzoic acid (PABA).").
core_structure_property(sulfanilamide_core, active_mechanism, "Competitively inhibits dihydropteroate synthase, blocks the folate synthesis pathway.").
core_structure_property(sulfanilamide_core, synergism, "Combination with trimethoprim dually blocks the folate metabolic pathway, enhancing antibacterial activity and reducing resistance development.").

% 5-Nitroimidazole core
core_structure_property(nitroimidazole_5_core, active_condition, "Only activated by bacterial nitroreductase under anaerobic conditions; completely inactive against aerobic Gram-negative bacteria.").
core_structure_property(nitroimidazole_5_core, bactericidal_mechanism, "Generates reactive free radicals after activation, damages bacterial DNA and proteins, with strong bactericidal effect against anaerobes.").
core_structure_property(nitroimidazole_5_core, clinical_application, "First-line drug for abdominal and pelvic infections caused by anaerobic Gram-negative bacteria such as Bacteroides fragilis.").

% ------------------------------
% 5.4 Core Structure Inference Rules
% ------------------------------
% Core structure inheritance: drug subclasses automatically inherit the corresponding core structure
has_core_structure(Drug, Core) :-
    is_a(Drug, ParentDrug),
    has_core_structure(ParentDrug, Core),
    Drug \= ParentDrug.

% Core structure specific query utilities
drug_core_info(Drug, CoreName, CoreID) :-
    has_core_structure(Drug, CoreID),
    core_structure(CoreID, CoreName).
all_core_properties(CoreID, PropList) :-
    findall([Type, Desc], core_structure_property(CoreID, Type, Desc), PropList).
core_related_drugs(CoreID, DrugList) :-
    findall(D, has_core_structure(D, CoreID), DrugList).
core_active_mechanism(Drug, MechanismDesc) :-
    has_core_structure(Drug, Core),
    core_structure_property(Core, active_mechanism, MechanismDesc).

% ==============================================
% Module 6: Phenotypic Differences Between Species
% ------------------------------
% 6.1 High-Level Group Phenotypic Differences
% ------------------------------
phenotypic_difference(
    enterobacterales, pseudomonadales, glucose_metabolism_type,
    "Enterobacterales are fermentative, produce acid and gas from glucose; Pseudomonadales are oxidative or non-saccharolytic"
).
phenotypic_difference(
    enterobacterales, pseudomonadales, oxidase_test,
    "Enterobacterales are oxidase-negative; Pseudomonadales are mostly oxidase-positive"
).
phenotypic_difference(
    enterobacterales, pseudomonadales, flagella_arrangement,
    "Enterobacterales mostly have peritrichous flagella; Pseudomonadales have polar flagella"
).
phenotypic_difference(
    enterobacterales, pseudomonadales, intrinsic_resistance_spectrum,
    "Enterobacterales are intrinsically susceptible to most cephalosporins; Pseudomonadales have broader intrinsic resistance to early-generation beta-lactams"
).

phenotypic_difference(
    aerobic_gram_negative, anaerobic_gram_negative, oxygen_requirement,
    "Aerobic GNB grow well under ambient air; Anaerobic GNB require strict anaerobic environment for growth"
).
phenotypic_difference(
    aerobic_gram_negative, anaerobic_gram_negative, energy_metabolism,
    "Aerobic GNB rely on aerobic respiratory chain; Anaerobic GNB use fermentation or anaerobic respiration"
).
phenotypic_difference(
    aerobic_gram_negative, anaerobic_gram_negative, aminoglycoside_susceptibility,
    "Most aerobic GNB are susceptible to aminoglycosides; Anaerobic GNB are intrinsically resistant to aminoglycosides"
).

phenotypic_difference(
    proteobacteria, bacteroidetes, typical_niche,
    "Proteobacteria widely colonize mucosal and environmental surfaces; Bacteroidetes mainly colonize the intestinal tract as normal flora"
).
phenotypic_difference(
    proteobacteria, bacteroidetes, cultivability,
    "Most Proteobacteria grow rapidly on ordinary media; Most Bacteroidetes require anaerobic culture conditions"
).

% ------------------------------
% 6.2 Within-Family/Genus Phenotypic Differences
% ------------------------------
phenotypic_difference(
    escherichia, klebsiella, motility,
    "Escherichia species are motile with peritrichous flagella; Klebsiella species are non-motile"
).
phenotypic_difference(
    escherichia, klebsiella, colony_morphology,
    "Escherichia form smooth round colonies; Klebsiella form large mucoid stringy colonies due to thick capsule"
).
phenotypic_difference(
    escherichia, klebsiella, imvic_test_pattern,
    "Escherichia show IMViC pattern ++--; Klebsiella show IMViC pattern --++"
).
phenotypic_difference(
    escherichia, klebsiella, urease_test,
    "Escherichia are urease-negative; Klebsiella are urease-positive"
).

phenotypic_difference(
    salmonella, shigella, motility,
    "Salmonella are motile with peritrichous flagella; Shigella are non-motile"
).
phenotypic_difference(
    salmonella, shigella, h2s_production,
    "Most Salmonella produce H2S on triple sugar iron agar; Shigella do not produce H2S"
).
phenotypic_difference(
    salmonella, shigella, clinical_infection_type,
    "Salmonella cause enteric fever and bacteremia with systemic invasion; Shigella cause localized bacillary dysentery limited to colon"
).

phenotypic_difference(
    pseudomonas, acinetobacter, cell_morphology,
    "Pseudomonas are slender rods with polar flagella; Acinetobacter are plump coccobacilli with no flagella"
).
phenotypic_difference(
    pseudomonas, acinetobacter, oxidase_test,
    "Pseudomonas are oxidase-positive; Acinetobacter are oxidase-negative"
).
phenotypic_difference(
    pseudomonas, acinetobacter, motility,
    "Pseudomonas are actively motile; Acinetobacter are non-motile"
).
phenotypic_difference(
    pseudomonas, acinetobacter, pigment_production,
    "Pseudomonas aeruginosa produces water-soluble pyocyanin and fluorescent pigments; Acinetobacter produce no soluble pigments"
).

phenotypic_difference(
    pseudomonas, stenotrophomonas, oxidase_test,
    "Pseudomonas are oxidase-positive; Stenotrophomonas maltophilia is oxidase-negative"
).
phenotypic_difference(
    pseudomonas, stenotrophomonas, carbapenem_susceptibility,
    "Most Pseudomonas aeruginosa are susceptible to carbapenems; Stenotrophomonas maltophilia is intrinsically resistant to all carbapenems"
).
phenotypic_difference(
    pseudomonas, stenotrophomonas, first_line_treatment,
    "Anti-pseudomonal beta-lactams are first-line for Pseudomonas; Trimethoprim-sulfamethoxazole is first-line for Stenotrophomonas"
).

phenotypic_difference(
    vibrio, aeromonas, cell_shape,
    "Vibrio are curved comma-shaped rods; Aeromonas are straight gram-negative rods"
).
phenotypic_difference(
    vibrio, aeromonas, salt_requirement,
    "Most Vibrio species are halophilic (require NaCl for growth); Aeromonas grow without added salt"
).
phenotypic_difference(
    vibrio, aeromonas, typical_infection,
    "Vibrio cause cholera and seafood-associated gastroenteritis; Aeromonas cause wound infection and aquatic-associated diarrhea"
).

phenotypic_difference(
    bacteroides, fusobacterium, cell_shape,
    "Bacteroides are pleomorphic rods with rounded ends; Fusobacterium are spindle-shaped with pointed ends"
).
phenotypic_difference(
    bacteroides, fusobacterium, bile_tolerance,
    "Bacteroides fragilis group are bile-tolerant; Fusobacterium are inhibited by bile"
).
phenotypic_difference(
    bacteroides, fusobacterium, common_infection_site,
    "Bacteroides mainly cause intra-abdominal abscesses; Fusobacterium mainly cause oral and head-neck infections"
).

% ------------------------------
% 6.3 Within-Genus Species Phenotypic Differences
% ------------------------------
phenotypic_difference(
    escherichia_coli, klebsiella_pneumoniae, capsule_expression,
    "E. coli has no obvious capsule; K. pneumoniae expresses a thick polysaccharide capsule with hypermucoviscous phenotype"
).
phenotypic_difference(
    escherichia_coli, klebsiella_pneumoniae, common_clinical_infection,
    "E. coli is the leading cause of UTI and neonatal meningitis; K. pneumoniae is a major cause of hospital-acquired pneumonia and liver abscess"
).

phenotypic_difference(
    pseudomonas_aeruginosa, acinetobacter_baumannii, environmental_adaptability,
    "P. aeruginosa prefers moist aquatic environments; A. baumannii tolerates desiccation and survives long on dry surfaces"
).
phenotypic_difference(
    pseudomonas_aeruginosa, acinetobacter_baumannii, carbapenem_resistance_mechanism,
    "P. aeruginosa carbapenem resistance mainly involves OprD porin loss and metallo-beta-lactamases; A. baumannii mainly produces OXA-class carbapenemases"
).
phenotypic_difference(
    pseudomonas_aeruginosa, acinetobacter_baumannii, typical_infection,
    "P. aeruginosa causes cystic fibrosis chronic lung infection and burn wound infection; A. baumannii causes ventilator-associated pneumonia and catheter-related bloodstream infection"
).

phenotypic_difference(
    klebsiella_pneumoniae, klebsiella_oxytoca, indole_test,
    "K. pneumoniae is indole-negative; K. oxytoca is indole-positive"
).
phenotypic_difference(
    klebsiella_pneumoniae, klebsiella_oxytoca, virulence_level,
    "K. pneumoniae includes hypervirulent strains causing invasive liver abscess; K. oxytoca has lower virulence and mainly causes nosocomial infection"
).

phenotypic_difference(
    proteus_mirabilis, proteus_vulgaris, indole_test,
    "P. mirabilis is indole-negative; P. vulgaris is indole-positive"
).
phenotypic_difference(
    proteus_mirabilis, proteus_vulgaris, swarming_growth,
    "Both show swarming growth on blood agar; P. mirabilis has more pronounced swarming phenomenon"
).

phenotypic_difference(
    helicobacter_pylori, campylobacter_jejuni, colonization_site,
    "H. pylori colonizes gastric mucosa; C. jejuni colonizes small intestinal mucosa"
).
phenotypic_difference(
    helicobacter_pylori, campylobacter_jejuni, urease_test,
    "H. pylori is strongly urease-positive; C. jejuni is urease-negative"
).
phenotypic_difference(
    helicobacter_pylori, campylobacter_jejuni, clinical_disease,
    "H. pylori causes chronic gastritis, peptic ulcer and gastric cancer; C. jejuni causes acute inflammatory diarrhea"
).

phenotypic_difference(
    vibrio_cholerae, vibrio_parahaemolyticus, salt_optimum,
    "V. cholerae grows in 0.5% NaCl (non-halophilic); V. parahaemolyticus requires 3-3.5% NaCl (halophilic)"
).
phenotypic_difference(
    vibrio_cholerae, vibrio_parahaemolyticus, disease_severity,
    "V. cholerae causes severe life-threatening watery diarrhea with cholera toxin; V. parahaemolyticus causes self-limiting seafood gastroenteritis"
).

phenotypic_difference(
    haemophilus_influenzae_type_b, nontypeable_haemophilus_influenzae, capsule_presence,
    "Type b strains have a type-specific polysaccharide capsule; Nontypeable strains have no capsule"
).
phenotypic_difference(
    haemophilus_influenzae_type_b, nontypeable_haemophilus_influenzae, disease_type,
    "Type b causes invasive meningitis and epiglottitis in children; Nontypeable strains cause otitis media and COPD exacerbations"
).

phenotypic_difference(
    neisseria_meningitidis, neisseria_gonorrhoeae, capsule,
    "N. meningitidis has a polysaccharide capsule for serogroup typing; N. gonorrhoeae lacks a capsule"
).
phenotypic_difference(
    neisseria_meningitidis, neisseria_gonorrhoeae, disease_type,
    "N. meningitidis causes meningitis and septicemia; N. gonorrhoeae causes urogenital gonorrhea"
).

% ------------------------------
% 6.4 Special Pathogen Phenotypic Differences
% ------------------------------
phenotypic_difference(
    treponema_pallidum, leptospira_interrogans, spiral_morphology,
    "T. pallidum has tight, regular spirals with pointed ends; Leptospira have loose spirals with hooked ends"
).
phenotypic_difference(
    treponema_pallidum, leptospira_interrogans, cultivability,
    "T. pallidum cannot be cultured on artificial media; Leptospira can be cultured in Korthof liquid medium"
).
phenotypic_difference(
    treponema_pallidum, leptospira_interrogans, transmission_route,
    "T. pallidum is transmitted via sexual contact and transplacental route; Leptospira is transmitted via contact with contaminated water"
).

phenotypic_difference(
    chlamydia_trachomatis, chlamydia_pneumoniae, inclusion_glycogen,
    "C. trachomatis inclusions contain glycogen and stain positive with iodine; C. pneumoniae inclusions have no glycogen and are iodine-negative"
).
phenotypic_difference(
    chlamydia_trachomatis, chlamydia_pneumoniae, primary_infection_site,
    "C. trachomatis infects ocular and urogenital mucosa; C. pneumoniae infects respiratory tract and causes atypical pneumonia"
).

phenotypic_difference(
    rickettsia_prowazekii, orientia_tsutsugamushi, vector,
    "R. prowazekii is transmitted by body lice; O. tsutsugamushi is transmitted by chigger mites"
).
phenotypic_difference(
    rickettsia_prowazekii, orientia_tsutsugamushi, intracellular_location,
    "Rickettsia grow in endothelial cell cytoplasm; Orientia grow in both cytoplasm and nucleus of host cells"
).

% ------------------------------
% 6.5 Phenotypic Difference Inference Rules
% ------------------------------
% Automatic downward inheritance of group differences: parent class differences apply to all subordinate species
phenotypic_difference(Sp1, Sp2, Dim, Desc) :-
    is_a(Sp1, Parent1),
    is_a(Sp2, Parent2),
    phenotypic_difference(Parent1, Parent2, Dim, Desc),
    Sp1 \= Parent1,
    Sp2 \= Parent2,
    Parent1 \= Parent2.

% Phenotypic difference specific query utilities
all_differences_between(Species1, Species2, DiffList) :-
    findall([Dimension, Description], phenotypic_difference(Species1, Species2, Dimension, Description), DiffList).
all_pairs_by_dimension(Dimension, PairList) :-
    findall([Species1, Species2, Description], phenotypic_difference(Species1, Species2, Dimension, Description), PairList).
all_differences_of(Species, DiffSummary) :-
    findall([OtherSpecies, Dimension, Desc],
        (phenotypic_difference(Species, OtherSpecies, Dimension, Desc);
         phenotypic_difference(OtherSpecies, Species, Dimension, Desc)),
        DiffSummary).
