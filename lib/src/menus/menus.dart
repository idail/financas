import 'package:financas/src/paginas/InformacoesPage.dart';
import 'package:financas/src/paginas/Inicio.dart';
import 'package:financas/src/paginas/ReceitasPage.dart';
import 'package:financas/src/paginas/CadastroUsuarioPage.dart';
import 'package:flutter/material.dart';

import '../paginas/DespesasPage.dart';
import '../paginas/LoginPage.dart';

class Menus extends StatefulWidget{
  var _cpf, _nome, _id;

  Tabs(cpf, nome, id) {
    this._cpf = cpf;
    this._nome = nome;
    this._id = id;
  }
  @override
  MenusState createState() => MenusState();

}

class MenusState extends State<Menus>{

  var cpfuser, nomeuser, iduser;

  int abaAtual = 0;
  late Inicio inicio;
  late ReceitasPage receitaspage;
  late DespesasPage despesaspage;
  late InformacoesPage informacoespage;

  late List<Widget> pages;
  late Widget pagAtual;


  @override
  void initState(){
    inicio = Inicio();
    receitaspage = ReceitasPage();
    despesaspage = DespesasPage();
    informacoespage = InformacoesPage();

    pages = [inicio,receitaspage,despesaspage,informacoespage];
    pagAtual = inicio;
    super.initState();
  }


  @override
  Widget build(BuildContext context){

    cpfuser = widget._cpf;
    nomeuser = widget._nome;
    iduser = widget._id;

    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.indigo,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.blueAccent),
            title:Text(
              abaAtual == 0
                  ? "Inicio"
                  : abaAtual == 1
                  ? "Receitas"
                  : abaAtual == 2 ? "Despesas" : "Informações",
              style:const TextStyle(
                  color:Colors.white,
                  fontSize:15.0,
                  fontWeight: FontWeight.bold
              ),

            ),
            centerTitle: true,

            actions: <Widget>[
              PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      const PopupMenuItem<int>(
                        value: 0,
                        child: Text("Minha conta"),
                      ),

                      const PopupMenuItem<int>(
                        value: 1,
                        child: Text("Sair"),
                      ),

                      /*const PopupMenuItem<int>(
                        value: 2,
                        child: Text("Logout"),
                      ),*/
                    ];
                  },
                  onSelected:(value){
                    if(value == 0){
                      print("My account menu is selected.");
                    }else if(value == 1){
                      print("Settings menu is selected.");
                    }else if(value == 2){
                      print("Logout menu is selected.");
                    }
                  }
              ),
              /*IconButton(
                  icon: const Icon(
                    Icons.add,
                    // size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                  }),*/
              IconButton(
                  icon: const Icon(
                    Icons.account_box,
                    // size: 30.0,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
                  }),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),


          //COLOCAR DRAWER
          drawer: Drawer(
            child: Column(
              children: <Widget>[
              IconButton(
                    icon: const Icon(
                      Icons.add,
                      // size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                    }),
                ListTile(

                  onTap: () {

                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CadastroUsuarioPage()
                    ));
                  },

                  leading: const Icon(Icons.people),

                  title: const Text(
                    "Editar Usuário",

                    style: TextStyle(fontSize: 16.0),

                  ),
                )
              ],
            ),
          ),

          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: abaAtual,
            onTap: (index) {
              setState(() {
                abaAtual = index;
                pagAtual = pages[index];
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Inicio",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_balance_wallet,
                ),
                label: "Receitas",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.attach_money,
                ),
                label: "Despesas",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: "Informações",
              ),
            ],
          ),


          //TRAZER O CONTEÚDO DA PÁGINA INICIAL HOME
          body:pagAtual,
        )
    );
  }
}