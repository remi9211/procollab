import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:procollab_web/progress/variables.dart';

import 'editpage.dart';

class AllPostsProgress extends StatefulWidget {
  final String documentId;
  final int totalPosts;

  AllPostsProgress({required this.documentId, required this.totalPosts});

  @override
  State<AllPostsProgress> createState() =>
      _AllPostsProgressState(documentId: documentId, totalPosts: totalPosts);
}

class _AllPostsProgressState extends State<AllPostsProgress> {
  final String documentId;
  final int totalPosts;

  _AllPostsProgressState({required this.documentId, required this.totalPosts});

  final user = FirebaseAuth.instance.currentUser;

  @override
  double percent = 0;

  Widget build(BuildContext context) {
    var mainColor = Color(0xFF5364B8);
    var secondaryColor = Color(0xFF7886CB);
    print("Document: $documentId");

    var loading = true;
    var userexists = false;
    var warningTrue = false;

    print("total posts: $totalPosts");

    CollectionReference tickets =
        FirebaseFirestore.instance.collection("tickets");
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");


    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: posts.doc(documentId).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                for(int i = 0; i < data["ticketsuid"].length; i++){
                  if(data["ticketsuid"][i].contains(FirebaseAuth.instance.currentUser!.uid)){
                    userexists = true;
                  }
                }

                for(int i = 0; i < totalPosts; i++){

                }

                if(userexists == true){
                  null;
                }
                else{
                  warningCounter += 1;
                  print("Counter of warning: $warningCounter");
                  print("Total posts: $totalPosts");
                  if(totalPosts == warningTrue){
                    warningTrue = true;
                    print("Warning true");
                  }
                  else{
                    print("Warning false");
                  }
                }

                return userexists ? Container(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: tickets
                          .doc(documentId+FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.done) {
                          print("object");
                          print(documentId +
                              FirebaseAuth.instance.currentUser!.uid);
                          Map<String, dynamic> ticketsData =
                              snapshot.data!.data()
                                  as Map<String, dynamic>;

                          loading = false;

                          //Calculating the progress percentage
                          var taskslen =
                              ticketsData['tasksname'].length;
                          print("taskslen $taskslen");
                          var completedTasks = 0;
                          for (int i = 0; i < taskslen; i++) {
                            if (ticketsData['taskstatuses'][i] ==
                                "Completed") {
                              completedTasks += 1;
                            }
                          }
                          percent = completedTasks / taskslen;
                          print(percent);
                          print("Completed Tasks: $completedTasks");
                          var percentText =
                              (percent * 100).toStringAsFixed(1);
                          print("Text Percent $percentText");

                          return Container(
                            width: MediaQuery.of(context).size.width *
                                0.65,
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width *
                                    0.175,
                                0,
                                0,
                                MediaQuery.of(context).size.height *
                                    0.0275),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(7.5),
                                border: Border.all(
                                  color: mainColor,
                                  width: 2.5,
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.015),
                                  child: Text(
                                    data["projectname"],
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                        color: mainColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.05),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Collaborators: ${data["Collaborators"].length}",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .height *
                                                    0.02,
                                                color: mainColor,
                                                fontWeight:
                                                    FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .height *
                                                    0.015),
                                            child: Text(
                                              "Your Tasks: ${ticketsData["tasksname"].length}",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                  color: mainColor,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                            right:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                        height: MediaQuery.of(context)
                                                .size
                                                .height *
                                            0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    7.5),
                                            border: Border.all(
                                              color: mainColor,
                                              width: 1,
                                            )),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(
                                                            context)
                                                        .size
                                                        .height *
                                                    0.015),
                                            child: Text(
                                              "Your Progress: ",
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                  color: mainColor,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ),
                                          LinearPercentIndicator(
                                            width:
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                            animation: true,
                                            lineHeight: 20.0,
                                            animationDuration: 2500,
                                            percent: percent,
                                            center:
                                                Text("$percentText%"),
                                            linearStrokeCap:
                                                LinearStrokeCap
                                                    .roundAll,
                                            progressColor:
                                                secondaryColor,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  SProgress2(
                                                                    ticketsData: ticketsData,
                                                                    documentId: documentId,
                                                                  )));
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                      mainColor, // Background color
                                                ),
                                                child: Text(
                                                    "View Progress")),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      })),
                ) : Container();
                // }
              }
              return loading
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          left: MediaQuery.of(context).size.width * 0.5),
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            })),
      ),
    );
  }
}
