Middleman::Blog::BlogArticle.module_eval do
  include Padrino::Helpers::FormatHelpers

  def description
    text = strip_tags(self.body).gsub(/\s+/, ' ')
    truncate(text, length: 147)
  end
end
