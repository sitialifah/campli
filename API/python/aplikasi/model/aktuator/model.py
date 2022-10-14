"""
Model Untuk Kind Aktuator

Property aktuator:
+ id :	INTEGER
+ id_ref_status : int
+ id_ref_aktuator :	string
+ id_tiang : int
+ nama_pengenal_aktuator : string
+ list_konfigurasi : array
"""

# Konstanta kind sensor, konstanta ini dipakai agar nama kind untuk sensor seragam
AKTUATOR_KIND = "aktuator"

class Aktuator:
    def __init__(self,
                    id=None, 
                    id_ref_status=None, 
                    id_ref_aktuator=None, 
                    id_tiang=None,
                    nama_pengenal_aktuator=None,
                    jenis_aktuator=None,
                    jumlah_konfigurasi=None,
                    list_konfigurasi=None):
        self.id = id
        self.id_ref_status = id_ref_status
        self.id_ref_aktuator = id_ref_aktuator
        self.id_tiang = id_tiang
        self.nama_pengenal_aktuator = nama_pengenal_aktuator
        self.jenis_aktuator = jenis_aktuator
        self.jumlah_konfigurasi = jumlah_konfigurasi
        self.list_konfigurasi=list_konfigurasi

    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika id_ref_status None jadikan 0
        if self.id_ref_status == None:
            hasil["id_ref_status"] = 0
        else: 
            hasil["id_ref_status"] = self.id_ref_status
        
        #Jika id_ref_aktuator tidak ada jadikan 0
        if self.id_ref_aktuator == None:
            hasil["id_ref_aktuator"] = 0
        else: 
            hasil["id_ref_aktuator"] = self.id_ref_aktuator

        # Jika id_tiang None jadikan 0
        if self.id_tiang == None:
            hasil["id_tiang"] = 0
        else:
            hasil["id_tiang"] = self.id_tiang

        # Jika id_tiang None jadikan tidak ada informasi
        if self.nama_pengenal_aktuator == None:
            hasil["nama_pengenal_aktuator"] = "TIDAK ADA INFORMASI"
        else:
            hasil["nama_pengenal_aktuator"] = self.nama_pengenal_aktuator
        
        # Jika id_tiang None jadikan tidak ada informasi
        if self.jenis_aktuator == None:
            hasil["jenis_aktuator"] = "TIDAK ADA INFORMASI"
        else:
            hasil["jenis_aktuator"] = self.jenis_aktuator
        
        # Jika jumlah_konfigurasi None jadikan tidak ada informasi
        if self.jumlah_konfigurasi == None:
            hasil["jumlah_konfigurasi"] = "TIDAK ADA INFORMASI"
        else:
            hasil["jumlah_konfigurasi"] = self.jumlah_konfigurasi
            
        # Jika id_tiang None jadikan tidak ada informasi
        if self.list_konfigurasi == None:
            hasil["list_konfigurasi"] = "TIDAK ADA INFORMASI"
        else:
            hasil["list_konfigurasi"] = self.list_konfigurasi

        return hasil
