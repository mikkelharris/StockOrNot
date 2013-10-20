require 'mechanize'

module ItemsHelper
  Regex = {
    "walmart.com" => /http:\/\/i.walmartimages.com\/i\/p\/.+/,
    "frys.com" => /http:\/\/images.frys.com\/art\/product\/.+/,
    "newegg.com" => /.+\/ProductImageCompressAll300\/.+/,
    "radioshack.com" => /.+\/graphics\/product_images\/.+/
  }
  
  def get_image(item)
    if !item.full_site.nil?
      page = agent.get(item.full_site)
      scrape_image_with_regex page, Regex[item.base_site]
    end
  end
  
  def scrape_image_with_regex(page, regex)
    page.images_with(src: regex).first.to_s
  end
  
  private
  def agent
    @agent ||= Mechanize.new
  end
end