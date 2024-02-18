import 'dart:async';
import 'dart:convert';
import 'package:dcs/secondscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(ProviderScope(child:Gitform()));
}

class Gitform extends StatelessWidget {
  const Gitform({super.key});

  @override
  Widget build(BuildContext context) {
    return git();
  }
}

class git extends StatefulWidget {
  const git({super.key});

  @override
  State<git> createState() => _gitState();
}

class _gitState extends State<git> {
  @override
  TextEditingController mycontroller = TextEditingController();
  List<dynamic> repos = [];
  bool isloading = false;
  String error = '';

  _launchUrl() async {
    final url = Uri.parse("https://github.com");
    if (!await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> getrepositories(String user) async {
    setState(() {
      isloading = true;
      error = '';
      repos = [];
    });
    print('Fetching repositories for user: $user');
    final String apiUrl = 'https://api.github.com/users/$user/repos';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print('API Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          repos = json.decode(response.body);
        });
        print('Repositories fetched: $repos');
      } else {
        setState(() {
          error = 'Failed to fetch repositories';
        });
        print('Failed to fetch repositories');
      }
    } catch (e) {
      setState(() {
        error = 'Failed to connect to the server';
      });
      print('Failed to connect to the server: $e');
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Git - Engine",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AboutDialog(
                applicationName: "Git - Engine",
                applicationIcon: CircleAvatar(
                  child: Image.asset("assets/githubdcs.png"),
                ),
                children: [
                  Container(
                    child: Text("Git - Engine is a mobile application"
                        " designed to provide users with easy access to "
                        "their GitHub repositories and information. "
                        "With this app, users can quickly view their "
                        "repositories, including details such as repository"
                        " names, owners, descriptions, and stars. Additionally, "
                        "users can explore GitHub profiles and repositories directly"
                        " from the app."),
                  )
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: RichText(text: TextSpan(text: "GIT - ENGINE"),softWrap: true,),
          flexibleSpace: Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black87,
              Colors.black12,
              Colors.black54,
              Colors.black38
            ]),
          )),
          actions: [
            Padding(
              padding: EdgeInsets.all(3),
              child: Image.asset("assets/githubdcs.png"),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/spacedcs.jpg"),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Icon(
                Icons.adb,
                color: Colors.blueAccent,
                size: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.blueAccent),
                  autofocus: true,
                  controller: mycontroller,
                  decoration: InputDecoration(
                      fillColor: Colors.blueGrey,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      hintText:
                          "                        Enter repository name...",
                      hintStyle: TextStyle(color: Colors.blue)),
                ),
              ), //text field
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do You have Github ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: _launchUrl,
                    child: Text(
                      "  Click here !",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("SUBMIT"),
                onPressed: () async {
                  await getrepositories(mycontroller.text);
                },
              ),
              Expanded(
                flex: 2,
                child: isloading
                    ? Center(
                        child: Container(
                          child: SpinKitCircle(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      )
                    : error.isNotEmpty
                        ? Center(
                            child: Text(error,
                                style: TextStyle(color: Colors.red)))
                        : ListView.builder(
                            itemCount: repos.length,
                            itemBuilder: (context, index) {
                              final repository = repos[index];
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RepositoryDetailsScreen(
                                          name: repository["name"],
                                          owner: repository["owner"]["login"],
                                          description:
                                              repository["description"] ?? "",
                                          stars: repository["stargazers_count"],
                                          url: repository["html_url"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            repository["owner"]["avatar_url"]),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            width: 2, color: Colors.blueAccent),
                                      ),
                                      title: Text(repos[index]["name"],
                                          style: TextStyle(
                                              color: Colors.blueAccent)),
                                      trailing: IconButton(
                                        icon: Icon(Icons.account_balance),
                                        color: Colors.redAccent,
                                        onPressed: null,
                                      ),
                                    ),
                                  ));
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
