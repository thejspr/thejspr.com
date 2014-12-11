require 'time'

desc 'create a new post'
task :new do
    title = ARGV[1]
    slug = "#{Date.today}-#{title.downcase.gsub(/[^\w]+/, '-')}"

    file = File.join(
        File.dirname(__FILE__),
        '_posts',
        slug + '.md'
    )

    File.open(file, "w") do |f|
        f << <<-EOS
---
layout: post
title: #{title}
published: false
---

TODO: summary

<!-- more -->


## Conclusion
EOS
    end

    system ("#{ENV['EDITOR']} #{file}")
end
