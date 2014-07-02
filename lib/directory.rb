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
	@students.map.with_index(1) do |student, index|
		"#{index}. #{student_to_s(student)}\n"
	end.join
end

# when handling files
def student_to_csv(student)
	student.values
end

def save(students)
	CSV.open('../students.csv') do |dummy|
		students.each do |student|
			dummy << student_to_csv(student)
		end
	end
end

def load_students
	CSV.foreach('../students.csv') do |row|
		students << row
	end
end
