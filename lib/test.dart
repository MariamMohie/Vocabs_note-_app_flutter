import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Test extends StatelessWidget {
  Test({super.key});
  late Box box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  box = await Hive.openBox("test");
                },
                child: Text('Open Box')),
                
                ElevatedButton(
                onPressed: () {
                box.putAll({
                  "Name": "Mariam" ,
                   "age": 22,
                   } );
                },
                child: Text('Put Data')),
                
                
                ElevatedButton(
                onPressed: ()  {
                  print(box.get("Name"));
                  print(box.get("age"));
                },
                child: Text('Display Data'))
          ],
        ),
      ),
    );
  }
}
