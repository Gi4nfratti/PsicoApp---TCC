import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterItem extends StatefulWidget {
  final String type;
  final dynamic value;
  final String label;
  final TextInputType keyboardType;
  final Function(String?) onSaved;
  final String optValues;
  final int maxLength;

  RegisterItem(
      this.type, this.value, this.label, this.keyboardType, this.onSaved,
      {this.optValues = "", this.maxLength = 50});

  @override
  State<RegisterItem> createState() => _RegisterItemState();
}

class _RegisterItemState extends State<RegisterItem> {
  int? option = 0;

  @override
  Widget build(BuildContext context) {
    Widget w = Center(child: Text("Erro"));

    switch (widget.type) {
      case "text":
        w = TextFormField(
          initialValue: widget.value,
          obscureText: widget.label == "Senha" ? true : false,
          enableSuggestions: widget.label == "Senha" ? true : false,
          autocorrect: widget.label == "Senha" ? true : false,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          inputFormatters: inputFormat(),
          decoration: inputDecoration(),
          onSaved: (newValue) => widget.onSaved(newValue),
          validator: (_name) {
            final name = _name ?? '';

            if (name.trim().isEmpty) {
              return '${widget.label} é obrigatório';
            }
            return null;
          },
        );
        break;
      case "dropdown":
        w = Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
              DropdownButtonFormField(
                hint: Text('Selecionar'),
                value: widget.optValues,
                items: widget.value
                    .map<DropdownMenuItem<String>>(
                        (value) => new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'Poppins')),
                            ))
                    .toList(),
                onChanged: (value) => widget.onSaved(value.toString()),
                onSaved: (value) => widget.onSaved(value.toString()),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(5, 20, 10, 20),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),
            ],
          ),
        );
        break;
    }
    return w;
  }

  inputFormat() {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);

    List<TextInputFormatter> formatter = [];

    if (widget.keyboardType == TextInputType.number) {
      formatter = [FilteringTextInputFormatter.digitsOnly];
      if (widget.label == "Celular") {
        formatter = [FilteringTextInputFormatter.digitsOnly, maskFormatter];
      }
    }
    return formatter;
  }

  inputDecoration() {
    return InputDecoration(
        counterText: "",
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 32.0),
            borderRadius: BorderRadius.circular(5.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.circular(5.0)));
  }
}
