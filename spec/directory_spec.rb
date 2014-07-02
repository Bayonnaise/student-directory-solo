require 'directory'

describe 'student directory' do
	let(:student) {{name: "David", cohort: :June, hobby: "Golf"}}
	let(:student2) {{name: "Brian", cohort: :May, hobby: "Swimming"}}

	context 'when handling the student list' do
		it 'has no students' do
			expect(students).to be_empty
		end

		it 'adds a student' do
			add(student)
			expect(students).to eq [student]
		end

		it 'converts a student to nice text' do
			expect(student_to_s(student)).to eq "David (June cohort) likes golf"
		end

		it 'converts all the students to a list of nice text' do
			add(student)
			add(student2)
			expect(students_to_s).to eq "1. David (June cohort) likes golf\n2. Brian (May cohort) likes swimming\n"
		end
	end

	context 'when handling files' do
		it 'transforms a student into a csv line' do
			expect(student_to_csv(student)).to eq ['David', :June, 'Golf']
		end

		it 'saves to a file' do
			add(student)
			dummy = double
			expect(dummy).to receive(:<<).with(student_to_csv(student))
			expect(CSV).to receive(:open).with('../students.csv').and_yield(dummy)
			save(students)
		end

		it 'loads from a file' do
			row = student
			expect(students).to receive(:<<).with(row)
			expect(CSV).to receive(:foreach).with('../students.csv').and_yield(student)
			load_students
		end
	end

	context 'when handling output' do
		it 'prints the header' do
			expect(self).to receive(:puts).with("\nWelcome to Makers Academy\n==========================\n")
			print_header
		end

		it 'prints the footer' do
			expect(self).to receive(:puts).with("There are #{students.length} happy students.\n")
			print_footer
		end

		it 'prints the student list with header and footer' do
			expect(self).to receive(:print_header)
			expect(self).to receive(:puts).with(students_to_s)
			expect(self).to receive(:print_footer)
			print_students
		end

		it 'prints the interactive menu' do
			choice = "1"
			expect(self).to receive(:puts).with("\nWelcome to Makers Academy\n-----------------------\n1. Add a student\n2. Show the student list\n3. Save students to file\n4. Load students from file\n9. Exit\nChoose an option...")
			expect(self).to receive(:gets).and_return(choice)
			expect(self).to receive(:process).with(choice)
			run_interactive_menu
		end
	end

	context 'when handling input' do
		it 'asks for a thing' do
			name = "David"
			expect(self).to receive(:puts).with("Enter a name:")
			expect(self).to receive(:gets).and_return(name)
			expect(get_input("name")).to eq name
		end

		it 'responds to a 1' do
			expect(self).to receive(:get_input).with("name")
			expect(self).to receive(:get_input).with("cohort")
			expect(self).to receive(:get_input).with("hobby")
			process("1")
		end	

		it 'responds to a 2' do
			expect(self).to receive(:print_students)
			process("2")
		end	

		it 'responds to a 3' do
			expect(self).to receive(:save).with(students)
			process("3")
		end

		it 'respends to a 4' do
			expect(self).to receive(:load_students)
			process("4")
		end

		it 'respond to a 9' do
			expect(self).to receive(:exit)
			process("9")
		end
	end

	context 'when running the program' do
		# it 'loops the menu until killed' do
		# 	loop do
		# 		expect(self).to receive(:run_interactive_menu)
		# 	end
		# end
	end
end