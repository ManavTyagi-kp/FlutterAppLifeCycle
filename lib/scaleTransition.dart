import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
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
      home: const TransitionWidget(),
    );
  }
}

class TransitionWidget extends StatefulWidget {
  const TransitionWidget({super.key});

  @override
  State<TransitionWidget> createState() => _TransitionWidgetState();
}

class _TransitionWidgetState extends State<TransitionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    lowerBound: 0.4,
    upperBound: 1.0,
    duration: const Duration(seconds: 3),
    vsync: this,
  );
  late final Animation<double> _animation;
  // bool animate = true;

  @override
  void initState() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.stop();
    // _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                height: 200,
                width: 200,
                color: Colors.blue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // _animation.isDismissed;
                  // animate ? _controller.forward() : _controller.reset();
                  _controller.forward();
                  Future.delayed(Duration(seconds: 1), () {
                    _controller.stop();
                  });
                });
              },
              // child: Text(animate ? 'Scale' : 'Reset')),
              child: Text('Scale'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.reset();
                });
              },
              // child: Text(animate ? 'Scale' : 'Reset')),
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
