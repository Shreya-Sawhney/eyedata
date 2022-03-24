import 'package:eyedata/screens/capture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  //const StartScreen();
  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController textControllerPhone = TextEditingController();
  TextEditingController textControllerName = TextEditingController();
  String displayText = "";
  String saveDataText = "";
  String genderText = "Gender";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Welcome'),
      ),
      resizeToAvoidBottomInset: false ,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextFormField(
                  controller: textControllerName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Name',
                    labelText: "Name *",
                  ),
                  validator:(value) {
                    if (!RegExp(r'^[a-z A-Z]+$').hasMatch
                      (value!)) {
                      return "Enter correct name";
                    }
                    // else {
                    //   return null;
                    // }
                  }
                ),
                ),
                Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextFormField(
                    controller: textControllerPhone,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Phone Number',
                      labelText: "Phone *",
                    ),
                    validator:(value) {
                      value = value?.replaceAll(' ', '');
                      //print(value);
                      if (value!. isEmpty || !RegExp
                        (r'(^(\+91[\-\s]?)?[0]?(91)?[789]\d{9}$)').hasMatch
                        (value))
                      {
                        return "Enter correct phone number";
                      }
                      //return null;
                    }
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                Colors.deepPurple,
                                Colors.indigo,
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.orange,
                                Colors.red,
                                //add more colors
                              ]),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                blurRadius: 10) //blur radius of shadow
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:10, right:10),
                        child: DropdownButton<String>(
                          //alignment: Alignment.center,
                          borderRadius: BorderRadius.circular(10),
                          isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            genderText,
                            style: const TextStyle(color: Colors.white),
                          ),
                          iconEnabledColor: Colors.green,
                          items: <String>['Male', 'Others', 'Female'].map((String value) {
                            return DropdownMenuItem<String>(
                              //alignment: Alignment.center,
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (var value) {
                            setState(() {
                              genderText = value!;
                            });
                          },
                      ),
                      )
                    ),
                  )
                ),
              ]
            ),
            Container(
                padding: const EdgeInsets.only(left: 80, right: 80, bottom: 20),
                child: ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: (){
                      setState(() {
                        //displayText = textControllerPhone.text.replaceAll(' ', '');
                        displayText = textControllerName.text;
                        saveDataText = textControllerPhone.text.replaceAll(' ', '') + "_" + textControllerName.text + "_" + genderText;
                      });
                      if(formKey.currentState!.validate() && genderText != "Gender") {
                        Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => CaptureScreen(userName: displayText, saveDataText: saveDataText)
                          ),
                          //ModalRoute.withName("/")
                        );
                      }
                      else if (formKey.currentState!.validate()) {
                        final scaffold = ScaffoldMessenger.of(context);
                        scaffold.showSnackBar(
                            SnackBar(
                              elevation: 6.0,
                              margin: const EdgeInsets.all(35),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              content: const Text("Please select gender!",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(seconds: 1),
                            )
                        );
                      }
                    }, style:
                ElevatedButton.styleFrom(
                    fixedSize: const Size(180, 60),
                    primary: const Color(0xFF80C038),
                    textStyle: const TextStyle(fontSize: 26),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                )
                )
            ),
          ],
        ),
      ),
    );
  }
}