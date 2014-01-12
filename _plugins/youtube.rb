class YouTube < Liquid::Tag
  Syntax = /^\s*([^\s]+)(\s+(\d+)\s+(\d+)\s*)?/

  def initialize(tagName, markup, tokens)
    super

    if markup =~ Syntax then
      @id = $1

      if $2.nil? then
          @width = 560
          @height = 420
      else
          @width = $2.to_i
          @height = $3.to_i
      end

      @uri = "http://www.youtube.com/embed/#{@id}"
    else
      raise "No YouTube ID provided in the \"youtube\" tag"
    end
  end

  def render(context)
    %Q{<iframe width="#{@width}" height="#{@height}" frameborder="0" src="#{@uri}">    </iframe>}
  end

  Liquid::Template.register_tag "youtube", self
end
