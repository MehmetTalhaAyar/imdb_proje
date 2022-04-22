import 'package:flutter/material.dart';
import 'package:imdb_proje/Functions/bottomNavigationBar.dart';
import 'package:imdb_proje/Classes/userClass.dart';

class AccountPage extends StatelessWidget {
  final User suankiUser;
  const AccountPage({required this.suankiUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      bottomNavigationBar: myBottomNavigationBar(),
      //scaffold hepsinde aynı kalacak
      appBar: AppBar(
          leading: Icon(Icons.keyboard_option_key),
          automaticallyImplyLeading: false,
          centerTitle: true,
          //Kullanici Adi
          title: Text("Merhaba " + suankiUser.name)),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.add),
                      Text(
                        "Listelerin",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  subtitle: Container(
                    color: Colors.amber,
                    height: 225,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        Text("Film 1"),
                        Text("Film 2"),
                        Text("Film 3")
                      ],
                    )),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Row(children: [
                    Icon(Icons.add),
                    Text(
                      "Puanladiklarin",
                      style: TextStyle(fontSize: 18),
                    )
                  ]),
                  subtitle: Container(
                    color: Colors.amber,
                    height: 225,
                    child: SingleChildScrollView(
                        child: Column(
                      children: [Text("Puan 1"), Text("Puan 2")],
                    )),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: ListTile(
              title: Row(children: [
                Icon(Icons.add),
                Text(
                  "İzleme Listen",
                  style: TextStyle(fontSize: 18),
                )
              ]),
              subtitle: Container(
                  height: 200,
                  color: Colors.teal,
                  child: SingleChildScrollView(
                    child: Column(children: [Text("Film 1"), Text("Film 2")]),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
