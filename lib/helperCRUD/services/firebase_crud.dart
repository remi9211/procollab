import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import '../models/response.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _contributorCollection = FirebaseFirestore.instance.collection("contributorrequest");
final CollectionReference _ticketsCollection = FirebaseFirestore.instance.collection("tickets");

class FirebaseCrud {

  static Future<Response> addTasksPerContributor({
    required String documentId,
    required String userId,
    required String projectName,
    required String userEmail,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _ticketsCollection.doc(documentId+userId);
    print("interested collab crud");
    print(documentId+userId);

    Map<String, dynamic> data = <String, dynamic>{
      "CollaboratorsEmail": List.generate(0, (r) => userEmail),
      "tasksname": List.generate(0, (r) => ""),
      "taskstatuses": List.generate(0, (r) => ""),
      "tasksdescription": List.generate(0, (r) => ""),
      "projectname": projectName,
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Request made successfully";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> addContributor({
    required String projectId,
    required String contributorId,
    required String projectName,
    required String email,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _contributorCollection.doc(projectId);

    Map<String, dynamic> data = <String, dynamic>{
      "contributors": FieldValue.arrayUnion([contributorId]),
      "email": email,
      "projectName": projectName,
      "contributorStatus": "Pending",
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Request made successfully";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> addDispute({
    required String projectName,
    required String description,
    required String reason,
    required String accountNumber,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _firestore.collection('disputes').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "projectName": projectName,
      "description": description,
      "reason": reason,
      "accountNumber": accountNumber,
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Dispute filed!";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> addWithdrawalRequest({
    required String projectName,
    required String amount,
    required String collaboratorEmail,
    required String requestedBy,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _firestore.collection('withdrawalrequest').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "projectName": projectName,
      "amount": amount,
      "collaboratorEmail": collaboratorEmail,
      "requestedBy": requestedBy,
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Request made successfully";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  // static Future<Response> addContributor({
  //   required String projectId,
  //   required String contributorId,
  //   required String projectName,
  //   required String email,
  // }) async {
  //
  //   Response response = Response();
  //   DocumentReference documentReferencer =
  //   _contributorCollection.doc(projectId);
  //
  //   //DocumentReference docRef = FirebaseFirestore.instance.collection("contributorrequest").doc(documentId);
  //   //DocumentSnapshot doc = await docRef.get();
  //   // documentReferencer.update({
  //   //   "contributors": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid]),
  //   //   "email": email,
  //   //   "projectName": projectName,
  //   // });
  //
  //   Map<String, dynamic> data = <String, dynamic>{
  //     "contributors": FieldValue.arrayUnion([contributorId]),
  //     "email": email,
  //     "projectName": projectName,
  //   };
  //
  //
  //     var result = await documentReferencer
  //       .set(data)
  //       .whenComplete(() {
  //     response.code = 200;
  //     response.message = "Request made successfully";
  //   })
  //       .catchError((e) {
  //     response.code = 500;
  //     response.message = e;
  //   });
  //
  //   return response;
  // }

  static Future<Response> updateCollaborators({
    required String name,
    required String docId,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _firestore.collection('posts').doc(docId);

    DocumentSnapshot doc = await documentReferencer.get();
    Map<String, dynamic> data2 = doc.data() as Map<String, dynamic>;

    Map<String, dynamic> data = <String, dynamic>{
      "paymentStatus": FieldValue.arrayUnion(data2["paymentStatus"]),
      "AmountDue": data2["AmountDue"],
      "AmountEarned": data2["AmountEarned"],
      "Collaborators": FieldValue.arrayUnion(data2["Collaborators"]),
      "InterestedCollabs": FieldValue.arrayUnion(data2["InterestedCollabs"]),
      "ProjectStatus": data2["ProjectStatus"],
      "approval": data2["approval"],
      "area": data2["area"],
      "collaboratorsneeded": data2["collaboratorsneeded"],
      "email": data2["email"],
      "experience": data2["experience"],
      "field": FieldValue.arrayUnion(data2["field"]),
      "name": data2["name"],
      "paihay": data2["paihay"],
      "progress": data2["progress"],
      "projectdescription": data2["projectdescription"],
      "projectname": data2["projectname"],
      "requirements": data2["requirements"],
      "responsibilities": data2["responsibilities"],
      "tasksname": FieldValue.arrayUnion(data2["tasksname"]),
      "taskstatuses": FieldValue.arrayUnion(data2["taskstatuses"]),
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Request made successfully";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> updatePaymentStatus({
    required String docId,
    required int updateIndex,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _firestore.collection('posts').doc(docId);

    DocumentReference docRef = FirebaseFirestore.instance.collection("posts").doc(docId);
    DocumentSnapshot doc = await docRef.get();
    var paymentStatus = doc['paymentStatus'];
    print("Payment Status $paymentStatus");
    paymentStatus[updateIndex] = "Done";
    print("Payment Status $paymentStatus");
    docRef.update({
      "paymentStatus": paymentStatus,
    });

    // DocumentSnapshot doc = await documentReferencer.get();
    // Map<String, dynamic> data2 = doc.data() as Map<String, dynamic>;
    // List getpaymentStatusArray = data2["paymentStatus"];
    // print("firebase array: $getpaymentStatusArray");
    // List updatedPaymentStatusArray = getpaymentStatusArray;
    // updatedPaymentStatusArray[updateIndex] = "Done";
    // print("firebase array: $updatedPaymentStatusArray");
    //
    //
    // Map<String, dynamic> data = <String, dynamic>{
    //   "paymentStatus": FieldValue.delete(),
    //   "paymentStatus": FieldValue.arrayUnion(updatedPaymentStatusArray),
    //   "AmountDue": data2["AmountDue"],
    //   "AmountEarned": data2["AmountEarned"],
    //   "Collaborators": FieldValue.arrayUnion(data2["Collaborators"]),
    //   "ProjectStatus": data2["ProjectStatus"],
    //   "approval": data2["approval"],
    //   "area": data2["area"],
    //   "collaboratorsneeded": data2["collaboratorsneeded"],
    //   "email": data2["email"],
    //   "experience": data2["experience"],
    //   "name": data2["name"],
    //   "paihay": data2["paihay"],
    //   "progress": data2["progress"],
    //   "projectdescription": data2["projectdescription"],
    //   "projectname": data2["projectname"],
    //   "requirements": data2["requirements"],
    //   "responsibilities": data2["responsibilities"],
    // };

    // var result = await documentReferencer
    //     .set(data)
    //     .whenComplete(() {
    //   response.code = 200;
    //   response.message = "Request made successfully";
    // })
    //     .catchError((e) {
    //   response.code = 500;
    //   response.message = e;
    // });

    return response;
  }


}