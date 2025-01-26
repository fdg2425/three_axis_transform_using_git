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
  var boxedAngleX = BoxedValue<double>(0);
  var boxedAngleY = BoxedValue<double>(0);
  var boxedAngleZ = BoxedValue<double>(0);

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
                  transform: Matrix4.rotationZ(boxedAngleZ.value),
                  child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(boxedAngleY.value),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(boxedAngleX.value),
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
            getAxisSlider("x-axis", Colors.red, boxedAngleX),
            getAxisSlider("y-axis", Colors.green, boxedAngleY),
            getAxisSlider("z-axis", Colors.blue, boxedAngleZ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    boxedAngleX.value = 0;
                    boxedAngleY.value = 0;
                    boxedAngleZ.value = 0;
                  });
                },
                child: const Text("Reset")),
          ],
        ),
      ),
    );
  }

  Row getAxisSlider(String title, Color color, BoxedValue<double> angle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: TextStyle(color: color)),
        Slider(
          value: angle.value,
          min: -2 * pi,
          max: 2 * pi,
          onChanged: (value) {
            setState(() {
              angle.value = value;
            });
          },
        ),
      ],
    );
  }
}

class BoxedValue<T> {
  BoxedValue(this.value);
  T value;
}

