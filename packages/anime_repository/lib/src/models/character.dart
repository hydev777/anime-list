import 'package:equatable/equatable.dart';

class Character extends Equatable {
  const Character({
    this.id,
    this.characterImage,
    this.gender,
    this.name,
    this.desc,
  });

  final int? id;
  final String? characterImage;
  final String? gender;
  final String? name;
  final String? desc;

  Character copyWith({
    int? id,
    String? characterImage,
    String? gender,
    String? name,
    String? desc,
  }) {
    return Character(
      id: id ?? this.id,
      characterImage: characterImage ?? this.characterImage,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "character_image": characterImage,
        "gender": gender,
        "name": name,
        "desc": desc,
      };

  @override
  List<Object?> get props => [
        id,
        characterImage,
        gender,
        name,
        desc,
      ];
}
