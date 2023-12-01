class ImageService
  def self.save_image(image,user_id)
    tempfile = image[:tempfile]
    extension = File.extname(image[:filename])
    filename = "image_#{user_id}_#{SecureRandom.hex(16)}" + extension
      file_path = File.join('public', 'uploads', filename)
    File.open(file_path, 'wb') do |file|
      file.write(tempfile.read)
    end
    file_path
  end

  def self.get_image_data(file_path)
    File.open(file_path)
  end

  def self.destroy(image,filepath)
  end


end