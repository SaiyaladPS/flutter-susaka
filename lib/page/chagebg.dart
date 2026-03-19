import 'package:flutter/material.dart';
import 'dart:math';

class ChangeBgPage extends StatefulWidget {
  const ChangeBgPage({super.key});

  @override
  State<ChangeBgPage> createState() => _ChangeBgPageState();
}

class _ChangeBgPageState extends State<ChangeBgPage> {
  Color _bgColor = Colors.white;
  final Random _random = Random();

  void _changeColorRandomly() {
    setState(() {
      _bgColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        title: const Text(
          'ປ່ຽນສີພື້ນຫຼັງ (Random BG)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          ),
          onPressed: _changeColorRandomly,
          child: const Text(
            'ປ່ຽນສີ (Random Color)',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Noto Sans Lao',
            ),
          ),
        ),
      ),
    );
  }
}
