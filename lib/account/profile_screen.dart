import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<SharedPreferences> _prefs;
 Map<String, dynamic> _userProfileInfo = <String,dynamic>{};
  Future<String?>getUserId(){
    _prefs =   SharedPreferences.getInstance();

    return  _prefs.then((SharedPreferences sharedPreferences) {
      String? userId = sharedPreferences.getString('userId');
      return userId;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId().then((String? userId) async{
      if(userId != null){
        print("userId is "+userId);
        var url =
        Uri.https('5vafvrk8kj.execute-api.us-east-1.amazonaws.com','/dev/user/${userId}');

        await http.get(url).then((response){
          if (response.statusCode == 200) {
            var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
            print(jsonResponse);
           setState(() {
             _userProfileInfo = jsonResponse;
           });


          } else {
            print('Request failed with status: ${response.statusCode}.');
          }
        });
      }else{
        print("userId is null");
      }
    });
  }
  @override
  Widget build(BuildContext context) {


      return Expanded(
      child:  Container(
         padding: EdgeInsets.only(top:20,left: 10),
          child: Column(



            children: [
Row(
  children: [

    _userProfileInfo['profilePic'] == null ? Container(
        child:ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: Image.asset('assets/images/bg.jpg',
            fit: BoxFit.cover,height: 100,width: 100,),
        )
    ) :  Container(
      child:ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: FadeInImage(image: NetworkImage(_userProfileInfo['profilePic']),
            placeholder: AssetImage('assets/images/bg.jpg'),fit: BoxFit.cover,height: 100,width: 100,)



      ),),


   Container(
     padding: EdgeInsets.all(10),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Container(
             padding: EdgeInsets.only(bottom: 10),
             child: Text(_userProfileInfo['username']??"",style: TextStyle(fontSize: 20),)),
        Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(_userProfileInfo['lastName']??"",style: TextStyle(fontSize: 20),),

               Container(
                   padding: EdgeInsets.only(left: 5),
                   child: Text(_userProfileInfo['firstName']??"",style: TextStyle(fontSize: 20),))
             ],
           ),
         Container(


           child: ElevatedButton(

               style: ButtonStyle(
                   elevation: MaterialStateProperty.all(10),

                   backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)
               ),
               onPressed: (){}, child: Text('Edit Profile')),
         )

       ],
     ),
   )
  ],
)
            ],
          ),
        ),

    );
    }

}
