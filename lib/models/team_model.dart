import 'dart:convert';

class TeamModel {
  final String id;
  final String teamName;
  final String teamImage;
  TeamModel({
    required this.id,
    required this.teamName,
    required this.teamImage,
  });

  TeamModel copyWith({
    String? id,
    String? teamName,
    String? teamImage,
  }) {
    return TeamModel(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      teamImage: teamImage ?? this.teamImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teamName': teamName,
      'teamImage': teamImage,
    };
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    return TeamModel(
      id: map['id'],
      teamName: map['teamName'],
      teamImage: map['teamImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) => TeamModel.fromMap(json.decode(source));

  @override
  String toString() => 'TeamModel(id: $id, teamName: $teamName, teamImage: $teamImage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TeamModel &&
      other.id == id &&
      other.teamName == teamName &&
      other.teamImage == teamImage;
  }

  @override
  int get hashCode => id.hashCode ^ teamName.hashCode ^ teamImage.hashCode;
}