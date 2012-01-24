

namespace :db do
  desc "Empty existing data from FilterSamplePreparation and  + Fill database with default data"
  task :addsubtable => :environment do

    existing_equip = SamplingEquipment.all()
    for ps in existing_equip do
        ps.destroy
    end

    SamplingEquipment.create!(:name => "?", :description => "Not defined")
    SamplingEquipment.create!(:name => "bucket", :description => "description for use of bucket")
    SamplingEquipment.create!(:name => "pump", :description => "description for use of pump")

    Sampling.update_all ["sampling_equipments_id = ?", 1]
    #UPDATE samplings SET `sampling_equipments_id` = 1 WHERE `sampling_equipments_id` = NULL


    existing_prepa = FilterSamplePreparation.all()
    for ps in existing_prepa do
        ps.destroy
    end

    FilterSamplePreparation.create!(:name => "?", :description => "Not defined")
    FilterSamplePreparation.create!(:name => "DNA/RNA", :description => "expose sample preparation for DNA/RNA extraction")
    FilterSamplePreparation.create!(:name => "PCR", :description => "expose sample preparation for PCR")

    FilterSample.update_all ["filter_sample_preparations_id = ?", 1]



  end
end

