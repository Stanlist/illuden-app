
import 'package:flutter/material.dart';
import 'package:illuden/widgets/bluetooth_bar/bloc/bluetooth_page.dart';
import 'page2.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Column(
        children: [
          BluetoothPage(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              },
              child: const Text('Go to Page 2'),
            ),
          ),
        ],
      ),
    );
  }
}