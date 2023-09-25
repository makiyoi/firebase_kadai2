import 'package:flutter/material.dart';
import 'package:assignment_2/Registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title,});//required this.registration});

  final String title;
  //final String registration;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectMenu ='';
  final _nameEditingController = TextEditingController();
  final _varietyEditingController = TextEditingController();
  final _ageEditingController = TextEditingController();
  final _listScrollController = ScrollController();
  final Stream<QuerySnapshot> _selectsStream= FirebaseFirestore.instance.collection('selects').snapshots();


  Future<void> addselect(Map<String,dynamic>select) async {
    await FirebaseFirestore.instance.collection('selects').add(select);
  }
  Future<void> _addselect() async{
    await FirebaseFirestore.instance.collection('selects').doc().set({
      'name': _nameEditingController.text,
      'variety': _varietyEditingController.text,
      'age': _ageEditingController.text,
    });
    _listScrollController.jumpTo(_listScrollController.position.maxScrollExtent);
  }

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
       body:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           StreamBuilder<QuerySnapshot>(
               stream: _selectsStream,
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                   List<DocumentSnapshot> selectsData = snapshot.data!.docs;
                   return Expanded(
                     child: ListView.builder(
                       controller: _listScrollController,
                       itemCount: selectsData.length,
                       itemBuilder: (context, index) {
                         final selectData = selectsData[index].data()! as Map<String, dynamic>;
                         return SelectCard(selectData: selectData,);//id: widget.id,);
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator(),);
          }
          ),
         ],
       ),
    //  body:  Card(
      //  child :ListTile(
        //  title: Text(selectMenu,),
        //)
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
           //
         //   ),
         // ],
       // ),
   // ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Registration(), )),

        child: const Icon(Icons.add),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}