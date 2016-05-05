class SearchController < ApplicationController
  def results
    @search_term = params[:search].html_safe

    @results = {
      "Artists" =>
          Artist.search(@search_term).each.map{ |artist| {
            name: artist.name,
            path: artist_path(artist)
          }},
      "Artworks" =>
        Artwork.search(@search_term).each.map{ |artwork| {
          name: artwork.name,
          path: artwork_path(artwork.exhibition.museum, artwork.exhibition, artwork)
        }},
      "Exhibitions" =>
        Exhibition.search(@search_term).each.map{ |exhibition| {
          name: exhibition.name,
          path: museum_exhibition_path(exhibition.museum, exhibition)
        }},
      "Museums" =>
        Museum.search(@search_term).each.map{ |museum| {
          name: museum.name,
          path: museum_path(museum)
        }}

     }
     @any_results = false
     @results.each do |key, value|
       if !value.blank?
         @any_results = true
       end
     end
  end
end
