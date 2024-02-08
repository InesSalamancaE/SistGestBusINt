import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

// The carroussel is in https://www.geeksforgeeks.org/flutter-carousel-slider/

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      // This is handled by the search bar itself.
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(5, 2, 33, 1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //body that goes under
          searchPage(context),
        ],
      ),
    );
  }

  Widget searchPage(BuildContext context){

    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 2, 33, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(5, 2, 33, 1),

      ),
      body: Center(
        child: Container(
          color: const Color.fromRGBO(5, 2, 33, 1),
          child: Padding(
              padding: const EdgeInsets.only( top: 30.0),
              child: ListView(
                  children: [
                    Expanded(child: Row(
                        children: const <Widget>[
                          SizedBox(width: 15,),
                          Expanded(

                            child: Text('Top Profiles', textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                    )
                    ),

                    const SizedBox(height: 20,),

                    CarouselSlider(items: [
                      topProfile('xisco', "assets/sea-gcbc3cf33f_1280.jpg"),
                      topProfile('toni', "assets/sea-gcbc3cf33f_1280.jpg"),
                      topProfile('andrea', "assets/sea-gcbc3cf33f_1280.jpg"),
                      topProfile('paula', "assets/sea-gcbc3cf33f_1280.jpg"),

                    ],

                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 0.697,
                        aspectRatio: 2.25,
                        initialPage: 1,
                      ),
                    ),

                    SizedBox(height: 10,),

                    Expanded(child: Row(
                        children: const <Widget>[
                          SizedBox(width: 15,),
                          Expanded(

                            child: Text('Discover', textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                    )
                    ),

                    SizedBox(height: 20,),

                    CarouselSlider(items: [
                      discoverProfiles('xisco', "assets/sea-gcbc3cf33f_1280.jpg", 100),
                      discoverProfiles('toni', "assets/sea-gcbc3cf33f_1280.jpg", 20),
                      discoverProfiles('andrea', "assets/sea-gcbc3cf33f_1280.jpg", 50),
                      discoverProfiles('paula', "assets/sea-gcbc3cf33f_1280.jpg", 10000),

                    ],

                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 0.45,
                        aspectRatio: 2.25,
                        initialPage: 1,
                      ),
                    ),
                    SizedBox(height: 35,),

                    Expanded(child: Row(
                        children: const <Widget>[
                          SizedBox(width: 15,),
                          Expanded(
                            child: Text('New posts', textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                    )
                    ),

                    SizedBox(height: 20,),

//Para hacer el grid de fotos estaría bien que el usuario no tuviera que esperarlas, es decir que llegado a un punto se cargaran las siguientes
//Posible librería: https://pub.dev/packages/flutter_pagewise
                    // Video explicativo guay: https://www.youtube.com/watch?v=eENDlIgadr4

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(0.1),
                        child: grid(context, "assets/sea-gcbc3cf33f_1280.jpg"),
                      ),

                    ),




                  ])

          ),
        ),
      ),
    );

  }
  Widget topProfile(String name, String image){
    double widthBox = 240;
    double heightBox = 150;

    return  SizedBox(
      width: widthBox,
      height: heightBox,
      child: Stack(
        children: <Widget>[
          Container(
            width: widthBox,
            height: heightBox,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white70,
                width: 0.25,
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),),
          Container(
              width: widthBox,
              height: heightBox,


              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment(0,0.4),
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.white38.withAlpha(0),
                    Colors.white30.withOpacity(0.4),
                    Colors.white30.withOpacity(0.6)
                  ],
                ),
              ),
              child: Text(
                name,
                textAlign: TextAlign.end,
                style: const TextStyle(

                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),)
          ),
        ],
      ),
    );



  }
  List<Widget> imageList (String image, BuildContext context){
    List<Widget> list = [];
    list.add(_buildPlace(image, context));
    list.add(_buildPlace(image, context));
    list.add(_buildPlace(image, context));
    list.add(_buildPlace(image, context));
    list.add(_buildPlace(image, context));
    return list;
  }
  Widget grid(BuildContext context, String image){
    return Container(
      padding: const EdgeInsets.all(0.1),
      child: Column(
        children: imageList(image, context),
      ),
    );

  }
  /*Future<List<dynamic>> generateProductList() async {

    final List<dynamic> employeesData = [];

    final String responseBody =
    await rootBundle.loadString("assets/product_data.json");

    var data = await json.decode(responseBody);

    data = data[0]['DETAIL'];

    for (final val in data) {

      employeesData.add(val);

    }
    _employeeDataGridSource = EmployeeDataGridSource(employees: employeesData);

    return Future<List<dynamic>>.value(data);
  }*/


  Widget _buildPlace(String image, BuildContext context) {
    double width = MediaQuery.of(context).size.width/3 -1;

    return Container(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            SizedBox(width: 0.7,),
            SizedBox(
              height: width,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 0.18,
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 0.5,),
            SizedBox(
              height: width,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 0.18,
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 0.5,),
            SizedBox(
              height: width,
              width: width,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: 0.18,
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

          ],
        ));

  }

  Widget discoverProfiles(String name, String image, int likes){
    double widthBox = 150;
    double heightBox = 320;
    return  SizedBox(
      width: widthBox,
      height: heightBox,

      child: Stack(
        children: <Widget>[
          Container(
            width: widthBox,
            height: heightBox,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white, width: 0.8,),
              color: Color(0x66bbbbbb).withOpacity(0.05),

            ),
          ),
          Column(
            children: [
              const SizedBox(height: 9,),
              Container(
                width: 130,
                height: 130,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white70,
                    width: 0.18,
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 6.0),
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      )
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only( top: 6.0, right: 16.0),
                    child: Row(
                      children: [

                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                            children: [
                              WidgetSpan(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                                    child: Icon(Icons.favorite, color: Colors.white, size: 15,)),
                              ),
                              TextSpan(text: likes.toString()),
                            ],
                          ),
                        )
                      ],
                    ),

                  )

                ],
              )
            ],
          ),
        ],
      ),
    );



  }

}