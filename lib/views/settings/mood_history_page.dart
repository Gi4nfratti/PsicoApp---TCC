import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:psicoapp/data/test_data.dart';
import 'package:psicoapp/utils/miscellaneous.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class MoodHistoryPage extends StatefulWidget {
  const MoodHistoryPage({super.key});

  @override
  State<MoodHistoryPage> createState() => _MoodHistoryPageState();
}

class _MoodHistoryPageState extends State<MoodHistoryPage> {
  bool _showChart = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Histórico do Humor'),
          actions: [
            IconButton(
                onPressed: () => setState(() => _showChart = !_showChart),
                icon: Icon(_showChart
                    ? Icons.calendar_view_month_rounded
                    : Icons.bar_chart_rounded)),
            _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                : IconButton(
                    onPressed: () => GeneratePDF(),
                    icon: Icon(Icons.picture_as_pdf_rounded),
                  ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _showChart ? showChart() : showTable(),
                ],
              ),
            ),
          ),
        ));
  }

  showChart() {
    return Column(
      children: [
        moodChart(),
        feelingChart(),
      ],
    );
  }

  showTable() {
    return tableChart();
  }

  Widget tableChart() {
    return DataTable(
      dividerThickness: 2,
      headingRowColor: MaterialStateProperty.all(Miscellaneous.mainColor),
      headingTextStyle: TextStyle(
          fontFamily: 'Urbanist',
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w600),
      columnSpacing: 15,
      dataTextStyle: TextStyle(
          fontFamily: 'Urbanist', fontSize: 22, color: Colors.black87),
      columns: [
        DataColumn(label: Text('Data')),
        DataColumn(label: Text('Humor')),
        DataColumn(label: Text('Sentimento')),
      ],
      rows: tableChartTestList.map((item) {
        return DataRow(
          color: MaterialStateProperty.all(Colors.grey.shade200),
          cells: [
            DataCell(Text(item.split('*')[0])),
            DataCell(Center(
                child: Text(
              item.split('*')[1],
            ))),
            DataCell(Center(
              child: Text(
                  moodFeelingList[int.parse(item.split('*')[2])].split('/')[0]),
            )),
          ],
        );
      }).toList(),
    );
  }

  Widget moodChart() {
    return Column(
      children: [
        Text(
          "Humor",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins", fontSize: 26, fontWeight: FontWeight.w300),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(0, 50, 20, 100),
          child: Container(
            height: 300,
            width: 800,
            padding: EdgeInsets.all(5),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: titleWidgets,
                      reservedSize: 30,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.black),
                ),
                minX: 1,
                maxX: 31,
                minY: 0,
                maxY: 10,
                lineBarsData: [
                  LineChartBarData(
                    spots: moodHistory
                        .map((e) => FlSpot(double.parse(e.split('/')[0]),
                            double.parse(e.split('/')[1])))
                        .toList(),
                    preventCurveOverShooting: true,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: false,
                    ),
                    aboveBarData: BarAreaData(
                      show: true,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              swapAnimationDuration: Duration(milliseconds: 3150),
              swapAnimationCurve: Curves.bounceIn,
            ),
          ),
        ),
      ],
    );
  }

  Widget feelingChart() {
    return Column(
      children: [
        Text(
          "Sentimento",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Poppins", fontSize: 26, fontWeight: FontWeight.w300),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(0, 50, 50, 100),
          child: Container(
            height: 320,
            width: 500,
            padding: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey,
                      tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                      tooltipMargin: -10,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          "${moodFeelingList[groupIndex].split('/')[0]}\n",
                          const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${(rod.rodStackItems[rodIndex].toY - 1).toString()} %',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: barTitleWidgets,
                        reservedSize: 50,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: getBarChartGroupList(barChartTestList),
                  gridData: FlGridData(show: false),
                ),
                swapAnimationDuration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> getBarChartGroupList(List<String> x) {
    List<BarChartGroupData> list = [];
    for (var i = 0; i < x.length; i++) {
      list.add(
        BarChartGroupData(
          x: int.parse(x[i].split('/')[0]),
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: 100,
              rodStackItems: [
                BarChartRodStackItem(
                    0, double.parse(x[i].split('/')[1]), Colors.blue)
              ],
              width: 40,
              color: Colors.grey.shade400,
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ],
        ),
      );
    }
    return list;
  }

  Widget titleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    return SideTitleWidget(
      fitInside: SideTitleFitInsideData(
        enabled: true,
        axisPosition: 20,
        parentAxisSize: 20,
        distanceFromEdge: 0,
      ),
      axisSide: meta.axisSide,
      space: 10,
      child: Text(value.round().toString(), style: style),
    );
  }

  Widget barTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Image.asset(
          "lib/images/${moodFeelingList[value.round() - 1].split('@')[1]}"),
    );
  }

  Future<void> GeneratePDF() async {
    setState(() => _isLoading = true);
    final textStyle = pw.TextStyle(
      font: pw.Font.helvetica(),
      fontSize: 22,
    );
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.ListView.builder(
          itemCount: tableChartTestList.length,
          itemBuilder: (context, i) {
            return pw.Row(children: [
              pw.Text(tableChartTestList[i].split('*')[0], style: textStyle),
              pw.SizedBox(width: 50),
              pw.Text(
                  moodFeelingList[
                          int.parse(tableChartTestList[i].split('*')[2])]
                      .split('/')[0],
                  style: textStyle),
            ]);
          },
        ),
      ),
    ));

    await Printing.sharePdf(
            bytes: await pdf.save(), filename: 'mood-history.pdf')
        .whenComplete(() {
      setState(() => _isLoading = false);
    });
  }
}
