/* [ ---- Ebro Admin - charts ---- ] */

$(function() {
    charts.init();
})

charts = {
    init: function() {
        if ($('.easy_chart_b').length) {
            $('.easy_chart_b').easyPieChart({
                animate: 2000,
                lineWidth: 5,
                scaleColor: false,
                barColor: '#48AC2E'
            });
        }
        if ($('#monthlyAdoption').length) {
            var chart_placeholder = $('#monthlyAdoption');

            var options = {
                grid: {
                    clickable: true,
                    hoverable: true,
                    autoHighlight: true,
                    backgroundColor: null,
                    borderWidth: 0,
                    color: "#666",
                    labelMargin: 10,
                    axisMargin: 0,
                    mouseActiveRadius: 10,
                    minBorderMargin: 5
                },
                series: {
                    lines: {
                        show: true,
                        lineWidth: 3,
                        steps: false
                    },
                    points: {
                        show: true,
                        radius: 4,
                        symbol: "circle",
                        fill: true
                    }
                },
                tooltip: true,
                tooltipOpts: {
                    content: "%x - %y",
                    shifts: {
                        x: 20,
                        y: 0
                    },
                    defaultTheme: false
                },
                xaxis: {
                    mode: "time",
                    minTickSize: [1, "day"],
                    timeformat: "%d/%m",
                    labelWidth: "40"
                },
                yaxis: {
                    min: 0
                },
                legend: {
                    noColumns: 0,
                    position: "ne"
                },
                colors: ["#7baf42", "#0892cd", "#efa91f"],
                shadowSize: 0
            };

            $.plot(chart_placeholder, [{
                label: "Adoptado",
                data: data_adopted,
                points: {
                    fillColor: '#fff'
                }
            }, {
                label: "Libre",
                data: data_free,
                points: {
                    fillColor: '#fff'
                }
            }, {
                label: "En Proceso",
                data: data_inprocess,
                points: {
                    fillColor: '#fff'
                }
            }], options);
        }
    }
}