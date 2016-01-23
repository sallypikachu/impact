class DataController < ApplicationController

  def choose_data
    @titles = []
    Title.all.each do |title|
      @titles << [title.name, title.value]
    end
    @locations = []
    Location.all.each do |location|
      @locations << [location.country, location.isocode]
    end
    @locations.sort!
  end

  def display_data
    info = []
    params["title"].each do |title|
      url = "http://api.worldbank.org/countries/#{params[:country]}/indicators/#{title}?per_page=500&date=1960:2016&format=json"
      info << JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
    end

    @infos_data = []
    info.each do |dataset|
      set = {}
      data = []
      dataset.map do |datum|
        data << [DateTime.parse("#{datum['date']}-01-01 00:00:00").to_i*1000, datum["value"].to_f] if datum["value"]
      end
      set["title"] = dataset[1]["indicator"]["value"]
      set["country"] = dataset[1]["country"]["value"]
      set["data"] = data
      @infos_data << set
    end

    info_data = []
    info[0].map do |y|
      info_data << [y["date"], y["value"].to_f] if y["value"]
    end
    info_data.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @info_hash = {}
    @info_hash["title"] = info[0][1]["indicator"]["value"]
    @info_hash["country"] = info[0][1]["country"]["value"]
    @info_hash["data"] = info_data
  end

  def display1
    url = "http://api.worldbank.org/countries/#{params[:country]}/indicators/#{params[:title]}?per_page=500&date=1960:2016&format=json"
    info = JSON.parse(Net::HTTP.get_response(URI(url)).body)

    info_data = []
    info[1].map do |y|
      info_data << [y["date"], y["value"].to_f] if y["value"]
    end
    info_data.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @info_hash = {}
    @info_hash["title"] = info[1][1]["indicator"]["value"]
    @info_hash["country"] = info[1][1]["country"]["value"]
    @info_hash["data"] = info_data
  end

  def display2
  end

  def show
  end

end
