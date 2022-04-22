import 'package:flutter/material.dart';
import 'package:imdb_proje/Fonksiyonlar.dart';
import 'package:imdb_proje/Classes/userClass.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

//sayfanın en altına belki birsey daha koyarız.
class _SignInPageState extends State<SignInPage> {
  String _username = "";
  String _password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app barı kaldırmayı dusunuyorum.
      appBar:
          //icon bulabilirsek uygulama iconu olacak.
          //renkler ayarlanacak.
          AppBar(leading: Icon(Icons.add), title: Text("IMDB Sign in Page")),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //buraya bi resim gelecek
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
                onSaved: (deger) {
                  _username = deger!;
                  // debugPrint(_username);
                },
                validator: (deger) {
                  if (deger!.length < 8) {
                    return "Girilen Username 8 Karakterden kucuk olamaz.";
                  } else
                    return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
                onSaved: (deger) {
                  _password = deger!;
                  // debugPrint(_password);
                },
                validator: (deger) {
                  if (deger!.length < 8) {
                    return "Password 8 karakterden kucuk olamazdd";
                  } else
                    return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 50, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/RegisterPage"),
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Şifreni mi unuttun ?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  bool _validate = _formKey.currentState!.validate();
                  if (_validate) {
                    _formKey.currentState!.save();
                  }
                  if (_password == "123456789" && _username == "MehmetTalha") {
                    var suankiUser = User(_username, _password);
                    Navigator.pushReplacementNamed(context, "/AccountPage",
                        arguments: suankiUser);
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 25,
                    child: Text(
                      "Giris Yap",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )))
          ],
        ),
      )),
    );
  }
}
