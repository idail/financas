import 'package:financas/src/componentes/Topo.dart';
import 'package:financas/src/componentes/rapidodespesas.dart';
import 'package:financas/src/componentes/saldo.dart';
import 'package:flutter/material.dart';

import '../componentes/rapidosaldos.dart';


class Inicio extends StatefulWidget{
  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio> {

  //AreaCategoria area = new AreaCategoria();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(
        padding:const EdgeInsets.only(left:20.0, top:30.0, right:20.0),
        children: <Widget>[
          Topo(),
          Saldo(),
          const SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Menu Rápido",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              /*GestureDetector(
                onTap: () {
                  print("Precionou' pressed");
                },
                child: const Text(
                  "Ver Todos",
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),*/
            ],
          ),
          const SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Column(
          children: <Widget>[
            RapidoSaldos(120.0, 120.0, "", ""),
            const SizedBox(
              height: 10.0,
            ),
            RapidoDespesas(120.0, 120.0, "", ""),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}