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
    @description = dataset_description(params["title"]) unless params["title"].nil?
    @threatened = threatened(params["country"]) if params["pie"] == "1"
    if params["title"].nil?
      flash["notice"] = "You didn't choose any datasets/countries?!"
      redirect_to data_path
    elsif params["title"].count >= 1 && params["title"].count <= 3 && params["country"].count == 1
      info = world_bank_info(params["country"], params["title"])
      @infos_data = multi_dataset_info(info)
    elsif params["title"].count == 1 && params["country"].count > 1
      info = world_bank_info(params["country"], params["title"])
      @no_info = []
      params["country"].each do |country|
        url = "http://api.worldbank.org/countries/#{country}/indicators/#{params["title"][0]}?date=1960:2016&format=json"
        output = JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
        if output.nil?
          @no_info << Location.find_by(isocode: country).country
        end
      end
      @infos_data = multi_countries_info(info)
    else
      flash["notice"] = "Whoopsy?!"
      redirect_to data_path
    end
  end

  def learn
    info = world_bank_info(["AM"], ["SP.POP.TOTL", "EG.USE.PCAP.KG.OE"])
    @infos_data = multi_dataset_info(info)
    info = world_bank_info(["IS", "US"], ["EG.USE.PCAP.KG.OE"])
    @energy = multi_countries_info(info)
  end

  def dataset_description(indicator_array)
    description = []
    indicator_array.each do |dataset|
    url = "http://api.worldbank.org/indicators/#{dataset}?format=json"
    info = JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
    description << { "title" => info[0]["name"], "description" => info[0]["sourceNote"] }
    end
    description
  end

  def threatened(country_array)
    return [1053, 48379, 24143, 32529, 354185] if country_array.include?("1W")
    extinct = 0
    threatened = 0
    lower_risk = 0
    data_deficient = 0
    least_concerned = 0
    country_array.each do |country|
      url = "http://apiv3.iucnredlist.org/api/v3/country/getspecies/#{country}?token=#{ENV['IUCN_TOKEN']}"
      info = JSON.parse(Net::HTTP.get_response(URI(url)).body)
      info["result"].each do |specie|
        case specie["category"]
        when "EX", "EW" then extinct += 1
        when "CR", "EN", "VU" then threatened += 1
        when "NT", "LR/nt" then lower_risk += 1
        when "DD" then data_deficient += 1
        when "LR/lc", "LC" then least_concerned += 1
        end
      end
    end
    return [extinct, threatened, lower_risk, data_deficient, least_concerned]
  end

  def world_bank_info(country_array, dataset_array)
    info = []
    dataset_array.each do |dataset|
      country_array.each do |country|
        url = "http://api.worldbank.org/countries/#{country}/indicators/#{dataset}?per_page=500&date=1960:2016&format=json"
        temp = JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
        info << temp unless temp.nil?
      end
    end
    info
  end

  def multi_dataset_info(array)
    infos_data = []
    array.each do |dataset|
      set = {}
      data = []
      dataset.map do |datum|
        data << [DateTime.parse("#{datum['date']}-01-01 00:00:00").to_i * 1000, datum["value"].to_f] if datum["value"]
      end
      set["title"] = dataset[1]["indicator"]["value"]
      set["country"] = dataset[1]["country"]["value"]
      set["data"] = data
      infos_data << set
    end
    infos_data
  end

  def multi_countries_info(array)
    infos_data = {}
    infos_data["title"] = array[0][0]["indicator"]["value"]
    data = []
    array.each do |dataset|
      country_data = {}
      unless dataset.nil?
        country_data["country"] = dataset[0]["country"]["value"]
        set = []
        dataset.map do |datum|
          set << [DateTime.parse("#{datum['date']}-01-01 00:00:00").to_i * 1000, datum["value"].to_f] if datum["value"]
        end
        country_data["data"] = set
        data << country_data
      end
    end
    infos_data["data"] = data
    infos_data
  end
end
