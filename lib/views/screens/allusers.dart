import 'package:admin/models/user_model.dart';
import 'package:admin/services/firestore_helper.dart';
import 'package:admin/views/screens/user_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

String getInitials(String name) => name.isNotEmpty
    ? name.trim().split(' ').map((l) => l[0]).take(2).join()
    : '';

class AllUsers extends StatefulWidget {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Users".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: .3,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: UserSearchDeligate());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: PaginateFirestore(
          separator: const Divider(),
          itemsPerPage: 10,
          emptyDisplay: Center(child: Text("No Users")),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemBuilder: (int index, context, snapshot) => ListTile(
            onTap: () {
              Get.to(UserDetail(id: snapshot.data()?['uid']));
            },
            title: Text("${snapshot.data()?["name"]}"),
            subtitle: Text("${snapshot.data()?["email"]}"),
            leading: snapshot.data()?["photoUrl"] == ""
                ? CircleAvatar(
                    backgroundColor: Colors.cyan,
                    child: Text(
                      getInitials(snapshot.data()?["points"]).toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      snapshot.data()?["photoUrl"],
                    ),
                  ),
            trailing: IconButton(
              icon: Icon(Icons.email),
              onPressed: () async {
                await launch("mailto:${snapshot.data()?["email"]}");
              },
            ),
          ),
          // orderBy is compulsary to enable pagination
          query: widget._firebaseFirestore.collection('users').orderBy('uid'),
          listeners: [
            refreshChangeListener,
          ],
          itemBuilderType: PaginateBuilderType.listView,
        ),
        onRefresh: () async {
          refreshChangeListener.refreshed = true;
        },
      ),
    );
  }
}

class UserSearchDeligate extends SearchDelegate {
  @override
  Animation<double> get transitionAnimation => super.transitionAnimation;

  final FirestoreHelper _firestoreHelper = FirestoreHelper();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _firestoreHelper.searchUsers(query),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Get.to(UserDetail(
                      id: snapshot.data![index].uid,
                    ));
                  },
                  title: Text("${snapshot.data?[index].name}"),
                  subtitle: Text("${snapshot.data?[index].email}"),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      snapshot.data![index].photoUrl,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () async {
                      await launch("mailto:${snapshot.data?[index].email}");
                    },
                  ),
                );
              });
        } else {
          return Text("Searching");
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return Card(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Start searching users"),
            ],
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: _firestoreHelper.searchUsers(query),
        builder: (BuildContext context,
            AsyncSnapshot<Iterable<UserModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Get.to(UserDetail(
                        id: snapshot.data!.toList()[index].uid,
                      ));
                    },
                    title: Text("${snapshot.data?.toList()[index].name}"),
                    subtitle: Text("${snapshot.data?.toList()[index].email}"),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        snapshot.data!.toList()[index].photoUrl,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.email),
                      onPressed: () async {
                        await launch(
                            "mailto:${snapshot.data?.toList()[index].email}");
                      },
                    ),
                  );
                });
          } else {
            return Center(child: Text("Searching..."));
          }
        },
      );
    }
  }
}
