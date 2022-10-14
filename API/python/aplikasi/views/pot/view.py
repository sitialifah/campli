from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.pot import tambah
from aplikasi.model.pot import daftar
from aplikasi.model.pot import hapus
from aplikasi.model.pot import ubah
from aplikasi.model.pot import cari
from aplikasi.model.pot import cari_id_lantai
from aplikasi.model.pot import Pot
from aplikasi.model.pot import POT_KIND
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

pot = Blueprint("pot", __name__, url_prefix="/pot")
#Pot

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@pot.route("/tambah", methods=["POST"])
def pot_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        pot_baru = request.get_json()
    elif request.form:
        pot_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if pot_baru is None:
        return "Data pot baru tidak ada!", 400        
    if "nama_pot" not in pot_baru.keys():
        return "Salah data! Property nama pot tidak ada.", 400
    if "keterangan" not in pot_baru.keys():
        return "Salah data! Property keterangan tidak ada.", 400
    if "id_lantai" not in pot_baru.keys():
        return "Salah data! Property id lantai tidak ada.", 400
    # if "id_tiang" not in pot_baru.keys():
    #     return "Salah data! Property id pot tidak ada.", 400
    

    nama_pot = escape(pot_baru["nama_pot"]).strip()
    keterangan = escape(pot_baru["keterangan"]).strip()
    id_lantai = str(escape(pot_baru["id_lantai"]).strip())

    cari_lantai = model.lantai.atur.cari_id(int(id_lantai))

    if len(cari_lantai) == 1:
        cari_lantai = cari_lantai[0]

        # Tambah pot baru
        try:
            hasil = tambah(nama_pot, keterangan, id_lantai, cari_lantai["id_tiang"])
        except EntityNotFoundException:
            return f"Gagal menambah pot baru", 400

        # jsn dumps
        cari_lantai['list_pot'] = cari_lantai['list_pot']
        cari_lantai['list_pot'] += [str(hasil.id)]
        cari_lantai['list_pot'] = cari_lantai['list_pot']
        cari_lantai['jumlah_pot'] += 1

        del cari_lantai['id']

    try:
        hasil = model.lantai.atur.update(int(id_lantai), cari_lantai)
    except EntityNotFoundException:
        return f"Gagal menambah lantai baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500
    return redirect(url_for('campli.tabelpot'))

@pot.route("/daftar", methods=["GET"])
def pot_daftar():

    # Minta data semua pengaduan
    hasil = model.pot.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar pot.", 400

    # Ubah class ke dictionary
    daftar_pot = []
    for satu_hasil in hasil:
        daftar_pot.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_pot }

    return jsonify(hasil), 200


@pot.route("/hapus/<int:id>", methods=["DELETE"])
def pot_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200


@pot.route("/ubah/<int:id>", methods=["PUT"])
def pot_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        pot_baru = request.get_json()
    elif request.form:
        pot_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # # Periksa parameter sudah benar
    # if pot_baru is None:
    #     return "Data Pot baru tidak ada!", 400        
    # if "nama_pot" not in pot_baru.keys():
    #     return "Salah data! Property nama pot tidak ada.", 400
    # if "keterangan" not in pot_baru.keys():
    #     return "Salah data! Property keterangan tidak ada.", 400
    # if "id_lantai" not in pot_baru.keys():
    #     return "Salah data! Property id lantai tidak ada.", 400
    app.logger.info(request.form)

    try:
        cari_pot = cari(id)
        app.logger.info(cari_pot)
    
    except:
        pass
    cari_pot=cari_pot[0]
    pot_baru = Pot(  
                            nama_pot= pot_baru["nama_pot"],
                            keterangan = pot_baru["keterangan"],
                            id_lantai = pot_baru["id_lantai"],
                            status = pot_baru["status"],
                            jenis= pot_baru["jenis"],
                            jumlah_sensorpot=int(pot_baru["jumlah_sensorpot"]),
                            list_sensorpot=cari_pot["list_sensorpot"])
    try:
        hasil = ubah(id, pot_baru) 
    except EntityNotFoundException:
        return f"Tidak ada pot dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah pot dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200


@pot.route("/cari/<int:id>", methods=["GET"])
def pot_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari pot  dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari pot dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil.ke_dictionary()), 200

@pot.route("/cari/id_lantai/<string:id_lantai>", methods=["GET"])
def pot_cari_id_lantai(id_lantai):
    try:
        hasil = cari_id_lantai(id_lantai)
    except:
        return f"Gagal mengambil id_lantai '{id_lantai}'", 400

    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mengambil id_lantai '{id_lantai}'", 400
    # Buat wrapper dictionary untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil
        hasil_json.append(satu_hasil_json)     
    return jsonify(hasil_json), 200
