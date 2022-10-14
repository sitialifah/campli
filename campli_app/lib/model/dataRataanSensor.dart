// To parse this JSON data, do
//
//     final dataRataanSensor = dataRataanSensorFromJson(jsonString);

import 'dart:convert';

List<DataRataanSensor> dataRataanSensorFromJson(String str) =>
    List<DataRataanSensor>.from(
        json.decode(str).map((x) => DataRataanSensor.fromJson(x)));

String dataRataanSensorToJson(List<DataRataanSensor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataRataanSensor {
  DataRataanSensor({
    this.id,
    this.idSensor,
    this.jenis,
    this.kapan,
    this.nilai,
    this.tiang,
    this.idPot,
    this.kondisi,
    this.lantai,
  });

  int id;
  String idSensor;
  String jenis;
  double kapan;
  double nilai;
  String tiang;
  String idPot;
  String kondisi;
  String lantai;

  factory DataRataanSensor.fromJson(Map<String, dynamic> json) =>
      DataRataanSensor(
        id: json["id"],
        idSensor: json["id_sensor"] == null ? null : json["id_sensor"],
        jenis: json["jenis"],
        kapan: json["kapan"],
        nilai: json["nilai"].toDouble(),
        tiang: json["tiang"] == null ? null : json["tiang"],
        idPot: json["id_pot"] == null ? null : json["id_pot"],
        kondisi: json["kondisi"] == null ? null : json["kondisi"],
        lantai: json["lantai"] == null ? null : json["lantai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_sensor": idSensor == null ? null : idSensor,
        "jenis": jenis,
        "kapan": kapan,
        "nilai": nilai,
        "tiang": tiang == null ? null : tiang,
        "id_pot": idPot == null ? null : idPot,
        "kondisi": kondisi == null ? null : kondisi,
        "lantai": lantai == null ? null : lantai,
      };
}
