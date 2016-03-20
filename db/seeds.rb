User.delete_all
Museum.delete_all
Exhibition.delete_all
Room.delete_all
Artwork.delete_all
Artist.delete_all

admin = User.create(
  name: "admin",
  password: "password",
  password_confirmation: "password",
  admin: true
)

user = User.create(
  name: "user",
  password: "password",
  password_confirmation: "password",
  admin: false
)

rose = Museum.create(
  user: admin,
  name: "The Rose Art Museum",
  latitude: 42.366284,
  longitude: -71.258734,
  street_address: "415 South St",
  city: "waltham",
  country: "United States",
  description: "The Rose Art Museum is Brandeis University BLAHBLAHBLA",
  website: "http://www.brandeis.edu/rose/"
)
r_exhibition = Exhibition.create(
  user: admin,
  museum: rose,
  name: Faker::Name.name + " Collection",
  start_date: Faker::Date.between(20.years.ago, 10.years.ago),
  end_date: Faker::Date.between(10.years.ago, Date.today),
  description: Faker::Lorem.paragraph,
  curator: Faker::Name
)
r_rose = Room.create(
  name: Faker::Name.name + " Room",
  exhibition_id: r_exhibition.id
)
artist_rose = Artist.create(
  name: Faker::Name.name
)
a_rose = Artwork.create(
  name: Faker::Book.title,
  # img_url: Faker::Placeholdit.image,
  description: Faker::Hacker.say_something_smart,
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn,
  rooms: [r_rose],
  artists: [artist_rose]
)
r_rose.artworks << a_rose



(0..2).each do
  m = Museum.create(
    user: admin,
    name: Faker::Company.name + " Museum",
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    country: Faker::Address.country,
    description: Faker::Lorem.paragraph,
    website: Faker::Internet.url
  )

  (0..3).each do
    e = Exhibition.create(
      user: admin,
      museum: m,
      name: Faker::Name.name + " Collection",
      start_date: Faker::Date.between(20.years.ago, 10.years.ago),
      end_date: Faker::Date.between(10.years.ago, Date.today),
      description: Faker::Lorem.paragraph,
      curator: Faker::Name
    )
    a = Artist.create(
      name: Faker::Name.name
    )
    (0..2).each do
      r = Room.create(
        name: Faker::Name.name + " Room",
        museum: m,
        exhibition: e
      )
      (0..5).each do
        artwork = Artwork.create(
          name: Faker::Book.title,
          image_id: 0,  # should put default image maybe using faker somewhere else
          description: Faker::Hacker.say_something_smart,
          date_created: Faker::Date.between(1000.years.ago, Date.today),
          accession_no: Faker::Code.isbn,
          rooms: [r],
          artists: [a]
        )
        r.artworks << artwork
      end
    end
  end
end
