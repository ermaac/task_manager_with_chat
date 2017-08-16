module DashboardHelper
  def make_nickname message
    profile = message.user.profile
    "#{profile.last_name} #{profile.first_name[0]}.".titleize
  end
end
