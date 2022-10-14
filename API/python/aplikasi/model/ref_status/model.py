# Konstanta kind status, konstanta ii dipakai agar nama kind untuk status seragam
REF_STATUS_KIND = "ref_status"

class Ref_Status:
    def __init__(self, id=None,
                        nama="TIDAK ADA INFORMASI"
                        ):
        self.id = id
        self.nama = nama

    
    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        # Jika nama status None jadikan "TIDAK ADA INFORMASI"
        if self.nama == None:
            hasil["nama"] = "TIDAK ADA INFORMASI"
        else: 
            hasil["nama"] = self.nama
        
        return hasil
