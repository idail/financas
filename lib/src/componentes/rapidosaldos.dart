import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class RapidoSaldos extends StatefulWidget {
  var _altura, _largura, _nomebusca, _idcat;

  RapidoSaldos(altura, largura, nomebusca, idcat) {
    _altura = altura;
    _largura = largura;
    _nomebusca = nomebusca;
    _idcat = idcat;
  }
  @override
  RapidoSaldosState createState() => RapidoSaldosState();

}

class RapidoSaldosState extends State<RapidoSaldos> {
  var cardText = const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  late final String texto_botao;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /*_listarDados() async{
    buscar = widget._nomebusca;

    var response = await http.get(
        Uri.encodeFull(
            "http://192.168.15.6/flutter/produtos/listar.php?nome=${buscar}&idcat=${widget._idcat}"),
        headers: {"Accept": "application/json"});
    final map = json.decode(response.body);
    final itens = map["result"];
    if(map["result"] == 'Dados não encontrados!'){
      mensagem();
    }else{
      setState(() {
        carregando = true;
        this.dados = itens;

      });

    }

  }*/

  Widget botao() {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
      child: const Center(
        child: Text(
          "Cadastrar Receitas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(40.0),
      ),
      child: Stack(
        children: <Widget>[

          Container(
            height: widget._altura,
            width: widget._largura,
            child: GestureDetector(
              onTap: () {
                //Login(usuariotxt.text, senhatxt.text);
              },

             child: SizedBox.fromSize(

               size: const Size(10,10),
               child: ClipRect(
                 child: Material(

                   color: Colors.green,
                   child: InkWell(
                     splashColor: Colors.indigo,
                     onTap: (){

                     },
                     child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                         const Icon(Icons.account_balance_wallet_outlined), // icon
                         const Text("Cadastrar Receitas"), // text
                      ],
                     ),
                   ),
                 ),
               ),
             ),

            ),

          ),
        ],
      ),
    );
  }
}