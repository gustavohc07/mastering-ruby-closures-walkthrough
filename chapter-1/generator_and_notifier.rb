Report = Struct.new(:to_csv, keyword_init: true)

class Generator
  attr_reader :report
  def initialize(report)
    @report = report
  end

  def run
    report.to_csv
  end
end


class Notifier
  attr_reader :callbacks, :generator

  def initialize(generator:, callbacks:)
    @generator = generator
    @callbacks = callbacks
  end

  def run
    result = generator.run
    if result
      callbacks.fetch(:on_success).call(result)
    else
      callbacks.fetch(:on_failure).call
    end
  end
end

good_report = Report.new(to_csv: "59.99, Great Success")
bad_report = Report.new(to_csv: nil)

Notifier.new(
  generator: Generator.new(good_report),
  callbacks: {
    on_success: -> (report) {puts "#{report} sending to your boss"},
    on_failure: -> {puts "Something is wrong with this report, take a look"}
  }
).tap do |notifier|
  notifier.run
end

