import 'package:flutter/material.dart';

class Topo extends StatelessWidget{
  final textoTitulo = const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400,height: 2);
  final textoSubtitulo = const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(children: <Widget>
        [
          Text("Suas informações", style: textoTitulo),
          //Text("Temos diversas opções", style: textoSubtitulo),
        ],
        ),
//        const Icon(Icons.notifications),
    ],
    );
  }
}