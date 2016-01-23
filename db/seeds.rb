# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: "test", email: "test@m.com", password: "12345678")

Title.create([
  { value: "AG.LND.FRST.ZS", name: "Forest area (% of land area)" },
  { value: "EG.USE.PCAP.KG.OE", name: "Energy use (kg of oil equivalent per capita)" },
  { value: "EN.POP.DNST", name: "Population density (people per sq. km of land area)" },
  { value: "EG.FEC.RNEW.ZS", name: "Renewable energy consumption (% of total final energy consumption)" },
  { value: "AG.LND.FRST.K2", name: "Forest area (sq. km)" },
  { value: "AG.LND.IRIG.AG.ZS", name: "Agricultural irrigated land (% of total agricultural land)" },
  { value: "ER.LND.PTLD.ZS", name: "Terrestrial protected areas (% of total land area)" },
  { value: "BN.GSR.FCTY.CD", name: "Net primary income (BoP, current US$)" },
  { value: "EG.GDP.PUSE.KO.PP", name: "GDP per unit of energy use (PPP $ per kg of oil equivalent)" },
  { value: "EG.GDP.PUSE.KO.PP.KD", name: "GDP per unit of energy use (constant 2011 PPP $ per kg of oil equivalent)" }
])

(1960..2015).each do |year|
  Year.create(year: year)
end

a = JSON.parse(Net::HTTP.get_response(URI("http://apiv3.iucnredlist.org/api/v3/country/list?token=5d6279ab12fcdff4656202461bd97157972fa09db6e3c097e77e58ed4f87a653")).body)

Location.create(country: "World", isocode: "1W")

a["results"].each do |country|
  Location.create(country: country["country"], isocode: country["isocode"])
end
