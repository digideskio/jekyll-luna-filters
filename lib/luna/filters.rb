module Luna
  module Filters
      TAG_ANCHOR = %Q{<a class="tag" href="%s">%s</a>}
         NO_CAPS = %W(and but or of for nor a an the)
    TIME_METHODS = {
      :iso8601_date => "%Y/%m/%0d",
      :iso_8601_date => :iso8601_date,
      :pretty_date => "%B %0d, %Y",
    }

    TIME_METHODS.each do |k, v|
      if v.is_a?(Symbol)
        alias_method k, v
      else
        define_method k do |i|
          i.strftime(v)
        end
      end
    end

    def pretty_url(out)
      out.gsub(/(index)?\.html/, "").gsub(/\/$/, "")
    end

    # -------------------------------------------------------------------------

    def pretty_tag_links(tags, site = @context.registers[:site])
      path = site.config["tags"]["path"]

      to_sentence(
        tags.map do |t|
          TAG_ANCHOR % [pretty_url(path.sub(":tag", t)), t]
        end
      )
    end

    # -------------------------------------------------------------------------

    def strip_end_punctuation(input)
      # There could be some missing out.
      input.gsub(/(\.|!|\?|\?!|!\?)$/, "")
    end

    # -------------------------------------------------------------------------

    def titlecase(input)
      input.split(/\b/).map do |w|
        if w =~ /\A[A-Z]/ || w.length < 2 then w else
          NO_CAPS.include?(w.downcase) ? w.downcase : w.capitalize
        end
      end.join
    end

    # -------------------------------------------------------------------------

    def truncate(out, length)
      if out.respond_to?(:truncate)
        then out[0...length] + "\s&hellip;"
      else
        out.truncate(length + 3, {
          :separator => "\s",
          :ommission => "&hellip;"
        })
      end
    end

    # -------------------------------------------------------------------------

    def canonical(url)
      # Because canonical urls should be pretty.
      pretty_url(url).gsub(%r!/page(/\d+|\d+)/$!, "/")
    end

    # -------------------------------------------------------------------------
    # This is hijacked from Rails and edited, thank Rails :)
    # -------------------------------------------------------------------------

    def to_sentence(ary)
      return unless ary.is_a?(Array)

      case ary.size
        when 1 then ary.to_s
        when 2 then "#{ary[0]}, #{ary[1]}"
        when 0 then ""
      else
        "#{ary[0...-1].join(", ")} and #{ary[-1]}"
      end
    end
  end
end

Liquid::Template.register_filter(Luna::Filters)
