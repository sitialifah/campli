// To parse this JSON data, do
//
//     final dataPingSensorKelembabanTanah = dataPingSensorKelembabanTanahFromJson(jsonString);

import 'dart:convert';

DataPingSensorKelembabanTanah dataPingSensorKelembabanTanahFromJson(
        String str) =>
    DataPingSensorKelembabanTanah.fromJson(json.decode(str));

String dataPingSensorKelembabanTanahToJson(
        DataPingSensorKelembabanTanah data) =>
    json.encode(data.toJson());

class DataPingSensorKelembabanTanah {
  DataPingSensorKelembabanTanah({
    this.dataPingsensorkelembabantanah,
    this.id,
    this.idTiang,
    this.jumlahPot,
    this.listPot,
    this.namaLantai,
  });

  List<DataPingsensorkelembabantanah> dataPingsensorkelembabantanah;
  int id;
  String idTiang;
  int jumlahPot;
  List<String> listPot;
  String namaLantai;

  factory DataPingSensorKelembabanTanah.fromJson(Map<String, dynamic> json) =>
      DataPingSensorKelembabanTanah(
        dataPingsensorkelembabantanah: List<DataPingsensorkelembabantanah>.from(
            json["data_pingsensorkelembabantanah"]
                .map((x) => DataPingsensorkelembabantanah.fromJson(x))),
        id: json["id"],
        idTiang: json["id_tiang"],
        jumlahPot: json["jumlah_pot"],
        listPot: List<String>.from(json["list_pot"].map((x) => x)),
        namaLantai: json["nama_lantai"],
      );

  Map<String, dynamic> toJson() => {
        "data_pingsensorkelembabantanah": List<dynamic>.from(
            dataPingsensorkelembabantanah.map((x) => x.toJson())),
        "id": id,
        "id_tiang": idTiang,
        "jumlah_pot": jumlahPot,
        "list_pot": List<dynamic>.from(listPot.map((x) => x)),
        "nama_lantai": namaLantai,
      };
}

class DataPingsensorkelembabantanah {
  DataPingsensorkelembabantanah({
    this.id,
    this.idLantai,
    this.idTiang,
    this.jenis,
    this.jumlahBacaanpot,
    this.keterangan,
    this.listBacaanpot,
    this.namaPot,
    this.status,
  });

  int id;
  String idLantai;
  String idTiang;
  String jenis;
  int jumlahBacaanpot;
  String keterangan;
  String listBacaanpot;
  String namaPot;
  String status;

  factory DataPingsensorkelembabantanah.fromJson(Map<String, dynamic> json) =>
      DataPingsensorkelembabantanah(
        id: json["id"],
        idLantai: json["id_lantai"],
        idTiang: json["id_tiang"],
        jenis: json["jenis"],
        jumlahBacaanpot: json["jumlah_bacaanpot"],
        keterangan: json["keterangan"],
        listBacaanpot: json["list_bacaanpot"],
        namaPot: json["nama_pot"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_lantai": idLantai,
        "id_tiang": idTiang,
        "jenis": jenis,
        "jumlah_bacaanpot": jumlahBacaanpot,
        "keterangan": keterangan,
        "list_bacaanpot": listBacaanpot,
        "nama_pot": namaPot,
        "status": status,
      };
}
