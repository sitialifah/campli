from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model.ref_aktuator import tambah
from aplikasi.model.ref_aktuator import daftar
from aplikasi.model.ref_aktuator import ubah
from aplikasi.model.ref_aktuator import hapus
from aplikasi.model.ref_aktuator import REF_AKTUATOR_KIND
from aplikasi.model.ref_aktuator import Ref_Aktuator
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

ref_aktuator = Blueprint("ref_aktuator", __name__, url_prefix="/ref_aktuator")
#Pot

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@ref_aktuator.route("/tambah", methods=["POST"])
def ref_aktuator_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        ref_aktuator_baru = request.get_json()
    elif request.form:
        ref_aktuator_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if ref_aktuator_baru is None:
        return "Data ref_aktuator baru tidak ada!", 400        
    if "nama_aktuator" not in ref_aktuator_baru.keys():
        return "Salah data! Property nama_aktuator tidak ada.", 400

    nama_aktuator = escape(ref_aktuator_baru["nama_aktuator"]).strip()

    # Tambah ref_aktuator baru
    try:
        hasil = tambah(nama_aktuator)
    except EntityNotFoundException:
        return f"Gagal menambah nama aktuator baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@ref_aktuator.route("/daftar", methods=["GET"])
def ref_aktuator_daftar():

    # Minta data semua ref aktuator
    hasil = model.ref_aktuator.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar ref aktuator.", 400

    # Ubah class ke dictionary
    daftar_ref_aktuator = []
    for satu_hasil in hasil:
        daftar_ref_aktuator.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_ref_aktuator }

    return jsonify(hasil), 200


@ref_aktuator.route("/hapus/<int:id>", methods=["DELETE"])
def ref_aktuator_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200


@ref_aktuator.route("/ubah/<int:id>", methods=["PUT"])
def ref_aktuator_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        ref_aktuator_baru = request.get_json()
    elif request.form:
        ref_aktuator_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if ref_aktuator_baru is None:
        return "Data ref aktuator baru tidak ada!", 400        
    if "nama_aktuator" not in ref_aktuator_baru.keys():
        return "Salah data! Property nama aktuator tidak ada.", 400

    ref_aktuator_baru = Ref_Aktuator(nama_aktuator= ref_aktuator_baru["nama_aktuator"])
    try:
        hasil = ubah(id, ref_aktuator_baru) 
    except EntityNotFoundException:
        return f"Tidak ada ref_aktuator dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah ref_aktuator dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200
