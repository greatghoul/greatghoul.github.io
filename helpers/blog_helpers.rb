# https://github.com/danielbayerlein/middleman-casper/blob/master/helpers/middleman_casper_helpers.rb
# 
module BlogHelpers
  def is_tag_page?
    current_resource.metadata[:locals]['page_type'] == 'tag'
  end

  def page_title
    site_name = blog.options.name.dup

    title =
      if is_tag_page?
        current_resource.metadata[:locals]['tagname']
      elsif current_page.data.title
        current_page.data.title
      elsif is_blog_article?
        current_article.title
      end

    if title.present?
      "#{title} | #{site_name}"
    else
      site_name
    end
  end

  def page_description
    if is_blog_article?
      body = strip_tags(current_article.body).gsub(/\s+/, ' ')
      truncate(body, length: 147)
    end
  end

  def page_tags
    if is_blog_article?
      current_article.tags.join(', ')
    else
      "Ruby on Rails, Python, Chrome Extension"
    end
  end

  def set_seo_meta(title, description=nil, tags=nil)
    title_text = 'Ask and Learn'
    title_text = "#{title} | #{title_text}" if title.present?
    content_for :seo_meta do
      partial 'includes/seo_meta', locals: {
        page_title: title_text,
        page_description: description,
        page_tags: tags
      }
    end
  end

  def article_seo_meta(article)
    title = article.title
    description = article.body
    tags = article.tags

    set_seo_meta(title, description, tags)
  end

  def render_article(article)
    partial 'article', locals: { article: article }
  end

  def render_article_list(articles, options={})
    options = { date_format: :short }.merge(options)

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

  def article_tags(article)
    article.tags.join(', ')
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