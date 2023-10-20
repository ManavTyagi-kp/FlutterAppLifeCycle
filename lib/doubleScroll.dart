import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double Scroll App',
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Icon(
            Icons.add,
            size: 1500,
          ),
        ),
      ),
    );
  }
}

class DoubleScroll extends StatelessWidget {
  const DoubleScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Container(
              height: 2000,
              // width: 5000,
              // child: GridView(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 50),
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     for (int i = 0; i < 5000; i++)
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Container(
              //           color: Colors.red,
              //           height: 500,
              //           width: 500,
              //         ),
              //       ),
              //   ],
              // ),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, i) {
                    return const Icon(
                      Icons.add,
                      size: 1500,
                    );
                  }),
              // child: GridView(
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 12),
              //   scrollDirection: Axis.horizontal,
              //   children: [
              //     for (int i = 0; i < 500; i++)
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Container(
              //           color: Colors.red,
              //           height: 500,
              //           width: 500,
              //         ),
              //       ),
              //   ],
              // ),
            );
          }),
    );
  }
}
