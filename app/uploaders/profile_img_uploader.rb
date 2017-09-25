class ProfileImgUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end
