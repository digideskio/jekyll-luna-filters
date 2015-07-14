require "rspec/helper"
require "date"

describe Jekyll::Luna::Filters do
  context [:iso8601_date, :pretty_date] do
    it "works with DateTime Objects" do
      expect(iso8601_date(DateTime.now)).to match(
        %r!\d{4}/\d{2}/\d{2}!
      )
    end

    it "works with Time Objects" do
      expect(iso8601_date(Time.now)).to match(
        %r!\d{4}/\d{2}/\d{2}!
      )
    end

    it "works with strings" do
      expect(iso8601_date(Time.now.to_s)).to match(
        %r!\d{4}/\d{2}/\d{2}!
      )
    end

    it "works with Date Objects" do
      expect(iso8601_date(Date.today)).to match(
        %r!\d{4}/\d{2}/\d{2}!
      )
    end
  end

  context :num_as_color do
    it "responds to all numbers" do
      expect(num_as_color(9001)).to eq(
        "green"
      )
    end
  end

  context :num_as_word do
    it "responds to all numbers" do
      expect(num_as_word(9001)).to eq(
        "Great"
      )
    end
  end

  context :pretty_url do
    it "strips index+html from the URL" do
      expect(pretty_url("/hello-world.html")).to eq "/hello-world"
      expect(pretty_url("/hello-world/index.html")).to eq "/hello-world"
    end

    it "strips trailing slashes" do
      expect(pretty_url("/hello/")).to eq "/hello"
    end
  end

  context do
    let(:site) do
      OpenStruct.new({
        :config => {
          "tag_permalink" => "/tag/:tag"
        }
      })
    end

    context :tag_url do
      it "converts converts tags to a url" do
        expect(tag_url("hello", site)).to eq(
          %Q{<a class="tag" href="/tag/hello">hello</a>}
        )
      end
    end

    context :pretty_tag_links do
      it "converts an array into tag urls" do
        expect(pretty_tag_links(%W(1 2), site)).to eq(
          %Q{<a class="tag" href="/tag/1">1</a> and <a class="tag" href="/tag/2">2</a>}
        )
      end
    end
  end

  context :strip_end_punctuation do
    it "removes punctuation" do
      expect(strip_end_punctuation("hello.?!!?")).to eq(
        "hello"
      )
    end
  end

  context :titlecase do
    it "just works" do
      expect(titlecase("hello and but or of for nor a an the world")).to eq(
        "Hello and but or of for nor a an the World"
      )
    end
  end

  context :truncate do
    it "makes sure that something always returns" do
      expect(truncate("hello world how are you", 1)).to eq(
        "hello"
      )
    end

    it "does whole word truncation" do
      expect(truncate("hello world how are you", 12)).to eq(
        "hello world"
      )
    end
  end

  context :canonical do
    it "Strips pagination from the URL" do
      expect(canonical("/page/1")).to eq "/"
      expect(canonical("/page/1.html")).to eq "/"
      expect(canonical("/page1.html")).to eq "/"
      expect(canonical("/page1")).to eq "/"
    end
  end

  context :to_sentence do
    it "does not add commas when not needed" do
      expect(to_sentence(%W(hello))).to eq(
        "hello"
      )
    end

    it "comma seperates a list" do
      expect(to_sentence(%W(hello world today))).to eq(
        "hello, world and today"
      )
    end
  end
end
