import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class CriarContaPage extends StatefulWidget {
  @override
  CriarContaPageState createState() => CriarContaPageState();
}

class CriarContaPageState extends State<CriarContaPage> {
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
                      onPressed: null,
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
