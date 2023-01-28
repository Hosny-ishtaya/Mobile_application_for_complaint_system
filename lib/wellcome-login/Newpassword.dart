import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:store_app/wellcome-login/signin_page.dart';
import 'verify.dart';
import '../pageone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Newpassword extends StatefulWidget {
  @override
  State<Newpassword> createState() => _NewpasswordState();
}

class _NewpasswordState extends State<Newpassword> {
  AppBar homeAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  var erremail;
  var emaill;
  bool isSignIn = false;

  final TextEditingController passwordcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: homeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            Text(
              'Change Password',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 30, color: mainecolor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please Enter A New Password',
              style: TextStyle(fontWeight: FontWeight.w600, color: maincolor),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(Icons.looks, color: icon),
                  ),
                  Expanded(
                      child: TextField(
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            hintText: "New Password",
                            errorText: erremail,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 12),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: maincolor), //<-- SEE HERE
                            ),
                          )))
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  resetpass(passwordcontroller.text, context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: maincolor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Change",
                        style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  resetpass(String password, BuildContext contextt) async {
    SharedPreferences sharoref = await SharedPreferences.getInstance();
    emaill = sharoref.getString('gmaill');

    if (emaill != null) {
      setState(() {
        emaill = sharoref.getString('gmaill');
        print("insideeee$emaill");
        isSignIn = true;
      });
    }

    print("hi im omar");
    var response = await http.post(
        Uri.parse("http://$ip:9090/api/compailntsystem/customer/resetPassword"),
        body: json.encode({
          'email': emaill,
          'password': password,
        }),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('change password ');

      passwordcontroller.text = "";

      final snakbar = SnackBar(content: Text("password Changed"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return SignIn();
        },
      ));
    } else {
      print(response.statusCode);
    }
  }
}
