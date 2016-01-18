class FactsController < ApplicationController
  def index
    @tables = []
    titles = Title.all
    titles.each do |title|
      @tables << title.fact
    end
  end

  def show
  end

  def new
    @fact = Fact.new
  end

  def create
  end
end
