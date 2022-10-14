from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.sensor_suhu import tambah
from aplikasi.model.sensor_suhu import daftar
from aplikasi.model.sensor_suhu import cari
from aplikasi.model.sensor_suhu import cari_nama_pengenal_sensor
from aplikasi.model.sensor_suhu import cari_id_tiang
from aplikasi.model.sensor_suhu import Sensor_Suhu
from aplikasi.model.sensor_suhu import SENSOR_SUHU_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

sensor_suhu = Blueprint("sensor_suhu", __name__, url_prefix="/sensor_suhu")
#Sensor_Suhu

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@sensor_suhu.route("/tambah", methods=["POST"])
def sensor_suhu_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        sensor_suhu_baru = request.get_json()
    elif request.form:
        sensor_suhu_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if sensor_suhu_baru is None:
        return "Data sensor_suhu baru tidak ada!", 400       
    if "id_tiang" not in sensor_suhu_baru.keys():
        return "Salah data! Property id tiang tidak ada.", 400
    if "nama_pengenal_sensor" not in sensor_suhu_baru.keys():
        return "Salah data! Property nama_pengenal_sensor tidak ada.", 400
    

    id_tiang = escape(sensor_suhu_baru["id_tiang"]).strip()
    nama_pengenal_sensor = escape(sensor_suhu_baru["nama_pengenal_sensor"]).strip()

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
        cari_tiang['list_sensor_suhu'] = cari_tiang['list_sensor_suhu']
        cari_tiang['list_sensor_suhu'] += [str(hasil.id)]
        cari_tiang['list_sensor_suhu'] = cari_tiang['list_sensor_suhu']
        cari_tiang['jumlah_sensor_suhu'] += 1

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
    return redirect(url_for('campli.tabelsensorsuhu'))


@sensor_suhu.route("/daftar", methods=["GET"])
def sensor_suhu_daftar():

    # Minta data semua pengaduan
    hasil = model.sensor_suhu.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar sensor_suhu.", 400

    # Ubah class ke dictionary
    daftar_sensor_suhu = []
    for satu_hasil in hasil:
        daftar_sensor_suhu.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_sensor_suhu }

    return jsonify(hasil), 200


@sensor_suhu.route("/ubah/<int:id>", methods=["PUT"])
def sensor_suhu_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        sensor_suhu_baru = request.get_json()
    elif request.form:
        sensor_suhu_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if sensor_suhu_baru is None:
        return "Data Sensor_Suhu baru tidak ada!", 400        
    if "status" not in sensor_suhu_baru.keys():
        return "Salah data! Property status tidak ada.", 400
    if "jenis" not in sensor_suhu_baru.keys():
        return "Salah data! Property jenis tidak ada.", 400
    if "id_tiang" not in sensor_suhu_baru.keys():
        return "Salah data! Property id_tiang tidak ada.", 400
    if "nama_pengenal_sensor" not in sensor_suhu_baru.keys():
        return "Salah data! Property nama_pengenal_sensor tidak ada.", 400 

    sensor_suhu_baru = Sensor_Suhu(
                                        status = sensor_suhu_baru["status"],
                                        jenis= sensor_suhu_baru["jenis"],
                                        id_tiang = sensor_suhu_baru["id_tiang"],
                                        nama_pengenal_sensor = sensor_suhu_baru["nama_pengenal_sensor"])
    try:
        hasil = ubah(id, sensor_suhu_baru) 
    except EntityNotFoundException:
        return f"Tidak ada sensor_suhu dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah sensor_suhu dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@sensor_suhu.route("/cari/<int:id>", methods=["GET"])
def sensor_suhu_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari sensor_suhu  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari sensor_suhu dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@sensor_suhu.route("/cari/jenis/<string:jenis>", methods=["GET"])
def sensor_suhu_cari_jenis(jenis):
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

@sensor_suhu.route("/cari/nama_pengenal_sensor/<string:nama_pengenal_sensor>", methods=["GET"])
def sensor_suhu_cari_nama_pengenal_sensor(nama_pengenal_sensor):
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

@sensor_suhu.route("/cari/id_tiang/<string:id_tiang>", methods=["GET"])
def sensor_suhu_cari_id_tiang(id_tiang):
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

