"""
Model Untuk Kind Lantai

Property Lantai:
+ id :	string
+ nama_lantai :	string
+ jumlah_pot : integer 
+ id_tiang: integer
+ list_pot: []
"""

# Konstanta kind lantai, konstanta ii dipakai agar nama kind untuk lantai seragam
LANTAI_KIND = "lantai"

class Lantai:
    def __init__(self, 
                id=None,
                nama_lantai="TIDAK ADA INFORMASI",
                jumlah_pot="TIDAK ADA INFORMASI",
                id_tiang="TIDAK ADA INFORMASI",
                list_pot="TIDAK ADA INFORMASI"):
        self.id = id
        self.nama_lantai = nama_lantai
        self.jumlah_pot = jumlah_pot
        self.id_tiang = id_tiang
        self.list_pot = list_pot
    
    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika nama tiang None jadikan "TIDAK ADA INFORMASI"
        if self.nama_lantai == None:
            hasil["nama_lantai"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["nama_lantai"] = self.nama_lantai
        
        #Jika jumlah lantai tidak ada jadikan 0
        if self.jumlah_pot  == None:
            hasil["jumlah_pot"] = 0
        else: 
            hasil["jumlah_pot"] = self.jumlah_pot

        if self.id_tiang == None:
            hasil["id_tiang"] ="TIDAK ADA INFORMASI"
        else:
            hasil["id_tiang"] = self.id_tiang
        
        #Jika daftar pot tidak ada jadikan "TIDAK ADA INFORMASI"
        if self.list_pot == None:
            hasil["list_pot"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["list_pot"] = self.list_pot
        
        return hasil
