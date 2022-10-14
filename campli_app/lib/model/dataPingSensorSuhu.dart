// To parse this JSON data, do
//
//     final dataPingSensorSuhu = dataPingSensorSuhuFromJson(jsonString);

import 'dart:convert';

DataPingSensorSuhu dataPingSensorSuhuFromJson(String str) =>
    DataPingSensorSuhu.fromJson(json.decode(str));

String dataPingSensorSuhuToJson(DataPingSensorSuhu data) =>
    json.encode(data.toJson());

class DataPingSensorSuhu {
  DataPingSensorSuhu({
    this.dataPingsensorsuhu,
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

  List<DataPingsensorsuhu> dataPingsensorsuhu;
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

  factory DataPingSensorSuhu.fromJson(Map<String, dynamic> json) =>
      DataPingSensorSuhu(
        dataPingsensorsuhu: List<DataPingsensorsuhu>.from(
            json["data_pingsensorsuhu"]
                .map((x) => DataPingsensorsuhu.fromJson(x))),
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
        "data_pingsensorsuhu":
            List<dynamic>.from(dataPingsensorsuhu.map((x) => x.toJson())),
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

class DataPingsensorsuhu {
  DataPingsensorsuhu({
    this.id,
    this.idTiang,
    this.jenis,
    this.jumlahBacaansuhu,
    this.listBacaansuhu,
    this.namaPengenalSensor,
    this.status,
  });

  int id;
  String idTiang;
  String jenis;
  int jumlahBacaansuhu;
  List<String> listBacaansuhu;
  String namaPengenalSensor;
  String status;

  factory DataPingsensorsuhu.fromJson(Map<String, dynamic> json) =>
      DataPingsensorsuhu(
        id: json["id"],
        idTiang: json["id_tiang"],
        jenis: json["jenis"],
        jumlahBacaansuhu: json["jumlah_bacaansuhu"],
        listBacaansuhu:
            List<String>.from(json["list_bacaansuhu"].map((x) => x)),
        namaPengenalSensor: json["nama_pengenal_sensor"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tiang": idTiang,
        "jenis": jenis,
        "jumlah_bacaansuhu": jumlahBacaansuhu,
        "list_bacaansuhu": List<dynamic>.from(listBacaansuhu.map((x) => x)),
        "nama_pengenal_sensor": namaPengenalSensor,
        "status": status,
      };
}
