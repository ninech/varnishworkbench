class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :ip
      t.string :title
      t.text :text

      t.timestamps
    end
  end
end
