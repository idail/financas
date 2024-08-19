import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../menus/menus.dart';
import '../componentes/botao.dart';
import 'CadastroUsuarioPage.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _toggleVisibility = true;
  var usuariotxt = new TextEditingController();
  var senhatxt = new TextEditingController();
  var emailtxt = new TextEditingController();
  var dados;
  var seguro = true;

  Widget _usuariotxt() {
    return TextFormField(
      controller: usuariotxt,
      decoration: const InputDecoration(
        labelText: "Informe seu usuário",
        hintText: "Digite seu usuário",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _emailtxt(){
      return TextFormField(
          controller: emailtxt,
          decoration:const InputDecoration(
            labelText: "Informe seu e-mail:",
            hintText: "Digite seu e-mail",
            hintStyle: TextStyle(
              color: Color(0xFFBDC2CB),
              fontSize: 18.0,
            ),
          ),
      );
  }

  Widget _senhatxt() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        labelText: "Informe sua senha",
        hintText: "Digite Sua Senha",
        hintStyle: const TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisibility = !_toggleVisibility;
            });
          },
          icon: _toggleVisibility
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisibility,
    );
  }

@override
Widget build(BuildContext context)
{
  //MENSAGEM DADOS INCORRETOS
  String MensagemDadosIncorretos() {
    var alert = new AlertDialog(
      title: new Text("Dados Incorretos"),
      content: new Text(
          "Usuário ou Senha incorretos"),
    );
    showDialog(builder: (context) => alert, context: context);
    return "Falha";
  }


  //FUNCAO DO LOGIN
  Future<String> Login(String usuario, String senha) async {
    var response = await http.get(
        Uri.encodeFull(
            "https://idailneto.com.br/financas/login.php?usuario=${usuario}&senha=${senha}") as Uri,
        headers: {"Accept": "application/json"});

    //print(response.body);

    var obj = json.decode(response.body);
    var msg = obj;
    print(msg);
    /*if(msg == "Dados incorretos!"){
      var retorno = MensagemDadosIncorretos();
      return retorno;
    }else{
      return dados = obj['result'];
    }*/
    return "";
  }

  //VERIFICAR DADOS
  /*VerificarDados(String usuario, String senha) {
    if (dados[0]['usuario'] == usuario && dados[0]['senha'] == senha) {

      var route = new MaterialPageRoute(
        builder: (BuildContext context) =>
        new Abas(),
      );
      Navigator.of(context).push(route);
    } else {
      MensagemDadosIncorretos();
    }

  }*/

  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           const Image(
              image:AssetImage("assets/imagens/login.png"),
              height:140.0,
              width:140.0,
          ),
            const Text("Minhas finanças, caso já tenha conta, logue-se"),
            Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _usuariotxt(),
                    const SizedBox(
                      height: 7.0,
                    ),
                    _senhatxt(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Login(usuariotxt.text, senhatxt.text);
                //VerificarDados(usuariotxt.text, senhatxt.text);
              },
              child: Botao(
                btnText: "Logar",
              )
            ),
            const Divider(
              height: 35.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Não possui Cadastro?",
                  style: TextStyle(
                      color: Color(0xFFBDC2CB),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => CadastroUsuarioPage()
                    ));
                  },
                  child: const Text(
                    "Cadastre-se",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  "Recuperar Senha?",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
    ],
    )
  )
  );
}
}