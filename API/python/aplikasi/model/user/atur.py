from google.cloud import datastore
from aplikasi import app, model
from aplikasi.model.exception import EntityNotFoundException, EntityIdException

from .model import USER_KIND, User


def tambah(email, no_hp):
    #tambah user

    # cek parameter
    if email and no_hp is not None:
        user_baru = User(email=email, no_hp=no_hp)

        client = datastore.Client()
        key_baru = client.key(USER_KIND)
        entity_baru = datastore.Entity(key=key_baru)
        entity_baru.update(user_baru.ke_dictionary())
        client.put(entity_baru)
        return User(id=entity_baru.id,
                    email=entity_baru["email"],
                    no_hp=entity_baru["no_hp"])


def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind lantai
    query = client.query(kind=USER_KIND)
    # Jalankan query
    hasil = query.fetch()


    daftar_user = []
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_user = User(id=satu_hasil.id,
                            email=satu_hasil["email"],
                            no_hp=satu_hasil["no_hp"])
        # append atau add elemen ke list
        daftar_user.append(satu_user)

    # Kembalikan list object lantai
    return daftar_user

def cari(id):
    if id is not None:
        """ Mencari satu user berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_user = client.key(USER_KIND, id)
        hasil = client.get(key_user)
        
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada user dengan id: {id}.")

        return User(id=hasil.id,email=hasil["email"])

def cari_email(email):
    if email is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=USER_KIND)
        query.add_filter('email', '=', email)
        query.order = ['email']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_user = []
        for satu_hasil_entity in hasil:
            satu_hasil = User(id=satu_hasil_entity.id, email=satu_hasil_entity["email"])
            # append atau add elemen ke list
            data_user.append(satu_hasil)
        # kembalikan list 
        return data_user
