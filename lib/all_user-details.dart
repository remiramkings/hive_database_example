import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_project/data_service.dart';
import 'package:hive_project/user_form.dart';
import 'package:hive_project/user_item.dart';


class AllUserDetails extends StatefulWidget {
  const AllUserDetails({super.key});

  @override
  State<AllUserDetails> createState() => AllUserDetailsState();
}

class AllUserDetailsState extends State<AllUserDetails> {
  Future<Map<String, Map<dynamic, dynamic>>>? valuesFuture;
  int? valuesLength;
  Map<String, Map<dynamic, dynamic>>? value;

  @override
  void initState(){
    super.initState();
    loadData();
  }

  loadData() async{
    setState(() {
      valuesFuture = DataService.getInstance().getUserValues();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          
          children: [
            ElevatedButton(onPressed: (){
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UserForm() ,
                ),
              );
              }, child: const Text('Create new user')),
            valuesFuture == null ? const Text("Loading...") : Expanded(
              flex:1,
              child: FutureBuilder<Map<String, Map<dynamic, dynamic>>>(
                future: valuesFuture,
                builder: (context, snapshot) {
                  if(!snapshot.hasData || snapshot.data!.isEmpty){
                     return const Text('No data found');
                  }
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  Map<String, Map<dynamic, dynamic>> userDetailsMap = snapshot.data!;
                  List<Map<dynamic, dynamic>> userDetails = userDetailsMap.values.toList();
                return ListView.builder(
                  itemCount: userDetails.length,
                  itemBuilder: (context, index) {
                    return UserItem(userDetails: userDetails[index], onClick: loadData);
                },);
              },),
            ),
              
          ],
        ),
      ),
    );
  }
}