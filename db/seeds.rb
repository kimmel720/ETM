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
  website: "http://www.brandeis.edu/rose/",
  color: "#024685"
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
  image_id: 0
)
a1.image = File.open("app/assets/images/Farber/3D Printed Replica of Square Reflections.png")
a1.save

a2 = Artwork.create(
  name: "Nevelson Sculpture Renders",
  exhibition: e1,
  medium: "Crayon",
  artists: [fake_artist],
  description: "Computer generated image of Louise Nevelson sculptures that were recreated by Daniela Dimitrova and Michael Makivic using 3D modeling. Left: Tropical Garden, 1957 Grey Art Gallery, NYU Right: Totality Dark, 1962",
  date_created: Faker::Date.between(1000.years.ago, Date.today),
  accession_no: Faker::Code.isbn,
  image_id: 0
)
a2.image = File.open("app/assets/images/Farber/Render of Two Sculptures.png")
a2.save




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
  website: "http://www.harvardartmuseums.org/",
  color: "#72bb27"
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

a3 = Artwork.create(
  name: "Allegorical Portrait of a Young Man in the Guise of Mercury Slaying Argus",
  exhibition: e2,
  artists: [fake_artist],
  description: "This portrait depicts a young man disguised as the mischievous Mercury after he has slain the hundred-eyed watchman Argus. Balancing himself on a puff of clouds as he holds a flute and caduceus (a staff entwined with snakes), he stands before a hillside that opens onto what Florentines would have recognized as a Flemish-style landscape. The Medici often identified themselves with classical gods, sometimes even assuming their guises in allegorical portraits. Francesco I de’ Medici, Grand Duke of Tuscany, was an enthusiast of alchemy and often had himself portrayed with an image of Mercury, who was associated with the metal of the same name. The facial features of this youth, however, more closely resemble those found in portraits of Antonio de’ Medici, son of Francesco’s second wife, Bianca Cappello.",
  date_created: Date.new(1575, 1, 1),
  accession_no: Faker::Code.isbn,
  image_id: 0,
  left: 356,
  right: 385,
  top: 129,
  bottom: 187,
  catagory: "painting"
)
a3.image = File.open("app/assets/images/Harvard/mercury.png")
a3.save

a4 = Artwork.create(
  name: "The Virgin and Child with Saints Peter and Paul",
  exhibition: e2,
  artists: [fake_artist],
  description: "Painted in Lombardy, this altarpiece shows Christ handing the large, gleaming keys of the kingdom of heaven to Saint Peter. The saint rests one foot on what resembles a cornerstone, symbolizing his role as a founder of the Church — the “rock” upon which it was built. The image thus confirms that the authority of the Church was granted by Christ himself, a central tenet of the Counter-Reformation. On the right is Saint Paul, holding the sword with which he was martyred and a book representing his epistles.
The throne of the Virgin seems to be carved out of the living rock, from which sprout roots and foliage. The emphasis on nature reveals the continuing influence of Leonardo da Vinci on the Lombard school of painting, though the crisp delineation of forms is more linear and straightforward than the ambiguity and subtlety of the great master’s work.",
  date_created: Date.new(1550, 1, 1),
  accession_no: Faker::Code.isbn,
  image_id: 0,
  left: 71,
  right: 97,
  top: 101,
  bottom: 154,
  catagory: "sculpture"
)
a4.image = File.open("app/assets/images/Harvard/virgin_peter_paul.png")
a4.save

e3 = Exhibition.create(
  user: admin,
  museum: harvard,
  name: "Japanese 19th Century Art",
  start_date: Date.new(2010, 10, 16),
  end_date: Date.new(2013, 12, 22),
  description: "Various Japanese Works of Art",
  curator: "Team of Busch-Reisinger curators headed by Miriam Stewart"
)

e3 = Exhibition.create(
  user: admin,
  museum: harvard,
  name: "Egyptian Artifacts",
  start_date: Date.new(2009, 10, 16),
  end_date: Date.new(2013, 11, 22),
  description: "Egyptian artifacts recovered from the latest dig",
  curator: "Team of Busch-Reisinger curators headed by Miriam Stewart"
)




m = Museum.create(
  user: admin,
  name: "The MOMA",
  latitude: 40.761417,
  longitude: -73.977120,
  street_address: "11 W 53rd St",
  city: "New York",
  country: "United States",
  description: "The Museum of Modern Art (MoMA) is an art museum located in Midtown Manhattan in New York City, on 53rd Street between Fifth and Sixth Avenues. It has been important in developing and collecting modernist art, and is often identified as the most influential museum of modern art in the world. It is also one of the largest. The museum's collection offers an overview of modern and contemporary art, including works of architecture and design, drawing, painting, sculpture, photography, prints, illustrated books and artist's books, film and electronic media. The Library's holdings include approximately 300,000 books and exhibition catalogs, over 1,000 periodical titles, and over 40,000 files of ephemera about individual artists and groups. The archives holds primary source material related to the history of modern and contemporary art. (Description provided by Wikipedia)",
  website: "http://www.moma.org/",
  color: "#FF3300"
)
m.image = File.open("app/assets/images/moma.jpg")
m.save
#Image courtesy of :https://zealnyc.com/wp-content/uploads/2014/06/moma.jpg

m = Museum.create(
  user: admin,
  name: "The Louvre",
  latitude: 48.860339,
  longitude: 2.337599,
  street_address: "Musée du Louvre",
  city: "Paris",
  country: "France",
  description: "The Louvre or the Louvre Museum is one of the world's largest museums and a historic monument in Paris, France. A central landmark of the city, it is located on the Right Bank of the Seine in the 1st arrondissement (ward). Nearly 35,000 objects from prehistory to the 21st century are exhibited over an area of 60,600 square metres (652,300 square feet). The Louvre is the world's most visited museum after the Palace Museum in China, receiving more than 9.26 million visitors in 2014. It is also one of the largest. (Description from Wikipedia)",
  website: "http://www.louvre.fr",
  color: "#222222"
)
m.image = File.open("app/assets/images/louvre.jpg")
m.save
#http://aflouvre.org/assets/slideshows/38/home_temp1__medium.jpg

m = Museum.create(
  user: admin,
  name: "London Natural History Museum",
  latitude: 51.495983,
  longitude: -0.176372,
  street_address: "Cromwell Rd, Kensington",
  city: "London",
  country: "United Kingdom",
  description: "The Natural History Museum in London is a museum of natural history that exhibits a vast range of specimens from various segments of natural history. It is one of three major museums on Exhibition Road in South Kensington, the others being the Science Museum and the Victoria and Albert Museum. The Natural History Museum's main frontage, however, is on Cromwell Road.(From Wikipedia)",
  website: "http://www.nhm.ac.uk/",
  color: "#565656"
)
m.image = File.open("app/assets/images/nathist.jpg")
m.save
#https://upload.wikimedia.org/wikipedia/commons/c/c1/Natural_History_Museum_London_Jan_2006.jpg

m = Museum.create(
  user: admin,
  name: "Israel Museum",
  latitude: 31.772379,
  longitude: 35.204524,
  street_address: "Derech Ruppin",
  city: "Jerusalem",
  country: "Israel",
  description: "The Israel Museum was founded in 1965 as Israel's national museum. It is situated on a hill in the Givat Ram neighborhood of Jerusalem, near the Bible Lands Museum, the Knesset, the Israeli Supreme Court, and the Hebrew University of Jerusalem. Among the unique objects on display is the Venus of Berekhat Ram a carved female figurine considered the oldest artwork in the world; the interior of a 1736 Zedek ve Shalom synagogue from Suriname; necklaces worn by Jewish brides in Yemen; a mosaic Islamic prayer niche from 17th-century Persia; and a nail attesting to the practice of crucifixion in Jesus’ time. An urn-shaped building on the grounds of the museum, the Shrine of the Book, houses the Dead Sea Scrolls and artifacts discovered at Masada. It is one of the largest museums in the Middle East.",
  website: "http://www.english.imjnet.org.il/",
  color: "#abb03c"
)
m.image = File.open("app/assets/images/isreal.jpg")
m.save
#http://www.english.imjnet.org.il/media/Uploads/Israel-Museum-entry-nighttime%281%29.jpg

# 3.times do
#   m = Museum.create(
#     user: admin,
#     name: Faker::Company.name + " Museum",
#     latitude: Faker::Address.latitude,
#     longitude: Faker::Address.longitude,
#     street_address: Faker::Address.street_address,
#     city: Faker::Address.city,
#     country: Faker::Address.country,
#     description: Faker::Lorem.paragraph,
#     website: Faker::Internet.url,
#     color: ('#' + SecureRandom.hex(3))
#   )
#   m.image = open(Faker::Placeholdit.image)
#   m.save
#
#
# 4.times do
#   e = Exhibition.create(
#     user: admin,
#     museum: m,
#     name: Faker::Name.name + " Collection",
#     start_date: Faker::Date.between(20.years.ago, 10.years.ago),
#     end_date: Faker::Date.between(10.years.ago, Date.today),
#     description: Faker::Lorem.paragraph,
#     curator: Faker::Name
#   )
#   e.image = open(Faker::Placeholdit.image)
#   e.save
#
#   a = Artist.create(
#     name: Faker::Name.name
#   )
#
#   5.times do
#     artwork = Artwork.create(
#       exhibition: e,
#       name: Faker::Book.title,
#       image_id: id_counter,  # should put default image maybe using faker somewhere else
#       description: Faker::Hacker.say_something_smart,
#       date_created: Faker::Date.between(1000.years.ago, Date.today),
#       accession_no: Faker::Code.isbn,
#     )
#     artwork.artists << a
#     artwork.image = open(Faker::Placeholdit.image("1200x300"))
#     artwork.save
#     id_counter += 1
#   end
# end
# end
#
