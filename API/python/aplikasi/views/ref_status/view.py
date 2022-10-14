from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template
from aplikasi import model
from aplikasi.model.ref_status import tambah
from aplikasi.model.ref_status import daftar
from aplikasi.model.ref_status import ubah
from aplikasi.model.ref_status import hapus
from aplikasi.model.ref_status import REF_STATUS_KIND
from aplikasi.model.ref_status import Ref_Status
from aplikasi.model.exception import EntityIdException, EntityNotFoundException

from aplikasi import app


from flask_login import login_required

ref_status = Blueprint("ref_status", __name__, url_prefix="/ref_status")
#Pot

# Endpoint untuk URL: /dashboardadmin
#

# Tampilkan halaman jika sudah login

@ref_status.route("/tambah", methods=["POST"])
def ref_status_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        ref_status_baru = request.get_json()
    elif request.form:
        ref_status_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if ref_status_baru is None:
        return "Data ref_status baru tidak ada!", 400        
    if "nama_status" not in ref_status_baru.keys():
        return "Salah data! Property nama status tidak ada.", 400

    nama_status = escape(ref_status_baru["nama_status"]).strip()

    # Tambah status baru
    try:
        hasil = tambah(nama_status)
    except EntityNotFoundException:
        return f"Gagal menambah nama status baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200

@ref_status.route("/daftar", methods=["GET"])
def ref_status_daftar():

    # Minta data semua ref status
    hasil = model.ref_status.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar ref status.", 400

    # Ubah class ke dictionary
    daftar_ref_status = []
    for satu_hasil in hasil:
        daftar_ref_status.append(satu_hasil.ke_dictionary())
    
    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_ref_status }

    return jsonify(hasil), 200


@ref_status.route("/hapus/<int:id>", methods=["DELETE"])
def ref_status_hapus(id):
    # Panggil method hapus 
    
    hasil = hapus(id)
    return "Berhasil", 200


@ref_status.route("/ubah/<int:id>", methods=["PUT"])
def ref_status_ubah(id):
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        ref_status_baru = request.get_json()
    elif request.form:
        ref_status_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400
    
    # Periksa parameter sudah benar
    if ref_status_baru is None:
        return "Data ref status baru tidak ada!", 400        
    if "nama_status" not in ref_status_baru.keys():
        return "Salah data! Property nama status tidak ada.", 400

    ref_status_baru = Ref_Status(nama_status= ref_status_baru["nama_status"])
    try:
        hasil = ubah(id, ref_status_baru) 
    except EntityNotFoundException:
        return f"Tidak ada ref_status dengan id: {id}.", 400
    except: 
        return f"Gagal mengubah ref_status dengan id: {id}.", 400
    
    if (hasil is None):
        return "Gagal menambah data!", 500

    return "Berhasil", 200
