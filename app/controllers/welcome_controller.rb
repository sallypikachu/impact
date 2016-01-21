class WelcomeController < ApplicationController
  def home
    @fact = Fact.new
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
    url = "http://api.worldbank.org/countries/USA/indicators/8.1.1_FINAL.ENERGY.CONSUMPTION?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

    @energy_data = []
    @info[1].map {|y| @energy_data << [y["date"], y["value"].to_f] if y["value"]}
    @energy_data.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @energy = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(defaultSeriesType: "spline")
      f.title(text: "Total final consumption")
      f.series(name: "USA", data: @energy_data)
      f.xAxis(type: "datetime")
      f.yAxis(title: {:text => "Tetrajoule (TJ)", style: { color: '#333'}})
    end

    url = "http://api.worldbank.org/countries/USA/indicators/ER.BDV.TOTL.XQ?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

    @bio = []
    @info[1].map {|y| @bio << [y["date"], y["value"].to_f] if y["value"]}
    @bio.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end
    @bio = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(defaultSeriesType: "spline")
      f.title(text: "Biodiversity")
      f.series(name: "USA", data: @bio)
      f.xAxis(type: "datetime")
      f.yAxis(title: {:text => "GEF", style: { color: '#333'}})
    end
  end
end
