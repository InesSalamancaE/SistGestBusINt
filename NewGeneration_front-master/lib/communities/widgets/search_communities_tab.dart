

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:newgeneration_front/communities/widgets/communities_tab.dart';
import 'package:newgeneration_front/search/widgets/searchTab.dart';

class searchCommunitiesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromRGBO(5, 2, 33, 1),
      body: Stack(
        children: [
          buildFloatingSearchBar(context),
          Padding(padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(icon: Icon(Icons.account_circle_outlined, color: Colors.white,)),
                  Tab(icon: Icon(Icons.supervised_user_circle, color: Colors.white,),)
                ],),
                TabBarView(children: [
                  SearchTab(),
                  CommunitiTab(),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
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
    physics: const BouncingScrollPhysics(),
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
          icon: const Icon(Icons.public),
          onPressed: () {
            //Pestaña de algoritmo =)
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