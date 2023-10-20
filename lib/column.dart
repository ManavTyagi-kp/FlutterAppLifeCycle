import 'package:flutter/material.dart';
import 'package:widget_lifecycle/deactivate.dart';
import 'package:widget_lifecycle/main.dart';

class Columns extends StatefulWidget {
  const Columns({super.key});

  @override
  State<Columns> createState() => _ColumnsState();
}

class _ColumnsState extends State<Columns> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Cycle'),
      ),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LifeCycleExm(),
              MyWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
