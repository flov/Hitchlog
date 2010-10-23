module Paperclip
  class Cropper < Thumbnail
    # Returns the command ImageMagick's +convert+ needs to transform the image
    # into the thumbnail.
    def transformation_command
      if crop_command
        crop_command + super.first.sub(/ -crop \S+/, '')
      else
        super
      end
    end
    
    # def transformation_command
    #   scale, crop = @current_geometry.transformation_to(@target_geometry, crop?)
    #   trans = []
    #   trans << "-resize" << %["#{scale}"] unless scale.nil? || scale.empty?
    #   trans << "-crop" << %["#{crop}"] << "+repage" if crop
    #   trans
    # end    
    
    def crop_command
      target = @attachment.instance
      if target.cropping?
        " -crop '#{target.crop_w.to_i}x#{target.crop_h.to_i}+#{target.crop_x.to_i}+#{target.crop_y.to_i}'"
      end
    end
  end
end