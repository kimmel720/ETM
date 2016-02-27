# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Exhibition.delete_all
Museum.delete_all
Artwork.delete_all
m = Museum.create(
  name: "The Rose"
)

e = Exhibition.create(
  name: "Current Collection",
  museum_id: m.id
)

a = Artwork.create(
  name: "Winged Victory of Samothrace",
  img_path: "nike.jpg",
  description:
    """The Winged Victory of Samothrace, also called the Nike of Samothrace,
    is a 2nd-century BC marble sculpture of the Greek goddess Nike (Victory).
    Since 1884, it has been prominently displayed at the Louvre and is one
    of the most celebrated sculptures in the world. H.W. Janson described it
    as \"the greatest masterpiece of Hellenistic sculpture. (Wikipedia)\"""",
  date_created: Date.new(-200, 1, 1)
)
