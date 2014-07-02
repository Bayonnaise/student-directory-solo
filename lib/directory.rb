require 'csv'

# when handling the student list
def students
	@students ||= []
end

def add(student)
	students << student
end

def student_to_s(student)
	"#{student[:name]} (#{student[:cohort]} cohort) likes #{student[:hobby].downcase}"
end

def students_to_s
	students.map.with_index(1) do |student, index|
		"#{index}. #{student_to_s(student)}\n"
	end.join
end

# when handling files
def student_to_csv(student)
	student.values
end

def save(students)
	CSV.open('../students.csv', 'w') do |dummy|
		students.each do |student|
			dummy << student_to_csv(student)
		end
	end
end

def load_students
	CSV.foreach('../students.csv', 'r') do |row|
		students << row
	end
end

# when handling output
def print_header
	puts "\nWelcome to Makers Academy\n==========================\n"
end

def print_footer
	puts "There are #{students.length} happy students.\n"
end

def print_students
	print_header
	puts students_to_s
	print_footer
end

# when handling input
def get_input(thing)
	puts "Enter a #{thing}:"
	gets.chomp
end

def run_interactive_menu
	puts "\nWelcome to Makers Academy\n-----------------------\n1. Add a student\n2. Show the student list\n3. Save students to file\n4. Load students from file\n9. Exit\nChoose an option..."
	process(gets.chomp)
end

def process(choice)
	case choice
	when "1"
		name = get_input("name")
		cohort = get_input("cohort")
		hobby = get_input("hobby")
		add({name: name, cohort: cohort, hobby: hobby})
	when "2"
		print_students
	when "3"
		save(students)
	when "4"
		load_students
	when "9"
		exit
	else
	end
end

# loop do
# 	run_interactive_menu
# end