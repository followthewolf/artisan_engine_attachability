Rails.application.routes.draw do
  namespace :manage do
    post '/sort/:attachable_type/:attachable_id/:attachment_type' => 'attachers#sort', :as => 'sort_attachments'
  end
end