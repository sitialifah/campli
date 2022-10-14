from google.cloud import datastore
from aplikasi import model
from aplikasi import app
from aplikasi.model.exception import EntityNotFoundException
from aplikasi.model.exception import EntityIdException

from .model import SENSOR_KELEMBABAN_UDARA_KIND, Sensor_Kelembaban_Udara


# Tambah Sensor_Kelembaban_Udara
#
# Tambah object Sensor_Kelembaban_Udara ke datastore.
def tambah(id_tiang, nama_pengenal_sensor):
    # Pastikan ada Sensor_Kelembaban_Udara 
    # # tambah operator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if id_tiang != None and nama_pengenal_sensor!=None:
        # Buat object baru
        sensor_kelembaban_udara_baru = Sensor_Kelembaban_Udara(
                                            jenis                   ="Kelembaban Udara",
                                            status                  ="Aktif", 
                                            id_tiang                =id_tiang,
                                            nama_pengenal_sensor    =nama_pengenal_sensor,
                                            list_bacaankeludara     =[],
                                            jumlah_bacaankeludara   =0
                                            )

        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(SENSOR_KELEMBABAN_UDARA_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Pot ke entity baru
        entity_baru.update(sensor_kelembaban_udara_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Sensor_Kelembaban_Udara yang baru disimpan dengan id yang diberikan
        return Sensor_Kelembaban_Udara(
                                id                      =entity_baru.id, 
                                status                  =entity_baru["status"], 
                                jenis                   =entity_baru["jenis"], 
                                id_tiang                =entity_baru["id_tiang"],
                                nama_pengenal_sensor    =entity_baru["nama_pengenal_sensor"],
                                list_bacaankeludara     =entity_baru["list_bacaankeludara"],
                                jumlah_bacaankeludara   =entity_baru["jumlah_bacaankeludara"]
                                )

        
# Ambil daftar sensor_kelembaban_udara
#
# Ambil semua entity sensor_kelembaban_udara yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind sensor_kelembaban_udara
    query = client.query(kind=SENSOR_KELEMBABAN_UDARA_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Pot.
    daftar_sensor_kelembaban_udara = []
    
    # mau tarik data nama tiang pada tabel tiang berdasarkan id yang dikirim
    tiang = model.tiang.atur.daftar()
    tiang_nama = {}
    for data in tiang:
        tiang_nama[str(data.id)] = data.nama_tiang
    # iterate data sensor_kelembaban_udara, simpan ke list
    for satu_hasil in hasil:
        satu_sensor_kelembaban_udara = Sensor_Kelembaban_Udara(
                                            id                      =satu_hasil.id,
                                            status                  =satu_hasil["status"],
                                            jenis                   =satu_hasil["jenis"],
                                            id_tiang                =tiang_nama[satu_hasil["id_tiang"]],
                                            nama_pengenal_sensor    =satu_hasil["nama_pengenal_sensor"],
                                            list_bacaankeludara     =satu_hasil["list_bacaankeludara"],
                                            jumlah_bacaankeludara   =satu_hasil["jumlah_bacaankeludara"]
                                            )
        # append atau add elemen ke list
        daftar_sensor_kelembaban_udara.append(satu_sensor_kelembaban_udara)

    # Kembalikan list object pot
    return daftar_sensor_kelembaban_udara


def cari(id):
    """ 
    Mencari satu sensor berdasarkan id-nya. 
    Throw
    + EntityNotFoundException: tidak ada sensor dengan id yang diberikan.
    """
    if id is not None:
        """ Mencari satu tiang berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_sensor_kelembaban_udara = client.key(SENSOR_KELEMBABAN_UDARA_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_sensor_kelembaban_udara)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada sensor_kelembaban_udara dengan id: {id}.")
        # buat list
        data_sensor_kelembaban_udara = []
        # buat objek operator
        sensor_kelembaban_udara = Sensor_Kelembaban_Udara(    
                                        id                      =hasil.id, 
                                        status                  =hasil["status"], 
                                        jenis                   =hasil["jenis"], 
                                        id_tiang                =hasil["id_tiang"],
                                        nama_pengenal_sensor    =hasil["nama_pengenal_sensor"],
                                        list_bacaankeludara     =hasil["list_bacaankeludara"],
                                        jumlah_bacaankeludara   =hasil["jumlah_bacaankeludara"])
        # ubah format data ke dictionary dan append ke list
        data_sensor_kelembaban_udara.append(sensor_kelembaban_udara.ke_dictionary())
        return data_sensor_kelembaban_udara

def cari_nama_pengenal_sensor(nama_pengenal_sensor):
    if nama_pengenal_sensor is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=SENSOR_KELEMBABAN_UDARA_KIND)
        query.add_filter('nama_pengenal_sensor', '=', nama_pengenal_sensor)
        query.order = ['nama_pengenal_sensor']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_sensor_kelembaban_udara = []
        for satu_hasil_entity in hasil:
            satu_hasil = Sensor_Kelembaban_Udara(
                                        id                          =satu_hasil_entity.id,
                                        status                      =satu_hasil_entity["status"],
                                        jenis                       =satu_hasil_entity["jenis"],
                                        id_tiang                    =satu_hasil_entity["id_tiang"],
                                        nama_pengenal_sensor        =satu_hasil_entity["nama_pengenal_sensor"],
                                        list_bacaankeludara         =satu_hasil_entity["list_bacaankeludara"],
                                        jumlah_bacaankeludara       =satu_hasil_entity["jumlah_bacaankeludara"])
            # append atau add elemen ke list
            data_sensor_kelembaban_udara.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_sensor_kelembaban_udara

def cari_id_tiang(id_tiang):
    if id_tiang is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=SENSOR_KELEMBABAN_UDARA_KIND)
        query.add_filter('id_tiang', '=', id_tiang)
        query.order = ['id_tiang']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_sensor_kelembaban_udara = []
        for satu_hasil_entity in hasil:
            satu_hasil = Sensor_Kelembaban_Udara(
                                        id                      =satu_hasil_entity.id,
                                        status                  =satu_hasil_entity["status"],
                                        jenis                   =satu_hasil_entity["jenis"],
                                        id_tiang                =satu_hasil_entity["id_tiang"],
                                        nama_pengenal_sensor    =satu_hasil_entity["nama_pengenal_sensor"],
                                        list_bacaankeludara     =satu_hasil_entity["list_bacaankeludara"],
                                        jumlah_bacaankeludara   =satu_hasil_entity["jumlah_bacaankeludara"]
                                        )
            # append atau add elemen ke list
            data_sensor_kelembaban_udara.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_sensor_kelembaban_udara


def cari_by_tiangpingkelembabanudara(tiang):
    if tiang is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=SENSOR_KELEMBABAN_UDARA_KIND).add_filter("id_tiang", "=", str(tiang))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada tiang  dengan id: {tiang}.")
        # buat list
        data_sensor_kelembaban_udara = []

        for data in hasil:
            # buat objek operator
            sensor_kelembaban_udara = Sensor_Kelembaban_Udara(  id                      =data.id,
                                                                status                  =data["status"],
                                                                jenis                   =data["jenis"],
                                                                id_tiang                =data["id_tiang"],
                                                                nama_pengenal_sensor    =data["nama_pengenal_sensor"],
                                                                list_bacaankeludara     =data["list_bacaankeludara"],
                                                                jumlah_bacaankeludara   =data["jumlah_bacaankeludara"]
                                                                )
            # ubah format data ke dictionary dan append ke list
            # res = aktuator.ke_dictionary()
            if (sensor_kelembaban_udara.jumlah_bacaankeludara <24 and sensor_kelembaban_udara.status=="Aktif"):
                sensor_kelembaban_udara.status = "non aktif"
                # res["id_ref_status"] = aktuator.id_ref_status
            # if(aktuator.id_ref_status != "Aktif"):
            #     data_aktuator.append(res)
            data_sensor_kelembaban_udara.append(sensor_kelembaban_udara.ke_dictionary())
        return data_sensor_kelembaban_udara
        

def update(id, data):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data tiang berdasar property id
    key = client.key(SENSOR_KELEMBABAN_UDARA_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada sensor_kelembaban_udara  dengan id: {id}.")
    
    # Simpan
    hasil.update(data)
    client.put(hasil)
    # kembalikan data pengaduan
    return Sensor_Kelembaban_Udara(id=id)


