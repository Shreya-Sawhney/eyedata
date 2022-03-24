import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:eyedata/screens/phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as ip;


class AnalysisOneScreen extends StatefulWidget {
  final File? imageGetRight;
  final File? imageGetLeft;

  const AnalysisOneScreen({required this.imageGetRight, required this.imageGetLeft});

  @override
  _AnalysisOneScreenState createState() => _AnalysisOneScreenState();
}

class _AnalysisOneScreenState extends State<AnalysisOneScreen> {
  String leftDet = "No";
  String rightDet = "No";
  var leftImg;
  var rightImg;

  @override
  void initState() {
    super.initState();
    loadDet();
  }

  void loadDet() async {
    await detectOD(1);
    await detectOD(2);
  }

  Future detectOD(int s) async {
    var url = 'http://10.237.22.173:5000/';
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(url));

    if (s == 1) {
      request.files.add(
          await http.MultipartFile.fromPath(
            'Images',
            widget.imageGetLeft!.path,
          )
      );
    }

    else {
      request.files.add(
          await http.MultipartFile.fromPath(
            'Images',
            widget.imageGetRight!.path,
          )
      );
    }

    http.StreamedResponse r = await request.send();
    print(r.statusCode);
    var data = await r.stream.bytesToString();
    print(data);

    // await Future.delayed(const Duration(seconds: 2), (){});
    // var data = "0 10 20 500 500 90";

    var x0 = (double.parse(data.split(" ")[1])*100).round();
    var y0 = (double.parse(data.split(" ")[2])*100).round();
    var w = (double.parse(data.split(" ")[3])*100).round();
    var h = (double.parse(data.split(" ")[4])*100).round();

    if (s == 1) {
      setState(() {
        leftDet = data;
        final image = ip.decodeImage(widget.imageGetLeft!.readAsBytesSync());
        print("Height = ${image?.height} width = ${image?.width}");
        int? width = ((image?.width)! / 100).round();
        int? height = ((image?.height)! / 100).round();
        print("x0 = ${x0} width = ${width!}");
        x0 = (x0 * width!) - (((w * width)! / 2).round());
        y0 = (y0 * height!) - (((h * height)! / 2).round());
        print("x0 = ${x0} width = ${width!}");
        leftImg = ip.encodeJpg(ip.drawRect(image!, x0, y0, (x0) + w * width!, (y0) + h * height!, ip.Color.fromRgb(0, 255, 0)));
      });
    }
    else {
      setState(() {
        rightDet = data;
        final image = ip.decodeImage(widget.imageGetRight!.readAsBytesSync());
        int? width = ((image?.width)! / 100).round();
        int? height = ((image?.height)! / 100).round();
        x0 = (x0 * width!) - (((w * width)! / 2).round());
        y0 = (y0 * height!) - (((h * height)! / 2).round());
        rightImg = ip.encodeJpg(ip.drawRect(image!, x0, y0, (x0) + w * width!, (y0) + h * height!, ip.Color.fromRgb(0, 255, 0)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Optical Disk'),
      ),
      resizeToAvoidBottomInset: false ,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              children: <Widget>[
                Container(
                    margin:const EdgeInsets.only(top:10,bottom:20),
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - 60) / 2,
                    //color: Colors.lightGreen[100],
                    child: leftImg != null
                        ? Center(
                      child: Image.memory(
                        Uint8List.fromList(leftImg),
                        // width: 300,
                        // height: 300,
                        fit: BoxFit.contain,
                        // height: MediaQuery.of(context).size.height - 233,
                      ),
                    )
                        : const Center(
                      child: Center(child: CircularProgressIndicator()),
                    )),
                Container(
                    margin:const EdgeInsets.only(top:10,bottom:20),
                    width: MediaQuery.of(context).size.width,
                    height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height - 60) / 2,
                    //color: Colors.lightGreen[100],
                    child: rightImg != null
                        ? Center(
                      child: Image.memory(
                        Uint8List.fromList(rightImg),
                        // width: 300,
                        // height: 300,
                        fit: BoxFit.contain,
                        //height: MediaQuery.of(context).size.height - 233,
                      ),
                    )
                        : const Center(
                      child: Center(child: CircularProgressIndicator()),
                    )),
              ]
          ),
        ],
      ),
    );
  }
}