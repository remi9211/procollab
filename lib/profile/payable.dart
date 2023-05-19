import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:procollab_web/profile/allpayableposts.dart';

import 'getpaybledata.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyBJ9HcdFos8Bx85m9Jj2X3BPt3U7MhRV50",
        projectId: "fir-authentication-ef41b",
        messagingSenderId: "712311594484",
        appId: "1:712311594484:web:15e0dcb3b32f4406c36da1",
      )
  );
  runApp(PayableMain());
}

class PayableMain extends StatefulWidget {
  const PayableMain({Key? key}) : super(key: key);

  @override
  State<PayableMain> createState() => _PayableMainState();
}

class _PayableMainState extends State<PayableMain> {

  static const mainColor = Color(0xFF1C5D8B);
  static const secondaryColor = Color(0xFF3F83B4);

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
                                  GetPayableData(documentId: docIDs[index]),
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
  }
}

