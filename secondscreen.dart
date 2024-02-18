import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailsScreen extends StatelessWidget {
  final String name;
  final String owner;
  final String description;
  final int stars;
  final String url;

  const RepositoryDetailsScreen({
    required this.name,
    required this.owner,
    required this.description,
    required this.stars,
    required this.url,
  });

  @override
  _launchUrl(String owner, String name) async {
    final url = Uri.parse("https://github.com/$owner/$name");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.black87,
                Colors.black12,
                Colors.black54,
                Colors.black38
              ]),
            ),
          ),
          title: Text(
            "Repository Details",
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 20,
                fit: BoxFit.cover,
                image: AssetImage('assets/space2.jpg'),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Container(
                          height: 60, // Set the height of the Container
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2, // Set the border width
                              color: Colors.blueAccent, // Set the border color
                            ),
                            borderRadius: BorderRadius.circular(
                                4), // Set the border radius
                          ),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: "REPOSITORY: ",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: "$name",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Container(
                          height: 60, // Set the height of the Container
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2, // Set the border width
                              color: Colors.blueAccent, // Set the border color
                            ),
                            borderRadius: BorderRadius.circular(
                                4), // Set the border radius
                          ),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: "OWNER: ",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: "$owner",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Container(
                          height: 60, // Set the height of the Container
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2, // Set the border width
                              color: Colors.blueAccent, // Set the border color
                            ),
                            borderRadius: BorderRadius.circular(
                                4), // Set the border radius
                          ),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: "STARS: ",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: "     $stars",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        title: Container(
                          height: 200, // Set the height of the Container
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://www.bing.com/ck/a?!&&p=e73692f7d29715fbJmltdHM9MTcwODA0MTYwMCZpZ3VpZD0yZmIzM2E3OS1kYWMwLTZlYjUtM2VkOS0yOTJiZGI2ZDZmNTQmaW5zaWQ9NTY3Nw&ptn=3&ver=2&hsh=3&fclid=2fb33a79-dac0-6eb5-3ed9-292bdb6d6f54&u=a1L2ltYWdlcy9zZWFyY2g_cT1zcGFjZSBpbWFnZSZGT1JNPUlRRlJCQSZpZD03QzA0RTlGRENFQUNDQjQxMjE0OTk5RDYxQTI3QUZBOTVDMjYxNTlC&ntb=1'),
                              // Provide the URL of your image
                              fit: BoxFit
                                  .cover, // Adjust the image size to cover the entire Container
                            ),
                            border: Border.all(
                              width: 2, // Set the border width
                              color: Colors.blueAccent, // Set the border color
                            ),
                            borderRadius: BorderRadius.circular(
                                4), // Set the border radius
                          ),
                          child: ListTile(
                            title: RichText(
                              text: TextSpan(
                                text: "DESCRIPTION: \n",
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: description != " "
                                        ? "$description"
                                        : "No description for this repository",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _launchUrl(owner, name);
                          },
                          child: Text(
                            "See Repo --",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                )
              ],
            )));
  }
}

class second_screen extends StatefulWidget {
  const second_screen({super.key});

  @override
  State<second_screen> createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
