import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    ;
    _animationController.repeat(reverse: true);
    _animationController2.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    super.dispose();
  }

  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  ).animate(
    CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.easeInToLinear),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animação Bolinha'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent.shade100,
        onPressed: () {
          if (_animationController.isAnimating) {
            _animationController.stop();
            _animationController2.stop();
          } else {
            _animationController.repeat(reverse: true);
          }
        },
        child: Icon(
          Icons.back_hand,
          color: Colors.deepPurple.shade900,
        ),
      ),
      body: AlignTransition(
        alignment: _animation,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: RotationTransition(
              turns: _animationController2,
              child: Icon(
                Icons.sports_basketball,
                size: 75,
              ),
            )
            //CircleAvatar(backgroundColor: Colors.orange),
            ),
      ),
    );
  }
}
