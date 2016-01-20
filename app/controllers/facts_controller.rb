class FactsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tables = []
    titles = Title.all
    years = Year.all
    titles.each do |title|
      @tables << title.facts
    end
    @t = []
    titles.each do |title|
      years.each do |year|
        @t << Fact.where(title: title, year: year)
      end
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
