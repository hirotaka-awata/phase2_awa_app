module ItemsHelper

  def gravatar_for(item, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(item.id)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
