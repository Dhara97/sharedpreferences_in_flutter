import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool autoValidate = false;
  bool isLoading = false;
  bool newUser;
  SharedPreferences logindata;

  TextEditingController mobilecont = new TextEditingController();
  TextEditingController passcont = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newUser = (logindata.getBool('login') ?? true);

    print(newUser);
    if (newUser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobilecont.dispose();
    passcont.dispose();
    super.dispose();
  }

  sendData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      autoValidate = true;
    } else {
      autoValidate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.all(16),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/download.png',
                        width: 150,
                        height: 150,
                      ),
                      10.height,
                      Form(
                        autovalidate: autoValidate,
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (String value) {
                                if (value.isEmpty)
                                  return 'Please enter valid mobile number';
                                if (value.length < 10)
                                  return "Mobile number must be of 10 digits";
                                else
                                  return null;
                              },
                              controller: mobilecont,
                              autofocus: false,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                hintText: 'Enter your mobile number',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            10.height,
                            TextFormField(
                              controller: passcont,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14),
                                hintText: 'Enter your password',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            20.height,
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: RaisedButton(
                                highlightElevation: 0.0,
                                elevation: 1.0,
                                color: Colors.lightBlue[300],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 24),
                                ),
                                onPressed: () async {
                                  sendData();

                                  if (mobilecont.text == '7405729529' &&
                                      passcont.text == '123456') {
                                    print('Successfull');
                                    logindata.setBool('login', false);

                                    logindata.setString(
                                        'mobile', mobilecont.text);

                                    setState(() {
                                      isLoading = true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeScreen(),
                                          ));
                                    });
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
      )),
    );
  }
}
