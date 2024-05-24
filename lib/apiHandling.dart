import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  void newsDetails() async {
    Uri url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2024-04-24&sortBy=publishedAt&apiKey=API_KEY');
    http.Response response = await http.get(url);
    log(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ShortsNews",
          style: GoogleFonts.quicksand(
            fontSize: 20,
            color: Colors.orange,
          ),
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Column(
          children: [],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newsDetails();
        },
      ),
    );
  }
}
