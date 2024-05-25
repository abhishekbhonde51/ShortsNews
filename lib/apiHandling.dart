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
  List<dynamic> productDetails = [];
  void newsDetails() async {
    try {
      Uri url = Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2024-04-25&sortBy=publishedAt&apiKey=1f360acfe18046128948d80b4aa3f9f0');
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
              fontSize: 25,
              color: const Color.fromARGB(255, 0, 1, 10),
              fontWeight: FontWeight.bold),
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
          var imageUrl = article['urlToImage'] ?? 'Url not found';
          var publishedDate = article['publishedAt'] ?? 'unknown';

          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            child: Column(
              
              children: [
                Text(
                  title,
                  style: GoogleFonts.quicksand(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "- $author",
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    description,
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 58, 35, 35),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    publishedDate,
                    style: GoogleFonts.quicksand(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.black,
                )
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
