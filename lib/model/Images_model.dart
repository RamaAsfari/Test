import 'dart:convert';

class ImagesModel {
  final String id;
  final String color;
  final Map urls;

  const ImagesModel(
      {required this.id, required this.color, required this.urls});

  ImagesModel copyWith({String? id, String? color, Map? urls}) {
    return ImagesModel(
        id: id ?? this.id, color: color ?? this.color, urls: urls ?? this.urls);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'color': color, 'urls': urls};
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(id: map['id'], color: map['color'], urls: map['urls']);
  }

  factory ImagesModel.fromJson(String src) {
    return ImagesModel.fromMap(jsonDecode(src));
  }
  @override
  String toString() => 'ImagesModel(id:$id,color:$color,urls:$urls)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImagesModel &&
        other.id == id &&
        other.color == color &&
        other.urls == urls;
  }

  @override
  int get hashCode => id.hashCode ^ color.hashCode ^ urls.hashCode;
}
