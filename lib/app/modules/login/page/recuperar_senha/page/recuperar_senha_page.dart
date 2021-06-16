import 'package:app_games_rating/app/modules/login/page/login_store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecuperarSenhaPage extends StatefulWidget {
  @override
  RecuperarSenhaPageState createState() => RecuperarSenhaPageState();
}

class RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final loginController = Modular.get<LoginStore>();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
                    "Recuperar Senha",
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            text: "Carregando...",
                            barrierDismissible: false,
                          );

                          await loginController.forgotPassword(_emailController.text).then((value) {
                            Modular.to.pop();
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              barrierDismissible: false,
                              title: "Sucesso",
                              text: "Enviamos uma recuperação de senha para seu e-mail.",
                              onConfirmBtnTap: () {
                                Modular.to.pop();
                                Modular.to.pop();
                              },
                            );
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
                      },
                      child: Text('Recuperar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
