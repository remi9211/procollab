import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:procollab_web/tickets/taskshome.dart';
import '../headerfooter/footer.dart';
import '../headerfooter/headerpostsignin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:percent_indicator/percent_indicator.dart';


class SPTickets extends StatefulWidget {
  final String documentId;

  SPTickets({required this.documentId});

  @override
  State<SPTickets> createState() =>
      _SPTicketsState(documentId: documentId);
}

class _SPTicketsState extends State<SPTickets> {
  final String documentId;

  _SPTicketsState({required this.documentId});

  final user = FirebaseAuth.instance.currentUser;

  @override
  double percent = 0;

  Widget build(BuildContext context) {
    var mainColor = Color(0xFF5364B8);
    var secondaryColor = Color(0xFF7886CB);
    print("Document: $documentId");

    var loading = true;

    var compBack = Color(0xFF71FF99);
    var compFront = Color(0xFF2FB856);

    var inpBack = Color(0xFFFCFF98);
    var inpFront = Color(0xFFBEC300);

    var pendBack = Color(0xFFFF9292);
    var pendFront = Color(0xFFFF1919);

    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    CollectionReference tickets = FirebaseFirestore.instance.collection("tickets");
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: tickets.doc(documentId).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                loading = false;
                // if(documentId.contains(user!.email!)){
                  var taskslen = data['tasksname'].length;
                  print("taskslen $taskslen");

                  return Container(
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.175,
                              0,
                              0,
                              MediaQuery.of(context).size.height * 0.0175),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7.5),
                              border: Border.all(
                                color: mainColor,
                                width: 2.5,
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height *
                                        0.015),
                                child: Text(
                                  data["projectname"],
                                  style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.03,
                                      color: mainColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              taskslen == 0 ? Column(
                                children: [
                                  Text("No tickets yet!", style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.red),)
                                ],
                              ) : Container(),
                              Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width *
                                            0.05),
                                    child: Column(
                                        children:
                                        List.generate(taskslen, (index) {
                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "${data["tasksname"][index]}: ",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        }),

                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0),
                                    child: Column(
                                        children:
                                        List.generate(taskslen, (index) {
                                          return Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "${data["tasksdescription"][index]} ",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        })

                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width*0.3),
                                    child: Column(
                                        children:
                                        List.generate(taskslen, (index) {
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: ElevatedButton(
                                              onPressed: () {  },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: "${data["taskstatuses"][index]}" == "Completed" ? compBack : "${data["taskstatuses"][index]}" == "In Progress" ? inpBack : pendBack, // Background color
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Text("${data["taskstatuses"][index]}", style: TextStyle(color: "${data["taskstatuses"][index]}" == "Completed" ? compFront : "${data["taskstatuses"][index]}" == "In Progress" ? inpFront : pendFront),)
                                                  // child: Text(
                                                  //   "${data["taskstatuses"][index]} ",
                                                  //
                                                  //   style: TextStyle(
                                                  //       fontSize: MediaQuery.of(context)
                                                  //           .size
                                                  //           .height *
                                                  //           0.02,
                                                  //       color: "${data["taskstatuses"][index]}" == "Completed" ? compFront : "${data["taskstatuses"][index]}" == "In Progress" ? inpFront : pendFront,
                                                  //       fontWeight: FontWeight.w600),
                                                  //
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })

                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height *
                                        0.02),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskHome(data: data,documentId: documentId,)));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor, // Background color
                                    ),
                                    child: Text("Edit Tickets")),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                // else {
                //   return Container();
                // }
              // }
              return loading ? Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15,left: MediaQuery.of(context).size.width*0.5),
                child: CircularProgressIndicator(),
              ) : Container();
            }
            )),
      ),
    );
  }
}
