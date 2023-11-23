import 'package:flutter/material.dart';

class AllCheckinsCheckoutPage extends StatelessWidget {
  const AllCheckinsCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
          child: Center(
            child: Text('Checkin and Out'),
          )),
    );
  }
}
