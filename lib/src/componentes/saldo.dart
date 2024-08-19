import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'infosaldos.dart';


class Saldo extends StatefulWidget {

  @override
  SaldoState createState() => SaldoState();
}

class SaldoState extends State<Saldo> {

  var carregando = false;
  var dados;

  listarDados() async{
    var url = "http://192.168.15.6/flutter/produtos/listar-categorias.php";
    var response = await http.get(url as Uri);
    var map = json.decode(response.body);
    var itens = map["result"];


    setState(() {
      carregando = true;
      this.dados = itens;

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.listarDados();
    print('teste');
  }




  @override
  Widget build(BuildContext context){
    return
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100.0,
          width: 180.0,
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
                        const Text("Saldo:"), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ),

        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 100.0,
          width: 160.0,
          child: GestureDetector(
            onTap: () {
              //Login(usuariotxt.text, senhatxt.text);
            },

            child: SizedBox.fromSize(

              size: const Size(10,10),
              child: ClipRect(
                child: Material(

                  color: Colors.red,
                  child: InkWell(
                    splashColor: Colors.indigo,
                    onTap: (){

                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.account_balance_wallet_outlined), // icon
                        const Text("Despesa:"), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ),

        ),
        /*Icon(Icons.star, color: Colors.green[500]),
        const Icon(Icons.star, color: Colors.black),
        const Icon(Icons.star, color: Colors.black),*/
      ],
    );
    /*return Container(

        height:80.0,
        margin:EdgeInsets.only(top:10.0),
        child: !carregando
            ? LinearProgressIndicator()
            : ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.dados != null ? this.dados.length : 0,
          itemBuilder: (context, i){
            final item = this.dados[i];
            print(item);
            return GestureDetector(
              onTap:(){
                /*Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => produtosPage("", item['id'])
                ));*/

              },
              child: InfoSaldos(
                nomeCat: item['nome'],
                totalProd: item['produtos'],
                imgCat: item['imagem'],
              ),
            );
          },
        )
    );
  }*/
}
}