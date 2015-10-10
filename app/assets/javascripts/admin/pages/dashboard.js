window.formatCurrency = d3.format(',f');
window.monthlyAdoptionChart;
var efficiencyGraph = $('.graph__effective-adoption'),
    efficiencyGraphData = [
        {
          "label": "Adoptados",
          "value" : parseInt(efficiencyGraph.data('adopted'))
        } ,
        {
          "label": "Totales",
          "value" : parseInt(efficiencyGraph.data('total'))
        }
    ],
    monthlySolvedReports = $('monthlySolvedReports'),
    monthlyAdoptionGraph = $('#monthlyAdoption'),
    eventsMonthlyGraph = $('#monthlyAdoption')

// create unique dates

// debugger;
// for (var i = 0; i < data_adopted.length; i++) {
//     var yVal;
//     if ( data_adopted[i] === undefined ) { yVal = 0 } else { yVal = data_adopted[i][1] }
//     monthlyAdoptionData[0].values.push({x: new Date(data_adopted[i][0]) , y:yVal })
//     if ( data_free[i] === undefined ) { yVal = 0 } else { yVal = data_free[i][1] }
//     monthlyAdoptionData[1].values.push({x: new Date(data_adopted[i][0]) , y:yVal })
//     if ( data_inprocess[i] === undefined ) { yVal = 0 } else { yVal = data_inprocess[i][1] }
//     monthlyAdoptionData[2].values.push({x: new Date(data_adopted[i][0]) , y:yVal })
// };

nv.addGraph(function() {
  var efficiencyGraphChart = nv.models.pieChart()
      .x(function(d) { return d.label })
      .y(function(d) { return d.value })
      .showLabels(false)
      .margin({top: 0, right: 0, bottom: 0, left: 0})
      .showLegend(false)
      .donut(true);

    d3.select(".graph__effective-adoption svg")
        .datum(efficiencyGraphData)
      .transition().duration(1200)
        .call(efficiencyGraphChart);

    efficiencyGraphChart.tooltipContent(function(key, y, e, graph) {
        return '<h3>' + key + '</h3>' +
               '<p>' +  parseInt(y) + '</p>'
    })

  return efficiencyGraphChart;
});

// nv.addGraph(function() {
//   monthlySolvedReportsChart = nv.models.lineChart()
//     .margin({top: 10, right: 30, bottom: 50, left: 30})
//     .useInteractiveGuideline(true);

//     monthlySolvedReportsChart.yAxis
//         .axisLabel('Numbers')
//         .tickFormat(d3.format('d'));

//     monthlySolvedReportsChart.xAxis
//         .axisLabel('Fecha')
//         .rotateLabels(-45)
//         .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

//   d3.select('#monthlySolvedReports svg')
//     .datum(solvedReportsData)
//     .transition().duration(500)
//     .call(monthlySolvedReportsChart);

//   nv.utils.windowResize(monthlySolvedReportsChart.update);

//   return monthlySolvedReportsChart;
// });

nv.addGraph(function() {
    window.monthlySolvedReportsChart = nv.models.multiBarChart()
      .showControls(false)
      .showLegend(false);

    monthlySolvedReportsChart.yAxis
        .tickFormat(d3.format('f'));

    monthlySolvedReportsChart
      .xAxis
      .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

    monthlySolvedReportsChart
      .tooltipContent(function(key, y, e, graph) {
        return '<h3><small>' + y + '</small></h3>' +'<p>' + e + '</p>' ;
      })

    // monthlySolvedReportsChart.yAxis
    //     .tickFormat(d3.format('f'));

    d3.select('#monthlySolvedReports svg')
        .datum(solvedReportsData)
        .transition().duration(500)
        .call(monthlySolvedReportsChart)
        ;

    nv.utils.windowResize(monthlySolvedReportsChart.update);

    return monthlySolvedReportsChart;
});

nv.addGraph(function() {
  monthlyAdoptionChart = nv.models.lineChart()
    .margin({top: 10, right: 30, bottom: 50, left: 30})
    .useInteractiveGuideline(true);

    monthlyAdoptionChart.yAxis
        .axisLabel('Numbers')
        .tickFormat(d3.format('d'));

    monthlyAdoptionChart.xAxis
        .axisLabel('Fecha')
        .rotateLabels(-45)
        .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

  d3.select('#monthlyAdoption svg')
    .datum(monthlyAdoptionData)
    .transition().duration(500)
    .call(monthlyAdoptionChart);

  nv.utils.windowResize(monthlyAdoptionChart.update);

  return monthlyAdoptionChart;
});

nv.addGraph(function() {
    window.eventsMonthlyChart = nv.models.multiBarChart()
      .showControls(false)
      .showLegend(false);

    eventsMonthlyChart.yAxis
        .tickFormat(d3.format('f'));

    eventsMonthlyChart
      .xAxis
      .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

    eventsMonthlyChart
      .tooltipContent(function(key, y, e, graph) {
        return '<h3><small>' + y + '</small></h3>' +'<p>' + e + '</p>' ;
      })

    // eventsMonthlyChart.yAxis
    //     .tickFormat(d3.format('f'));

    d3.select('#eventsMonthly svg')
        .datum(event_graph)
        .transition().duration(500)
        .call(eventsMonthlyChart)
        ;

    nv.utils.windowResize(eventsMonthlyChart.update);

    return eventsMonthlyChart;
});

nv.addGraph(function() {
    window.moneyMonthlyChart = nv.models.multiBarChart()
      .showControls(false)
      .showLegend(false);

    moneyMonthlyChart.yAxis
        .tickFormat(d3.format(',f'));

    moneyMonthlyChart
      .xAxis
      .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

    moneyMonthlyChart
      .tooltipContent(function(key, y, e, graph) {
        return '<h3><small>' + y + '</small></h3>' +'<p>$ ' + e + ' MXN</p>' ;
      })

    // moneyMonthlyChart.yAxis
    //     .tickFormat(d3.format('f'));

    d3.select('#moneyMonthly svg')
        .datum(money_graph)
        .transition().duration(500)
        .call(moneyMonthlyChart)
        ;

    nv.utils.windowResize(moneyMonthlyChart.update);

    return moneyMonthlyChart;
});

nv.addGraph(function() {
    window.questionsMonthlyChart = nv.models.multiBarChart()
      .showControls(false)
      .showLegend(false);

    questionsMonthlyChart.yAxis
        .tickFormat(d3.format('f'));

    questionsMonthlyChart
      .xAxis
      .tickFormat(function(d) { return d3.time.format('%m/%Y')(new Date(d)) });

    questionsMonthlyChart
      .tooltipContent(function(key, y, e, graph) {
        return '<h3><small>' + y + '</small></h3>' +'<p>' + e + '</p>' ;
      })

    // questionsMonthlyChart.yAxis
    //     .tickFormat(d3.format('f'));

    d3.select('#questionsMonthly svg')
        .datum(questions_graph)
        .transition().duration(500)
        .call(questionsMonthlyChart)
        ;

    nv.utils.windowResize(questionsMonthlyChart.update);

    return questionsMonthlyChart;
});