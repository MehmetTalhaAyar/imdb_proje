import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';

import '../Classes/userClass.dart';

class RegisterPage extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _username;
  late String _password;
  late String _e_mail;
  late User suankiUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Register Page"),
      ),
      body: Center(
          child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: widget._formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                validator: (value) {
                  if (value!.length < 8) {
                    return "Girilen username 8 karakterden kucuk olamaz";
                  } else
                    return null;
                },
                onSaved: (value) => _username = value!,
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                validator: (value) {
                  if (value!.length < 8) {
                    return "Girilen password 8 karakterden kucuk olamaz";
                  } else
                    return null;
                },
                onSaved: (value) => _password = value!,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                validator: (deger) {
                  if (deger!.isEmpty) {
                    return "Email bos birakilamaz";
                  } else if (!EmailValidator.validate(deger))
                    return "Gecerli bir mail giriniz.";
                  else
                    return null;
                },
                onSaved: (value) {
                  _e_mail = value!;
                },
                decoration: InputDecoration(
                    labelText: "E-Mail",
                    hintText: "E-Mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
              ),
            ),
            Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () {
                      bool _validate = widget._formKey.currentState!.validate();

                      if (_validate) {
                        widget._formKey.currentState!.save();

                        Duration(seconds: 1);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.teal,
                            duration: Duration(seconds: 5),
                            content: Text(
                              "Kayıt Oldunuz.\nSimdi Giris Yapiniz.",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.amber),
                            )));

                        FirebaseAndFire.createUserEmailAndPassword(
                            _e_mail, _password);
                        FirebaseAndFire.writeUser(
                            _e_mail, _password, _username);

                        Navigator.pushReplacementNamed(context, "/SignInPage");
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.teal,
                            duration: Duration(seconds: 3),
                            content: Text(
                              "Girilen bilgiler gecerli bir kisi olusturamiyor.",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.amber),
                            )));
                      }
                    },
                    child: Text("Log in", style: TextStyle(fontSize: 16))))
          ],
        ),
      )),
    );
  }
}
