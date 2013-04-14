class Browsercms355 < ActiveRecord::Migration
  def up
    create_table prefix(:form_blocks) do |t|
      t.string :type

      t.string :name
      t.boolean :archived, :default => false
      t.boolean :deleted, :default => false
      t.integer :created_by_id, :updated_by_id
      t.timestamps
    end
    create_table prefix(:form_block_attributes) do |t|
      t.integer :form_block_id
      t.string :name
      t.string :type
      t.text :value
      t.timestamps
    end
    create_table prefix(:form_block_posts) do |t|
      t.integer :form_block_id
      t.text :value
      t.timestamps
    end
  end

  def down
    drop_table prefix(:form_block_attributes)
    drop_table prefix(:form_blocks)
    drop_Table prefix(:form_block_posts)
  end
end
