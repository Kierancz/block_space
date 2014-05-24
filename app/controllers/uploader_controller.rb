class UploaderController < ApplicationController
    def create
        @image = Imgurruby::Imgur.new('ca590cbea5d1ba9')
        @image.upload(params[:file])
    end
end
