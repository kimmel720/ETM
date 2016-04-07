class SearchController < ApplicationController
  def results
    @search_term = params[:search].html_safe
    @results = {
      "Artists" => Artist.search(@search_term),
      "Artworks" => Artwork.search(@search_term),
      "Exhibitions" => Exhibition.search(@search_term),
      "Museums" => Museum.search(@search_term)
     }
     @any_results = false
     @results.each do |key, value|
       if !value.blank?
         @any_results = true
       end
     end
  end
end
