# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Usuario no logueado - sin permisos
    return unless user.present?

    # === Reglas Generales (Empleado y superiores) ===
    # "Empleado: puede administrar productos y ventas"
    can :manage, Disk
    can :manage, Sale
    can :manage, Item
    can :manage, Client
    can :manage, Genre
    can :read, :dashboard

    # === Reglas de Gerente ===
    # "Gerente: puede gestionar usuarios, pero no puede crear ni modificar admins"
    if user.gerente? || user.admin?
      can :manage, User
    end

    if user.gerente?
      # No puede gestionar usuarios que sean admin
      cannot :manage, User, role: 'admin'
    end

    # === Reglas de Admin ===
    # "Administrador: acceso total"
    if user.admin?
      can :manage, :all
    end
  end
end
