import 'dart:convert';

class MatchModel {
  final String id;
  final String teamA;
  final String teamB;
  final DateTime time;
  final String teamAimage;
  final String teamBimage;
  final String? winingTeam;

  MatchModel({
    required this.id,
    required this.teamA,
    required this.teamB,
    required this.time,
    required this.teamAimage,
    required this.teamBimage,
    this.winingTeam,
  });

  MatchModel copyWith({
    String? id,
    String? teamA,
    String? teamB,
    DateTime? time,
    String? teamAimage,
    String? teamBimage,
    String? winingTeam,
  }) {
    return MatchModel(
      id: id ?? this.id,
      teamA: teamA ?? this.teamA,
      teamB: teamB ?? this.teamB,
      time: time ?? this.time,
      teamAimage: teamAimage ?? this.teamAimage,
      teamBimage: teamBimage ?? this.teamBimage,
      winingTeam: winingTeam ?? this.winingTeam,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teamA': teamA,
      'teamB': teamB,
      'time': time.millisecondsSinceEpoch,
      'teamAimage': teamAimage,
      'teamBimage': teamBimage,
      'winingTeam': winingTeam,
    };
  }

  factory MatchModel.fromMap(Map<String, dynamic> map) {
    return MatchModel(
      id: map['id'],
      teamA: map['teamA'],
      teamB: map['teamB'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      teamAimage: map['teamAimage'],
      teamBimage: map['teamBimage'],
      winingTeam: map['winingTeam'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchModel.fromJson(String source) =>
      MatchModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MatchModel(id: $id, teamA: $teamA, teamB: $teamB, time: $time, teamAimage: $teamAimage, teamBimage: $teamBimage, winingTeam: $winingTeam)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchModel &&
        other.id == id &&
        other.teamA == teamA &&
        other.teamB == teamB &&
        other.time == time &&
        other.teamAimage == teamAimage &&
        other.teamBimage == teamBimage &&
        other.winingTeam == winingTeam;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        teamA.hashCode ^
        teamB.hashCode ^
        time.hashCode ^
        teamAimage.hashCode ^
        teamBimage.hashCode ^
        winingTeam.hashCode;
  }
}
