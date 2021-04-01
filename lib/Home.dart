import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indice = 0;
  String _resultado = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Incricao(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
          opacity: 1
        ),
        backgroundColor: Colors.white,
        title: Image.asset(
            "images/youtube.png",
          width: 98,
          height: 22,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.videocam),
              onPressed: (){
                print("acao: video cam");
              }
          ),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(context: context, delegate: CustomSearchDelegate());
                setState(() {
                  _resultado = res;
                });
                print(res);
              }
          ),
          IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){
                print("acao: conta");
              }
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indice]
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _indice,
        onTap: (indice){
          setState(() {
            _indice = indice;
          });
        },
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Colors.deepOrange,
              title: Text("Início"),
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.lightBlueAccent,
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.lightGreenAccent,
              title: Text("Inscrições"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.black45,
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ],
      ),
    );
  }
}
