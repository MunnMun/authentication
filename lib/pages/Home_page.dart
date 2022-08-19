import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/read%20data/get_username.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;

  List<String> docIDs = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').get().then(
            (snapshot) => snapshot.docs.forEach((element) {
              print(element.reference);
              docIDs.add(element.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('signed in as ' + user.email!),
          MaterialButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          },
            color: Colors.deepPurple[200],
            child: Text('Sign Out'),
          ),
          Expanded(
              child: FutureBuilder(
                future: getDocIds(),
                builder: (context,snapshot){
                  return  ListView.builder(
                      itemCount: docIDs.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: GetUserName(documentId: docIDs[index]),
                        );
                      });
                },
              ),
          ),
        ],
      )),
    );
  }
}
