# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= Utilizador.new # guest user (not logged in)
    if user.administrador?
      can :manage, :all
    elsif user.docente?
      can :read, Turma do |turma|
        turma.utilizador_id == user.id
      end 

      can :update, Turma do |turma|
        turma.utilizador_id == user.id && turma.activada?
      end
      can :create, Turma 

      #can :destroy, Turma do |turma|
      #  turma.utilizador_id == utilizador.id && turma.activada?
      #end

    end
    
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
