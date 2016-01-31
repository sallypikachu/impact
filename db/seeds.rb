# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: "test", email: "test@m.com", password: "12345678")

Title.create([
  { value: "SP.POP.TOTL", name: "Population, total"},
  { value: "EN.POP.DNST", name: "Population density (people per sq. km of land area)" },
  { value: "AG.LND.FRST.K2", name: "Forest area (sq. km)" },
  { value: "AG.LND.FRST.ZS", name: "Forest area (% of land area)" },
  { value: "EG.USE.PCAP.KG.OE", name: "Energy use (kg of oil equivalent per capita)" },
  { value: "AG.LND.IRIG.AG.ZS", name: "Agricultural irrigated land (% of total agricultural land)" },
  { value: "EG.ELC.RNEW.ZS", name: "Renewable electricity output (% of total electricity output)" },
  { value: "EG.FEC.RNEW.ZS", name: "Renewable energy consumption (% of total final energy consumption)" },
  { value: "EG.USE.COMM.CL.ZS", name: "Alternative and nuclear energy (% of total energy use),Energy & Mining" },
  { value: "EG.USE.COMM.FO.ZS", name: "Fossil fuel energy consumption (% of total),Energy & Mining" },
  { value: "EG.USE.CRNW.ZS", name: "Combustible renewables and waste (% of total energy),Energy & Mining" },
  { value: "EN.ATM.CO2E.PC", name: "CO2 emissions (metric tons per capita)" },
  { value: "EN.ATM.METH.AG.ZS", name: "Agricultural methane emissions (% of total)" },
  { value: "ER.LND.PTLD.ZS", name: "Terrestrial protected areas (% of total land area)" },
  { value: "ER.H2O.FWAG.ZS", name: "Annual freshwater withdrawals, agriculture (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWDM.ZS", name: "Annual freshwater withdrawals, domestic (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWIN.ZS", name: "Annual freshwater withdrawals, industry (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWTL.ZS", name: "Annual freshwater withdrawals, total (% of internal resources)" },
  { value: "EN.ATM.METH.EG.ZS", name: "Energy related methane emissions (% of total)" },
  { value: "EN.ATM.NOXE.AG.ZS", name: "Agricultural nitrous oxide emissions (% of total)" },
  { value: "EN.CO2.BLDG.ZS", name: "CO2 emissions from residential buildings and commercial and public services (% of total fuel combustion)" },
  { value: "EN.CO2.ETOT.ZS", name: "CO2 emissions from electricity and heat production, total (% of total fuel combustion)" },
  { value: "EN.CO2.MANF.ZS", name: "CO2 emissions from manufacturing industries and construction (% of total fuel combustion)" },
  { value: "EN.CO2.OTHX.ZS", name: "CO2 emissions from other sectors, excluding residential buildings and commercial and public services (% of total fuel combustion)" },
  { value: "EN.CO2.TRAN.ZS", name: "CO2 emissions from transport (% of total fuel combustion)" },
  { value: "ER.BDV.TOTL.XQ", name: "GEF benefits index for biodiversity (0 = no biodiversity potential to 100 = maximum)" },
  { value: "ER.GDP.FWTL.M3.KD", name: "Water productivity, total (constant 2005 US$ GDP per cubic meter of total freshwater withdrawal)" },
  { value: "ER.MRN.PTMR.ZS", name: "Marine protected areas (% of territorial waters)" },
  { value: "ER.PTD.TOTL.ZS", name: "Terrestrial and marine protected areas (% of total territorial area)" }
])

(1960..2015).each do |year|
  Year.create(year: year)
end

a = JSON.parse(Net::HTTP.get_response(URI("http://apiv3.iucnredlist.org/api/v3/country/list?token=5d6279ab12fcdff4656202461bd97157972fa09db6e3c097e77e58ed4f87a653")).body)

Location.create(country: "World", isocode: "1W")

a["results"].each do |country|
  Location.create(country: country["country"], isocode: country["isocode"])
end
