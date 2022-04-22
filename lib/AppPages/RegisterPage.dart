import 'package:flutter/material.dart';
import 'package:imdb_proje/Fonksiyonlar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Register Page"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              onChanged: (value) {},
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
              onChanged: (value) {},
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
              onChanged: (value) {},
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
                  onPressed: () {},
                  child: Text("Log in", style: TextStyle(fontSize: 16))))
        ],
      )),
    );
  }
}
