RailsAdmin.config do |config|

  ### Popular gems integration

  config.authorize_with do
    redirect_to main_app.root_path unless warden.user.admin == true
  end
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
  config.excluded_models = ["UserBoard","Message","Chat","Invitation"]
  config.model 'User' do
    exclude_fields :sign_in_count,:last_sign_in_at, :vk_id , :gh_id, :facebook_id, :google_id, :remember_created_at, :reset_password_sent_at, :provider, :last_sign_in_ip, :boards, :current_sign_in_ip, :current_sign_in_at, :updated_at, :created_at
  end  
  config.model 'Invitation' do
    exclude_fields :accepted
  end  
  config.model 'Board' do
    exclude_fields :users, :lists, :creator_id
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
      except ['Note', 'List', 'Chat','Profile','UserBoard', 'Board']
    end  
    show_in_app do
      except ['Invitation', 'Board', 'Profile']
    end  

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
