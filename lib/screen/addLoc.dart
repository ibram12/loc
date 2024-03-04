
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loc/widget/card_TextField.dart';

import '../generated/l10n.dart';

class addLoc extends StatefulWidget {
  const addLoc({super.key});


  @override
  State<addLoc> createState() => _addLocState();
}

class _addLocState extends State<addLoc> {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var name_loc,floor;
    CollectionReference loc = FirebaseFirestore.instance.collection('loc');
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('loc').snapshots();
    Future<void> addloc() {
      // Call the user's CollectionReference to add a new user
      return loc
          .add({
        'name_loc': name_loc,
        'floor': floor // 42
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
          appBar: AppBar(

            backgroundColor: Theme.of(context).colorScheme.inversePrimary,

            title: Text(S.of(context).add_khdma),
          ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: cardTextField(value: (value){
                    name_loc = value;
                  }, hinttext: S.of(context).name_loc, textEditingController: _textEditingController,),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: cardTextField(value: (value){
                    floor = value;
                  }, hinttext: S.of(context).floor, textEditingController: textEditingController,),
                ),
              ),
            ],
          ),
          ElevatedButton(onPressed: (){
            if(name_loc != null && floor!=null){
           addloc();
           _textEditingController.clear();
           textEditingController.clear();
            }else{

            }
          }, child: Text(S.of(context).add_loc)),
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(data['name_loc']),
                          subtitle: Text(data['floor']),
                        ),
                      ),
                      Expanded(
                        child: IconButton(onPressed: (){
                          showDeleteItemAlert(document.id);

                        }, icon: Icon(Icons.remove_circle ,color:Colors.red ,)),
                      ),
                    ],
                  );
                }).toList(),
              );
            },
          ))


        ],
      ),
    );
  }
  void deleteDocument(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('loc').doc(documentId).delete();
      print('Document successfully deleted');
    } catch (e) {
      print('Error deleting document: $e');
      // You can handle the error in any way that makes sense for your app
    }
  }
  void showDeleteItemAlert(String index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).title_alart),
          content: Text(S.of(context).mass_alart),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
              },
              child: Text(S.of(context).cancal),
            ),
            TextButton(
              onPressed: () {

                // Remove the item from the list
                setState(() {
                  deleteDocument(index);
                });
                Navigator.pop(context); // Close the alert dialog
              },
              child: Text(S.of(context).remove,style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}


