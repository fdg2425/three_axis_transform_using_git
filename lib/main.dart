import 'dart:math';

import 'package:flutter/material.dart';

import 'angle_slider.dart';
import 'pixel_slider.dart';

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
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, surface: Colors.blue.shade100),
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
  double moveX = 0;
  double moveY = 0;
  double shearX = 0;
  bool translationFirst = false;

  @override
  Widget build(BuildContext context) {
    var mShear = Matrix4.identity();
    mShear.setEntry(0, 1, tan(shearX));

    var mTranslate = Matrix4.identity();
    mTranslate.setEntry(0, 3, moveX);
    mTranslate.setEntry(1, 3, moveY);

    var mTransform = Matrix4.identity();
    if (!translationFirst) {
      mTransform.multiply(mTranslate);
    }

    mTransform.multiply(mShear);
    mTransform.multiply(Matrix4.rotationX(angleX));
    mTransform.multiply(Matrix4.rotationY(angleY));
    mTransform.multiply(Matrix4.rotationZ(angleZ));

    // the right-most factor in the matrix multiplication is the first  the vector gets multiplied with
    if (translationFirst) {
      mTransform.multiply(mTranslate);
    }

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
                  transform: mTransform,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset("assets/images/snoopy_laptop.jpg",
                          width: 230)),
                ),
                const SizedBox(width: 40),
                Image.asset("assets/images/axis_y_down.jpg", width: 130),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AngleSlider(
                      title: "rotateX",
                      color: Colors.red,
                      angle: angleX,
                      callback: (value) {
                        setState(() {
                          angleX = value;
                        });
                      },
                    ),
                    AngleSlider(
                      title: "rotateY",
                      color: Colors.green,
                      angle: angleY,
                      callback: (value) {
                        setState(() {
                          angleY = value;
                        });
                      },
                    ),
                    AngleSlider(
                      title: "rotateZ",
                      color: Colors.blue,
                      angle: angleZ,
                      callback: (value) {
                        setState(() {
                          angleZ = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                Column(
                  children: [
                    PixelSlider(
                      title: "moveX",
                      color: Colors.red,
                      offset: moveX,
                      callback: (value) {
                        setState(() {
                          moveX = value;
                        });
                      },
                    ),
                    PixelSlider(
                      title: "moveY",
                      color: Colors.green,
                      offset: moveY,
                      callback: (value) {
                        setState(() {
                          moveY = value;
                        });
                      },
                    ),
                    AngleSlider(
                      title: "shearX",
                      color: Colors.pink,
                      angle: shearX,
                      minMaxAbsolute: pi,
                      callback: (value) {
                        setState(() {
                          shearX = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              width: 500,
              child: SwitchListTile(
                title: Text(
                    "Transformation sequence: move ${translationFirst ? "before" : "after"} rotate & shear",
                    style: const TextStyle(fontSize: 14)),
                //controlAffinity: ListTileControlAffinity.leading,
                value: translationFirst,
                onChanged: (value) {
                  setState(() {
                    translationFirst = value;
                  });
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    angleX = 0;
                    angleY = 0;
                    angleZ = 0;
                    moveX = 0;
                    moveY = 0;
                    shearX = 0;
                  });
                },
                child: const Text("Reset")),
          ],
        ),
      ),
    );
  }
}
