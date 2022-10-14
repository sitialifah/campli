from google.cloud import datastore
from aplikasi import app, model
from .model import POT_KIND, Pot
from aplikasi.model.exception import EntityNotFoundException, EntityIdException
# from model.pot import Pot

# Tambah Pot
#
# Tambah object Pot ke datastore.
def tambah(nama_pot, keterangan, id_lantai, id_tiang):
    # Pastikan ada pot 
    # pot = model.pot.cari(id_lantai)
    # # tambah operator
    #  
    # Buat object hanya jika ketiga data ada
    # cek parameter agar tidak kosong
    if nama_pot and keterangan and id_lantai and id_tiang is not None:
        # Buat object baru
        pot_baru = Pot( nama_pot        =nama_pot,
                        keterangan      =keterangan, 
                        id_lantai       =id_lantai,
                        id_tiang        =id_tiang,
                        jumlah_bacaanpot=0,
                        list_bacaanpot  =[],
                        jenis           ="Kelembaban Tanah",
                        status          ="Aktif")
        # Sambung ke datastore
        client = datastore.Client()
        # Minta dibuatkan Key/Id baru untuk object baru
        key_baru = client.key(POT_KIND)
        # Minta dibuatkan entity di datastore memakai key baru
        entity_baru = datastore.Entity(key=key_baru)
        # Simpan object Pot ke entity baru
        entity_baru.update(pot_baru.ke_dictionary())
        # Simpan entity ke datastore
        client.put(entity_baru)

        # Kembalikan object Pot yang baru disimpan dengan id yang diberikan
        return Pot(id               =entity_baru.id, 
                    nama_pot        =entity_baru["nama_pot"], 
                    keterangan      =entity_baru["keterangan"],
                    id_lantai       =entity_baru["id_lantai"],
                    id_tiang        =entity_baru["id_tiang"],
                    jumlah_bacaanpot=entity_baru["jumlah_bacaanpot"],
                    list_bacaanpot  =entity_baru["list_bacaanpot"],
                    jenis           =entity_baru["jenis"], 
                    status          =entity_baru["status"] 
                    )
        
# Ambil daftar Pot
#
# Ambil semua entity Pot yang ada di datastore.
def daftar():
    # Sambung ke datastore
    client = datastore.Client()

    # Buat query untuk meminta semua isi kind pot
    query = client.query(kind=POT_KIND)
    # Jalankan query
    hasil = query.fetch()

    # Ambil setiap entity yang dikembalikan query dan jadikan list dari
    # object Pot.
    daftar_pot = []
    # mau tarik data nama lantai pada tabel lantai berdasarkan id yang dikirim
    lantai = model.lantai.atur.daftar()
    lantai_nama = {}
    for data in lantai:
        lantai_nama[str(data.id)] = data.nama_lantai
    # mau tarik data nama tiang pada tabel tiang berdasarkan id yang dikirim
    tiang = model.tiang.atur.daftar()
    tiang_nama = {}
    for data in tiang:
        tiang_nama[str(data.id)] = data.nama_tiang
    # iterate data operator, simpan ke list
    for satu_hasil in hasil:
        satu_pot = Pot(     id                  =satu_hasil.id,
                            nama_pot            =satu_hasil["nama_pot"],
                            keterangan          =satu_hasil["keterangan"],
                            id_lantai           =lantai_nama[satu_hasil["id_lantai"]],
                            id_tiang            =tiang_nama[satu_hasil["id_tiang"]],
                            jumlah_bacaanpot    =satu_hasil["jumlah_bacaanpot"],
                            list_bacaanpot      =satu_hasil["list_bacaanpot"],
                            jenis               =satu_hasil["jenis"], 
                            status              =satu_hasil["status"])
        # append atau add elemen ke list
        daftar_pot.append(satu_pot)

    # Kembalikan list object pot
    return daftar_pot

def hapus(id):
    # Hapus data dari datastore
    
    # Buka koneksi ke datastore
    client = datastore.Client()

    # Buat query baru khusus untuk operator
    key_pot = client.key(POT_KIND, id)
    # Jalankan query, hasilnya berupa iterator
    hasil = client.get(key_pot)

    # Cek apakah id ditemukan
    if hasil is None:
        # Jika tidak ditemukan tampilkan exception
        raise EntityNotFoundException(f"Tidak ada pot dengan id: {id}.")
    else:
        # Jika ditemukan hapus entitas
        client.delete(hasil.key)
    # Kembalikan kode 200
    return 200

def ubah(id, pot_ubah):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data operator berdasar property id
    key_pot = client.key(POT_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key_pot)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada pot dengan id: {id}.")

    # Simpan
    hasil.update(pot_ubah.ke_dictionary())
    client.put(hasil)
    # kembalikan data operator
    return Pot(id=id,
                nama_pot        =hasil["nama_pot"],
                keterangan      =hasil["keterangan"],
                id_lantai       =hasil["id_lantai"],
                id_tiang        =hasil["id_tiang"],
                jumlah_bacaanpot=hasil["jumlah_bacaanpot"],
                list_bacaanpot  =hasil["list_bacaanpot"],
                jenis           =hasil["jenis"], 
                status          =hasil["status"])

def cari(id):
    if id is not None:
        """ Mencari satu pot berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        key_pot = client.key(POT_KIND, id)
        #  ambil hasil carinya
        hasil = client.get(key_pot)
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada pot  dengan id: {id}.")
        # buat list
        data_pot = []
        # buat objek operator
        pot = Pot(      id=id,
                        nama_pot        =hasil["nama_pot"],
                        keterangan      =hasil["keterangan"],
                        id_lantai       =hasil["id_lantai"],
                        id_tiang        =hasil["id_tiang"],
                        jumlah_bacaanpot=hasil["jumlah_bacaanpot"],
                        list_bacaanpot  =hasil["list_bacaanpot"],
                        jenis           =hasil["jenis"], 
                        status          =hasil["status"])
        # ubah format data ke dictionary dan append ke list
        data_pot.append(pot.ke_dictionary())
        return data_pot

# untuk halaman pot page by id lantai
def cari_by_lantai(lantai):
    if lantai is not None:
        """ Mencari satu lantai berdasarkan id-nya. """
        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=POT_KIND).add_filter("id_lantai", "=", str(lantai))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada lantai  dengan id: {lantai}.")
        # buat list
        data_pot = []

        for data in hasil:
            # buat objek operator
            pot = Pot(      id=data.id,
                            nama_pot        =data["nama_pot"],
                            keterangan      =data["keterangan"],
                            id_lantai       =data["id_lantai"],
                            id_tiang        =data["id_tiang"],
                            jumlah_bacaanpot=data["jumlah_bacaanpot"],
                            list_bacaanpot  =data["list_bacaanpot"],
                            jenis           =data["jenis"],
                            status          =data["status"])
            # ubah format data ke dictionary dan append ke list
            data_pot.append(pot.ke_dictionary())
        return data_pot

# cari pot dengan id lantai tertentu untuk halaman ping
def cari_by_lantaipingkelembabantanah(lantai):
    if lantai is not None:
        """ Mencari satu lantai berdasarkan id-nya. """

        # Buka koneksi ke datastore
        client = datastore.Client()

        # Cari
        query = client.query(kind=POT_KIND).add_filter("id_lantai", "=", str(lantai))
        #  ambil hasil carinya
        hasil = query.fetch()
        # jika tidak ditemukan, bangkitkan exception
        if hasil is None:
            raise EntityNotFoundException(f"Tidak ada lantai  dengan id: {lantai}.")
        # buat list
        data_pot = []

        for data in hasil:
            # buat objek operator
            pot = Pot(  id =data.id,
                        nama_pot                =data["nama_pot"],
                        status                  =data["status"],
                        jenis                   =data["jenis"],
                        id_lantai               =data["id_lantai"],
                        id_tiang                =data["id_tiang"],
                        keterangan              =data["keterangan"],
                        jumlah_bacaanpot        =data["jumlah_bacaanpot"],
                        # list_bacaanpot          =data["list_bacaanpot"]
                        )
            # ubah format data ke dictionary dan append ke list
            # res = aktuator.ke_dictionary()
            if (pot.jumlah_bacaanpot <24 and pot.status=="Aktif"):
                pot.status = "non aktif"
                # res["id_ref_status"] = aktuator.id_ref_status
            # if(aktuator.id_ref_status != "Aktif"):
            #     data_aktuator.append(res)
            data_pot.append(pot.ke_dictionary())
        return data_pot
        
        
def cari_id_lantai(id_lantai):
    if id_lantai is not None:
        client = datastore.Client()

        # buat query filter email
        query = client.query(kind=POT_KIND)
        query.add_filter('id_lantai', '=', id_lantai)
        query.order = ['id_lantai']
        # ambil hasil filter
        hasil = query.fetch()

        # ubah hasil ke format yang kita butuhkan
        data_pot = []
        for satu_hasil_entity in hasil:
            satu_hasil = Pot(
                                id              =satu_hasil_entity.id,
                                id_tiang        =satu_hasil_entity["id_tiang"],
                                nama_pot        =satu_hasil_entity["nama_pot"],
                                keterangan      =satu_hasil_entity["keterangan"],
                                id_lantai       =satu_hasil_entity["id_lantai"],
                                jumlah_bacaanpot=satu_hasil_entity["jumlah_bacaanpot"],
                                list_bacaanpot  =satu_hasil_entity["list_bacaanpot"],
                                jenis           =satu_hasil_entity["jenis"], 
                                status          =satu_hasil_entity["status"])
            # append atau add elemen ke list
            data_pot.append(satu_hasil.ke_dictionary())
        # kembalikan list 
        return data_pot

# update data pot
def update(id, data):

    # Buka koneksi ke datastore
    client = datastore.Client()

    # cari/filter data tiang berdasar property id
    key = client.key(POT_KIND, id)
    #  ambil hasil carinya
    hasil = client.get(key)
    # jika tidak ditemukan, bangkitkan exception
    if hasil is None:
        raise EntityNotFoundException(f"Tidak ada POT  dengan id: {id}.")
    
    # Simpan
    hasil.update(data)
    client.put(hasil)
    # kembalikan data pengaduan
    return Pot(id=id)

