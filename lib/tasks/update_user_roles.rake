namespace :rhinoart do
  desc "Update user roles to rolefy gem"
  task update_user_roles: :environment do
    Rhinoart::User.all.each do |user|
      roles = user.admin_role.split(',') if user.admin_role.present?
      if roles.present? && roles.any?
        roles.each do |r|
          user.add_role r
        end
      end

      roles = user.frontend_role.split(',') if user.frontend_role.present?
      next unless roles.present? && roles.any?
      roles.each do |r|
        user.add_role r
      end
    end
  end

  desc "Load user roles"
  task load_user_roles: :environment do
    Rhinoart::User::ADMIN_PANEL_ROLES.each do |role|
      Role.create!(name: role) unless Role.find_by(name: role)
    end

    Rhinoart::User::FRONTEND_ROLES.each do |role|
      Role.create!(name: role) unless Role.find_by(name: role)
    end
  end
end
