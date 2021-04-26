import 'package:admin/views/screens/matches/add_match.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MatchesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
          Get.to(AddMatch());
        },),
        appBar: AppBar(
          title: Text('Matches'),
          bottom: TabBar(tabs: [
            Text('Today'),
            Text('Upcoming'),
            Text('Completed'),
          ]),
        ),
        body: TabBarView(children: [
          _getMatches('today'),
          _getMatches('upcoming'),
          _getMatches('completed'),
        ]),
      ),
    );
  }


  Widget _getMatches(String type){
    return Text(type);
  }
}
