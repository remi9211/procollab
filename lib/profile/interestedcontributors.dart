import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'interestedcollabdata.dart';

class interestedContributors extends StatefulWidget {
  const interestedContributors({Key? key}) : super(key: key);

  @override
  State<interestedContributors> createState() => _interestedContributorsState();
}

class _interestedContributorsState extends State<interestedContributors> {
  static const mainColor = Color(0xFF1C5D8B);
  static const secondaryColor = Color(0xFF3F83B4);

  static const fontFamily = "DM Sans";

  final user = FirebaseAuth.instance.currentUser;

  List<String> docIDs = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection("contributorrequest").get().then(
          (snapshot) =>
          snapshot.docs.forEach((document) {
            docIDs.add(document.reference.id);
          }),
    );
    print(docIDs);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.15,
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: getDocIds(),
                  builder: (context, snapshot){
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: docIDs.length,
                        itemBuilder: (context, index){
                          return Container(
                            child: Row(
                              children: [
                                Row(children: [
                                  SPInterested(documentId: docIDs[index]),
                                ],),
                              ],
                            ),

                          );
                        }
                    );
                  },
                ),
              ),

              // ),
            ],


          ),
        ),
      ),
    );
    //);
  }
}
