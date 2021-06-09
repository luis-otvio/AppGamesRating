import 'package:app_games_rating/app/modules/login/page/login_store.dart';
import 'package:app_games_rating/app/modules/usuario/model/usuario_model.dart';
import 'package:app_games_rating/app/modules/usuario/page/usuario_store.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CriarContaPage extends StatefulWidget {
  @override
  CriarContaPageState createState() => CriarContaPageState();
}

class CriarContaPageState extends State<CriarContaPage> {
  final loginController = Modular.get<LoginStore>();
  final usuarioController = Modular.get<UsuarioStore>();

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _nomeUsuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  DateTime dataNascimentoSelecionada;

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
                    "Criar Conta",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 40),
                  Material(
                    elevation: 2,
                    child: TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'Nome Completo',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 3) {
                          return 'Informe o seu nome';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    child: DateTimeFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.event_note),
                        hintText: 'Data de Nascimento',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1 ? 'Informe uma data de nascimento válida' : null,
                      onDateSelected: (DateTime value) {
                        dataNascimentoSelecionada = value;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    child: TextFormField(
                      controller: _nomeUsuarioController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'Nome de Usuário',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Informe o nome de usuário.';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Material(
                    elevation: 2,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        hintText: 'Endereço de e-mail',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.mail_outline),
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
                        hintText: 'Senha',
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock_outline),
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
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            text: "Carregando...",
                            barrierDismissible: false,
                          );

                          Usuario usuario = new Usuario();
                          usuario.name = _nomeController.text;
                          usuario.nickName = _nomeUsuarioController.text;
                          usuario.email = _emailController.text;
                          usuario.birthDate = dataNascimentoSelecionada.toString();

                          await usuarioController.inserirUsuario(usuario, _senhaController.text).then((_) async {
                            await loginController.entrar(_emailController.text, _senhaController.text, context);
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
                      child: Text('Cadastrar'),
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
