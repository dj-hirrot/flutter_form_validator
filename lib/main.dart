import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContainerStore()),
        ChangeNotifierProvider(create: (context) => LoginStore()),
      ],
      child: App(),
    ));

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Container(),
    );
  }
}

class Container extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class ContainerStore with ChangeNotifier {}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (context, loginStore, _) {
      return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 50),
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                onChanged: (text) => loginStore.changeEmail(text),
                validator: (value) => loginStore.validate(value),
              ),
              Text('${loginStore.emailError}'), // エラーメッセージ
            ],
          ));
    });
  }
}

class LoginStore with ChangeNotifier {
  var email = "";
  var emailError = "";

  void changeEmail(String text) {
    email = text;
    notifyListeners();
  }

  String validate(String email) {
    if(EmailValidator.validate(email)){
      return '';
    } else {
      return 'メールアドレスを正しく入力してください';
    }
  }
}
