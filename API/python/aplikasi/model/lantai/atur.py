from google.cloud import datastore
from aplikasi import app, model
from .model import LANTAI_KIND, Lantai
from aplikasi.model.pot import POT_KIND, Pot
from aplikasi.model.pot import cari
from aplikasi.model.exception import EntityNotFoundException, EntityIdException

# from model.tiang import Tiang

# Tambah Lantai
#
# Tambah object Lantai ke datastore.
def tambah(nama_lantai, id_tiang):
    # Pastikan ada tiangnya 
    # tiang = model.tiang.cari(id_tiang)
    # # tambah operator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if nama_lantai and id_tiang is not None:
        # Buat object baru
        lantai_baru = Lantai(nama_lantai=nama_lantai,
                            jumlah_pot=0,
                            id_tiang=id_tiang,
                            list_pot=[])
        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(LANTAI_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Lantai ke entity baru
        entity_baru.update(lantai_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Lantai yang baru disimpan dengan id yang diberikan
        return Lantai(id=entity_baru.id, 
                    nama_lantai=entity_baru["nama_lantai"], 
                    jumlah_pot=entity_baru["jumlah_pot"],
                    id_tiang=entity_baru["id_tiang"],
                    list_pot=entity_baru["list_pot"]
                    )
        
# Ambil daftar Lantai
#
# Ambil semua entity Lantai yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind lantai
    query = client.query(kind=LANTAI_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Lantai.
    daftar_lantai = []
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_lantai = Lantai(id=satu_hasil.id,
                            nama_lantai=satu_hasil["nama_lantai"],
                            jumlah_pot=satu_hasil["jumlah_pot"],
                            id_tiang=satu_hasil["id_tiang"],
                            list_pot=satu_hasil["list_pot"])
        # append atau add elemen ke list
        daftar_lantai.append(satu_lantai)

    # Kembalikan list object lantai
    return daftar_lantai

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_lantai = client.key(LANTAI_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_lantai)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada lantai dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, lantai_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_lantai = client.key(LANTAI_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_lantai)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada lantai dengan id: {id}.")

    # Simpan
    hasil.update(lantai_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Lantai(id=id,
                nama_lantai=hasil["nama_lantai"],
                jumlah_pot=hasil["jumlah_pot"],
                id_tiang=hasil["id_tiang"],
                list_pot=hasil["list_pot"])

def cari_id(id):
    if id is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_lantai = client.key(LANTAI_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_lantai)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada lantai  dengan id: {id}.")
        # buat list
        data_lantai = []
        # buat objek operator
        lantai = Lantai(    id=id,
                            nama_lantai =hasil["nama_lantai"],
                            jumlah_pot  =hasil["jumlah_pot"],
                            id_tiang    =hasil["id_tiang"],
                            list_pot    =hasil["list_pot"])
        # ubah format data ke dictionary dan append ke list
        data_lantai.append(lantai.ke_dictionary())
        return data_lantai

def cari_by_tiang(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=LANTAI_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_lantai = []

        for data in hasil:
            # buat objek operator
            lantai = Lantai(    id=data.id,
                                nama_lantai =data["nama_lantai"],
                                jumlah_pot  =data["jumlah_pot"],
                                id_tiang    =data["id_tiang"],
                                list_pot    =data["list_pot"])
            # ubah format data ke dictionary dan append ke list
            data_lantai.append(lantai.ke_dictionary())
        return data_lantai

def cari_by_tiangpot(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=LANTAI_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_lantai = []

        for data in hasil:
            data_pot = []
            pot = model.pot.atur.cari_by_lantai(data.id)
            for datapot in pot:
                data_pot.append(datapot)
            # buat objek operator
            lantai = Lantai(    id=data.id,
                                nama_lantai =data["nama_lantai"],
                                jumlah_pot  =data["jumlah_pot"],
                                id_tiang    =data["id_tiang"],
                                list_pot    =data_pot)
            # ubah format data ke dictionary dan append ke list
            data_lantai.append(lantai.ke_dictionary())
        return data_lantai

def cari_by_tiangsensor(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=LANTAI_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_lantai = []

        pot = model.pot.atur.cari_by_tiang(tiang)
        data_pot = []
        for datapot in pot:
            data_pot.append(datapot)
            
        for data in hasil:
            # buat objek operator
            lantai = Lantai(    id=data.id,
                                nama_lantai =data["nama_lantai"],
                                jumlah_pot  =data["jumlah_pot"],
                                id_tiang    =data["id_tiang"],
                                list_pot    =data_pot)
            # ubah format data ke dictionary dan append ke list
            data_lantai.append(lantai.ke_dictionary())
        return data_lantai

def cari_nama_lantai(nama_lantai):
    if nama_lantai is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=LANTAI_KIND)
        query.add_filter('nama_lantai', '=', nama_lantai)
        query.order = ['nama_lantai']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_lantai = []
        for satu_hasil_entity in hasil:
            satu_hasil = Lantai(
                                id           =satu_hasil_entity.id,
                                nama_lantai  =satu_hasil_entity["nama_lantai"],
                                jumlah_pot   =satu_hasil_entity["jumlah_pot"],
                                id_tiang     =satu_hasil_entity["id_tiang"],
                                list_pot     =satu_hasil_entity["list_pot"])
            # append atau add elemen ke list
            data_lantai.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_lantai

def cari_id_tiang(id_tiang):
    if id_tiang is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=LANTAI_KIND)
        query.add_filter('id_tiang', '=', id_tiang)
        query.order = ['id_tiang']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_lantai = []
        for satu_hasil_entity in hasil:
            satu_hasil = Lantai(
                                id           =satu_hasil_entity.id,
                                nama_lantai  =satu_hasil_entity["nama_lantai"],
                                jumlah_pot   =satu_hasil_entity["jumlah_pot"],
                                id_tiang     =satu_hasil_entity["id_tiang"],
                                list_pot     =satu_hasil_entity["list_pot"])
            # append atau add elemen ke list
            data_lantai.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_lantai

#funcion untuk select lantai by id tiang

def update(id, data):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data tiang berdasar property id
    key = client.key(LANTAI_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada lantai  dengan id: {id}.")
    
    # Simpan
    hasil.update(data)
    client.put(hasil)
    # kembalikan data pengaduan
    return Lantai(id=id)

