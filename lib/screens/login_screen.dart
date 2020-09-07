import 'package:flutter/material.dart';
import 'package:gerenciador_loja/blocs/login_bloc.dart';
import 'package:gerenciador_loja/screens/home_screen.dart';
import 'package:gerenciador_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((event) {
      switch (event) {
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text("Error"),
            content: Text("Você não possui os privilégios necessários"),
          ));
          break;
        case LoginState.IDLE:
        case LoginState.LOADING:

      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          initialData: LoginState.LOADING,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                );
              case LoginState.FAIL:
              case LoginState.SUCCESS:
              case LoginState.IDLE:
                return Stack(
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
                              stream: _loginBloc.outEmail,
                              onChanged: _loginBloc.changeEmail,
                            ),
                            InputField(
                              icon: Icons.lock,
                              hint: "Senha",
                              obscure: true,
                              stream: _loginBloc.outPassword,
                              onChanged: _loginBloc.changePassword,
                            ),
                            SizedBox(
                              height: 32.0,
                            ),
                            StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50.0,
                                    child: RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text("Entrar"),
                                      onPressed: snapshot.hasData
                                          ? _loginBloc.submit
                                          : null,
                                      textColor: Colors.white,
                                      disabledColor: Theme.of(context)
                                          .primaryColor
                                          .withAlpha(140),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              default:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                );
            }
          }),
    );
  }
}
