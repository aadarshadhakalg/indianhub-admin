import 'dart:convert';

class BetModel {
  final String id;
  final String matchid;
  final String uid;
  final String teamid;
  final int amount;
  final String status;
  BetModel({
    required this.id,
    required this.matchid,
    required this.uid,
    required this.teamid,
    required this.amount,
    required this.status,
  });

  BetModel copyWith({
    String? id,
    String? matchid,
    String? uid,
    String? teamid,
    int? amount,
    String? status,
  }) {
    return BetModel(
      id: id ?? this.id,
      matchid: matchid ?? this.matchid,
      uid: uid ?? this.uid,
      teamid: teamid ?? this.teamid,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'matchid': matchid,
      'uid': uid,
      'teamid': teamid,
      'amount': amount,
      'status': status,
    };
  }

  factory BetModel.fromMap(Map<String, dynamic> map) {
    return BetModel(
      id: map['id'],
      matchid: map['matchid'],
      uid: map['uid'],
      teamid: map['teamid'],
      amount: map['amount']?.toInt(),
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BetModel.fromJson(String source) =>
      BetModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BetModel(id: $id, matchid: $matchid, uid: $uid, teamid: $teamid, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BetModel &&
        other.id == id &&
        other.matchid == matchid &&
        other.uid == uid &&
        other.teamid == teamid &&
        other.amount == amount &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        matchid.hashCode ^
        uid.hashCode ^
        teamid.hashCode ^
        status.hashCode ^
        amount.hashCode;
  }
}
