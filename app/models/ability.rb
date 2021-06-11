class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      user.role.permissions.each do |permission|
        if permission.subject_class == "all"
          can permission.action.to_sym, permission.subject_class.to_sym
        else
          can permission.action.to_sym, permission.subject_class.constantize
        end
      end
    else
      can :amfp_callback, :amfp_callback
    end
  end
end
