"""
Model Untuk Kind Sensor_Suhu

Property sensor_suhu:
+ id :	INTEGER
+ id_ref_status : int
+ id_ref_sensor :	string
+ id_tiang : int
+ nama_pengenal_sensor : string
"""

# Konstanta kind sensor, konstanta ini dipakai agar nama kind untuk sensor seragam
SENSOR_SUHU_KIND = "sensor_suhu"

class Sensor_Suhu:
    def __init__(self,
                    id=None, 
                    status="TIDAK ADA INFORMASI", 
                    jenis="TIDAK ADA INFORMASI", 
                    id_tiang=None,
                    nama_pengenal_sensor=None,
                    list_bacaansuhu="TIDAK ADA INFORMASI",
                    jumlah_bacaansuhu="TIDAK ADA INFORMASI"):
        self.id = id
        self.status = status
        self.jenis = jenis
        self.id_tiang = id_tiang
        self.nama_pengenal_sensor = nama_pengenal_sensor
        self.list_bacaansuhu = list_bacaansuhu
        self.jumlah_bacaansuhu = jumlah_bacaansuhu

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

        # Jika list_bacaansuhu None jadikan tidak ada informasi
        if self.list_bacaansuhu == None:
            hasil["list_bacaansuhu"] = "TIDAK ADA INFORMASI"
        else:
            hasil["list_bacaansuhu"] = self.list_bacaansuhu
        
        # Jika jumlah_bacaansuhu None jadikan tidak ada informasi
        if self.jumlah_bacaansuhu == None:
            hasil["jumlah_bacaansuhu"] = "TIDAK ADA INFORMASI"
        else:
            hasil["jumlah_bacaansuhu"] = self.jumlah_bacaansuhu

        return hasil
