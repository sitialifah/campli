
function titleCase(data) {
    data = data.toLowerCase().split(' ');
    for (var i = 0; i < data.length; i++) {
      data[i] = data[i].charAt(0).toUpperCase() + data[i].slice(1); 
    }
    return data.join(' ');
  }

(async function() {

    console.log("init")
    
    let xhrResponse = await xhrRequest("get", "json", "/tiang/daftar")
    console.log("respon")

    console.log(xhrResponse.response[''])

    let data = xhrResponse.response['daftar']

    let optionsList = '<option>Pilih</option>'


    for(let i = 0; i < data.length; i++) {
        optionsList += "<option name=id_tiang value='" + data[i]['id'] +"'> " + titleCase(data[i]['nama_tiang']) + " </option>"
    }

    $('#select-tiang').append(optionsList);

}());
