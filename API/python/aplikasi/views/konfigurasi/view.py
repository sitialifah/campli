from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model.konfigurasi import daftar
from aplikasi.model.konfigurasi import tambah
from aplikasi.model.konfigurasi import ubah
from aplikasi.model.konfigurasi import hapus
from aplikasi.model.konfigurasi import cari
from aplikasi.model.konfigurasi import cari_id_ref_status_konfig
from aplikasi.model.konfigurasi import cari_id_aktuator
from aplikasi.model.konfigurasi import daftarselesai
from aplikasi.model.konfigurasi import KONFIGURASI_KIND
from aplikasi.model.konfigurasi import Konfigurasi
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

konfigurasi = Blueprint("konfigurasi", __name__, url_prefix="/konfigurasi")
#Konfigurasi

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@konfigurasi.route("/tambah", methods=["POST"])
def konfigurasi_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        konfigurasi_baru = request.get_json()
    elif request.form:
        konfigurasi_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if konfigurasi_baru is None:
        return "Data konfigurasi baru tidak ada!", 400        
    # if "id_ref_aktuator" not in konfigurasi_baru.keys():
    #     return "Salah data! Property id ref aktuator tidak ada.", 400
    if "id_aktuator" not in konfigurasi_baru.keys():
        return "Salah data! Property id aktuator tidak ada.", 400
    if "email" not in konfigurasi_baru.keys():
        return "Salah data! Property email tidak ada.", 400
    
    # id_ref_aktuator = escape(konfigurasi_baru["id_ref_aktuator"]).strip()
    kapan = escape(konfigurasi_baru["kapan"]).strip()
    id_aktuator = str(escape(konfigurasi_baru["id_aktuator"]).strip())
    email = escape(konfigurasi_baru["email"]).strip()

    cari_aktuator = model.aktuator.atur.cari(int(id_aktuator))
    app.logger.info(kapan)

    if len(cari_aktuator) == 1:
        cari_aktuator = cari_aktuator[0]

        # Tambah konfigurasi baru
        try:
            hasil = tambah(kapan, id_aktuator)
        except EntityNotFoundException:
            return f"Gagal menambah konfigurasi baru", 400
        
        # jsn dumps
        cari_aktuator['list_konfigurasi'] = cari_aktuator['list_konfigurasi']
        cari_aktuator['list_konfigurasi'] += [str(hasil.id)]
        cari_aktuator['list_konfigurasi'] = cari_aktuator['list_konfigurasi']
        cari_aktuator['jumlah_konfigurasi'] += 1

        del cari_aktuator['id'] 
    # tambah konfigurasi baru
    try:
        hasil = model.aktuator.atur.update(int(id_aktuator), cari_aktuator)
    except EntityIdException:
        return "Gagal menambah data!", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@konfigurasi.route("/daftar", methods=["GET"])
def konfigurasi_daftar():

    # Minta data semua pengaduan
    hasil = model.konfigurasi.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar konfigurasi.", 400

    # Ubah class ke dictionary
    daftar_konfigurasi = []
    for satu_hasil in hasil:
        daftar_konfigurasi.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_konfigurasi }

    return jsonify(hasil), 200

@konfigurasi.route("/daftarselesai", methods=["GET"])
def konfigurasi_daftarselesai():
    hasil = model.konfigurasi.atur.daftarselesai()
    if hasil is None:
        return "Gagal", 400
    daftar_konfigurasi=[]
    for satu_hasil in hasil:
        daftar_konfigurasi.append(satu_hasil)
    hasil = {"daftar konfigurasi selesai": daftar_konfigurasi}
    return jsonify(hasil), 200

# route untuk daftar konfigurasi selesai berdasarkan email
@konfigurasi.route("/daftarselesaibyemail/<string:email>", methods=["GET"])
def konfigurasi_daftarselesaibyemail(email):
    hasil = model.konfigurasi.atur.daftarselesaibyemail(email)
    if hasil is None:
        return "Gagal", 400
    daftar_konfigurasi=[]
    for satu_hasil in hasil:
        daftar_konfigurasi.append(satu_hasil)
    hasil = {"daftar konfigurasi selesai": daftar_konfigurasi}
    return jsonify(hasil), 200


@konfigurasi.route("/hapus/<int:id>", methods=["DELETE"])
def konfigurasi_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200


@konfigurasi.route("/ubah/<int:id>", methods=["PUT"])
def konfigurasi_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        konfigurasi_baru = request.get_json()
    elif request.form:
        konfigurasi_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if konfigurasi_baru is None:
        return "Data konfigurasi baru tidak ada!", 400        
    # if "id_ref_aktuator" not in konfigurasi_baru.keys():
    #     return "Salah data! Property id_ref_aktuator tidak ada.", 400
    if "kapan" not in konfigurasi_baru.keys():
        return "Salah data! Property kapan tidak ada.", 400
    if "id_aktuator" not in konfigurasi_baru.keys():
        return "Salah data! Property id tiang tidak ada.", 400
    if "email" not in konfigurasi_baru.keys():
        return "Salah data! Property email tidak ada.", 400

    konfigurasi_baru = Konfigurasi( 
                                    # id_ref_aktuator = konfigurasi_baru["id_ref_aktuator"],
                                    kapan       = konfigurasi_baru["kapan"],
                                    id_aktuator = konfigurasi_baru["id_aktuator"],
                                    email       = konfigurasi_baru["email"])
    try:
        hasil = ubah(id, konfigurasi_baru) 
    except EntityNotFoundException:
        return f"Tidak ada konfigurasi dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah konfigurasi dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@konfigurasi.route("/cari/<int:id>", methods=["GET"])
def konfigurasi_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari konfigurasi  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari konfigurasi dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

@konfigurasi.route("/cari/id_ref_status_konfig/<string:id_ref_status_konfig>", methods=["GET"])
def konfigurasi_cari_id_ref_status_konfig(id_ref_status_konfig):
    try:
        hasil = cari_id_ref_status_konfig(id_ref_status_konfig)
    except:
        return f"Gagal mengambil id_ref_status_konfig '{id_ref_status_konfig}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil id_ref_status_konfig '{id_ref_status_konfig}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200

@konfigurasi.route("/cari/id_aktuator/<string:id_aktuator>", methods=["GET"])
def konfigurasi_cari_id_aktuator(id_aktuator):
    try:
        hasil = cari_id_aktuator(id_aktuator)
    except:
        return f"Gagal mengambil id_aktuator '{id_aktuator}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil id_aktuator '{id_aktuator}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200


