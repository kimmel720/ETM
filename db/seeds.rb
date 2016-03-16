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

    (0..2).each do
      r = Room.create(
        name: Faker::Name.name + " Room"
      )

      (0..5).each do
        a = Artwork.create(
          name: Faker::Book.title,
          # img_url: Faker::Placeholdit.image,
          description: Faker::Hacker.say_something_smart,
          date_created: Faker::Date.between(1000.years.ago, Date.today),
          accession_no: Faker::Code.isbn,
          rooms: [r]
        )
        r.artworks << a
      end
    end
  end
end
