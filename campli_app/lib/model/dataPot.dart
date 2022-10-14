// To parse this JSON data, do
//
//     final dataPot = dataPotFromJson(jsonString);

import 'dart:convert';

DataPot dataPotFromJson(String str) => DataPot.fromJson(json.decode(str));

String dataPotToJson(DataPot data) => json.encode(data.toJson());

class DataPot {
  DataPot({
    this.dataPot,
    this.id,
    this.idTiang,
    this.jumlahPot,
    this.listPot,
    this.namaLantai,
  });

  List<DataPotElement> dataPot;
  int id;
  String idTiang;
  int jumlahPot;
  List<String> listPot;
  String namaLantai;

  factory DataPot.fromJson(Map<String, dynamic> json) => DataPot(
        dataPot: List<DataPotElement>.from(
            json["data_pot"].map((x) => DataPotElement.fromJson(x))),
        id: json["id"],
        idTiang: json["id_tiang"],
        jumlahPot: json["jumlah_pot"],
        listPot: List<String>.from(json["list_pot"].map((x) => x)),
        namaLantai: json["nama_lantai"],
      );

  Map<String, dynamic> toJson() => {
        "data_pot": List<dynamic>.from(dataPot.map((x) => x.toJson())),
        "id": id,
        "id_tiang": idTiang,
        "jumlah_pot": jumlahPot,
        "list_pot": List<dynamic>.from(listPot.map((x) => x)),
        "nama_lantai": namaLantai,
      };
}

class DataPotElement {
  DataPotElement({
    this.id,
    this.idPot,
    this.kapan,
    this.kondisi,
    this.lantai,
    this.nilai,
  });

  int id;
  String idPot;
  double kapan;
  String kondisi;
  String lantai;
  double nilai;

  factory DataPotElement.fromJson(Map<String, dynamic> json) => DataPotElement(
        id: json["id"],
        idPot: json["id_pot"],
        kapan: json["kapan"],
        kondisi: json["kondisi"],
        lantai: json["lantai"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pot": idPot,
        "kapan": kapan,
        "kondisi": kondisi,
        "lantai": lantai,
        "nilai": nilai,
      };
}
