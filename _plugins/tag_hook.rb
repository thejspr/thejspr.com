Jekyll::Hooks.register :posts, :post_write do |post|
  all_existing_tags = Dir.entries('tags')
                         .map { |t| t.match(/(.*).html/) }
                         .compact.map { |m| m[1] }

  tags = post['tags'].reject(&:empty?)
  tags.each do |tag|
    generate_tag_file(tag) unless all_existing_tags.include?(tag)
  end
end

def generate_tag_file(tag)
  File.open("tags/#{tag}.html", 'wb') do |file|
    file << "---\nlayout: tags\ntag-name: #{tag}\ntitle: Posts tagged #{tag}\n---\n\n"
  end
end
