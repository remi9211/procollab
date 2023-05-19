import 'package:flutter/material.dart';
import 'package:procollab_web/ProjectCRUD/ProjectCRUD/main.dart';
import 'package:procollab_web/ProjectCRUD/ProjectCRUD/page/editprofilepage.dart';
import 'package:procollab_web/contributorside/contributortab.dart';
import 'package:procollab_web/main.dart';
import 'package:procollab_web/profile/profilehome.dart';
import 'package:procollab_web/profile/tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procollab_web/services/procollab_crud.dart';

import '../ProjectCRUD/ProjectCRUD/models/employee.dart';
import '../main.dart';

class ContributorPage extends StatefulWidget {
  ContributorPage({Key? key}) : super(key: key);
// final String documentId;

// GetData({required this.documentId});
  @override
  State<ContributorPage> createState() => _ContributorPageState();
}

class _ContributorPageState extends State<ContributorPage> {


  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    // const mainColor = Color(0xFF1C5D8B);
    var mainColor = Color(0xFF5364B8);
    const secondaryColor = Color(0xFF3F83B4);

    var documentId = "arhamlatif";
    //var documentId = "nooraizashgar";
    //  var documentId = "salihashahzad";
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return SafeArea(
      child: FutureBuilder<DocumentSnapshot>(
          future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
          builder: ((context, snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.05, 0, MediaQuery.of(context).size.height*0.05),
                    height: MediaQuery.of(context).size.height*0.3,
                    width: MediaQuery.of(context).size.width*0.65,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.37,
                              height: MediaQuery.of(context).size.height*0.3,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                ),
                                border: Border.all(
                                  width: 2,
                                  color: mainColor,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.04, 0, 0, 0),
                                    child: CircleAvatar(

                                      backgroundImage: const AssetImage("happy-bearded-young-man.jpg"),
                                      radius: MediaQuery.of(context).size.height*0.075,
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.3,
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.01, MediaQuery.of(context).size.height*0.08, 0, 0),
                                          child: Positioned(
                                            child: Text("${data["name"]}", style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.04,
                                              color: mainColor,
                                              fontWeight: FontWeight.w700,
                                            ),),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.01, MediaQuery.of(context).size.height*0.13, 0, 0),
                                          child: Positioned(
                                            child: Text("${data["field"]}", style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.03,
                                              color: mainColor,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.01, MediaQuery.of(context).size.height*0.17, 0, 0),
                                          child: Positioned(
                                            top: 10,
                                            left: 10,
                                            child: Text("${data["linkedin"]}", style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.height*0.02,
                                              fontWeight: FontWeight.w600,
                                              color: mainColor,
                                            ),),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.23),
                                          height: MediaQuery.of(context).size.height*0.05,
                                          width: MediaQuery.of(context).size.width*0.15,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(17),
                                          ),
                                          child: Row(
                                            children: [
                                              ButtonBar(
                                                //alignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: const Color.fromARGB(
                                                          255, 143, 133, 226), padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                      textStyle: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 30.0),
                                                      child: Text(
                                                        "LOGOUT",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            backgroundColor:
                                                            mainColor,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015,
                                                            ),
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      signUserOut();
                                                    },
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor: const Color.fromARGB(
                                                          255, 143, 133, 226), padding:
                                                      const EdgeInsets.all(
                                                          5.0),
                                                      textStyle: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 30.0),
                                                      child: Text(
                                                        "Switch Profile",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            backgroundColor:
                                                            mainColor,
                                                            fontWeight:
                                                            FontWeight.w700,
                                                            fontSize: MediaQuery.of(
                                                                context)
                                                                .size
                                                                .height *
                                                                0.015),
                                                      ),
                                                    ),
                                                    onPressed: () async {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ProfileMain()));
                                                    },
                                                  ),
                                                ],
                                                //);
                                              ),
                                            ],
                                          )
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
                              width: MediaQuery.of(context).size.width*0.28,
                              height: MediaQuery.of(context).size.height*0.3,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                ),
                                border: Border.all(
                                  width: 2,
                                  color: mainColor,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height*0.045, 0, 0),
                                child: Column(
                                  children: [
                                    Text("About", style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.035,
                                      color: mainColor,
                                      fontWeight: FontWeight.w700,
                                    ),),
                                    Text("Email: ${data["email"]}", style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.025,
                                      color: mainColor,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Text("From: ${data["from"]}", style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.025,
                                      color: mainColor,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    // Text("Member Since: ${data["membersince"]}", style: TextStyle(
                                    //   fontSize: MediaQuery.of(context).size.height*0.025,
                                    //   color: mainColor,
                                    //   fontWeight: FontWeight.w500,
                                    // ),),
                                    Text("Projects Completed: ${data["projectscompleted"]}", style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.025,
                                      color: mainColor,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Text("Ongoing Projects: ${data["ongoingprojects"]}", style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.height*0.025,
                                      color: mainColor,
                                      fontWeight: FontWeight.w500,
                                    ),),
                                    Container(
                                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                                      height: MediaQuery.of(context).size.height*0.05,
                                      width: MediaQuery.of(context).size.width*0.15,
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(17),
                                      ),
                                      child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height*0.05,
                                            width: MediaQuery.of(context).size.width*0.11,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.circular(17),
                                            ),
                                            child: FutureBuilder(
                                              future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
                                              builder: ((context, snapshot){
                                                if (snapshot.hasData) {
                                                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                                  // return ListView(
                                                  // children: snapshot.data!.docs.map((e) {
                                                  return Row(
                                                    children: [
                                                      ButtonBar(
                                                        //alignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              padding: const EdgeInsets.all(5.0),
                                                              primary: const Color.fromARGB(255, 143, 133, 226),
                                                              textStyle: const TextStyle(fontSize: 20),
                                                            ),
                                                            child: Text("Edit Profile",style: TextStyle(
                                                                color: Colors.white,
                                                                backgroundColor: mainColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize:  MediaQuery.of(context).size.height*0.015),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pushAndRemoveUntil<dynamic>(
                                                                context,
                                                                MaterialPageRoute<dynamic>(
                                                                  builder: (BuildContext context) => EditProfilePage(
                                                                    profile: Profile(
                                                                      uid: FirebaseAuth.instance.currentUser!.uid,
                                                                      name: "${data["name"]}",
                                                                      email: "${data["email"]}",
                                                                      field: "${data["field"]}",
                                                                      linkedin: "${data["linkedin"]}",
                                                                      // ongoingprojects: "${data["ongoingprojects"]}",
                                                                      // projectscompleted: "${data["projectscompleted"]}",
                                                                      from: "${data["from"]}",
                                                                    ),
                                                                  ),
                                                                ),
                                                                    (route) =>
                                                                false, //if you want to disable back feature set to false
                                                              );
                                                            },
                                                          ),
                                                          TextButton(
                                                            style: TextButton.styleFrom(
                                                              padding: const EdgeInsets.all(5.0),
                                                              primary: const Color.fromARGB(255, 143, 133, 226),
                                                              textStyle: const TextStyle(fontSize: 20),
                                                            ),
                                                            child: Text("Delete Profile",style: TextStyle(
                                                                color: Colors.white,
                                                                backgroundColor: mainColor,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize:  MediaQuery.of(context).size.height*0.015),
                                                            ),
                                                            onPressed: () async {
                                                              // setState(() {

                                                              // });
                                                              var response =
                                                              await FirebaseCrud.deleteProfile(docId: FirebaseAuth.instance.currentUser!.uid);
                                                              if (response.code != 200) {
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                        Text(response.message.toString()),
                                                                      );
                                                                    });
                                                              }

                                                              signUserOut();

                                                            },
                                                          ),

                                                        ],
                                                        //);
                                                      ),
                                                    ],
                                                  );
                                                  //}).toList(),
                                                  //);
                                                }

                                                return Container();
                                              }
                                              ),
                                            ),
                                          )
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
                  ),
                  Container(
                    height: 2500,
                    width: MediaQuery.of(context).size.width*0.65,
                    child: ContributorTabs(),

                  ),
                ],
              );

            }
            //return Text("Fetching Data from Database..");
            return const Text("");
          })),
    );

  }
}

