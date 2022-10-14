from google.cloud import datastore
from aplikasi import app, model
from .model import TIANG_KIND, Tiang
from aplikasi.model.lantai import LANTAI_KIND, Lantai
from aplikasi.model.lantai import cari_id
from aplikasi.model.aktuator import AKTUATOR_KIND, Aktuator, cari
from aplikasi.model.exception import EntityNotFoundException, EntityIdException
import datetime

"""
Controller Untuk Kind Tiang
"""
# Tambah object Tiang ke datastore.
def tambah(nama_tiang, keterangan, email):
    # cek parameter agar tidak kosong
    if  nama_tiang  and keterangan and email is not  None:
        # Buat object baru
        tiang_baru = Tiang( email=email,
                            nama_tiang=nama_tiang,
                            jumlah_lantai=0, 
                            id_ref_status="5644004762845184", 
                            keterangan=keterangan,
                            waktu_pemasangan=datetime.datetime.now().timestamp(), 
                            # waktu_pemasangan=datetime.datetime.now().fromtimestamp(float(waktu_pemasangan)).strftime('%d-%m-%y'), 
                            list_lantai=[],
                            list_aktuator=[],
                            jumlah_aktuator=0,
                            list_sensortiang=[],
                            jumlah_sensortiang=0,
                            list_sensor_suhu=[],
                            jumlah_sensor_suhu=0,
                            list_sensor_keludara=[],
                            jumlah_sensor_keludara=0)

        # app.logger.info("+" * 20)
        # app.logger.info(tiang_baru)

        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(TIANG_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Tiang ke entity baru
        entity_baru.update(tiang_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Tiang  yang baru disimpan dengan id yang diberikan
        return Tiang(id=entity_baru.id, 
                    nama_tiang              =entity_baru["nama_tiang"], 
                    jumlah_lantai           =entity_baru["jumlah_lantai"],
                    email                   =entity_baru["email"],
                    id_ref_status           =entity_baru["id_ref_status"],
                    keterangan              =entity_baru["keterangan"],
                    waktu_pemasangan        =entity_baru["waktu_pemasangan"],
                    list_lantai             =entity_baru["list_lantai"],
                    list_aktuator           =entity_baru["list_aktuator"],
                    jumlah_aktuator         =entity_baru["jumlah_aktuator"],
                    list_sensortiang        =entity_baru["list_sensortiang"],
                    jumlah_sensortiang      =entity_baru["jumlah_sensortiang"],
                    list_sensor_suhu        =entity_baru["list_sensor_suhu"],
                    jumlah_sensor_suhu      =entity_baru["jumlah_sensor_suhu"],
                    list_sensor_keludara    =entity_baru["list_sensor_keludara"],
                    jumlah_sensor_keludara  =entity_baru["jumlah_sensor_keludara"])
        
# Ambil daftar Tiang
#
# Ambil semua entity Tiang yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind tiang
    query = client.query(kind=TIANG_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Tiang.
    daftar_tiang = []

    # mau tarik data nama status pada tabel ref_status berdasarkan id yang dikirim
    status = model.ref_status.atur.daftar()
    status_nama = {}
    for data in status:
        status_nama[str(data.id)] = data.nama
    
    # iterate data tiang, simpan ke list
    for satu_hasil in hasil:
        satu_tiang = Tiang(id=satu_hasil.id,
                            email                       =satu_hasil["email"],
                            nama_tiang                  =satu_hasil["nama_tiang"],
                            jumlah_lantai               =satu_hasil["jumlah_lantai"],
                            id_ref_status               =status_nama[satu_hasil["id_ref_status"]],
                            keterangan                  =satu_hasil["keterangan"],
                            waktu_pemasangan            =satu_hasil["waktu_pemasangan"],
                            list_lantai                 =satu_hasil["list_lantai"],
                            list_aktuator               =satu_hasil["list_aktuator"],
                            jumlah_aktuator             =satu_hasil["jumlah_aktuator"],
                            list_sensortiang            =satu_hasil["list_sensortiang"],
                            jumlah_sensortiang          =satu_hasil["jumlah_sensortiang"],
                            list_sensor_suhu            =satu_hasil["list_sensor_suhu"],
                            jumlah_sensor_suhu          =satu_hasil["jumlah_sensor_suhu"],
                            list_sensor_keludara        =satu_hasil["list_sensor_keludara"],
                            jumlah_sensor_keludara      =satu_hasil["jumlah_sensor_keludara"])
        if(satu_tiang.waktu_pemasangan != ""):
            satu_tiang.waktu_pemasangan = datetime.datetime.fromtimestamp(float(satu_tiang.waktu_pemasangan)).strftime('%d-%m-%y %H:%M')
        
        # append atau add elemen ke list
        daftar_tiang.append(satu_tiang)

    # Kembalikan list object tiang
    return daftar_tiang

# Ambil daftar Tiang yang ada di datastore berdasarkan email
def daftarbyemail(email):
    if email is not None:
    # Sambung ke datastore
        client = datastore.Client()

        # Buat query untuk meminta semua isi kind tiang
        query = client.query(kind=TIANG_KIND)
        query.add_filter('email', '=', email)
        query.order = ['email']
        # Jalankan query
        hasil = query.fetch()

        # Ambil setiap entity yang dikembalikan query dan jadikan list dari
        # object Tiang.
        daftar_tiang = []

        # mau tarik data nama status pada tabel ref_status berdasarkan id yang dikirim
        status = model.ref_status.atur.daftar()
        status_nama = {}
        for data in status:
            status_nama[str(data.id)] = data.nama
        
        # iterate data operator, simpan ke list
        for satu_hasil in hasil:
            satu_tiang = Tiang(id=satu_hasil.id,
                                email                  =satu_hasil["email"],
                                nama_tiang             =satu_hasil["nama_tiang"],
                                jumlah_lantai          =satu_hasil["jumlah_lantai"],
                                id_ref_status          =status_nama[satu_hasil["id_ref_status"]],
                                keterangan             =satu_hasil["keterangan"],
                                waktu_pemasangan       =satu_hasil["waktu_pemasangan"],
                                list_lantai            =satu_hasil["list_lantai"],
                                list_aktuator          =satu_hasil["list_aktuator"],
                                jumlah_aktuator        =satu_hasil["jumlah_aktuator"],
                                list_sensortiang       =satu_hasil["list_sensortiang"],
                                jumlah_sensortiang     =satu_hasil["jumlah_sensortiang"],
                                list_sensor_suhu       =satu_hasil["list_sensor_suhu"],
                                jumlah_sensor_suhu     =satu_hasil["jumlah_sensor_suhu"],
                                list_sensor_keludara   =satu_hasil["list_sensor_keludara"],
                                jumlah_sensor_keludara =satu_hasil["jumlah_sensor_keludara"])
            if(satu_tiang.waktu_pemasangan != ""):
                satu_tiang.waktu_pemasangan = datetime.datetime.fromtimestamp(float(satu_tiang.waktu_pemasangan)).strftime('%d-%m-%y %H:%M')
            
            # append atau add elemen ke list
            daftar_tiang.append(satu_tiang)

        # Kembalikan list object tiang
        return daftar_tiang


def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_tiang = client.key(TIANG_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_tiang)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada tiang dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, tiang_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_tiang = client.key(TIANG_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_tiang)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada tiang dengan id: {id}.")

    # Simpan
    hasil.update(tiang_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Tiang(id                         =id,
                email                       =hasil["email"],
                nama_tiang                  =hasil["nama_tiang"],
                jumlah_lantai               =hasil["jumlah_lantai"],
                id_ref_status               =hasil["id_ref_status"],
                keterangan                  =hasil["keterangan"],
                waktu_pemasangan            =hasil["waktu_pemasangan"],
                list_lantai                 =hasil["list_lantai"],
                list_aktuator               =hasil["list_aktuator"],
                jumlah_aktuator             =hasil["jumlah_aktuator"],
                list_sensortiang            =hasil["list_sensortiang"],
                jumlah_sensortiang          =hasil["jumlah_sensortiang"],
                list_sensor_suhu            =hasil["list_sensor_suhu"],
                jumlah_sensor_suhu          =hasil["jumlah_sensor_suhu"],
                list_sensor_keludara        =hasil["list_sensor_keludara"],
                jumlah_sensor_keludara      =hasil["jumlah_sensor_keludara"]
                )

def cari(id):
    if id is not None:
        """ Mencari satu tiang berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_tiang = client.key(TIANG_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_tiang)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {id}.")
        # buat list
        data_tiang = []
        # buat objek tiang
        tiang = Tiang(  id                          =hasil.id,
                        email                       =hasil["email"],
                        nama_tiang                  =hasil["nama_tiang"],
                        jumlah_lantai               =hasil["jumlah_lantai"],
                        id_ref_status               =hasil["id_ref_status"],
                        keterangan                  =hasil["keterangan"],
                        waktu_pemasangan            =hasil["waktu_pemasangan"],
                        list_lantai                 =hasil["list_lantai"],
                        list_aktuator               =hasil["list_aktuator"],
                        jumlah_aktuator             =hasil["jumlah_aktuator"],
                        list_sensortiang            =hasil["list_sensortiang"],
                        jumlah_sensortiang          =hasil["jumlah_sensortiang"],
                        list_sensor_suhu            =hasil["list_sensor_suhu"],
                        jumlah_sensor_suhu          =hasil["jumlah_sensor_suhu"],
                        list_sensor_keludara        =hasil["list_sensor_keludara"],
                        jumlah_sensor_keludara      =hasil["jumlah_sensor_keludara"])
                        
        # ubah format data ke dictionary dan append ke list
        data_tiang.append(tiang.ke_dictionary())
        return data_tiang

def cari_email(email):
    if email is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=TIANG_KIND)
        query.add_filter('email', '=', email)
        query.order = ['email']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_tiang = []
        for satu_hasil_entity in hasil:
            satu_hasil = Tiang(
                                id                          =satu_hasil_entity.id,
                                email                       =satu_hasil_entity["email"],
                                nama_tiang                  =satu_hasil_entity["nama_tiang"],
                                jumlah_lantai               =satu_hasil_entity["jumlah_lantai"],
                                id_ref_status               =satu_hasil_entity["id_ref_status"],
                                keterangan                  =satu_hasil_entity["keterangan"],
                                waktu_pemasangan            =satu_hasil_entity["waktu_pemasangan"],
                                list_lantai                 =satu_hasil_entity["list_lantai"],
                                list_aktuator               =satu_hasil_entity["list_aktuator"],
                                jumlah_aktuator             =satu_hasil_entity["jumlah_aktuator"],
                                list_sensortiang            =satu_hasil_entity["list_sensortiang"],
                                jumlah_sensortiang          =satu_hasil_entity["jumlah_sensortiang"],
                                list_sensor_suhu            =satu_hasil_entity["list_sensor_suhu"],
                                jumlah_sensor_suhu          =satu_hasil_entity["jumlah_sensor_suhu"],
                                list_sensor_keludara        =satu_hasil_entity["list_sensor_keludara"],
                                jumlah_sensor_keludara      =satu_hasil_entity["jumlah_sensor_keludara"])
            # append atau add elemen ke list
            data_tiang.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_tiang

def cari_nama_tiang(nama_tiang):
    if nama_tiang is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=TIANG_KIND)
        query.add_filter('nama_tiang', '=', nama_tiang)
        query.order = ['nama_tiang']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_tiang = []
        for satu_hasil_entity in hasil:
            satu_hasil = Tiang(
                                id                          =satu_hasil_entity.id,
                                email                       =satu_hasil_entity.id,
                                nama_tiang                  =satu_hasil_entity["nama_tiang"],
                                jumlah_lantai               =satu_hasil_entity["jumlah_lantai"],
                                id_ref_status               =satu_hasil_entity["id_ref_status"],
                                keterangan                  =satu_hasil_entity["keterangan"],
                                waktu_pemasangan            =satu_hasil_entity["waktu_pemasangan"],
                                list_lantai                 =satu_hasil_entity["list_lantai"],
                                list_aktuator               =satu_hasil_entity["list_aktuator"],
                                jumlah_aktuator             =satu_hasil_entity["jumlah_aktuator"],
                                list_sensortiang            =satu_hasil_entity["list_sensortiang"],
                                jumlah_sensortiang          =satu_hasil_entity["jumlah_sensortiang"],
                                list_sensor_suhu            =satu_hasil_entity["list_sensor_suhu"],
                                jumlah_sensor_suhu          =satu_hasil_entity["jumlah_sensor_suhu"],
                                list_sensor_keludara        =satu_hasil_entity["list_sensor_keludara"],
                                jumlah_sensor_keludara      =satu_hasil_entity["jumlah_sensor_keludara"])
            # append atau add elemen ke list
            data_tiang.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_tiang


# untuk update data tiang saat data lantai baru ditambah
def update(id, data):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data tiang berdasar property id
    key = client.key(TIANG_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {id}.")
    
    # Simpan
    hasil.update(data)
    client.put(hasil)
    # kembalikan data pengaduan
    return Tiang(id=id)

