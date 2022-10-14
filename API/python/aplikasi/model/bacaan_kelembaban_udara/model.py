""" 
Model untuk satu bacaan_kelembaban_udara dari sensor

"""
import datetime


BACAAN_KELEMBABAN_UDARA_KIND = "bacaan_kelembaban_udara"

class Bacaan_Kelembaban_Udara:
    def __init__(self,  id=None,
                        tiang=None,
                        jenis=None,
                        id_sensor=None,
                        kapan= "TIDAK ADA INFORMASI",
                        nilai=None):
        self.id = id
        self.tiang = tiang
        self.jenis = jenis
        self.id_sensor = id_sensor
        self.kapan = kapan
        self.nilai = nilai


    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        if self.tiang == None:
            hasil["tiang"] = 0
        else: 
            hasil["tiang"] = self.tiang

        if self.jenis == None:
            hasil["jenis"] = 0
        else: 
            hasil["jenis"] = self.jenis

        if self.id_sensor == None:
            hasil["id_sensor"] = 0
        else: 
            hasil["id_sensor"] = self.id_sensor
        
        if self.kapan == None:
            hasil["kapan"] = "TIDAK ADA INFORMASI"
        else:
            hasil["kapan"] = self.kapan

        if self.nilai == None:
            hasil["nilai"] = 0
        else:    
            hasil["nilai"] = self.nilai

        return hasil
