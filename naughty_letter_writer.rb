require 'erb'
require 'pry'

# inserts table in kids-data.txt and letter in our template.txt file into variables. File.read reads the file that we've put as the argument.

#each row in the table will become its own string
kids_data = File.read('data/kids-data.txt')

# each paragraph/line and break become its own string
naughty_letter = File.read('templates/naughty_letter_template.txt.erb')


# interating through variable kids_data to split up the information into separate arrays.
kids_data.each_line do |kid|

  kid_data_array = kid.split('|')
  kid_info = kid_data_array[0].split
  kid_infraction = kid_data_array[1]

  name        = kid_info[0]
  gender      = kid_info[1]
  behavior    = kid_info[2]
  toys        = kid_info[3..8]
  infraction  = kid_infraction

  toys.delete_if { |toy| toy == 'Kaleidoscope' }

# 'next' tells ruby to skip what follows in that particlar line is true. with unless it'll skip it if what follows in that line is false
  next unless behavior == 'naughty'

# lets ruby where to save and know how to name each file that we're creating for all of the kids where behavior = naughty
  filename = 'letters/naughty/' + name + '.txt'
# creating a new erb that will contain the naughty_letter variable we created above. '-' trims trims the line and ensures it's not included as part of the output. Without this trimming option, our letters would have extra lines.
  letter_text = ERB.new(naughty_letter, nil, '-').result(binding)

  puts "Writing #{filename}."
# initiates writing the letters and putting them into the naughty folder
  File.write(filename, letter_text)

end

puts "Done!!!"
