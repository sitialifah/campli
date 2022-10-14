// To parse this JSON data, do
//
//     final detailTiang = detailTiangFromJson(jsonString);

import 'dart:convert';

DetailTiang detailTiangFromJson(String str) =>
    DetailTiang.fromJson(json.decode(str));

String detailTiangToJson(DetailTiang data) => json.encode(data.toJson());

class DetailTiang {
  DetailTiang({
    this.dataLantai,
    this.dataSensor,
    this.id,
    this.idRefStatus,
    this.jumlahAktuator,
    this.jumlahLantai,
    this.jumlahSensortiang,
    this.keterangan,
    this.listAktuator,
    this.listLantai,
    this.listSensortiang,
    this.namaTiang,
    this.waktuPemasangan,
  });

  List<DataLantai> dataLantai;
  List<DataSensor> dataSensor;
  int id;
  String idRefStatus;
  int jumlahAktuator;
  int jumlahLantai;
  int jumlahSensortiang;
  String keterangan;
  List<String> listAktuator;
  List<String> listLantai;
  List<String> listSensortiang;
  String namaTiang;
  double waktuPemasangan;

  factory DetailTiang.fromJson(Map<String, dynamic> json) => DetailTiang(
        dataLantai: List<DataLantai>.from(
            json["data_lantai"].map((x) => DataLantai.fromJson(x))),
        dataSensor: List<DataSensor>.from(
            json["data_sensor"].map((x) => DataSensor.fromJson(x))),
        id: json["id"],
        idRefStatus: json["id_ref_status"],
        jumlahAktuator: json["jumlah_aktuator"],
        jumlahLantai: json["jumlah_lantai"],
        jumlahSensortiang: json["jumlah_sensortiang"],
        keterangan: json["keterangan"],
        listAktuator: List<String>.from(json["list_aktuator"].map((x) => x)),
        listLantai: List<String>.from(json["list_lantai"].map((x) => x)),
        listSensortiang:
            List<String>.from(json["list_sensortiang"].map((x) => x)),
        namaTiang: json["nama_tiang"],
        waktuPemasangan: json["waktu_pemasangan"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "data_lantai": List<dynamic>.from(dataLantai.map((x) => x.toJson())),
        "data_sensor": List<dynamic>.from(dataSensor.map((x) => x.toJson())),
        "id": id,
        "id_ref_status": idRefStatus,
        "jumlah_aktuator": jumlahAktuator,
        "jumlah_lantai": jumlahLantai,
        "jumlah_sensortiang": jumlahSensortiang,
        "keterangan": keterangan,
        "list_aktuator": List<dynamic>.from(listAktuator.map((x) => x)),
        "list_lantai": List<dynamic>.from(listLantai.map((x) => x)),
        "list_sensortiang": List<dynamic>.from(listSensortiang.map((x) => x)),
        "nama_tiang": namaTiang,
        "waktu_pemasangan": waktuPemasangan,
      };
}

class DataLantai {
  DataLantai({
    this.id,
    this.idTiang,
    this.jumlahPot,
    this.listPot,
    this.namaLantai,
  });

  int id;
  String idTiang;
  int jumlahPot;
  List<ListPot> listPot;
  String namaLantai;

  factory DataLantai.fromJson(Map<String, dynamic> json) => DataLantai(
        id: json["id"],
        idTiang: json["id_tiang"],
        jumlahPot: json["jumlah_pot"],
        listPot: List<ListPot>.from(
            json["list_pot"].map((x) => ListPot.fromJson(x))),
        namaLantai: json["nama_lantai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tiang": idTiang,
        "jumlah_pot": jumlahPot,
        "list_pot": List<dynamic>.from(listPot.map((x) => x.toJson())),
        "nama_lantai": namaLantai,
      };
}

class ListPot {
  ListPot({
    this.id,
    this.idLantai,
    this.idTiang,
    this.jumlahSensorpot,
    this.keterangan,
    this.listSensorpot,
    this.namaPot,
  });

  int id;
  String idLantai;
  String idTiang;
  int jumlahSensorpot;
  String keterangan;
  List<String> listSensorpot;
  String namaPot;

  factory ListPot.fromJson(Map<String, dynamic> json) => ListPot(
        id: json["id"],
        idLantai: json["id_lantai"],
        idTiang: json["id_tiang"],
        jumlahSensorpot: json["jumlah_sensorpot"],
        keterangan: json["keterangan"],
        listSensorpot: List<String>.from(json["list_sensorpot"].map((x) => x)),
        namaPot: json["nama_pot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_lantai": idLantai,
        "id_tiang": idTiang,
        "jumlah_sensorpot": jumlahSensorpot,
        "keterangan": keterangan,
        "list_sensorpot": List<dynamic>.from(listSensorpot.map((x) => x)),
        "nama_pot": namaPot,
      };
}

class DataSensor {
  DataSensor({
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
  int kapan;
  int nilai;
  String tiang;

  factory DataSensor.fromJson(Map<String, dynamic> json) => DataSensor(
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
