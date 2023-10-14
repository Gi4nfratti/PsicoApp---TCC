import 'package:flutter/material.dart';
import 'package:psicoapp/data/test_data.dart';
import 'package:psicoapp/utils/app_routes.dart';

class ActionHistoryPage extends StatefulWidget {
  const ActionHistoryPage({super.key});

  @override
  State<ActionHistoryPage> createState() => _ActionHistoryPageState();
}

class _ActionHistoryPageState extends State<ActionHistoryPage> {
  List<ExpansionPanel> expansionPanelList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Pensamentos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.ACTIONS_MANDATORY);
        },
        elevation: 10,
        child: Icon(
          Icons.add_rounded,
          size: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Histórico',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 26)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              child: ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 500),
                  expandedHeaderPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  elevation: 2.0,
                  dividerColor: Colors.grey.shade300,
                  expansionCallback: (panelIndex, isExpanded) => setState(
                      () => testData3[panelIndex].isExpanded = isExpanded),
                  children: getExpansionList()),
            ),
          ],
        ),
      ),
    );
  }

  List<ExpansionPanel> getExpansionList() {
    expansionPanelList = testData3
        .map<ExpansionPanel>((item) => ExpansionPanel(
              isExpanded: item.isExpanded,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Text("${testData3.indexOf(item) + 1} - Meu Pensamento",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 22)),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.date,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 18)),
                    if (item.situation.isNotEmpty)
                      FormatText('Situação:', item.situation),
                    FormatText('Pensamentos:', item.thoughts),
                    FormatText('Humor:', item.mood),
                    FormatText('Emoções:', item.emotion.join(", ")),
                    if (item.behaviors.isNotEmpty)
                      FormatText('Comportamentos:', item.behaviors),
                    if (item.reactions.isNotEmpty)
                      FormatText('Reações:', item.reactions),
                  ],
                ),
              ),
            ))
        .toList();
    return expansionPanelList;
  }

  FormatText(String header, String text) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: header,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                      TextSpan(text: "  "),
                      TextSpan(
                        text: text,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
