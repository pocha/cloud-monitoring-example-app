class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :ip
      t.float :cpu
      t.float :disk
      t.float :memory

      t.timestamps null: false
    end
  end
end
