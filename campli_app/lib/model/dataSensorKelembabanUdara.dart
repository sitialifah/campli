// To parse this JSON data, do
//
//     final dataSensorKelembabanUdara = dataSensorKelembabanUdaraFromJson(jsonString);

import 'dart:convert';

DataSensorKelembabanUdara dataSensorKelembabanUdaraFromJson(String str) =>
    DataSensorKelembabanUdara.fromJson(json.decode(str));

String dataSensorKelembabanUdaraToJson(DataSensorKelembabanUdara data) =>
    json.encode(data.toJson());

class DataSensorKelembabanUdara {
  DataSensorKelembabanUdara({
    this.dataSensorKelembabanUdara,
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

  List<DataSensorKelembabanUdaraElement> dataSensorKelembabanUdara;
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

  factory DataSensorKelembabanUdara.fromJson(Map<String, dynamic> json) =>
      DataSensorKelembabanUdara(
        dataSensorKelembabanUdara: List<DataSensorKelembabanUdaraElement>.from(
            json["data_sensor_kelembaban_udara"]
                .map((x) => DataSensorKelembabanUdaraElement.fromJson(x))),
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
        "data_sensor_kelembaban_udara": List<dynamic>.from(
            dataSensorKelembabanUdara.map((x) => x.toJson())),
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

class DataSensorKelembabanUdaraElement {
  DataSensorKelembabanUdaraElement({
    this.id,
    this.idSensor,
    this.jenis,
    this.kapan,
    this.nilai,
    this.tiang,
  });

  int id;
  String idSensor;
  String jenis;
  double kapan;
  double nilai;
  String tiang;

  factory DataSensorKelembabanUdaraElement.fromJson(
          Map<String, dynamic> json) =>
      DataSensorKelembabanUdaraElement(
        id: json["id"],
        idSensor: json["id_sensor"],
        jenis: json["jenis"],
        kapan: json["kapan"],
        nilai: json["nilai"],
        tiang: json["tiang"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_sensor": idSensor,
        "jenis": jenis,
        "kapan": kapan,
        "nilai": nilai,
        "tiang": tiang,
      };
}
