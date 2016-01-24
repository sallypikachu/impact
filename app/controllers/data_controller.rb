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
    elsif params["title"].count > 1 && params["title"].count <= 3 && params["country"].count == 1
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
end
