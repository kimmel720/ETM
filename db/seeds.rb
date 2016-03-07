User.delete_all
Exhibition.delete_all
Museum.delete_all
Artwork.delete_all

u = User.create(
  name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: true
)

m = Museum.create(
  user: u,
  name: "The Rose"
)

e = Exhibition.create(
  user: u,
  museum: m,
  name: "Current Collection"
)

a = Artwork.create(
  name: "Winged Victory of Samothrace",
  description:
    """The Winged Victory of Samothrace, also called the Nike of Samothrace,
    is a 2nd-century BC marble sculpture of the Greek goddess Nike (Victory).
    Since 1884, it has been prominently displayed at the Louvre and is one
    of the most celebrated sculptures in the world. H.W. Janson described it
    as \"the greatest masterpiece of Hellenistic sculpture. (Wikipedia)\"""",
  date_created: Date.new(-200, 1, 1)
)
