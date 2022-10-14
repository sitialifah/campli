from flask import Flask
import requests
import os    
import logging

# os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "F:/FLUTTER_CAMPLI/campli-mobile/API/python/aplikasi/ta-campli-17c4573267c3.json"

# Buat object Flask
app = Flask(__name__, template_folder="templates", instance_relative_config=True)


# Muat konfigurasi global
app.config.from_object('config')
# Muat konfigurasi instance
app.config.from_pyfile('config.py')

# Set server untuk development
app.config["ENV"] = "development"
# Hidupkan debugger di server
app.config["DEBUG"] = True

logger = logging.getLogger('websockets')
logger.setLevel(logging.INFO)
logger.addHandler(logging.StreamHandler())

# Periksa apakah ada didefisinikan mode dimana kode dijalankan
if "MODE_LINGKUNGAN" in app.config:
    if app.config["MODE_LINGKUNGAN"] == "DEV":
        # Kode dijalankan dalam lingkungan pengembangan
        app.config["ENV"] = "development"
        app.config["DEBUG"] = True
    elif app.config["MODE_LINGKUNGAN"] == "PROD":
        # Kode dijalankan dalam lingkungan produksi
        app.config["ENV"] = "production"
        app.config["DEBUG"] = False
    elif app.config["MODE_LINGKUNGAN"] == "TEST":
        # Kode dijalankan dalam lingkungan pengembangan
        app.config["ENV"] = "development"
        app.config["DEBUG"] = True

# Jadikan template bisa auto reload
app.config["TEMPLATES_AUTO_RELOAD"] = True

# Buat session
app.secret_key = app.config["SESSION_SECRET_KEY"]
#

# Daftarkan semua blueprint
#


# Blueprint untuk campli
from .views import campli
app.register_blueprint(campli)

# Blueprint untuk user
from .views import user
app.register_blueprint(user)

# Blueprint untuk tiang
from .views import tiang
app.register_blueprint(tiang)

# Blueprint untuk lantai
from .views import lantai
app.register_blueprint(lantai)

# Blueprint untuk konfigurasi
from .views import konfigurasi
app.register_blueprint(konfigurasi)

# Blueprint untuk pot
from .views import pot
app.register_blueprint(pot)

# Blueprint untuk aktuator
from .views import aktuator
app.register_blueprint(aktuator)

# Blueprint untuk sensor_tiang
from .views import sensor_suhu
app.register_blueprint(sensor_suhu)

# Blueprint untuk sensor_kelembabanudara
from .views import sensor_kelembaban_udara
app.register_blueprint(sensor_kelembaban_udara)

# Blueprint untuk ref status
from .views import ref_status
app.register_blueprint(ref_status)

# Blueprint untuk ref aktuator
from .views import ref_aktuator
app.register_blueprint(ref_aktuator)

# Blueprint untuk bacaan_suhu
from .views import bacaan_suhu
app.register_blueprint(bacaan_suhu)

# Blueprint untuk bacaan_kelembaban_udara
from .views import bacaan_kelembaban_udara
app.register_blueprint(bacaan_kelembaban_udara)


# Blueprint untuk bacaan_pot
from .views import bacaan_pot
app.register_blueprint(bacaan_pot)

