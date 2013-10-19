class UpdateItemAndStock < ActiveRecord::Migration 
  def up
    remove_column :items, :img_ref
    remove_column :items, :img_source
    
    add_column :items, :img_url, :string
    add_column :items, :base_site, :string
    add_column :items, :full_site, :string
    
    add_column :stocks, :img_url, :string
  end
  
  def down
    add_column :items, :img_ref, :string
    add_column :items, :img_source, :string
    
    remove_column :items, :img_url
    remove_column :items, :base_site
    remove_column :items, :full_site
    
    remove_column :stocks, :img_url
  end
end
