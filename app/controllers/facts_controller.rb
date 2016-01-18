class FactsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tables = []
    titles = Title.all
    years = Year.all
    titles.each do |title|
      @tables << title.fact
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
      :location,
      :data,
    )
  end
end
