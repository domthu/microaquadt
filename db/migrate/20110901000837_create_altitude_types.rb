
class CreateAltitudeTypes < ActiveRecord::Migration
  def self.up
    create_table :altitude_types do |t|
      t.string :name, :null => false
      t.timestamps
    end

  end

  def self.down
     drop_table :altitude_types
  end
end


#class CreateCourses < ActiveRecord::Migration
#  def self.up
#    create_table :seasons do |t|
#      t.integer :year
#      t.string :period
#    end

#    create_table :courses do |t|
#      t.string :courseCode
#    end

#    create_table :courses_seasons, :id => false do |t|
#      t.references :course, :null => false
#      t.references :season, :null => false
#    end
#    add_index :courses_seasons, [:course_id, :season_id], :unique => true

#  end

#  def self.down
#    drop_table :seasons
#    drop_table :courses
#    drop_table :courses_seasons
#  end
#end
