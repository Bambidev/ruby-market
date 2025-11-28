# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    # Datos públicos
    can :read, Disk, public: true
    can :read, Genre, public: true

    # Todos los roles deben poder modificar los datos de su propia cuenta, menos su rol.

    # Un empleado puede administrar productos y ventas, pero no puede gestionar usuarios.
    if user.empleado?
      can :manage, Disk
      can :manage, Sale
      can :manage, Genre
      can :update, User, id: user.id # Solo su propio usuario
      cannot :manage, User, [:role]
    end

    # Un gerente puede administrar productos y ventas, y gestionar usuarios,
    # pero no puede crear ni modificar usuarios con rol de administrador.
    if user.gerente_o_superior?
      can :manage, Disk
      can :manage, Sale
      can :manage, Genre
      can :manage, User
      cannot :update, User, role: 'admin'  # No puede modificar admins!
      cannot :update, User, id: user.id, [:role]  # No puede cambiar su propio rol!
      can :view_reports, :all
    end

    # El administrador tiene todos los permisos. Tiene acceso a todas las funcionalidades de la aplicación.
    # Puede incluso crear/editar/eliminar otros usuarios administradores.
    if user.admin?
      can :manage, :all
      cannot :update, User, id: user.id, [:role]  # No puede cambiar su propio rol!
    end
  end
end
