import 'dart:convert';
import 'verify.dart';
//import 'dart:js';

// import '../main.dart';
import 'package:flutter/material.dart';
import 'package:store_app/constants.dart';
import '../pageone.dart';
import './signup_page.dart';
import './wellcome_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './Reset_password.dart';
import 'Login_option.dart';
import '../Main_page/Main_page.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool hiddenpaas = true;
  var errorpass;
  var erroremail;

  var _formkey = GlobalKey<FormState>();

  final TextEditingController EmailController = new TextEditingController();

  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/wellcome.png"),
                  fit: BoxFit.fitHeight, //for fit image on page
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("SIGN IN:",
                            style: Theme.of(context).textTheme.displayLarge),
                        FittedBox(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                },
                              ));
                            },
                            child: Text(
                              "SIGN UP",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        )
                      ],
                    ),
                    // Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 9),
                            child: Icon(Icons.email, color: icon),
                          ),
                          Expanded(
                              child: TextField(
                            controller: EmailController,
                            decoration: InputDecoration(
                              hintText: " Your Email",
                              errorText: erroremail,
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: maincolor), //<-- SEE HERE
                              ),
                            ),
                            style: TextStyle(color: black),
                          ))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.lock, color: icon),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: hiddenpaas,
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              errorText: errorpass,
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: maincolor), //<-- SEE HERE
                              ),
                              suffixIcon: InkWell(
                                onTap: _toglepass,
                                child: Icon(
                                  Icons.visibility,
                                ),
                              ),
                            ),
                            style: TextStyle(color: black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text("Or:", style: TextStyle(fontSize: 15)),
                    SizedBox(
                      height: 5,
                    ),
                    LoginOption(),
                    SizedBox(
                      height: 25,
                    ),
                    FittedBox(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ResetPasswordScreen();
                            },
                          ));
                        },
                        child: Text(
                          "Forgate Password..",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                final snakbar = SnackBar(
                                    content: Text("go to wellcom page"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakbar);

                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return wellcomsecreen();
                                  },
                                ));
                              },
                              //************************************************************************************** */
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mainecolor,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(15),
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: maincolor.withOpacity(1),
                          //   ),
                          //   child: Icon(
                          //     Icons.facebook_outlined,
                          //     // color: Colors.white.withOpacity(0.5),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: 5,
                          // ),

                          // Container(
                          //   padding: EdgeInsets.all(15),
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: maincolor.withOpacity(1),
                          //   ),
                          //   child: Icon(
                          //     Icons.youtube_searched_for_outlined,
                          //     // color: Colors.white.withOpacity(0.5),
                          //   ),
                          // ),
                          Spacer(),
                          //Icons.login_sharp,

                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                signin(EmailController.text,
                                    passwordController.text, context);
                                if (EmailController.text.isEmpty) {
                                  setState(() {
                                    erroremail = 'Not valid username';
                                  });
                                } else {
                                  setState(() {
                                    erroremail = null;
                                  });
                                }
                                if (passwordController.text.isEmpty) {
                                  setState(() {
                                    errorpass = 'Not valid password';
                                  });
                                } else {
                                  setState(() {
                                    errorpass = null;
                                  });
                                }

                                print('hello world');
                              },
                              //************************************************************************************** */
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mainecolor,
                                ),
                                child: Icon(
                                  Icons.login_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  signin(String email, String password, BuildContext contextt) async {
    print('potato');
    // print(email);
    // print(password);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("email", email);

    // Map data = {'email': email, 'password': password};

    var jasonData = null;
    var response = await http
        .post(Uri.parse("http://$ip:9090/api/compailntsystem/customer/signIn"),
            body: json.encode({
              'email': email,
              'password': password,
            }),
            headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('acc succcess');

      //var data =jasonData(response.body.toString());
      //print(data);

      if (response.body.isEmpty) {
        final snakbar =
            SnackBar(content: Text("Username or password is Wrong"));
        ScaffoldMessenger.of(context).showSnackBar(snakbar);
      } else {
        print(response.body.isEmpty);

        jasonData = json.decode(response.body);

        if (jasonData != null) {
          //  setState(() {
          //    _isLoading=false;

          //  });

          // prefs.setString("token", jasonData['jwtToken']);
          prefs.setString("email", jasonData["email"]);
          prefs.setString("name", jasonData["username"]);
          prefs.setString("password", jasonData["password"]);
          prefs.setString("address", jasonData["address"]);
          prefs.setInt("phone", jasonData["phone"]);
          prefs.setInt("social_number", jasonData["social_number"]);

          print(prefs.getString("email"));
          print(prefs.getString("name"));
          print(prefs.getInt("social_number"));

          Navigator.push(contextt, MaterialPageRoute(
            builder: (context) {
              return Mainpage(); //change it to main page not wellcome , wellcome to test only
            },
          ));
        } else {
          //  setState(() {
          //    _isLoading=false;

          //  });
          print(response.body);
        }
      }
    } else {
      print(response.statusCode);

      final snakbar = SnackBar(content: Text("Username or password is Wrong"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    }
  }

  void _toglepass() {
    setState(() {
      hiddenpaas = !hiddenpaas;
    });
  }
}
