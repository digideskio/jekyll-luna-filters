require "jekyll"

module Jekyll
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
          then alias_method(
            k, v
          )
        else
          define_method k do |i|
            DateTime.parse(i.to_s).strftime(
              v
            )
          end
        end
      end

      def num_as_color(num)
        num = Integer  num
        if num > 4 then "green"
          elsif num == 4 then "blue"
          elsif num == 3 then "yellow"
          else "red"
        end
      end

      def num_as_word(num)
        num = Integer num
        if num > 4 then "Great"
          elsif num == 4 then "Good"
          elsif num == 3 then "Alright"
          else "Bad"
        end
      end

      def pretty_url(out)
        if (out = out.gsub(/(index)?\.html/, "").gsub(/\/$/, "")) == ""
          then "/" else out
        end
      end

      def tag_url(tag, site = @context.registers[:site])
        template = "/#{site.config["tag_permalink"].gsub(
          /\A\//, ""
        )}"

        TAG_ANCHOR % [
          pretty_url(template.sub(":tag", tag)), tag
        ]
      end

      def pretty_tag_links(tags, site = @context.registers[:site])
        to_sentence(
          tags.map do |t|
            tag_url(
              t, site
            )
          end
        )
      end

      def strip_end_punctuation(input)
        input.gsub(
          /(\.|!|\?|\?!|!\?)+$/, ""
        )
      end

      def titlecase(input)
        input.split(/\b/).map do |w|
          if w =~ /\A[A-Z]/ || w.length < 2 then w else
            NO_CAPS.include?(w.downcase) ? w.downcase : w.capitalize
          end
        end.\
        join
      end

      def truncate(str, length)
        min = str.strip.split(/\b/)[0].length
        if min > length
          then length = min
        end

        str[/^.{0,#{length}}\b/].\
          strip
      end

      def canonical(url)
        return pretty_url(url).gsub(
          %r!/page(/\d+|\d+)/?$!, "/"
        )
      end

      # -----------------------------------------------------------------------
      # This is hijacked from Rails and edited, thank Rails :)
      # -----------------------------------------------------------------------

      def to_sentence(ary)
        return unless ary.is_a?(Array)

        case ary.size
          when 1 then ary[0]
          when 2 then "#{ary[0]} and #{ary[1]}"
          when 0 then ""
        else
          "#{ary[0...-1].join(", ")} and #{ary[-1]}"
        end
      end
    end
  end
end

Liquid::Template.register_filter(
  Jekyll::Luna::Filters
)
