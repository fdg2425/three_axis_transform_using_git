import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade100),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double angleX = 0;
  double angleY = 0;
  double angleZ = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title:
            const Text("Transform with 3 axis", style: TextStyle(fontSize: 24)),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
              foregroundImage: AssetImage("assets/images/flutter_logo.jpg")),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(angleZ),
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(angleY),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(angleX),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(
                                "assets/images/snoopy_laptop.jpg",
                                width: 230)),
                      )),
                ),
                const SizedBox(width: 20),
                Image.asset("assets/images/axis.jpg", width: 130),
              ],
            ),
            getAxisSlider("x-axis", Colors.red, angleX),
            getAxisSlider("y-axis", Colors.green, angleY),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    angleX = 0;
                    angleY = 0;
                    angleZ = 0;
                  });
                },
                child: const Text("Reset")),
          ],
        ),
      ),
    );
  }

  Row getAxisSlider(String title, Color color, double angle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: color)),
        Slider(
          value: angle,
          min: -2 * pi,
          max: 2 * pi,
          onChanged: (value) {
            setState(() {
              angle = value;
            });
          },
        ),
      ],
    );
  }
}
