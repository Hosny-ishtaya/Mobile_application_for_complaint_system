import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/pageone.dart';
import '../models/product.dart';
import '../Complain/Complain_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_app/constants.dart';

class List_complaint extends StatefulWidget {
  const List_complaint({key}) : super(key: key);

  @override
  State<List_complaint> createState() => _List_complaintState();
}

class _List_complaintState extends State<List_complaint> {
  List items = [];

  List itit = [];
  var social_num;
  bool isSignIn = false;

  getvaliddata() async {}

  @override
  void initState() {
    getvaliddata();
    GetComplaint();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text('My Complaint',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
      ),
      body: Visibility(
        visible: items.isNotEmpty,
        replacement: Center(
            child: Text("No complaint here !",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index] as Map;
              final id = item['_id'] as String;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                    backgroundColor: maincolor,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(
                    item['status'],
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle:
                      Text(item['description'], style: TextStyle(fontSize: 12)),
                  // leading: CircleAvatar(child: Text("1")),
                  // title: Text('cosmoline'),
                  // subtitle: Text('proplem in product'),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        //edit complaint
                        navigateToEditpage(item);
                      } else if (value == 'delete') {
                        // deleteById(id);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: Text('Edit'),
                          value: 'edit',
                        ),
                        PopupMenuItem(
                          child: Text('Delete'),
                          value: 'delete',
                        )
                      ];
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future<void> GetComplaint() async {
    SharedPreferences sharoref = await SharedPreferences.getInstance();
    social_num = sharoref.getInt('social_number');

    if (social_num != null) {
      setState(() {
        social_num = sharoref.getInt('social_number');
        print("inside$social_num");
        isSignIn = true;
      });
    }
    print("the socialnum: $social_num");
    final url =
        "http://$ip:9090/api/compailntsystem/customer/getAllComplaint?id=$social_num";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // final result = json['items'] as List;

      print(json);

      setState(() {
        items = json; // there we put all info from database in this list
      });
    }

    print(response.statusCode);
    print(response.body);
  }

  //*********************************************************************************************** */

  // Future<void> deleteById(String id) async {
  //   final url = "http/$id";
  //   final uri = Uri.parse(url);
  //   final response = await http.delete(uri);

  //   if (response.statusCode == 200) {
  //     final filtered = items.where((element) => element['_id'] != id).toList();
  //     setState(() {
  //       items = filtered;
  //     });

  //     showSuccessMessage("Success..!");
  //   } else {
  //     //Show Error
  //   }
  // }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToEditpage(Map item) {
    final route = MaterialPageRoute(builder: (context) => Complain(todo: item));
    Navigator.push(context, route);
  }
}
