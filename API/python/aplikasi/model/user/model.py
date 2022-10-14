USER_KIND="user"

class User:
    def __init__(   self, 
                    id=None,
                    email="TIDAK ADA INFORMASI",
                    no_hp="TIDAK ADA INFORMASI"):
        self.id = id
        self.email = email
        self.no_hp = no_hp

    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        if self.email == None:
            hasil["email"] = "TIDAK ADA INFORMASI"
        else:
            hasil["email"] = self.email

        if self.no_hp == None:
            hasil["no_hp"] = "TIDAK ADA INFORMASI"
        else:
            hasil["no_hp"] = self.no_hp
            
        return hasil
        