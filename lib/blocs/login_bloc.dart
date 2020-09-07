import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gerenciador_loja/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState =>
      _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc(){
    _streamSubscription = FirebaseAuth.instance.onAuthStateChanged.listen((user) async{
      if (user != null){
        if (await verifyPrivileges(user)){
          _stateController.add(LoginState.SUCCESS);
        }else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }
      }else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit(){
    final email = _emailController.value;
    final pass = _passwordController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).
    catchError((e){
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(FirebaseUser user) async{
    return await Firestore.instance.collection("adm").document(user.uid).get().then((value) {
      if (value.data != null){
        return true;
      }
      return false;
    }).catchError((e){
      return false;
    });
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
}
