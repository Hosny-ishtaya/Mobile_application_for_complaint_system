import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Statistic extends StatefulWidget {
  final Widget child;

  Statistic({Key key, this.child}) : super(key: key);

  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  double price = 0;
  double out = 0;
  double qulity = 0;
  double bad = 0;
  double other = 0;
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() async {
    final urlp =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Price";
    final urip = Uri.parse(urlp);
    final responsep = await http.get(urip);

    if (responsep.statusCode == 200) {
      final json = jsonDecode(responsep.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        price = json; // there we put all info from database in this list
      });
    }

    print(responsep.statusCode);
    print(responsep.body);

    //****************************************************** */

    final urlq =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Quality and quality";
    final uriq = Uri.parse(urlq);
    final responseq = await http.get(uriq);

    if (responseq.statusCode == 200) {
      final json = jsonDecode(responseq.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        qulity = json; // there we put all info from database in this list
      });
    }

    //********************************************************************************** */

    final urlo =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Out of date";
    final urio = Uri.parse(urlo);
    final responseo = await http.get(urio);

    if (responseo.statusCode == 200) {
      final json = jsonDecode(responseo.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        out = json; // there we put all info from database in this list
      });
    }
//********************************************************************************************** */

    final urlb =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Bad Service";
    final urib = Uri.parse(urlb);
    final responseb = await http.get(urib);

    if (responseb.statusCode == 200) {
      final json = jsonDecode(responseb.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        bad = json; // there we put all info from database in this list
      });
    }

    //********************************************************************************* */
    final urlot =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Others";
    final uriot = Uri.parse(urlot);
    final responseot = await http.get(uriot);

    if (responseot.statusCode == 200) {
      final json = jsonDecode(responseot.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        other = json; // there we put all info from database in this list
      });
    }
    var data1 = [
      new Pollution(1980, 'USA', 30),
      new Pollution(1980, 'Asia', 40),
      new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      new Pollution(1985, 'USA', 100),
      new Pollution(1980, 'Asia', 150),
      new Pollution(1985, 'Europe', 80),
    ];
    var data3 = [
      new Pollution(1985, 'USA', 200),
      new Pollution(1980, 'Asia', 300),
      new Pollution(1985, 'Europe', 180),
    ];

    var piedata = [
      new Task('Price', price, Color(0xff3366cc)),
      new Task('Out Date', out, Color(0xff990099)),
      new Task('Quality and Quntity', qulity, Color(0xff109618)),
      new Task('Bad Service', bad, Color(0xfffdbe19)),
      new Task('Others', other, Color(0xffdc3912)),
    ];

    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 35),
      new Sales(1, 46),
      new Sales(2, 45),
      new Sales(3, 50),
      new Sales(4, 51),
      new Sales(5, 60),
    ];

    var linesalesdata2 = [
      new Sales(0, 20),
      new Sales(1, 24),
      new Sales(2, 25),
      new Sales(3, 40),
      new Sales(4, 45),
      new Sales(5, 60),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    Getstatistic();
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('Statistic'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Analysis of the percentage of complaints according to the categories  of complaints',
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Expanded(
                          child: charts.PieChart(_seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification:
                                      charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 2,
                                  cellPadding: new EdgeInsets.only(
                                      right: 4.0, bottom: 4.0),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts
                                          .MaterialPalette.purple.shadeDefault,
                                      fontFamily: 'Georgia',
                                      fontSize: 11),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition:
                                            charts.ArcLabelPosition.inside)
                                  ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Sales for the first 5 years',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.LineChart(_seriesLineData,
                              defaultRenderer: new charts.LineRendererConfig(
                                  includeArea: true, stacked: true),
                              animate: true,
                              animationDuration: Duration(seconds: 5),
                              behaviors: [
                                new charts.ChartTitle('Years',
                                    behaviorPosition:
                                        charts.BehaviorPosition.bottom,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle('Sales',
                                    behaviorPosition:
                                        charts.BehaviorPosition.start,
                                    titleOutsideJustification: charts
                                        .OutsideJustification.middleDrawArea),
                                new charts.ChartTitle(
                                  'Departments',
                                  behaviorPosition: charts.BehaviorPosition.end,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea,
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> Getstatistic() async {
    SharedPreferences sharoref = await SharedPreferences.getInstance();
    // social_num = sharoref.getInt('social_number');

    // if (social_num != null) {
    //   setState(() {
    //     social_num = sharoref.getInt('social_number');
    //     print("inside$social_num");
    //     isSignIn = true;
    //   });
    // }
    // print("the socialnum: $social_num");
    final url =
        "http://$ip:9090/api/complaintsystem/employee/getNubmerOfComplaintsByType?type=Price";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        price = json; // there we put all info from database in this list
      });
    }

    print(response.statusCode);
    print(response.body);
  }
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
