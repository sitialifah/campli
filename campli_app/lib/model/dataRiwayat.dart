// To parse this JSON data, do
//
//     final dataRiwayat = dataRiwayatFromJson(jsonString);

import 'dart:convert';

DataRiwayat dataRiwayatFromJson(String str) =>
    DataRiwayat.fromJson(json.decode(str));

String dataRiwayatToJson(DataRiwayat data) => json.encode(data.toJson());

class DataRiwayat {
  DataRiwayat({
    this.daftarKonfigurasiSelesai,
  });

  List<DaftarKonfigurasiSelesai> daftarKonfigurasiSelesai;

  factory DataRiwayat.fromJson(Map<String, dynamic> json) => DataRiwayat(
        daftarKonfigurasiSelesai: List<DaftarKonfigurasiSelesai>.from(
            json["daftar konfigurasi selesai"]
                .map((x) => DaftarKonfigurasiSelesai.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "daftar konfigurasi selesai":
            List<dynamic>.from(daftarKonfigurasiSelesai.map((x) => x.toJson())),
      };
}

class DaftarKonfigurasiSelesai {
  DaftarKonfigurasiSelesai({
    this.id,
    this.idAktuator,
    this.idRefStatusKonfig,
    this.kapan,
  });

  int id;
  String idAktuator;
  IdRefStatusKonfig idRefStatusKonfig;
  double kapan;

  factory DaftarKonfigurasiSelesai.fromJson(Map<String, dynamic> json) =>
      DaftarKonfigurasiSelesai(
        id: json["id"],
        idAktuator: json["id_aktuator"],
        idRefStatusKonfig:
            idRefStatusKonfigValues.map[json["id_ref_status_konfig"]],
        kapan: json["kapan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_aktuator": idAktuator,
        "id_ref_status_konfig":
            idRefStatusKonfigValues.reverse[idRefStatusKonfig],
        "kapan": kapan,
      };
}

enum IdRefStatusKonfig { SELESAI }

final idRefStatusKonfigValues =
    EnumValues({"selesai": IdRefStatusKonfig.SELESAI});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
