class ApiController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token
  def video
    require 'streamio-ffmpeg'
    video = params[:video]
    name = video.original_filename[0...-5]
    save_path = Rails.root.join("public/upload/#{name}.webm")
    File.open(save_path, 'wb') do |f|
      f.write params[:video].read
    end
    movie = FFMPEG::Movie.new(Rails.root.join("public/upload/#{name}.webm"))
    movie.transcode(Rails.root.join("public/upload/#{name}.mp4"), '-strict -2')
    movie.transcode(Rails.root.join("public/upload/#{name}.png"), '-ss 00:00:00.100 -an -f image2 -r 1/5')
    File.delete(Rails.root.join("public/upload/#{name}.webm"))
    render :nothing => true
  end

  def email
    respond_to do |format|
      email = params[:email]
      isUnique = true
      begin
        User.find_by(:email => email)
        isUnique = false
      rescue
      end
      msg = {:isUnique => isUnique}
      format.json {render :json => msg}
    end
  end

  def videocheck
    respond_to do |format|
      isVideo = false
      begin
        VideoInfo.new(params[:url])
        isVideo = true
      rescue
      end
      puts isVideo
      puts params[:url]
      msg = {:isVideo => isVideo}
      format.json {render :json => msg}
    end
  end
end