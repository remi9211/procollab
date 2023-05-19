import 'package:flutter/material.dart';
import 'package:procollab_web/allposts/posts.dart';
import 'package:procollab_web/earnings/Earnings.dart';
import 'package:procollab_web/progress/editpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import '../profile/profilehome.dart';
import '../progress/home.dart';
import '../progress/progresshome.dart';

class Adminheaderpostsu extends StatefulWidget {
  const Adminheaderpostsu({Key? key}) : super(key: key);

  @override
  State<Adminheaderpostsu> createState() => _AdminheaderpostsuState();
}

class _AdminheaderpostsuState extends State<Adminheaderpostsu> {

  var mainColor = const Color(0xFF1C5D8B);
  var secondaryColor = const Color(0xFF3F83B4);
  static const fontFamily = "DM Sans";

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(

          child: Row(

            children: [
              Stack(

                children: <Widget>[
                  Positioned(

                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.5,
                      color:  mainColor,

                      child: CustomPaint(
                        painter: CurvePainter(),
                      ),
                    ),
                  ),

                  Positioned(
                      top : MediaQuery.of(context).size.height*0.03,
                      left: MediaQuery.of(context).size.width*0.17,

                      child: const Text("PROCOLLAB",
                        style: TextStyle(color: Colors.white,fontFamily: fontFamily, fontSize: 25, fontWeight: FontWeight.bold),)
                  ),

                  Positioned(
                      top : MediaQuery.of(context).size.height*0.0331,
                      left: MediaQuery.of(context).size.width*0.75,

                      child: InkWell(
                        onTap: (){
                          FirebaseAuth.instance.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                        },
                        child: Text("LOGOUT",
                          style: TextStyle(color: Colors.white,fontFamily: fontFamily, fontSize: MediaQuery.of(context).size.height*0.020, fontWeight: FontWeight.bold),),
                      )
                  ),

                  Positioned(
                    top : MediaQuery.of(context).size.height*0.15,
                    left: MediaQuery.of(context).size.width*0.17,

                    child: const CircleAvatar(
                      backgroundImage: AssetImage("happy-bearded-young-man.jpg"),
                      radius: 50,
                    ),
                  ),

                  Positioned(
                      top : MediaQuery.of(context).size.height*0.18,
                      left: MediaQuery.of(context).size.width*0.23,

                      child: Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),

                        child: const Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 10.0, left: 30.0, right: 30.0),

                          child: Center(child: Text("Welcome!",style: (TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )),)),
                        ),
                      )
                  ),

                  Positioned(
                      top : MediaQuery.of(context).size.height*0.28,
                      left: MediaQuery.of(context).size.width*0.17,

                      child: Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),

                        child: const Padding(
                          padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 40.0, right: 40.0),

                          child: Center(child: Text("Work Better Together",style: (TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          )),)),
                        ),
                      )
                  ),

                  Positioned(
                      top : MediaQuery.of(context).size.height*0.335,
                      left: MediaQuery.of(context).size.width*0.17,

                      child: Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: mainColor,
                        ),

                        child: const Padding(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 20.0, right: 20.0),

                          child: Center(child: Text("Let's Begin",style: (TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          )),)),
                        ),
                      )
                  ),

                  Positioned(
                    top : MediaQuery.of(context).size.height*0.13,
                    left: MediaQuery.of(context).size.width*0.7,

                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("procollabAdmin.png"),
                      radius: 150,
                    ),
                  ),
                ],
              ),

            ],
          ),


        ),

      ),
    );
  }


}




class CurvePainter extends CustomPainter {
  static const secondaryColor = Color(0xFF3F83B4);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = secondaryColor;
    paint.style = PaintingStyle.stroke;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.04,
        size.width * 0.5, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.65);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
