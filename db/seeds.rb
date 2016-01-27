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
  { value: "AG.LND.IRIG.AG.ZS", name: "Agricultural irrigated land (% of total agricultural land)" },
  { value: "EE.BOD.TOTL.KG", name: "Organic water pollutant (BOD) emissions (kg per day)" },
  { value: "EG.USE.PCAP.KG.OE", name: "Energy use (kg of oil equivalent per capita)" },
  { value: "EG.ELC.RNEW.ZS", name: "Renewable electricity output (% of total electricity output)" },
  { value: "EG.FEC.RNEW.ZS", name: "Renewable energy consumption (% of total final energy consumption)" },
  { value: "EG.USE.COMM.CL.ZS", name: "Alternative and nuclear energy (% of total energy use),Energy & Mining" },
  { value: "EG.USE.COMM.FO.ZS", name: "Fossil fuel energy consumption (% of total),Energy & Mining" },
  { value: "EG.USE.CRNW.ZS", name: "Combustible renewables and waste (% of total energy),Energy & Mining" },
  { value: "EN.ATM.CO2E.EG.ZS", name: "CO2 intensity (kg per kg of oil equivalent energy use)" },
  { value: "EN.ATM.CO2E.PC", name: "CO2 emissions (metric tons per capita),Climate Change,Aid Effectiveness" },
  { value: "EN.ATM.METH.AG.ZS", name: "Agricultural methane emissions (% of total)" },
  { value: "ER.LND.PTLD.ZS", name: "Terrestrial protected areas (% of total land area)" },
  { value: "ER.H2O.FWAG.ZS", name: "Annual freshwater withdrawals, agriculture (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWDM.ZS", name: "Annual freshwater withdrawals, domestic (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWIN.ZS", name: "Annual freshwater withdrawals, industry (% of total freshwater withdrawal)" },
  { value: "ER.H2O.FWTL.ZS", name: "Annual freshwater withdrawals, total (% of internal resources)" },
  { value: "ER.H2O.INTR.K3", name: "Renewable internal freshwater resources, total (billion cubic meters)" },
  { value: "ER.H2O.INTR.PC", name: "Renewable internal freshwater resources per capita (cubic meters)" },
  { value: "EN.ATM.METH.EG.ZS", name: "Energy related methane emissions (% of total)" },
  { value: "EN.ATM.NOXE.AG.ZS", name: "Agricultural nitrous oxide emissions (% of total)" },
  { value: "EN.BIR.THRD.NO", name: "Bird species, threatened" },
  { value: "EN.CLC.DRSK.XQ", name: "Disaster risk reduction progress score (1-5 scale; 5=best)" },
  { value: "EN.CLC.MDAT.ZS", name: "Droughts, floods, extreme temperatures (% of population, average 1990-2009)" },
  { value: "EN.CO2.BLDG.ZS", name: "CO2 emissions from residential buildings and commercial and public services (% of total fuel combustion)" },
  { value: "EN.CO2.ETOT.ZS", name: "CO2 emissions from electricity and heat production, total (% of total fuel combustion)" },
  { value: "EN.CO2.MANF.ZS", name: "CO2 emissions from manufacturing industries and construction (% of total fuel combustion)" },
  { value: "EN.CO2.OTHX.ZS", name: "CO2 emissions from other sectors, excluding residential buildings and commercial and public services (% of total fuel combustion)" },
  { value: "EN.CO2.TRAN.ZS", name: "CO2 emissions from transport (% of total fuel combustion)" },
  { value: "EN.FSH.THRD.NO", name: "Fish species, threatened" },
  { value: "EN.HPT.THRD.NO", name: "Plant species (higher), threatened" },
  { value: "EN.MAM.THRD.NO", name: "Mammal species, threatened" },
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
