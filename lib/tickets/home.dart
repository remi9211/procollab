import 'package:flutter/material.dart';
import 'package:procollab_web/allposts/allposts.dart';
import 'package:procollab_web/headerfooter/footer.dart';
import 'package:procollab_web/headerfooter/headerpostsignin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:procollab_web/progress/progresshome.dart';

import 'alltickets.dart';

class TicketsMain extends StatefulWidget {
  const TicketsMain({Key? key}) : super(key: key);

  @override
  State<TicketsMain> createState() => _TicketsMainState();
}

class _TicketsMainState extends State<TicketsMain> {

  static const mainColor = Color(0xFF5364B8);
  static const secondaryColor = Color(0xFF7886CB);

  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection("posts").get().then(
          (snapshot) =>
          snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }),
    );
    print(docIDs);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context){
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [

                    headerpostsu(), //Header post SignUp

                    Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.00,
                              MediaQuery.of(context).size.height * 0.1,
                              0,
                              MediaQuery.of(context).size.height * 0.025),
                          height:
                          MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: mainColor,
                              border: Border.all(
                                color: mainColor,
                                width: 2.5,
                              )),
                          child: Center(
                              child: Text(
                                "Tickets",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: "DM Sans",
                                  fontSize:
                                  MediaQuery.of(context).size.height *
                                      0.05,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ))),
                    ),

                    Center(
                        child: Text(
                          "ALL PROJECTS",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: "DM Sans",
                            fontSize:
                            MediaQuery.of(context).size.height * 0.03,
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )),

                    Tickets(),//GET data Page

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

