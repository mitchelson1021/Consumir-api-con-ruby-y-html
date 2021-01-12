require "uri"
require "net/http"
require 'json'


def request(address, key)  #método request que recive una url y una key
    address += key  #se concatena la url y key
    url = URI(address)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_PEER
    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    JSON.parse(response.read_body)
end


data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=100&api_key=', 'tMxCZjQPCNcgywZW5psMrzqOjhfUgAexR26phSg7')

photos = data['photos'].map{|x| x['img_src']}

#puts data['photos'][0] mi guía

def build_web_page(argument)
    html = "<!DOCTYPE html>
    <html lang='es'>
    
    <head>
        <meta charset='utf-8'>
        <title>nasa</title>
    
    </head>
    
    <body>
        <h1> IMAGENES NASA CURIOSITY</h1>
        <div style='width:80%; margin:auto'>
            "
    beto = (argument)
    beto.each do |img| 
        html += "<img src='#{img}' width='100', display='grid'>\n\t\t"
    end
    html += "
    </div>
</body>"
    File.write('document.html', html)
end

crear_html = build_web_page(photos)
puts crear_html



puts photos.count
