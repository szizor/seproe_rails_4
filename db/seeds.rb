# encoding: utf-8

account = Account.create!(name: "Ejemplo 1", subdomain: "ejemplo")

super_admin = Role.create!(name: "Super Administrador")
admin     = Role.create!(name: "Administrador")
adoptant  = Role.create!(name: "Adoptante")

User.create! email: "administrador@compartiendo.com", password: "Compartiendo2015", role_id: super_admin.id

User.create! email: "administrador@ejemplo.com", password: "Compartiendo2015", role_id: admin.id, account_id:  account.id
User.create! email: "adoptante@ejemplo.com",     password: "Compartiendo2015", role_id: adoptant.id, account_id:  account.id


if ListingType.all.length != 3
  ActiveRecord::Base.connection.execute("TRUNCATE listing_types")
  listing_types = ListingType.create([{ name: 'Libre' }, { name: 'En Proceso' }, { name: 'Adoptado' }])
end

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
      category: "camellones y parques",
      account_id: account.id
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
      category: "camellones y parques",
      account_id: account.id
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
      category: "plazas publicas",
      account_id: account.id
    }
  ].each do |listing|
    puts Listing.create(listing)
  end
end