// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class Tab1Widget extends StatefulWidget {
//   @override
//   State<Tab1Widget> createState() => _Tab1WidgetState();
// }

// class _Tab1WidgetState extends State<Tab1Widget> {
//   @override
//   void deactivate() {
//     print('deactivate');
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     print('dispose');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Tab 1 Content'),
//     );
//   }
// }

// class Tab2Widget extends StatefulWidget {
//   @override
//   State<Tab2Widget> createState() => _Tab2WidgetState();
// }

// class _Tab2WidgetState extends State<Tab2Widget> {
//   @override
//   void deactivate() {
//     print('deactivate');
//     super.deactivate();
//   }

//   @override
//   void dispose() {
//     print('dispose');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Tab 2 Content'),
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Tab Example'),
//         ),
//         body: IndexedStack(
//           index: _currentIndex,
//           children: [
//             Tab1Widget(),
//             Tab2Widget(),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.tab),
//               label: 'Tab 1',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.tab),
//               label: 'Tab 2',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: MyApp(
    child: Child(),
    foo: false,
  )));
}

class Child extends StatefulWidget {
  const Child({super.key});

  @override
  State<Child> createState() => _ChildState();
}

class _ChildState extends State<Child> {
  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Sample container'),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Foo(GlobalKey()),
                      ),
                    );
                  },
                  child: const Text('Foo'))
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  final Widget child;
  final bool foo;

  MyApp({
    Key? key,
    required this.child,
    required this.foo,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _key = GlobalKey();

  // late Widget child;

  // bool foo = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final child = KeyedSubtree(key: _key, child: widget.child);

    if (widget.foo) {
      return ChildDisplay(child: child);
    }
    return child;
  }
}

class ChildDisplay extends StatefulWidget {
  final Widget child;
  const ChildDisplay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ChildDisplay> createState() => _ChildDisplayState();
}

class _ChildDisplayState extends State<ChildDisplay> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class Foo extends StatefulWidget {
  @override
  State<Foo> createState() => _FooState();

  const Foo(key) : super(key: key);
}

class _FooState extends State<Foo> {
  bool _switchValue = false;
  double _sliderValue = 0.5;

  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Switch(
            value: _switchValue,
            onChanged: (v) {
              setState(() => _switchValue = v);
            },
          ),
          Slider(
            value: _sliderValue,
            onChanged: (v) {
              setState(() => _sliderValue = v);
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(
                            child: Child(),
                            foo: true,
                          )));
            },
            child: Text('Foo'),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('back')),
        ],
      ),
    );
  }
}
