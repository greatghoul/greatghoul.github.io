class TagCloud
  cattr_accessor :default_options
  self.default_options = {
    threshold: 1,
    max_weight: 3,
  }

  attr_reader :options


  def self.render(tags, options={}, &block)
    TagCloud.new(options).render(tags, &block)
  end

  def render(tags, &block)
    tags_weight(tags_count(tags)).each do |tag_pair|
      tag, weight = tag_pair

      yield(tag, weight)
    end
  end

  private

  def tags_count(tags)
    tags.map do |tag, articles|
      [tag, articles.count] if articles.count >= options[:threshold]
    end.compact
  end

  def tags_weight(count)
    # get the minimum, and maximum tag count
    min, max = count.map(&:last).minmax

    count.map do |tag, count|
      # logarithmic distribution
      weight = (Math.log(count) - Math.log(min))/(Math.log(max) - Math.log(min))
      weight = (options[:max_weight] * weight).to_i

      [tag, weight]
    end
  end

  private

  def initialize(options = {})
    @options = default_options.update(options)
  end
end
