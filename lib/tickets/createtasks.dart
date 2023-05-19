import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procollab_web/services/procollab_crud.dart';
import 'package:procollab_web/tickets/taskshome.dart';


class SPCreateTasks extends StatefulWidget{
  final String documentId;

  SPCreateTasks({required this.documentId});

  @override
  State<SPCreateTasks> createState() => _SPCreateTasksState();
}

class _SPCreateTasksState extends State<SPCreateTasks> {
  final _task_description = TextEditingController();
  final _task_name = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){

    var mainColor = const Color(0xFF5364B8);
    var secondaryColor = const Color(0xFF7886CB);
    CollectionReference tickets = FirebaseFirestore.instance.collection("tickets");
    return SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
            future: tickets.doc(widget.documentId).get(),
            builder: ((context, snapshot){
              print(widget.documentId);
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                var tasksname = data['tasksname'];
                var tasksdescription = data['tasksdescription'];
                var taskstatuses = data['taskstatuses'];
                var taskslength = tasksname.length;

                return Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.075),
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.075),
                  width: MediaQuery.of(context).size.width*0.65,
                  //height: 1000,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: mainColor,
                        width: 2.5,
                      )
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.025,top: MediaQuery.of(context).size.height*0.025),
                          child: Text("Welcome To ${data['projectname']} Project", style: TextStyle(decoration: TextDecoration.none, fontFamily: "DM Sans", fontSize: MediaQuery.of(context).size.height*0.03, color: mainColor, fontWeight: FontWeight.w700),)
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.003,
                        width: MediaQuery.of(context).size.width*0.55,
                        color: mainColor,
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.0185,top: MediaQuery.of(context).size.height*0.0185),
                          child: Text("Please define your tasks:", style: TextStyle(decoration: TextDecoration.none, fontFamily: "DM Sans", fontSize: MediaQuery.of(context).size.height*0.0275, color: mainColor, fontWeight: FontWeight.w700),)
                      ),
                      Container(
                          child: taskslength > 0 ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(taskslength, (index) {
                              return Container(
                                margin: EdgeInsets.only(left: 60, right: 70), // add left margin of 16 pixels
                                child: Row(
                                  children: [
                                    SizedBox(width: 10), // add some spacing between the icon and text
                                    Expanded(
                                      child: Text(
                                        "${tasksname[index]}: " + " ${tasksdescription[index]}",
                                        style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: "DM Sans",
                                          fontSize: MediaQuery.of(context).size.height * 0.025,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    IconTheme(
                                      data: IconThemeData(
                                        color: Colors.red,
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () async {
                                            DocumentReference docRef = FirebaseFirestore.instance.collection("tickets").doc(widget.documentId);
                                            // DocumentSnapshot doc = await docRef.get();
                                            setState(() {
                                              docRef.update({
                                                "tasksname": FieldValue.arrayRemove([data['tasksname'][index]]),
                                              });
                                              docRef.update({
                                                "taskstatuses": FieldValue.arrayRemove([data['taskstatuses'][index]]),
                                              });
                                              docRef.update({
                                                "tasksdescription": FieldValue.arrayRemove([data['tasksdescription'][index]]),
                                              });
                                            });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ):


                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: Text("No tasks defined yet!",
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontFamily: "DM Sans",
                                  fontSize: MediaQuery.of(context).size.height*0.018,
                                  //color: Colors.black,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          )

                      ),

                      Container(
                        child: Column(
                          children: [
                            taskslength > 0 ?
                            const Padding(
                              padding: EdgeInsets.only(top: 65.0),
                              child: Text("Add another task: ",
                                style: TextStyle(decoration: TextDecoration.none,
                                    fontFamily: "DM Sans",
                                    fontSize: 20,
                                    color: TaskHome.mainColor,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ):
                            const Padding(
                              padding: EdgeInsets.only(top:15.0),
                              child: Text("Add task",
                                style: TextStyle(decoration: TextDecoration.none,
                                    fontFamily: "DM Sans",
                                    fontSize: 20,
                                    color: TaskHome.mainColor,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 25.0),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.25,
                                        child: TextFormField(
                                            controller: _task_name,
                                            autofocus: false,
                                            validator: (value) {
                                              if (value == null || value.trim().isEmpty) {
                                                return 'This field is required';
                                              }
                                            },

                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.fromLTRB(80.0, 15.0, 20.0, 15.0),
                                                hintText: "ENTER TASK NAME HERE", hintStyle: TextStyle(color: TaskHome.secondaryColor,),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2.5,
                                                      color: TaskHome.secondaryColor,
                                                    )
                                                  // borderRadius: BorderRadius.circular(32.0),
                                                ),


                                                focusedBorder:
                                                UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 2.5,
                                                      color: TaskHome.mainColor,
                                                    )
                                                  // borderRadius: BorderRadius.circular(32.0),
                                                )

                                            )


                                        ),
                                      ),
                                      const SizedBox(height: 25.0),
                                      TextFormField(
                                        controller: _task_description,
                                        autofocus: false,
                                        validator: (value) {
                                          if (value == null || value.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                        },
                                        decoration: const InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                                            //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                            hintText: "Task Description:", hintStyle: TextStyle(color: TaskHome.secondaryColor,),
                                            enabledBorder:
                                            OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2.5,
                                                  color: TaskHome.secondaryColor,
                                                )
                                            ),



                                            focusedBorder:
                                            OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2.5,
                                                  color: TaskHome.mainColor,
                                                )
                                              // borderRadius: BorderRadius.circular(32.0),
                                            )

                                        ),

                                        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),

                                      ),
                                      const SizedBox(height: 25.0),
                                      Material(
                                        elevation: 5.0,
                                        borderRadius: BorderRadius.circular(30.0),
                                        color: secondaryColor,
                                        child: MaterialButton(
                                          minWidth: MediaQuery.of(context).size.width*0.15,
                                          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                          onPressed: () async {
                                            setState(() {

                                            });

                                            tasksname.add(_task_name.text);
                                            tasksdescription.add(_task_description.text);
                                            taskstatuses.add("Pending");

                                            FirebaseCrud.updateTasks(
                                                docId: widget.documentId,
                                                tasksname: _task_name.text,
                                                tasksdescription: _task_description.text,
                                                taskstatuses: taskstatuses
                                            );

                                          },
                                          child: const Text(
                                            "Save",
                                            style:
                                            TextStyle(color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15.0),
                                    ],
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
                //);
              }
              //return Text("Fetching Data from Database..");
              return const Text("");
            })),
        );
    }
}

