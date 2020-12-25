# frozen_string_literal: true

RSpec.describe Utils::Common do
  let(:rows) { 10 }
  let(:cols) { 10 }

  describe ".build_2d_array" do
    context "with default false empty arg" do
      context "created instance" do
        let!(:two_dimensional_array) { described_class.build_2d_array(rows, cols) }
        let(:first_row) { two_dimensional_array[0] }

        it "should return two_dimensional_array" do
          expect(two_dimensional_array).to be_an_instance_of(Array)
          expect(first_row).to be_an_instance_of(Array)
        end

        it "should return two_dimensional_array containing Integer values greater or equal than 0 or less than 2" do
          two_dimensional_array.each do |row|
            expect(row).to all(be_a(Integer).and(be >= 0 && be < 2))
          end
        end

        it "should return two_dimensional_array the proper amount of rows and columns " do
          expect(two_dimensional_array.size).to eq(rows)
          expect(first_row.size).to eq(cols)
        end
      end

      context "instance creation" do
        after(:example) do
          described_class.build_2d_array(rows, cols)
        end

        it "should invoke Array.new with rows args" do
          expect(Array).to receive(:new).with(rows).once
        end

        it "should invoke Array.new with cols args" do
          expect(Array).to receive(:new).with(cols).once
        end

        it "should invoke rand with 2 value number the same amount of values from the two_dimensional_array" do
          amount_of_total_cells = rows * cols
          expect_any_instance_of(Object).to receive(:rand).with(2).exactly(amount_of_total_cells).times
        end
      end
    end

    context "created instance" do
      let!(:two_dimensional_empty_array) { described_class.build_2d_array(rows, cols, empty: true) }

      it "should return two_dimensional_empty_array containing an Arrays" do
        expect(two_dimensional_empty_array).to be_an_instance_of(Array)
        expect(two_dimensional_empty_array[0]).to be_an_instance_of(Array)
      end

      it "should return two_dimensional_empty_array" do
        two_dimensional_empty_array.each do |row|
          expect(row).to all(eq(nil))
        end
      end

      it "should return two_dimensional_empty_array the proper amount of rows and columns " do
        expect(two_dimensional_empty_array.size).to eq(rows)
        expect(two_dimensional_empty_array[0].size).to eq(cols)
      end
    end

    context "instance creation" do
      after(:example) do
        described_class.build_2d_array(rows, cols, empty: true)
      end

      it "should invoke Array.new with rows args" do
        expect(Array).to receive(:new).with(rows).once
      end

      it "should invoke Array.new with cols args" do
        expect(Array).to receive(:new).with(cols)
      end
    end
  end
end
