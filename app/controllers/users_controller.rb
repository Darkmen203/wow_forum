class UsersController < ApplicationController
    
    # Other user actions...
    def show
        # redirect_to login_path_url unless current_user
    end
  
    def my_questions
        # redirect_to login_path_url unless current_user
    end
  
    def my_answers
        # redirect_to login_path_url unless current_user
    end
    
    def settings
        # redirect_to login_path_url unless current_user
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
            rescue => e
                Rails.logger.error("Error occurred while saving file: #{e.message}")
                render json: { message: "Failed", status: 500 }, status: :internal_server_error
                return
            end
            redirect_to '/profile/settings', notice: "Ответ успешно создан."
        else
            Rails.logger.error("Error occurred while saving file: User are not logined")
            render json: { message: "Failed", status: 503 }, status: :internal_server_error
            return
        end
    end
    
end
