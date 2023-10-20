import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tween Animation',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: TweenAnimation(),
    );
  }
}

class TweenAnimation extends StatefulWidget {
  TweenAnimation({super.key});

  @override
  State<TweenAnimation> createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation>
    with SingleTickerProviderStateMixin {
  double begin = 0.2;

  double end = 0.4;

  bool scale = true;
  bool selected = true;
  bool block = false;
  late AnimationController _controller;
  late Animation<Color?> _animation;
  late Widget _animatedModalBarrier;

  @override
  void initState() {
    ColorTween tween = ColorTween(
      begin: Colors.orangeAccent.withOpacity(0.5),
      end: Colors.blue.withOpacity(0.5),
    );
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = tween.animate(_controller);

    _animatedModalBarrier = AnimatedModalBarrier(
      color: _animation,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: begin, end: end),
              duration: const Duration(seconds: 1),
              builder: (context, value, child) {
                // print(value);
                return Transform.scale(
                    scale: value,
                    child: const Icon(
                      Icons.sports_baseball_rounded,
                      size: 200,
                    ));
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  print(selected);
                  selected = !selected;
                  if (end >= 0.9) {
                    scale = false;
                    begin += 0.2;
                    end += 0.2;
                    print(scale);
                  }
                  if (scale == false && end > 1.3) {
                    print(scale);
                    scale = true;
                    begin = 0.2;
                    end = 0.4;
                  } else {
                    begin += 0.2;
                    end += 0.2;
                  }
                });
              },
              child: Text(scale ? 'Scale' : 'Reset'),
            ),
            // const SizedBox(
            //   height: 150,
            // ),
            InkWell(
              onTap: () {
                setState(() {
                  print(selected);
                  selected = !selected;
                });
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                color: selected ? Colors.blue : Colors.lightBlueAccent,
                curve: Curves.fastOutSlowIn,
                height: selected ? 50 : 100,
                width: selected ? 100 : 50,
                child: const FlutterLogo(
                  size: 15,
                ),
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(seconds: 2),
              firstChild: const FlutterLogo(
                  style: FlutterLogoStyle.horizontal, size: 100.0),
              secondChild: const FlutterLogo(
                  style: FlutterLogoStyle.stacked, size: 100.0),
              crossFadeState: selected
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: selected ? 25 : 18,
                color: selected ? Colors.blue : Colors.lightBlueAccent,
              ),
              duration: Duration(seconds: 1),
              child: Text('Animations'),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedPhysicalModel(
              shape: BoxShape.rectangle,
              elevation: selected ? 0 : 10.0,
              color: selected ? Colors.lightBlueAccent : Colors.blue,
              shadowColor: Colors.black,
              duration: Duration(seconds: 2),
              child: const SizedBox(
                height: 100,
                width: 100,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        block = true;
                      });
                      _controller.reset();
                      _controller.forward();
                      Future.delayed(const Duration(seconds: 10), () {
                        setState(() {
                          block = false;
                        });
                      });
                    },
                    child: const Text('Block Me'),
                  ),
                  if (block) _animatedModalBarrier,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
