import 'package:crmacsinsights/Features/Splash/SplashController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 60), // Optional top spacing
            Center(
              child: Container(
                width: 250,
                child: SvgPicture.asset("assets/Icons/acslogo_light.svg",height: 200,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20), // Bottom padding
              child: Text(
                "Develop by ACS Insights",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),),
              ),
          ],
        ),
      ),
    );
  }
}
