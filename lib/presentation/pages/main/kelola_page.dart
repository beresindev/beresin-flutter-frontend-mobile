import 'package:flutter/material.dart';
import 'package:mobile_beresin/common/theme.dart';

class KelolaPage extends StatefulWidget {
  const KelolaPage({Key? key}) : super(key: key);

  @override
  State<KelolaPage> createState() => _KelolaPageState();
}

class _KelolaPageState extends State<KelolaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: const Scaffold(
          body: Center(
            child: Text(
              'Coomingsoon',
            ),
          ),
        ));
  }
}
