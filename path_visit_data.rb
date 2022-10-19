class PathVisitData
  attr_accessor :visit_count
  attr_accessor :unique_visit_count

  def initialize(visit_count:, unique_visit_count:)
    @visit_count = visit_count
    @unique_visit_count = unique_visit_count
  end

  def increment_stats(is_unique_visit:)
    self.tap do |path_visit_data|
      path_visit_data.visit_count += 1
      path_visit_data.unique_visit_count +=1 if is_unique_visit
    end
  end
end
