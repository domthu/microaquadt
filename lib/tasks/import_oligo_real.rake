

namespace :db do
  desc "Empty existing data from OligoSequence and Fill database with default sample filter data"
  task :addoligoreal => :environment do

    existing_oligos = OligoSequence.all()
    for efs in existing_oligos do
        efs.destroy
    end

#non c'è la tabella tax_id
#insert all data of oligo
    
#taxonomy_id, :decimal, :default => 0, :precision => 2, :scale => 0
#taxonomy_name, :string
# in second time during Edit


OligoSequence.create!( :code => "AMP_COF_P29", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "TCGTCGCCGTCCTGGCTCCACAATTC", :available =>1,  :description => "Lenght: 26, Tm: 67,5, GC Content: 61,5        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "AMP_COF_P29_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCTGCGCAACCGCGAATGCATCATC", :available =>1,  :description => "Lenght: 26, Tm: 68,4, GC Content: 61,5        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "Amp_COF_P22", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "TTCTTCCTCGTCGCCGTCCTGGCTCC", :available =>1,  :description => "Lenght: 26, Tm: 68,5, GC Content: 65,4        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "Amp_COF_P22_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GGATCCCGGCGCTGCGCAACCGCGAA", :available =>1,  :description => "Lenght: 26, Tm: 74, GC Content: 73,1        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "Amp_COF_P25", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CGAGATTTCCTCGCCCGCGGCGCACA", :available =>1,  :description => "Lenght: 26, Tm: 71,7, GC Content: 69,2        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "Amp_COF_P25_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CCAGACCGACAAGGCGACCCACGGCT", :available =>1,  :description => "Lenght: 26, Tm: 70,7, GC Content: 69,2        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "AMP_COF_P20", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CGCTCTCGTTCCTGTTGATGTATGCC", :available =>1,  :description => "Lenght: 26, Tm: 62,7, GC Content: 53,8        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "AMP_COF_P20_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GCTTTTCCTGCTCGATGTCGAAGAAC", :available =>1,  :description => "Lenght: 26, Tm: 61,5, GC Content: 50        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "AMP_COF_P21", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "ACCGGCACCATCAGCAGCACCAGCAT", :available =>1,  :description => "Lenght: 26, Tm: 69,5, GC Content: 61,5        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "AMP_COF_P21_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GCCAGGTGGTGGCGGATGAGGGCAAG", :available =>1,  :description => "Lenght: 26, Tm: 69,9, GC Content: 69,2        Random sequence", :name => "Amphora coffeaformis" )
OligoSequence.create!( :code => "NIT_DIS_P24", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GACGCGCCAACATCGCCGACATGAA", :available =>1,  :description => "Lenght: 25, Tm: 66,9, GC Content: 60        Random sequence", :name => "Nitzschia dissipata (R)" )
OligoSequence.create!( :code => "NIT_DIS_P24_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CAACACTGGTTCCACTTGTAGTAGC", :available =>1,  :description => "Lenght: 25, Tm: 58,5, GC Content: 48        Random sequence", :name => "Nitzschia dissipata (R)" )
OligoSequence.create!( :code => "NIT_DIS_P27", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CCGACCTCGATGCGGCCCTCCTTGAT", :available =>1,  :description => "Lenght: 26, Tm: 68,6, GC Content: 65,4        ", :name => "Nitzschia dissipata (G)" )
OligoSequence.create!( :code => "NIT_DIS_P27_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GTCGAGGGCAACAACCAGAAGCACGC", :available =>1,  :description => "Lenght: 26, Tm: 67,1, GC Content: 61,5        ", :name => "Nitzschia dissipata (G)" )
OligoSequence.create!( :code => "NIT_SIG_P21", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GCAGGCGAGCATCCTGACACGGGTGA", :available =>1,  :description => "Lenght: 26, Tm: 69,1, GC Content: 65,4        Random sequence", :name => "Nitzschia sigma" )
OligoSequence.create!( :code => "NIT_SIG_P21_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GCTCGTCCTAGCAGTCGTGGCCTTAT", :available =>1,  :description => "Lenght: 26, Tm: 64,8, GC Content: 57,7        Random sequence", :name => "Nitzschia sigma" )
OligoSequence.create!( :code => "NIT_SIG_P26", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AAGCACGGTTCGTCCATCAGGGCAT", :available =>1,  :description => "Lenght: 25, Tm: 65,4, GC Content: 56        Random sequence", :name => "Nitzschia sigma" )
OligoSequence.create!( :code => "NIT_SIG_P26_R", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GGCTACCACTGGCACAGGAACACAA", :available =>1,  :description => "Lenght: 25, Tm: 63,8, GC Content: 56        Random sequence", :name => "Nitzschia sigma" )
OligoSequence.create!( :code => "SSU_01", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GAACGGCTCATTATATCAGTTATAG", :available =>1,  :description => "Lenght: 25, Tm: 63,1, GC Content: 36    Genus level    SSU rRNA", :name => "Nitzschia " )
OligoSequence.create!( :code => "SSU_02", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GAGGTAATGATTAATAGGGACAGTT", :available =>1,  :description => "Lenght: 25, Tm: 60,8, GC Content: 28    Genus level    SSU rRNA", :name => "Navicula" )
OligoSequence.create!( :code => "SSU_03", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GTAGTATTTATTAGATGGAAACCAA", :available =>1,  :description => "Lenght: 25, Tm: 60,8, GC Content: 28    Genus level    ", :name => "Variants within the genus Navicula" )
OligoSequence.create!( :code => "SSU_04", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "TCCCTTACTACTTGGATAACCGTAG", :available =>1,  :description => "Lenght: 25, Tm: 67,2, GC Content: 44    Genus level    ", :name => "Variants within the genus Navicula" )
OligoSequence.create!( :code => "SSU_05", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AATTCTTGGATTTCTGGAAGACGAACTA", :available =>1,  :description => "Lenght: 28, Tm: 68,7, GC Content: 35,7    Genus level    ", :name => "Variants within the genus Navicula" )
OligoSequence.create!( :code => "SSU_06", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "GAGGTAATGATTAATAGGGACAGTT", :available =>1,  :description => "Lenght: 25, Tm: 64,2, GC Content: 36    Genus level    ", :name => "Variants within the genus Navicula" )
OligoSequence.create!( :code => "SSU_07", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AAGGAGGTAGTGACAATAAATAACA", :available =>1,  :description => "Lenght: 25, Tm: 64, GC Content: 32    Genus level    ", :name => "Variants within the genus Navicula" )
OligoSequence.create!( :code => "SSU_08", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "CTACACTGATGCATTCAACGAGTTT", :available =>1,  :description => "Lenght: 25, Tm: 67,9, GC Content: 40    Genus level    SSU rRNA", :name => "Eolimna" )
OligoSequence.create!( :code => "SSU_09", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AGATACCATCGTAGTCTTAACCATA", :available =>1,  :description => "Lenght: 25, Tm: 60,3, GC Content: 36    Clade level    SSU rRNA", :name => "Bacillariophycae (pennate) " )
OligoSequence.create!( :code => "SSU_10", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AAATCTCTTACTTTGAAACTGCGAA", :available =>1,  :description => "Lenght: 25, Tm: 61,3, GC Content: 32    Clade level    ", :name => "Variants within the clade Bacillariophycae" )
OligoSequence.create!( :code => "SSU_11", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AAAAGAAACTAACTAGGATTCCCTC", :available =>1,  :description => "Lenght: 25, Tm: 60,1, GC Content: 36    Clade level    ", :name => "Variants within the clade Bacillariophycae" )
OligoSequence.create!( :code => "SSU_12", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AACCTGCGGAAGGATCATTACCACA", :available =>1,  :description => "Lenght: 25, Tm: 68, GC Content: 48    Clade level    ", :name => "Variants within the clade Bacillariophycae" )
OligoSequence.create!( :code => "SSU_13", :oligoDate => "2012/05/25", :partner_id => 1 , :people_id =>3, :dna_sequence => "AAATGACCTAAAGCTTAAAGTGCAG", :available =>1,  :description => "Lenght: 25, Tm: 61,9, GC Content: 36    Clade level    ", :name => "Variants within the clade Bacillariophycae" )


  end
end

