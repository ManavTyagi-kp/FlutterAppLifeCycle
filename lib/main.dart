import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_lifecycle/column.dart';
import 'package:widget_lifecycle/deactivate.dart';
import 'package:widget_lifecycle/riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 35, 76)),
        useMaterial3: true,
      ),
      home: LifeCycleExm(),
    );
  }
}

class LifeCycleExm extends ConsumerStatefulWidget {
  @override
  ConsumerState<LifeCycleExm> createState() => _LifeCycleExmState();
}

class _LifeCycleExmState extends ConsumerState<LifeCycleExm>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(timeProvider.notifier).start(50);
    print("initState");
  }

  @override
  void didChangeDependencies() {
    print('did change dependency');
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      print('AppLifecycleState.inactive');
    } else if (state == AppLifecycleState.paused) {
      print('AppLifecycleState.paused');
    } else if (state == AppLifecycleState.resumed) {
      print('AppLifecycleState.resumed');
    } else if (state == AppLifecycleState.detached) {
      print('AppLifecycleState.detached');
    }
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   print('AppLifecycleState: $state');
  // }

  @override
  void dispose() {
    print('dispose');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    print("main deactivate");
    super.deactivate();
  }

  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Widget Lifecycle"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              ref.watch(timeProvider).when(data: (value) {
                return '$value';
              }, error: (error, stackTrace) {
                return '$error';
              }, loading: () {
                return 'Loading...';
              }),
            ),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWidget()),
                  );
                  // deactivate();
                  // dispose();
                },
                child: const Text('App Lifecycle'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initState();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
