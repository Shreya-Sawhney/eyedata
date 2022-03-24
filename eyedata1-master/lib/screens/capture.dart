import 'dart:io';
import 'package:eyedata/screens/analyse.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CaptureScreen extends StatefulWidget {
  final String userName;
  final String saveDataText;
  const CaptureScreen({required this.userName, required this.saveDataText});

  @override
  _CaptureScreenState createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  File? imageGet;
  File? imageGetRight;
  File? imageGetLeft;

  int previewFlagRight = 0;
  int previewFlagLeft = 0;

  Future getImageCamera(int pos) async {
    final p = await getTemporaryDirectory();
    final name = DateTime.now();
    var nameList = name.toString().split(" ");
    String newName = nameList[0]+"_"+nameList[1];

    File? imagePathRight;
    File? imagePathLeft;
    String tempPath;
    if(pos == 1) {
      final imageGetRight = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageGetRight == null) return;
      imagePathRight = File(imageGetRight.path);
      //print("imagePath $imagePath");

      tempPath = p.path + "/" + newName + "_RIGHT" + ".jpg";
      imageGetRight.saveTo(tempPath);
      this.imageGetRight = imagePathRight;
      this.previewFlagRight = 1;
    }

    else {
      final imageGetLeft = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageGetLeft == null) return;
      imagePathLeft = File(imageGetLeft.path);
      //print("imagePath $imagePath");

      tempPath = p.path + "/" + newName + "_LEFT" + ".jpg";
      imageGetLeft.saveTo(tempPath);
      this.imageGetLeft = imagePathLeft;
      this.previewFlagLeft = 1;
    }

    setState(() {
      GallerySaver.saveImage(tempPath, albumName: "Fundus/${widget.saveDataText}");
    });
  }
  Future getVideoCamera(int pos) async {
    final imageGet = await ImagePicker().pickVideo(source: ImageSource.camera);

    if (imageGet == null) return;
    final imagePath = File(imageGet.path);
    final p = await getTemporaryDirectory();
    final name = DateTime.now();
    var nameList = name.toString().split(" ");
    String newName = nameList[0]+"_"+nameList[1];

    String tempPath;
    if(pos == 1) {
      tempPath = p.path + "/" + newName + "_RIGHT" + ".jpg";
      imageGet.saveTo(tempPath);
      this.previewFlagRight = 2;
    }
    else {
      tempPath = p.path + "/" + newName + "_LEFT" + ".jpg";
      imageGet.saveTo(tempPath);
      this.previewFlagLeft = 2;
    }
    setState(() {
      this.imageGet = imagePath;
      GallerySaver.saveVideo(imageGet.path, albumName: "Fundus/${widget.saveDataText}");
    });
  }
  Future getImageGallery(int pos) async {

    File? imagePathLeft;
    File? imagePathRight;
    if (pos == 1) {
      final imageGetRight = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageGetRight == null) return;
      imagePathRight = File(imageGetRight.path);
      this.imageGetRight = imagePathRight;
      previewFlagRight = 3;
    }

    else {
      final imageGetLeft = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageGetLeft == null) return;
      imagePathLeft = File(imageGetLeft.path);
      this.imageGetLeft = imagePathLeft;
      previewFlagLeft = 3;
    }

    setState(() {
      //this.imageGet = imagePath;
      //GallerySaver.saveImage(imageGet.path, albumName: "Fundus/${widget.userName}");
    });
  }
  Future getVideoGallery(int pos) async {
    final imageGet = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (imageGet == null) return;
    final imagePath = File(imageGet.path);

    setState(() {
      //this.imageGet = imagePath;
     // GallerySaver.saveVideo(imageGet.path, albumName: "Fundus/${widget
        //  .userName}");
    });
  }

  Widget cameraImageMenu() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[100],
                child: imageGetLeft != null && previewFlagLeft == 1
                    ? Center(
                  child: Image.file(
                    imageGetLeft!,
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No image'),
                )),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black,
              child:
              PopupMenuButton(
                  onSelected: (result) {
                    if (result == 1) {
                      getImageCamera(1);
                    }
                    if (result == 2) {
                      getImageCamera(2);
                    }
                  },

                  icon: const Icon(Icons.camera, semanticLabel: "Image from Camera",),


                  tooltip: "Image from Camera",

                  // tooltip: "Image",
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Right Eye"),
                      value: 1,

                    ),
                    const PopupMenuItem(
                      child: Text("Left Eye"),
                      value: 2,
                    ),
                  ]
              ),
            ),
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[100],
                child: imageGetRight != null && previewFlagRight == 1
                    ? Center(
                  child: Image.file(
                    imageGetRight!,
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No image'),
                )),
          ],
        ),
      ),
    );
  }
  Widget cameraVideoMenu() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[200],
                child: imageGet != null && previewFlagLeft == 2
                    ?  const Center(
                  child: Text('Video Selected'),
                )
                    : const Center(
                  child: Text('No video'),
                )),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black,
              child:
              PopupMenuButton(
                  onSelected: (result) {
                    if (result == 1) {
                      getVideoCamera(1);
                    }
                    if (result == 2) {
                      getVideoCamera(2);
                    }
                  },
                  icon:  const Icon(Icons.videocam,),
                  tooltip: "Video from Camera",

                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Right Eye"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Left Eye"),
                      value: 2,
                    ),
                  ]
              ),
            ),
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[200],
                child: imageGet != null && previewFlagRight == 2
                    ? Center(
                  child: Image.asset('assets/imgs/camera.png',
                      width: 300,
                      height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No video'),
                )),
          ],
        ),
      ),
    );
  }
  Widget galleryImageMenu() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[300],
                child: imageGetLeft != null && previewFlagLeft == 3
                    ? Center(
                  child: Image.file(
                    imageGetLeft!,
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No image'),
                )),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black,
              child:
              PopupMenuButton(
                  onSelected: (result) {
                    if (result == 1) {
                      getImageGallery(1);
                    }
                    if (result == 2) {
                      getImageGallery(2);
                    }
                  },

                  icon: const Icon(Icons.photo_album),

                  tooltip: "Image from Gallery",

                  // tooltip: "Image",
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Right Eye"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Left Eye"),
                      value: 2,
                    ),
                  ]
              ),
            ),
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[300],
                child: imageGetRight != null && previewFlagRight == 3
                    ? Center(
                  child: Image.file(imageGetRight!,
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No image'),
                )),
          ],
        ),
      ),
    );
  }
  Widget galleryVideoMenu() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[400],
                child: imageGetLeft != null && previewFlagLeft == 4
                    ? Center(
                  child: Image.asset('asset/imgs/main2.jpg',
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No video'),
                )),
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black,
              child:
              PopupMenuButton(
                  onSelected: (result) {
                    if (result == 1) {
                      getVideoGallery(1);
                    }
                    if (result == 2) {
                      getVideoGallery(1);
                    }
                  },

                  icon: const Icon(Icons.video_library_rounded),

                  tooltip: "Video from Gallery",

                  // tooltip: "Image",
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Right Eye"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Left Eye"),
                      value: 2,
                    ),
                  ]
              ),
            ),
            Container(
                margin:const EdgeInsets.only(top:10,bottom:20),
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height,
                color: Colors.lightGreen[400],
                child: imageGetRight != null && previewFlagLeft == 4
                    ? Center(
                  child: Image.file(
                    imageGetRight!,
                    width: 300,
                    height: 300,
                  ),
                )
                    : const Center(
                  child: Text('No video'),
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        automaticallyImplyLeading: true,
        title: Text('Welcome ${widget.userName}'),
      ),
      resizeToAvoidBottomInset: false ,

      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
          children: <Widget>[
              Container(
                  height: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.102)*0.2,
                  width: double.infinity,
                  //padding: const EdgeInsets.all(15),
                  color: Colors.lightGreen[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Center (
                          child: Text("\nImage from Camera",
                            textAlign: TextAlign.center,
                          )
                      ),
                      cameraImageMenu(),
                    ],
                  ),
                ),
              Container(
                  height: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.102)*0.2,
                  width: double.infinity,
                  //padding: const EdgeInsets.all(15),
                  color: Colors.lightGreen[200],

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Center (
                          child: Text("\nVideo from Camera",
                            textAlign: TextAlign.center,
                          )
                      ),
                      cameraVideoMenu(),
                    ],
                  ),
                ),
              Container(
                  height: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.102)*0.2,
                  width: double.infinity,
                  //padding: const EdgeInsets.all(15),
                  color: Colors.lightGreen[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Center(
                        child:  Text("\nImage from Gallery",textAlign:
                        TextAlign.center, ),),
                      galleryImageMenu(),
                    ],
                  ),
                ),
              Container(
                  height: (MediaQuery.of(context).size.height-MediaQuery.of(context).size.height*0.102)*0.2,
                  width: double.infinity,
                  //padding: const EdgeInsets.all(15),
                  color: Colors.lightGreen[400],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Center(
                        child:  Text("\nVideo from Gallery",
                          textAlign: TextAlign.center, ),
                      ),
                      galleryVideoMenu(),
                    ],
                  ),
                ),
              ]
          ),
          Container(
            padding: const EdgeInsets.only(left: 80, right: 80, bottom: 50),
            child: ElevatedButton(
              child: const Text("Analyse"),
                onPressed: (){
                  if(imageGetRight != null && imageGetLeft != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:(context) => AnalyseScreen(imageGetRight: imageGetRight, imageGetLeft: imageGetLeft)
                        )
                    );
                  }
                  else {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.showSnackBar(SnackBar(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: const Text("Select Images!",
                        style: TextStyle(color: Colors.red),
                      ),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                }, style:
              ElevatedButton.styleFrom(
              fixedSize: const Size(180, 60),
              primary: const Color(0xFF80C038),
              textStyle: const TextStyle(fontSize: 26),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
          )
          )
          )
        ],
      ),
    );
  }
}