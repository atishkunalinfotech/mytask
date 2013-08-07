class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :mytask
      t.datetime :created_date
      t.string :status

      t.timestamps
    end
  end
end
