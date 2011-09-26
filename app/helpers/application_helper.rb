module ApplicationHelper

  def title
    @base_title = "Bk;Hack"
    full_title = "#{@base_title} | #{@title}" unless @title.nil?
  end
  
  def logo
    image_tag( "http://i299.photobucket.com/albums/mm281/foxnewsnetwork/metalupasmall.png", :alt => "Hack into the gate" )
  end
end
