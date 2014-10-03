module ApplicationHelper
  def studio_meta_tag
    if protect_against_forgery?
      [
          tag('meta', :name => 'developer', :content => ''),
          tag('meta', :name => 'art-director', :content => '')
      ].join("\n").html_safe
    end
  end
  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
  def embedded_svg_data filename, options={}
    file = File.read(Rails.root.join(filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end
  def inline_svg(path)
    file = File.open("app/assets/images/#{path}", "rb")
    raw file.read

    #"1233214".to_f
  end
end
