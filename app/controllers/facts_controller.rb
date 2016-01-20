class FactsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    titles = Title.all
    years = Year.all
    @t = []
    titles.each do |title|
      years.each do |year|
        @t << Fact.where(title: title, year: year)
      end
    end
    @tables = {}
    titles.each do |title|
      uniq_years = title.years.map{|x| x.year}.uniq.sort
      uniq_locations = title.locations.map{|x| x.country}.uniq
      @tables[title.name] = {}
      data = {}
      countries_data = []
      uniq_locations.each do |location|
        country_data = []
        uniq_years.each do |year|
          year_data = Fact.where(title: Title.find_by(name: title.name), location: Location.find_by(country: location), year: Year.find_by(year: year))
          if year_data[0]
            country_data << year_data[0].data
          else
            country_data << ""
          end
        end
        country_data.unshift(location)
        countries_data << country_data
      end
      uniq_years.unshift("Country")
      data[:columns] = uniq_years
      data[:country_data] = countries_data
      @tables[title.name] = data
    end
    url = "http://api.worldbank.org/countries/USA/indicators/8.1.1_FINAL.ENERGY.CONSUMPTION?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

      @data = {"status" => "ok", "data" => [{"2014-06-16 16:00:00" => 24.2},{"2014-06-17 12:00:00" => 30.2},{"2014-06-18 17:00:00" => 42.9}]}
      d = []
      @data['data'].each do |data|
        d << [DateTime.parse(data.keys.first).to_i*1000, data.values.first]
      end
      @playground = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Total final consumption")
        f.series(type: 'line', name: "USA", data: d)
        f.xAxis(type: "datetime")
        f.yAxis(title: {:text => "Tetrajoule (TJ)", style: { color: '#333'}})
      end
    end

    def show
    end

    def new
      @fact = Fact.new
      @title = Title.new
      @year = Year.new
      @titles = []
      Title.all.each do |title|
        @titles << [title.name, title.id]
      end
      @years = []
      Year.all.each do |year|
        @years << [year.year, year.id]
      end
      @locations = []
      Location.all.each do |location|
        @locations << [location.country, location.id]
      end
    end

    def create
      @fact = Fact.new(fact_params)
      @fact.user = current_user
      if @fact.save
        flash.notice = "Venue added successfully"
        redirect_to facts_path
      else
        flash.notice = @fact.errors.full_messages.join(". ")
        render "new"
      end
    end

    def fact_params
      params.require(:fact).permit(
      :title_id,
      :year_id,
      :location_id,
      :data,
      )
    end
  end
