# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: "test", email: "test@m.com", password: "12345678")

energy = Title.create(name: "Energy use (kg of oil equivalent per capita)")
biodiversity = Title.create(name: "GEF benefits index for biodiversity")

(1960..2015).each do |year|
  Year.create(year: year)
end

a = JSON.parse(Net::HTTP.get_response(URI("http://apiv3.iucnredlist.org/api/v3/country/list?token=5d6279ab12fcdff4656202461bd97157972fa09db6e3c097e77e58ed4f87a653")).body)

iceland = Location.create(country: "Iceland")
luxembourg = Location.create(country: "Luxembourg")
canada = Location.create(country: "Canada")
us = Location.create(country: "United States")
norway = Location.create(country: "Norway")
finland = Location.create(country: "Finland")
brazil = Location.create(country: "Brazil")
australia = Location.create(country: "Australia")
indonesia = Location.create(country: "Indonesia")
mexico = Location.create(country: "Mexico")
china = Location.create(country: "China")
colombia = Location.create(country: "Colombia")
india = Location.create(country: "India")
japan = Location.create(country: "Japan")
russia = Location.create(country: "Russia")
peru = Location.create(country: "Peru")

Fact.create([
  { title: energy, year: Year.find_by(year: 2013), location: iceland, data: "16679" },
  { title: energy, year: Year.find_by(year: 2013), location: luxembourg, data: "7327" },
  { title: energy, year: Year.find_by(year: 2013), location: canada, data: "7149" },
  { title: energy, year: Year.find_by(year: 2013), location: us, data: "6909" },
  { title: energy, year: Year.find_by(year: 2013), location: norway, data: "6487" },
  { title: energy, year: Year.find_by(year: 2013), location: finland, data: "5933" },

  { title: energy, year: Year.find_by(year: 2012), location: iceland, data: "17756" },
  { title: energy, year: Year.find_by(year: 2012), location: luxembourg, data: "7707" },
  { title: energy, year: Year.find_by(year: 2012), location: canada, data: "7226" },
  { title: energy, year: Year.find_by(year: 2012), location: us, data: "6815" },
  { title: energy, year: Year.find_by(year: 2012), location: norway, data: "5817" },
  { title: energy, year: Year.find_by(year: 2012), location: finland, data: "6151" },

  { title: energy, year: Year.find_by(year: 2011), location: iceland, data: "17964" },
  { title: energy, year: Year.find_by(year: 2011), location: luxembourg, data: "8044" },
  { title: energy, year: Year.find_by(year: 2011), location: canada, data: "7367" },
  { title: energy, year: Year.find_by(year: 2011), location: us, data: "7029" },
  { title: energy, year: Year.find_by(year: 2011), location: norway, data: "5652" },
  { title: energy, year: Year.find_by(year: 2011), location: finland, data: "6464" },

  { title: energy, year: Year.find_by(year: 2010, location: iceland, data: "16882" },
  { title: energy, year: Year.find_by(year: 2010, location: luxembourg, data: "8322" },
  { title: energy, year: Year.find_by(year: 2010, location: canada, data: "7390" },
  { title: energy, year: Year.find_by(year: 2010, location: us, data: "7162" },
  { title: energy, year: Year.find_by(year: 2010, location: norway, data: "6621" },
  { title: energy, year: Year.find_by(year: 2010, location: finland, data: "6808" },

  { title: energy, year: Year.find_by(year: 2009), location: iceland, data: "16905" },

  { title: biodiversity, year: Year.find_by(year: 2008), location: brazil, data: "100.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: us, data: "94.2" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: australia, data: "87.7" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: indonesia, data: "81.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: mexico, data: "68.7" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: china, data: "66.6" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: colombia, data: "51.5" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: india, data: "39.9" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: japan, data: "36.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: russia, data: "34.1" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: peru, data: "33.4" },
])
