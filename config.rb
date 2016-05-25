require "lib/tag_cloud"

###
# Blog settings
###

Time.zone = "Beijing"

activate :blog do |config|
  config.name = 'Ask and Learn'
  config.publish_future_dated = true

  config.permalink = ":year/:month/:title"
  config.sources = "posts/:year/:month/:title"
  config.layout = "layouts/article"
  config.summary_separator = /(READMORE)/
  config.summary_length = 250
  config.default_extension = ".md"

  config.tag_template = "tag.html"

  # Enable pagination
  config.paginate = true
  config.per_page = 10
  config.page_link = "page/{num}"
end

require "lib/blog_article_ext"


activate :directory_indexes
activate :meta_tags

activate :disqus do |d|
  d.shortname = 'g2world'
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-19523104-1'
end

page "/feed.xml", layout: false
page "/archive.html"
page "/tags.html"

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :fonts_dir, 'fonts'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

# Deploy
activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'ghoulmind.com'
  deploy.path   = '/home/deploy/ghoulmind'

  ## Optional Settings

  deploy.user  = 'deploy'
  # deploy.clean = true # remove orphaned files on remote host, default: false
  # deploy.flags = '-rltgoDvzO --no-p --del' # add custom flags, default: -avz
end
