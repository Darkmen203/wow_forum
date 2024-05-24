class UsersController < ApplicationController
    
    # Other user actions...
    def show 

    end

    def edit 

    end
    
    def update 

    end
    
    def destroy 

    end
    
    def create_avatar_file
        if current_user
          uploaded_files = params[:files] # Ensure your form is sending files as a multi-part form data
          
          if uploaded_files.blank?
            render json: { error: "No files received." }, status: :bad_request
            return
          end
          
          # Ensure the directory exists
          uploads_dir = Rails.root.join('public', 'uploads')
          FileUtils.mkdir_p(uploads_dir) unless File.directory?(uploads_dir)
          
          data_name_files = {}
          
          filename = "#{current_user.id}_avatar.#{uploaded_files.original_filename.split('.').last}"
          filepath = uploads_dir.join(filename)
    
          begin
            File.open(filepath, 'wb') do |f|
              f.write(uploaded_files.read)
            end
            data_name_files[uploaded_files.original_filename] = filename
            current_user.update(avatar_url: "/uploads/" + filename)
            session[:avatar_url] = current_user.avatar_url
          rescue => e
            Rails.logger.error("Error occurred while saving file: #{e.message}")
            render json: { message: "Failed", status: 500 }, status: :internal_server_error
            return
          end
          
          # Redirect to the same page to reload it completely
          redirect_to request.referer, status: 308
        else
          Rails.logger.error("Error occurred while saving file: User is not logged in")
          render json: { message: "Failed", status: 503 }, status: :service_unavailable
          return
        end
    end
    
end
