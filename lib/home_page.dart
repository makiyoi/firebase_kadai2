import 'package:flutter/material.dart';
import 'package:assignment_2/main.dart';
import 'package:assignment_2/Registration.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});//required this.registration});

  final String title;
  //final String registration;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectMenu ='';


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (String item) {
              setState(() {
                selectMenu = item;
                //widget.registration != '';
              });
            },
            itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
              const PopupMenuItem(
                  value:  '猫のみ',
                  child:  ListTile(
                    title: Text('猫のみ'),
                  )),
              const PopupMenuItem(
                  value: '犬のみ',
                  child: ListTile(
                    title: Text('犬のみ'),
                  )),
              const PopupMenuItem(
                  value: '年齢：昇順',
                  child: ListTile(
                    title: Text('年齢：昇順'),
                  )),
              const PopupMenuItem(
                  value: '年齢：降順',
                  child: ListTile(
                    title: Text('年齢：降順'),
                  )),
            ],
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        
        title: Text(widget.title),
      ),
      body:  Card(
        child :ListTile(
          title: Text(selectMenu,),
        )
        //child: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //  children: <Widget>[
        //    Padding(
          //    padding: const EdgeInsets.all(8.0),
           //   child: Card(
           //     child:
           //     Text(selectMenu,style: const TextStyle(fontSize: 20,),
                  //'You have pushed the button this many times:',
            //    ),
           //   ),
         //   ),
         // ],
       // ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Registration(registration: 'neko',) )),

        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}