import 'package:flutter/material.dart';
import 'package:assignment_2/Registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});//required this.registration});

  final String title;
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String selectMenu = '';


  final Stream<QuerySnapshot> _selectsStream= FirebaseFirestore.instance.collection('selects').snapshots();

  Future<void> addselect(Map<String,dynamic>select) async {
    await FirebaseFirestore.instance.collection('selects').add(select);
  }

  final Stream<QuerySnapshot> _cat = FirebaseFirestore.instance.collection('selects').where('animal',isEqualTo: 'cat').snapshots();
  final Stream<QuerySnapshot> _dog = FirebaseFirestore.instance.collection('selects').where('animal',isEqualTo: 'dog' ).snapshots();
  final Stream<QuerySnapshot> _ageup = FirebaseFirestore.instance.collection('selects').orderBy('age',descending: true).snapshots();
  final Stream<QuerySnapshot> _agedown = FirebaseFirestore.instance.collection('selects').orderBy('age',descending: false).snapshots();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu),
            onSelected: (String value) {
              setState(() {
                selectMenu = value;
              });
            },
            itemBuilder: (BuildContext context)=> <PopupMenuEntry<String>>[
              const PopupMenuItem(
                  value: '',
                  child:  ListTile(
                    title: Text('猫のみ'),
                  )),
              const PopupMenuItem(
                  value: '',
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
        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Registration(), )),

        child: const Icon(Icons.add),
      ),
    );
  }
}
class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.selectData}) : super(key: key);
  final Map<String,dynamic> selectData;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: ListTile(
        leading: const Icon(Icons.pets),
        title: Text('名前: ${selectData['name']} 年齢: ${selectData['age']} 品種: ${selectData['variety']}'),
        subtitle: Text('性別: ${selectData['jender']}'),
        tileColor: Colors.blue[100],
      ),
    );
  }
}
