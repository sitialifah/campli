from google.cloud import datastore
from aplikasi import app, model
from .model import AKTUATOR_KIND, Aktuator
from aplikasi.model.konfigurasi import KONFIGURASI_KIND, Konfigurasi
from aplikasi.model.exception import EntityNotFoundException
from aplikasi.model.exception import EntityIdException

from .model import AKTUATOR_KIND, Aktuator
# from model.pot importAktuator

# TambahAktuator
#
# Tambah objectAktuator ke datastore.
def tambah(id_ref_aktuator, id_tiang, nama_pengenal_aktuator, jenis_aktuator):
    # Pastikan ada Aktuator 
    # # tambah aktuator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if id_ref_aktuator != None and id_tiang != None and nama_pengenal_aktuator!=None and jenis_aktuator!=None:
        # Buat object baru
        aktuator_baru = Aktuator(
                                id_ref_status="Aktif",
                                id_ref_aktuator=id_ref_aktuator,
                                id_tiang=id_tiang,
                                nama_pengenal_aktuator=nama_pengenal_aktuator,
                                jenis_aktuator=jenis_aktuator,
                                jumlah_konfigurasi=0,
                                list_konfigurasi=[])

        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(AKTUATOR_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Pot ke entity baru
        entity_baru.update(aktuator_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan objectAktuator yang baru disimpan dengan id yang diberikan
        return Aktuator(
                                id=entity_baru.id, 
                                id_ref_status=entity_baru["id_ref_status"], 
                                id_ref_aktuator=entity_baru["id_ref_aktuator"], 
                                id_tiang=entity_baru["id_tiang"],
                                nama_pengenal_aktuator=entity_baru["nama_pengenal_aktuator"],
                                jenis_aktuator=entity_baru["jenis_aktuator"],
                                jumlah_konfigurasi=entity_baru["jumlah_konfigurasi"],
                                list_konfigurasi=entity_baru["list_konfigurasi"]
                                )

        
# Ambil daftar aktuator
#
# Ambil semua entity aktuator yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind aktuator
    query = client.query(kind=AKTUATOR_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Pot.
    daftar_aktuator = []

    
    # mau tarik data nama aktuator pada tabel ref_aktuator berdasarkan id yang dikirim
    refaktuator = model.ref_aktuator.atur.daftar()
    aktuator_nama = {}
    for data in refaktuator:
        aktuator_nama[str(data.id)] = data.nama_aktuator

    # mau tarik data nama tiang pada tabel tiang berdasarkan id yang dikirim
    tiang = model.tiang.atur.daftar()
    tiang_nama = {}
    for data in tiang:
        tiang_nama[str(data.id)] = data.nama_tiang

    # iterate data aktuator, simpan ke list
    for satu_hasil in hasil:
        satu_aktuator =Aktuator(
                                            id=satu_hasil.id,
                                            id_ref_status=satu_hasil["id_ref_status"],
                                            id_ref_aktuator=aktuator_nama[satu_hasil["id_ref_aktuator"]],
                                            id_tiang=tiang_nama[satu_hasil["id_tiang"]],
                                            nama_pengenal_aktuator=satu_hasil["nama_pengenal_aktuator"],
                                            jenis_aktuator=satu_hasil["jenis_aktuator"],
                                            jumlah_konfigurasi=satu_hasil["jumlah_konfigurasi"],
                                            list_konfigurasi=satu_hasil["list_konfigurasi"]
                                            )

        # append atau add elemen ke list
        daftar_aktuator.append(satu_aktuator)

    # Kembalikan list object pot
    return daftar_aktuator

def ubah(id, aktuator_ubah):
    """ 
    Simpan data aktuator yang baru. 
    Perhatikan: id_tiang tidak bisa diubah.
    """

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_aktuator = client.key(AKTUATOR_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_aktuator)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada Aktuator dengan id: {id}.")

    # Simpan
    aktuator_ubah.id_tiang = hasil["id_tiang"] # id_tiang tidak bisa diubah
    hasil.update(aktuator_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Aktuator(
                            id=hasil.id, 
                            id_ref_status=hasil["id_ref_status"], 
                            id_ref_aktuator=hasil["id_ref_aktuator"], 
                            id_tiang=hasil["id_tiang"],
                            jenis_aktuator=hasil["jenis_aktuator"],
                            jumlah_konfigurasi=hasil["jumlah_konfigurasi"],
                            nama_pengenal_aktuator=hasil["nama_pengenal_aktuator"],
                            list_konfigurasi=hasil["list_konfigurasi"])


def cari(id):
    if id is not None:
        """ Mencari satu  aktuator berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_aktuator = client.key(AKTUATOR_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_aktuator)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada aktuator dengan id: {id}.")
        # buat list
        data_aktuator = []
        # buat objek operator
        aktuator =Aktuator(    
                                        id=hasil.id, 
                                        id_ref_status=hasil["id_ref_status"], 
                                        id_ref_aktuator=hasil["id_ref_aktuator"], 
                                        id_tiang=hasil["id_tiang"],
                                        jenis_aktuator=hasil["jenis_aktuator"],
                                        jumlah_konfigurasi=hasil["jumlah_konfigurasi"],
                                        nama_pengenal_aktuator=hasil["nama_pengenal_aktuator"],
                                        list_konfigurasi=hasil["list_konfigurasi"])
        # ubah format data ke dictionary dan append ke list
        data_aktuator.append(aktuator.ke_dictionary())
        return data_aktuator

# munculin data tiang dengan nested data aktuator  yang ambil juga seluruh data konfigurasi
# berdasarkan id_aktuator
def cari_by_tiangkonfigurasi(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=AKTUATOR_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_aktuator = []

        for data in hasil:
            data_konfigurasi = []
            konfigurasi = model.konfigurasi.atur.cari_by_aktuator(data.id)
            for datakonfigurasi in konfigurasi:
                data_konfigurasi.append(datakonfigurasi)
            # buat objek operator
            aktuator = Aktuator(    id                      =data.id, 
                                    id_ref_status           =data["id_ref_status"], 
                                    id_ref_aktuator         =data["id_ref_aktuator"], 
                                    id_tiang                =data["id_tiang"],
                                    jenis_aktuator          =data["jenis_aktuator"],
                                    jumlah_konfigurasi      =data["jumlah_konfigurasi"],
                                    nama_pengenal_aktuator  =data["nama_pengenal_aktuator"],
                                    list_konfigurasi        =data_konfigurasi)
            # ubah format data ke dictionary dan append ke list
            data_aktuator.append(aktuator.ke_dictionary())
        return data_aktuator

def cari_by_tiangping(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=AKTUATOR_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_aktuator = []

        for data in hasil:
            data_konfigurasi = []
            konfigurasi = model.konfigurasi.atur.cari_by_aktuator(data.id)
            for datakonfigurasi in konfigurasi:
                data_konfigurasi.append(datakonfigurasi)
            # buat objek operator
            aktuator = Aktuator(    id                      =data.id, 
                                    id_ref_status           =data["id_ref_status"], 
                                    id_ref_aktuator         =data["id_ref_aktuator"], 
                                    id_tiang                =data["id_tiang"],
                                    jenis_aktuator          =data["jenis_aktuator"],
                                    jumlah_konfigurasi      =data["jumlah_konfigurasi"],
                                    nama_pengenal_aktuator  =data["nama_pengenal_aktuator"],
                                    list_konfigurasi        =data_konfigurasi)
            # ubah format data ke dictionary dan append ke list
            # res = aktuator.ke_dictionary()
            if (aktuator.jumlah_konfigurasi <1 and aktuator.id_ref_status=="Aktif"):
                aktuator.id_ref_status = "non aktif"
                # res["id_ref_status"] = aktuator.id_ref_status
            # if(aktuator.id_ref_status != "Aktif"):
            #     data_aktuator.append(res)
            data_aktuator.append(aktuator.ke_dictionary())
        return data_aktuator
        
def cari_id_ref_aktuator(id_ref_aktuator):
    if id_ref_aktuator is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=AKTUATOR_KIND)
        query.add_filter('id_ref_aktuator', '=', id_ref_aktuator)
        query.order = ['id_ref_aktuator']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_aktuator = []
        for satu_hasil_entity in hasil:
            satu_hasil = Aktuator(
                                    id                       =satu_hasil_entity.id,
                                    id_ref_status            =satu_hasil_entity["id_ref_status"],
                                    id_ref_aktuator           =satu_hasil_entity["id_ref_aktuator"],
                                    id_tiang                 =satu_hasil_entity["id_tiang"],
                                    jenis_aktuator           =satu_hasil_entity["jenis_aktuator"],
                                    jumlah_konfigurasi       =satu_hasil_entity["jumlah_konfigurasi"],
                                    nama_pengenal_aktuator   =satu_hasil_entity["nama_pengenal_aktuator"],
                                    list_konfigurasi         =satu_hasil_entity["list_konfigurasi"])
            # append atau add elemen ke list
            data_aktuator.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_aktuator

def cari_id_tiang(id_tiang):
    if id_tiang is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=AKTUATOR_KIND)
        query.add_filter('id_tiang', '=', id_tiang)
        query.order = ['id_tiang']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_aktuator = []
        for satu_hasil_entity in hasil:
            satu_hasil =Aktuator(
                                        id                      =satu_hasil_entity.id,
                                        id_ref_status           =satu_hasil_entity["id_ref_status"],
                                        id_ref_aktuator         =satu_hasil_entity["id_ref_aktuator"],
                                        id_tiang                =satu_hasil_entity["id_tiang"],
                                        jenis_aktuator          =satu_hasil_entity["jenis_aktuator"],
                                        jumlah_konfigurasi      =satu_hasil_entity["jumlah_konfigurasi"],
                                        nama_pengenal_aktuator  =satu_hasil_entity["nama_pengenal_aktuator"],
                                        list_konfigurasi        =satu_hasil_entity["list_konfigurasi"])
            # append atau add elemen ke list
            data_aktuator.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_aktuator

def update(id, data):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data tiang berdasar property id
    key = client.key(AKTUATOR_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada aktuator  dengan id: {id}.")
    
    # Simpan
    hasil.update(data)
    client.put(hasil)
    # kembalikan data pengaduan
    return Aktuator(id=id)



