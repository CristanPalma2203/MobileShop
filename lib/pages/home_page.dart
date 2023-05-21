import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_cliente_page.dart';
import 'list_client_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Parcial 04'),
            SizedBox(),
          ],
        ),
      ),
      body: ListClientPage(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddClientPage(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person),
                  SizedBox(height: 5.0),
                  Text('New'),
                ],
              ),
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 16.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddClientPage(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car),
                  SizedBox(height: 5.0),
                  Text('New'),
                ],
              ),
              backgroundColor: Colors.blue,
            ),
            SizedBox(height: 16.0),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddClientPage(),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment),
                  SizedBox(height: 5.0),
                  Text('New'),
                ],
              ),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
