import 'package:admin/views/screens/transactions/approved_requests.dart';
import 'package:admin/views/screens/transactions/pending_requests_ui.dart';
import 'package:admin/views/screens/transactions/rejected_requests.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
          bottom: TabBar(tabs: [
            Text('New Requests'),
            Text('Approved Requests'),
            Text('Rejected Requests')
          ],),
        ),
        body: TabBarView(children: [
          PendingRequests(),
          ApprovedRequests(),
          RejectedRequests(),
        ],),
      ),
    );
  }
}
