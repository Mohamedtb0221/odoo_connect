import 'package:flutter/material.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'pagetwo.dart';

final orpc = OdooClient('http://192.168.1.101:8069/');
String name='';
String pass='';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("odoo test"),
          centerTitle: true,
        ),
        body: const mywidget(),
      ),
    );
  }
}

class mywidget extends StatefulWidget {
  const mywidget({super.key});

  @override
  State<mywidget> createState() => _mywidgetState();
}

class _mywidgetState extends State<mywidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(onPressed: () async{
          try {
            final x = orpc.authenticate('testdb', 'odoo@gmail.com', 'mohamedtb21');
            name = 'odoo@gmail.com';
            pass = 'mohamedtb21';
          }on OdooException catch (e) {
            print("----------------------------------catch");
          }
          finally{
            print('---------rhcrhhcr--');
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>pagetwo()));
          }
        }, child: const Text("get data")),
      ),
    );
  }
}
