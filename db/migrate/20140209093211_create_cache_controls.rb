class CreateCacheControls < ActiveRecord::Migration
  def change
    create_table :cache_controls do |t|
      t.string :ip
      t.string :expire
      t.boolean :noCache
      t.boolean :noStore
      t.boolean :public
      t.boolean :private
      t.integer :maxAge
      t.integer :sMaxAge
      t.integer :timeout

      t.timestamps
    end
  end
end
