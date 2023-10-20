import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widget_lifecycle/riverpod.dart';

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key});

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  void dispose() {
    print('deactivate dispose');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    // ref.read(timeProvider.notifier).start(50);
    print("initState");
  }

  @override
  void didChangeDependencies() {
    print('did change dependency');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deactivate Example'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer(builder: (context, ref, _) {
              return Text(
                ref.watch(timeProvider).when(data: (value) {
                  return '$value';
                }, error: (error, stackTrace) {
                  return '$error';
                }, loading: () {
                  return 'Loading...';
                }),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}
