import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          //textTheme:
          accentColor: Colors.white,
        )
    );

    return Scaffold(

      backgroundColor: const Color.fromRGBO(5, 2, 33, 1),
      body: Center(
        child: Container(
          color: const Color.fromRGBO(5, 2, 33, 1),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: ListView(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: EdgeInsets.only(top: size.height * .001, bottom: size.height * .03),
                      child: Image.asset('assets/logotipo.png')
                  ),
                ),
                Expanded(child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text('Login', textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 33)),
                      ),
                    ]
                )
                ),
                Expanded(child: Row(
                    children: const <Widget>[
                      Expanded(
                        child: Text('Please sign in to continue', textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white, fontSize: 15)),
                      ),
                    ]
                )
                ),

                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.06),
                      child: Column(
                        children: [
                          component1(
                              Icons.email_outlined, 'Email...', false, true),
                          const SizedBox(height: 15),
                          component1(
                              Icons.lock_outline, 'Password...', true, false),
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                component2(
                                  'LOGIN',
                                  3.00,
                                      () {
                                    HapticFeedback.lightImpact();
                                    Fluttertoast.showToast(
                                        msg: 'Login button pressed');
                                  },
                                ),
                                SizedBox(width: size.width / 10),
                                Container(
                                  margin: EdgeInsets.all(0.02),
                                  child: TextButton(
                                    child: Text('Forgot password?', style: TextStyle(fontSize: 13.0, color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),),
                        ],
                      ),)
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.all(0.02),
                        child: TextButton(
                          child: Text('Don\'t have an account? Sign up', style: TextStyle(fontSize: 13.0, color: Colors.white)
                            ,
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            style: TextStyle(color: Colors.white.withOpacity(.8)),
            cursorColor: Colors.white,
            obscureText: isPassword,
            keyboardType:
            isEmail ? TextInputType.emailAddress : TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.white.withOpacity(.7),
              ),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
              TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
          ),
        ),
      ),
    );
  }

  Widget component2(String string, double width, VoidCallback voidCallback) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: voidCallback,
          child: Container(
            height: size.width / 8,
            width: size.width / width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              string,
              style: TextStyle(color: Color.fromRGBO(5, 2, 33, 1)),
            ),
          ),
        ),
      ),
    );
  }

}
