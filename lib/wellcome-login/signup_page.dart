import '../main.dart';
import 'signin_page.dart';
import 'package:flutter/material.dart';
import '../pageone.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_screen.dart';
import '../Main_page/Main_page.dart';
import 'package:store_app/constants.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

bool hiddenpaas = true;
var erruname, erremail, errphone, erraddress, errid, errpass;

class _SignUpState extends State<SignUp> {
  final TextEditingController usernameeController = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController PhoneController = new TextEditingController();

  final TextEditingController AddressController = new TextEditingController();

  final TextEditingController IdController = new TextEditingController();

  final TextEditingController passworddController = new TextEditingController();

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
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "SIGN UP:",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ],
                    ),
                    //  Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.supervised_user_circle,
                                color: maincolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: usernameeController,
                                  decoration: InputDecoration(
                                    hintText: "USER NAME",
                                    errorText: erruname,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: maincolor), //<-- SEE HERE
                                    ),
                                  )))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.email, color: maincolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Email Address",
                                    errorText: erremail,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: maincolor), //<-- SEE HERE
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.phone, color: maincolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: PhoneController,
                                  decoration: InputDecoration(
                                    hintText: "Phone",
                                    errorText: errphone,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: maincolor), //<-- SEE HERE
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.location_city, color: maincolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: AddressController,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    errorText: erraddress,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: maincolor), //<-- SEE HERE
                                    ),
                                  )))
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(Icons.perm_identity, color: maincolor),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: IdController,
                                  decoration: InputDecoration(
                                    hintText: "ID",
                                    errorText: errid,
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: maincolor), //<-- SEE HERE
                                    ),
                                  )))
                        ],
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.lock, color: maincolor),
                        ),
                        Expanded(
                            child: TextField(
                                obscureText: true,
                                controller: passworddController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  errorText: errpass,
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: maincolor), //<-- SEE HERE
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: _toglepass,
                                    child: Icon(
                                      Icons.visibility,
                                    ),
                                  ),
                                )))
                      ],
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
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return SignIn();
                                    //SignIn();
                                  },
                                ));
                                setState(() {
                                  erruname = null;
                                  erremail = null;
                                  errphone = null;
                                  erraddress = null;
                                  errid = null;
                                  errpass = null;
                                });
                              },
                              //************************************************************************************** */
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: maincolor,
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(15),
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.black.withOpacity(0.2),
                          //   ),
                          //   child: Icon(
                          //     Icons.facebook_outlined,
                          //     // color: Colors.white.withOpacity(0.5),
                          //   ),
                          // ),
                          Spacer(),
                          FittedBox(
                            child: GestureDetector(
                              //*************************************************************************************** */
                              onTap: () {
                                if (usernameeController.text.isEmpty) {
                                  setState(() {
                                    erruname = "Not valid Username";
                                  });
                                } else {
                                  setState(() {
                                    erruname = null;
                                  });
                                }
                                if (AddressController.text.isEmpty) {
                                  setState(() {
                                    erraddress = "Not valid Address";
                                  });
                                } else {
                                  setState(() {
                                    erraddress = null;
                                  });
                                }
                                if (emailController.text.isEmpty) {
                                  setState(() {
                                    erremail = "Not valid Email";
                                  });
                                } else {
                                  setState(() {
                                    erremail = null;
                                  });
                                }
                                if (PhoneController.text.isEmpty) {
                                  setState(() {
                                    erremail = "Not valid Phone";
                                  });
                                } else {
                                  setState(() {
                                    errphone = null;
                                  });
                                }
                                if (IdController.text.isEmpty) {
                                  setState(() {
                                    erremail = "Not valid ID";
                                  });
                                } else {
                                  setState(() {
                                    errid = null;
                                  });
                                }
                                if (passworddController.text.isEmpty) {
                                  setState(() {
                                    errpass = "Not valid Password";
                                  });
                                } else {
                                  setState(() {
                                    errpass = null;
                                  });
                                }
                                // signup(context)
                                print("hi im hosny");
                                signup(
                                    usernameeController.text,
                                    emailController.text,
                                    PhoneController.text,
                                    AddressController.text,
                                    IdController.text,
                                    passworddController.text,
                                    context);

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return wellcomsecreen();
                                //   },
                                // )
                                // );
                              },
                              //************************************************************************************** */

                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: maincolor,
                                ),
                                child: Icon(
                                  Icons.create,
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

  signup(String username, String email, String phone, String address, String id,
      String password, BuildContext contextt) async {
    print("hi im omar");
    var response = await http.post(
        Uri.parse(
            "http://$ip:9090/api/compailntsystem/customer/registerCustomer"),
        body: json.encode({
          'username': username,
          'phone': phone,
          'address': address,
          'email': email,
          'password': password,
          "social_number": id
        }),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('account is creted ');

      usernameeController.text = "";
      emailController.text = "";
      PhoneController.text = "";
      AddressController.text = "";
      IdController.text = "";
      passworddController.text = "";

      final snakbar = SnackBar(content: Text("Account is Created"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);
    } else {
      print(response.statusCode);
    }
  }

  void _toglepass() {
    setState(() {
      hiddenpaas = !hiddenpaas;
    });
  }
}
