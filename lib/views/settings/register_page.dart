import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:psicoapp/auth/keysSecret.dart';
import 'package:psicoapp/dao/db_util.dart';
import 'package:psicoapp/utils/miscellaneous.dart';
import '../../components/alert.dart';
import '../../components/settings/register_item.dart';
import '../../data/test_data.dart';
import '../../models/register.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  List<String> _buscaNoAppSelected = [];
  bool _endedDBSearch = false;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  List<Map<String, dynamic>> registerList = [];
  var result;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    try {
      registerList = await DbUtil.read('register');
      if (registerList.isNotEmpty) {
        result = registerList
            .map((item) => Register(
                genero: item['genero'],
                estCivil: item['estCivil'],
                idade: item['idade'],
                celular: item['celular'],
                email: item['email'],
                senha: item['senha'],
                tratPsico: item['tratPsico'],
                tratPsiq: item['tratPsiq'],
                buscaNoApp: item['buscaNoApp'],
                id: 1,
                nome: item['nome']))
            .first;
        setState(() {
          _formData['id'] = result.id;
          _formData['nome'] = result.nome;
          _formData['idade'] = result.idade;
          _formData['genero'] = result.genero;
          _formData['estCivil'] = result.estCivil;
          _formData['celular'] = result.celular;
          _formData['email'] = result.email;
          _formData['senha'] = result.senha;
          _formData['tratPsico'] = result.tratPsico;
          _formData['tratPsiq'] = result.tratPsiq;
          _formData['buscaNoApp'] = result.buscaNoApp;
        });

        if (_formData['buscaNoApp'].toString().contains("#")) {
          _buscaNoAppSelected = _formData['buscaNoApp'].toString().split("#");
        } else if (_formData['buscaNoApp'].toString().isNotEmpty) {
          _buscaNoAppSelected.add(_formData['buscaNoApp'].toString());
        }
      }
    } finally {
      setState(() {
        _endedDBSearch = true;
      });
    }
  }

  void _submitForm() async {
    try {
      final isValid = _formKey.currentState?.validate() ?? false;

      if (_buscaNoAppSelected.isEmpty) {
        showDialog(
            context: context,
            builder: (context) => Alert(
                title: "Atenção",
                desc: "Selecione um campo em \"O que você busca no app.\""));
        return;
      } else
        _formData['buscaNoApp'] = _buscaNoAppSelected;
      if (!isValid) {
        return;
      }
      _formKey.currentState?.save();

      Map<String, Object> data = {
        'id': "1",
        'nome': _formData['nome']!,
        'genero': _formData['genero']!,
        'estCivil': _formData['estCivil']!,
        'idade': _formData['idade']!,
        'celular': _formData['celular']!,
        'email': _formData['email']!,
        'senha': _formData['senha']!,
        'tratPsico': _formData['tratPsico']!,
        'tratPsiq': _formData['tratPsiq']!,
        'buscaNoApp': (_formData['buscaNoApp'] as List<String>).join("#"),
      };

      if (await DbUtil.read('register').then((value) => value.isEmpty))
        await DbUtil.insert('register', data);
      else
        await DbUtil.update('register', data);

      await _saveToCloud(data);

      Navigator.of(context).pop();
    } catch (error) {
      print(error);
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
            '${USER_REGISTER_URL}/$userId.json?auth=$auth',
          ),
          body: jsonEncode({
            'id': "1",
            'nome': data['nome']!,
            'genero': data['genero']!,
            'estCivil': data['estCivil']!,
            'idade': data['idade']!,
            'celular': data['celular']!,
            'email': data['email']!,
            'senha': data['senha']!,
            'tratPsico': data['tratPsico']!,
            'tratPsiq': data['tratPsiq']!,
            'buscaNoApp': data['buscaNoApp']!,
          }));

      if (response.statusCode >= 400) {
        throw HttpException('Erro na conexão ao salvar no banco de dados.');
      }
    } catch (error) {
      print(error);
      throw new Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: !_endedDBSearch
          ? Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()))
          : Card(
              color: Colors.white,
              shadowColor: Colors.grey,
              elevation: 20,
              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(children: [
                        RegisterItem(
                          "text",
                          (_formData['nome'] ?? '').toString(),
                          "Nome",
                          TextInputType.text,
                          ((name) => _formData['nome'] = name ?? ''),
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "dropdown",
                          Register.GeneroList,
                          "Gênero",
                          TextInputType.text,
                          ((genero) =>
                              _formData['genero'] = genero ?? 'Masculino'),
                          optValues:
                              (_formData['genero'] ?? 'Masculino').toString(),
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "dropdown",
                          Register.EstCivilList,
                          "Estado Civil",
                          TextInputType.text,
                          ((estCivil) => _formData['estCivil'] =
                              estCivil ?? 'Solteiro(a)'),
                          optValues: (_formData['estCivil'] ?? 'Solteiro(a)')
                              .toString(),
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "text",
                          (_formData['idade'] ?? '').toString(),
                          "Idade",
                          TextInputType.number,
                          ((idade) => _formData['idade'] = idade ?? ''),
                          maxLength: 3,
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "text",
                          (_formData['celular'] ?? '').toString(),
                          "Celular",
                          TextInputType.number,
                          ((celular) => _formData['celular'] = celular ?? ''),
                          maxLength: 15,
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "text",
                          (_formData['email'] ?? '').toString(),
                          "E-mail",
                          TextInputType.emailAddress,
                          ((email) => _formData['email'] = email ?? ''),
                        ),
                        SizedBox(height: 20.0),
                        RegisterItem(
                          "text",
                          (_formData['senha'] ?? '').toString(),
                          "Senha",
                          TextInputType.visiblePassword,
                          ((senha) => _formData['senha'] = senha ?? ''),
                        ),
                        RegisterItem(
                          "dropdown",
                          Register.Tratamento,
                          "Já fez tratamento com psicólogo?",
                          TextInputType.text,
                          ((psico) => _formData['tratPsico'] = psico ?? 'Não'),
                          optValues:
                              (_formData['tratPsico'] ?? 'Não').toString(),
                        ),
                        RegisterItem(
                          "dropdown",
                          Register.Tratamento,
                          "Já fez tratamento com psiquiatra?",
                          TextInputType.text,
                          ((psiq) => _formData['tratPsiq'] = psiq ?? 'Não'),
                          optValues:
                              (_formData['tratPsiq'] ?? 'Não').toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'O que você busca no app?',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: buscaNoAppList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (_buscaNoAppSelected.contains(
                                              buscaNoAppList[index])) {
                                            _buscaNoAppSelected.removeWhere(
                                                (item) =>
                                                    item ==
                                                    buscaNoAppList[index]);
                                          } else {
                                            _buscaNoAppSelected
                                                .add(buscaNoAppList[index]);
                                          }
                                          _formData['buscaNoApp'] =
                                              _buscaNoAppSelected.join("#");
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        color: (_formData['buscaNoApp'])
                                                .toString()
                                                .split('#')
                                                .contains(buscaNoAppList[index])
                                            ? Miscellaneous.mainColor
                                            : Colors.transparent,
                                        height: 35,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            buscaNoAppList[index],
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
                      ]),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
