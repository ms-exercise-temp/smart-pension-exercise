require './path_visit_data'

RSpec.describe PathVisitData do
  subject { described_class.new(visit_count: 1, unique_visit_count: 1) }

  context '#incremented_stats' do
    it 'increments the visit count' do
      subject.increment_stats(is_unique_visit: false)

      expect(subject.visit_count).to eq 2
    end

    context 'with a non-unique visit' do
      it 'does not increment the unique visits total' do
        subject.increment_stats(is_unique_visit: false)

        expect(subject.unique_visit_count).to eq 1
      end
    end

    context 'with a unique visit' do
      it 'increments the unique visits total' do
        subject.increment_stats(is_unique_visit: true)

        expect(subject.unique_visit_count).to eq 2
      end
    end
  end
end
