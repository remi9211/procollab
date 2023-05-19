import 'package:flutter/material.dart';
import 'package:procollab_web/CollaboratorHeaderFooter/footer.dart';
import 'package:procollab_web/CollaboratorHeaderFooter/headerpostsignin.dart';
import 'package:procollab_web/allposts/posts.dart';
import '../../../profile/profile.dart';
import '../../../profile/profilehome.dart';
import '../services/firebase_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// CollectionReference users = FirebaseFirestore.instance.collection("users");


class AddPage extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> data;

  AddPage({required this.documentId, required this.data});
  static const mainColor = Color(0xFF1C5D8B);
  static const secondaryColor = Color(0xFF3F83B4);

  static const fontFam = "DM Sans";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPage(documentId: documentId, data: data);
  }
}

class _AddPage extends State<AddPage> {
  final String documentId;
  final Map<String, dynamic> data;

  _AddPage({required this.documentId,  required this.data});

  final user = FirebaseAuth.instance.currentUser;

  List<String> userIDs = [];

  Future getDocIds() async {
    await FirebaseFirestore.instance.collection("users").get().then(
          (snapshot) =>
          snapshot.docs.forEach((document) {
            userIDs.add(document.reference.id);
          }),
    );
    print("UserIDs: $userIDs");
  }

  final _name = TextEditingController();
  final _projectname = TextEditingController();
  final _collaboratorsneeded = TextEditingController();
  final _area = TextEditingController();
  final _email = TextEditingController();
  final _AmountDue = TextEditingController();
  final _AmountEarned = TextEditingController();
  final _experience = TextEditingController();
  final _paihay = TextEditingController();
  final _projectdescription = TextEditingController();
  final _requirements = TextEditingController();
  final _responsibilites = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("userDocID: $documentId");
    final projectNameField = SizedBox(
      width: MediaQuery.of(context).size.width*0.25,
      child: TextFormField(
          maxLines: null,
          controller: _projectname,
          autofocus: false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
          },

          decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(80.0, 15.0, 20.0, 15.0),
              hintText: "ENTER PROJECT NAME HERE", hintStyle: TextStyle(color: AddPage.secondaryColor,),
              enabledBorder:
              UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.secondaryColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              ),


              focusedBorder:
              UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.mainColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              )

          )


      ),
    );



    final numofcolls =  Text("No. of Collaborators Required:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height*0.0225, color: AddPage.mainColor),);

    final collaboratorsNeededField = SizedBox(
      width: MediaQuery.of(context).size.width*0.05,
      child: TextFormField(
          controller: _collaboratorsneeded,
          autofocus: false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
          },
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(35.0, 15.0, 20.0, 15.0),
              hintText: "0", hintStyle: TextStyle(color: AddPage.secondaryColor,),
              enabledBorder:
              OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.secondaryColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              ),


              focusedBorder:
              OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.mainColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              )

          )
      ),
    );

    final OfferedAmount =  Text("Offered Amount:",style: TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height*0.0225, color: AddPage.mainColor),);

    final amountDueField = SizedBox(
      width: MediaQuery.of(context).size.width*0.05,
      child: TextFormField(
          controller: _AmountDue,
          autofocus: false,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'This field is required';
            }
          },
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: "\$0", hintStyle: TextStyle(color: AddPage.secondaryColor,),
              enabledBorder:
              OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.secondaryColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              ),


              focusedBorder:
              OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                    color: AddPage.mainColor,
                  )
                // borderRadius: BorderRadius.circular(32.0),
              )

          )
      ),
    );

    final experienceField = TextFormField(
        maxLines: null,
        controller: _experience,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Required Experience:", hintStyle: TextStyle(color: AddPage.secondaryColor,),
          enabledBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.secondaryColor,
              )

            // borderRadius: BorderRadius.circular(32.0),
          ),


          focusedBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.mainColor,
              )
            // borderRadius: BorderRadius.circular(32.0),
          )

      ),

      style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),
    );

    final projectDescriptionField = TextFormField(
        maxLines: null,
        controller: _projectdescription,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Project Description:", hintStyle: TextStyle(color: AddPage.secondaryColor,),
            enabledBorder:
            OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.5,
                  color: AddPage.secondaryColor,
                )

              // borderRadius: BorderRadius.circular(32.0),
            ),



            focusedBorder:
            OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2.5,
                  color: AddPage.mainColor,
                )
              // borderRadius: BorderRadius.circular(32.0),
            )

        ),

        style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),

    );

    final responsibilitiesField = TextFormField(
        maxLines: null,
        controller: _responsibilites,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }
        },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Responsibilities:", hintStyle: TextStyle(color: AddPage.secondaryColor,),
          enabledBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.secondaryColor,
              )

            // borderRadius: BorderRadius.circular(32.0),
          ),



          focusedBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.mainColor,
              )
            // borderRadius: BorderRadius.circular(32.0),
          )

      ),

      style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),
    );

    final requirementsField = TextFormField(
      maxLines: null,
      controller: _requirements,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          //contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Requirements:", hintStyle: TextStyle(color: AddPage.secondaryColor,),
          enabledBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.secondaryColor,
              )

            // borderRadius: BorderRadius.circular(32.0),
          ),



          focusedBorder:
          OutlineInputBorder(
              borderSide: BorderSide(
                width: 2.5,
                color: AddPage.mainColor,
              )
            // borderRadius: BorderRadius.circular(32.0),
          )

      ),

      style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),
    );

    // final backButton = Container(
    //   height: MediaQuery.of(context).size.height*0.04,
    //   width: MediaQuery.of(context).size.width*0.055,
    //   decoration: BoxDecoration(
    //     color: AddPage.secondaryColor,
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   child: const Center(
    //     child: Text(
    //       "Back",
    //       style: TextStyle(color: Colors.white),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );

    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: AddPage.mainColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width*0.06,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileMain()));
        },
        child: const Text(
          "Back",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: AddPage.mainColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width*0.06,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var ongoingprojects = int.parse("${data["ongoingprojects"]}") + 1;
            DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
            //DocumentSnapshot doc = await docRef.get();
            docRef.update({
              "ongoingprojects": ongoingprojects,
            });
            var response = await FirebaseCrud.addEmployee(
                documentId: documentId,
                name: "${data["name"]}",
                projectname: _projectname.text,
                collaboratorsneeded: _collaboratorsneeded.text,
                area: "${data["field"]}",
                email: user!.email!,
                AmountDue: _AmountDue.text,
                paihay: _AmountDue.text,
                AmountEarned: _AmountEarned.text,
                approval: "Pending",
                projectdescription: _projectdescription.text,
                experience: _experience.text,
                requirements: _requirements.text,
                responsibilities: _responsibilites.text,
            );
            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: const Text(
          "Post",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );

    //var mainColor = const Color(0xFF5364B8);
    var mainColor = Color(0xFF1C5D8B);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            headerpostsu(),
            Container(
              margin: const EdgeInsets.only(top: 75),
              height: MediaQuery.of(context).size.height*0.13,
              width: MediaQuery.of(context).size.width*0.65,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: Text("OFFER PROJECT",style: TextStyle(fontWeight: FontWeight.w600, fontSize: MediaQuery.of(context).size.height*0.06, color: Colors.white),)),
            ),


            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(50),
                width: MediaQuery.of(context).size.width*0.65,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: mainColor,
                      width: 5,
                    )
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,


                      children: [

                        Row(
                          children: <Widget>[
                            projectNameField,
                            SizedBox(width: MediaQuery.of(context).size.width*0.10,),
                            numofcolls,
                            const SizedBox(width: 10,),
                            collaboratorsNeededField,
                          ],
                        ),

                        const SizedBox(height: 20,),

                        Row(
                          children: <Widget>[
                            SizedBox(width: MediaQuery.of(context).size.width*0.415,),
                            OfferedAmount,
                            const SizedBox(width: 10,),
                            amountDueField,
                          ],
                        ),

                        const SizedBox(height: 50,),


                        Column(
                          children: <Widget>[
                            projectDescriptionField,
                            const SizedBox(height: 10,),
                            responsibilitiesField,
                            const SizedBox(height: 10,),
                            requirementsField,
                            const SizedBox(height: 10,),
                            experienceField,
                          ],
                        ),

                        SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                        Row(
                          children: <Widget>[
                            SizedBox(width: MediaQuery.of(context).size.width*0.44,),
                            backButton,
                            const SizedBox(width: 10,),
                            SaveButon,
                          ],
                        ),

                      ],

                    ),
                  ),
                ),
              ),
            ),

            const Collfooter(),
          ],
        ),
      ),
    );
  }
}
