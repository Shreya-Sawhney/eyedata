import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:eyedata/screens/phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'analysisOne.dart';

class AnalyseScreen extends StatefulWidget {
  final File? imageGetRight;
  final File? imageGetLeft;

  const AnalyseScreen({required this.imageGetRight, required this.imageGetLeft});

  @override
  _AnalyseScreenState createState() => _AnalyseScreenState();
}

class _AnalyseScreenState extends State<AnalyseScreen> {

  // void detectOD() async {
  //   var url = 'http://10.237.22.173:5000/';
  //   http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));
  //
  //   request.files.add(
  //     await http.MultipartFile.fromPath(
  //       'Images',
  //       widget.imageGetRight!.path,
  //     )
  //   );
  //
  //   http.StreamedResponse r = await request.send();
  //   print(r.statusCode);
  //   var data = await r.stream.bytesToString();
  //   print(data);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Analyse'),
      ),
      resizeToAvoidBottomInset: false ,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
              margin:const EdgeInsets.only(top:10,bottom:20),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 5,
              //color: Colors.lightGreen[100],
              child: widget.imageGetLeft != null
                  ? Center(
                child: Image.file(
                  widget.imageGetLeft!,
                  width: 300,
                  height: 300,
                ),
              )
                  : const Center(
                child: Text('No image'),
              )),
              Container(
              margin:const EdgeInsets.only(top:10,bottom:20),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 5,
              //color: Colors.lightGreen[100],
              child: widget.imageGetRight != null
                  ? Center(
                child: Image.file(
                  widget.imageGetRight!,
                  width: 300,
                  height: 300,
                ),
              )
                  : const Center(
                child: Text('No image'),
              )),
            ]
          ),
          Align(
              alignment: Alignment.center,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 25, color: Colors.black),
                      ),
                      onPressed: (){
                        // Navigator.pushAndRemoveUntil(context,
                        //   MaterialPageRoute(builder: (context) => PhoneScreen()),
                        //       (Route<dynamic> route) => false,
                        // );
                        //detectOD();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder:(context) => AnalysisOneScreen(imageGetRight: widget.imageGetRight, imageGetLeft: widget.imageGetLeft)
                            )
                        );
                      },
                      child: const Text('Optical Disk'),
                    ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     textStyle: const TextStyle(fontSize: 25, color: Colors.black),
                    //   ),
                    //   onPressed: (){
                    //     SystemNavigator.pop();
                    //   },
                    //   child: const Text('Exit'),
                    // ),
                  ]
              )
          ),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.black,
            height: 70,
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    onPressed: (){
                      Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) => PhoneScreen()),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text('Take Another'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 25, color: Colors.black),
                    ),
                    onPressed: (){
                      SystemNavigator.pop();
                    },
                    child: const Text('Exit'),
                  ),
                ]
              )
            )
          )
        ],
      ),
    );
  }
}