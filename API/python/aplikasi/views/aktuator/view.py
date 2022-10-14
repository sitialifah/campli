from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.aktuator import tambah
from aplikasi.model.aktuator import daftar
from aplikasi.model.aktuator import ubah
from aplikasi.model.aktuator import cari
from aplikasi.model.aktuator import cari_id_ref_aktuator
from aplikasi.model.aktuator import cari_id_tiang
from aplikasi.model.aktuator import Aktuator
from aplikasi.model.aktuator import AKTUATOR_KIND
from aplikasi.model.konfigurasi import cari_by_aktuator
from aplikasi.model.aktuator import cari_by_tiangping
from aplikasi.model.konfigurasi import cari_by_aktuatorselesai
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

aktuator = Blueprint("aktuator", __name__, url_prefix="/aktuator")
#Aktuator

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@aktuator.route("/tambah", methods=["POST"])
def aktuator_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        aktuator_baru = request.get_json()
    elif request.form:
        aktuator_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if aktuator_baru is None:
        return "Data aktuator baru tidak ada!", 400  
    if "id_ref_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property id_ref_aktuator tidak ada.", 400
    if "id_tiang" not in aktuator_baru.keys():
        return "Salah data! Property id_tiang tidak ada.", 400
    if "nama_pengenal_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property nama_pengenal_aktuator tidak ada.", 400
    if "jenis_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property jenis_aktuator tidak ada.", 400

    id_ref_aktuator = escape(aktuator_baru["id_ref_aktuator"]).strip()
    id_tiang = str(escape(aktuator_baru["id_tiang"]).strip())
    nama_pengenal_aktuator = escape(aktuator_baru["nama_pengenal_aktuator"]).strip()
    jenis_aktuator = escape(aktuator_baru["jenis_aktuator"]).strip()

    cari_tiang = model.tiang.atur.cari(int(id_tiang))

    if len(cari_tiang) == 1:
        cari_tiang = cari_tiang[0]

        # Tambah aktuator baru
        try:
            hasil = tambah(id_ref_aktuator, id_tiang, nama_pengenal_aktuator, jenis_aktuator)
        
        except EntityNotFoundException:
            return f"Gagal menambah aktuator baru", 400
        # jsn dumps
        cari_tiang['list_aktuator'] = cari_tiang['list_aktuator']
        cari_tiang['list_aktuator'] += [str(hasil.id)]
        cari_tiang['list_aktuator'] = cari_tiang['list_aktuator']
        cari_tiang['jumlah_aktuator'] += 1

        del cari_tiang['id']

    # Tambah lantai baru
    try:
        hasil = model.tiang.atur.update(int(id_tiang), cari_tiang)
    except EntityNotFoundException:
        return f"Gagal menambah aktuator baru", 400
    

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return redirect(url_for('campli.tabelaktuator'))

@aktuator.route("/daftar", methods=["GET"])
def aktuator_daftar():

    # Minta data semua pengaduan
    hasil = model.aktuator.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar aktuator.", 400

    # Ubah class ke dictionary
    daftar_aktuator = []
    for satu_hasil in hasil:
        daftar_aktuator.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_aktuator }

    return jsonify(hasil), 200


@aktuator.route("/ubah/<int:id>", methods=["PUT"])
def aktuator_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        aktuator_baru = request.get_json()
    elif request.form:
        aktuator_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if aktuator_baru is None:
        return "Data Aktuator baru tidak ada!", 400        
    if "id_ref_status" not in aktuator_baru.keys():
        return "Salah data! Property id_ref_status tidak ada.", 400
    if "id_ref_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property id_ref_aktuator tidak ada.", 400
    if "id_tiang" not in aktuator_baru.keys():
        return "Salah data! Property id_tiang tidak ada.", 400
    if "nama_pengenal_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property nama_pengenal_aktuator tidak ada.", 400 
    if "jenis_aktuator" not in aktuator_baru.keys():
        return "Salah data! Property jenis_aktuator tidak ada.", 400

    aktuator_baru = Aktuator(
                                id_ref_status = aktuator_baru["id_ref_status"],
                                id_ref_aktuator= aktuator_baru["id_ref_aktuator"],
                                id_tiang = aktuator_baru["id_tiang"],
                                nama_pengenal_aktuator = aktuator_baru["nama_pengenal_aktuator"],
                                jenis_aktuator = aktuator_baru["jenis_aktuator"])
    try:
        hasil = ubah(id, aktuator_baru) 
    except EntityNotFoundException:
        return f"Tidak ada aktuator dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah aktuator dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@aktuator.route("/cari/<int:id>", methods=["GET"])
def aktuator_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari aktuator  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari aktuator dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@aktuator.route("/cari/id_ref_aktuator/<string:id_ref_aktuator>", methods=["GET"])
def aktuator_cari_id_ref_aktuator(id_ref_aktuator):
    try:
        hasil = cari_id_ref_aktuator(id_ref_aktuator)
    except:
        return f"Gagal mengambil id_ref_aktuator '{id_ref_aktuator}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil id_ref_aktuator '{id_ref_aktuator}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@aktuator.route("/konfigurasi/<int:id>", methods=["GET"])
def aktuator_daftar_konfigurasi(id):

    # Lakukan pencarian
    try:
        cari_aktuator = cari(id)
    except: 
        return f"Gagal mencari aktuator  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_aktuator is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_aktuator[0]["data_konfigurasi"] = cari_by_aktuator(cari_aktuator[0]['id'])

    hasil = cari_aktuator[0]
    # app.logger.info(cari_aktuator[0])
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@aktuator.route("/konfigurasiselesai/<int:id>", methods=["GET"])
def aktuator_daftar_konfigurasiselesai(id):

    # Lakukan pencarian
    try:
        cari_aktuator = cari(id)
    except: 
        return f"Gagal mencari aktuator  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if cari_aktuator is None:
        return f"Gagal mencari tiang dengan id: {id}.", 400

    cari_aktuator[0]["data_konfigurasi"] = cari_by_aktuatorselesai(cari_aktuator[0]['id'])

    hasil = cari_aktuator[0]
    # app.logger.info(cari_aktuator[0])
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200


@aktuator.route("/cari/id_tiang/<string:id_tiang>", methods=["GET"])
def aktuator_cari_id_tiang(id_tiang):
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

