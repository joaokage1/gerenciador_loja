import 'package:flutter/material.dart';
import 'package:gerenciador_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.store_mall_directory,
                    color: Theme.of(context).primaryColor,
                    size: 160,
                  ),
                  InputField(
                    icon: Icons.person,
                    hint: "Usuário",
                    obscure: false,
                  ),
                  InputField(
                    icon: Icons.lock,
                    hint: "Senha",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Entrar"),
                      onPressed: () {},
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
