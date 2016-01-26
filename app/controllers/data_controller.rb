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

    if params["title"].nil?
      flash["notice"] = "You didn't choose any datasets/countries?!"
      redirect_to data_path
    elsif params["title"].count >= 1 && params["title"].count <= 3 && params["country"].count == 1
      @threatened = threatened(params["country"])
      info = []
      params["title"].each do |title|
        url = "http://api.worldbank.org/countries/#{params[:country][0]}/indicators/#{title}?per_page=500&date=1960:2016&format=json"
        info << JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
      end

      @infos_data = []
      info.each do |dataset|
        set = {}
        data = []
        dataset.map do |datum|
          data << [DateTime.parse("#{datum['date']}-01-01 00:00:00").to_i * 1000, datum["value"].to_f] if datum["value"]
        end
        set["title"] = dataset[1]["indicator"]["value"]
        set["country"] = dataset[1]["country"]["value"]
        set["data"] = data
        @infos_data << set
      end
    elsif params["title"].count == 1 && params["country"].count > 1
      @threatened = threatened(params["country"])
      info = []
      @no_info = []
      params["country"].each do |country|
        url = "http://api.worldbank.org/countries/#{country}/indicators/#{params["title"][0]}?per_page=500&date=1960:2016&format=json"
        output = JSON.parse(Net::HTTP.get_response(URI(url)).body)[1]
        if output.nil?
          @no_info << Location.find_by(isocode: country).country
        else
          info << output
        end
      end

      @infos_data = {}
      @infos_data["title"] = info[0][0]["indicator"]["value"]
      data = []
      info.each do |dataset|
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
      @infos_data["data"] = data
    else
      flash["notice"] = "Whoopsy?!"
      redirect_to data_path
    end
  end

  def threatened(country_array)
    return [1053, 48379, 24143, 32529, 354185] if country_array.include?("1W")
    extinct = 0
    threatened = 0
    lower_risk = 0
    data_deficient = 0
    least_concerned = 0
    country_array.each do |country|
      url = "http://apiv3.iucnredlist.org/api/v3/country/getspecies/#{country}?token=5d6279ab12fcdff4656202461bd97157972fa09db6e3c097e77e58ed4f87a653"
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
end
