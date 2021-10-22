import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;

void main() {
  TorchController().initialize();
  runApp(const FlashLight());
}

class FlashLight extends StatefulWidget {
  const FlashLight({Key? key}) : super(key: key);

  @override
  State<FlashLight> createState() => _FlashLightState();
}

class _FlashLightState extends State<FlashLight> {
  final controller = TorchController();
  double? intensity;
  Color buttonColor = Colors.white70;

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      intensity = 1;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Flashlite',
              style: TextStyle(
                color: Colors.white,
                fontSize: 35.0,
                fontFamily: GoogleFonts.mPlusRounded1c().fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color(0xFF080516),
            elevation: 0.0,
          ),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF080518),
              Color(0xFF0B051B),
            ])),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    counterClockwise: false,
                    infoProperties: InfoProperties(
                      mainLabelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontFamily: GoogleFonts.mPlusRounded1c().fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    spinnerMode: false,
                    startAngle: 90,
                    animationEnabled: true,
                    angleRange: 360,
                    size: 250,
                    customColors: CustomSliderColors(
                      dynamicGradient: true,
                      trackColor: const Color(0xFF301c5b),
                      progressBarColors: const [
                        Color(0xFFA30B6E),
                        Color(0xFFBF610D),
                        Color(0xFFdbaf3f),
                      ],
                    ),
                    customWidths: CustomSliderWidths(
                      handlerSize: 13.0,
                      progressBarWidth: 26.0,
                      trackWidth: 26.0,
                    ),
                  ),
                  min: 0,
                  max: 100,
                  initialValue: 0,
                  onChange: (double value) {
                    setState(() {
                      intensity = value / 100;
                    });
                  },
                ),
                const SizedBox(
                  height: 50.0,
                ),
                GestureDetector(
                  onTap: platform == TargetPlatform.iOS
                      ? () {
                          controller.toggle(
                            intensity: intensity,
                          );
                        }
                      : () {
                          controller.toggle();
                        },
                  child: Container(
                    height: 85.0,
                    width: 85.0,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        size: 42,
                        color: Color(0xFF080516),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
