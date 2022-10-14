"""
Model Untuk Kind Pot

Property Pot:
+ id :	string
+ nama_pot :	string
+ keterangan : string 
+ id_lantai: integer
+ list_bacaanpot: array
"""

# Konstanta kind pot, konstanta ii dipakai agar nama kind untuk pot seragam
POT_KIND = "pot"

class Pot:
    def __init__(self, id=None,
                        nama_pot="TIDAK ADA INFORMASI",
                        keterangan="TIDAK ADA INFORMASI",
                        id_lantai=None,
                        id_tiang="TIDAK ADA INFORMASI",
                        jumlah_bacaanpot=None,
                        list_bacaanpot="TIDAK ADA INFORMASI",
                        jenis="TIDAK ADA INFORMASI",
                        status="TIDAK ADA INFORMASI"):
        self.id = id
        self.nama_pot = nama_pot
        self.keterangan = keterangan
        self.id_lantai = id_lantai
        self.id_tiang = id_tiang
        self.jumlah_bacaanpot = jumlah_bacaanpot
        self.list_bacaanpot = list_bacaanpot
        self.jenis = jenis
        self.status = status
    
    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika nama pot None jadikan "TIDAK ADA INFORMASI"
        if self.nama_pot == None:
            hasil["nama_pot"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["nama_pot"] = self.nama_pot
        
        #Jika keterangan tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.keterangan == None:
            hasil["keterangan"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["keterangan"] = self.keterangan

        hasil["id_lantai"] = self.id_lantai
        hasil["id_tiang"] = self.id_tiang
        
        #Jika  jumlah_bacaanpot tidak ada jadikan 0
        if self.jumlah_bacaanpot  == None:
            hasil["jumlah_bacaanpot"] = 0
        else: 
            hasil["jumlah_bacaanpot"] = self.jumlah_bacaanpot
        
        #Jika daftar list_bacaanpot tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_bacaanpot == None:
            hasil["list_bacaanpot"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_bacaanpot"] = self.list_bacaanpot
        
        #Jika  jenis tidak ada jadikan 0
        if self.jenis  == None:
            hasil["jenis"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["jenis"] = self.jenis
        
        #Jika daftar status tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.status == None:
            hasil["status"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["status"] = self.status
        return hasil
