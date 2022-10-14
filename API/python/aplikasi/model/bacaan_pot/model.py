""" 
Model untuk satu bacaan_pot dari sensor

Property:
+ id: integer
+ id_sensor: integer
+ kapan: string
  Memakai: RFC 3339, section 5.6,
  Contoh: 2001-01-01T01:01:01+07:00
+ nilai: double 

"""
import datetime


BACAAN_POT_KIND = "bacaan_pot"

class Bacaan_Pot:
    def __init__(self,  id=None,
                        id_pot=None,
                        lantai=None,
                        kapan= "TIDAK ADA INFORMASI",
                        nilai=None,
                        kondisi="TIDAK ADA INFORMASI",
                        jenis="TIDAK ADA INFORMASI"):
        self.id = id
        self.id_pot = id_pot
        self.lantai = lantai
        self.kapan = kapan
        self.nilai = nilai
        self.kondisi = kondisi
        self.jenis = jenis


    def ke_dictionary(self):
        hasil = {}

        # Jika id None jangan buat key "id"
        if self.id != None:
            hasil["id"] = self.id

        if self.id_pot == None:
            hasil["id_pot"] = 0
        else: 
            hasil["id_pot"] = self.id_pot
        
        if self.lantai == None:
            hasil["lantai"] = 0
        else: 
            hasil["lantai"] = self.lantai
        
        if self.kapan == None:
            hasil["kapan"] = "TIDAK ADA INFORMASI"
        else:
            hasil["kapan"] = self.kapan

        if self.nilai == None:
            hasil["nilai"] = 0
        else:    
            hasil["nilai"] = self.nilai

        if self.kondisi == None:
            hasil["kondisi"] = "TIDAK ADA INFORMASI"
        else:    
            hasil["kondisi"] = self.kondisi
            
        if self.jenis == None:
            hasil["jenis"] = "TIDAK ADA INFORMASI"
        else:    
            hasil["jenis"] = self.jenis

        return hasil
