class Ability
  include CanCan::Ability

  def initialize(user)
    
    user ||= User.new # guest user (not logged in)
    
    alias_action :create, :read, :update, :destroy, :to => :crud
    
    # Guest users
    can [:home, :about, :contact, :help], StaticPagesController
    
    if user.role == "user" && user.approved == true
      can [:home, :about, :contact, :help, :useronlypage], StaticPagesController
    end    
    
    if user.role == "superuser" && user.approved == true      
      can [:home, :about, :contact, :help, :useronlypage], StaticPagesController
    end
    
    if user.role == "admin" && user.approved == true      
      can [:manage], StaticPagesController
      can [:index, :show], User
      
      can [:edit, :update, :destroy], User do |u|
        u.id != user.id 
      end
    end
        
  end
end
