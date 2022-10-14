// To parse this JSON data, do
//
//     final dataKonfigurasi = dataKonfigurasiFromJson(jsonString);

import 'dart:convert';

DataKonfigurasi dataKonfigurasiFromJson(String str) =>
    DataKonfigurasi.fromJson(json.decode(str));

String dataKonfigurasiToJson(DataKonfigurasi data) =>
    json.encode(data.toJson());

class DataKonfigurasi {
  DataKonfigurasi({
    this.dataKonfigurasi,
    this.id,
    this.idRefAktuator,
    this.idRefStatus,
    this.idTiang,
    this.jenisAktuator,
    this.jumlahKonfigurasi,
    this.listKonfigurasi,
    this.namaPengenalAktuator,
  });

  List<DataKonfigurasiElement> dataKonfigurasi;
  int id;
  String idRefAktuator;
  String idRefStatus;
  String idTiang;
  String jenisAktuator;
  int jumlahKonfigurasi;
  List<String> listKonfigurasi;
  String namaPengenalAktuator;

  factory DataKonfigurasi.fromJson(Map<String, dynamic> json) =>
      DataKonfigurasi(
        dataKonfigurasi: List<DataKonfigurasiElement>.from(
            json["data_konfigurasi"]
                .map((x) => DataKonfigurasiElement.fromJson(x))),
        id: json["id"],
        idRefAktuator: json["id_ref_aktuator"],
        idRefStatus: json["id_ref_status"],
        idTiang: json["id_tiang"],
        jenisAktuator: json["jenis_aktuator"],
        jumlahKonfigurasi: json["jumlah_konfigurasi"],
        listKonfigurasi:
            List<String>.from(json["list_konfigurasi"].map((x) => x)),
        namaPengenalAktuator: json["nama_pengenal_aktuator"],
      );

  Map<String, dynamic> toJson() => {
        "data_konfigurasi":
            List<dynamic>.from(dataKonfigurasi.map((x) => x.toJson())),
        "id": id,
        "id_ref_aktuator": idRefAktuator,
        "id_ref_status": idRefStatus,
        "id_tiang": idTiang,
        "jenis_aktuator": jenisAktuator,
        "jumlah_konfigurasi": jumlahKonfigurasi,
        "list_konfigurasi": List<dynamic>.from(listKonfigurasi.map((x) => x)),
        "nama_pengenal_aktuator": namaPengenalAktuator,
      };
}

class DataKonfigurasiElement {
  DataKonfigurasiElement({
    this.id,
    this.idAktuator,
    this.idRefStatusKonfig,
    this.kapan,
  });

  int id;
  String idAktuator;
  String idRefStatusKonfig;
  double kapan;

  factory DataKonfigurasiElement.fromJson(Map<String, dynamic> json) =>
      DataKonfigurasiElement(
        id: json["id"],
        idAktuator: json["id_aktuator"],
        idRefStatusKonfig: json["id_ref_status_konfig"],
        kapan: json["kapan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_aktuator": idAktuator,
        "id_ref_status_konfig": idRefStatusKonfig,
        "kapan": kapan,
      };
}
