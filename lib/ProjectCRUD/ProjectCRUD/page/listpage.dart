// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../models/employee.dart';
// import '../services/firebase_crud.dart';
// import 'addpage.dart';
// import 'editpage.dart';
//
// class ListPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ListPage();
//   }
// }
//
// class _ListPage extends State<ListPage> {
//   final Stream<QuerySnapshot> collectionReference = FirebaseCrud.readEmployee();
//   //FirebaseFirestore.instance.collection('Employee').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text("List of Employee"),
//         backgroundColor: Theme.of(context).primaryColor,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.app_registration,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               Navigator.pushAndRemoveUntil<dynamic>(
//                 context,
//                 MaterialPageRoute<dynamic>(
//                   builder: (BuildContext context) => AddPage(),
//                 ),
//                 (route) =>
//                     false, //if you want to disable back feature set to false
//               );
//             },
//           )
//         ],
//       ),
//       body: StreamBuilder(
//         stream: collectionReference,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasData) {
//             return Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: ListView(
//                 children: snapshot.data!.docs.map((e) {
//                   return Card(
//                       child: Column(children: [
//                     ListTile(
//                       title: Text(e["employee_name"]),
//                       subtitle: Container(
//                         child: (Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text("Position: " + e['position'],
//                                 style: const TextStyle(fontSize: 14)),
//                             Text("Contact Number: " + e['contact_no'],
//                                 style: const TextStyle(fontSize: 12)),
//                             Text("Email: " + e['email'],
//                                 style: const TextStyle(fontSize: 12)),
//                             ClipRRect(
//                               borderRadius: new BorderRadius.circular(50),
//                               child: Image(
//                                 height: 300,
//                                 width: 300,
//                                 image: NetworkImage(e['picture_url']),
//                               ),
//                             ),
//                           ],
//                         )),
//                       ),
//                     ),
//                     ButtonBar(
//                       alignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             padding: const EdgeInsets.all(5.0),
//                             primary: const Color.fromARGB(255, 143, 133, 226),
//                             textStyle: const TextStyle(fontSize: 20),
//                           ),
//                           child: const Text('Edit'),
//                           onPressed: () {
//                             Navigator.pushAndRemoveUntil<dynamic>(
//                               context,
//                               MaterialPageRoute<dynamic>(
//                                 builder: (BuildContext context) => EditPage(
//                                   employee: Employee(
//                                       uid: e.id,
//                                       employeename: e["employee_name"],
//                                       position: e["position"],
//                                       contactno: e["contact_no"],
//                                       email: e["email"],
//                                       picture: e["picture_url"],
//                                   ),
//                                 ),
//                               ),
//                               (route) =>
//                                   false, //if you want to disable back feature set to false
//                             );
//                           },
//                         ),
//                         TextButton(
//                           style: TextButton.styleFrom(
//                             padding: const EdgeInsets.all(5.0),
//                             primary: const Color.fromARGB(255, 143, 133, 226),
//                             textStyle: const TextStyle(fontSize: 20),
//                           ),
//                           child: const Text('Delete'),
//                           onPressed: () async {
//                             var response =
//                                 await FirebaseCrud.deleteEmployee(docId: e.id);
//                             if (response.code != 200) {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       content:
//                                           Text(response.message.toString()),
//                                     );
//                                   });
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ]));
//                 }).toList(),
//               ),
//             );
//           }
//
//           return Container();
//         },
//       ),
//     );
//   }
// }
