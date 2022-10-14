from google.cloud import datastore

from .model import REF_AKTUATOR_KIND, Ref_Aktuator


# Tambah Ref_Aktuator
#
# Tambah object Ref_Aktuator ke datastore.
def tambah(nama_aktuator):
   
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if nama_aktuator is not None:
        # Buat object baru
        Ref_Aktuator_baru = Ref_Aktuator(nama_aktuator=nama_aktuator)
        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(REF_AKTUATOR_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Ref_Aktuator ke entity baru
        entity_baru.update(Ref_Aktuator_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Ref_Aktuator yang baru disimpan dengan id yang diberikan
        return Ref_Aktuator(id=entity_baru.id, 
                    nama_aktuator=entity_baru["nama_aktuator"])
        
# Ambil daftar Ref_Aktuator
#
# Ambil semua entity Ref_Aktuator yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind ref aktuator
    query = client.query(kind=REF_AKTUATOR_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Ref_Aktuator.
    daftar_Ref_Aktuator = []
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_ref_aktuator = Ref_Aktuator(id=satu_hasil.id,
                            nama_aktuator=satu_hasil["nama_aktuator"]
                            )
        # append atau add elemen ke list
        daftar_Ref_Aktuator.append(satu_ref_aktuator)

    # Kembalikan list object ref_aktuator
    return daftar_Ref_Aktuator

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_ref_aktuator = client.key(REF_AKTUATOR_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_ref_aktuator)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada ref aktuator dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, Ref_Aktuator_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_ref_aktuator = client.key(REF_AKTUATOR_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_ref_aktuator)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada ref aktuator dengan id: {id}.")

    # Simpan
    hasil.update(Ref_Aktuator_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Ref_Aktuator(id=id,
                nama_aktuator=hasil["nama_aktuator"])

