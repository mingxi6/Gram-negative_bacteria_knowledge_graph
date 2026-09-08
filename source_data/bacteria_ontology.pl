% ==============================================================================
% Basic Metadata of Ontology
% ==============================================================================
ontology_info(gram_negative_bacteria, microbiology, 'Gram-Negative Bacteria Comprehensive Knowledge Graph').
ontology_author('Microbiology Ontology Modeller').
ontology_version('2.1').
ontology_time_range('2016-2026').
ontology_use_scope(education_and_research_only).
ontology_clinical_use_status(blocked_pending_taxonomy_and_reference_validation).
predicate_use_status(gram_neg_antibiotic_profile/4, teaching_summary_not_patient_or_isolate_susceptibility).
predicate_use_status(gram_neg_species_trait/4, descriptive_summary_not_diagnostic_rule).
ontology_validation_gap(current_taxonomy_authority_and_synonym_reconciliation).
ontology_validation_gap(reference_identifier_doi_pmid_or_isbn_mapping).
ontology_validation_gap(linkage_to_clinical_coverage_and_ast_standard_versions).
ontology_theoretical_basis([
    'Endosymbiosis theory for eukaryote origin',
    'Peptidoglycan biosynthesis and cell envelope assembly theory',
    'LPS endotoxin innate immune activation theory',
    'Outer membrane permeability barrier theory of Gram-negative bacteria',
    'RND efflux pump multidrug resistance theory',
    'Horizontal gene transfer mediated mobile antibiotic resistance gene dissemination theory',
    'Gram staining differential decolorization physical chemistry theory',
    'Plasmid & integron mediated resistance transmission theory'
]).

% ==============================================================================
% Part 1: Taxonomy Hierarchy Ontology (Core KG Nodes: Domain->Phylum->Class->Order->Family->Genus->Species)
% ==============================================================================
% Define taxonomic rank level
taxon_rank('Eukaryota', domain).
taxon_rank('Bacteria', domain).
taxon_rank('Archaea', domain).
taxon_rank('Proteobacteria', phylum).
taxon_rank('Betaproteobacteria', class).
taxon_rank('Gammaproteobacteria', class).
taxon_rank('Alphaproteobacteria', class).
taxon_rank('Deltaproteobacteria', class).
taxon_rank('Epsilonproteobacteria', class).
taxon_rank('Neisseriales', order).
taxon_rank('Enterobacterales', order).
taxon_rank('Pseudomonadales', order).
taxon_rank('Rhizobiales', order).
taxon_rank('Myxococcales', order).
taxon_rank('Campylobacterales', order).
taxon_rank('Neisseriaceae', family).
taxon_rank('Enterobacteriaceae', family).
taxon_rank('Pseudomonadaceae', family).
taxon_rank('Rhizobiaceae', family).
taxon_rank('Myxococcaceae', family).
taxon_rank('Helicobacteraceae', family).
taxon_rank('Campylobacteraceae', family).
taxon_rank('Neisseria', genus).
taxon_rank('Escherichia', genus).
taxon_rank('Klebsiella', genus).
taxon_rank('Salmonella', genus).
taxon_rank('Pseudomonas', genus).
taxon_rank('Rhizobium', genus).
taxon_rank('Myxococcus', genus).
taxon_rank('Helicobacter', genus).
taxon_rank('Campylobacter', genus).
taxon_rank(neisseria_gonorrhoeae, species).
taxon_rank(neisseria_meningitidis, species).
taxon_rank(escherichia_coli, species).
taxon_rank(klebsiella_pneumoniae, species).
taxon_rank(salmonella_enterica, species).
taxon_rank(pseudomonas_aeruginosa, species).
taxon_rank(rhizobium_leguminosarum, species).
taxon_rank(myxococcus_xanthus, species).
taxon_rank(helicobacter_pylori, species).
taxon_rank(campylobacter_jejuni, species).

% Parent-child taxonomic hierarchical relationship (KG hierarchical edges)
taxon_parent('Proteobacteria', 'Bacteria').
taxon_parent('Betaproteobacteria', 'Proteobacteria').
taxon_parent('Gammaproteobacteria', 'Proteobacteria').
taxon_parent('Alphaproteobacteria', 'Proteobacteria').
taxon_parent('Deltaproteobacteria', 'Proteobacteria').
taxon_parent('Epsilonproteobacteria', 'Proteobacteria').
taxon_parent('Neisseriales', 'Betaproteobacteria').
taxon_parent('Enterobacterales', 'Gammaproteobacteria').
taxon_parent('Pseudomonadales', 'Gammaproteobacteria').
taxon_parent('Rhizobiales', 'Alphaproteobacteria').
taxon_parent('Myxococcales', 'Deltaproteobacteria').
taxon_parent('Campylobacterales', 'Epsilonproteobacteria').
taxon_parent('Neisseriaceae', 'Neisseriales').
taxon_parent('Enterobacteriaceae', 'Enterobacterales').
taxon_parent('Pseudomonadaceae', 'Pseudomonadales').
taxon_parent('Rhizobiaceae', 'Rhizobiales').
taxon_parent('Myxococcaceae', 'Myxococcales').
taxon_parent('Helicobacteraceae', 'Campylobacterales').
taxon_parent('Campylobacteraceae', 'Campylobacterales').
taxon_parent('Neisseria', 'Neisseriaceae').
taxon_parent('Escherichia', 'Enterobacteriaceae').
taxon_parent('Klebsiella', 'Enterobacteriaceae').
taxon_parent('Salmonella', 'Enterobacteriaceae').
taxon_parent('Pseudomonas', 'Pseudomonadaceae').
taxon_parent('Rhizobium', 'Rhizobiaceae').
taxon_parent('Myxococcus', 'Myxococcaceae').
taxon_parent('Helicobacter', 'Helicobacteraceae').
taxon_parent('Campylobacter', 'Campylobacteraceae').
taxon_parent(neisseria_gonorrhoeae, 'Neisseria').
taxon_parent(neisseria_meningitidis, 'Neisseria').
taxon_parent(escherichia_coli, 'Escherichia').
taxon_parent(klebsiella_pneumoniae, 'Klebsiella').
taxon_parent(salmonella_enterica, 'Salmonella').
taxon_parent(pseudomonas_aeruginosa, 'Pseudomonas').
taxon_parent(rhizobium_leguminosarum, 'Rhizobium').
taxon_parent(myxococcus_xanthus, 'Myxococcus').
taxon_parent(helicobacter_pylori, 'Helicobacter').
taxon_parent(campylobacter_jejuni, 'Campylobacter').

% Gram staining attribute linkage (recursive: covers all descendants of Proteobacteria)
gram_stain(Taxon, negative) :- taxon_parent(Taxon, 'Proteobacteria').
gram_stain(Taxon, negative) :-
    taxon_parent(Taxon, Parent),
    gram_stain(Parent, negative).
gram_stain('Bacteria', indeterminate).
gram_stain('Eukaryota', non_stainable).
gram_stain('Archaea', variable).

% Cell type classification: prokaryote / eukaryote (recursive)
cell_type(Taxon, prokaryote) :- taxon_parent(Taxon, 'Bacteria').
cell_type(Taxon, prokaryote) :-
    taxon_parent(Taxon, Parent),
    cell_type(Parent, prokaryote).
cell_type(Taxon, eukaryote) :- taxon_parent(Taxon, 'Eukaryota').
cell_type(Taxon, eukaryote) :-
    taxon_parent(Taxon, Parent),
    cell_type(Parent, eukaryote).

% Supplementary theoretical fact: taxonomic classification standard basis
taxonomy_theory_basis('Proteobacteria', '16S rRNA gene sequence homology classification theory', ref08).

% ==============================================================================
% Part 2: Prokaryote VS Eukaryote Feature Comparison Ontology
% ==============================================================================
cell_feature(prokaryote, membrane_bound_nucleus, absent, ref08).
cell_feature(eukaryote, membrane_bound_nucleus, present, ref08).

cell_feature(prokaryote, membrane_organelles, absent, ref08).
cell_feature(eukaryote, membrane_organelles, present, ref08).

cell_feature(prokaryote, cytoplasmic_ribosome, '70S', ref08).
cell_feature(eukaryote, cytoplasmic_ribosome, '80S', ref08).

cell_feature(prokaryote, primary_chromosome, single_circular, ref08).
cell_feature(eukaryote, primary_chromosome, multiple_linear, ref08).

cell_feature(prokaryote, cell_wall_peptidoglycan, present, ref12).
cell_feature(eukaryote, cell_wall_peptidoglycan, absent, ref12).

cell_feature(prokaryote, asexual_binary_fission, present, ref08).
cell_feature(eukaryote, asexual_mitosis, present, ref08).

cell_feature(prokaryote, horizontal_gene_transfer, present, ref11).
cell_feature(eukaryote, horizontal_gene_transfer, rare, ref11).

% Enriched supplementary comparison items based on endosymbiosis & cell biology theory
cell_feature(prokaryote, intron_gene_structure, absent, ref08).
cell_feature(eukaryote, intron_gene_structure, present, ref08).
cell_feature(prokaryote, transcription_translation_coupling, present, ref08).
cell_feature(eukaryote, transcription_translation_separated, present, ref08).
cell_feature(prokaryote, sterol_membrane_component, absent, ref04).
cell_feature(eukaryote, sterol_membrane_component, present, ref04).
cell_feature(prokaryote, meiosis_sexual_reproduction, absent, ref08).
cell_feature(eukaryote, meiosis_sexual_reproduction, present, ref08).

% ==============================================================================
% Part 3: Unique Structural & Physiological Feature Ontology of Gram-Negative Bacteria
% ==============================================================================
gram_neg_unique_feature(double_bilayer_envelope, 'Two-layer membrane system: inner cytoplasmic membrane + outer membrane', ref01).
gram_neg_unique_feature(lipopolysaccharide_outer_membrane, 'Outer membrane contains LPS (endotoxin) composed of lipid A, core oligosaccharide, O-antigen', ref03).
gram_neg_unique_feature(thin_peptidoglycan_layer, 'Peptidoglycan layer thickness 2-7 nm, located within periplasmic space', ref12).
gram_neg_unique_feature(periplasmic_compartment, 'Wide periplasmic space between two membranes storing hydrolytic enzymes and binding proteins', ref04).
gram_neg_unique_feature(outer_membrane_porins, 'Porin channel proteins allow passive diffusion of small hydrophilic molecules (<600 Da)', ref04).
gram_neg_unique_feature(gram_decolorization_property, 'Ethanol washes out crystal violet-iodine complex; counterstained pink-red by safranin', ref08).
gram_neg_unique_feature(endotoxin_virulence_factor, 'Lipid A triggers host inflammatory cascade, sepsis and septic shock', ref09).
gram_neg_unique_feature(chromosomal_ampc_beta_lactamase, 'Intrinsic chromosomal AmpC enzyme mediates partial cephalosporin resistance', ref05).

% Enriched theoretical supplementary features
gram_neg_unique_feature(outer_membrane_vesicles, 'Outer membrane vesicles (OMVs) bud from outer membrane, deliver LPS, virulence factors and resistance genes to host cells', ref11).
gram_neg_unique_feature(rnd_efflux_system, 'Chromosomal RND efflux pumps span inner and outer membrane, extrude multiple classes of antibiotics out of cell', ref06).
gram_neg_unique_feature(lps_modification_plasticity, 'LPS lipid A can be chemically modified under cationic antimicrobial pressure to reduce negative surface charge and evade binding', ref02).
gram_neg_unique_feature(sec_tat_secretion_dual_pathway, 'Periplasmic space supports both Sec and Tat protein secretion systems for extracellular virulence factor transport', ref01).

% ==============================================================================
% Part 4: Gram-Negative VS Gram-Positive Bacteria Trait Comparison Ontology
% ==============================================================================
gram_comparison(cell_envelope_layers, dual_membrane_system, single_membrane_system, ref01).
gram_comparison(peptidoglycan_thickness, thin_2_7nm, thick_20_80nm, ref12).
gram_comparison(lipopolysaccharide_content, present, absent, ref03).
gram_comparison(teichoic_acids, absent, abundant, ref12).
gram_comparison(periplasmic_space, wide, minimal_or_narrow, ref04).
gram_comparison(outer_membrane_porins, abundant, absent, ref04).
gram_comparison(final_gram_stain_color, pink_red, purple_blue, ref08).
gram_comparison(intrinsic_vancomycin_susceptibility, resistant, susceptible, ref04).
gram_comparison(intrinsic_macrolide_permeability, low, high, ref04).

% Supplementary comparison items based on cell envelope theory
gram_comparison(outer_membrane_vesicle_secretion, high_abundance, rare, ref11).
gram_comparison(chromosomal_ampc_beta_lactamase, widespread, rare, ref05).
gram_comparison(innate_colistin_susceptibility, variable, intrinsically_resistant, ref02).
gram_comparison(major_efflux_family, rnd_family, mfs_family, ref06).

% ==============================================================================
% Part 5: Virulence & Clinical Trait Ontology of Representative Gram-Negative Species
% ==============================================================================
gram_neg_species_trait(escherichia_coli, habitat, 'Commensal resident of human intestinal tract; pathotypes cause UTI, hemorrhagic diarrhea, neonatal sepsis', ref09).
gram_neg_species_trait(klebsiella_pneumoniae, virulence, 'Thick polysaccharide capsule inhibits phagocytosis; major nosocomial pathogen for pneumonia and abscesses', ref08).
gram_neg_species_trait(salmonella_enterica, invasion, 'Invades intestinal epithelial cells, induces foodborne gastroenteritis and systemic enteric fever', ref08).
gram_neg_species_trait(pseudomonas_aeruginosa, physiology, 'Obligate aerobe with broad metabolic versatility; multidrug-resistant opportunistic pathogen for burn and cystic fibrosis patients', ref07).
gram_neg_species_trait(neisseria_gonorrhoeae, niche, 'Strict human-specific pathogen colonizing urogenital mucosa, causative agent of gonorrhea', ref08).
gram_neg_species_trait(neisseria_meningitidis, virulence, 'Capsular polysaccharide mediates bloodstream invasion and meningitis, naturally competent for horizontal gene transformation', ref08).
gram_neg_species_trait(helicobacter_pylori, virulence, 'Urease-mediated acid neutralization enables gastric colonization; CagA and VacA toxins cause chronic gastritis and peptic ulcer', ref09).
gram_neg_species_trait(campylobacter_jejuni, invasion, 'Most common cause of bacterial gastroenteritis worldwide; post-infectious Guillain-Barre syndrome risk', ref08).

% Supplementary theoretical virulence mechanism fact
gram_neg_virulence_theory('LPS endotoxin shock', 'Lipid A activates TLR4/MD2 innate immune receptor pathway to release pro-inflammatory cytokines TNF-alpha, IL-1, IL-6', ref09).
gram_neg_virulence_theory('Type III secretion system', 'Injectisome secretion system delivers effector proteins into host cytoplasm to disrupt epithelial barrier function', ref07).
gram_neg_virulence_theory('Quorum sensing virulence regulation', 'AHL-based quorum sensing coordinates biofilm formation and virulence factor expression at population density threshold', ref07).

% ==============================================================================
% Part 6: Antibiotic Susceptibility Ontology of Gram-Negative Bacteria
% ==============================================================================
gram_neg_antibiotic_profile(aminoglycosides, 'Bind 30S ribosomal subunit, block protein translation', susceptible, ref10).
gram_neg_antibiotic_profile(carbapenems, 'Inhibit peptidoglycan transpeptidase, broad-spectrum bactericidal activity', susceptible, ref05).
gram_neg_antibiotic_profile(macrolides, 'Poor penetration across outer membrane barrier, low intrinsic susceptibility', resistant, ref04).
gram_neg_antibiotic_profile(vancomycin, 'High molecular weight cannot cross outer membrane, intrinsically resistant', resistant, ref04).
gram_neg_antibiotic_profile(fluoroquinolones, 'Inhibit DNA gyrase and topoisomerase IV, disrupt DNA replication', susceptible, ref10).
gram_neg_antibiotic_profile(penicillin_g, 'Outer membrane barrier reduces penetration, weak activity', resistant, ref05).
gram_neg_antibiotic_profile(polymyxins, 'Bind LPS lipid A; resistance arises via pEtN LPS modification', variable, ref02).

% Supplementary theoretical drug resistance classification fact
resistance_mechanism_theory(outer_membrane_permeability_reduction, 'Porin downregulation reduces drug influx across outer membrane', ref04).
resistance_mechanism_theory(efflux_overexpression, 'Overexpressed RND efflux pumps continuously extrude antibiotics out of periplasm', ref06).
resistance_mechanism_theory(beta_lactamase_hydrolysis, 'Chromosomal or acquired beta-lactamases hydrolyze beta-lactam ring structure', ref05).
resistance_mechanism_theory(lps_modification, 'Lipid A chemical modification eliminates polymyxin binding site', ref02).

% ==============================================================================
% Part 7: Knowledge Graph Complete Reasoning Rules (Ontology Query & Trace Logic)
% ==============================================================================
% Judge whether a taxon belongs to Gram-negative bacteria
is_gram_negative(Taxon) :-
    cell_type(Taxon, prokaryote),
    gram_stain(Taxon, negative).

% Judge whether a taxon is eukaryote
is_eukaryotic(Taxon) :-
    cell_type(Taxon, eukaryote).

% Obtain all unique characteristic names of Gram-negative bacteria
get_all_gram_neg_features(FeatureList) :-
    findall(Feature, gram_neg_unique_feature(Feature, _, _), FeatureList).

% Query single trait comparison between Gram-negative and Gram-positive
get_single_trait_comparison(Trait, GramNegDesc, GramPosDesc, RefID) :-
    gram_comparison(Trait, GramNegDesc, GramPosDesc, RefID).

% Obtain all trait records of specified Gram-negative species
get_species_all_traits(Species, TraitRecord) :-
    gram_neg_species_trait(Species, TraitType, Desc, RefID),
    TraitRecord = trait(TraitType, Desc, RefID).

% Query antibiotic mechanism and susceptibility information
get_antibiotic_info(DrugClass, Mechanism, Susceptibility, RefID) :-
    gram_neg_antibiotic_profile(DrugClass, Mechanism, Susceptibility, RefID).

% Recursively acquire full taxonomic lineage (Species->Genus->Family->Order->Class->Phylum->Domain)
taxonomic_lineage(Taxon, [Taxon|RestLineage]) :-
    taxon_parent(Taxon, Parent),
    taxonomic_lineage(Parent, RestLineage).
taxonomic_lineage(Taxon, [Taxon]) :-
    taxon_rank(Taxon, domain).

% Retrieve complete reference according to reference ID (core trace interface)
get_ref_gbt7714(RefID, FullGBTCite, Journal, PublishYear, ResearchField) :-
    ref(RefID, FullGBTCite, Journal, PublishYear, ResearchField).

% Reverse trace: query all reference IDs supporting specified feature
find_all_refs_for_feature(TargetFeature, RefIDList) :-
    findall(R, gram_neg_unique_feature(TargetFeature, _, R), R1),
    findall(R, cell_feature(_, TargetFeature, _, R), R2),
    findall(R, gram_comparison(TargetFeature, _, _, R), R3),
    append([R1,R2,R3], AllRawRef),
    sort(AllRawRef, RefIDList).

% Batch export all standardized reference lists
export_all_gbt_refs(AllReferenceList) :-
    findall(Citation, ref(_, Citation, _, _, _), AllReferenceList).

% Query all theoretical basis of virulence mechanism
get_all_virulence_theory(TheoryList) :-
    findall(Theory, gram_neg_virulence_theory(Theory, _, _), TheoryList).

% Query all antibiotic resistance theoretical mechanisms
get_all_resistance_theory(MechanismList) :-
    findall(Mechanism, resistance_mechanism_theory(Mechanism, _, _), MechanismList).

% Query taxonomic classification theory of specified taxon
get_taxonomy_theory(Taxon, Theory, RefID) :-
    taxonomy_theory_basis(Taxon, Theory, RefID).

% ==============================================================================
% Appendix: Reference Entity
% ==============================================================================
ref(ref01, 'XU F, XIE Y, YU W, et al. Breaking the outer membrane barrier: structure, targets, and antimicrobial strategies for Gram-negative bacteria[J]. Frontiers in Microbiology, 2026, 17:1734749.', 'Frontiers in Microbiology', 2026, 'Outer membrane structure & antibiotic penetration').
ref(ref02, 'SCHUMANN A, GABALLA A, WIEDMANN M. The multifaceted roles of phosphoethanolamine-modified lipopolysaccharides: from stress response and virulence to cationic antimicrobial resistance[J]. Microbiology and Molecular Biology Reviews, 2024, 88(4):e00193-23.', 'Microbiology and Molecular Biology Reviews', 2024, 'LPS modification, colistin resistance').
ref(ref03, 'SPERANDEO P, DEHO G, POLISSI A. LPS biosynthesis and transport as therapeutic targets against multidrug-resistant Gram-negative bacteria[J]. Annual Review of Microbiology, 2022, 76:421-443.', 'Annual Review of Microbiology', 2022, 'LPS synthesis, membrane biogenesis').
ref(ref04, 'HUSAIN M, NIKAIDO H. Outer membrane permeability revisited: porins, efflux pumps and antibiotic resistance in Gram-negative pathogens[J]. Nature Reviews Microbiology, 2021, 19(10):621-636.', 'Nature Reviews Microbiology', 2021, 'Porin, efflux pump, intrinsic resistance').
ref(ref05, 'BUSH K. Beta-lactamases and resistance in Gram-negative bacteria: update 2020-2025[J]. Clinical Microbiology Reviews, 2025, 38(2):e00112-24.', 'Clinical Microbiology Reviews', 2025, 'Beta-lactamase, AmpC, carbapenemase').
ref(ref06, 'LI X, ZHANG Y. RND efflux pumps: master regulators of multidrug resistance in Enterobacterales and Pseudomonas aeruginosa[J]. Journal of Antimicrobial Chemotherapy, 2025, 80(9):2411-2428.', 'Journal of Antimicrobial Chemotherapy', 2025, 'RND efflux, cross-class antibiotic resistance').
ref(ref07, 'DI PILATO V, CARRARA S, GROSSI F, et al. The microbiology and pathogenesis of nonfermenting Gram-negative infections[J]. Current Opinion in Infectious Diseases, 2023, 36(6):537-544.', 'Current Opinion in Infectious Diseases', 2023, 'Pseudomonas, Acinetobacter virulence').
ref(ref08, 'OLIVEIRA J, REYGAERT W C. Gram-Negative Bacteria[M]//STATPEARLS TEAM. StatPearls. Treasure Island: StatPearls Publishing, 2023.', 'StatPearls', 2023, 'Clinical classification, nosocomial pathogens').
ref(ref09, 'CANI P D. Gut microbial LPS, metabolic inflammation and host immunity[J]. Nature Reviews Gastroenterology & Hepatology, 2024, 21(7):441-456.', 'Nature Reviews Gastroenterology & Hepatology', 2024, 'Endotoxin immunopathology').
ref(ref10, 'WANG R Y, YANG Y S, ZHANG Y Y. Advances in novel anti-Gram-negative bacterial drugs targeting cell envelope and replication machinery[J]. Acta Pharmaceutica Sinica, 2025, 60(3):789-806.', 'Acta Pharmaceutica Sinica', 2025, 'Novel antibiotics, drug development').
ref(ref11, 'SABNIS A, LANGFORD P R, KAY D, et al. Horizontal gene transfer and mobile resistance elements in Gram-negative bacteria[J]. Journal of Infectious Diseases, 2026, 233(5):891-902.', 'Journal of Infectious Diseases', 2026, 'ARG spread, plasmid, OMV vesiduction').
ref(ref12, 'VOLLMER W. Peptidoglycan remodelling in Gram-negative bacteria under antibiotic stress[J]. Nature Reviews Microbiology, 2019, 17(8):473-486.', 'Nature Reviews Microbiology', 2019, 'Peptidoglycan structure & stress adaptation').
