import 'package:flutter/material.dart';
import 'package:psicoapp/utils/app_routes.dart';

import '../../models/psychoeducation.dart';

class PsychoeducationItem extends StatelessWidget {
  final Psychoeducation psychoeducation;

  const PsychoeducationItem(this.psychoeducation);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).pushNamed(
            AppRoutes.PSYCHOEDUCATION_TEXT,
            arguments: psychoeducation,
          ),
        },
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 0,
                shadowColor: Colors.green,
                child: Image(
                  image: AssetImage(psychoeducation.images),
                  fit: BoxFit.fitWidth,
                  height: 100,
                ),
              ),
              Text(
                psychoeducation.title,
                style: const TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w200),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
