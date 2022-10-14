from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.bacaan_suhu import tambah
from aplikasi.model.bacaan_suhu import daftar
from aplikasi.model.bacaan_suhu import hapus
from aplikasi.model.bacaan_suhu import cari
from aplikasi.model.bacaan_suhu import cari_id_sensor
from aplikasi.model.bacaan_suhu import cari_interval
from aplikasi.model.bacaan_suhu import cari_interval_sensor
from aplikasi.model.bacaan_suhu import Bacaan_Suhu
from aplikasi.model.bacaan_suhu import BACAAN_SUHU_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException
from aplikasi.views.bacaan_pot.view import bacaan_pot_list as bacaan_pot
from aplikasi.views.bacaan_kelembaban_udara.view import bacaan_kelembaban_udara_list as bacaan_kelembaban_udara
import datetime
from aplikasi import app


from flask_login import login_required

bacaan_suhu = Blueprint("bacaan_suhu", __name__, url_prefix="/bacaan_suhu")
#Bacaan_Suhu

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@bacaan_suhu.route("/tambah", methods=["POST"])
def bacaan_suhu_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        bacaan_suhu_baru = request.get_json()
    elif request.form:
        bacaan_suhu_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if bacaan_suhu_baru is None:
        return "Data bacaan_suhu baru tidak ada!", 400        
    if "id_sensor" not in bacaan_suhu_baru.keys():
        return "Salah data! Property id sensor tidak ada.", 400
    if "tiang" not in bacaan_suhu_baru.keys():
        return "Salah data! Property id tiang tidak ada.", 400
    if "nilai" not in bacaan_suhu_baru.keys():
        return "Salah data! Property nilai tidak ada.", 400
    

    tiang           = escape(bacaan_suhu_baru["tiang"]).strip()
    id_sensor       = escape(bacaan_suhu_baru["id_sensor"]).strip()
    kapan           = escape(bacaan_suhu_baru["kapan"]).strip()
    nilai           = escape(bacaan_suhu_baru["nilai"]).strip()
    nilai           = float(nilai)

    # # Mencari id_tiang pada model.atur tiang
    # cari_tiang = model.tiang.atur.cari(int(id_tiang))

    # mencari id_sensor
    cari_sensor_suhu = model.sensor_suhu.atur.cari(int(id_sensor))
    # mau tambah isi array list_bacaantiang di kind sensor_pot
    if len(cari_sensor_suhu) == 1:
        cari_sensor_suhu = cari_sensor_suhu[0]
        tiang = cari_sensor_suhu["id_tiang"]
        # Tambah konfigurasi baru
        try:
            hasil = tambah(tiang, id_sensor,  kapan, nilai)
        except EntityNotFoundException:
            return f"Gagal menambah bacaan tiang baru", 400
        
        # jsn dumps
        cari_sensor_suhu['list_bacaansuhu'] = cari_sensor_suhu['list_bacaansuhu']
        cari_sensor_suhu['list_bacaansuhu'] += [str(hasil.id)]
        cari_sensor_suhu['list_bacaansuhu'] = cari_sensor_suhu['list_bacaansuhu']
        cari_sensor_suhu['jumlah_bacaansuhu'] += 1

        del cari_sensor_suhu['id'] 

    # Tambah bacaan_pot baru
    try:
        hasil = model.sensor_suhu.atur.update(int(id_sensor), cari_sensor_suhu)
    except EntityNotFoundException:
        return f"Gagal menambah data", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    # return "Berhasil", 200
    return redirect(url_for('campli.tabelbacaansuhu'))

@bacaan_suhu.route("/daftar", methods=["GET"])
def bacaan_suhu_daftar():

    # Minta data semua pengaduan
    hasil = model.bacaan_suhu.atur.daftar()
    
    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_suhu.", 400

    # Ubah class ke dictionary
    daftar_bacaan_suhu = []
    for satu_hasil in hasil:
        daftar_bacaan_suhu.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_bacaan_suhu }
    return jsonify(hasil), 200

# tapi kok cuman masuk 2 biji list nyaaa
# API untuk munculin rata-rata semua bacaan sensor pada waktu terkini dari setiap sensor
@bacaan_suhu.route("/list", methods=["GET"])
def bacaan_suhu_list():

    # Minta data semua pengaduan
    hasil = model.bacaan_suhu.atur.daftar()
    
    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_suhu.", 400

    # Ubah class ke dictionary
    daftar_bacaan_suhu = []
    for satu_hasil in hasil:
        daftar_bacaan_suhu.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = {"bacaan_suhu" : daftar_bacaan_suhu}
    hasil["bacaan_kelembaban_udara"] = bacaan_kelembaban_udara()
    hasil["bacaan_pot"] = bacaan_pot()
    app.logger.info(hasil["bacaan_pot"])
    
    bacaan = []
    bacaankelembabanudara = []
    bacaanpot = []
    suhu = []
    kelembaban_udara = []
    kelembaban_tanah = []

    for waktu in hasil["bacaan_suhu"]:
        
        if waktu["kapan"] != "":
            sekarang = datetime.datetime.now()
            tgl = datetime.datetime.strptime(waktu["kapan"], '%Y-%m-%dT%H:%M')
            rentang = sekarang - tgl
            if rentang.days >= 1:
                waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                    waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                    if waktu["jenis"] == "Suhu":
                        suhu.append(waktu["nilai"])
                    bacaan.append(waktu)
                    hasil["bacaan_suhu"] = bacaan
                    
    suhu = sum(suhu)/len(suhu)
    rata = []
    for x in hasil["bacaan_suhu"]:
        if x["jenis"] == "Suhu":
            x["nilai"] = suhu
            rata.append(x)
            break

    for waktu in hasil["bacaan_kelembaban_udara"]:
        
        if waktu["kapan"] != "":
            sekarang = datetime.datetime.now()
            tgl = datetime.datetime.strptime(waktu["kapan"], '%Y-%m-%dT%H:%M')
            rentang = sekarang - tgl
            if rentang.days >= 1:
                waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                    waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                    if waktu["jenis"] == "Kelembaban Udara":
                        kelembaban_udara.append(waktu["nilai"])
                    bacaankelembabanudara.append(waktu)
                    hasil["bacaan_kelembaban_udara"] = bacaankelembabanudara
                    
    kelembaban_udara = sum(kelembaban_udara)/len(kelembaban_udara)
    # rata = []
    for x in hasil["bacaan_kelembaban_udara"]:
        if x["jenis"] == "Kelembaban Udara":
            x["nilai"] = kelembaban_udara
            rata.append(x)
            break

    for waktu in hasil["bacaan_pot"]:
        if waktu["kapan"] != "":
            sekarang = datetime.datetime.now()
            tgl = datetime.datetime.strptime(waktu["kapan"], '%Y-%m-%dT%H:%M')
            rentang = sekarang - tgl
            if rentang.days >= 1:
                waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                    waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                    if waktu["jenis"] == "Kelembaban Tanah":
                        kelembaban_tanah.append(waktu["nilai"])
                    bacaanpot.append(waktu)
                    hasil["bacaan_pot"] = bacaanpot
                    
    nilai_pot = sum(kelembaban_tanah)/len(kelembaban_tanah)
    app.logger.info(hasil["bacaan_pot"])
    for x in hasil["bacaan_pot"]:
        if x["jenis"] == "Kelembaban Tanah":
            x["nilai"] = nilai_pot
            rata.append(x)
            break

    return jsonify(rata), 200

@bacaan_suhu.route("/hapus/<int:id>", methods=["DELETE"])
def bacaan_suhu_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200

@bacaan_suhu.route("/cari/<int:id>", methods=["GET"])
def bacaan_suhu_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except EntityNotFoundException:
        return f"Tidak ada bacaan dengan id: {id}.", 400
    except: 
        return f"Gagal mencari bacaan_suhu  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari bacaan_suhu dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil.ke_dictionary()), 200

@bacaan_suhu.route("/bacaan_suhu/sensor_suhu/<int:id>", methods=["GET"])
def bacaan_suhu_sensor(id):
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

@bacaan_suhu.route("/bacaan_suhu/interval", methods=["GET"])
def bacaan_suhu_interval():
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

@bacaan_suhu.route("/cari/id_sensor/<string:id_sensor>", methods=["GET"])
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

