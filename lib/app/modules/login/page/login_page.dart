import 'package:app_games_rating/app/app_store.dart';
import 'package:app_games_rating/app/modules/login/page/login_store.dart';
import 'package:app_games_rating/app/modules/login/helper/usuario_helper.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  UsuarioHelper _db = UsuarioHelper();

  final appController = Modular.get<AppStore>();
  final loginController = Modular.get<LoginStore>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.05),
        elevation: 0,
        titleSpacing: 0,
        title: Image.asset(
          "assets/images/logo.png",
          width: 220,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(40),
        color: Colors.black.withOpacity(0.05),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 40),
                  Material(
                    elevation: 2,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        prefixIcon: Icon(Icons.mail_outline),
                        hintText: 'Endereço de e-mail',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o endereço de e-mail';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    child: TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        prefixIcon: Icon(Icons.lock_outline_rounded),
                        hintText: 'Senha',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe a senha de acesso';
                        } else if (value.length < 3) {
                          return 'A senha deve ter mais que 3 caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) return Colors.redAccent;
                          return null;
                        }),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) return Colors.white;
                          return null; // Defer to the widget's default.
                        }),
                      ),
                      onPressed: () => _validarLogin(),
                      child: Text('Entrar'),
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Novo por aqui?',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Criar conta',
                          style: TextStyle(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()..onTap = () => Modular.to.pushNamed('/login/register'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Esqueceu sua senha?',
                      style: TextStyle(color: Colors.blueAccent),
                      recognizer: TapGestureRecognizer()..onTap = () => Modular.to.pushNamed('/login/recoveryPassword'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(),
                      ),
                      Text("OU"),
                      Expanded(
                        child: Divider(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialButton('facebook.png', Color(0xFF485a96), () {}),
                      SizedBox(width: 20),
                      _socialButton('google.jpg', Colors.white, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String imageName, Color backgroundColor, Function onClick) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/' + imageName),
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }

  _validarLogin() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        text: "Carregando...",
        barrierDismissible: false,
      );

      await loginController.validarLogin(_emailController.text, _senhaController.text).then((value) async {
        await _db.deleteAllUsuario();
        int resultado = await _db.insertUsuario(value);

        if (resultado != null) {
          await appController.setUsuarioLogado(value);
          Modular.to.pushReplacementNamed('/feed');
        } else {
          Modular.to.pop();
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            barrierDismissible: false,
            title: "Ops!",
            text: "Ocorreu um erro inesperado ao tentar validar os seus dados de Login.",
            onConfirmBtnTap: () {
              Modular.to.pop();
            },
          );
        }
      }).onError((error, stackTrace) {
        Modular.to.pop();
        CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          barrierDismissible: false,
          title: "Ops!",
          text: error.toString(),
          onConfirmBtnTap: () {
            Modular.to.pop();
          },
        );
      });
    }
  }
}
