User.delete_all
Museum.delete_all
Exhibition.delete_all
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

farber = Museum.create(
  user: admin,
  name: "Farber Mezzanine",
  latitude: 42.366284,
  longitude: -71.258734,
  street_address: "415 South St",
  city: "Waltham",
  country: "United States",
  description: "The Rose Art Museum is Brandeis University BLAHBLAHBLA",
  website: "http://www.brandeis.edu/rose/"
)
farber.image = File.open("app/assets/images/Farber/goldfarb.png")
farber.save

e1 = Exhibition.create(
  user: admin,
  museum: farber,
  name: "Deis Impact Exhibit",
  start_date: Date.new(2016, 1, 31),
  end_date: Date.new(2016, 5, 22),
  description:
  "Technologies such as 3D printing can revolutionize access and inclusivity in today's world. For example, event organizer Daniela Dimitrova made a 3D replica of 'Square Reflections', a sculpture by Louise Nevelson, to make it more accessible for the visually impaired. While someone who is visually impaired can't touch the original sculpture, they can touch the 3D replica, making the art more accessible to all. In addition, the Brandeis Prostheses Club is working on making prostheses for children who need to use their muscles so they don't atrophy, but can't afford $10,000 - $50,000 for a regular prosthesis each time they grow. Furthermore, the Virtual Reality Club is using gaming technology to make 3D interactive virtual 'tours' of the Rose Art Museum, particularly for those who live in rural areas and can't afford to visit an art museum. These technologies, like any other tools, can be used for good or ill -- either taking piracy to a new level (as 3D printers can make it possible to do home manufacturing of any copyrighted item), or making prostheses, art and museum experiences more accessible for all.",
  curator: "Daniela Dimitrova"
)
e1.image = File.open("app/assets/images/Farber/Lower Rose.png")
e1.save

p = Panorama.create(
  exhibition: e1,
  artwork_coordinates: {}
)
p.image = File.open("app/assets/images/Farber/panorama_test.png")
p.save

fake_artist = Artist.create(
  name: Faker::Name.name
)

a1 = Artwork.create(
  name: "Square Reflections",
  exhibition: e1,
  artists: [fake_artist],
  description: "Painted 3D printed replica of a Louise Nevelson sculpture with wooden frame and acrylic mirrors. Square Reflections, 1964 Pace Gallery Made possible with the generous help of the Brandeis MakerLab staff, the members of the Deis3D and DeisVR clubs, as well as  David Stiefel, Jack Holloman, and Debra Sarlin.",
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn
)
a1.image = File.open("app/assets/images/Farber/3D Printed Replica of Square Reflections.png")
a1.save

a2 = Artwork.create(
  name: "Nevelson Sculpture Renders",
  exhibition: e1,
  artists: [fake_artist],
  description: "Computer generated image of Louise Nevelson sculptures that were recreated by Daniela Dimitrova and Michael Makivic using 3D modeling. Left: Tropical Garden, 1957 Grey Art Gallery, NYU Right: Totality Dark, 1962",
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn
)
a2.image = File.open("app/assets/images/Farber/Render of Two Sculptures.png")
a2.save
id_counter = 0
3.times do
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

  4.times do
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

    5.times do
      artwork = Artwork.create(
        exhibition: e,
        name: Faker::Book.title,
        image_id: id_counter,  # should put default image maybe using faker somewhere else
        description: Faker::Hacker.say_something_smart,
        date_created: Faker::Date.between(1000.years.ago, Date.today),
        accession_no: Faker::Code.isbn,
      )
      artwork.artists << a
      id_counter += 1
    end
  end
end
