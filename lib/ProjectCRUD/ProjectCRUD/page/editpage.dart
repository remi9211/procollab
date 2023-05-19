
import 'package:flutter/material.dart';
import 'package:procollab_web/ProjectCRUD/ProjectCRUD/page/addpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/employee.dart';
import '../services/firebase_crud.dart';
import 'listpage.dart';

class EditPage extends StatefulWidget {
  final Post? post;
  EditPage({this.post});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPage();
  }
}

class _EditPage extends State<EditPage> {
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
  final _docid = TextEditingController();


  final user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.post!.uid.toString());
    _name.value = TextEditingValue(text: widget.post!.name.toString());
    _projectname.value = TextEditingValue(text: widget.post!.projectname.toString());
    _collaboratorsneeded.value = TextEditingValue(text: widget.post!.collaboratorsneeded.toString());
    _email.value = TextEditingValue(text: widget.post!.email.toString());
    _AmountDue.value = TextEditingValue(text: widget.post!.AmountDue.toString());
    _AmountEarned.value = TextEditingValue(text: widget.post!.AmountEarned.toString());
    _paihay.value = TextEditingValue(text: widget.post!.paihay.toString());
    _responsibilites.value = TextEditingValue(text: widget.post!.responsibilities.toString());
    _requirements.value = TextEditingValue(text: widget.post!.requirements.toString());
    _projectdescription.value = TextEditingValue(text: widget.post!.projectdescription.toString());
    _area.value = TextEditingValue(text: widget.post!.area.toString());
    _experience.value = TextEditingValue(text: widget.post!.experience.toString());

  }
  var name;
  var area;

  @override
  Widget build(BuildContext context) {
    if(user!.email! == "arhamlatif54@gmail.com"){
      name = "Arham Latif";
      area = "Web Developer";
    }
    else if(user!.email! == "salihashahzad@gmail.com"){
      name = "Saliha Shahzad";
      area = "UI/UX Designer";
    }
    else if(user!.email! == "nooraizasghar@gmail.com"){
      name = "Nooraiz Asghar";
      area = "Front End Developer";
    }

    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Document ID",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));


    final projectNameField = SizedBox(
      width: MediaQuery.of(context).size.width*0.25,
      child: TextFormField(
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






    // final amountEarnedField = TextFormField(
    //     controller: _AmountEarned,
    //     autofocus: false,
    //     validator: (value) {
    //       if (value == null || value.trim().isEmpty) {
    //         return 'This field is required';
    //       }
    //     },
    //     decoration: InputDecoration(
    //         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Amount Earned",
    //         border:
    //         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)
    //         )
    //     )
    // );





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







    // final paihayField = TextFormField(
    //     controller: _paihay,
    //     autofocus: false,
    //     validator: (value) {
    //       if (value == null || value.trim().isEmpty) {
    //         return 'This field is required';
    //       }
    //     },
    //     decoration: InputDecoration(
    //         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //         hintText: "Offered Amount",
    //         border:
    //         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));







    final projectDescriptionField = TextFormField(
      // maxLines: null,
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

    // final SaveButton = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Theme.of(context).primaryColor,
    //   child: MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width,
    //     padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () async {
    //       if (_formKey.currentState!.validate()) {
    //         var response = await FirebaseCrud.updatePost(
    //             docId: _docid.text,
    //             projectname: _projectname.text,
    //             collaboratorsneeded: _collaboratorsneeded.text,
    //             area: _area.text,
    //             email: _email.text,
    //             AmountDue: _AmountDue.text,
    //             AmountEarned: _AmountEarned.text,
    //             experience: _experience.text,
    //             paihay: _AmountDue.text,
    //             projectdescription: _projectdescription.text,
    //             requirements: _requirements.text,
    //             responsibilities: _responsibilites.text,
    //             name: _name.text
    //         );
    //         if (response.code != 200) {
    //           showDialog(
    //               context: context,
    //               builder: (context) {
    //                 return AlertDialog(
    //                   content: Text(response.message.toString()),
    //                 );
    //               });
    //         } else {
    //           showDialog(
    //               context: context,
    //               builder: (context) {
    //                 return AlertDialog(
    //                   content: Text(response.message.toString()),
    //                 );
    //               });
    //         }
    //       }
    //     },
    //     child: Text(
    //       "Update",
    //       style: TextStyle(color: Theme.of(context).primaryColorLight),
    //       //textAlign: TextAlign.center,
    //     ),
    //   ),
    // );

    final SaveButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: AddPage.mainColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width*0.1,

        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrud.updatePost(
                docId: _docid.text,
                projectname: _projectname.text,
                collaboratorsneeded: _collaboratorsneeded.text,
                area: _area.text,
                email: _email.text,
                AmountDue: _AmountDue.text,
                AmountEarned: _AmountEarned.text,
                experience: _experience.text,
                paihay: _AmountDue.text,
                projectdescription: _projectdescription.text,
                requirements: _requirements.text,
                responsibilities: _responsibilites.text,
                name: _name.text
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
          "Update Post",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
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
                      // DocIDField,
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                  Row(
                    children: <Widget>[
                      SizedBox(width: MediaQuery.of(context).size.width*0.27,),
                      const SizedBox(width: 10,),
                      SaveButton,
                    ],
                  ),



                ],

              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   }
// }
