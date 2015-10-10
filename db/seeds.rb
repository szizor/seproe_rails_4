# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
ActiveRecord::Base.establish_connection

if Role.all.length != 3
  ActiveRecord::Base.connection.execute("TRUNCATE roles")
  roles = Role.create([{ name: 'Administrador' }, { name: 'Adoptante' }, { name: 'Usuario' }])
end

if User.count < 1
  user = User.create(username: 'admin', email: 'admin@seproe.com', password: '12345678', password_confirmation: '12345678')
  role = Role.find_by_name("Administrador")
  user.roles << role
end

if ListingType.all.length != 3
  ActiveRecord::Base.connection.execute("TRUNCATE listing_types")
  listing_types = ListingType.create([{ name: 'Libre' }, { name: 'En Proceso' }, { name: 'Adoptado' }])
end

puts "Creating listings #{Listing.count}"
if Listing.count == 0
  [
    {
      name: 'paseo de Chapultepec',
      latitude: 20.67762900,
      longitude: -103.36874700,
      location: 'Paseo Chapultepec, Guadalajara, Jalisco',
      is_featured: 1,
      dimensions: 1024,
      listing_type_id: 1,
      subtitle: 'e/ Av. México Y Av. Niños Héroes',
      postal: 44260,
      description: 'Yr McSweeney Terry Richardson, Marfa tempor gastropub retro delectus Shoreditch cray narwhal enim next level. Reprehenderit bicycle rights VHS, keffiyeh non cred typewriter elit yr farm-to-table Banksy.',
      slug: 'paseo-de-chapultepec',
      category: "camellones y parques"
    },
    {
      name: 'Paseo de la Arboleda',
      latitude: 20.66329900,
      longitude: -103.38582200,
      location: 'Paseo de la Arboleda (Sol), Guadalajara, Jalisco 44520',
      is_featured: 0,
      dimensions: 234586,
      listing_type_id: 3,
      subtitle: 'Plaza del Sol',
      postal: 44100,
      description: 'Yr McSweeney Terry Richardson, Marfa tempor gastropub retro delectus Shoreditch cray narwhal enim next level. Reprehenderit bicycle rights VHS, keffiyeh non cred typewriter elit yr farm-to-table Banksy.',
      slug: 'paseo-de-la-arboleda',
      category: "camellones y parques"
    },
    {
      name: 'Centro Histórico',
      latitude: 20.66627300,
      longitude: -103.34851300,
      location: 'Av. 16 de Septiembre, Guadalajara Centro',
      is_featured: 0,
      dimensions: 234586,
      listing_type_id: 1,
      subtitle: 'Centro Histórico',
      postal: 44100,
      description: 'Yr McSweeney Terry Richardson, Marfa tempor gastropub retro delectus Shoreditch cray narwhal enim next level. Reprehenderit bicycle rights VHS, keffiyeh non cred typewriter elit yr farm-to-table Banksy.',
      slug: 'centro-historico',
      category: "plazas publicas"
    }
  ].each do |listing|
    puts Listing.create(listing)
  end
end