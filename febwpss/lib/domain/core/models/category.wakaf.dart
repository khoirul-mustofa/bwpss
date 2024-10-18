class CategoryWakaf {
  int? id;
  String? name;
  String? image;
  int? targetAmount;
  String? location;
  String? createdAt;
  String? updatedAt;

  CategoryWakaf(
      {this.id,
      this.name,
      this.image,
      this.targetAmount,
      this.location,
      this.createdAt,
      this.updatedAt});

  CategoryWakaf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    targetAmount = json['target_amount'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['target_amount'] = targetAmount;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
