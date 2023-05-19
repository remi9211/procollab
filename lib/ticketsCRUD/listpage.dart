import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:procollab_web/services/procollab_crud.dart';

import 'models/tasks.dart';
import 'addpage.dart';

class ListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPage();
  }
}

class _ListPage extends State<ListPage> {
  final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readPosts();
  //FirebaseFirestore.instance.collection('Employee').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("List of Employee"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => AddPage(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    ListTile(
                      title: Text(e["name"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Project Name: " + e['projectname'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Project Description: " + e['projectdescription'],
                                style: const TextStyle(fontSize: 12)),
                            Text("Area: " + e['area'],
                                style: const TextStyle(fontSize: 12)),
                            Text("Collaborators Needed: " + e['collaboratorsneeded'].toString(),
                                style: const TextStyle(fontSize: 12)),
                            // Text("Experience: " + e['experience'],
                            //     style: const TextStyle(fontSize: 12)),
                            Text("Paisay: " + e['paihay'].toString(),
                                style: const TextStyle(fontSize: 12)),
                            // Text("Requirements: " + e['requirements'],
                            //     style: const TextStyle(fontSize: 12)),
                            // Text("Responsibilities: " + e['responsibilities'],
                            //     style: const TextStyle(fontSize: 12)),

                          ],
                        )),
                      ),
                    ),

                  ]));
                }).toList(),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
