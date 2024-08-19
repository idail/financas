import 'package:financas/src/paginas/Inicio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../menus/menus.dart';
import '../componentes/botao.dart';
import 'LoginPage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroUsuarioPage extends StatefulWidget {
  //var _id;

  cadastroPage() {
  }
  @override
  CadastroUsuarioPageState createState() => CadastroUsuarioPageState();
}

class CadastroUsuarioPageState extends State<CadastroUsuarioPage> {
  bool _toggleVisibility = true;
  late File? _imagem = File("");
  late String? nome_imagem;
  late String? arquivo;
  late String _email;
  late String _nome;
  late String _usuario;
  late String _senha;
  late String base64image = "";
  late String? mensagem_usuario;
  var nome,  usuario, senha, email;
  var nometxt, emailtxt, senhatxt, usuariotxt, imagem;
  var dados;
  var caminhoImg = "assets/imagens/cadastro.png";
  var nomebtn = "Cadastrar Usuário";

  ImagePicker imagePicker = ImagePicker();

  GlobalKey<FormState> _formKey = GlobalKey();

  Widget _emailtxt() {
    return TextFormField(
      controller: emailtxt,
      decoration: const InputDecoration(
        labelText: "Informe seu e-mail:",
        hintText: "Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
      ),
      onSaved: (String? email) {
        _email = email!;
      },
      validator: (String? email) {
        String errorMessage = "";
        if (!email!.contains("@")) {
          errorMessage = "Seu email está incorreto";
        }
        if (email.isEmpty) {
          errorMessage = "O campo email é requerido";
        }

        return errorMessage;
      },
    );
  }

  Widget _nometxt() {
    return TextFormField(
      controller: nometxt,
      decoration: const InputDecoration(
        labelText: "Informe seu nome:",
        hintText: "Digite seu nome",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        ),
      ),
      onSaved: (String? username) {
        _nome = username!.trim();
      },
      validator: (String? username) {
        String errorMessage = "";
        if (username!.isEmpty) {
          errorMessage = "O nome é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }


  Widget _usuariotxt() {
    return TextFormField(
      controller: usuariotxt,
      decoration: const InputDecoration(
        labelText: "Informe seu usuário:",
        hintText: "Digite seu usuário",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        ),
      ),
      onSaved: (String? username) {
        _usuario = username!.trim();
      },
      validator: (String? username) {
        String errorMessage = "";
        if (username!.isEmpty) {
          errorMessage = "O usuário é requerido";
        }
        // if(username.length > 8 ){
        //   errorMessage = "Your username is too short";
        // }
        return errorMessage;
      },
    );
  }

  Widget _senhatxt() {
    return TextFormField(
      controller: senhatxt,
      decoration: InputDecoration(
        labelText: "Informe sua senha:",
        hintText: "Digite sua senha",
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
      onSaved: (String? password) {
        _senha = password!;
      },
      validator: (String? password) {
        String errorMessage = "";

        if (password!.isEmpty) {
          errorMessage = "O campo senha é requerido";
        }
        return errorMessage;
      },
    );
  }

  // Future<void> selecionaImagem() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _imagem = File(image!.path);
  //     nome_imagem = image.path.split("/").last;
  //     arquivo = base64Encode(image!.readAsBytesSync());
  //     print(_imagem);
  //     print(nome_imagem);
  //     print(arquivo);
  //   });
  // }
  
  // Widget _botaoSelecionaImagem() {
  //   return ElevatedButton(statesController: imagem,onPressed: selecionaImagem, child: Text("Selecione a foto de perfil"));
  // }


  mensagem(res){
    var alert = AlertDialog(
      title: Text('Informação'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(res),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Tudo bem'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Menus()));
          },
        ),
      ],
    );
    showDialog(builder: (context) => alert, context: context);

    if(res == 'Inserido com Sucesso'){
      nometxt.text = "";
      emailtxt.text = "";
      senhatxt.text = "";
    }

  }

  mensagem_valida_campos(mensagem)
  {
    var alert = AlertDialog(
      title: Text("Informação"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(mensagem),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ok'),
          onPressed: () {
            /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()));*/
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alert, context: context);
  }


  //VERIFICAR SE O USUÁRIO ESTÁ LOGADO, SE TIVER RECUPERAR SEUS DADOS PARA EDITAR
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*if(widget._id != ""){
      caminhoImg = "assets/imagens/excluir.png";
      nomebtn = "Editar";
      recuperarDados();
    }*/
    nometxt = TextEditingController();
    usuariotxt = TextEditingController();
    emailtxt = TextEditingController();
    senhatxt = TextEditingController();
  }

  //método para recuperar os dados do usuário logado
  recuperarDados() async{

    /*var response = await http.get(
        Uri.encodeFull(
            "http://192.168.15.6/flutter/usuarios/recuperarDados.php?id=${widget._id}"),
        headers: {"Accept": "application/json"});
    final map = json.decode(response.body);
    final itens = map["result"];*/

    setState(() {

      /*this.dados = itens;

      nome = dados[0]["nome"];
      cpf = dados[0]["cpf"];
      telefone = dados[0]["telefone"];
      usuario = dados[0]["usuario"];
      senha = dados[0]["senha"];


      nometxt = TextEditingController(text: nome);
      emailtxt = TextEditingController(text: usuario);
      senhatxt = TextEditingController(text: senha);
      cpftxt = TextEditingController(text: cpf);
      telefonetxt = TextEditingController(text: telefone);*/
    });



  }

  //método para inserir na api
  void _inserir() async{
    var resultado_inserir_usuario;

    if(nometxt.text == ""){
       mensagem_valida_campos("Por favor, preencha o campo nome");
    }else if(usuariotxt.text == ""){
      mensagem_valida_campos("Por favor, preencha o campo usuário");
    }else if(senhatxt.text == ""){
      mensagem_valida_campos("Por favor, preencha o campo senha");
    }else if(emailtxt.text == ""){
      mensagem_valida_campos("Por favor, preencha o campo e-mail");
    }else {
      if(_imagem!.path == "") {
        nome_imagem = "usuario_sem_foto.jpeg";
        arquivo = "";
      }

      var url = "https://idailneto.com.br/financas/api/UsuarioAPI.php";
      resultado_inserir_usuario = await http.post(url as Uri, body:{
        "processo_usuario":"inserir_usuario",
        "nome" : nometxt.text,
        "usuario" : usuariotxt.text,
        "email" : emailtxt.text,
        "senha" : senhatxt.text,
        "imagem_selecionada": arquivo,
        "nome_imagem_selecionada":nome_imagem,
        //"id" : widget._id,
      });

      final retorno = await json.decode(json.encode(resultado_inserir_usuario.body));
      //final res = map["message"];
      print(retorno);
      if(retorno != ""){
        mensagem_usuario = "Usuário cadastrado com sucesso";
      }else{
        mensagem_usuario = "Usuário não foi cadastrado com sucesso";
      }
      //}

      mensagem(mensagem_usuario);
    }
  }

  /*mensagemExcluir(){
    var alert = AlertDialog(
      title: Text('Excluir Usuário'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text("Deseja Realmente Excluir o Usuário"),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Sim'),
          onPressed: () {
            excluirUsuario(widget._id);
          },
        ),
        TextButton(
          child: Text('Não'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(builder: (context) => alert, context: context);
  }*/

  /*excluirUsuario(id){
    http.get(
        Uri.encodeFull(
            "http://192.168.15.6/flutter/usuarios/excluir.php?id=${id}"),
        headers: {"Accept": "application/json"});
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Abas()
    ));
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*GestureDetector(
                  onTap:(){
                    mensagemExcluir();
                  },
                  child:Image(
                    image:AssetImage(caminhoImg),
                    height:120.0,
                    width:120.0,
                  ),
                ),*/
                Image(
                  image:AssetImage(caminhoImg),
                  height:120.0,
                  width:120.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _nometxt(),
                        const SizedBox(
                          height: 12.0,
                        ),
                        _usuariotxt(),
                        const SizedBox(
                          height: 12.0,
                        ),
                        _emailtxt(),
                        const SizedBox(
                          height: 12.0,
                        ),
                        _senhatxt(),
                        const SizedBox(
                          height: 12.0,
                        ),
                        _imagem!.path != "" ? Image.file(_imagem!,height: 60, width: 60,) : Text("Nenhuma imagem selecionada"),
                        //_botaoSelecionaImagem(),
                        //_imagem.path == "" ? Text("Nenhuma imagem selecionada") : Image.file(_imagem,height: 60),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),


                GestureDetector(
                  onTap: () {
                    _inserir();

                  },
                  child: Botao(
                    btnText: nomebtn,
                  ),
                ),

                const Divider(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Já possui Cadastro?",
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                      },
                      child: const Text(
                        "Logar",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }



  void onSubmit(Function authenticate) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Seu Email: $_email, sua senha: $_senha");
      authenticate(_email, _senha);
    }
  }
}