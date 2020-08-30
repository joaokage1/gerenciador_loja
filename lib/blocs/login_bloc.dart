import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerenciador_loja/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class loginBloc extends BlocBase with LoginValidator{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }

}