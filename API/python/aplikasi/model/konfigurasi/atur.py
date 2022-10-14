from google.cloud import datastore
from google.cloud import datastore
from aplikasi import app, model

import datetime

from .model import KONFIGURASI_KIND, Konfigurasi

#tambah 1 atribut email


# Tambah Konfigurasi
#
# Tambah object Konfigurasi ke datastore.
def tambah(kapan, id_aktuator, email):
    # Pastikan ada tiangnya 
    # tiang = model.tiang.cari(id_aktuator)
    # # tambah operator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if kapan !=None and id_aktuator != None:
        # Buat object baru
        konfigurasi_baru = Konfigurasi( kapan=kapan,                                      
                                        id_ref_status_konfig="belum dikerjakan",  
                                        id_aktuator=id_aktuator,
                                        email=email)
        app.logger.info(kapan)                                
        konfigurasi_baru.kapan = datetime.datetime.timestamp(datetime.datetime.strptime(konfigurasi_baru.kapan, '%Y-%m-%dT%H:%M'))
                                        
        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(KONFIGURASI_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Konfigurasi ke entity baru
        entity_baru.update(konfigurasi_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Konfigurasi yang baru disimpan dengan id yang diberikan
        return Konfigurasi( id=entity_baru.id, 
                            id_ref_status_konfig=entity_baru["id_ref_status_konfig"], 
                            kapan=entity_baru["kapan"],
                            id_aktuator=entity_baru["id_aktuator"],
                            email=entity_baru["email"])
                            
        
# Ambil daftar konfigurasi
#
# Ambil semua entity konfigurasi yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind konfigurasi
    query = client.query(kind=KONFIGURASI_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Konfigurasu.
    daftar_konfigurasi = []

    # mau tarik data nama status pada tabel ref_status_konfig berdasarkan id yang dikirim
    # status = model.ref_status_konfig.atur.daftar()
    # status_nama = {}
    # for data in status:
    #     status_nama[str(data.id)] = data.nama_status_konfig
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_konfigurasi = Konfigurasi( id=satu_hasil.id,
                                        id_ref_status_konfig=satu_hasil["id_ref_status_konfig"],
                                        kapan=satu_hasil["kapan"],
                                        id_aktuator=satu_hasil["id_aktuator"],
                                        email=satu_hasil["email"])
        if(satu_konfigurasi.kapan != ""):
            satu_konfigurasi.kapan = datetime.datetime.fromtimestamp(float(satu_konfigurasi.kapan)).strftime('%Y-%m-%dT%H:%M')
        # append atau add elemen ke list
        daftar_konfigurasi.append(satu_konfigurasi)

    # Kembalikan list object konfigurasi
    return daftar_konfigurasi

# function untuk munculin semua daftar konfigurasi yang selesai 
def daftarselesai():
    client = datastore.Client()
    query = client.query(kind=KONFIGURASI_KIND)
    hasil = query.fetch()
    daftar_konfigurasi = []

    # mau tarik data nama aktuator pada tabel aktuator  berdasarkan id yang dikirim
    aktuator = model.aktuator.atur.daftar()
    aktuator_nama = {}
    for data in aktuator:
        aktuator_nama[str(data.id)] = data.nama_pengenal_aktuator

    u = datetime.datetime.now()
    for satu_hasil in hasil:
        satu_konfigurasi = Konfigurasi(
                                        id                      =satu_hasil.id,
                                        id_ref_status_konfig    =satu_hasil["id_ref_status_konfig"],
                                        kapan                   =satu_hasil["kapan"],
                                        id_aktuator             =aktuator_nama[satu_hasil["id_aktuator"]],
                                        email                   =satu_hasil["email"])
        if(satu_konfigurasi.kapan != ""):
            satu_konfigurasi.kapan = datetime.datetime.fromtimestamp(float(satu_konfigurasi.kapan)).strftime('%Y-%m-%dT%H:%M')
            app.logger.info(satu_konfigurasi.kapan)
            x = datetime.datetime.timestamp(datetime.datetime.strptime(satu_konfigurasi.kapan, '%Y-%m-%dT%H:%M'))
            x = datetime.datetime.fromtimestamp(x)
            satu_konfigurasi.kapan = satu_hasil["kapan"]
            

            res = satu_konfigurasi.ke_dictionary()
            if (x - u <= datetime.timedelta(seconds=1)and satu_konfigurasi.id_ref_status_konfig=="belum dikerjakan"):
                satu_konfigurasi.id_ref_status_konfig="selesai"
                res["id_ref_status_konfig"]=satu_konfigurasi.id_ref_status_konfig
                res["kapan"] = satu_hasil["kapan"]
            if(satu_konfigurasi.id_ref_status_konfig != "belum dikerjakan"):
                daftar_konfigurasi.append(res)
    return daftar_konfigurasi

# function untuk munculin semua daftar konfigurasi yang selesai berdasarkan email
def daftarselesaibyemail(email):
    if email is not None:
        #sambung ke datastore
        client = datastore.Client()
        query = client.query(kind=KONFIGURASI_KIND)

        #filter email dulu 
        query.add_filter('email', '=', email)
        query.order = ['email']
        #jalankan query
        hasil = query.fetch()
        daftar_konfigurasi = []

        # mau tarik data nama aktuator pada tabel aktuator  berdasarkan id yang dikirim
        aktuator = model.aktuator.atur.daftar()
        aktuator_nama = {}
        for data in aktuator:
            aktuator_nama[str(data.id)] = data.nama_pengenal_aktuator

        u = datetime.datetime.now()
        for satu_hasil in hasil:
            satu_konfigurasi = Konfigurasi(
                                            id                      =satu_hasil.id,
                                            id_ref_status_konfig    =satu_hasil["id_ref_status_konfig"],
                                            kapan                   =satu_hasil["kapan"],
                                            id_aktuator             =aktuator_nama[satu_hasil["id_aktuator"]],
                                            email                   =satu_hasil["email"])
            if(satu_konfigurasi.kapan != ""):
                satu_konfigurasi.kapan = datetime.datetime.fromtimestamp(float(satu_konfigurasi.kapan)).strftime('%Y-%m-%dT%H:%M')
                app.logger.info(satu_konfigurasi.kapan)
                x = datetime.datetime.timestamp(datetime.datetime.strptime(satu_konfigurasi.kapan, '%Y-%m-%dT%H:%M'))
                x = datetime.datetime.fromtimestamp(x)
                satu_konfigurasi.kapan = satu_hasil["kapan"]
                

                res = satu_konfigurasi.ke_dictionary()
                if (x - u <= datetime.timedelta(seconds=1)and satu_konfigurasi.id_ref_status_konfig=="belum dikerjakan"):
                    satu_konfigurasi.id_ref_status_konfig="selesai"
                    res["id_ref_status_konfig"]=satu_konfigurasi.id_ref_status_konfig
                    res["kapan"] = satu_hasil["kapan"]
                if(satu_konfigurasi.id_ref_status_konfig != "belum dikerjakan"):
                    daftar_konfigurasi.append(res)
        return daftar_konfigurasi


def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_konfigurasi = client.key(KONFIGURASI_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_konfigurasi)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada konfigurasi dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, konfigurasi_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_konfigurasi = client.key(KONFIGURASI_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_konfigurasi)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada konfigurasi dengan id: {id}.")

    # Simpan
    hasil.update(konfigurasi_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Konfigurasi( id=id,
                        id_ref_status_konfig=hasil["id_ref_status_konfig"], 
                        kapan=hasil["kapan"],
                        id_aktuator=hasil["id_aktuator"],
                        email=hasil["email"])

def cari(id):
    if id is not None:
        """ Mencari satu konfigurasi berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_konfigurasi = client.key(KONFIGURASI_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_konfigurasi)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada konfigurasi  dengan id: {id}.")
        # buat list
        data_konfigurasi = []
        # buat objek operator
        konfigurasi = Konfigurasi(  id=id,
                                    id_ref_status_konfig=hasil["id_ref_status_konfig"], 
                                    kapan=hasil["kapan"],
                                    id_aktuator=hasil["id_aktuator"],
                                    email=hasil["email"])
        # ubah format data ke dictionary dan append ke list
        data_konfigurasi.append(konfigurasi.ke_dictionary())
        return data_konfigurasi

def cari_id_ref_status_konfig(id_ref_status_konfig):
    if id_ref_status_konfig is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=KONFIGURASI_KIND)
        query.add_filter('id_ref_status_konfig', '=', id_ref_status_konfig)
        query.order = ['id_ref_status_konfig']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_konfigurasi = []
        for satu_hasil_entity in hasil:
            satu_hasil = Konfigurasi(
                                        id                      =satu_hasil_entity.id,
                                        id_ref_status_konfig    =satu_hasil_entity["id_ref_status_konfig"],
                                        kapan                   =satu_hasil_entity["kapan"],
                                        id_aktuator             =satu_hasil_entity["id_aktuator"],
                                        email                   =satu_hasil_entity["email"])
            # append atau add elemen ke list
            data_konfigurasi.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_konfigurasi

# function untuk munculin data konfigurasi yang belum dikerjakan berdasarkan id aktuator
def cari_by_aktuator(aktuator):
    if aktuator is not None:
        """ Mencari satu aktuator berdasarkan id-nya. """
        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=KONFIGURASI_KIND).add_filter("id_aktuator", "=", str(aktuator))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada aktuator  dengan id: {aktuator}.")
        # buat list
        data_konfigurasi = []
        
        u = datetime.datetime.now()

        for data in hasil:
            # buat objek operator
            konfigurasi = Konfigurasi(     
                                        id                      =data.id,
                                        id_ref_status_konfig    =data["id_ref_status_konfig"],
                                        kapan                   =data["kapan"],
                                        id_aktuator             =data["id_aktuator"],
                                        email                   =data["email"])

            if(konfigurasi.kapan != ""):
                konfigurasi.kapan = datetime.datetime.fromtimestamp(float(konfigurasi.kapan)).strftime('%Y-%m-%dT%H:%M')
                x = datetime.datetime.timestamp(datetime.datetime.strptime(konfigurasi.kapan, '%Y-%m-%dT%H:%M'))
                x = datetime.datetime.fromtimestamp(x)
                konfigurasi.kapan = data["kapan"]

                # try:
                res = konfigurasi.ke_dictionary()
                if (x - u <= datetime.timedelta(seconds=1) and konfigurasi.id_ref_status_konfig == "belum dikerjakan"):
                    konfigurasi.id_ref_status_konfig = "selesai"
                    res["id_ref_status_konfig"] = konfigurasi.id_ref_status_konfig
                    res["kapan"] = data["kapan"]
                if(konfigurasi.id_ref_status_konfig != "selesai"):
                    data_konfigurasi.append(res)
            
            # ubah format data ke dictionary dan append ke list
            # data_konfigurasi.append(konfigurasi.ke_dictionary())
        return data_konfigurasi
        

def cari_by_aktuatorselesai(aktuator):
    if aktuator is not None:
        """ Mencari satu aktuator berdasarkan id-nya. """
        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=KONFIGURASI_KIND).add_filter("id_aktuator", "=", str(aktuator))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada aktuator  dengan id: {aktuator}.")
        # buat list
        data_konfigurasi = []
        
        u = datetime.datetime.now()

        for data in hasil:
            # buat objek operator
            konfigurasi = Konfigurasi(     
                                        id                      =data.id,
                                        id_ref_status_konfig    =data["id_ref_status_konfig"],
                                        kapan                   =data["kapan"],
                                        id_aktuator             =data["id_aktuator"],
                                        email                   =data["email"])

            if(konfigurasi.kapan != ""):
                konfigurasi.kapan = datetime.datetime.fromtimestamp(float(konfigurasi.kapan)).strftime('%Y-%m-%dT%H:%M')
                x = datetime.datetime.timestamp(datetime.datetime.strptime(konfigurasi.kapan, '%Y-%m-%dT%H:%M'))
                x = datetime.datetime.fromtimestamp(x)
                konfigurasi.kapan = data["kapan"]

                # try:
                res = konfigurasi.ke_dictionary()
                if (x - u <= datetime.timedelta(seconds=1) and konfigurasi.id_ref_status_konfig == "belum dikerjakan"):
                    konfigurasi.id_ref_status_konfig = "selesai"
                    res["id_ref_status_konfig"] = konfigurasi.id_ref_status_konfig
                    res["kapan"] = data["kapan"]
                if(konfigurasi.id_ref_status_konfig != "belum dikerjakan"):
                    data_konfigurasi.append(res)
            
            # ubah format data ke dictionary dan append ke list
            # data_konfigurasi.append(konfigurasi.ke_dictionary())
        return data_konfigurasi
        

def cari_id_aktuator(id_aktuator):
    if id_aktuator is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=KONFIGURASI_KIND)
        query.add_filter('id_aktuator', '=', id_aktuator)
        query.order = ['id_aktuator']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_konfigurasi = []
        for satu_hasil_entity in hasil:
            satu_hasil = Konfigurasi(
                                        id                      =satu_hasil_entity.id,
                                        id_ref_status_konfig    =satu_hasil_entity["id_ref_status_konfig"],
                                        kapan                   =satu_hasil_entity["kapan"],
                                        id_aktuator             =satu_hasil_entity["id_aktuator"],
                                        email                   =satu_hasil_entity["email"])
            # append atau add elemen ke list
            data_konfigurasi.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_konfigurasi


