from google.cloud import datastore
from aplikasi import model
from aplikasi import app
from .model import BACAAN_POT_KIND, Bacaan_Pot

from aplikasi.model.exception import EntityNotFoundException

import datetime

# Tambah Bacaan_Pot
#
# Tambah object Bacaan_Pot ke datastore.
def tambah(id_pot, lantai, kapan, nilai, kondisi):

    # Jika kapan masih string ubah ke datetime

    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if id_pot and lantai and kapan and  nilai and kondisi is not  None:
        # Buat object baru
        
        bacaan_pot_baru = Bacaan_Pot(       id_pot=id_pot,
                                            lantai=lantai,
                                            kapan=kapan, 
                                            nilai=nilai,
                                            kondisi=kondisi,
                                            jenis="Kelembaban Tanah")

        bacaan_pot_baru.kapan = datetime.datetime.timestamp(datetime.datetime.strptime(bacaan_pot_baru.kapan, '%Y-%m-%dT%H:%M'))

        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(BACAAN_POT_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Bacaan_Pot ke entity baru
        entity_baru.update(bacaan_pot_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Bacaan_Pot yang baru disimpan dengan id yang diberikan
        return Bacaan_Pot(id=entity_baru.id, 
                    id_pot=entity_baru["id_pot"], 
                    lantai=entity_baru["lantai"], 
                    kapan=entity_baru["kapan"],
                    nilai=entity_baru["nilai"],
                    kondisi=entity_baru["kondisi"],
                    jenis=entity_baru["jenis"])

def cari(id):
    if id is not None:
        """ Mencari satu bacaan_pot berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_bacaan_pot = client.key(BACAAN_POT_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_bacaan_pot)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada bacaan pot  dengan id: {id}.")
        # buat list
        data_bacaan_pot = []
        # buat objek bacaan pot
        bacaan_pot = Bacaan_Pot(        id=id,
                                        id_pot=hasil["id_pot"],
                                        lantai=hasil["lantai"],
                                        kapan=hasil["kapan"],
                                        nilai=hasil["nilai"],
                                        kondisi=hasil["kondisi"],
                                        jenis=hasil["jenis"])
        # ubah format data ke dictionary dan append ke list
        data_bacaan_pot.append(bacaan_pot.ke_dictionary())
        return data_bacaan_pot

def cari_id_pot(id_pot):
    if id_pot is not None:
        """ Mencari satu bacaan_pot berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=BACAAN_POT_KIND)
        query.add_filter('id_pot', '=', id_pot)
        query.order = ["id_pot"]
        hasil = query.fetch()
    
        data_bacaan_pot = []
        pot = model.pot.atur.daftar()
        pot_nama = {}
        for data in pot:
            pot_nama[str(data.id)] = data.nama_pot
            
        for satu_hasil_entity in hasil:
            satu_hasil = Bacaan_Pot(        id=satu_hasil_entity.id,
                                            id_pot=pot_nama[satu_hasil_entity["id_pot"]],
                                            lantai=satu_hasil_entity["lantai"],
                                            kapan=satu_hasil_entity["kapan"],
                                            nilai=satu_hasil_entity["nilai"],
                                            kondisi=satu_hasil_entity["kondisi"],
                                            jenis=satu_hasil_entity["jenis"])
            # ubah format data ke dictionary dan append ke list
            data_bacaan_pot.append(satu_hasil.ke_dictionary())
        return data_bacaan_pot

def cari_interval(awal, akhir):
    """ Mencari semua bacaan pot dalam range yang diberikan, inklusif. """

    # Ubah dari string ke datetime
    if isinstance(awal, str):
        awal = datetime.fromisoformat(awal)
    if isinstance(akhir, str):
        akhir = datetime.fromisoformat(akhir)

    # Buka koneksi ke datastore
    client = datastore.Client()

    # Bangun query nya
    query = client.query(kind=BACAAN_POT_KIND)
    query.add_filter('kapan', '>=', awal)
    query.add_filter('kapan', '<=', akhir)
    query.order = ['kapan', 'id_sensor']    
    
    # Jalankan query
    hasil_entity = query.fetch()

    # Ubah entitas ke class
    hasil = []
    for satu_hasil_entity in hasil_entity:
        satu_hasil = Bacaan_Pot( id=satu_hasil_entity.id, 
                                    id_pot=satu_hasil_entity["id_pot"],
                                    lantai=satu_hasil_entity["lantai"],
                                    kapan=satu_hasil_entity["kapan"],
                                    nilai=satu_hasil_entity["nilai"],
                                    kondisi=satu_hasil_entity["kondisi"],
                                    jenis=satu_hasil_entity["jenis"])
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
    query = client.query(kind=BACAAN_POT_KIND)
    query.add_filter('kapan', '>=', awal)
    query.add_filter('kapan', '<=', akhir)
    query.add_filter('id_sensor', '=', id_sensor)
    query.order = ['kapan', 'id_sensor']    
    
    # Jalankan query
    hasil_entity = query.fetch()

    # Ubah entitas ke class
    hasil = []
    for satu_hasil_entity in hasil_entity:
        satu_hasil = Bacaan_Pot( id=satu_hasil_entity.id, 
                                    id_pot=satu_hasil_entity["id_pot"],
                                    lantai=satu_hasil_entity["lantai"],
                                    kapan=satu_hasil_entity["kapan"],
                                    nilai=satu_hasil_entity["nilai"],
                                    kondisi=satu_hasil_entity["kondisi"],
                                    jenis=satu_hasil_entity["jenis"])
        hasil.append(satu_hasil)

    # Kembalikan hasil
    return hasil


# Ambil daftar Bacaan_Pot
#
# Ambil semua entity Bacaan_Pot yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind bacaan_pot
    query = client.query(kind=BACAAN_POT_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Bacaan_Pot.
    daftar_bacaan_pot = []

    # mau tarik data nama_pengenal_sensor pada tabel sensor_pot berdasarkan id yang dikirim
    bacaanpot = model.pot.atur.daftar()
    bacaanpot_namapot = {}
    for data in bacaanpot:
        bacaanpot_namapot[str(data.id)] = data.nama_pot

    # BUAT SATUAN BERDASARKAN REF SENSOR

    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_bacaan_pot = Bacaan_Pot(id=satu_hasil.id,
                            id_pot=bacaanpot_namapot[satu_hasil["id_pot"]],
                            lantai=satu_hasil["lantai"],
                            kapan=satu_hasil["kapan"],
                            nilai=satu_hasil["nilai"],
                            kondisi=satu_hasil["kondisi"],
                            jenis=satu_hasil["jenis"])

        if(satu_bacaan_pot.kapan != ""):
            satu_bacaan_pot.kapan = datetime.datetime.fromtimestamp(float(satu_bacaan_pot.kapan)).strftime('%Y-%m-%dT%H:%M')
            
        # append atau add elemen ke list
        daftar_bacaan_pot.append(satu_bacaan_pot)

    # Kembalikan list object bacaan_pot
    return daftar_bacaan_pot

def daftar_pot():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind bacaan_pot
    query = client.query(kind=BACAAN_POT_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Bacaan_Pot.
    daftar_bacaan_pot = []

    # mau tarik data nama_pengenal_sensor pada tabel sensor_pot berdasarkan id yang dikirim
    bacaanpot = model.pot.atur.daftar()
    bacaanpot_namapot = {}
    for data in bacaanpot:
        bacaanpot_namapot[str(data.id)] = data.nama_pot

    # BUAT SATUAN BERDASARKAN REF SENSOR

    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_bacaan_pot = Bacaan_Pot(id=satu_hasil.id,
                            id_pot=bacaanpot_namapot[satu_hasil["id_pot"]],
                            lantai=satu_hasil["lantai"],
                            kapan=satu_hasil["kapan"],
                            nilai=satu_hasil["nilai"],
                            kondisi=satu_hasil["kondisi"],
                            jenis=satu_hasil["jenis"],
                            )

        if(satu_bacaan_pot.kapan != ""):
            satu_bacaan_pot.kapan = datetime.datetime.fromtimestamp(float(satu_bacaan_pot.kapan)).strftime('%Y-%m-%dT%H:%M')
            
        # append atau add elemen ke list
        daftar_bacaan_pot.append(satu_bacaan_pot)

    daftar_bacaan = []
    for satu_hasil in daftar_bacaan_pot:
        daftar_bacaan_pot.append(satu_hasil)

    # Kembalikan list object bacaan_pot
    return daftar_bacaan

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_bacaan_pot = client.key(BACAAN_POT_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_bacaan_pot)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada bacaan dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

