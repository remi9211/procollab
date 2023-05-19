import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procollab_web/agreement/Agreement.dart';
import 'package:procollab_web/agreement/Agreement2.dart';
import 'package:procollab_web/headerfooter/footer.dart';
import 'package:procollab_web/headerfooter/headerpostsignin.dart';
import 'package:procollab_web/profile/Viewfulllist.dart';

import '../helperCRUD/services/firebase_crud.dart';

class SPInterested extends StatefulWidget {
  final String documentId;
  SPInterested({required this.documentId});

  @override
  State<SPInterested> createState() => _SPInterestedState();
}

class _SPInterestedState extends State<SPInterested> {
  @override
  Widget build(BuildContext context) {
    print(widget.documentId);
    var fontFam = "DM Sans";
    const mainColor = Color(0xFF1C5D8B);
    const secondaryColor = Color(0xFF3F83B4);
    var loading = true;
    var contributorLoading = true;

    CollectionReference user = FirebaseFirestore.instance.collection("users");
    CollectionReference contributorsCollection =
        FirebaseFirestore.instance.collection("contributorrequest");

    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: contributorsCollection.doc(widget.documentId).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                loading = false;
                if (data["email"] == FirebaseAuth.instance.currentUser!.email) {
                  // DocumentReference docRef = FirebaseFirestore.instance.collection("contributorrequest").doc(documentId);
                  // DocumentSnapshot doc = await docRef.get();
                  var length = data["contributors"].length;
                  // var collaboratorsLen = data["Collaborators"].length;
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: mainColor,
                                        width: 2.5,
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Positioned(
                                            child: Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.fromLTRB(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.5,
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.03,
                                                    0,
                                                    0),
                                                child: Column(
                                                  children: [
                                                    Text(data['projectName'],
                                                        style: TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            fontSize: 20,
                                                            color: mainColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                fontFam)),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                      Column(
                                        children:
                                            List.generate(length, (index) {
                                          return FutureBuilder<
                                                  DocumentSnapshot>(
                                              future: user
                                                  .doc(data["contributors"]
                                                      [index])
                                                  .get(),
                                              builder: ((context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  contributorLoading = false;
                                                  if (data["contributorStatus"]
                                                          [index] ==
                                                      "Pending") {
                                                    Map<String, dynamic>
                                                        userData =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;
                                                    print("Data: $userData");
                                                    return Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.21,
                                                              MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                                  0.05,
                                                              0,
                                                              0),
                                                          child: const CircleAvatar(
                                                            radius: 30,
                                                            backgroundImage: AssetImage(
                                                                'happy-bearded-young-man.jpg'),
                                                          ),
                                                        ),
                                                        Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width*0.08,
                                                            margin: EdgeInsets.fromLTRB(
                                                                MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.01,
                                                                MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                    0.03,
                                                                0,
                                                                0),
                                                            child: Column(children: [
                                                              Text(
                                                                  "${userData['name']}",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                      fontSize: 20,
                                                                      color: mainColor,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontFamily:
                                                                      fontFam)),
                                                              Text(
                                                                  "${userData['field']}",
                                                                  style: TextStyle(
                                                                      decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                      fontSize: 14,
                                                                      color: mainColor,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontFamily:
                                                                      fontFam))

                                                            ])),
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.1,
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.05,
                                                              0,
                                                              0),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: mainColor,
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(10),
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title:
                                                                          Row(
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.37,
                                                                                height: MediaQuery.of(context).size.height * 0.3,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                                                                  border: Border.all(
                                                                                    width: 2,
                                                                                    color: mainColor,
                                                                                    style: BorderStyle.solid,
                                                                                  ),
                                                                                ),
                                                                                child: Row(
                                                                                  children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                                                                                      child: CircleAvatar(
                                                                                        backgroundImage: const AssetImage("happy-bearded-young-man.jpg"),
                                                                                        radius: MediaQuery.of(context).size.height * 0.075,
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      height: MediaQuery.of(context).size.height * 0.3,
                                                                                      child: Stack(
                                                                                        children: [
                                                                                          Container(
                                                                                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.08, 0, 0),
                                                                                            child: Positioned(
                                                                                              child: Text(
                                                                                                "${userData['name']}",
                                                                                                style: TextStyle(
                                                                                                  fontSize: MediaQuery.of(context).size.height * 0.04,
                                                                                                  color: mainColor,
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.13, 0, 0),
                                                                                            child: Positioned(
                                                                                              child: Text(
                                                                                                "${userData["field"]}",
                                                                                                style: TextStyle(
                                                                                                  fontSize: MediaQuery.of(context).size.height * 0.03,
                                                                                                  color: mainColor,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.17, 0, 0),
                                                                                            child: Positioned(
                                                                                              top: 10,
                                                                                              left: 10,
                                                                                              child: Text(
                                                                                                "${userData["linkedin"]}",
                                                                                                style: TextStyle(
                                                                                                  fontSize: MediaQuery.of(context).size.height * 0.02,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  color: mainColor,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.28,
                                                                                height: MediaQuery.of(context).size.height * 0.3,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                                                                  border: Border.all(
                                                                                    width: 2,
                                                                                    color: mainColor,
                                                                                    style: BorderStyle.solid,
                                                                                  ),
                                                                                ),
                                                                                child: Container(
                                                                                  margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.045, 0, 0),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Text(
                                                                                        "About",
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.height * 0.035,
                                                                                          color: mainColor,
                                                                                          fontWeight: FontWeight.w700,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "Email: ${userData["email"]}",
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                                                                          color: mainColor,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "From: ${userData["from"]}",
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                                                                          color: mainColor,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                      // Text("Member Since: ${data["membersince"]}", style: TextStyle(
                                                                                      //   fontSize: MediaQuery.of(context).size.height*0.025,
                                                                                      //   color: mainColor,
                                                                                      //   fontWeight: FontWeight.w500,
                                                                                      // ),),
                                                                                      Text(
                                                                                        "Projects Completed: ${userData["projectscompleted"]}",
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                                                                          color: mainColor,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "Ongoing Projects: ${userData["ongoingprojects"]}",
                                                                                        style: TextStyle(
                                                                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                                                                          color: mainColor,
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            },
                                                            child: Center(
                                                                child: Text(
                                                                    "View Profile",
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            fontFam))),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        "${userData["name"]} has been added to the list of contributors"),
                                                                  );
                                                                });

                                                            DocumentReference
                                                                docContributorReqRef =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "contributorrequest")
                                                                    .doc(widget
                                                                        .documentId);
                                                            DocumentSnapshot
                                                                doc =
                                                                await docContributorReqRef
                                                                    .get();
                                                            var contributorStatus =
                                                                doc['contributorStatus'];
                                                            contributorStatus[
                                                                    index] =
                                                                "Approved";
                                                            docContributorReqRef
                                                                .update({
                                                              "contributorStatus":
                                                                  contributorStatus,
                                                            });

                                                            DocumentReference
                                                                docRef =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "posts")
                                                                    .doc(widget
                                                                        .documentId);

                                                            DocumentSnapshot docPostRef = await docRef.get();

                                                            var paymentStatus = docPostRef['paymentStatus'];
                                                            var CollaboratorsField = docPostRef['CollaboratorsField'];

                                                            print("PaymentStatus: $paymentStatus");
                                                            paymentStatus.add("Pending");
                                                            print("PaymentStatus: $paymentStatus");

                                                            print("CollaboratorsField: $CollaboratorsField");
                                                            CollaboratorsField.add(userData["field"]);
                                                            print("CollaboratorsField: $CollaboratorsField");

                                                            docRef.update({
                                                              "Collaborators":
                                                                  FieldValue.arrayUnion([userData["name"]]),
                                                              "CollaboratorsID": FieldValue.arrayUnion([data["contributors"][index]]),
                                                              "CollaboratorsEmail": FieldValue.arrayUnion([userData["email"]]),
                                                              "paymentStatus": paymentStatus,
                                                              "CollaboratorsField": CollaboratorsField,
                                                              "ticketsuid": FieldValue.arrayUnion([widget.documentId + userData["uid"]]),
                                                            });

                                                            Future<bool>
                                                                checkIfDocExists(
                                                                    String
                                                                        docId) async {
                                                              try {
                                                                // Get reference to Firestore collection
                                                                var docTicketsRef = FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "tickets")
                                                                    .doc(widget
                                                                        .documentId)
                                                                    .collection(
                                                                        userData[
                                                                            'uid'])
                                                                    .doc(widget
                                                                        .documentId);

                                                                var doc =
                                                                    await docTicketsRef
                                                                        .get();
                                                                return doc
                                                                    .exists;
                                                              } catch (e) {
                                                                throw e;
                                                              }
                                                            }

                                                            // Check If Document Exists
                                                            bool docExists =
                                                                await checkIfDocExists(
                                                                    widget
                                                                        .documentId);
                                                            print("Document exists in Firestore? " +
                                                                docExists
                                                                    .toString());

                                                            final snapshot =
                                                                await FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "tickets")
                                                                    .get();

                                                            if (snapshot.size ==
                                                                0) {
                                                              await FirebaseCrud
                                                                  .addTasksPerContributor(
                                                                documentId: widget
                                                                    .documentId,
                                                                userId:
                                                                    userData[
                                                                        'uid'],
                                                                projectName: data[
                                                                    'projectName'],
                                                                userEmail:
                                                                    userData[
                                                                        'email'],
                                                              );
                                                            } else if (docExists ==
                                                                false) {
                                                              await FirebaseCrud
                                                                  .addTasksPerContributor(
                                                                documentId: widget
                                                                    .documentId,
                                                                userId:
                                                                    userData[
                                                                        'uid'],
                                                                projectName: data[
                                                                    'projectName'],
                                                                userEmail:
                                                                    userData[
                                                                        'email'],
                                                              );
                                                            } else {
                                                              DocumentReference
                                                                  ticketsDocRef =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "tickets")
                                                                      .doc(widget
                                                                              .documentId +
                                                                          userData[
                                                                              'uid']);
                                                              print(
                                                                  "interested collab");
                                                              print(widget
                                                                      .documentId +
                                                                  FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid);
                                                              ticketsDocRef.set(
                                                                  {
                                                                    "exists":
                                                                        "true",
                                                                    "tasksname":
                                                                        List.generate(
                                                                            0,
                                                                            (r) =>
                                                                                ""),
                                                                    "taskstatuses":
                                                                        List.generate(
                                                                            0,
                                                                            (r) =>
                                                                                ""),
                                                                    "tasksdescription":
                                                                        List.generate(
                                                                            0,
                                                                            (r) =>
                                                                                ""),
                                                                    "projectname":
                                                                        data[
                                                                            'projectName'],
                                                                    "CollaboratorsEmail":
                                                                        List.generate(
                                                                            0,
                                                                            (r) =>
                                                                                "$userData['email']"),
                                                                  },
                                                                  SetOptions(
                                                                      merge:
                                                                          true));
                                                            }
                                                          },
                                                          child: Container(
                                                            margin: EdgeInsets.fromLTRB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.025,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                0,
                                                                0),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.04,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.1,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: mainColor,
                                                              borderRadius:
                                                                  new BorderRadius
                                                                      .circular(10),
                                                            ),
                                                            child: Center(
                                                                child: Text(
                                                                    "Collaborate",
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .none,
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            fontFam))),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }
                                                return contributorLoading
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            top: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.03),
                                                        child:
                                                            CircularProgressIndicator())
                                                    : Container();
                                              }));
                                        }),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
              return loading
                  ? Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.15,
                          left: MediaQuery.of(context).size.width * 0.325),
                      child: CircularProgressIndicator(),
                    )
                  : Container();
            })),
      ),
    );
  }
}
