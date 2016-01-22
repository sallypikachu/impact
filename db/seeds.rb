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

# "AG.CON.FERT.PT.ZS","Fertilizer consumption (% of fertilizer production)","Agriculture & Rural Development"
# "AG.CON.FERT.ZS","Fertilizer consumption (kilograms per hectare of arable land)","Agriculture & Rural Development"
# "AG.LND.AGRI.ZS","Agricultural land (% of land area)","Climate Change","Agriculture & Rural Development"
# "AG.LND.ARBL.HA","Arable land (hectares)","Agriculture & Rural Development"
# "AG.LND.ARBL.HA.PC","Arable land (hectares per person)","Agriculture & Rural Development"
# "AG.LND.ARBL.ZS","Arable land (% of land area),""Agriculture & Rural Development"
# "AG.LND.CROP.ZS","Permanent cropland (% of land area)","Agriculture & Rural Development"
# "AG.LND.PRCP.MM","Average precipitation in depth (mm per year)","Agriculture & Rural Development"
# "AG.LND.TOTL.K2","Land area (sq. km)","Agriculture & Rural Development"
# "AG.PRD.CROP.XD","Crop production index (2004-2006 = 100)","Agriculture & Rural Development"
# "AG.PRD.FOOD.XD","Food production index (2004-2006 = 100)","Agriculture & Rural Development"
# "AG.PRD.LVSK.XD","Livestock production index (2004-2006 = 100)","Agriculture & Rural Development"
# "EN.AGR.EMPL","Economically active population in agriculture (number)","Agriculture & Rural Development"
#
# "DT.DIS.IDAG.CD","IDA grants (current US$)","External Debt","Aid Effectiveness"
#
# "AG.LND.FRST.K2","Forest area (sq. km)","Environment","Agriculture & Rural Development","Climate Change"
# "AG.LND.IRIG.AG.ZS","Agricultural irrigated land (% of total agricultural land)","Agriculture & Rural Development","Climate Change"
#
# "ER.LND.PTLD.ZS","Terrestrial protected areas (% of total land area)","Environment","Climate Change"
#
# "BN.GSR.FCTY.CD","Net primary income (BoP, current US$)","Economy & Growth"
#
# "EG.GDP.PUSE.KO.PP","GDP per unit of energy use (PPP $ per kg of oil equivalent)","Energy & Mining"
# "EG.GDP.PUSE.KO.PP.KD","GDP per unit of energy use (constant 2011 PPP $ per kg of oil equivalent)","Energy & Mining"

(1960..2015).each do |year|
  Year.create(year: year)
end

a = JSON.parse(Net::HTTP.get_response(URI("http://apiv3.iucnredlist.org/api/v3/country/list?token=5d6279ab12fcdff4656202461bd97157972fa09db6e3c097e77e58ed4f87a653")).body)

a["results"].each do |country|
  Location.create(country: country["country"], isocode: country["isocode"])
end

Fact.create([
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "Iceland"), data: "16679" },
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "Luxembourg"), data: "7327" },
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "Canada"), data: "7149" },
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "United States"), data: "6909" },
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "Norway"), data: "6487" },
  { title: energy, year: Year.find_by(year: 2013), location: Location.find_by(country: "Finland"), data: "5933" },

  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "Iceland"), data: "17756" },
  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "Luxembourg"), data: "7707" },
  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "Canada"), data: "7226" },
  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "United States"), data: "6815" },
  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "Norway"), data: "5817" },
  { title: energy, year: Year.find_by(year: 2012), location: Location.find_by(country: "Finland"), data: "6151" },

  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "Iceland"), data: "17964" },
  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "Luxembourg"), data: "8044" },
  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "Canada"), data: "7367" },
  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "United States"), data: "7029" },
  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "Norway"), data: "5652" },
  { title: energy, year: Year.find_by(year: 2011), location: Location.find_by(country: "Finland"), data: "6464" },

  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "Iceland"), data: "16882" },
  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "Luxembourg"), data: "8322" },
  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "Canada"), data: "7390" },
  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "United States"), data: "7162" },
  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "Norway"), data: "6621" },
  { title: energy, year: Year.find_by(year: 2010), location: Location.find_by(country: "Finland"), data: "6808" },

  { title: energy, year: Year.find_by(year: 2009), location: Location.find_by(country: "Iceland"), data: "16905" },

  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Brazil"), data: "100.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "United States"), data: "94.2" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Australia"), data: "87.7" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Indonesia"), data: "81.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Mexico"), data: "68.7" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "China"), data: "66.6" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Colombia"), data: "51.5" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "India"), data: "39.9" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Japan"), data: "36.0" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Russia"), data: "34.1" },
  { title: biodiversity, year: Year.find_by(year: 2008), location: Location.find_by(country: "Peru"), data: "33.4" },
])
