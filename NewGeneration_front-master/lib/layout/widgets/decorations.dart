import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget{

  //Arguments we need for generating the box
  final double width;
  final double height;
  final Widget child;
  //Widget that takes the mesurements of a box and provides a glass box with that mesurements
  const GlassBox({required Key key,required this.width, required this.height, required this.child}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
            width: width,
            height: height,
          child: Stack(
            children: [
            BackdropFilter(filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ), child: Container(width: width, height: height),),
            Container(
              decoration: BoxDecoration(
                //Rounded borders and shadows
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 30),
                ],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
                gradient: LinearGradient(
                  //We need a source of ligth that will start at the top left and end at bottom right
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //Adding the colors to the glass and the opacity
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.2)
                    ],
                    //Setiting when the colors start, in between there is a gradiant
                    stops: [0.0,1.0]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}