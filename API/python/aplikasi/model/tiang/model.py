"""
Model Untuk Kind Tiang
"""

# Konstanta kind tiang, konstanta ini dipakai agar nama kind untuk tiang seragam
TIANG_KIND = "tiang"

class Tiang:
    def __init__(self, 
                id=None,
                email="TIDAK ADA INFORMASI",
                nama_tiang="TIDAK ADA INFORMASI", 
                jumlah_lantai="TIDAK ADA INFORMASI", 
                id_ref_status="TIDAK ADA INFORMASI",
                keterangan="TIDAK ADA INFORMASI",
                waktu_pemasangan="TIDAK ADA INFORMASI",
                list_lantai="TIDAK ADA INFORMASI",
                list_aktuator="TIDAK ADA INFORMASI",
                jumlah_aktuator="TIDAK ADA INFORMASI",
                list_sensortiang="TIDAK ADA INFORMASI",
                jumlah_sensortiang="TIDAK ADA INFORMASI",
                list_sensor_suhu="TIDAK ADA INFORMASI",
                jumlah_sensor_suhu="TIDAK ADA INFORMASI",
                list_sensor_keludara="TIDAK ADA INFORMASI",
                jumlah_sensor_keludara="TIDAK ADA INFORMASI") :
        self.id = id
        self.email = email
        self.nama_tiang = nama_tiang
        self.jumlah_lantai = jumlah_lantai
        self.id_ref_status = id_ref_status
        self.keterangan = keterangan
        self.waktu_pemasangan = waktu_pemasangan
        self.list_lantai = list_lantai
        self.list_aktuator = list_aktuator
        self.jumlah_aktuator = jumlah_aktuator
        self.list_sensortiang = list_sensortiang
        self.jumlah_sensortiang = jumlah_sensortiang
        self.list_sensor_suhu = list_sensor_suhu
        self.jumlah_sensor_suhu = jumlah_sensor_suhu
        self.list_sensor_keludara = list_sensor_keludara
        self.jumlah_sensor_keludara = jumlah_sensor_keludara

    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id
        
        if self.email != None:
            hasil["email"] = self.email

        # Jika nama tiang None jadikan "TIDAK ADA INFORMASI"
        if self.nama_tiang == None:
            hasil["nama_tiang"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["nama_tiang"] = self.nama_tiang
        
        #Jika jumlah lantai tidak ada jadikan 0
        if self.jumlah_lantai == None:
            hasil["jumlah_lantai"] = 0
        else: 
            hasil["jumlah_lantai"] = self.jumlah_lantai

        #Jika id_ref_status tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.id_ref_status == None:
            hasil["id_ref_status"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["id_ref_status"] = self.id_ref_status

        #Jika keterangan tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.keterangan == None:
            hasil["keterangan"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["keterangan"] = self.keterangan
        
        #Jika waktu_pemasangan tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.waktu_pemasangan == None:
            hasil["waktu_pemasangan"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["waktu_pemasangan"] = self.waktu_pemasangan

        #Jika daftar lantai tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_lantai == None:
            hasil["list_lantai"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_lantai"] = self.list_lantai
        
        #Jika list aktuator tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_aktuator == None:
            hasil["list_aktuator"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_aktuator"] = self.list_aktuator
        
        #Jika jumlah aktuator tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.jumlah_aktuator == None:
            hasil["jumlah_aktuator"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["jumlah_aktuator"] = self.jumlah_aktuator
        
        #Jika list sensor tiang tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_sensortiang == None:
            hasil["list_sensortiang"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_sensortiang"] = self.list_sensortiang
        
        #Jika jumlah sensor tiang tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.jumlah_sensortiang == None:
            hasil["jumlah_sensortiang"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["jumlah_sensortiang"] = self.jumlah_sensortiang

        #Jika list sensor suhu tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_sensortiang == None:
            hasil["list_sensor_suhu"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_sensor_suhu"] = self.list_sensor_suhu
        
        #Jika jumlah_sensor_suhu tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.jumlah_sensortiang == None:
            hasil["jumlah_sensor_suhu"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["jumlah_sensor_suhu"] = self.jumlah_sensor_suhu
        
        #Jika list_sensor_keludarag tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_sensor_keludara == None:
            hasil["list_sensor_keludara"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_sensor_keludara"] = self.list_sensor_keludara
        
        #Jika jumlah_sensor_keludara tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.jumlah_sensor_keludara == None:
            hasil["jumlah_sensor_keludara"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["jumlah_sensor_keludara"] = self.jumlah_sensor_keludara

        return hasil
