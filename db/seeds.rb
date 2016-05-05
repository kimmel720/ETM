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

id_counter = 0

farber = Museum.create(
  user: admin,
  name: "Farber Mezzanine",
  latitude: 42.36787,
  longitude: -71.25857,
  street_address: "415 South St",
  city: "Waltham",
  country: "United States",
  description: Faker::Lorem.paragraph,
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
)
p.image = File.open("app/assets/images/Harvard_Panorama_II.jpg")
p.save

fake_artist = Artist.create(
  name: Faker::Name.name
)

a1 = Artwork.create(
  name: "Square Reflections",
  exhibition: e1,
  medium: "Crayon",
  artists: [fake_artist],
  description: "Painted 3D printed replica of a Louise Nevelson sculpture with wooden frame and acrylic mirrors. Square Reflections, 1964 Pace Gallery Made possible with the generous help of the Brandeis MakerLab staff, the members of the Deis3D and DeisVR clubs, as well as  David Stiefel, Jack Holloman, and Debra Sarlin.",
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn,
  image_id: id_counter
)
a1.image = File.open("app/assets/images/Farber/3D Printed Replica of Square Reflections.png")
a1.save

id_counter += 1

a2 = Artwork.create(
  name: "Nevelson Sculpture Renders",
  exhibition: e1,
  medium: "Crayon",
  artists: [fake_artist],
  description: "Computer generated image of Louise Nevelson sculptures that were recreated by Daniela Dimitrova and Michael Makivic using 3D modeling. Left: Tropical Garden, 1957 Grey Art Gallery, NYU Right: Totality Dark, 1962",
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn,
  image_id: id_counter
)
a2.image = File.open("app/assets/images/Farber/Render of Two Sculptures.png")
a2.save

id_counter += 1

harvard = Museum.create(
  user: admin,
  name: "Harvard Art Museums",
  latitude: 42.37403,
  longitude: -71.11410,
  street_address: "32 Quincy Street",
  city: "Cambridge",
  country: "United States",
  description: "The Harvard Art Museums is part of Harvard University and comprise three museums: the Fogg Museum (established in 1895), the Busch-Reisinger Museum (established in 1903), and the Arthur M. Sackler Museum (established in 1985) and four research centers: the Archaeological Exploration of Sardis (founded in 1958), the Center for the Technical Study of Modern Art (founded in 2002), the Harvard Art Museums Archives, and the Straus Center for Conservation and Technical Studies (founded in 1928). The three museums that comprise the Harvard Art Museums were initially integrated into a single institution under the name Harvard University Art Museums in 1983. University was dropped from the institutional name in 2008.
The collections include approximately 250,000 objects in all media, ranging in date from antiquity to the present and originating in Europe, North America, North Africa, the Middle East, South Asia, East Asia, and Southeast Asia.
",
  website: "http://www.harvardartmuseums.org/"
)
harvard.image = File.open("app/assets/images/Harvard/harvard.jpg")
harvard.save

e2 = Exhibition.create(
  user: admin,
  museum: harvard,
  name: "European Art, 13th-16th century",
  start_date: Date.new(2014, 10, 16),
  end_date: Date.new(2020, 5, 22),
  description: "For centuries artists were tasked with painting images (icons) of Christ and the Virgin Mary. Viewers believed that these likenesses had been created miraculously, and artists were able to give their work a sense of authenticity by adhering closely to images that were reputedly painted by Saint Luke or by some other holy means. Over the centuries, Byzantine icons stayed true to these early images. Although there was considerable exchange btween Europe and the East, the sack of Constantinople by Western European and Venetian crusaders in 1204 brought a wave of artwork from the Byzantine capital to Europe. Early Italian painters initially remained faithful to Byzantine models, but they soon broke away from tradition, introducing personal and regional styles to their work. During the Renaissance, artistic practice became more codified through treatises as well as through critical awareness of differences between artists and personal styles. Around the middle of the sixteenth century Giorgio Vasari, the Italian artist and art historian, wrote a history of the lives of Italian artists that assessed Italian painting from the previous three centuries. ",
  curator: "Team of Busch-Reisinger curators headed by Miriam Stewart"
)
e2.image = File.open("app/assets/images/Harvard/exhibition.png")
e2.floor_plan = File.open("app/assets/images/Harvard/harvard_euro_floor.jpg")
e2.save

p1 = Panorama.create(
  exhibition: e2,
  adjacent_panoramas: [p],
)
p1.image = File.open("app/assets/images/Harvard_Panorama_I.jpg")
p1.save

p2 = Panorama.create(
  exhibition: e2,
  adjacent_panoramas: [p1],
)
p2.image = File.open("app/assets/images/Harvard_Panorama_II.jpg")
p2.save

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
  m.image = open(Faker::Placeholdit.image)
  m.save


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
  e.image = open(Faker::Placeholdit.image)
  e.save

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
    artwork.image = open(Faker::Placeholdit.image("1200x300"))
    artwork.save
    id_counter += 1
  end
end
end

a3 = Artwork.create(
  name: "Allegorical Portrait of a Young Man in the Guise of Mercury Slaying Argus",
  exhibition: e2,
  artists: [fake_artist],
  description: "This portrait depicts a young man disguised as the mischievous Mercury after he has slain the hundred-eyed watchman Argus. Balancing himself on a puff of clouds as he holds a flute and caduceus (a staff entwined with snakes), he stands before a hillside that opens onto what Florentines would have recognized as a Flemish-style landscape. The Medici often identified themselves with classical gods, sometimes even assuming their guises in allegorical portraits. Francesco I de’ Medici, Grand Duke of Tuscany, was an enthusiast of alchemy and often had himself portrayed with an image of Mercury, who was associated with the metal of the same name. The facial features of this youth, however, more closely resemble those found in portraits of Antonio de’ Medici, son of Francesco’s second wife, Bianca Cappello.",
  date_created: Date.new(1575, 1, 1),
  accession_no: Faker::Code.isbn,
  image_id: 200
)
a3.image = File.open("app/assets/images/Harvard/mercury.png")
a3.save

id_counter += 1

a4 = Artwork.create(
  name: "The Virgin and Child with Saints Peter and Paul",
  exhibition: e2,
  artists: [fake_artist],
  description: "Painted in Lombardy, this altarpiece shows Christ handing the large, gleaming keys of the kingdom of heaven to Saint Peter. The saint rests one foot on what resembles a cornerstone, symbolizing his role as a founder of the Church — the “rock” upon which it was built. The image thus confirms that the authority of the Church was granted by Christ himself, a central tenet of the Counter-Reformation. On the right is Saint Paul, holding the sword with which he was martyred and a book representing his epistles.
The throne of the Virgin seems to be carved out of the living rock, from which sprout roots and foliage. The emphasis on nature reveals the continuing influence of Leonardo da Vinci on the Lombard school of painting, though the crisp delineation of forms is more linear and straightforward than the ambiguity and subtlety of the great master’s work.",
  date_created: Date.new(1550, 1, 1),
  accession_no: Faker::Code.isbn,
  image_id: 201
)
a4.image = File.open("app/assets/images/Harvard/virgin_peter_paul.png")
a4.save

id_counter += 1
