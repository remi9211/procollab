import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:procollab_web/authentication/signup.dart';
import 'package:procollab_web/tickets/createtasks.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../headerfooter/footer.dart';
import '../headerfooter/headerpostsignin.dart';

class TaskHome extends StatefulWidget {
  final String documentId;
  // Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  final Map<String, dynamic> data;

  TaskHome({required this.documentId, required this.data});

  static const mainColor = Color(0xFF5364B8);
  static const secondaryColor = Color(0xFF7886CB);

  @override
  State<TaskHome> createState() => _TaskHomeState(documentId: documentId, data: data);
}

class _TaskHomeState extends State<TaskHome> {
  final String documentId;
  final Map<String, dynamic> data;
  _TaskHomeState({required this.documentId, required this.data});

  final user = FirebaseAuth.instance.currentUser;

  bool exists = false;

  List<String> Collaborators = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");

    var collaboratorsArray = data["CollaboratorsEmail"];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context){
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [

                    headerpostsu(), //Header post SignUp

                    SPCreateTasks(documentId: documentId),

                    footer(), // Footer
                  ],
                ),
              ),
            ),

          );
        },
            )
        );
    }
}
