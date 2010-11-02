module Paperclip
  class Cropper < Thumbnail
    # Returns the command ImageMagick's +convert+ needs to transform the image
    # into the thumbnail.
    def transformation_command
      if crop_command
        crop_command + super.join(' ').sub(/ -crop \S+/, '').split(' ')
      else
        super
      end
    end
    # -crop '221x221+0+0' -resize "x100" +repage
    # -crop '221x221+0+0' -resize "500x500>"

    
    def crop_command
      target = @attachment.instance
      if target.cropping?
        ["-crop","#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}"]
      end
    end
  end
end