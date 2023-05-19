import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procollab_web/adminpanel/approvepost.dart';
import 'package:procollab_web/postdetail/projectdetails.dart';

class GetWithdrawalData extends StatefulWidget {
  //const GetData({Key? key}) : super(key: key);
  final String documentId;

  GetWithdrawalData({required this.documentId});

  @override
  State<GetWithdrawalData> createState() =>
      _GetWithdrawalDataState(documentId: this.documentId);
}

class _GetWithdrawalDataState extends State<GetWithdrawalData> {
  final String documentId;
  //
  _GetWithdrawalDataState({required this.documentId});

  @override
  Widget build(BuildContext context) {
    var mainColor = const Color(0xFF1C5D8B);
    var secondaryColor = const Color(0xFF3F83B4);
    var sec2Color = const Color(0xFFD8EAFF);
    var sec3Color = const Color(0xFF5381B8);
    CollectionReference withdrawalrequest = FirebaseFirestore.instance.collection("withdrawalrequest");
    CollectionReference posts = FirebaseFirestore.instance.collection("posts");
    return SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: withdrawalrequest.doc(documentId).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
                print("withdrawal data: $data");
                return FutureBuilder<DocumentSnapshot>(
                    future: posts.doc(data['postid']).get(),
                    builder: ((context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        Map<String, dynamic> postData = snapshot.data!.data() as Map<String, dynamic>;
                        print("Post Data: $postData");
                        if(postData["withdrawalStatus"] == "Pending"){
                          return Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width * 0.175,
                                      top: MediaQuery.of(context).size.height * 0.02),
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  height: MediaQuery.of(context).size.height * 0.315,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: mainColor,
                                        width: 2.5,
                                      )),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.12,
                                        left: MediaQuery.of(context).size.height * 0.08,
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                "Collaborator: ",
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontFamily: "DM Sans",
                                                    fontSize:
                                                    MediaQuery.of(context).size.height *
                                                        0.03,
                                                    color: mainColor,
                                                    fontWeight: FontWeight.w300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * 0.12,
                                          left: MediaQuery.of(context).size.height * 0.35,
                                          child: Container(
                                            child: Text(
                                              "${data['collaboratorEmail']}",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontFamily: "DM Sans",
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      0.03,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          )),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * 0.16,
                                          left: MediaQuery.of(context).size.height * 0.08,
                                          child: Container(
                                            child: Text(
                                              "Requested By: ",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontFamily: "DM Sans",
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      0.03,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          )),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * 0.16,
                                          left: MediaQuery.of(context).size.height * 0.35,
                                          child: Container(
                                            child: Text(
                                              "${data['requestedBy']}",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontFamily: "DM Sans",
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      0.03,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          )),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * 0.035,
                                          left: MediaQuery.of(context).size.height * 1.15,
                                          child: Container(
                                            child: Text(
                                              "\$${data['amount']}",
                                              style: TextStyle(
                                                  decoration: TextDecoration.none,
                                                  fontFamily: "DM Sans",
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      0.035,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          )),
                                      Positioned(
                                          top: MediaQuery.of(context).size.height * 0.1,
                                          left: MediaQuery.of(context).size.height * 0.08,
                                          child: Container(
                                            height: MediaQuery.of(context).size.height *
                                                0.003,
                                            width:
                                            MediaQuery.of(context).size.width * 0.57,
                                            color: mainColor,
                                          )),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.035,
                                        left: MediaQuery.of(context).size.height * 0.08,
                                        child: Text(
                                          "${data['projectName']}",
                                          style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontFamily: "DM Sans",
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  0.035,
                                              color: mainColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.22,
                                        left: MediaQuery.of(context).size.height * 0.8,
                                        child: Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(17),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {});
                                            },
                                            child: MaterialButton(
                                              minWidth: MediaQuery.of(context).size.width,
                                              padding: const EdgeInsets.fromLTRB(
                                                  20.0, 15.0, 20.0, 15.0),
                                              onPressed: () async {
                                                print("Post id:");
                                                print(data['postid']);
                                                DocumentReference docRef = FirebaseFirestore.instance.collection("posts").doc(data['postid']);
                                                // DocumentSnapshot doc = await docRef.get();
                                                docRef.update({
                                                  "withdrawalStatus": "Rejected",
                                                });
                                              },
                                              child: Text(
                                                "Reject",
                                                style: TextStyle(
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.025,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.22,
                                        left: MediaQuery.of(context).size.height * 1.04,
                                        child: Container(
                                          height:
                                          MediaQuery.of(context).size.height * 0.05,
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(17),
                                          ),
                                          child: Center(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {});
                                              },
                                              child: MaterialButton(
                                                minWidth:
                                                MediaQuery.of(context).size.width,
                                                padding: const EdgeInsets.fromLTRB(
                                                    20.0, 15.0, 20.0, 15.0),
                                                onPressed: () async {
                                                  print("Post id:");
                                                  print(data['postid']);
                                                  DocumentReference docRef = FirebaseFirestore.instance.collection("posts").doc(data['postid']);
                                                  DocumentSnapshot doc = await docRef.get();
                                                  var amountDue = doc['AmountDue'];
                                                  var amountEarned = doc['AmountEarned'];
                                                  var temp = amountDue;
                                                  amountDue = amountEarned;
                                                  amountEarned = temp;
                                                  docRef.update({
                                                    "AmountEarned": amountEarned,
                                                    "AmountDue": amountDue,
                                                    "withdrawalStatus": "Done",
                                                  });
                                                },
                                                child: Text(
                                                  "Approve",
                                                  style: TextStyle(
                                                      fontSize: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                          0.025,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return Container();
                    }));
                // if("${data['approval']}" == "Pending"){
                //   return Container(
                //     child: Row(
                //       children: [
                //         Container(
                //           margin: EdgeInsets.only(
                //               left: MediaQuery.of(context).size.width * 0.175,
                //               top: MediaQuery.of(context).size.height * 0.02),
                //           width: MediaQuery.of(context).size.width * 0.65,
                //           height: MediaQuery.of(context).size.height * 0.315,
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               border: Border.all(
                //                 color: mainColor,
                //                 width: 2.5,
                //               )),
                //           child: Stack(
                //             children: <Widget>[
                //               Positioned(
                //                 top: MediaQuery.of(context).size.height * 0.12,
                //                 left: MediaQuery.of(context).size.height * 0.08,
                //                 child: Row(
                //                   children: [
                //                     Container(
                //                       child: Text(
                //                         "Collaborator: ",
                //                         style: TextStyle(
                //                             decoration: TextDecoration.none,
                //                             fontFamily: "DM Sans",
                //                             fontSize:
                //                             MediaQuery.of(context).size.height *
                //                                 0.03,
                //                             color: mainColor,
                //                             fontWeight: FontWeight.w300),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //               Positioned(
                //                   top: MediaQuery.of(context).size.height * 0.12,
                //                   left: MediaQuery.of(context).size.height * 0.35,
                //                   child: Container(
                //                     child: Text(
                //                       "${data['collaboratorEmail']}",
                //                       style: TextStyle(
                //                           decoration: TextDecoration.none,
                //                           fontFamily: "DM Sans",
                //                           fontSize:
                //                           MediaQuery.of(context).size.height *
                //                               0.03,
                //                           color: mainColor,
                //                           fontWeight: FontWeight.w300),
                //                     ),
                //                   )),
                //               Positioned(
                //                   top: MediaQuery.of(context).size.height * 0.16,
                //                   left: MediaQuery.of(context).size.height * 0.08,
                //                   child: Container(
                //                     child: Text(
                //                       "Requested By: ",
                //                       style: TextStyle(
                //                           decoration: TextDecoration.none,
                //                           fontFamily: "DM Sans",
                //                           fontSize:
                //                           MediaQuery.of(context).size.height *
                //                               0.03,
                //                           color: mainColor,
                //                           fontWeight: FontWeight.w300),
                //                     ),
                //                   )),
                //               Positioned(
                //                   top: MediaQuery.of(context).size.height * 0.16,
                //                   left: MediaQuery.of(context).size.height * 0.35,
                //                   child: Container(
                //                     child: Text(
                //                       "${data['requestedBy']}",
                //                       style: TextStyle(
                //                           decoration: TextDecoration.none,
                //                           fontFamily: "DM Sans",
                //                           fontSize:
                //                           MediaQuery.of(context).size.height *
                //                               0.03,
                //                           color: mainColor,
                //                           fontWeight: FontWeight.w300),
                //                     ),
                //                   )),
                //               Positioned(
                //                   top: MediaQuery.of(context).size.height * 0.035,
                //                   left: MediaQuery.of(context).size.height * 1.15,
                //                   child: Container(
                //                     child: Text(
                //                       "\$${data['amount']}",
                //                       style: TextStyle(
                //                           decoration: TextDecoration.none,
                //                           fontFamily: "DM Sans",
                //                           fontSize:
                //                           MediaQuery.of(context).size.height *
                //                               0.035,
                //                           color: Colors.green,
                //                           fontWeight: FontWeight.w300),
                //                     ),
                //                   )),
                //               Positioned(
                //                   top: MediaQuery.of(context).size.height * 0.1,
                //                   left: MediaQuery.of(context).size.height * 0.08,
                //                   child: Container(
                //                     height: MediaQuery.of(context).size.height *
                //                         0.003,
                //                     width:
                //                     MediaQuery.of(context).size.width * 0.57,
                //                     color: mainColor,
                //                   )),
                //               Positioned(
                //                 top: MediaQuery.of(context).size.height * 0.035,
                //                 left: MediaQuery.of(context).size.height * 0.08,
                //                 child: Text(
                //                   "${data['projectName']}",
                //                   style: TextStyle(
                //                       decoration: TextDecoration.none,
                //                       fontFamily: "DM Sans",
                //                       fontSize:
                //                       MediaQuery.of(context).size.height *
                //                           0.035,
                //                       color: mainColor,
                //                       fontWeight: FontWeight.w600),
                //                 ),
                //               ),
                //               Positioned(
                //                 top: MediaQuery.of(context).size.height * 0.22,
                //                 left: MediaQuery.of(context).size.height * 0.8,
                //                 child: Container(
                //                   height:
                //                   MediaQuery.of(context).size.height * 0.05,
                //                   width: MediaQuery.of(context).size.width * 0.1,
                //                   decoration: BoxDecoration(
                //                     color: Colors.red,
                //                     borderRadius: BorderRadius.circular(17),
                //                   ),
                //                   child: InkWell(
                //                     onTap: () {
                //                       setState(() {});
                //                     },
                //                     child: MaterialButton(
                //                       minWidth: MediaQuery.of(context).size.width,
                //                       padding: const EdgeInsets.fromLTRB(
                //                           20.0, 15.0, 20.0, 15.0),
                //                       onPressed: () async {
                //                         print("Post id:");
                //                         print(data['postid']);
                //                         DocumentReference docRef = FirebaseFirestore.instance.collection("posts").doc(data['postid']);
                //                         // DocumentSnapshot doc = await docRef.get();
                //                         docRef.update({
                //                           "withdrawalStatus": "Rejected",
                //                         });
                //                       },
                //                       child: Text(
                //                         "Reject",
                //                         style: TextStyle(
                //                             fontSize: MediaQuery.of(context)
                //                                 .size
                //                                 .height *
                //                                 0.025,
                //                             color: Colors.white,
                //                             fontWeight: FontWeight.w500),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 top: MediaQuery.of(context).size.height * 0.22,
                //                 left: MediaQuery.of(context).size.height * 1.04,
                //                 child: Container(
                //                   height:
                //                   MediaQuery.of(context).size.height * 0.05,
                //                   width: MediaQuery.of(context).size.width * 0.1,
                //                   decoration: BoxDecoration(
                //                     color: mainColor,
                //                     borderRadius: BorderRadius.circular(17),
                //                   ),
                //                   child: Center(
                //                     child: InkWell(
                //                       onTap: () {
                //                         setState(() {});
                //                       },
                //                       child: MaterialButton(
                //                         minWidth:
                //                         MediaQuery.of(context).size.width,
                //                         padding: const EdgeInsets.fromLTRB(
                //                             20.0, 15.0, 20.0, 15.0),
                //                         onPressed: () async {
                //                           print("Post id:");
                //                           print(data['postid']);
                //                           DocumentReference docRef = FirebaseFirestore.instance.collection("posts").doc(data['postid']);
                //                           DocumentSnapshot doc = await docRef.get();
                //                           var amountDue = doc['AmountDue'];
                //                           var amountEarned = doc['AmountEarned'];
                //                           var temp = amountDue;
                //                           amountDue = amountEarned;
                //                           amountEarned = temp;
                //                           docRef.update({
                //                             "AmountEarned": amountEarned,
                //                             "AmountDue": amountDue,
                //                             "withdrawalStatus": "Done",
                //                           });
                //                         },
                //                         child: Text(
                //                           "Approve",
                //                           style: TextStyle(
                //                               fontSize: MediaQuery.of(context)
                //                                   .size
                //                                   .height *
                //                                   0.025,
                //                               color: Colors.white,
                //                               fontWeight: FontWeight.w500),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   );
                // }

              }
              //return Text("Fetching Data from Database..");
              return const Text("");
            })),
      ),
    );
  }
}
