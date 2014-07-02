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
end