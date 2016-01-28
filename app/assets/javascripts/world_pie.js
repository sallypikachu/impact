$(function () {
  $(document).ready(function () {
      // Build the chart
    $('#world_pie').highcharts({
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
      },
      title: {
        text: 'Endangered Animals around the World'
      },
      tooltip: {
        pointFormat: '{point.y} organisms'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            format: '{point.y} organisms',
          }
        }
      },
      series: [{
        name: 'Brands',
        colorByPoint: true,
        data: [{
          name: 'Extinct',
          y: 1053
        }, {
          name: 'Threatened',
          y: 48379,
          sliced: true,
          selected: true
        }, {
          name: 'At Risk',
          y: 24143
        }, {
          name: 'Data Deficient',
          y: 32529
        }, {
          name: 'Least Concerned',
          y: 354185
        }]
      }]
    });
  });
});
