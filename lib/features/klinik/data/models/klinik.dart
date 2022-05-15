class Klinik {
  final String? id;
  final String? name;
  final String? motto;
  final List<String>? photos;
  final String? address;
  final String? phoneNumber;
  final Map? schedules;
  final Map<int, String>? listUid;
  const Klinik({
    this.photos,
    this.address,
    this.phoneNumber,
    this.schedules,
    this.id,
    this.name,
    this.listUid,
    this.motto,
  });

  factory Klinik.fromJson(Map<String, dynamic> json) {
    return Klinik(
      id: json['id'],
      name: json['name'],
      motto: json['motto'],
      photos: json['photos']?.cast<List>(),
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      schedules: json['schedules'],
      listUid: json['listUid']?.cast<Map>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'motto': motto,
      'photos': photos,
      'address': address,
      'phoneNumber': phoneNumber,
      'schedules': schedules,
      'listUid': listUid,
    };
  }
}
