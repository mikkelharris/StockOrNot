require 'rake'
require "#{Rails.root}/app/helpers/items_helper"
include ItemsHelper

namespace :items do
  task :get_images => :environment do
    @items = Item.where("img_url IS NULL OR img_url = ? AND full_site IS NOT NULL", '')
    @items.each do |item|
      puts item.id
      item.img_url = get_image item
      item.save
    end
  end
end