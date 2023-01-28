import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id, rate;
  final String namec, typeofc, description, image;

  Product(
      {this.id,
      this.rate,
      this.namec,
      this.typeofc,
      this.description,
      this.image});
}

List<Product> products = [
  Product(
    id: 7,
    rate: 7,
    namec: "Al-Rajeh",
    typeofc: "cleaning products",
    image: "images/companylogo.png",
    description: "Nablus",
  ),
  Product(
    id: 2,
    rate: 3,
    namec: "cosmoline",
    typeofc: "cosmatics",
    image: "images/companylogo.png",
    description: "nab",
  ),
  Product(
    id: 4,
    rate: 8,
    namec: "ASAL",
    typeofc: "Software Industry",
    image: "images/companylogo.png",
    description: "Rawabi - Rammallah",
  ),
  Product(
    id: 1,
    rate: 8,
    namec: "Al-quds",
    typeofc: "Pharmaceuticals",
    image: "images/companylogo.png",
    description: "Rammallah",
  ),
  Product(
    id: 6,
    rate: 9,
    namec: "Al-Dolphine",
    typeofc: "Sanitary Ware",
    image: "images/companylogo.png",
    description: "Nablus-salem",
  ),
];




  // factory Product.fromJson(List<dynamic> parsedJson) {
  //   List<Product> list = new List<Product>();

  // }

//}

// list of products

// Future<List<void>> GetCompany() async {
//   final url =
//       "http://192.168.1.114:9090/api/compailntsystem/customer/getallcompanies";
//   final uri = Uri.parse(url);
//   final response = await http.get(uri);

//   if (response.statusCode == 200) {
//     print("success get company");

//     final json = jsonDecode(response.body);

//     final result = json as List;

//     return result;

//     // setState(() {
//     //   producty = result; // there we put all info from database in this list
//     // });

//     print(response.statusCode);
//     print(json);
//     // print(response.body);
//   } else {
//     print(response.statusCode);
//   }
// }