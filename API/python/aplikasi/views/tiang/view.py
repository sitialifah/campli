from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model.tiang import tambah
from aplikasi.model.tiang import daftar
from aplikasi.model.tiang import hapus
from aplikasi.model.tiang import ubah
from aplikasi.model.tiang import cari
from aplikasi.model.tiang import cari_email
from aplikasi.model.tiang import cari_nama_tiang
from aplikasi.model.tiang import Tiang
from aplikasi.model.tiang import TIANG_KIND
from aplikasi.model.lantai import cari_by_tiang
from aplikasi.model.exception import EntityIdException, EntityNotFoundException
import datetime
from aplikasi import app


from flask_login import login_required

tiang = Blueprint("tiang", __name__, url_prefix="/tiang")

#Tiang

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@tiang.route("/tambah", methods=["POST"])
def tiang_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        tiang_baru = request.get_json()
    elif request.form:
        tiang_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if tiang_baru is None:
        return "Data Tiang baru tidak ada!", 400        
    if "nama_tiang" not in tiang_baru.keys():
        return "Salah data! Property nama tiang tidak ada.", 400
    if "keterangan" not in tiang_baru.keys():
        return "Salah data! Property keterangan tiang tidak ada.", 400
    

    nama_tiang = escape(tiang_baru["nama_tiang"]).strip()
    keterangan = escape(tiang_baru["keterangan"]).strip()
    email = escape(tiang_baru["email"]).strip()

    # Tambah tiang  baru
    try:
        hasil = tambah(nama_tiang, keterangan, email)
    except EntityNotFoundException:
        return f"Gagal menambah tiang  baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@tiang.route("/daftar", methods=["GET"])
def tiang_daftar():

    # Minta data semua tiang 
    hasil = model.tiang.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar tiang.", 400

    # Ubah class ke dictionary
    daftar_tiang = []
    for satu_hasil in hasil:
        daftar_tiang.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_tiang }

    return jsonify(hasil), 200

@tiang.route("/daftartiang/<string:email>", methods=["GET"])
def tiang_daftar_email(email):

    
    # Minta data semua tiang 
    hasil = model.tiang.atur.daftarbyemail(email)

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar tiang.", 400

    # Ubah class ke dictionary
    daftar_tiang = []
    for satu_hasil in hasil:
        daftar_tiang.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_tiang }

    return jsonify(hasil), 200


@tiang.route("/hapus/<int:id>", methods=["DELETE"])
def tiang_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    # except: 
    #     return f"Gagal menghapus tiang dengan id: {id}.", 400

    return "Berhasil", 200


@tiang.route("/ubah/<int:id>", methods=["PUT"])
def tiang_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        tiang_baru = request.get_json()
    elif request.form:
        tiang_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    app.logger.info(request.form)

    try:
        cari_tiang = cari(id)
        app.logger.info(cari_tiang)


    except:
        pass
    cari_tiang=cari_tiang[0]
    app.logger.info(cari_tiang["id_ref_status"])
    
    tiang_baru = Tiang(
                nama_tiang              = tiang_baru["nama_tiang"],
                email                   = str(cari_tiang["email"]),
                jumlah_lantai           = int(cari_tiang["jumlah_lantai"]),
                id_ref_status           = str(cari_tiang["id_ref_status"]),
                keterangan              = tiang_baru["keterangan"],
                list_lantai             = cari_tiang["list_lantai"],
                list_aktuator           = cari_tiang["list_aktuator"],
                jumlah_aktuator         = int(cari_tiang["jumlah_aktuator"]),
                list_sensortiang        = cari_tiang["list_sensortiang"],
                jumlah_sensortiang      = int(cari_tiang["jumlah_sensortiang"]),
                list_sensor_suhu        = cari_tiang["list_sensor_suhu"],
                jumlah_sensor_suhu      = int(cari_tiang["jumlah_sensor_suhu"]),
                list_sensor_keludara    = cari_tiang["list_sensor_keludara"],
                jumlah_sensor_keludara  = int(cari_tiang["jumlah_sensor_keludara"]),
                waktu_pemasangan        = str(cari_tiang["waktu_pemasangan"])
                )
    try:
        hasil = ubah(id, tiang_baru) 
    except EntityNotFoundException:
        return f"Tidak ada tiang dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah tiang dengan id: {id}.", 400
    
    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    # return ("", 204)
    return "Berhasil", 200

@tiang.route("/cari/<int:id>", methods=["GET"])
def tiang_cari(id):

    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@tiang.route("/cariemail/<string:email>", methods=["GET"])
def tiang_cari_email(email):

    # Lakukan pencarian
    try:
        hasil = cari_email(email)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil email '{email}'", 400

    # Buat wrapper dictionaty untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil.ke_dictionary()
        hasil_json.append(satu_hasil_json)            

    return jsonify(hasil_json), 200

# view untuk munculin nested data_lantai berdasarkan id tiang
@tiang.route("/lantai/<int:id>", methods=["GET"])
def tiang_daftar_lantai(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_tiang[0]["data_lantai"] = model.lantai.atur.cari_by_tiangpot(id)
    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200


#  munculin bacaan sensor berdasarkan id tiang//mungkin ga kepake
@tiang.route("/sensor/<int:id>", methods=["GET"])
def tiang_daftar_sensor(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    # app.logger.info(cari_tiang[0]["list_sensortiang"])
    cari_tiang[0]["data_sensor"] = cari_tiang[0]["list_sensortiang"]
    bacaan = []
    for sensor in cari_tiang[0]["data_sensor"]:
        cari_sensor = model.bacaan_tiang.atur.cari_id_sensor(sensor)
        for waktu in cari_sensor:
            if waktu["kapan"] != "":
                sekarang = datetime.datetime.now()
                tgl = datetime.datetime.fromtimestamp(waktu["kapan"])
                rentang = sekarang - tgl
                if rentang.days >= 1:
                    waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                    if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                        waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                        bacaan.append(waktu)
                        cari_tiang[0]["data_sensor"] = bacaan
    
    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200


#  munculin bacaan sensor kelembaban udara terkini berdasarkan id tiang
@tiang.route("/sensorudaraterkini/<int:id>", methods=["GET"])
def tiang_daftar_sensorudaraterkini(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    # app.logger.info(cari_tiang[0]["list_sensortiang"])
    cari_tiang[0]["data_sensor_kelembaban_udara"] = cari_tiang[0]["list_sensor_keludara"]
    bacaan = []
    for sensor in cari_tiang[0]["data_sensor_kelembaban_udara"]:
        cari_sensor = model.bacaan_kelembaban_udara.atur.cari_id_sensor(sensor)
        for waktu in cari_sensor:
            if waktu["kapan"] != "":
                sekarang = datetime.datetime.now()
                tgl = datetime.datetime.fromtimestamp(waktu["kapan"])
                rentang = sekarang - tgl
                if rentang.days >= 1:
                    waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                    if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                        waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                        bacaan.append(waktu)
                        cari_tiang[0]["data_sensor_kelembaban_udara"] = bacaan
    
    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

#  munculin bacaan sensor suhu terkini berdasarkan id tiang
@tiang.route("/sensorsuhuterkini/<int:id>", methods=["GET"])
def tiang_daftar_sensorsuhuterkini(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    # app.logger.info(cari_tiang[0]["list_sensortiang"])
    cari_tiang[0]["data_sensor_suhu_terkini"] = cari_tiang[0]["list_sensor_suhu"]
    bacaan_suhu = []
    for sensor in cari_tiang[0]["data_sensor_suhu_terkini"]:
        cari_sensor = model.bacaan_suhu.atur.cari_id_sensor(sensor)
        for waktu in cari_sensor:
            if waktu["kapan"] != "":
                sekarang = datetime.datetime.now()
                tgl = datetime.datetime.fromtimestamp(waktu["kapan"])
                rentang = sekarang - tgl
                if rentang.days >= 1:
                    waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                    if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                        waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                        bacaan_suhu.append(waktu)
                        cari_tiang[0]["data_sensor_suhu_terkini"] = bacaan_suhu
    
    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200



# view untuk munculin nested data_aktuator berdasarkan id tiang
@tiang.route("/aktuator/<int:id>", methods=["GET"])
def tiang_daftar_aktuator(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_tiang[0]["data_aktuator"] = model.aktuator.atur.cari_by_tiangkonfigurasi(id)

    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200


# view untuk munculin nested data untuk ping aktuator berdasarkan id tiang
@tiang.route("/pingaktuator/<int:id>", methods=["GET"])
def tiang_ping_aktuator(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_tiang[0]["data_pingaktuator"] = model.aktuator.atur.cari_by_tiangping(id)

    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

# view untuk munculin nested data_ping sensor suhu  berdasarkan id tiang
@tiang.route("/pingsensorsuhu/<int:id>", methods=["GET"])
def tiang_ping_sensor_suhu(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_tiang[0]["data_pingsensorsuhu"] = model.sensor_suhu.atur.cari_by_tiangpingsuhu(id)

    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

# view untuk munculin nested data_ping sensor kelembaban udara  berdasarkan id tiang
@tiang.route("/pingsensorkelembabanudara/<int:id>", methods=["GET"])
def tiang_ping_sensor_kelembaban_udara(id):

    # Lakukan pencarian
    try:
        cari_tiang = cari(id)
    except: 
        return f"Gagal mencari tiang  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_tiang is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_tiang[0]["data_pingsensorkelembabanudara"] = model.sensor_kelembaban_udara.atur.cari_by_tiangpingkelembabanudara(id)

    hasil = cari_tiang[0]
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200


@tiang.route("/cari/nama_tiang/<string:nama_tiang>", methods=["GET"])
def tiang_cari_nama_tiang(nama_tiang):
    try:
        hasil = cari_nama_tiang(nama_tiang)
    except:
        return f"Gagal mengambil nama_tiang '{nama_tiang}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil nama_tiang '{nama_tiang}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

