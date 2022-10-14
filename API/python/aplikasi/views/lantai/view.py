from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model.lantai import tambah
from aplikasi.model.lantai import daftar
from aplikasi.model.lantai import hapus
from aplikasi.model.lantai import ubah
from aplikasi.model.lantai import cari_id
from aplikasi.model.lantai import cari_nama_lantai
from aplikasi.model.lantai import cari_id_tiang
from aplikasi.model.lantai import Lantai
from aplikasi.model.lantai import LANTAI_KIND
from aplikasi.model.pot import cari_by_lantai
from aplikasi.model.pot import cari_by_lantaipingkelembabantanah
from aplikasi.model.exception import EntityIdException, EntityNotFoundException
import datetime
from aplikasi import app


from flask_login import login_required

lantai = Blueprint("lantai", __name__, url_prefix="/lantai")
#Lantai

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@lantai.route("/tambah", methods=["POST"])
def lantai_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        lantai_baru = request.get_json()
    elif request.form:
        lantai_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if lantai_baru is None:
        return "Data lantai baru tidak ada!", 400        
    if "nama_lantai" not in lantai_baru.keys():
        return "Salah data! Property nama lantai tidak ada.", 400

    

    nama_lantai = escape(lantai_baru["nama_lantai"]).strip()
    id_tiang = str(escape(lantai_baru["id_tiang"]).strip())

    cari_tiang = model.tiang.atur.cari(int(id_tiang))

    if len(cari_tiang) == 1:
        cari_tiang = cari_tiang[0]

        # Tambah komen baru
        try:
            hasil = tambah(nama_lantai, id_tiang)
        except EntityNotFoundException:
            return f"Gagal menambah lantai baru", 400
        # jsn dumps
        cari_tiang['list_lantai'] = cari_tiang['list_lantai']
        cari_tiang['list_lantai'] += [str(hasil.id)]
        cari_tiang['list_lantai'] = cari_tiang['list_lantai']
        cari_tiang['jumlah_lantai'] += 1

        del cari_tiang['id']
    # Tambah lantai baru
    try:
        hasil = model.tiang.atur.update(int(id_tiang), cari_tiang)
    except EntityNotFoundException:
        return f"Gagal menambah lantai baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200


@lantai.route("/daftar", methods=["GET"])
def lantai_daftar():

    # Minta data semua pengaduan
    hasil = model.lantai.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar lantai.", 400

    # Ubah class ke dictionary
    daftar_lantai = []
    for satu_hasil in hasil:
        daftar_lantai.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_lantai }

    return jsonify(hasil), 200


@lantai.route("/hapus/<int:id>", methods=["DELETE"])
def lantai_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200


@lantai.route("/ubah/<int:id>", methods=["PUT"])
def lantai_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        lantai_baru = request.get_json()
    elif request.form:
        lantai_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    app.logger.info(request.form)

    try:
        cari_lantai = cari_id(id)
        app.logger.info(cari_lantai)
    
    except:
        pass
    cari_lantai=cari_lantai[0]

    lantai_baru = Lantai(
                        nama_lantai= lantai_baru["nama_lantai"],
                        jumlah_pot = int(cari_lantai["jumlah_pot"]),
                        id_tiang = str(cari_lantai["id_tiang"]),
                        list_pot = cari_lantai["list_pot"])
    try:
        hasil = ubah(id, lantai_baru) 
    except EntityNotFoundException:
        return f"Tidak ada lantai dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah lantai dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@lantai.route("/cari/<int:id>", methods=["GET"])
def lantai_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari_id(id)
    except: 
        return f"Gagal mencari lantai  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari lantai dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@lantai.route("/cari/nama_lantai/<string:nama_lantai>", methods=["GET"])
def lantai_cari_nama_lantai(nama_lantai):
    try:
        hasil = cari_nama_lantai(nama_lantai)
    except:
        return f"Gagal mengambil nama_lantai '{nama_lantai}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil nama_lantai '{nama_lantai}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@lantai.route("/cari/id_tiang/<string:id_tiang>", methods=["GET"])
def lantai_cari_id_tiang(id_tiang):
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

@lantai.route("/pot/<int:id>", methods=["GET"])
def lantai_daftar_pot(id):

    # Lakukan pencarian
    try:
        cari_lantai = cari_id(id)
    except: 
        return f"Gagal mencari lantai  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_lantai is None:
        return f"Gagal mencari lantai dengan id: {id}.", 400
    cari_lantai[0]["data_pot"] = cari_lantai[0]["list_pot"]
    bacaan_pot = []
    app.logger.info(cari_lantai[0]["data_pot"])
    for pot in cari_lantai[0]["data_pot"]:
        app.logger.info("-------------")
        app.logger.info(pot)
        cari_pot = model.bacaan_pot.atur.cari_id_pot(pot)
        for waktu in cari_pot:
            if waktu["kapan"] != "":
                sekarang = datetime.datetime.now()
                tgl = datetime.datetime.fromtimestamp(waktu["kapan"])
                rentang = sekarang - tgl
                if rentang.days >= 1:
                    waktu["kapan"] = tgl + datetime.timedelta(days=rentang.days)
                    if sekarang - waktu["kapan"] <= datetime.timedelta(hours=1):
                        waktu["kapan"] = datetime.datetime.timestamp(waktu["kapan"])
                        bacaan_pot.append(waktu)
                        cari_lantai[0]["data_pot"] = bacaan_pot
                        app.logger.info("+++++++++++++")
                        app.logger.info(cari_lantai[0]["data_pot"])

    hasil = cari_lantai[0]
    app.logger.info(cari_lantai[0])
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

# view untuk munculin nested data_ping sensorkelembaban tanah berdasarkan id lantai
@lantai.route("/pingsensorkelembabantanah/<int:id>", methods=["GET"])
def lantai_pingsensorkelembabantanah(id):

    # Lakukan pencarian
    try:
        cari_lantai = cari_id(id)
    except: 
        return f"Gagal mencari lantai  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_lantai is None:
        return f"Gagal mencari lantai dengan id: {id}.", 400

    cari_lantai[0]["data_pingsensorkelembabantanah"] = model.pot.atur.cari_by_lantaipingkelembabantanah(id)

    hasil = cari_lantai[0]
    app.logger.info(cari_lantai[0])
    
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200
