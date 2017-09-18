
class PrettyTime
  def initialize(record_array)
    @records = record_array
  end

  def call
    prettify
  end

  private
  def prettify
    @records.each { |record| record.assign_attributes({date: record.date.strftime('%b %d %Y, %I:%M%p')}) }
    @records
  end
end
