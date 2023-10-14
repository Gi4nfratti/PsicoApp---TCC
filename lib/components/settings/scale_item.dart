import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ScaleItem extends StatefulWidget {
  final String title;
  final Function(String?) onSaved;
  final String title2;
  final Function(String?)? onSaved2;

  ScaleItem(
      {required this.onSaved,
      required this.title,
      this.title2 = "",
      this.onSaved2});

  @override
  State<ScaleItem> createState() => _ScaleItemState();
}

class _ScaleItemState extends State<ScaleItem> {
  final value = [
    "Não",
    "Leve",
    "Moderado",
    "Grave",
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.loose,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(child: ScaleSubItem(1)),
          SizedBox(width: 10),
          if (widget.title2.isNotEmpty) Flexible(child: ScaleSubItem(2)),
        ],
      ),
    );
  }

  ScaleSubItem(int column) {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            column == 1 ? widget.title : widget.title2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            maxLines: 3,
            minFontSize: 16,
            group: AutoSizeGroup(),
          ),
          DropdownButtonFormField(
            hint: Text('Selecionar'),
            items: value
                .map<DropdownMenuItem<String>>((value) =>
                    new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value,
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: true),
                          style:
                              TextStyle(fontSize: 16, fontFamily: 'Poppins')),
                    ))
                .toList(),
            onChanged: column == 1
                ? (value) => widget.onSaved(value.toString())
                : (value) => widget.onSaved2!(value.toString()),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(5, 20, 10, 20),
              filled: true,
              fillColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
