class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :description
      t.boolean :is_private
      t.string :share_url

      t.timestamps null: false
    end

    add_index :snippets, :description, :length => 20
    add_index :snippets, :is_private
    add_index :snippets, :share_url
  end
end
