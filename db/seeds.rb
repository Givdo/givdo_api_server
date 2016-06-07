Answer.destroy_all
Trivia.destroy_all

# Organizations
[
  '6204742571', '24472055070', '10004746836', '100235282316', '10150097369190298', '10150115436950364',
  '103927839658987', '108147600393', '110875278993891', '111049572241728', '111263655567366', '114527438605257',
  '11489714459', '116783373272', '121457559697', '122816931079030', '124637427614470', '124822327598488',
  '129504020431763', '137263192988252', '137605952937845', '138273981390', '139877936048487', '1418722245060307',
  '143450215071', '145729345990', '151056047463', '152630384756238', '154214174253', '154882568152', '161919800497696',
  '162575697564', '163561379108', '1638314679741495', '164704756597', '178851656378', '182652741786358', '19397272468',
  '19652732615', '199244038582', '20679907023', '213703000713', '21783226184', '237203823072826', '239480899433820',
  '24379801832', '244715388875818', '24738305748', '249660460739', '24969260878', '253978954649030', '256056697748482',
  '258615240845107', '27923251292', '293517332885', '30100581939', '306485082786856', '311905907076', '318577481116',
  '318976542175', '35796107678', '382163031845541', '417925141600078', '445040695547260', '46349596313', '49918541836',
  '50241121055', '53591201334', '54251291911', '5618849604', '56463308862', '56586643368', '56644048356', '62009902514',
  '6769347911', '71679985558', '71800720352', '72724474789', '76025018070', '76025018070', '77249738079', '77943343461',
  '7972952490', '80880151683', '81081806187', '81250541096', '85576047938', '89181104843', '8978324743', '91821375381',
  '91990961868', '9217584365', '94121835955', '95295732841', '95784413698', '97261063097'
].each do |facebook_id|
  Organization.where(:facebook_id => facebook_id).first_or_create
end

# Trivias
[
  ['What is the most common litter on beaches?', 'Glass', 'Aluminum', 'Plastic'],
  ['How much water on Earth is clean enough to drink?', '1%', '40%', '15%'],
  ['How much of the Earth\'s oceans are polluted?', '80%', '1%', '32%'],
  ['How many people have gained access to clean water since 1990?', '2.6 billion people', '1.4 million people', '860,000'],
  ['Recycling one aluminum can saves enough energy to...', 'run a TV for three hours', 'run an electric car for 12 miles', 'run a laptop for an hour'],
  ['How many times can an alumnium can be recycled?', 'ad infinitum', '3 times', '10 times'],
  ['How many aluminum cans do we consume in a year?', '80 trillion', '25 trillion', '600 billion'],
  ['The worlds tallest tree is in...', 'California', 'Montana', 'Washington'],
  ['Recycling a single run of the Sunday New York Times would save...', '75 million trees', '10 thousand trees', '1 million'],
  ['On average, how many bags does ONE supermarket go through in one year', '60,500,000', '5,000,000,000', '15,000,000']
].each do |args|
  trivia = Trivia.create(question: args.shift, category: Category.other)
  options = args.map do |option|
    trivia.options.create(text: option)
  end
  trivia.update_attribute(:correct_option_id, options.first.id)
end


# Badges
[
  # $1
  ['Giver', '100'],
  ['Giver 2', '200'],
  ['Giver 3', '300'],
  ['Giver 4', '400'],

  # $5
  ['Samaritan', '500'],
  ['Samaritan 2', '1000'],
  ['Samaritan 3', '1500'],
  ['Samaritan 4', '2000'],

  # $25
  ['Altruist', '2500'],
  ['Altruist 2', '4000'],
  ['Altruist 3', '6000'],
  ['Altruist 4', '8000'],

  # $100
  ['Benefactor', '10000'],
  ['Benefactor 2', '14000'],
  ['Benefactor 3', '18000'],
  ['Benefactor 4', '22000'],

  # $250
  ['Patron', '25000'],
  ['Patron 2', '31000'],
  ['Patron 3', '37000'],
  ['Patron 4', '43000'],

  # $500
  ['Philanthropist', '50000'],
  ['Philanthropist 2', '60000'],
  ['Philanthropist 3', '75000'],
  ['Philanthropist 4', '90000'],

  # $1_000
  ['Grantor', '100000']
].each do |args|
  Badge.find_or_create_by(name: args.first) do |badge|
    badge.score = args.last
  end
end


[
  'animal-welfare',
  'art-theatre',
  'community',
  'environment',
  'family-services',
  'health-wellness',
  'human-rights',
  'hunger',
  'international-support',
  'mental-health',
  'science-research',
  'youth-education'
].each do |args|
  Cause.create(name: args)
end
