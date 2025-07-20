import 'dart:math';

import 'package:flutter/material.dart';

import 'angle_slider.dart';
import 'animation_provider.dart';
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
  bool _translationFirst = false;
  late AnimationProvider _animationProvider;

  @override
  void initState() {
    super.initState();
    _animationProvider = AnimationProvider(
        duration: const Duration(seconds: 2),
        translationFirst: _translationFirst,
        callback: refresh);
  }

  @override
  void dispose() {
    _animationProvider.stopAnimation();
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mShear = Matrix4.identity();
    mShear.setEntry(
        0, 1, tan(shearX * _animationProvider.rotateAndShearFactor));

    var mTranslate = Matrix4.identity();
    mTranslate.setEntry(0, 3, moveX * _animationProvider.moveFactor);
    mTranslate.setEntry(1, 3, moveY * _animationProvider.moveFactor);

    var mTransform = Matrix4.identity();
    if (!_translationFirst) {
      mTransform.multiply(mTranslate);
    }

    mTransform.multiply(mShear);
    mTransform.multiply(
        Matrix4.rotationX(angleX * _animationProvider.rotateAndShearFactor));
    mTransform.multiply(
        Matrix4.rotationY(angleY * _animationProvider.rotateAndShearFactor));
    mTransform.multiply(
        Matrix4.rotationZ(angleZ * _animationProvider.rotateAndShearFactor));

    // the right-most factor in the matrix multiplication is the first  the vector gets multiplied with
    if (_translationFirst) {
      mTransform.multiply(mTranslate);
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text("3D Transformations with Matrix4",
              style: TextStyle(fontSize: 24)),
          centerTitle: true,
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
                foregroundImage: AssetImage("assets/images/flutter_logo.jpg")),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset("assets/images/fdg_logo.png")),
            ),
          ]),
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
                Opacity(
                    opacity: 0.7,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image.asset("assets/images/axis_y_down.jpg",
                          width: 130),
                    )),
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
                    "Transformation sequence: move ${_translationFirst ? "before" : "after"} rotate & shear",
                    style: const TextStyle(fontSize: 14)),
                //controlAffinity: ListTileControlAffinity.leading,
                value: _translationFirst,
                onChanged: (value) {
                  setState(() {
                    _translationFirst = value;
                    _animationProvider.translationFirst = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _animationProvider.stopAnimation();
                        _animationProvider.startAnimation();
                      });
                    },
                    child: const Text("Animate")),
                SizedBox(width: 100),
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
          ],
        ),
      ),
    );
  }
}
