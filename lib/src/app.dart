import 'package:financas/src/paginas/LoginPage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  Widget build(BuildContext context)
  {
      return MaterialApp(
          title: "Minhas Finanças",
          theme: ThemeData(primarySwatch: Colors.blue),
          home: LoginPage(),
      );
  }
}