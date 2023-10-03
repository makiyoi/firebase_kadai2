import 'package:flutter/material.dart';
import 'package:assignment_2/Registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title,});//required this.registration});

  final String title;



  @override

  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 //Stream<QuerySnapshot> selectMenu = FirebaseFirestore.instance.collection('selects').where('animal', isEqualTo: 'cat').snapshots();
  String selectMenu = '';

   final Stream<QuerySnapshot> _selectsStream= FirebaseFirestore.instance.collection('selects').snapshots();

  Future<void> addselect(Map<String,dynamic>select) async {
    await FirebaseFirestore.instance.collection('selects').add(select);
  }

  Stream<QuerySnapshot>  popupMenu(String selectMenu) {
      switch (selectMenu) {
        case 'cat':
          return FirebaseFirestore.instance.collection('selects').where(
              'animal', isEqualTo: 'cat').snapshots();
        case 'dog' :
          return FirebaseFirestore.instance.collection('selects').where(
              'animal', isEqualTo: 'dog').snapshots();
        case 'ageup':
          return FirebaseFirestore.instance.collection('selects').orderBy(
              'age', descending: true).snapshots();
        case 'agedown':
          return FirebaseFirestore.instance.collection('selects').orderBy(
              'age', descending: false).snapshots();
        default :
        return FirebaseFirestore.instance.collection('selects').snapshots();
      }
    }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (String value){
                setState(() {
                  selectMenu = value;
                  popupMenu(selectMenu);
                });
                },
            itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
              const PopupMenuItem(
                  value: 'cat',
                  child:  ListTile(
                    title: Text('猫のみ'),
                  )),
              const PopupMenuItem(
                  value: 'dog',
                  child: ListTile(
                    title: Text('犬のみ'),
                  )),
              const PopupMenuItem(
                  value: 'ageup',
                  child: ListTile(
                    title: Text('年齢：昇順'),
                  )),
              const PopupMenuItem(
                  value: 'agedown',
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
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const Registration(), )),

        child: const Icon(Icons.add),
      ),
    );
  }
}
class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.selectData,}) : super(key: key);
  final Map<String,dynamic> selectData;
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        leading: const Icon(Icons.pets),
        title: Text('名前: ${selectData['name']} 年齢: ${selectData['age']} 品種: ${selectData['variety']} 性別: ${selectData['jender']}'),
        //subtitle: Text('性別: ${selectData['jender']}'),
        tileColor: Colors.blue[100],
      ),
    );
  }
}
