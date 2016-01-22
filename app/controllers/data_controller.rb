class DataController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def choose_data
    @titles = []
    Title.all.each do |title|
      @titles << [title.name, title.id]
    end
    @locations = []
    Location.all.each do |location|
      @locations << [location.country, location.id]
    end
  end

  def display_data
    binding.pry
  end

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
