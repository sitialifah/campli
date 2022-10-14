
# Konstanta kind status, konstanta ii dipakai agar nama kind untuk status seragam
REF_AKTUATOR_KIND = "ref_aktuator"

class Ref_Aktuator:
    def __init__(self, id=None,
                        nama_aktuator="TIDAK ADA INFORMASI"
                        ):
        self.id = id
        self.nama_aktuator = nama_aktuator

    
    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika nama aktuator None jadikan "TIDAK ADA INFORMASI"
        if self.nama_aktuator == None:
            hasil["nama_aktuator"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["nama_aktuator"] = self.nama_aktuator
        
        return hasil
