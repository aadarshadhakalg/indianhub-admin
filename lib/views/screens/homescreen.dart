import 'package:admin/controller/stat_controller.dart';
import 'package:admin/views/components/drawer.dart';
import 'package:admin/views/screens/allusers.dart';
import 'package:admin/views/screens/matches/matches_screen.dart';
import 'package:admin/views/screens/notifyscreen.dart';
import 'package:admin/views/screens/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final statsController = Get.put(StatsController());

  @override
  void initState() {
    statsController.getStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(
          "Indian HUB Admin".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            letterSpacing: .3,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          // vertical: 10.0,
        ),
        child: Obx(() {
          return RefreshIndicator(
            onRefresh: () async {
              await statsController.getStats();
            },
            child: ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          statsController.totalUsers.value.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Total Users",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                statsController.freeUsers.value.toString(),
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Free Users",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                statsController.paidUsers.value.toString(),
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                "Paid Users",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rs. " +
                              statsController.totalTransactions.value
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 35.0,
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Total In App Purchases",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.2,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Quick Actions",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.group,
                                    color: Colors.cyan,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    Get.to(AllUsers());
                                  },
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.attach_money,
                                    color: Colors.cyan,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    Get.to(Transactions());
                                  },
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.sports_cricket,
                                    color: Colors.cyan,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    Get.to(MatchesScreen());
                                  },
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.message,
                                    color: Colors.cyan,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    Get.to(NotifyScreen());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
