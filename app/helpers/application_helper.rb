module ApplicationHelper
  include CloudinaryHelper
  # app/helpers/application_helper.rb
  def can_edit_post?(post)
    user_signed_in? && (current_user.admin? || current_user.redacteur? || post.user == current_user)
  end
end