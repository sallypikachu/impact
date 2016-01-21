class WelcomeController < ApplicationController
  def home
    url = "http://api.worldbank.org/countries/USA/indicators/8.1.1_FINAL.ENERGY.CONSUMPTION?per_page=500&date=1960:2016&format=json"
    info = Net::HTTP.get_response(URI(url)).body
    @info = JSON.parse(info)

    x = []
    @info[1].map {|y| x << [y["date"], y["value"].to_f] if y["value"]}
    x.each do |y|
      if y[1]
        y[0] = DateTime.parse("#{y[0]}-01-01 00:00:00").to_i*1000
      end
    end

    @playground = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart(defaultSeriesType: "spline")
      f.title(text: "Total final consumption")
      f.series(name: "USA", data: x)
      f.xAxis(type: "datetime")
      f.yAxis(title: {:text => "Tetrajoule (TJ)", style: { color: '#333'}})
    end
  end
end
