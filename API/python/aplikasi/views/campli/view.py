from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model import bacaan_pot, daftar, cari
from aplikasi.model import aktuator, daftar, cari
from aplikasi.model import pot, daftar, cari
from aplikasi.model import user, daftar, cari


from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app

campli = Blueprint("campli", __name__, url_prefix="/campli")

#Pot

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

#halaman beranda
@campli.route("/beranda", methods=["GET"])
def beranda():

    # Muat template
    return render_template("campli/index.j2")

#halaman user
@campli.route("/user/tambahuser", methods=["GET"])
def tambahuser():

    # Muat template
    return render_template("campli/tambahUser.j2")
    
#halaman user
@campli.route("/tabeluser", methods=["GET"])
def tabeluser():

    user = model.user.atur.daftar()

    # Muat template
    return render_template("campli/tabelUser.j2", daftar_user=user)


#halaman tambahsensorsuhu
@campli.route("/sensor/tambahsensorsuhu", methods=["GET"])
def tambahsensorsuhu():

    # Muat template
    return render_template("campli/tambahSensorSuhu.j2")

#halaman tambahsensorkelembabanudara
@campli.route("/sensor/tambahsensorkelembabanudara", methods=["GET"])
def tambahsensorkelembabanudara():

    # Muat template
    return render_template("campli/tambahSensorKelembabanUdara.j2")

#halaman tambahbacaansuhu
@campli.route("/sensor/bacaansuhu", methods=["GET"])
def bacaansuhu():

    # Muat template
    return render_template("campli/bacaanSuhu.j2")


#halaman tambahbacaankelembabanudara
@campli.route("/sensor/bacaankelembabanudara", methods=["GET"])
def bacaankelembabanudara():

    # Muat template
    return render_template("campli/bacaanKelembabanUdara.j2")

#halaman tambahbacaanpot
@campli.route("/sensor/bacaanpot", methods=["GET"])
def bacaanpot():

    # Muat template
    return render_template("campli/bacaanPot.j2")

#halaman tambahaktuator
@campli.route("/tambahaktuator", methods=["GET"])
def tambahaktuator():

    # Muat template
    return render_template("campli/tambahAktuator.j2")

#halaman tambahaktuator
@campli.route("/tambahpot", methods=["GET"])
def tambahpot():

    # Muat template
    return render_template("campli/tambahPot.j2")


#halaman tabelsensorsuhu
@campli.route("/tabelsensorsuhu", methods=["GET"])
def tabelsensorsuhu():

    sensor_suhu = model.sensor_suhu.atur.daftar()

    # Muat template
    return render_template("campli/tabelSensorSuhu.j2", daftar_sensor_suhu=sensor_suhu)

#halaman tabelsensorkelembabanudara
@campli.route("/tabelsensorkelembabanudara", methods=["GET"])
def tabelsensorkelembabanudara():

    sensor_kelembaban_udara = model.sensor_kelembaban_udara.atur.daftar()

    # Muat template
    return render_template("campli/tabelSensorKelembabanUdara.j2", daftar_sensor_kelembaban_udara=sensor_kelembaban_udara)

#halaman tabelbacaansuhu
@campli.route("/tabelbacaansuhu", methods=["GET"])
def tabelbacaansuhu():

    bacaan_suhu = model.bacaan_suhu.atur.daftar()

    # Muat template
    return render_template("campli/tabelBacaanSuhu.j2", daftar_bacaansuhu=bacaan_suhu)

#halaman tabelbacaankelembabanudara
@campli.route("/tabelbacaankelembabanudara", methods=["GET"])
def tabelbacaankelembabanudara():

    bacaan_kelembaban_udara = model.bacaan_kelembaban_udara.atur.daftar()

    # Muat template
    return render_template("campli/tabelBacaanKelembabanUdara.j2", daftar_bacaankelembabanudara=bacaan_kelembaban_udara)

#halaman tabelbacaanpot
@campli.route("/tabelbacaanpot", methods=["GET"])
def tabelbacaanpot():

    bacaan_pot = model.bacaan_pot.atur.daftar()
    # Muat template
    return render_template("campli/tabelBacaanPot.j2", daftar_bacaanpot=bacaan_pot)

#halaman tabelaktuator
@campli.route("/tabelaktuator", methods=["GET"])
def tabelaktuator():
    aktuator = model.aktuator.atur.daftar()
    # Muat template
    return render_template("campli/tabelAktuator.j2", daftar_aktuator=aktuator)

#halaman tabelpot
@campli.route("/tabelpot", methods=["GET"])
def tabelpot():
    pot = model.pot.atur.daftar()
    # Muat template
    return render_template("campli/tabelPot.j2", daftar_pot=pot)











