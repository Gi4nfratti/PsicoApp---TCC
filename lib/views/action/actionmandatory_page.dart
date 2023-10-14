import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:psicoapp/data/test_data.dart';
import 'package:psicoapp/models/action_history.dart';
import 'package:psicoapp/utils/app_routes.dart';
import 'package:psicoapp/utils/miscellaneous.dart';

import '../../components/alert.dart';

class ActionMandatoryPage extends StatefulWidget {
  const ActionMandatoryPage({super.key});

  @override
  State<ActionMandatoryPage> createState() => _ActionMandatoryPageState();
}

class _ActionMandatoryPageState extends State<ActionMandatoryPage> {
  double rating = 10;
  List<String> _moodFeelingSelected = [];
  String thoughts = "";
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (_moodFeelingSelected.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: "Atenção",
              desc: "Selecione um campo em \"O que você está sentindo.\""));
      return;
    } else if (!isValid) return;

    try {
      ActionHistory history = new ActionHistory(
          id: 1,
          date: DateFormat("dd/MM/yyyy").format(DateTime.now()),
          mood: rating.toString(),
          emotion: _moodFeelingSelected,
          thoughts: thoughts);
      Navigator.of(context)
          .pushNamed(AppRoutes.ACTIONS_OPTIONAL, arguments: history);
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
        title: Text('Cadastrar Humor'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(3.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Como você está se sentindo agora?',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Humor',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            SizedBox(height: 30),
                            Slider(
                              label: rating.toStringAsFixed(0),
                              thumbColor: Miscellaneous.mainColor,
                              activeColor: Miscellaneous.mainColor,
                              value: rating,
                              min: 0,
                              max: 10,
                              onChanged: (value) {
                                setState(() {
                                  rating = value;
                                });
                              },
                              divisions: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'O que você está sentindo?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: actionFeelingList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (_moodFeelingSelected.contains(
                                              actionFeelingList[index])) {
                                            _moodFeelingSelected.removeWhere(
                                                (item) =>
                                                    item ==
                                                    actionFeelingList[index]);
                                          } else {
                                            _moodFeelingSelected
                                                .add(actionFeelingList[index]);
                                          }
                                          print(_moodFeelingSelected.join("#"));
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        color: (_moodFeelingSelected).contains(
                                                actionFeelingList[index])
                                            ? Miscellaneous.mainColor
                                            : Colors.transparent,
                                        height: 35,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            actionFeelingList[index],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Quais pensamentos passaram pela sua mente?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                maxLength: 100,
                                validator: (_thoughts) {
                                  thoughts = _thoughts ?? '';
                                  if (thoughts.trim().isEmpty) {
                                    return 'Preencha o campo';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
