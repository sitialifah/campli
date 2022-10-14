from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.bacaan_pot import tambah
from aplikasi.model.bacaan_pot import daftar
from aplikasi.model.bacaan_pot import hapus
from aplikasi.model.bacaan_pot import cari
from aplikasi.model.bacaan_pot import cari_interval
from aplikasi.model.bacaan_pot import cari_interval_sensor
from aplikasi.model.bacaan_pot import Bacaan_Pot
from aplikasi.model.bacaan_pot import BACAAN_POT_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

bacaan_pot = Blueprint("bacaan_pot", __name__, url_prefix="/bacaan_pot")
#Bacaan_Pot

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@bacaan_pot.route("/tambah", methods=["POST"])
def bacaan_pot_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        bacaan_pot_baru = request.get_json()
    elif request.form:
        bacaan_pot_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if bacaan_pot_baru is None:
        return "Data bacaan_pot baru tidak ada!", 400        
    if "id_pot" not in bacaan_pot_baru.keys():
        return "Salah data! Property id pot tidak ada.", 400
    if "lantai" not in bacaan_pot_baru.keys():
        return "Salah data! Property lantai tidak ada.", 400
    if "nilai" not in bacaan_pot_baru.keys():
        return "Salah data! Property nilai tidak ada.", 400
    if "kondisi" not in bacaan_pot_baru.keys():
        return "Salah data! Property kondisi tidak ada.", 400
    
    
    id_pot          = escape(bacaan_pot_baru["id_pot"]).strip()
    lantai          = escape(bacaan_pot_baru["lantai"]).strip()
    kapan           = escape(bacaan_pot_baru["kapan"]).strip()
    nilai           = escape(bacaan_pot_baru["nilai"]).strip()
    nilai           = float(nilai)
    kondisi         = escape(bacaan_pot_baru["kondisi"]).strip()
    cari_pot = model.pot.atur.cari(int(id_pot))

    # mau tambah isi array list_bacaanpot di kind pot
    if len(cari_pot) == 1:
        cari_pot = cari_pot[0]

        # Tambah konfigurasi baru
        try:
            hasil = tambah(id_pot, lantai, kapan, nilai, kondisi)
        except EntityNotFoundException:
            return f"Gagal menambah bacaan pot baru", 400
        
        # jsn dumps
        cari_pot['list_bacaanpot'] = cari_pot['list_bacaanpot']
        cari_pot['list_bacaanpot'] += [str(hasil.id)]
        cari_pot['list_bacaanpot'] = cari_pot['list_bacaanpot']
        cari_pot['jumlah_bacaanpot'] += 1

        del cari_pot['id'] 

    # Tambah bacaan_pot baru
    try:
        hasil = model.pot.atur.update(int(id_pot), cari_pot)
    except EntityNotFoundException:
        return f"Gagal menambah data", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    # return "Berhasil", 200
    return redirect(url_for('campli.tabelbacaanpot'))

@bacaan_pot.route("/daftar", methods=["GET"])
def bacaan_pot_daftar():

    # Minta data semua pengaduan
    hasil = model.bacaan_pot.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_pot.", 400

    # Ubah class ke dictionary
    daftar_bacaan_pot = []
    for satu_hasil in hasil:
        daftar_bacaan_pot.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_bacaan_pot }

    return jsonify(hasil), 200

@bacaan_pot.route("/list", methods=["GET"])
def bacaan_pot_list():

    # Minta data semua pengaduan
    hasil = model.bacaan_pot.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar bacaan_pot.", 400

    # Ubah class ke dictionary
    daftar_bacaan_pot = []
    for satu_hasil in hasil:
        daftar_bacaan_pot.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_bacaan_pot }

    return daftar_bacaan_pot


@bacaan_pot.route("/hapus/<int:id>", methods=["DELETE"])
def bacaan_pot_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200

@bacaan_pot.route("/cari/<int:id>", methods=["GET"])
def bacaan_pot_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except EntityNotFoundException:
        return f"Tidak ada bacaan dengan id: {id}.", 400
    except: 
        return f"Gagal mencari bacaan_pot  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari bacaan_pot dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil.ke_dictionary()), 200

@bacaan_pot.route("/bacaan_pot/sensor_pot/<int:id>", methods=["GET"])
def bacaan_pot_sensor(id):
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

@bacaan_pot.route("/bacaan_pot/interval", methods=["GET"])
def bacaan_pot_interval():
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
