# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Chief Hen
if user = User.find_by_email('samantha.s.harris@gmail.com')
  user.destroy
end
user = User.create(first_name:            'Sam',
                   last_name:             'Harris',
                   email:                 'samantha.s.harris@gmail.com',
                   password:              '12345678',
                   password_confirmation: '12345678',
                   chief_hen:             true)

# Hen party
user.parties.create(name: "Natalie's Hen Party")
party = user.parties.last

# Budget options
party.budgets.create([{ amount: 125 },
                      { amount: 150 },
                      { amount: 200 }])

# Date options
party.date_options.create([{ start_date: '18/01/2014', end_date: '19/01/2014' },
                           { start_date: '25/01/2014', end_date: '26/01/2014' },
                           { start_date: '08/02/2014', end_date: '09/02/2014' },
                           { start_date: '15/02/2014', end_date: '16/02/2014' }])

# Hens (participants)
party.participants.create([{ first_name: 'Jodie',
                             last_name:  'Parker',
                             email:      'ala1ne@me.com',
                             konnection: 'Bridesmaid' },
                           { first_name: 'Jess',
                             last_name:  'Smith',
                             email:      'jess@henparty.io',
                             konnection: 'Big sister' },
                           { first_name: 'Elizabeth',
                             last_name:  'Smith',
                             email:      'elizabeth@henparty.io',
                             konnection: 'Mother of the bride' },
                           { first_name: 'Verity',
                             last_name:  'Goodall',
                             email:      'vgoodall@henparty.io',
                             konnection: 'Uni friend' },
                           { first_name: 'Emily',
                             last_name:  'Wood',
                             email:      'emwood@henparty.io',
                             konnection: 'School friend' }])

# Hen's responses (budgets & dates)
party.participants.each do |participant|
  budget_ids = party.budgets.map(&:id)
  date_option_ids = party.date_options.map(&:id)

  if participant.id % 3 == 0
    budget_ids = budget_ids.take(1)
    date_option_ids = date_option_ids.sample(1)
  else participant.id.even?
    budget_ids = budget_ids.take(2)
    date_option_ids = date_option_ids.sample(2)
  end

  participant.response = Response.create(budget_option_ids: [budget_ids],
                                         date_option_ids: [date_option_ids])
end
