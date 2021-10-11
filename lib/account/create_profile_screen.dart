import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:upstash_mobile/home/home_screen.dart';
class CreateProfileScreen extends StatefulWidget {


  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  static const String  CREATE_USER_PROFILE_URL = "https://5vafvrk8kj.execute-api.us-east-1.amazonaws.com/dev/user";
  bool _loading = false;
late Future<SharedPreferences> _prefs;
  Future<void>saveUserId(String userId) async {
     _prefs =   SharedPreferences.getInstance();
    return _prefs.then((SharedPreferences sharedPreferences) {
      sharedPreferences.setString("userId", userId);
    });

  }
  Future<void>createUserProfile() async{
    setState(() {
      _loading = true;
    });
  print(usernameController.text);
  print(firstNameController.text);
  print(lastNameController.text);
  print(profilePicUrl);
    await http.post(Uri.parse(CREATE_USER_PROFILE_URL),
        body: convert.jsonEncode({'username': usernameController.text,
          "firstName":firstNameController.text,"lastName":lastNameController.text,
          "profilePic":profilePicUrl})).then((response) async {

      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;

      setState(() {
        _loading = false;
      });
      if(response.statusCode == 400){

       ScaffoldMessenger.of(context).showSnackBar(SnackBar(padding:EdgeInsets.all(10),backgroundColor: Colors.red,content: Text(jsonResponse['message'])));
      }else if(response.statusCode == 200) {

        print('user id is :' +jsonResponse['userId']);
        await saveUserId(jsonResponse['userId']);
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomeScreen();
        }));
      }
    });




  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  String profilePicUrl = "https://images.unsplash.com/photo-1559214369-a6b1d7919865?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80";
 @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                          "Create Profile",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
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


              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),

              child:  Form(

                  key: formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Container(
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.network(profilePicUrl,
                            fit: BoxFit.cover,height: 100,width: 100,),
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:  TextFormField(


                          controller:usernameController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Please enter your username";
                            }else{
                              return null;
                            }

                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, ),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            hintText: "username",
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:  TextFormField(


                          controller:firstNameController,

                          validator: (value) {
                            if(value!.isEmpty){
                              return "Please enter your firstName";
                            }else{
                              return null;
                            }

                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),
                              
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, ),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!, ),

                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            hintText: "First Name",
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:  TextFormField(


                          controller:lastNameController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Please enter your lastName";
                            }else{
                              return null;
                            }

                          },

                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!, ),

                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary,),

                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: (Colors.grey[700])!,),

                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            hintText: "Last Name",
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
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20,vertical: 20)),
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)
                          ),
                            onPressed: (){
                              final FormState form = formKey.currentState!;
                            if(form.validate()){
                              form.save();
                              createUserProfile();
                              print("clicked");
                            }
                            }, child: Text('save profile')),
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
