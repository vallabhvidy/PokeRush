class Pokemon {
  String? name;
  int? id;
  String? img;

  Pokemon.fromJson(Map<String, dynamic> data)
    : id = data['id'],
      name = data['name'],
      img = data['img'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
  };
}