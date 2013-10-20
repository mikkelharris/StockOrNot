require 'mechanize'

module ItemsHelper
  def get_image(item)
    image = nil
    page = agent.get(item.full_site)
    
    if item.base_site.eql? "walmart.com"
      image = get_image_walmart page
    elsif item.base_site.eql? "frys.com"
      # image = get_image_frys page
    elsif item.base_site.eql? "radioshack.com"
      # image = get_image_radioshock page
    end
    
    image
  end
  
  def get_image_walmart(page)
    find_image(page, '#mainImage')
  end
  
  def get_image_frys(page)
    #Need to implement
    find_image(page, '')
  end
  
  def get_image_radioshock(page)
    #Need to implement
    # find_image(page, '')
    
    images = page.links
    Rails.logger.debug images
    images.each do |img|
      Rails.logger.debug img
      # img.node.attributes
    end
    images.first.to_s
  end
  
  private
  def agent
    @agent ||= Mechanize.new
  end
  
  def find_image(page, id)
    images = page.search("img#{id}").map {|node| Mechanize::Page::Image.new(node, page) }
    # images.each do |img|
      # Rails.logger.debug img.to_s
    # end
    images.first.to_s
  end
end