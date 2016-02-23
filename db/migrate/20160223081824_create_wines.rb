class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :title
      t.datetime :vintage
      t.string :brand
      t.text :description
      t.text :extracomments

      t.timestamps null: false
    end
  end
end
