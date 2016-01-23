class WelcomeController < ApplicationController
  def home
    url = "http://api.worldbank.org/countries/BR/indicators/EG.USE.PCAP.KG.OE?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

    @energy_data = []
    @info[1].map {|y| @energy_data << [y["date"], y["value"].to_f] if y["value"]}
    @energy_data.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @energy_hash = {}
    @energy_hash["title"] = @info[1][1]["indicator"]["value"]
    @energy_hash["country"] = @info[1][1]["country"]["value"]
    @energy_hash["data"] = @energy_data

    url = "http://api.worldbank.org/countries/BR/indicators/AG.LND.FRST.ZS?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

    @bio_data = []
    @info[1].map {|y| @bio_data << [y["date"], y["value"].to_f] if y["value"]}
    @bio_data.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @bio_hash = {}
    @bio_hash["title"] = @info[1][1]["indicator"]["value"]
    @bio_hash["data"] = @bio_data
  end
end
