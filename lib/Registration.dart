import 'dart:html';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment_2/home_page.dart';

enum SingingCharacter {dog, cat,osu,mesu}

class Registration extends StatefulWidget {
  const Registration({Key? key,required this.registration}) : super(key: key);
 final String registration;
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  SingingCharacter? _character = SingingCharacter.dog;
  SingingCharacter? _jender = SingingCharacter.osu;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [

      ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width/1.2,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '名前',border: OutlineInputBorder()),
                  ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: SingingCharacter.osu, groupValue: _character,
                        onChanged: (SingingCharacter? value){
                      setState(() {
                        _character = value;
                      });
                        }),
                    const Text('犬'),
                    const SizedBox(width: 130,),
                    Radio(value: SingingCharacter.mesu, groupValue: _character,
                      onChanged:(SingingCharacter? value){
                      setState(() {
                        _character = value;
                      });
                      },
                    ),
                    const Text('猫'),
                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '品種',border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(value: SingingCharacter.dog, groupValue: _jender,
                        onChanged: (SingingCharacter? value){
                      setState(() {
                        _jender = value;
                      });
                        },
                    ),
                    const Text('オス'),
                    const SizedBox(width: 130,),
                    Radio(value: SingingCharacter.cat, groupValue: _jender,
                      onChanged:(SingingCharacter? value){
                      setState(() {
                        _jender = value;
                      });
                      },
                    ),
                    const Text('メス'),
                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: '年齢',border: OutlineInputBorder()),
                ),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    setState(() {

                    });
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

