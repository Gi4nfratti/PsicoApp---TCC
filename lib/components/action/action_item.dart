import 'package:flutter/material.dart';
import 'package:psicoapp/models/action_m.dart';

class ActionItem extends StatelessWidget {
  final ActionM action;

  const ActionItem(this.action);

  @override
  Widget build(BuildContext context) {
    String args = "";
    var pageToGoAux = action.pageToGo.split('#');
    return GestureDetector(
      onTap: () => {
        if (pageToGoAux.length > 1) args = pageToGoAux[1],
        Navigator.of(context).pushNamed(
          action.pageToGo.split('#')[0],
          arguments: args,
        ),
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(action.images),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(4, 5, 0, 5),
              width: double.infinity,
              color: Color(0xCC555555),
              child: Text(
                action.title,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
