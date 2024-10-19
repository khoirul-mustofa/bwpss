class Wakaf {
  int? id;
  String? namaLengkap;
  String? sapaan;
  String? categoryWakaf;
  int? price;
  String? noWa;
  String? email;
  String? pesan;
  String? metodeBayar;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;

  Wakaf(
      {this.id,
      this.namaLengkap,
      this.sapaan,
      this.categoryWakaf,
      this.price,
      this.noWa,
      this.email,
      this.pesan,
      this.metodeBayar,
      this.fcmToken,
      this.createdAt,
      this.updatedAt});

  Wakaf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaLengkap = json['nama_lengkap'];
    sapaan = json['sapaan'];
    categoryWakaf = json['category_wakaf'];
    price = json['price'];
    noWa = json['no_wa'];
    email = json['email'];
    pesan = json['pesan'];
    metodeBayar = json['metode_bayar'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama_lengkap'] = namaLengkap;
    data['sapaan'] = sapaan;
    data['category_wakaf'] = categoryWakaf;
    data['price'] = price;
    data['no_wa'] = noWa;
    data['email'] = email;
    data['pesan'] = pesan;
    data['metode_bayar'] = metodeBayar;
    data['fcm_token'] = fcmToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'Wakaf{id: $id, namaLengkap: $namaLengkap, sapaan: $sapaan, categoryWakaf: $categoryWakaf, price: $price, noWa: $noWa, email: $email, pesan: $pesan, metodeBayar: $metodeBayar, fcmToken: $fcmToken, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
