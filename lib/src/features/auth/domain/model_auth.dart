
enum Role {
  user("User"),
  anonimus("Anonimus");

  final String value;
  const Role(this.value);
}

class ModelAuth {
  final String id;
  final String name;
  final String imageUrl;
  final Role role;

  ModelAuth(this.id,this.name, this.imageUrl, this.role, );

  factory ModelAuth.empty() => ModelAuth(
        "",
        "Anonimus",
        "https://firebasestorage.googleapis.com/v0/b/test-thunkable-e8b09.appspot.com/o/Jepretan%20Layar%202022-10-29%20pukul%2020.55.45.png?alt=media&token=4d981952-138e-48af-a935-7b6dd2355014",
        Role.anonimus,
      );

  @override
  bool operator ==(covariant ModelAuth other) {
    if (identical(this, other)) return true;
    return other.name == name && other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => name.hashCode ^ imageUrl.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'role': role.value,
    };
  }

  factory ModelAuth.fromMap(Map<String, dynamic> map,String id) {
    return ModelAuth(
      id,
      map['name'],
      map['imageUrl'],
      Role.values.byName(map['role'].toString().toLowerCase()),
    );
  }
}
