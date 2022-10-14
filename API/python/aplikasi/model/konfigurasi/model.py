"""
Model Untuk Kind Konfigurasi

Property Konfigurasi:
+ id :	string
+ id_ref_aktuator : integer 
+ set_waktu : string
+ set_tanggal : string
+ id_aktuator: integer
+email" string (penambahan baru)
"""

# Konstanta kind konfigurasi, konstanta ii dipakai agar nama kind untuk konfigurasi seragam
KONFIGURASI_KIND = "konfigurasi"

class Konfigurasi:
    def __init__(self,  id=None,
                        id_ref_status_konfig=None, 
                        kapan="TIDAK ADA INFORMASI",
                        id_aktuator=None,
                        email="TIDAK ADA INFORMASI"):
        self.id = id
        self.id_ref_status_konfig = id_ref_status_konfig
        self.kapan = kapan
        self.id_aktuator = id_aktuator
        self.email=email
    
    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id
        
        #Jika ref status konfig tidak ada jadikan 0
        if self.id_ref_status_konfig == None:
            hasil["id_ref_status_konfig"] = 0
        else: 
            hasil["id_ref_status_konfig"] = self.id_ref_status_konfig

        if self.kapan == None:
            hasil["kapan"] = "TIDAK ADA INFORMASI"
        else:
            hasil["kapan"] = self.kapan
            
        #Jika id_aktuator tidak ada jadikan 0
        if self.id_aktuator == None:
            hasil["id_aktuator"] = 0
        else: 
            hasil["id_aktuator"] = self.id_aktuator
        
        if self.email == None:
            hasil["email"] = "TIDAK ADA INFORMASI"
        else:
            hasil["email"] = self.email

        
        return hasil
