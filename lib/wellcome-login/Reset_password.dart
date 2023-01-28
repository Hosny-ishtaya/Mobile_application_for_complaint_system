import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:store_app/wellcome-login/signin_page.dart';
import 'verify.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../pageone.dart';
import 'dart:convert';

class ResetPasswordScreen extends StatefulWidget {
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AppBar homeAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  var erremail;

  final TextEditingController emailController = new TextEditingController();

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
              'Reset Password',
              style: TextStyle(
                  fontWeight: FontWeight.w900, fontSize: 30, color: mainecolor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Please enter your email address',
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
                    child: Icon(Icons.email, color: icon),
                  ),
                  Expanded(
                      child: TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email Address",
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
                  reset(emailController.text, context);

                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Verfiy();
                    },
                  ));
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
                        "Reset",
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

  reset(String email, BuildContext contextt) async {
    print("hi im omar");

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jasonData = null;
    var response = await http
        .post(Uri.parse("http://$ip:9090/api/compailntsystem/customer/otp"),
            body: json.encode({
              'bodystring': email,
            }),
            headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('done');

      //var data =jasonData(response.body.toString());
      //print(data);

      if (response.body.isEmpty) {
        final snakbar = SnackBar(content: Text("Email is Wrong"));
        ScaffoldMessenger.of(context).showSnackBar(snakbar);
      } else {
        print(response.body.isEmpty);

        jasonData = json.decode(response.body);

        if (jasonData != null) {
          print(jasonData);
          //  setState(() {
          //    _isLoading=false;

          //  });

          // prefs.setString("token", jasonData['jwtToken']);
          prefs.setInt("code", jasonData);
          prefs.setString("gmaill", email);

          print(prefs.getInt("code"));
          Navigator.push(contextt, MaterialPageRoute(
            builder: (context) {
              return Verfiy(); //change it to main page not wellcome , wellcome to test only
            },
          ));
        } else {
          //  setState(() {
          //    _isLoading=false;

          //  });
          print(response.body);
        }
      }

      emailController.text = "";

      final snakbar = SnackBar(content: Text("Check your Email "));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } else {
      print(response.statusCode);
      final snakbar = SnackBar(content: Text("Email is Wrong"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }
}
