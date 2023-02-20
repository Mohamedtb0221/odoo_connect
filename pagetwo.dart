

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

class pagetwo extends StatelessWidget {
  pagetwo({super.key});

  final orpc = OdooClient('http://192.168.1.101:8069/');

Future<dynamic> check() async{
  await orpc.authenticate('testdb', 'odoo@gmail.com', 'mohamedtb21');

}

Future<dynamic> fetchcontacts() async{
  await check();
  return orpc.callKw({
     'model':'res.partner',
     'method':'search_read',
     'args':[],
     'kwargs':{
      'context': {'bin_size': true},
        'domain': [],
        'fields': ['id', 'name', 'email', '__last_update', 'image_128'],
        'limit': 80,
     }
  });
}
Widget buildListItem(Map<String,dynamic> record){
  return ListTile(
    leading: Text(record['id'].toString()),
    title:Text(record['name']), 
    subtitle:Text(record['email'] is String ? record['email'] : '') ,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("contacts odoo"),centerTitle: true,),
      body: Center(
        child: FutureBuilder(
          future: fetchcontacts(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final record=snapshot.data[index] as Map<String,dynamic>;
                  return buildListItem(record);
                },
              );
            }
            else{
              if (snapshot.hasError) {
                return Text("something went wrong"); 
              }
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}