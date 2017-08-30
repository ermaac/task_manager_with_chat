RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.excluded_models = ["UserBoard","Message","Chat","Invitation", "Profile"]
  config.model 'User' do
    exclude_fields :vk_id , :gh_id, :facebook_id, :google_id, :remember_created_at, :reset_password_sent_at, :provider, :last_sign_in_ip, :boards, :current_sign_in_ip, :current_sign_in_at, :updated_at, :created_at
  end  
  config.model 'Invitation' do
    exclude_fields :accepted
  end  
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['UserBoard','List','Note','Chat','Profile','Message']
    end  
    bulk_delete
    show do
      except ['Invitation', 'Profile']
    end  
    edit do
      except ['Note', 'List', 'Chat','Profile','UserBoard']
    end  
    delete do
      except ['Note', 'List', 'Chat','Profile','UserBoard']
    end  
    show_in_app do
      except ['Invitation', 'Board']
    end  

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
