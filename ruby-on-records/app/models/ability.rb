# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Usuario no logueado - sin permisos
    return unless user.present?

    # Todos los usuarios logueados pueden:
    can :read, Disk      # Ver discos (público)
    can :read, Genre     # Ver géneros
    can :read, Client    # Ver clientes
    can :read, Sale      # Ver ventas
    can :read, Item      # Ver items de ventas
    can :read, :dashboard # Ver dashboard

    # Empleado: solo lectura (ya definido arriba)

    # Gerente: puede gestionar discos, ventas, clientes, géneros, items
    if user.gerente? || user.admin?
      can :manage, Disk
      can :manage, Sale
      can :manage, Client
      can :manage, Genre
      can :manage, Item
    end

    # Admin: puede todo, incluyendo gestionar usuarios
    if user.admin?
      can :manage, User
      can :manage, :all
    end
  end
end
