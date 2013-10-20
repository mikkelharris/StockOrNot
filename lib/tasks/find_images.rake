require 'rake'
require "#{Rails.root}/app/helpers/items_helper"
include ItemsHelper

namespace :items do
  task :get_images => :environment do
    sites = %w{walmart.com newegg.com frys.com radioshack.com}
    @items = Item.where("base_site IN (?) AND (img_url = ? OR img_url IS NULL)", sites, '')
    @items.each do |item|
      puts "#{item.id}: #{item.base_site} - #{item.full_site}"
      item.img_url = get_image item
      item.save
    end
  end
end