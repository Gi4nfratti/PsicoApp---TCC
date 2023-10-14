import 'package:flutter/material.dart';
import 'package:psicoapp/components/alert.dart';
import 'package:psicoapp/data/test_data.dart';
import 'package:psicoapp/models/mood.dart';

class ActionMoodPage extends StatefulWidget {
  const ActionMoodPage({super.key});

  @override
  State<ActionMoodPage> createState() => _ActionMoodPageState();
}

class _ActionMoodPageState extends State<ActionMoodPage> {
  List<String> _moodFeelingSelectedList = [];
  double rating = 10;
  bool otherEnable = false;
  bool moreAddEnable = false;
  String moreValue = moodMoreList.first;
  String addMoreValue = "";

  _submitMood() {
    if (moreValue == moodMoreList.last && addMoreValue.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => Alert(
                title: "Atenção",
                desc: "Preencha o campo em branco.",
              ));
      return;
    } else if (addMoreValue.isNotEmpty) {
      moreValue = addMoreValue;
    }

    if (_moodFeelingSelectedList.any((element) => element.contains("outros")) &&
        moreValue.isNotEmpty) {
      _moodFeelingSelectedList
          .removeWhere((element) => element.contains("outros"));

      _moodFeelingSelectedList.add(moreValue);
    }

    print(_moodFeelingSelectedList);

    if (_moodFeelingSelectedList.isEmpty) {
      showDialog(
          context: context,
          builder: (context) =>
              Alert(title: "Atenção", desc: "Selecione um dos pensamentos."));
      return;
    } else {
      try {
        Mood(
          id: 1,
          moodValue: rating.round(),
          feelings: _moodFeelingSelectedList.join("#"),
        );
        Navigator.of(context).pop();
      } catch (onError) {
        showDialog(
            context: context,
            builder: (context) => Alert(
                title: "Erro",
                desc: "Erro ao salvar, tente novamente em alguns minutos."));
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Humor'),
        actions: [
          IconButton(
            onPressed: _submitMood,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Card(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Text(
                            'Como você está se sentindo agora?',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
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
                          Slider(
                            label: rating.toStringAsFixed(0),
                            thumbColor: Colors.green.shade300,
                            activeColor: Colors.green.shade300,
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
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 10,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Qual sentimento predominou hoje?',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    itemCount: moodFeelingList.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Card(
                        color: _moodFeelingSelectedList
                                .contains(moodFeelingList[index])
                            ? Colors.green.shade300
                            : Colors.white,
                        elevation: 5,
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (_moodFeelingSelectedList
                                    .contains(moodFeelingList[index])) {
                                  _moodFeelingSelectedList.removeWhere(
                                      (item) => item == moodFeelingList[index]);
                                  print(_moodFeelingSelectedList);
                                } else
                                  _moodFeelingSelectedList
                                      .add(moodFeelingList[index]);
                                print(_moodFeelingSelectedList);
                                if (_moodFeelingSelectedList
                                    .contains(moodFeelingList.last))
                                  otherEnable = true;
                                else {
                                  moreAddEnable = otherEnable = false;
                                }
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: Image.asset(
                                    "lib/images/${moodFeelingList[index].split('@')[1]}",
                                    height: 40,
                                  ),
                                ),
                                Text(moodFeelingList[index].split('/')[0],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                    )),
                                Text(
                                    moodFeelingList[index]
                                        .split('/')[1]
                                        .split('@')[0],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        focusColor: Colors.white,
                        value: moreValue,
                        items: moodMoreList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          moreAddEnable =
                              value == moodMoreList.last ? true : false;
                          setState(() {
                            moreValue = value.toString();
                            print(moreValue);
                            (value) => value.toString();
                          });
                        },
                      ),
                    ),
                    visible: otherEnable,
                  ),
                  Visibility(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (value) {
                          addMoreValue = value;
                          print(addMoreValue);
                          print(_moodFeelingSelectedList);
                        },
                        maxLength: 50,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                          hintText: 'Digite o sentimento',
                        ),
                      ),
                    ),
                    visible: moreAddEnable,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
