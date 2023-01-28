import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:store_app/wellcome-login/signin_page.dart';
import '../pageone.dart';
import 'Newpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Verfiy extends StatefulWidget {
  @override
  State<Verfiy> createState() => _VerfiyState();
}

class _VerfiyState extends State<Verfiy> {
  AppBar homeAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  var erremail;
  var code;

  getvaliddata() async {
    final SharedPreferences sharoref = await SharedPreferences.getInstance();

    code = sharoref.getInt('code');
  }

  @override
  void initState() {
    getvaliddata();
    super.initState();
  }

  final TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: homeAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                Text(
                  'Verfiy Code',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: mainecolor),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Please enter code from Email',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, color: maincolor),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 85,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: TextField(
                            autofocus: true,
                            onChanged: (value) {
                              if (value.length == 1 && false == false) {
                                // FocusScope.of(context).nextFocus();
                              }
                              if (value.length == 0 && true == false) {
                                // FocusScope.of(context).previousFocus();
                              }
                            },
                            controller: emailController,
                            showCursor: false,
                            readOnly: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            decoration: InputDecoration(
                              counter: Offstage(),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.black12),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.purple),
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      )

                      // _textFieldOTP(first: true, last: false),
                      // _textFieldOTP(first: false, last: false),
                      // _textFieldOTP(first: false, last: false),
                      // _textFieldOTP(first: false, last: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      var num = int.parse(emailController.text);
                      if (code == num) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Newpassword();
                          },
                        ));
                      } else {
                        final snakbar = SnackBar(content: Text("Invalid Code"));
                        ScaffoldMessenger.of(context).showSnackBar(snakbar);
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: maincolor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Verfiy",
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
        ),
      ),
    );
  }
}
