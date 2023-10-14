import 'package:flutter/material.dart';
import 'package:psicoapp/data/test_data.dart';

import '../../models/action_history.dart';

class ActionSummaryPage extends StatefulWidget {
  const ActionSummaryPage({super.key});

  @override
  State<ActionSummaryPage> createState() => _ActionSummaryPageState();
}

class _ActionSummaryPageState extends State<ActionSummaryPage> {
  late ActionHistory args;

  _saveForm() {
    testData3.add(args);
    Navigator.restorablePushNamedAndRemoveUntil(context, "/actions-history", ModalRoute.withName("/home"));
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as ActionHistory;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastrar Humor'),
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: formatText("Resumo", fontSize: 26),
              ),
              SizedBox(height: 50),
              formatText(title: "Data:", args.date.toString()),
              formatText(title: "Humor:", args.mood.toString()),
              formatText(title: "Sentimentos:", ""),
              for (int i = 0; i < args.emotion.length; i++)
                formatText(" - " + args.emotion[i].toString()),
              formatText(title: "Pensamentos:", args.thoughts),
              if (args.situation.isNotEmpty)
                formatText(title: "Situação:", args.situation),
              if (args.behaviors.isNotEmpty)
                formatText(title: "Comportamentos:", args.behaviors),
              if (args.reactions.isNotEmpty)
                formatText(title: "Reações físicas:", args.reactions),
            ],
          ),
        ),
      ),
    );
  }

  Padding formatText(String text, {String title = "", double fontSize = 20}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize + 2),
            ),
            TextSpan(text: "  "),
            TextSpan(
              text: text,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: fontSize),
            )
          ],
        ),
      ),
    );
  }
}
