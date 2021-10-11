import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter/material.dart';


class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final postTextController = TextEditingController();
  static const String CREATE_USER_POST_URL =
      "https://5vafvrk8kj.execute-api.us-east-1.amazonaws.com/dev/post";
  bool _loading = false;
  late Future<SharedPreferences> _prefs;
  int i = 0;
  Random random = Random();

  List<String> _postPicUrl = [
    "https://images.unsplash.com/photo-1518796745738-41048802f99a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1169&q=80",
    "https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    "https://images.unsplash.com/photo-1589952283406-b53a7d1347e8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1074&q=80",
    "https://images.unsplash.com/photo-1599169713100-120531cef331?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80"
  ];
  int postPicUrlIndex = 0;
  Future<String?>getUserId(){
    _prefs =   SharedPreferences.getInstance();
    return  _prefs.then((SharedPreferences sharedPreferences) {
      String? userId = sharedPreferences.getString('userId');
      return userId;
    });
  }
  Future<void> createPost(String userId) async {
    await http
        .post(Uri.parse(CREATE_USER_POST_URL),
            body: convert.jsonEncode({
              'userId': userId,
              "postText": postTextController.text,
              "postImage": _postPicUrl[i]
            }))
        .then((response) async {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _loading = false;
      });
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            padding: EdgeInsets.all(10),
            backgroundColor: Colors.red,
            content: Text(jsonResponse['message'])));
      } else if (response.statusCode == 200) {
        print('post id is :' + jsonResponse['id']);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      i = random.nextInt(_postPicUrl.length);
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: Container(),
            expandedHeight: 150.0,
            floating: true,
            pinned: true,
            snap: false,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            flexibleSpace: FlexibleSpaceBar(
                stretchModes: <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                title: Text(
                  "Create Post",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            actions: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        _postPicUrl[i],
                        fit: BoxFit.cover,
                        height: 200,
                        width: size.width,
                      ),
                    )),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: postTextController,
                        maxLines: 4,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Please say something";
                          }else{
                            return null;
                          }

                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: (Colors.grey[700])!,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: (Colors.grey[700])!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: (Colors.grey[700])!,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          hintText: "say something.....",
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    _loading? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary)),
                    ): Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 300,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(10),
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20)),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.secondary)),
                          onPressed: () {

                            final FormState form = formKey.currentState!;
                            if(form.validate()){
                              form.save();
                              getUserId().then((String? userId){
                                if(userId != null){
                                  setState(() {
                                    _loading = true;
                                  });
                                  createPost(userId);
                                }else{
                                  setState(() {
                                    _loading = false;
                                  });
                                  print("userId is null");
                                }
                              });

                            }
                          },
                          child: Text('save post')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
