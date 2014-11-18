module BlogHelpers
  def render_article(article)
    partial 'article', locals: { article: article }
  end

  def render_article_list(articles, options={})
    option = { date_format: :short }.merge(options)

    partial 'article_list', locals: { articles: articles, options: options }
  end

  def render_article_summary(article)
    html = Nokogiri::HTML(article.summary)
    html.css('img').each(&:remove)
    html.css('p:empty').each(&:remove)
    html.to_s
  end

  def render_article_tags(article)
    return '' unless article.tags.any?
    
    partial 'article_tags', locals: { tags: article.tags }
  end

  def render_article_meta(article)
    partial 'article_meta', locals: { article: article }
  end

  def to_date(date, format=:default)
    case format
    when :short
      date.strftime('%m-%d')
    else
      date.strftime('%Y-%m-%d %H:%M')
    end
  end
end