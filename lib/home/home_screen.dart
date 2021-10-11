import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upstash_mobile/account/profile_screen.dart';
import 'package:upstash_mobile/api.dart';
import 'package:upstash_mobile/post/create_post.dart';

import 'package:http/http.dart' as http;
import 'package:upstash_mobile/post/models/post.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //Future<List<Order>> futureOrders;
  int _selectedIndex = 0;
  late Future<List<Post>> _posts;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _posts = fetchPosts(http.Client());

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
            ),
            child: FlexibleSpaceBar(
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
                    Text(
                      "Upstash Sample",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CreatePostScreen();
          }));
        },
        child: Icon(Icons.add),),
        body: Row(

          children: [
            NavigationRail(

                // minWidth: 40.0,
                // groupAlignment: 0.5,
                groupAlignment: 1,




                trailing: IconButton(
                  icon: Icon(Icons.logout), onPressed: () {  },
                ),


                selectedIndex: _selectedIndex,

                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if(index ==1 ){
                    print("clicked");

                  }
                },
                labelType: NavigationRailLabelType.selected,
                selectedLabelTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                destinations: [
                  NavigationRailDestination(

                      label: Text(""),
                      icon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/home.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          // color: color,

                        ),
                      ),
                      selectedIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/home.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          color: Theme.of(context).colorScheme.secondary,

                        ),
                      )),

                  NavigationRailDestination(
                      label: Text(""),

                      icon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/chats.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          // color: color,

                        ),
                      ),
                      selectedIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/chats.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          color: Theme.of(context).colorScheme.secondary,

                        ),
                      )),

                  NavigationRailDestination(
                      label: Text(""),


                      icon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/profile.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          // color: color,

                        ),
                      ),
                      selectedIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/profile.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          color: Theme.of(context).colorScheme.secondary,

                        ),
                      )),
                  NavigationRailDestination(
                      label: Text(""),

                      icon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/notification.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          // color: color,

                        ),
                      ),
                      selectedIcon: Padding(
                        padding: EdgeInsets.all(5),
                        child:SvgPicture.asset(
                          "assets/svg/notification.svg",

                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                          color: Theme.of(context).colorScheme.secondary,

                        ),
                      )),


                ],
              ),

            VerticalDivider(thickness: 1, width: 1),
             _selectedIndex == 2 ? ProfileScreen() :
            Expanded(child: FutureBuilder<List<Post>>(
              future: _posts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post>? posts = snapshot.data;
                  if(posts != null){
                    return ListView.builder(itemBuilder: (context,index){
                      return  Card(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.network(
                            posts[index].postAdmin!.profilePic!,
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                          ),
                      ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Text(posts[index].postAdmin!.username!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Text(posts[index].postText!),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      posts[index].postImage!,
                                      fit: BoxFit.cover,
                                      height: 150,
                                      width: size.width,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                            ],
                          ),
                        ),
                      );
                    },itemCount: posts.length,);
                  }

                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Container(
                    height: 40,
                    width: 40,

                    child: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary))));
              },
            ))


          ],
        )
    );
  }

}
