:- encoding(utf8).

% ==============================================
% 【顶层本体：一级大类定义】知识图谱最高层级分类
% ==============================================
top_category(cell_structure, "Cell structure properties").
top_category(physio_biochem, "Biochemical staining & culture physiology").
top_category(virulence, "Virulence & pathogenicity").
top_category(antibiotic_resistance, "Antibiotic resistance").

% 核心研究实体
bacterium(gram_negative_bacteria, "Gram-negative bacteria").

% 一级大类与实体的归属关系
has_top_category(gram_negative_bacteria, cell_structure).
has_top_category(gram_negative_bacteria, physio_biochem).
has_top_category(gram_negative_bacteria, virulence).
has_top_category(gram_negative_bacteria, antibiotic_resistance).

% ==============================================
% 【二级子类：细胞结构属性下的三大分支】
% ==============================================
sub_category(cell_wall, cell_structure, "Cell wall structural properties").
sub_category(appendage, cell_structure, "Appendage structural properties").
sub_category(intracellular, cell_structure, "Intracellular organelle & cytoplasmic structure properties").

% 二级子类归属关联
has_sub_category(cell_structure, cell_wall).
has_sub_category(cell_structure, appendage).
has_sub_category(cell_structure, intracellular).

% ==============================================
% 一、细胞壁结构属性 - 具体实体与属性
% ==============================================
% 细胞壁下属具体结构实体
entity(peptidoglycan_layer, cell_wall, "Peptidoglycan thin layer").
entity(outer_membrane, cell_wall, "Outer membrane (unique to Gram-negative bacteria)").
entity(periplasmic_space, cell_wall, "Periplasmic space").
entity(braun_lipoprotein, cell_wall, "Braun's lipoprotein").

% 肽聚糖薄层 结构属性
struct_property(peptidoglycan_layer, thickness, "2-7 nm thick, 1-2 glycan layers only, accounting for 5%-10% of cell wall dry weight").
struct_property(peptidoglycan_layer, composition, "Glycan backbone formed by alternating N-acetylglucosamine and N-acetylmuramic acid, linked to tetrapeptide side chains").
struct_property(peptidoglycan_layer, crosslink_mode, "No pentapeptide cross-bridge; directly crosslinked by D-alanine and diaminopimelic acid (DAP), low crosslinking rate").
struct_property(peptidoglycan_layer, mechanical_strength, "Low mechanical strength; easily penetrated by ethanol, cannot retain crystal violet-iodine complex").
struct_property(peptidoglycan_layer, drug_target, "Target of beta-lactam antibiotics, which inhibit peptidoglycan crosslinking").
struct_property(peptidoglycan_layer, lysozyme_target, "Lysozyme hydrolyzes glycosidic bonds of glycan backbone and causes bacterial lysis").

% 外膜 结构属性（革兰氏阴性菌核心特有结构）
struct_property(outer_membrane, basic_structure, "Asymmetric lipid bilayer; inner layer is phospholipid, outer layer is mainly lipopolysaccharide (LPS)").
struct_property(outer_membrane, main_components, "Lipopolysaccharide (LPS), phospholipids, outer membrane porins, outer membrane proteases, lipoproteins").
struct_property(outer_membrane, porin_type, "Non-specific porins (OmpF/OmpC) control small molecule permeability; specific porins transport dedicated substrates").
struct_property(outer_membrane, lps_structure, "LPS consists of three covalently linked parts: lipid A, core polysaccharide, O-specific side chain").
struct_property(outer_membrane, lipid_a_function, "Lipid A is the core toxic moiety of endotoxin, no species specificity").
struct_property(outer_membrane, core_polysaccharide, "Core polysaccharide has genus specificity, located between lipid A and O-side chain").
struct_property(outer_membrane, o_antigen, "O-specific side chain (O-antigen) has species/type specificity, can undergo antigenic variation to evade immunity").
struct_property(outer_membrane, barrier_function, "Natural permeability barrier, blocks macromolecular and hydrophobic antibiotics, mediates intrinsic resistance").
struct_property(outer_membrane, permeability, "Permeability is only 1/100 of Gram-positive bacteria; intrinsically resistant to vancomycin and macrolides").

% 周质空间 结构属性
struct_property(periplasmic_space, location, "Closed colloidal gap between inner and outer membrane, accounting for 20%-40% of cell volume").
struct_property(periplasmic_space, contained_proteins, "Contains hydrolases, synthases, substrate-binding proteins, chemoreceptors, detoxifying enzymes").
struct_property(periplasmic_space, beta_lactamase, "Enriched with beta-lactamases, which hydrolyze penicillins and cephalosporins in situ").
struct_property(periplasmic_space, transport_function, "Participates in nutrient binding, transport, preliminary processing and environmental signal sensing").
struct_property(periplasmic_space, stress_response, "Involved in osmoregulation, oxidative stress response and protein folding quality control").

% 布劳恩脂蛋白 结构属性
struct_property(braun_lipoprotein, linkage_mode, "N-terminus covalently linked to peptidoglycan layer; C-terminus non-covalently anchored to inner leaflet of outer membrane").
struct_property(braun_lipoprotein, function, "Maintains structural stability between outer membrane and peptidoglycan layer, ensures cell envelope integrity").
struct_property(braun_lipoprotein, abundance, "The most abundant protein in E. coli, approximately 10^5 copies per cell").

% ==============================================
% 二、附属结构属性 - 具体实体与属性
% ==============================================
entity(flagellum, appendage, "Flagellum").
entity(common_pilus, appendage, "Common pilus (fimbria)").
entity(sex_pilus, appendage, "Sex pilus").
entity(capsule, appendage, "Capsule").
entity(biofilm, appendage, "Biofilm").
entity(outer_membrane_vesicle, appendage, "Outer membrane vesicle (OMV)").

% 鞭毛 属性
struct_property(flagellum, structure, "Composed of basal body, hook and filament; basal body anchored to cell envelope").
struct_property(flagellum, motility, "Drives bacterial motility by rotation, enables chemotaxis toward nutrients and away from harmful environments").
struct_property(flagellum, virulence, "Mediates adhesion to host mucosal epithelium, promotes bacterial colonization and infection spread").
struct_property(flagellum, antigen, "Flagellin is H-antigen, highly specific and used for serotyping").
struct_property(flagellum, immune_activation, "Recognized by host TLR5, triggers innate immune inflammatory response").

% 普通菌毛 属性
struct_property(common_pilus, morphology, "Slender short straight protein fibers, 3-10 nm in diameter, up to hundreds per cell").
struct_property(common_pilus, core_function, "Mediates specific adhesion to host mucosal epithelial cells, the first step of infection and colonization").
struct_property(common_pilus, adhesin, "Tip carries adhesins that specifically recognize receptors on host cell surface").
struct_property(common_pilus, clinical_significance, "P pili and colonization factor pili of uropathogenic E. coli are key virulence factors").

% 性菌毛 属性
struct_property(sex_pilus, morphology, "Thicker and longer than common pili, few in number (1-4 per cell), encoded by F plasmid").
struct_property(sex_pilus, genetic_function, "Mediates bacterial conjugation, physical channel for horizontal gene transfer between bacteria").
struct_property(sex_pilus, resistance_spread, "Transfers resistance plasmids and virulence plasmids, accelerates cross-species spread of carbapenemase and colistin resistance genes").
struct_property(sex_pilus, phage_receptor, "Serves as adsorption receptor for filamentous phages, mediates transduction").

% 荚膜 属性
struct_property(capsule, composition, "Mainly polysaccharide polymers, few are polypeptides, thickness >= 0.2 um").
struct_property(capsule, immune_escape, "Masks bacterial surface antigens, resists phagocytosis and complement-mediated killing").
struct_property(capsule, anti_desiccation, "Rich in water, enhances bacterial resistance to desiccation").
struct_property(capsule, biofilm_component, "Important component of biofilm extracellular matrix").
struct_property(capsule, antigenicity, "Type-specific, can be used for bacterial typing and vaccine development").

% 生物膜 属性
struct_property(biofilm, composition, "Three-dimensional structure formed by bacterial community and secreted exopolysaccharides, eDNA, proteins and lipids").
struct_property(biofilm, formation_stage, "Four stages: initial adhesion, aggregation and proliferation, maturation and differentiation, dispersion and release").
struct_property(biofilm, resistance_effect, "Physical barrier blocks antibiotic penetration; nutrient limitation forms persisters; resistance increases 10-1000 fold").
struct_property(biofilm, immune_evasion, "Resists immune cell infiltration and killing, causes chronic persistent infection").
struct_property(biofilm, clinical_hazard, "Easily colonizes medical implant surfaces, major cause of nosocomial infections").

% 外膜囊泡(OMV) 属性
struct_property(outer_membrane_vesicle, formation, "Spherical vesicles 20-200 nm in diameter, formed by budding and shedding from outer membrane").
struct_property(outer_membrane_vesicle, cargo, "Encapsulates LPS, outer membrane proteins, proteases, virulence factors, resistance enzymes and nucleic acids").
struct_property(outer_membrane_vesicle, virulence_transport, "Delivers virulence proteins long-distance to host cells, induces inflammation and tissue damage").
struct_property(outer_membrane_vesicle, resistance_function, "Carries beta-lactamases to extracellular environment, degrades antibiotics in situ and protects the whole population").
struct_property(outer_membrane_vesicle, cell_communication, "Mediates intra/inter-species communication, material exchange and horizontal gene transfer").

% ==============================================
% 三、内部细胞器与胞质结构属性 - 具体实体与属性
% ==============================================
entity(inner_membrane, intracellular, "Cytoplasmic membrane (inner membrane)").
entity(ribosome_70s, intracellular, "70S ribosome").
entity(plasmid, intracellular, "Plasmid").
entity(nucleoid, intracellular, "Nucleoid").
entity(cytoplasmic_granule, intracellular, "Cytoplasmic inclusion granule").

% 细胞质膜（内膜）属性
struct_property(inner_membrane, structure, "Phospholipid bilayer with embedded proteins, no cholesterol, similar to eukaryotic cell membrane").
struct_property(inner_membrane, transport_function, "Selectively controls nutrient import and metabolic waste export via transporters").
struct_property(inner_membrane, energy_production, "Distributes respiratory chain and ATP synthase, main site of bacterial energy production").
struct_property(inner_membrane, biosynthesis, "Participates in biosynthesis of cell wall components: peptidoglycan, phospholipids, LPS precursors").
struct_property(inner_membrane, signal_transduction, "Distributes receptor proteins and histidine kinases, senses environmental signals and regulates gene expression").
struct_property(inner_membrane, efflux_pump, "Anchors inner membrane components of RND efflux pumps, works with outer membrane components for drug efflux").

% 70S核糖体 属性
struct_property(ribosome_70s, subunit, "Composed of 30S small subunit (with 16S rRNA) and 50S large subunit (with 23S and 5S rRNA)").
struct_property(ribosome_70s, function, "Core site of protein biosynthesis").
struct_property(ribosome_70s, drug_target, "Target of aminoglycosides, tetracyclines, macrolides and chloramphenicol").
struct_property(ribosome_70s, taxonomy, "16S rRNA gene sequence is the gold standard for bacterial classification and identification").

% 质粒 属性
struct_property(plasmid, nature, "Circular double-stranded DNA molecule independent of nucleoid, capable of autonomous replication").
struct_property(plasmid, classification, "F plasmid (fertility), R plasmid (resistance), virulence plasmid, metabolic plasmid, cryptic plasmid").
struct_property(plasmid, gene_carrier, "Carries non-essential traits: antibiotic resistance, virulence, heavy metal tolerance genes").
struct_property(plasmid, horizontal_transfer, "Transferable horizontally between same or different species via conjugation, transformation, transduction").
struct_property(plasmid, copy_number, "Stringent plasmids have low copy number (1-2 per cell); relaxed plasmids have high copy number (dozens per cell)").

% 拟核 属性
struct_property(nucleoid, structure, "Formed by coiled circular double-stranded DNA, bound to histone-like proteins, no nuclear membrane or nucleolus").
struct_property(nucleoid, function, "Stores all bacterial genetic information, controls main hereditary traits").
struct_property(nucleoid, genome_size, "Most pathogens have 2-6 Mb genome, encoding thousands of genes").
struct_property(nucleoid, gene_island, "Can integrate genomic islands, prophages and other foreign genetic elements to gain virulence and resistance").

% 胞质内含颗粒 属性
struct_property(cytoplasmic_granule, glycogen, "Glycogen granules: carbon and energy storage for metabolic emergency").
struct_property(cytoplasmic_granule, phb, "Poly-beta-hydroxybutyrate granules: lipid energy storage, raw material for biodegradable materials").
struct_property(cytoplasmic_granule, polyphosphate, "Metachromatic granules (polyphosphate): phosphorus and energy storage, used for bacterial identification").
struct_property(cytoplasmic_granule, function, "Stores nutrients, regulates intracellular osmotic pressure and metabolic homeostasis").

% ==============================================
% 四、生化染色与培养生理属性
% ==============================================
entity(gram_stain, physio_biochem, "Gram staining reaction").
entity(culture_trait, physio_biochem, "Culture growth characteristics").
entity(biochemical_reaction, physio_biochem, "Biochemical reaction features").
entity(stress_resistance, physio_biochem, "Environmental stress resistance").

% 革兰氏染色 属性
phys_property(gram_stain, staining_result, "Appears red/pink after ethanol decolorization and safranin counterstaining").
phys_property(gram_stain, principle, "Ethanol dissolves outer membrane lipids; thin loose peptidoglycan cannot retain crystal violet-iodine complex, so it is eluted and counterstained").
phys_property(gram_stain, staining_step, "Procedure: crystal violet primary stain -> iodine mordant -> 95% ethanol decolorization -> safranin counterstain").
phys_property(gram_stain, diagnostic_value, "The most basic and commonly used morphological classification basis for clinical bacterial identification").

% 培养生长特性 属性
phys_property(culture_trait, optimal_temp, "Optimal growth temperature for most pathogens is 37C, consistent with human body temperature").
phys_property(culture_trait, optimal_ph, "Optimal growth pH is 7.2-7.6, neutral to slightly alkaline").
phys_property(culture_trait, nutrition_demand, "Most grow on ordinary nutrient agar; fastidious bacteria require blood, serum or growth factors").
phys_property(culture_trait, oxygen_type, "Includes four metabolic types: obligate aerobe, facultative anaerobe, microaerophile, obligate anaerobe").
phys_property(culture_trait, clinical_common_type, "Major clinical pathogens are facultative anaerobes (Enterobacteriaceae) and aerobes (Pseudomonas, Acinetobacter)").
phys_property(culture_trait, selective_medium, "MacConkey, SS and other selective media inhibit Gram-positive bacteria and isolate Gram-negative rods").
phys_property(culture_trait, colony_feature, "Most form round, smooth, moist, medium-sized colonies with neat edges on ordinary agar").
phys_property(culture_trait, growth_curve, "Four growth phases: lag phase, logarithmic phase, stationary phase, decline phase").

% 生化反应特征 属性
phys_property(biochemical_reaction, glucose_ferment, "The vast majority ferment glucose to produce acid; some species produce gas").
phys_property(biochemical_reaction, oxidase, "Oxidase reaction varies: Pseudomonas positive, Enterobacteriaceae negative; key differential test").
phys_property(biochemical_reaction, catalase, "Most Gram-negative bacteria are catalase positive").
phys_property(biochemical_reaction, nitrate_reduction, "Most reduce nitrate to nitrite, an important identification basis").
phys_property(biochemical_reaction, imvic_test, "IMViC test is the core biochemical panel for genus identification of Enterobacteriaceae").
phys_property(biochemical_reaction, identification_value, "Biochemical reaction profile is the core basis for clinical species identification, principle of automated identification systems").

% 环境抵抗特性 属性
phys_property(stress_resistance, heat_resistance, "Most Gram-negative bacteria are killed by moist heat at 60C for 30 min; heat resistance is weaker than Gram-positive bacteria").
phys_property(stress_resistance, disinfectant, "Sensitive to common disinfectants; 75% ethanol and chlorine-containing disinfectants are effective").
phys_property(stress_resistance, osmotic_pressure, "Weak tolerance to hyperosmotic environment; prone to lysis in hypotonic environment").
phys_property(stress_resistance, lysozyme_sensitivity, "Lysozyme alone has poor effect; requires EDTA to disrupt outer membrane first").
phys_property(stress_resistance, antibiotic_spectrum, "Natural barrier effect against multiple antibiotics; available drug spectrum is narrower than Gram-positive bacteria").

% ==============================================
% 五、致病毒力属性
% ==============================================
entity(adhesion_colonization_factor, virulence, "Adhesion & colonization factors").
entity(invasion_factor, virulence, "Invasion & secretion system factors").
entity(toxin_factor, virulence, "Toxin factors").
entity(immune_escape_factor, virulence, "Immune evasion factors").
entity(iron_uptake_system, virulence, "Iron uptake system").

% 黏附定植因子 属性
virulence_property(adhesion_colonization_factor, pili_adhesin, "Common pili and non-pilus adhesins mediate specific binding to host epithelial receptors to achieve colonization").
virulence_property(adhesion_colonization_factor, capsule_adhesin, "Capsule and biofilm enhance non-specific adhesion and resist physical clearance").
virulence_property(adhesion_colonization_factor, flagellum_adhesin, "Flagella assist motility toward host surface and participate in initial adhesion").
virulence_property(adhesion_colonization_factor, infection_premise, "Adhesion and colonization are the prerequisite and first step of bacterial infection").

% 侵袭与分泌系统因子 属性
virulence_property(invasion_factor, invasin_protein, "Invasin proteins mediate bacterial invasion into non-phagocytic cells for intracellular parasitism and spread").
virulence_property(invasion_factor, t3ss_function, "Type III secretion system (T3SS): injects virulence effector proteins directly into host cells, disrupts cytoskeleton and immune signaling").
virulence_property(invasion_factor, t4ss_function, "Type IV secretion system (T4SS): transports DNA and proteins, involved in both conjugation and virulence delivery").
virulence_property(invasion_factor, t6ss_function, "Type VI secretion system (T6SS): kills competing bacteria and acts on host cells to promote infection").
virulence_property(invasion_factor, intracellular_survival, "Some species survive and replicate inside phagocytes to evade humoral immunity").

% 毒素因子 属性
virulence_property(toxin_factor, endotoxin_nature, "Endotoxin is LPS lipid A, a structural component of bacterial cell, released massively upon bacterial lysis").
virulence_property(toxin_factor, endotoxin_effect, "Causes fever, leukocytosis, microcirculation disorder, septic shock and disseminated intravascular coagulation (DIC)").
virulence_property(toxin_factor, endotoxin_feature, "High heat resistance, destroyed at 160C for 2-4 h; weak antigenicity, cannot be made into toxoid").
virulence_property(toxin_factor, exotoxin_nature, "Exotoxins are actively secreted by live bacteria, proteinaceous, extremely toxic, with tissue selectivity").
virulence_property(toxin_factor, exotoxin_type, "Three categories: enterotoxins, cytotoxins, neurotoxins, acting on intestine, tissue cells and nervous system respectively").
virulence_property(toxin_factor, exotoxin_feature, "Heat-labile, destroyed at 60C; strong antigenicity, can be detoxified by formaldehyde into toxoid vaccine").

% 免疫逃逸因子 属性
virulence_property(immune_escape_factor, anti_phagocytosis, "Capsule, pili and surface proteins resist phagocytosis and intracellular killing by phagocytes").
virulence_property(immune_escape_factor, complement_resistance, "LPS modification, capsule masking, surface protein binding complement regulatory proteins resist complement lysis").
virulence_property(immune_escape_factor, antigen_variation, "High-frequency variation of O-antigen and pilin evades host specific antibody recognition").
virulence_property(immune_escape_factor, immunosuppression, "Secretes immunosuppressive factors, interferes with host cytokine network and immune cell activation").
virulence_property(immune_escape_factor, biofilm_escape, "Biofilm structure blocks immune cell and antibody penetration, forms immune-privileged area").

% 铁摄取系统 属性
virulence_property(iron_uptake_system, siderophore, "Synthesizes and secretes siderophores with high affinity to chelate trace iron in the environment").
virulence_property(iron_uptake_system, heme_uptake, "Expresses heme receptors to directly acquire iron from host hemoglobin").
virulence_property(iron_uptake_system, virulence_significance, "Iron is an essential nutrient for bacteria; iron uptake capacity is a key virulence determinant").
virulence_property(iron_uptake_system, regulation, "Negatively regulated by iron concentration; highly expressed under iron deficiency, suppressed under iron sufficiency").

% ==============================================
% 六、耐药性属性
% ==============================================
entity(intrinsic_resistance, antibiotic_resistance, "Intrinsic resistance mechanism").
entity(acquired_resistance_mechanism, antibiotic_resistance, "Acquired resistance mechanism").
entity(resistance_gene_transfer, antibiotic_resistance, "Resistance gene horizontal transfer mechanism").
entity(resistance_regulation, antibiotic_resistance, "Resistance expression regulation mechanism").

% 天然耐药机制 属性
resist_property(intrinsic_resistance, outer_membrane_barrier, "Outer membrane is an effective natural permeability barrier, blocking entry of large and hydrophobic molecules").
resist_property(intrinsic_resistance, narrow_porin_channel, "OmpF/OmpC porins restrict molecular weight cut-off around 600 Da, blocking large antibiotics").
resist_property(intrinsic_resistance, constitutive_efflux, "Constitutive low-level expression of RND efflux pumps provides baseline resistance to multiple drug classes").
resist_property(intrinsic_resistance, target_inaccessibility, "Glycopeptides cannot pass outer membrane and cannot reach peptidoglycan target in the periplasm").
resist_property(intrinsic_resistance, chromosomal_enzyme, "Species-specific chromosomal beta-lactamases provide inherent resistance to specific beta-lactam subclasses").
resist_property(intrinsic_resistance, clinical_significance, "Determines the starting point of empirical therapy: narrow-spectrum drugs invalid, broad-spectrum drugs required").

% 获得性耐药机制 属性
resist_property(acquired_resistance_mechanism, enzyme_inactivation, "Produces beta-lactamases (ESBLs, AmpC, carbapenemases), aminoglycoside-modifying enzymes to inactivate drugs").
resist_property(acquired_resistance_mechanism, target_modification, "Point mutations in drug target genes (gyrA, parC, PBPs) reduce drug-target binding affinity").
resist_property(acquired_resistance_mechanism, efflux_upregulation, "Overexpression of RND-family efflux pumps (AcrAB-TolC, MexAB-OprM) actively export multiple classes of drugs").
resist_property(acquired_resistance_mechanism, porin_loss, "Downregulation/loss of outer membrane porins (OprD, OmpK36) reduces drug influx").
resist_property(acquired_resistance_mechanism, target_protection, "Expression of ribosome protection proteins (such as Qnr, Tet(M)) shields drug target from binding").
resist_property(acquired_resistance_mechanism, metabolic_bypass, "Acquired alternate metabolic pathway genes bypass inhibited steps, such as plasmid-borne sulfonamide resistance").
resist_property(acquired_resistance_mechanism, lps_modification, "LPS lipid A modification (MCR-mediated phosphoethanolamine addition) reduces polymyxin binding").

% 耐药基因水平转移机制 属性
resist_property(resistance_gene_transfer, conjugation, "Conjugative plasmid transfer is the most common and efficient inter-species resistance gene dissemination mechanism").
resist_property(resistance_gene_transfer, transformation, "Natural transformation: uptake of free DNA carrying resistance genes from lysed bacteria in the environment").
resist_property(resistance_gene_transfer, transduction, "Bacteriophage-mediated transduction packages and delivers resistance genes to new hosts").
resist_property(resistance_gene_transfer, omv_vesiduction, "OMV-mediated vesiduction delivers DNA and resistance enzymes, effective across species barriers").
resist_property(resistance_gene_transfer, transposon_integron, "Transposons and integrons capture, accumulate and reorganize multiple resistance gene cassettes").
resist_property(resistance_gene_transfer, mobile_element, "IS elements, ICE (integrative conjugative elements) drive chromosomal integration and excision of resistance islands").
resist_property(resistance_gene_transfer, clinical_impact, "Horizontal transfer is the root cause of rapid epidemic spread of carbapenemase (KPC, NDM, OXA-48) and colistin resistance (MCR) genes").

% 耐药表达调控机制 属性
resist_property(resistance_regulation, inducible_expression, "Some beta-lactamases (AmpC) are inducible: low-level basal expression, induced to high-level by drug exposure").
resist_property(resistance_regulation, two_component_regulation, "Two-component signal systems sense antibiotic concentration, regulate porin and efflux pump expression").
resist_property(resistance_regulation, quorum_sensing, "Quorum sensing signals regulate biofilm formation and collective resistance phenotype expression").
resist_property(resistance_regulation, stress_response, "SOS response enhances mutagenesis, promotes emergence of resistant variants under antibiotic pressure").
resist_property(resistance_regulation, epigenetic_regulation, "DNA methylation and phase variation regulate heterogeneous resistance phenotype expression in isogenic populations").

% ==============================================
% 七、属性推理规则与查询接口
% ==============================================
% 查询指定实体的所有结构属性
all_struct_properties(Entity, PropList) :-
    findall([PropType, Desc], struct_property(Entity, PropType, Desc), PropList).

% 查询指定实体的所有生理生化属性
all_phys_properties(Entity, PropList) :-
    findall([PropType, Desc], phys_property(Entity, PropType, Desc), PropList).

% 查询指定实体的所有毒力属性
all_virulence_properties(Entity, PropList) :-
    findall([PropType, Desc], virulence_property(Entity, PropType, Desc), PropList).

% 查询指定实体的所有耐药属性
all_resist_properties(Entity, PropList) :-
    findall([PropType, Desc], resist_property(Entity, PropType, Desc), PropList).

% 查询指定大类下所有实体
entities_in_category(Category, EntityList) :-
    findall([Entity, Desc], entity(Entity, Category, Desc), EntityList).

% 查询指定大类下所有子类
subcategories_of(TopCat, SubList) :-
    findall([Sub, Desc], sub_category(Sub, TopCat, Desc), SubList).

% 综合查询：获取所有一级属性大类
all_top_categories(CatList) :-
    findall([Cat, Desc], top_category(Cat, Desc), CatList).

% 查询指定维度的特定属性值
specific_property(Entity, PropType, Desc) :-
    (struct_property(Entity, PropType, Desc);
     phys_property(Entity, PropType, Desc);
     virulence_property(Entity, PropType, Desc);
     resist_property(Entity, PropType, Desc)).

% 全文检索：按关键词搜索属性描述
search_property(Keyword, Results) :-
    findall([Entity, PropType, Desc],
        (specific_property(Entity, PropType, Desc),
         sub_atom(Desc, _, _, _, Keyword)),
        Results).

% 对比查询：获取两个实体在同一维度的属性差异
compare_entities(Entity1, Entity2, ComparisonList) :-
    findall([PropType, Desc1, Desc2],
        (specific_property(Entity1, PropType, Desc1),
         specific_property(Entity2, PropType, Desc2),
         Desc1 \= Desc2),
        ComparisonList).

% ==============================================
% 八、属性与本体/关系文件的接口规则
% ==============================================
% 属性归属关系：连接属性文件中的实体到关系文件中的分类体系
attribute_of_bacterium(Bacterium, Category, Entity, PropType, Desc) :-
    has_top_category(Bacterium, Category),
    entity(Entity, Category, _),
    specific_property(Entity, PropType, Desc).

% 属性继承规则：所有革兰氏阴性菌共享本文件中定义的通用属性
% (通过关系文件中的is_a链，子类自动继承上层属性)
shared_attribute(Species, Category, Entity, PropType, Desc) :-
    is_a(Species, gram_negative_bacteria),
    attribute_of_bacterium(gram_negative_bacteria, Category, Entity, PropType, Desc).
