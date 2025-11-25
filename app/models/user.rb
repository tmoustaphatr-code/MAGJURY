class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[visiteur abonne redacteur admin super_admin]

  validates :role, inclusion: { in: ROLES }

  def has_role?(requested_role)
    role == requested_role.to_s
  end

  has_many :posts

  has_one_attached :profile

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'visiteur'
  end

   def super_admin?
    role == 'super_admin'
  end

  def admin?
    role == 'admin'
  end

  def abonne?
    role == 'abonne'
  end

  def redacteur?
    role == 'redacteur'
  end

  def nom_complet
    "#{nom} #{prenom}"
  end

  def initiales
    "#{prenom&.first&.upcase}#{nom&.first&.upcase}"
  end

end
