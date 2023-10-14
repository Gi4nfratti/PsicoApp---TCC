import 'package:flutter/material.dart';
import 'package:psicoapp/models/psychoeducation.dart';

class PsychoeducationTextPage extends StatelessWidget {
  const PsychoeducationTextPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Psychoeducation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Psicoeducação'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                children: [
                  Center(
                      child: Text(
                    args.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 36,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w500),
                  )),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    args.text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Karla',
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
