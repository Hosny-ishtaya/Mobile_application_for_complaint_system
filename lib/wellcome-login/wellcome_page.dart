import 'dart:convert';
//import 'dart:js';
import 'package:store_app/wellcome-login/signin_page.dart';

import '../main.dart';
import 'package:flutter/material.dart';
import '../pageone.dart';
// import './signin_page.dart';
// import './signup_page.dart';
import 'package:http/http.dart' as http;
import '../screens/home_screen.dart';

class wellcomsecreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/wellcome.png"),
                  fit: BoxFit.fitWidth,
                  //  scale: 12,
                ),
              ),
            )),
        Expanded(
            child: Column(
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "Consumer Protection Association\n",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                              fontSize: 28,
                              color: mainecolor,
                              fontWeight: FontWeight.w700)),
                ])),
            FittedBox(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return SignIn();
                    },
                  ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: maincolor,
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Let's Start",
                        style: Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ]),
    );
  }
}
