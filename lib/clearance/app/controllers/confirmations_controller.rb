module Clearance
  module App
    module Controllers
      module ConfirmationsController
    
        def self.included(controller)
          controller.class_eval do
            before_filter :existing_user?, :only => :new
        
            def new
              create
            end

            def create
              @user.confirm!
              session[:user_id] = @user.id
              redirect_to url_after_create
            end
        
            private
            
            def existing_user?
              @user = User.find_by_id_and_salt(params[:user_id], params[:salt])
              if @user.nil?
                render :nothing => true, :status => :not_found
              end
            end

            def url_after_create
              root_url
            end
            
          end
        end    
      end
    end
  end
end
