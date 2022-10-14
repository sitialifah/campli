
from flask import Blueprint, request, session, escape, redirect, flash, jsonify, render_template, url_for
from aplikasi import model
from aplikasi.model.user import cari, tambah, USER_KIND, User, cari_email, daftar
from aplikasi.model.exception import EntityIdException, EntityNotFoundException


import logging

from aplikasi import app


user = Blueprint("user", __name__, url_prefix="/user")

#User

# Endpoint untuk URL: /dashboarduser
#

# Tampilkan halaman jika sudah login

@user.route("/tambah", methods=["POST"])
def user_tambah():
    # konversi request ke json
    if request.is_json:
        # Ambil parameter
        user_baru = request.get_json()
    elif request.form:
        user_baru = request.form
    else:
        return "Hanya menerima request json dan form", 400

    # Periksa parameter sudah benar
    if user_baru is None:
        return "Data User baru tidak ada!", 400        
    if "email" not in user_baru.keys():
        return "Salah data! Property email tidak ada.", 400
    

    email = escape(user_baru["email"]).strip()
    no_hp = escape(user_baru["no_hp"]).strip()

    # Tambah user baru
    try:
        hasil = tambah(email, no_hp)
    except EntityNotFoundException:
        return f"Gagal menambah user baru", 400

    # Pastikan berhasil
    if (hasil is None):
        return "Gagal menambah data!", 500

    return redirect(url_for('campli.tabeluser'))

@user.route("/daftar", methods=["GET"])
def user_daftar():

    # Minta data semua user
    hasil = model.user.atur.daftar()

    # Pastikan berhasil
    if hasil is None:
        return "Gagal meminta daftar user.", 400

    # Ubah class ke dictionary
    daftar_user = []
    for satu_hasil in hasil:
        daftar_user.append(satu_hasil.ke_dictionary())

    # Buat wrapper dictionaty untuk dikembalikan
    hasil = { "daftar": daftar_user }

    return jsonify(hasil), 200

@user.route("/cariemail/<string:email>", methods=["GET"])
def user_cari_email(email):
    # email = request.form.get("email")

    try:
        hasil = cari_email(email)
    except:
        return f"Gagal mengambil email '{email}'", 400

        # Pastikan berhasil
    if hasil == []:
        return f"Gagal mengambil email '{email}'", 400

    # Buat wrapper dictionaty untuk dikembalikan
    hasil_json = []
    for satu_hasil in hasil:
        # kalau tidak diubah ke dictionary hasilnya error json not serializable(?)
        satu_hasil_json = satu_hasil.ke_dictionary()
        hasil_json.append(satu_hasil_json)            

    return jsonify(hasil_json), 200
    
@user.route("/cari/<int:id>", methods=["GET"])
def user_cari(id):
    # Lakukan pencarian
    try:
        hasil = cari(id)
    except: 
        return f"Gagal mencari user dengan id: {id}.", 400
    
    # Pastikan berhasil
    if hasil is None:
        return f"Gagal mencari user dengan id: {id}.", 400
    # Kembalikan hasilnya dalam format JSON dan kode HTTP 200
    return jsonify(hasil), 200

