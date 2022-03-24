import 'package:flutter/material.dart';
import 'package:eyedata/main.dart';
import 'package:eyedata/screens/phone.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.black,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Opacity(
                      opacity: 0.3,
                      child:Image.asset('assets/imgs/main2.jpg',
                          fit: BoxFit.cover),)
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      const SizedBox(height: 50),
                      const Text('This app analyses your eyes and helps to detect '
                          'problems with minimal device use.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height:80),
                      Container(
                          margin:const EdgeInsets.only(left: 30,right:30,bottom:20),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child:Material(
                                  color:Colors.transparent,
                                  child: InkWell(
                                      splashColor:const Color(0xFF80C038).withOpacity(0.2),
                                      highlightColor:const Color(0xFF80C038).withOpacity(0.2),
                                      onTap:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:(context) =>PhoneScreen()
                                          )
                                        );
                                      },
                                      child:Container(
                                          padding:const EdgeInsets.all(30),
                                          child:const Text('Get Started',
                                              textAlign:TextAlign.center,
                                              style:TextStyle(
                                                  fontSize: 25,color:Color
                                                (0xFF80C038),
                                                  fontWeight:FontWeight.bold
                                              )
                                          ),
                                          decoration:BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color:Colors.transparent,
                                              border:Border.all(
                                                  color:Color(0xFF80C038),
                                                  width:4
                                              )
                                          )
                                      )
                                  )
                              )
                          )
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );

  }
}