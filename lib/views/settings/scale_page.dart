import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:psicoapp/auth/keysSecret.dart';
import 'package:psicoapp/dao/db_util.dart';
import '../../components/alert.dart';
import '../../components/settings/scale_item.dart';
import '../../data/test_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

class ScalePage extends StatefulWidget {
  const ScalePage({super.key});

  @override
  State<ScalePage> createState() => _ScalePageState();
}

class _ScalePageState extends State<ScalePage> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    try {
      Map<String, Object> data = {
        'id': "1",
        'field1': _formData['field1']!,
        'field2': _formData['field2']!,
        'field3': _formData['field3']!,
        'field4': _formData['field4']!,
        'field5': _formData['field5']!,
        'field6': _formData['field6']!,
        'field7': _formData['field7']!,
        'field8': _formData['field8']!,
        'field9': _formData['field9']!,
        'field10': _formData['field10']!,
        'field11': _formData['field11']!,
        'field12': _formData['field12']!,
        'field13': _formData['field13']!,
        'field14': _formData['field14']!,
        'field15': _formData['field15']!,
      };

      if (await DbUtil.read('scale').then((value) => value.isEmpty))
        await DbUtil.insert('scale', data);
      else
        await DbUtil.update('scale', data);

      await _saveToCloud(data);

      showDialog(
          context: context,
          builder: (context) => Alert(
                title: "Sucesso",
                desc: "Escala salva com sucesso.",
                icon: Icons.check,
              ));
    } catch (error) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: "Ocorreu um erro!", desc: "Ocorreu um erro ao salvar."));
    }
  }

  Future<void> _saveToCloud(Map<String, Object> data) async {
    try {
      final userId = data['id'];
      final response = await http.put(
          Uri.parse(
            '${USER_SCALE_URL}/$userId.json?auth=$auth',
          ),
          body: jsonEncode({
            'id': "1",
            'campo_1': data['field1']!,
            'campo_2': data['field2']!,
            'campo_3': data['field3']!,
            'campo_4': data['field4']!,
            'campo_5': data['field5']!,
            'campo_6': data['field6']!,
            'campo_7': data['field7']!,
            'campo_8': data['field8']!,
            'campo_9': data['field9']!,
            'campo_10': data['field10']!,
            'campo_11': data['field11']!,
            'campo_12': data['field12']!,
            'campo_13': data['field13']!,
            'campo_14': data['field14']!,
            'campo_15': data['field15']!,
          }));

      if (response.statusCode >= 400) {
        throw HttpException('Erro na conexão ao salvar no banco de dados.');
      }
    } catch (_) {
      throw new Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escala'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
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
        child: Card(
          color: Colors.white,
          shadowColor: Colors.grey,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  color: Colors.white,
                  shadowColor: Colors.grey,
                  elevation: 10,
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('DICA',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Colors.grey.shade600)),
                                Text(
                                    'As escalas a seguir avaliam sintomas de ansiedade, depressão e estresse, além de outras perturbações emocionais que você possa estar passando. É muito importante que você preencha elas, pois de acordo com suas respostas o PsicoApp irá gerar um plano de conteúdos personalizados para a sua necessidade.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14, fontFamily: 'Poppins')),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('ANSIEDADE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        color: Colors.grey.shade700)),
                                SizedBox(height: 20),
                                ScaleItem(
                                  title: scale[0],
                                  onSaved: (field1) =>
                                      _formData['field1'] = field1!,
                                  title2: scale[1],
                                  onSaved2: (field2) =>
                                      _formData['field2'] = field2!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[2],
                                  onSaved: (field3) =>
                                      _formData['field3'] = field3!,
                                  title2: scale[3],
                                  onSaved2: (field4) =>
                                      _formData['field4'] = field4!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[4],
                                  onSaved: (field5) =>
                                      _formData['field5'] = field5!,
                                  title2: scale[5],
                                  onSaved2: (field6) =>
                                      _formData['field6'] = field6!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[6],
                                  onSaved: (field7) =>
                                      _formData['field7'] = field7!,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Card(
                          color: Colors.white,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          margin: EdgeInsets.all(1),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('DEPRESSÃO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        color: Colors.grey.shade700)),
                                SizedBox(
                                  height: 20,
                                ),
                                ScaleItem(
                                  title: scale[7],
                                  onSaved: (field8) =>
                                      _formData['field8'] = field8!,
                                  title2: scale[8],
                                  onSaved2: (field9) =>
                                      _formData['field9'] = field9!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[9],
                                  onSaved: (field10) =>
                                      _formData['field10'] = field10!,
                                  title2: scale[10],
                                  onSaved2: (field11) =>
                                      _formData['field11'] = field11!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[11],
                                  onSaved: (field12) =>
                                      _formData['field12'] = field12!,
                                  title2: scale[12],
                                  onSaved2: (field13) =>
                                      _formData['field13'] = field13!,
                                ),
                                SizedBox(height: 30),
                                ScaleItem(
                                  title: scale[13],
                                  onSaved: (field14) =>
                                      _formData['field14'] = field14!,
                                  title2: scale[14],
                                  onSaved2: (field15) =>
                                      _formData['field15'] = field15!,
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> GeneratePDF() async {
    setState(() => _isLoading = true);
    final textStyle = pw.TextStyle(
      font: pw.Font.helvetica(),
      fontSize: 22,
    );
    final textStyleBold = pw.TextStyle(
      font: pw.Font.helvetica(),
      fontWeight: pw.FontWeight.bold,
      fontSize: 22,
    );
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) => pw.Column(children: [
        pw.Padding(
            padding: pw.EdgeInsets.only(bottom: 30),
            child: pw.Text("ESCALAS", style: textStyleBold)),
        pw.ListView.builder(
          itemCount: 15,
          itemBuilder: (context, i) {
            return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text("${scale[i].substring(0, 20)}...",
                      maxLines: 5, style: textStyle),
                  pw.SizedBox(width: 30),
                  pw.Text(
                      _formData['field${i + 1}'] == null
                          ? "Não informado"
                          : (_formData['field${i + 1}'] as String),
                      style: textStyleBold),
                ]);
          },
        ),
      ]),
    ));

    await Printing.sharePdf(
            bytes: await pdf.save(), filename: 'mood-history.pdf')
        .whenComplete(() {
      setState(() => _isLoading = false);
    });
  }
}
