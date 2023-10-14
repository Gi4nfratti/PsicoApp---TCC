import 'package:flutter/material.dart';
import 'package:psicoapp/models/action_history.dart';

import '../../components/alert.dart';
import '../../utils/app_routes.dart';

class ActionOptionalPage extends StatefulWidget {
  const ActionOptionalPage({super.key});

  @override
  State<ActionOptionalPage> createState() => _ActionOptionalPageState();
}

class _ActionOptionalPageState extends State<ActionOptionalPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  late ActionHistory args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as ActionHistory;
  }

  void _submitForm() {
    try {
      _formKey.currentState?.save();
      Navigator.of(context).pushNamed(AppRoutes.ACTIONS_SUMMARY,
          arguments: new ActionHistory(
            id: args.id,
            date: args.date,
            emotion: args.emotion,
            mood: args.mood,
            thoughts: args.thoughts,
            situation: _formData["happened"].toString(),
            behaviors: _formData["did"].toString(),
            reactions: _formData["bodyReact"].toString(),
          ));
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: "Ocorreu um erro!", desc: "Ocorreu um erro ao salvar."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Humor (opcional)'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InflateField("O que aconteceu?", "happened"),
                              InflateField("O que você fez?", "did"),
                              InflateField(
                                  "Como seu corpo reagiu?", "bodyReact"),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InflateField(String title, String field) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
        ),
        TextFormField(
          maxLength: 100,
          onSaved: (newValue) {
            _formData[field] = newValue ?? '';
          },
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
