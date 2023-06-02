import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gerenciamento_de_estado/components/auth_form.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
       Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 177, 255, 0.5),
              Color.fromRGBO(255, 188, 177, 0.9),

            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        ),
       ),
       Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 70
              ),
              //cascade operator
              transform: Matrix4.rotationZ(-10 * pi/180)..translate(-10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepOrange.shade900,
                boxShadow: const [
                   BoxShadow(
                    blurRadius: 8,
                    color: Colors.black45,
                     offset: Offset(2,10),
                  )
                ]
              ),
              child:  Text(
                'Minha loja',
                style: TextStyle(
                 fontSize: 45,
                 fontFamily: 'Anton',
                 color: Theme.of(context).accentTextTheme.headline6?.color,
                ),
                ),
                ),
                AuthForm(),
          ],
        ),
       )
        ]) ,
    );
    
  }
}