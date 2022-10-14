from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.bacaan_kelembaban_udara import tambah
from aplikasi.model.bacaan_kelembaban_udara import daftar
from aplikasi.model.bacaan_kelembaban_udara import hapus
from aplikasi.model.bacaan_kelembaban_udara import cari
from aplikasi.model.bacaan_kelembaban_udara import cari_id_sensor
from aplikasi.model.bacaan_kelembaban_udara import cari_interval
from aplikasi.model.bacaan_kelembaban_udara import cari_interval_sensor
from aplikasi.model.bacaan_kelembaban_udara import Bacaan_Kelembaban_Udara
from aplikasi.model.bacaan_kelembaban_udara import BACAAN_KELEMBABAN_UDARA_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException
from aplikasi.views.bacaan_pot.view import bacaan_pot_list as bacaan_pot
import datetime
from aplikasi import app


from flask_login import login_required

bacaan_kelembaban_udara = Blueprint("bacaan_kelembaban_udara", __name__, url_prefix="/bacaan_kelembaban_udara")
#Bacaan_Kelembaban_Udara

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@bacaan_kelembaban_udara.route("/tambah", methods=["POST"])
def bacaan_kelembaban_udara_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        bacaan_kelembaban_udara_baru = request.get_json()
    elif request.form:
        bacaan_kelembaban_udara_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if bacaan_kelembaban_udara_baru is None:
        return "Data bacaan_kelembaban_udara baru tidak ada!", 400        
    if "id_sensor" not in bacaan_kelembaban_udara_baru.keys():
        return "Salah data! Property id sensor tidak ada.", 400
    if "tiang" not in bacaan_kelembaban_udara_baru.keys():
        return "Salah data! Property id tiang tidak ada.", 400
    if "nilai" not in bacaan_kelembaban_udara_baru.keys():
        return "Salah data! Property nilai tidak ada.", 400
    

    tiang           = escape(bacaan_kelembaban_udara_baru["tiang"]).strip()
    id_sensor       = escape(bacaan_kelembaban_udara_baru["id_sensor"]).strip()
    kapan           = escape(bacaan_kelembaban_udara_baru["kapan"]).strip()
    nilai           = escape(bacaan_kelembaban_udara_baru["nilai"]).strip()
    nilai           = float(nilai)

    # # Mencari id_tiang pada model.atur tiang
    # cari_tiang = model.tiang.atur.cari(int(id_tiang))

    # mencari id_sensor
    cari_sensor_kelembaban_udara = model.sensor_kelembaban_udara.atur.cari(int(id_sensor))
    # mau tambah isi array list_bacaantiang di kind sensor_pot
    if len(cari_sensor_kelembaban_udara) == 1:
        cari_sensor_kelembaban_udara = cari_sensor_kelembaban_udara[0]
        tiang = cari_sensor_kelembaban_udara["id_tiang"]
        # Tambah konfigurasi baru
        try:
            hasil = tambah(tiang, id_sensor,  kapan, nilai)
        except EntityNotFoundException:
            return f"Gagal menambah bacaan tiang baru", 400
        
        # jsn dumps
        cari_sensor_kelembaban_udara['list_bacaankeludara'] = cari_sensor_kelembaban_udara['list_bacaankeludara']
        cari_sensor_kelembaban_udara['list_bacaankeludara'] += [str(hasil.id)]
        cari_sensor_kelembaban_udara['list_bacaankeludara'] = cari_sensor_kelembaban_udara['list_bacaankeludara']
        cari_sensor_kelembaban_udara['jumlah_bacaankeludara'] += 1

        del cari_sensor_kelembaban_udara['id'] 

    # Tambah bacaan_pot baru
    try:
        hasil = model.sensor_kelembaban_udara.atur.update(int(id_sensor), cari_sensor_kelembaban_udara)
    except EntityNotFoundException:
        return f"Gagal menambah data", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    # return "Berhasil", 200
    return redirect(url_for('campli.tabelbacaankelembabanudara'))

@bacaan_kelembaban_udara.route("/daftar", methods=["GET"])
def bacaan_kelembaban_udara_daftar():

    # Minta data semua pengaduan
    hasil = model.bacaan_kelembaban_udara.atur.daftar()
    
    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_kelembaban_udara.", 400

    # Ubah class ke dictionary
    daftar_bacaan_kelembaban_udara = []
    for satu_hasil in hasil:
        daftar_bacaan_kelembaban_udara.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_bacaan_kelembaban_udara }
    return jsonify(hasil), 200

@bacaan_kelembaban_udara.route("/hapus/<int:id>", methods=["DELETE"])
def bacaan_kelembaban_udara_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200

@bacaan_kelembaban_udara.route("/cari/<int:id>", methods=["GET"])
def bacaan_kelembaban_udara_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except EntityNotFoundException:
        return f"Tidak ada bacaan dengan id: {id}.", 400
    except: 
        return f"Gagal mencari bacaan_kelembaban_udara  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari bacaan_kelembaban_udara dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil.ke_dictionary()), 200

@bacaan_kelembaban_udara.route("/bacaan_kelembaban_udara/sensor_kelembaban_udara/<int:id>", methods=["GET"])
def bacaan_kelembaban_udara_sensor(id):
    interval = request.get_json()

    # Periksa parameter sudah benar
    if interval is None:
        return f"Tidak ada interval bacaan untuk sensor {id}!", 400        
    if "awal" not in interval.keys():
        return f"Tidak ada awal interval bacaan untuk sensor {id}!", 400        
    if "akhir" not in interval.keys():
        return f"Tidak ada akhir interval bacaan untuk sensor {id}!", 400        

    # Ambil parameter request
    awal = interval["awal"]
    akhir = interval["akhir"]

    # Ambil bacaan
    try:
        hasil = cari_interval_sensor(awal, akhir, id)
    except EntityNotFoundException:
        return f"Tidak ada sensor dengan id: {id}.", 400
    except:
        return f"Gagal mengambil bacaan untuk sensor ({id}) antara '{interval['awal']}' s/d '{interval['akhir']}'.", 400


    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil bacaan untuk sensor ({id}) antara '{interval['awal']}' s/d '{interval['akhir']}'.", 400

    # Buat wrapper dictionaty untuk dikembalikan
    hasil_json = {"awal":awal, "akhir":akhir, "daftar":[]}
    for satu_hasil in hasil:
        satu_hasil_json = satu_hasil.ke_dictionary()
        hasil_json["daftar"].append(satu_hasil_json)            

    return jsonify(hasil_json), 200

@bacaan_kelembaban_udara.route("/bacaan_kelembaban_udara/interval", methods=["GET"])
def bacaan_kelembaban_udara_interval():
    interval = request.get_json()

    # Periksa parameter sudah benar
    if interval is None:
        return f"Tidak ada interval bacaan untuk sensor {id}!", 400        
    if "awal" not in interval.keys():
        return f"Tidak ada awal interval bacaan untuk sensor {id}!", 400        
    if "akhir" not in interval.keys():
        return f"Tidak ada akhir interval bacaan untuk sensor {id}!", 400        

    # Ambil parameter request
    awal = interval["awal"]
    akhir = interval["akhir"]

    # Ambil bacaan
    try:
        hasil = cari_interval(awal, akhir)
    except:
        return f"Gagal mengambil bacaan antara '{interval['awal']}' s/d '{interval['akhir']}'.", 400


    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil bacaan antara '{interval['awal']}' s/d '{interval['akhir']}'.", 400

    # Buat wrapper dictionaty untuk dikembalikan
    hasil_json = {"awal":awal, "akhir":akhir, "daftar":[]}
    for satu_hasil in hasil:
        satu_hasil_json = satu_hasil.ke_dictionary()
        hasil_json["daftar"].append(satu_hasil_json)            

    return jsonify(hasil_json), 200

@bacaan_kelembaban_udara.route("/cari/id_sensor/<string:id_sensor>", methods=["GET"])
def bacaan_cari_id_sensor(id_sensor):
    # Lakukan pencarian
    try:
        hasil = cari_id_sensor(id_sensor)
    except: 
        return f"Gagal mencari bacaan  dengan id: {id_sensor}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari bacaan dengan id: {id_sensor}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@bacaan_kelembaban_udara.route("/list", methods=["GET"])
def bacaan_kelembaban_udara_list():

    # Minta data semua pengaduan
    hasil = model.bacaan_kelembaban_udara.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_kelembaban_udara.", 400

    # Ubah class ke dictionary
    daftar_bacaan_kelembaban_udara = []
    for satu_hasil in hasil:
        daftar_bacaan_kelembaban_udara.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_bacaan_kelembaban_udara }

    return daftar_bacaan_kelembaban_udara