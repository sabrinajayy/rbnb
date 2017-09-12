class CreateCertifications < ActiveRecord::Migration[5.0]
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :img
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
