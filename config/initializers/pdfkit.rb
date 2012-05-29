PDFKit.configure do |config|
  config.wkhtmltopdf = 'C:\Program Files\wkhtmltopdf\wkhtmltopdf.exe'
  config.default_options = {
     :page_size => 'A4',
     :print_media_type => true
  }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end