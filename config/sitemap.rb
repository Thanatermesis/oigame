# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://oiga.me"

SitemapGenerator::Sitemap.yahoo_app_id = "V_diTqPV34HiBmRTs7vbnppcD.3pBTqA_X_pK47FkcfLAcxC5tCUTaEir5X2ojJOJtM22g--"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # Páginas estáticas
  add donate_path
  add answers_path
  add privacy_policy_path
  add contact_path
  
  # Secciones
  add campaigns_path, :changefreq => 'daily'
  add archived_campaigns_path, :changefreq => 'daily'

  # Campañas
  Campaign.published.find_each do |campaign|
    add campaign_path(I18n.default_locale, campaign), :lastmod => campaign.updated_at, :changefreq => 'daily'
  end
end
