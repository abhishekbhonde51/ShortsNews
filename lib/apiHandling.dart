import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  List<dynamic> productDetails = [];
  void newsDetails() async {
    try {
      Uri url = Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2024-04-24&sortBy=publishedAt&apiKey=c6f761505a47457eac563f53842e0642');
      http.Response response = await http.get(url);
      log(response.body);

      var responseData = json.decode(response.body);

      setState(() {
        productDetails = responseData['articles'];
      });
    } catch (e) {
      log("Failed in fetching data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ShortsNews",
          style: GoogleFonts.quicksand(
              fontSize: 25, color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: productDetails.length,
        itemBuilder: (context, index) {
          var article = productDetails[index];
          var author = article['author'] ?? 'Anonymous';
          var title = article['title'] ?? 'No title';
          var description = article['description'] ?? 'No description';
          var imageUrl = article['urlToImage'];
          var publishedDate = article['publishedAt'];
        

          return Container(
            child: Column(
              children: [
                Text(author),
                Text(description),
                Text(imageUrl),
                Text(publishedDate)
              ],
              
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newsDetails();
        },
      ),
    );
  }
}
