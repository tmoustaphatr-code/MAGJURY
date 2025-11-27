# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds/auctions.rb

# Création ou mise à jour de l'admin racine
admin = User.find_or_create_by!(email: "admin@magjury.com") do |u|
  u.nom = "Admin"
  u.prenom = "Super"
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role = "admin"
  u.status = "approved"
end

# db/seeds.rb
setting = SiteSetting.find_or_initialize_by(id: 1)
setting.update!(
  site_name:    'MagJury',
  logo:         nil,
  currency:     'EUR',
  time_zone:    'UTC+1',
  tel1:         '+33 1 23 45 67 89',
  tel2:         nil,
  site_email:   'contact@magjury.com',
  whatsapp:     '33612345678',
  facebook:     'https://facebook.com/magjury',
  linkedin:     'https://linkedin.com/company/magjury',
  instagram:    'https://instagram.com/magjury',
  tiktok:       nil,
  youtube:      nil,
  twitter:      'https://twitter.com/magjury',
  localisation: 'Paris, France',
  devise:       '€',
  description:  'MagJury – la plateforme citoyenne qui évalue les magistrats pour une justice plus transparente.'
)


puts "Admin racine créé : #{admin.email}"

