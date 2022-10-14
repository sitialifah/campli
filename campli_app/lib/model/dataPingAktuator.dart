// To parse this JSON data, do
//
//     final dataPingAktuator = dataPingAktuatorFromJson(jsonString);

import 'dart:convert';

DataPingAktuator dataPingAktuatorFromJson(String str) =>
    DataPingAktuator.fromJson(json.decode(str));

String dataPingAktuatorToJson(DataPingAktuator data) =>
    json.encode(data.toJson());

class DataPingAktuator {
  DataPingAktuator({
    this.dataPingaktuator,
    this.id,
    this.idRefStatus,
    this.jumlahAktuator,
    this.jumlahLantai,
    this.jumlahSensorKeludara,
    this.jumlahSensorSuhu,
    this.jumlahSensortiang,
    this.keterangan,
    this.listAktuator,
    this.listLantai,
    this.listSensorKeludara,
    this.listSensorSuhu,
    this.listSensortiang,
    this.namaTiang,
    this.waktuPemasangan,
  });

  List<DataPingaktuator> dataPingaktuator;
  int id;
  String idRefStatus;
  int jumlahAktuator;
  int jumlahLantai;
  int jumlahSensorKeludara;
  int jumlahSensorSuhu;
  int jumlahSensortiang;
  String keterangan;
  List<String> listAktuator;
  List<String> listLantai;
  List<String> listSensorKeludara;
  List<String> listSensorSuhu;
  List<String> listSensortiang;
  String namaTiang;
  double waktuPemasangan;

  factory DataPingAktuator.fromJson(Map<String, dynamic> json) =>
      DataPingAktuator(
        dataPingaktuator: List<DataPingaktuator>.from(
            json["data_pingaktuator"].map((x) => DataPingaktuator.fromJson(x))),
        id: json["id"],
        idRefStatus: json["id_ref_status"],
        jumlahAktuator: json["jumlah_aktuator"],
        jumlahLantai: json["jumlah_lantai"],
        jumlahSensorKeludara: json["jumlah_sensor_keludara"],
        jumlahSensorSuhu: json["jumlah_sensor_suhu"],
        jumlahSensortiang: json["jumlah_sensortiang"],
        keterangan: json["keterangan"],
        listAktuator: List<String>.from(json["list_aktuator"].map((x) => x)),
        listLantai: List<String>.from(json["list_lantai"].map((x) => x)),
        listSensorKeludara:
            List<String>.from(json["list_sensor_keludara"].map((x) => x)),
        listSensorSuhu:
            List<String>.from(json["list_sensor_suhu"].map((x) => x)),
        listSensortiang:
            List<String>.from(json["list_sensortiang"].map((x) => x)),
        namaTiang: json["nama_tiang"],
        waktuPemasangan: json["waktu_pemasangan"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "data_pingaktuator":
            List<dynamic>.from(dataPingaktuator.map((x) => x.toJson())),
        "id": id,
        "id_ref_status": idRefStatus,
        "jumlah_aktuator": jumlahAktuator,
        "jumlah_lantai": jumlahLantai,
        "jumlah_sensor_keludara": jumlahSensorKeludara,
        "jumlah_sensor_suhu": jumlahSensorSuhu,
        "jumlah_sensortiang": jumlahSensortiang,
        "keterangan": keterangan,
        "list_aktuator": List<dynamic>.from(listAktuator.map((x) => x)),
        "list_lantai": List<dynamic>.from(listLantai.map((x) => x)),
        "list_sensor_keludara":
            List<dynamic>.from(listSensorKeludara.map((x) => x)),
        "list_sensor_suhu": List<dynamic>.from(listSensorSuhu.map((x) => x)),
        "list_sensortiang": List<dynamic>.from(listSensortiang.map((x) => x)),
        "nama_tiang": namaTiang,
        "waktu_pemasangan": waktuPemasangan,
      };
}

class DataPingaktuator {
  DataPingaktuator({
    this.id,
    this.idRefAktuator,
    this.idRefStatus,
    this.idTiang,
    this.jenisAktuator,
    this.jumlahKonfigurasi,
    this.listKonfigurasi,
    this.namaPengenalAktuator,
  });

  int id;
  String idRefAktuator;
  String idRefStatus;
  String idTiang;
  String jenisAktuator;
  int jumlahKonfigurasi;
  List<dynamic> listKonfigurasi;
  String namaPengenalAktuator;

  factory DataPingaktuator.fromJson(Map<String, dynamic> json) =>
      DataPingaktuator(
        id: json["id"],
        idRefAktuator: json["id_ref_aktuator"],
        idRefStatus: json["id_ref_status"],
        idTiang: json["id_tiang"],
        jenisAktuator: json["jenis_aktuator"],
        jumlahKonfigurasi: json["jumlah_konfigurasi"],
        listKonfigurasi:
            List<dynamic>.from(json["list_konfigurasi"].map((x) => x)),
        namaPengenalAktuator: json["nama_pengenal_aktuator"],
      );

  Map<String, dynamic> toJson() => {
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
