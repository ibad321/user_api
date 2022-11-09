
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_api/model/usermodel.dart';


class Hompage extends StatefulWidget {
  const Hompage({Key? key}) : super(key: key);

  @override
  State<Hompage> createState() => _HompageState();
}

class _HompageState extends State<Hompage> {

  List<Usermodel> userlist=[];

  Future<List<Usermodel>> getuserApi()async{

    final responce=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(responce.body.toString());

    if(responce.statusCode==200){
      for(Map i in data){
        userlist.add(Usermodel.fromJson(i));
      }
      return userlist;
    }
    return userlist;


  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Api"),
      ),
      body: SafeArea(
        child: Column(
          children: [ 
                Expanded(
                  child: FutureBuilder(
                    future: getuserApi(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return  const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }
                      return  ListView.builder(
                          itemCount: userlist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                               child:Column(
                                children: [
                                  Rrow(title: "Name", value: userlist[index].name.toString()),
                                  Rrow(title: "UserName", value: userlist[index].username.toString()),
                                  Rrow(title: "Email", value: userlist[index].email.toString()),
                                  Rrow(title: "Phone", value: userlist[index].phone.toString()),
                                  Rrow(title: "Comapany", value: userlist[index].company.toString()),
                                  Rrow(title: "City", value: userlist[index].address!.city.toString()),
                                  Rrow(title: "Website", value: userlist[index].website.toString()),
                                
                                  
                                ],
                               ), 
                               
                              ),
                            );
                          },
                      );
                    },
                
                  ),
                ),
              ],
            ),
      ),
    );
     
  }
  
}
class Rrow extends StatelessWidget {
    String title,value;
   Rrow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ]
      ),
    );    
  }

}