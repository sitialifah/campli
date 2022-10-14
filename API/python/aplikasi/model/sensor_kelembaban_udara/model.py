"""
Model Untuk Kind Sensor_Kelembaban_Udara

Property sensor_kelembaban_udara:
+ id :	INTEGER
+ id_ref_status : int
+ id_ref_sensor :	string
+ id_tiang : int
+ nama_pengenal_sensor : string
"""

# Konstanta kind sensor, konstanta ini dipakai agar nama kind untuk sensor seragam
SENSOR_KELEMBABAN_UDARA_KIND = "sensor_kelembaban_udara"

class Sensor_Kelembaban_Udara:
    def __init__(self,
                    id=None, 
                    status="TIDAK ADA INFORMASI", 
                    jenis="TIDAK ADA INFORMASI", 
                    id_tiang=None,
                    nama_pengenal_sensor=None,
                    list_bacaankeludara="TIDAK ADA INFORMASI",
                    jumlah_bacaankeludara="TIDAK ADA INFORMASI"):
        self.id = id
        self.status = status
        self.jenis = jenis
        self.id_tiang = id_tiang
        self.nama_pengenal_sensor = nama_pengenal_sensor
        self.list_bacaankeludara = list_bacaankeludara
        self.jumlah_bacaankeludara = jumlah_bacaankeludara

    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika status None jadikan 0
        if self.status == None:
            hasil["status"] = 0
        else: 
            hasil["status"] = self.status
        
        #Jika jenis tidak ada jadikan 0
        if self.jenis == None:
            hasil["jenis"] = 0
        else: 
            hasil["jenis"] = self.jenis

        # Jika id_tiang None jadikan 0
        if self.id_tiang == None:
            hasil["id_tiang"] = 0
        else:
            hasil["id_tiang"] = self.id_tiang

        # Jika id_tiang None jadikan tidak ada informasi
        if self.nama_pengenal_sensor == None:
            hasil["nama_pengenal_sensor"] = "TIDAK ADA INFORMASI"
        else:
            hasil["nama_pengenal_sensor"] = self.nama_pengenal_sensor

        # Jika list_bacaankeludara None jadikan tidak ada informasi
        if self.list_bacaankeludara == None:
            hasil["list_bacaankeludara"] = "TIDAK ADA INFORMASI"
        else:
            hasil["list_bacaankeludara"] = self.list_bacaankeludara
        
        # Jika jumlah_bacaankeludara None jadikan tidak ada informasi
        if self.jumlah_bacaankeludara == None:
            hasil["jumlah_bacaankeludara"] = "TIDAK ADA INFORMASI"
        else:
            hasil["jumlah_bacaankeludara"] = self.jumlah_bacaankeludara

        return hasil
