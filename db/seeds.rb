# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

energy = Title.create(name: "Energy use (kg of oil equivalent per capita)")
biodiversity = Title.create(name: "GEF benefits index for biodiversity")

year2013 = Year.create(year: 2013)
year2008 = Year.create(year: 2008)

Fact.create([
  {title: energy, year: year2013, location: "Iceland", data: "16679"},
  {title: energy, year: year2013, location: "Luxembourg", data: "7327"},
  {title: energy, year: year2013, location: "Canada", data: "7149"},
  {title: energy, year: year2013, location: "United States", data: "6909"},
  {title: energy, year: year2013, location: "Norway", data: "6487"},
  {title: energy, year: year2013, location: "Finland", data: "5933"},

  {title: biodiversity, year: year2008, location: "Brazil", data: "100.0"},
  {title: biodiversity, year: year2008, location: "United States", data: "94.2"},
  {title: biodiversity, year: year2008, location: "Australia", data: "87.7"},
  {title: biodiversity, year: year2008, location: "Indonesia", data: "81.0"},
  {title: biodiversity, year: year2008, location: "Mexico", data: "68.7"},
  {title: biodiversity, year: year2008, location: "China", data: "66.6"},
  {title: biodiversity, year: year2008, location: "Colombia", data: "51.5"},
  {title: biodiversity, year: year2008, location: "India", data: "39.9"},
  {title: biodiversity, year: year2008, location: "Japan", data: "36.0"},
  {title: biodiversity, year: year2008, location: "Russia", data: "34.1"},
  {title: biodiversity, year: year2008, location: "Peru", data: "33.4"},
])
