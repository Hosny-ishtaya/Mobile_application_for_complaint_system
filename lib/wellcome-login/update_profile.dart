import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import '../pageone.dart';
import 'dart:convert';
import 'signin_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/constants.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _updateprofile();
}

bool hiddenpaas = true;
var erruname, erremail, errphone, erraddress, errid, errpass;

class _updateprofile extends State<UpdateProfileScreen> {
  final TextEditingController usernameeController = new TextEditingController();

  final TextEditingController emailController = new TextEditingController();

  final TextEditingController PhoneController = new TextEditingController();

  final TextEditingController AddressController = new TextEditingController();

  final TextEditingController passworddController = new TextEditingController();

  bool isSignIn = false;
  var username;
  var email;
  var password;
  var phone;
  var address;
  var social_num;

  getvaliddata() async {
    final SharedPreferences sharoref = await SharedPreferences.getInstance();
    username = sharoref.getString('name');
    email = sharoref.getString('email');
    password = sharoref.getString('password');
    phone = sharoref.getInt('phone');
    address = sharoref.getString('address');

    // username = sharoref.getInt('social_number');

    if (username != null) {
      setState(() {
        username = sharoref.getString('name');
        email = sharoref.getString('email');
        password = sharoref.getString('password');
        phone = sharoref.getInt('phone');
        address = sharoref.getString('address');
        //********* */
        usernameeController.text = username;
        emailController.text = email;
        passworddController.text = password;
        PhoneController.text = phone.toString();
        AddressController.text = address;

        isSignIn = true;
      });
    }
  }

  @override
  void initState() {
    getvaliddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text("Edit Profile",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ), // AppBar

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(1),
          child: Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage("images/users.png"),
                  ), // sizedBox
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: kPrimaryColor),
                      child: const Icon(
                        Icons.camera,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: <Widget>[
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
                    SizedBox(
                      height: 30,
                    ),
                    FittedBox(
                      child: GestureDetector(
                        onTap: () {
                          signup(
                              usernameeController.text,
                              PhoneController.text,
                              AddressController.text,
                              emailController.text,
                              passworddController.text,
                              context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 26, vertical: 16),
                          margin: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: maincolor,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Edit Profile",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  signup(String username, String phone, String address, String email,
      String password, BuildContext contextt) async {
    SharedPreferences sharoref = await SharedPreferences.getInstance();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    social_num = sharoref.getInt('social_number');

    if (social_num != null) {
      setState(() {
        social_num = sharoref.getInt('social_number');
        print("inside$social_num");
        isSignIn = true;
      });
    }

    print("hi im omar");
    var response = await http.put(
        Uri.parse("http://$ip:9090/api/compailntsystem/customer/editProfile"),
        body: json.encode({
          'username': username,
          'phone': phone,
          'address': address,
          'email': email,
          'password': password,
          "social_number": social_num
        }),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      print('updated Data ');

      final snakbar = SnackBar(content: Text("updated Data "));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);

      prefs.setString("email", email);
      prefs.setString("name", username);
      prefs.setString("password", password);
      prefs.setString("address", address);
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
