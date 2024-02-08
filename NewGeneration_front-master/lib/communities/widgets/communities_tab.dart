import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

// The carroussel is in https://www.geeksforgeeks.org/flutter-carousel-slider/

class CommunitiTab extends StatelessWidget {
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
          //buildFloatingSearchBar(context),
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;


    return FloatingSearchBar(
      hint: 'Search...',
      backgroundColor: Colors.white.withOpacity(.05),
      borderRadius: BorderRadius.circular(30),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const NeverScrollableScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.add_circle, color: Color.fromRGBO(5, 2, 33, 1),),
            onPressed: () {
              //Pestaña de crear comunidad
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white.withOpacity(.05),
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget searchPage(BuildContext context){

    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 2, 33, 1),

      body: Center(
        child: Container(
          color: const Color.fromRGBO(5, 2, 33, 1),
          child: Padding(
              padding: const EdgeInsets.only( top: 70.0),
              child: ListView(
                  children: [
                    Expanded(child: Row(
                        children: const <Widget>[
                          SizedBox(width: 15,),
                          Expanded(

                            child: Text('My communities', textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                    )
                    ),

                    const SizedBox(height: 15,),

                    CarouselSlider(items: [
                      myCommunities('Sinfónica Palma', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('Vida es vida', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('My real food community', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('Frases inspiracionales', "assets/sea-gcbc3cf33f_1280.jpg"),

                    ],

                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 0.42,
                        aspectRatio: 2.09,
                        initialPage: 1,
                      ),
                    ),



                    Expanded(child: Row(
                        children: const <Widget>[
                          SizedBox(width: 15,),
                          Expanded(

                            child: Text('My creations', textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ]
                    )
                    ),

                    SizedBox(height: 15,),

                    CarouselSlider(items: [
                      myCommunities('La cocina vegana', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('Las moscas', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('Aurea', "assets/sea-gcbc3cf33f_1280.jpg"),
                      myCommunities('Cumpleaños de Paula', "assets/sea-gcbc3cf33f_1280.jpg"),

                    ],

                      options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: false,
                        viewportFraction: 0.42,
                        aspectRatio: 2.0,
                        initialPage: 1,
                      ),
                    ),
                    SizedBox(height: 20,),

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
              borderRadius: BorderRadius.circular(30),
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
                borderRadius: BorderRadius.circular(30),
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

  Widget myCommunities(String name, String image){
    double widthBox = 150;
    double heightBox = 160;
    return  SizedBox(
      width: widthBox,
      height: heightBox,

      child: Stack(
        children: <Widget>[
          Container(
            width: widthBox,
            height: heightBox,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 0.8,),
              color: Color(0x66bbbbbb).withOpacity(0.06),

            ),
          ),
          Column(
            children: [
              const SizedBox(height: 9,),
              Container(
                width: 100,
                height: 100,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
              Center(
                child: Padding(
                    padding: const EdgeInsets.only( top: 10.0, right: 5, left: 5),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                      ),
                    )
                ),


              )
            ],
          ),
        ],
      ),
    );



  }

}