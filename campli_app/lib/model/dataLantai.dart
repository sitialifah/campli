// To parse this JSON data, do
//
//     final dataLantai = dataLantaiFromJson(jsonString);

import 'dart:convert';

DataLantai dataLantaiFromJson(String str) =>
    DataLantai.fromJson(json.decode(str));

String dataLantaiToJson(DataLantai data) => json.encode(data.toJson());

class DataLantai {
  DataLantai({
    this.dataLantai,
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

  List<DataLantaiElement> dataLantai;
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

  factory DataLantai.fromJson(Map<String, dynamic> json) => DataLantai(
        dataLantai: List<DataLantaiElement>.from(
            json["data_lantai"].map((x) => DataLantaiElement.fromJson(x))),
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

class DataLantaiElement {
  DataLantaiElement({
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

  factory DataLantaiElement.fromJson(Map<String, dynamic> json) =>
      DataLantaiElement(
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
    this.jumlahBacaanpot,
    this.keterangan,
    this.listBacaanpot,
    this.namaPot,
  });

  int id;
  String idLantai;
  String idTiang;
  int jumlahBacaanpot;
  String keterangan;
  List<String> listBacaanpot;
  String namaPot;

  factory ListPot.fromJson(Map<String, dynamic> json) => ListPot(
        id: json["id"],
        idLantai: json["id_lantai"],
        idTiang: json["id_tiang"],
        jumlahBacaanpot: json["jumlah_bacaanpot"],
        keterangan: json["keterangan"],
        listBacaanpot: List<String>.from(json["list_bacaanpot"].map((x) => x)),
        namaPot: json["nama_pot"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_lantai": idLantai,
        "id_tiang": idTiang,
        "jumlah_bacaanpot": jumlahBacaanpot,
        "keterangan": keterangan,
        "list_bacaanpot": List<dynamic>.from(listBacaanpot.map((x) => x)),
        "nama_pot": namaPot,
      };
}
