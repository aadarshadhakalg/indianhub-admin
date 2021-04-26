import 'package:admin/controller/teams/teams_controller.dart';
import 'package:admin/models/team_model.dart';
import 'package:admin/views/screens/Teams/add_team.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamsScreen extends StatefulWidget {
  @override
  _TeamsScreenState createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final TeamsController _teamsController = Get.find<TeamsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddTeam());
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Teams'),
      ),
      body: FutureBuilder(
        future: _teamsController.getAllTeams(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TeamModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.none) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data![index].teamImage),
                      ),
                      title: Text(snapshot.data![index].teamName),
                    );
                  },
                ),
              );
            } else {
              return Center(
                child: Text('No Teams'),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
