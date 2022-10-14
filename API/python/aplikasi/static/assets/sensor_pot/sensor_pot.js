function titleCase(data) {
  data = data.toLowerCase().split(' ');
  for (var i = 0; i < data.length; i++) {
    data[i] = data[i].charAt(0).toUpperCase() + data[i].slice(1);
  }
  console.log("data")

  console.log(data)

  return data.join(' ');

}

(async function () {

  console.log("init")

  let xhrResponse = await xhrRequest("get", "json", "/sensor_pot/daftar")
  console.log("XHR")

  console.log(xhrResponse.response['daftar'])

  let data = xhrResponse.response['daftar']
  // console.log(data)

  let optionsList = '<option>Pilih</option>'


  for (let i = 0; i < data.length; i++) {
    optionsList += "<option name=id_sensor value='" + data[i]['id'] + "'> " + titleCase(data[i]['nama_pengenal_sensor']) + " </option>"
  }

  $('#select-sensor-pot').append(optionsList);

}());