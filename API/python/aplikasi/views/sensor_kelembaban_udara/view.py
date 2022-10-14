from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.sensor_kelembaban_udara import tambah
from aplikasi.model.sensor_kelembaban_udara import daftar
from aplikasi.model.sensor_kelembaban_udara import cari
from aplikasi.model.sensor_kelembaban_udara import cari_nama_pengenal_sensor
from aplikasi.model.sensor_kelembaban_udara import cari_id_tiang
from aplikasi.model.sensor_kelembaban_udara import Sensor_Kelembaban_Udara
from aplikasi.model.sensor_kelembaban_udara import SENSOR_KELEMBABAN_UDARA_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

sensor_kelembaban_udara = Blueprint("sensor_kelembaban_udara", __name__, url_prefix="/sensor_kelembaban_udara")
#Sensor_Kelembaban_Udara

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@sensor_kelembaban_udara.route("/tambah", methods=["POST"])
def sensor_kelembaban_udara_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        sensor_kelembaban_udara_baru = request.get_json()
    elif request.form:
        sensor_kelembaban_udara_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if sensor_kelembaban_udara_baru is None:
        return "Data sensor_kelembaban_udara baru tidak ada!", 400       
    if "id_tiang" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property id tiang tidak ada.", 400
    if "nama_pengenal_sensor" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property nama_pengenal_sensor tidak ada.", 400
    

    id_tiang = escape(sensor_kelembaban_udara_baru["id_tiang"]).strip()
    nama_pengenal_sensor = escape(sensor_kelembaban_udara_baru["nama_pengenal_sensor"]).strip()

    # Mencari id_tiang pada model.atur tiang
    cari_tiang = model.tiang.atur.cari(int(id_tiang))

    if len(cari_tiang) == 1:
        cari_tiang = cari_tiang[0]

        # Tambah sensor pot baru
        try:
            hasil = tambah(id_tiang, nama_pengenal_sensor)
        except EntityNotFoundException:
            return f"Gagal menambah sensor tiang baru", 400
        
        # jsn dumps
        cari_tiang['list_sensor_keludara'] = cari_tiang['list_sensor_keludara']
        cari_tiang['list_sensor_keludara'] += [str(hasil.id)]
        cari_tiang['list_sensor_keludara'] = cari_tiang['list_sensor_keludara']
        cari_tiang['jumlah_sensor_keludara'] += 1

        del cari_tiang['id'] 
    # tambah sensor tiang
    try:
        hasil = model.tiang.atur.update(int(id_tiang), cari_tiang)
    except EntityNotFoundException:
        return f"Gagal menambah data baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    # return "Berhasil", 200
    return redirect(url_for('campli.tabelsensorkelembabanudara'))


@sensor_kelembaban_udara.route("/daftar", methods=["GET"])
def sensor_kelembaban_udara_daftar():

    # Minta data semua pengaduan
    hasil = model.sensor_kelembaban_udara.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar sensor_kelembaban_udara.", 400

    # Ubah class ke dictionary
    daftar_sensor_kelembaban_udara = []
    for satu_hasil in hasil:
        daftar_sensor_kelembaban_udara.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_sensor_kelembaban_udara }

    return jsonify(hasil), 200


@sensor_kelembaban_udara.route("/ubah/<int:id>", methods=["PUT"])
def sensor_kelembaban_udara_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        sensor_kelembaban_udara_baru = request.get_json()
    elif request.form:
        sensor_kelembaban_udara_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if sensor_kelembaban_udara_baru is None:
        return "Data Sensor_Kelembaban_Udara baru tidak ada!", 400        
    if "status" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property status tidak ada.", 400
    if "jenis" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property jenis tidak ada.", 400
    if "id_tiang" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property id_tiang tidak ada.", 400
    if "nama_pengenal_sensor" not in sensor_kelembaban_udara_baru.keys():
        return "Salah data! Property nama_pengenal_sensor tidak ada.", 400 

    sensor_kelembaban_udara_baru = Sensor_Kelembaban_Udara(
                                        status = sensor_kelembaban_udara_baru["status"],
                                        jenis= sensor_kelembaban_udara_baru["jenis"],
                                        id_tiang = sensor_kelembaban_udara_baru["id_tiang"],
                                        nama_pengenal_sensor = sensor_kelembaban_udara_baru["nama_pengenal_sensor"])
    try:
        hasil = ubah(id, sensor_kelembaban_udara_baru) 
    except EntityNotFoundException:
        return f"Tidak ada sensor_kelembaban_udara dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah sensor_kelembaban_udara dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@sensor_kelembaban_udara.route("/cari/<int:id>", methods=["GET"])
def sensor_kelembaban_udara_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari sensor_kelembaban_udara  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari sensor_kelembaban_udara dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@sensor_kelembaban_udara.route("/cari/jenis/<string:jenis>", methods=["GET"])
def sensor_kelembaban_udara_cari_jenis(jenis):
    try:
        hasil = cari_jenis(jenis)
    except:
        return f"Gagal mengambil jenis '{jenis}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil jenis '{jenis}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@sensor_kelembaban_udara.route("/cari/nama_pengenal_sensor/<string:nama_pengenal_sensor>", methods=["GET"])
def sensor_kelembaban_udara_cari_nama_pengenal_sensor(nama_pengenal_sensor):
    try:
        hasil = cari_nama_pengenal_sensor(nama_pengenal_sensor)
    except:
        return f"Gagal mengambil nama_pengenal_sensor '{nama_pengenal_sensor}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil nama_pengenal_sensor '{nama_pengenal_sensor}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@sensor_kelembaban_udara.route("/cari/id_tiang/<string:id_tiang>", methods=["GET"])
def sensor_kelembaban_udara_cari_id_tiang(id_tiang):
    try:
        hasil = cari_id_tiang(id_tiang)
    except:
        return f"Gagal mengambil id_tiang '{id_tiang}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil id_tiang '{id_tiang}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

