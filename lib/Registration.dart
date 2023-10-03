import 'dart:html';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


enum SingingCharacter {dog,cat,osu,mesu}

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);


  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  final _nameEditingController = TextEditingController();
  final _varietyEditingController = TextEditingController();
  final _ageEditingController = TextEditingController();
  String _jender = '';
  String _character ='';



  String getCharacter(SingingCharacter singingCharacter) {
    switch(singingCharacter){
      case SingingCharacter.dog:
       return '犬';
    case SingingCharacter.cat:
       return '猫';
     case SingingCharacter.osu:
       return 'オス';
     case SingingCharacter.mesu:
       return 'メス';
      default:
        return '';
    }
  }

   Future<DocumentSnapshot> selectData = FirebaseFirestore.instance.collection('selects').doc().get();

  Future<void> addselected() async{
    await FirebaseFirestore.instance.collection('selects').doc().set({
      'name': _nameEditingController.text,
      'variety': _varietyEditingController.text,
      'age': _ageEditingController.text,
      'jender': _jender,
      'animal': _character,
    });
    _nameEditingController.clear();
    _varietyEditingController.clear();
    _ageEditingController.clear();
  }

  @override




  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: const [
      ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/1.2,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
           child: Column(
                children: [
                  TextFormField(
                  controller: _nameEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '名前',border: OutlineInputBorder()),
                  ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: '犬', groupValue: _character,
                        onChanged: (value){
                      setState(() {
                        _character = value!;
                      });
                        }),

                    const Text('犬'),
                    const SizedBox(width: 130,),
                    Radio(value: '猫', groupValue: _character,
                      onChanged:(value){
                      setState(() {
                        _character = value!;
                      });
                      },
                    ),
                    const Text('猫'),
                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _varietyEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '品種',border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: 'オス', groupValue: _jender,
                        onChanged: (value){
                      setState(() {
                        _jender = value!;
                      });
                        },
                    ),
                    const Text('オス'),
                    const SizedBox(width: 130,),
                    Radio(value: 'メス', groupValue: _jender,
                      onChanged:(value){
                      setState(() {
                        _jender = value!;
                      });
                      },
                    ),
                    const Text('メス'),

                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: _ageEditingController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '年齢',border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    addselected();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  child: const Text('登録',style: TextStyle(fontSize: 15,color: Colors.white),),

                ),
             ],
            ),
          ),
        ),
      ),
    );
  }
}

