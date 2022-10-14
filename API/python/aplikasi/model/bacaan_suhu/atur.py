from google.cloud import datastore
from aplikasi import model
from aplikasi import app
from .model import BACAAN_SUHU_KIND, Bacaan_Suhu

from aplikasi.model.exception import EntityNotFoundException

import datetime

import aplikasi.model.sensor_suhu

# Tambah Bacaan_Suhu
#
# Tambah object Bacaan_Suhu ke datastore.
def tambah(tiang, id_sensor, kapan, nilai):

    # Jika kapan masih string ubah ke datetime

    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if tiang and id_sensor  and kapan and  nilai  is not  None:
        # Buat object baru
    
        bacaan_suhu_baru = Bacaan_Suhu( tiang       =tiang,
                                                                id_sensor   =id_sensor,
                                                                jenis       ="Suhu",
                                                                kapan       =kapan, 
                                                                nilai       =nilai)

        # bacaan_suhu_baru.kapan = datetime.strptime(bacaan_suhu_baru.kapan, '%Y-%m-%dT%H:%M')
        # bacaan_suhu_baru.kapan = datetime.datetime.fromtimestamp(float(bacaan_suhu_baru.kapan)).strftime('%Y-%m-%dT%H:%M')
        bacaan_suhu_baru.kapan = datetime.datetime.timestamp(datetime.datetime.strptime(bacaan_suhu_baru.kapan, '%Y-%m-%dT%H:%M'))

        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(BACAAN_SUHU_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Bacaan_Suhu ke entity baru
        entity_baru.update(bacaan_suhu_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Bacaan_Suhu yang baru disimpan dengan id yang diberikan
        return Bacaan_Suhu( id          =entity_baru.id, 
                            tiang       =entity_baru["tiang"], 
                            id_sensor   =entity_baru["id_sensor"], 
                            jenis       =entity_baru["jenis"],
                            kapan       =entity_baru["kapan"],
                            nilai       =entity_baru["nilai"])

def cari(id):
    if id is not None:
        """ Mencari satu bacaan_suhu berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_bacaan_suhu = client.key(BACAAN_SUHU_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_bacaan_suhu)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada bacaan suhu  dengan id: {id}.")
        # buat list
        data_bacaan_suhu = []
        # buat objek bacaan suhu
        bacaan_suhu = Bacaan_Suhu(  id          =id,
                                    tiang       =hasil["tiang"],
                                    jenis       =hasil["jenis"],
                                    id_sensor   =hasil["id_sensor"],
                                    kapan       =hasil["kapan"],
                                    nilai       =hasil["nilai"])
        # ubah format data ke dictionary dan append ke list
        data_bacaan_suhu.append(bacaan_suhu.ke_dictionary())
        return data_bacaan_suhu

def cari_interval(awal, akhir):
    """ Mencari semua bacaan suhu dalam range yang diberikan, inklusif. """

    # Ubah dari string ke datetime
    if isinstance(awal, str):
        awal = datetime.fromisoformat(awal)
    if isinstance(akhir, str):
        akhir = datetime.fromisoformat(akhir)

    # Buka koneksi ke datastore
    client = datastore.Client()

    # Bangun query nya
    query = client.query(kind=BACAAN_SUHU_KIND)
    query.add_filter('kapan', '>=', awal)
    query.add_filter('kapan', '<=', akhir)
    query.order = ['kapan', 'id_sensor']    
    
    # Jalankan query
    hasil_entity = query.fetch()

    # Ubah entitas ke class
    hasil = []
    for satu_hasil_entity in hasil_entity:
        satu_hasil = Bacaan_Suhu(   id          =satu_hasil_entity.id, 
                                    tiang       =satu_hasil_entity["tiang"],
                                    jenis       =satu_hasil_entity["jenis"],
                                    id_sensor   =satu_hasil_entity["id_sensor"],
                                    kapan       =satu_hasil_entity["kapan"],
                                    nilai       =satu_hasil_entity["nilai"])
        hasil.append(satu_hasil)

    # Kembalikan hasil
    return hasil

def cari_interval_sensor(awal, akhir, id_sensor):
    """ 
    Mencari semua bacaan dalam range yang diberikan, inklusif, untuk senor 
    tertentu. 
    """

    # Pastikan sensor ada
    sensor_cari = sensor.cari(id_sensor)

    # Ubah dari string ke datetime
    if isinstance(awal, str):
        awal = datetime.fromisoformat(awal)
    if isinstance(akhir, str):
        akhir = datetime.fromisoformat(akhir)

    # Buka koneksi ke datastore
    client = datastore.Client()

    # Bangun query nya
    query = client.query(kind=BACAAN_SUHU_KIND)
    query.add_filter('kapan', '>=', awal)
    query.add_filter('kapan', '<=', akhir)
    query.add_filter('id_sensor', '=', id_sensor)
    query.order = ['kapan', 'id_sensor']    
    
    # Jalankan query
    hasil_entity = query.fetch()

    # Ubah entitas ke class
    hasil = []
    for satu_hasil_entity in hasil_entity:
        satu_hasil = Bacaan_Suhu(   id          =satu_hasil_entity.id, 
                                    tiang       =satu_hasil_entity["tiang"],
                                    jenis       =satu_hasil_entity["jenis"],
                                    id_sensor   =satu_hasil_entity["id_sensor"],
                                    kapan       =satu_hasil_entity["kapan"],
                                    nilai       =satu_hasil_entity["nilai"])
        hasil.append(satu_hasil)

    # Kembalikan hasil
    return hasil


# Ambil daftar Bacaan_Suhu
#
# Ambil semua entity Bacaan_Suhu yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()
    # Buat query untuk meminta semua isi kind bacaan_suhu
    query = client.query(kind=BACAAN_SUHU_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Bacaan_Suhu.
    daftar_bacaan_suhu = []

    # mau tarik data nama_pengenal_sensor pada tabel sensor_suhu berdasarkan id yang dikirim
    bacaansuhu = model.sensor_suhu.atur.daftar()
    bacaansuhu_namapengenal = {}
    for data in bacaansuhu:
        bacaansuhu_namapengenal[str(data.id)] = data.nama_pengenal_sensor

    # BUAT SATUAN BERDASARKAN REF SENSOR

    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_bacaan_suhu = Bacaan_Suhu( id          =satu_hasil.id,
                                        tiang       =satu_hasil["tiang"],
                                        jenis       =satu_hasil["jenis"],
                                        id_sensor   =bacaansuhu_namapengenal[satu_hasil["id_sensor"]],
                                        kapan       =satu_hasil["kapan"],
                                        nilai       =satu_hasil["nilai"])

        if(satu_bacaan_suhu.kapan != ""):
            satu_bacaan_suhu.kapan = datetime.datetime.fromtimestamp(float(satu_bacaan_suhu.kapan)).strftime('%Y-%m-%dT%H:%M')
            
        # append atau add elemen ke list
        daftar_bacaan_suhu.append(satu_bacaan_suhu)

    # Kembalikan list object bacaan_suhu
    return daftar_bacaan_suhu

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_bacaan_suhu = client.key(BACAAN_SUHU_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_bacaan_suhu)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada bacaan dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def cari_id_sensor(id_sensor):
    if id_sensor is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=BACAAN_SUHU_KIND)
        query.add_filter('id_sensor', '=', id_sensor)
        query.order = ['id_sensor']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_bacaan_suhu = []
        for satu_hasil_entity in hasil:
            satu_hasil = Bacaan_Suhu(   id          =satu_hasil_entity.id,
                                        tiang       =satu_hasil_entity["tiang"],
                                        jenis       =satu_hasil_entity["jenis"],
                                        id_sensor   =satu_hasil_entity["id_sensor"],
                                        kapan       =satu_hasil_entity["kapan"],
                                        nilai       =satu_hasil_entity["nilai"])
            data_bacaan_suhu.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_bacaan_suhu