import 'package:admin/views/screens/allusers.dart';
import 'package:admin/views/screens/notifyscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
            child: Container(
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    child: Text(
                      "IH",
                    ),
                  ),
                  title: Text(
                    "Indian HUB",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  subtitle: Text(
                    "Admin Panel",
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(AllUsers());
            },
            leading: Icon(Icons.group),
            title: Text("View Users"),
          ),
          ListTile(
            onTap: () {
              Get.to(NotifyScreen());
            },
            leading: Icon(Icons.message),
            title: Text("Notification"),
          ),
        ],
      ),
    );
  }
}
