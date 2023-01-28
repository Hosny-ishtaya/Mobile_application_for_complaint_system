import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:store_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pageone.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Complain extends StatefulWidget {
  final Map todo;
  const Complain({this.todo, key}) : super(key: key);

  @override
  _Complain_form createState() => _Complain_form();
}

class _Complain_form extends State<Complain> {
  File file;

  var custm_id;

  bool isSignIn = false;

  getvaliddata() async {
    SharedPreferences sharoref = await SharedPreferences.getInstance();
    custm_id = sharoref.getInt('social_number');

    if (custm_id != null) {
      setState(() {
        custm_id = sharoref.getInt('social_number');
        isSignIn = true;
        print(custm_id);
      });
    }
  }

  @override
  void initState() {
    getvaliddata();
    final todo = widget.todo;

    if (todo != null) {
      final Ncompany = todo['title'];
      final description = todo['description'];

      NameCompanyController.text = Ncompany;
      DescriptionController.text = description;

      isEdit = true;
    }
    super.initState();
  }

  Future piccamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      file = File(myfile.path);
    });
  }

  _myformState() {
    _Catogryvalue = _Catogrylist[0];
  }

  _myformmState() {
    _Catogrycomvalue = _Catogrycomlist[0];
  }

  bool isEdit = false;

  final _Catogrylist = [
    "Pharmaceuticals",
    "Grocery store",
    "sanity ware",
    "Cosmetics store",
    "Sport",
    "Fashion logistics",
    "Software Company",
    "Cleaning product",
    "others"
  ];

  final _Catogrycomlist = [
    "Price",
    "Out of date",
    "Quality and quality",
    "Bad Service",
    "Others"
  ];
  String _Catogryvalue = "Pharmaceuticals";
  String _Catogrycomvalue = "Price";

  TextEditingController NameCompanyController = TextEditingController();
  TextEditingController cus_idController = TextEditingController();
  TextEditingController company_idController = TextEditingController();
  TextEditingController LocationCompanyController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFFffffff),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 30, right: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.1),
                Container(
                  padding: const EdgeInsets.only(left: 0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.arrow_back_ios, color: maincolor),
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true)
                                  .pop(context))
                    ],
                  ),
                ),
                SizedBox(height: height * 0.04),
                TextWidget(
                    text: "Here to put", fontSize: 26, isUnderLine: false),
                TextWidget(
                    text: isEdit ? "Edit Complaint!" : "Free Complaint",
                    fontSize: 26,
                    isUnderLine: false),
                SizedBox(height: height * 0.01), //0.04
                // TextInput(
                //     textString: "Your ID ",
                //     textController: cus_idController,
                //     hint: "Your id"),
                // SizedBox(
                //   height: height * .02,
                // ),
                DropdownButtonFormField(
                  value: _Catogryvalue,
                  items: _Catogrylist.map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      )).toList(),
                  onChanged: (val) {
                    setState(() {
                      _Catogryvalue = val as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: maincolor,
                  ),
                  decoration:
                      InputDecoration(labelText: "Catogry company Type"),
                ),
                SizedBox(
                  height: height * .01,
                ),
                DropdownButtonFormField(
                  value: _Catogrycomvalue,
                  items: _Catogrycomlist.map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      )).toList(),
                  onChanged: (val) {
                    setState(() {
                      _Catogrycomvalue = val as String;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: maincolor,
                  ),
                  decoration:
                      InputDecoration(labelText: "Catogry Complaint Type"),
                ),
                SizedBox(
                  height: height * .01,
                ),
                TextInput(
                    textString: "Company id from list or defalt 10 ",
                    textController: company_idController,
                    hint: "company id from list or defalt 10"),
                SizedBox(
                  height: height * .01,
                ),
                TextInput(
                  textString: "Location of Company",
                  textController: LocationCompanyController,
                  hint: "Location of Company",
                  obscureText: false,
                ),
                SizedBox(
                  height: height * .01,
                ),
                TextInput(
                  textString: "Name of Company",
                  textController: NameCompanyController,
                  hint: "Name of Company",
                  obscureText: false,
                ),
                SizedBox(
                  height: height * .03,
                ),
                TextFormField(
                  controller: DescriptionController,
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(hintText: "Description of Complaint"),
                ),
                SizedBox(
                  height: height * .01,
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      piccamera();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: maincolor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Upload Image",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .03,
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      isEdit ? updateData() : submitData();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                      margin: EdgeInsets.only(left: 100, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: maincolor,
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            isEdit ? "Edit Complain" : "Complain",
                            style: Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     TextWidget(
                //         text: "Complain", fontSize: 22, isUnderLine: false),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     GestureDetector(
                //         onTap: () {
                //           submitData();
                //         },
                //         child: Container(
                //           height: 80,
                //           width: 60,
                //           decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: maincolor,
                //           ),
                //           child: Icon(Icons.arrow_forward,
                //               color: Colors.white, size: 30),
                //         ))
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("you cant update");
    }
    final description = DescriptionController.text;
    final company = NameCompanyController.text;

    final id = todo['_id'];

    final body = {
      "companyname": company,
      "description": description,
    };

    final url = "http update compalin/$id";
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(description),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print("Success update ");
    } else {
      print("Failed update ");
      print(response.body);
    }
  }

  Future<void> submitData() async {
    final description = DescriptionController.text;
    final location = LocationCompanyController.text;
    final compan_id = company_idController.text;
    final companyname = NameCompanyController.text;

    final url = "http://$ip:9090/api/compailntsystem/customer/makeComplaint";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: json.encode({
          'type_company': _Catogryvalue,
          'description': description,
          'location': location,
          'company_id': compan_id,
          'customer_id': custm_id,
          "companyName": companyname,
          "status": "Pending",
          "type_complaint": _Catogrycomvalue
        }),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print(response.statusCode);

      DescriptionController.text = "";
      LocationCompanyController.text = "";
      company_idController.text = "";
      NameCompanyController.text = "";

      final snakbar = SnackBar(content: Text("Complaint is Created"));
      ScaffoldMessenger.of(context).showSnackBar(snakbar);

      print("Success");
    } else {
      print("Failed");
      print(response.body);
    }
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  TextEditingController textController;
  final String hint;
  bool obscureText;
  TextInput(
      {Key key,
      this.textString,
      this.textController,
      this.hint,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xFF000000)),
      cursorColor: Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: this.textString,
        hintStyle: TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  int fontSize;
  bool isUnderLine;
  final Color color;
  TextWidget(
      {Key key,
      this.text,
      this.fontSize,
      this.isUnderLine = false,
      this.color = maincolor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 3, // space between underline and text
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: isUnderLine ? maincolor : Color(0xFFffffff), // Text colour here
        width: 1.0, // Underline width
      ))),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: this.fontSize.toDouble(),
          fontFamily: "Avenir",
          fontWeight: FontWeight.w900,
          color: this.color,
        ),
      ),
    );
  }
}
