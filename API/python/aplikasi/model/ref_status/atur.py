from google.cloud import datastore

from .model import REF_STATUS_KIND, Ref_Status
# from model.status import Ref_Status

# Tambah Ref_Status
#
# Tambah object Ref_Status ke datastore.
def tambah(nama):
    # Pastikan ada status 
    # status = model.status.cari(id_lantai)
    # # tambah operator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if nama is not None:
        # Buat object baru
        ref_status_baru = Ref_Status(nama=nama)
        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(REF_STATUS_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Ref_Status ke entity baru
        entity_baru.update(ref_status_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Ref_Status yang baru disimpan dengan id yang diberikan
        return Ref_Status(id=entity_baru.id, 
                    nama=entity_baru["nama"])
        
# Ambil daftar Ref_Status
#
# Ambil semua entity Ref_Status yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind status
    query = client.query(kind=REF_STATUS_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Ref_Status.
    daftar_ref_status = []
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_status = Ref_Status(id=satu_hasil.id,
                            nama=satu_hasil["nama"]
                            )
        # append atau add elemen ke list
        daftar_ref_status.append(satu_status)

    # Kembalikan list object status
    return daftar_ref_status

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_status = client.key(REF_STATUS_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_status)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada ref status dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, ref_status_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_status = client.key(REF_STATUS_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_status)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada ref status dengan id: {id}.")

    # Simpan
    hasil.update(ref_status_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Ref_Status(id=id,
                nama=hasil["nama"])

