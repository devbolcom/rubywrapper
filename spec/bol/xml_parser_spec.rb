require 'spec_helper'

describe Bol::XmlParser do
  def fixture(name)
    File.read(File.expand_path(File.join("../../fixtures/#{name}"), __FILE__))
  end

  describe 'parsing products' do
    let(:product) { Bol::XmlParser.new(fixture('products.xml')).product }

    it 'should set simple attributes' do
      product.id.must_equal('1001004006016448')
      product.title.must_equal('Harry Potter Boxed Set (Adult Edition)')
      product.subtitle.must_equal('Volume 1 - 7, paperback')
      product.publisher.must_equal('Bloomsbury Publishing PLC')
      product.ean.must_equal('9780747595847')
      product.attributes[:binding_description].must_equal('Paperback')
      product.language_code.must_equal('en')
      product.language_description.must_equal('Engels')
      product.url.must_equal('http://www.bol.com/nl/p/engelse-boeken/harry-potter-boxed-set/1001004006016448/index.html')
      product.rating.must_equal('5')
      product.authors.must_include('J. K. Rowling')
      product.authors.must_include('J.K. Rowling')
    end

    it 'should parse release date' do
      product.release_date.year.must_equal 2008
      product.release_date.month.must_equal 10
      product.release_date.day.must_equal 1
    end

    it 'should parse cover' do
      product.cover.must_equal('http://s-bol.com/imgbase0/imagebase/thumb/FC/8/4/4/6/1001004006016448.jpg')
      product.cover(:medium).must_equal('http://s-bol.com/imgbase0/imagebase/thumb/FC/8/4/4/6/1001004006016448.jpg')
      product.cover(:extra_small).must_equal('http://s-bol.com/imgbase0/imagebase/mini/FC/8/4/4/6/1001004006016448.jpg')
      product.cover(:small).must_equal('http://s-bol.com/imgbase0/imagebase/tout/FC/8/4/4/6/1001004006016448.jpg')
      product.cover(:large).must_equal('http://s-bol.com/imgbase0/imagebase/regular/FC/8/4/4/6/1001004006016448.jpg')
      product.cover(:extra_large).must_equal('http://s-bol.com/imgbase0/imagebase/large/FC/8/4/4/6/1001004006016448.jpg')
    end
  end

  describe 'parsing product search results' do
    let(:parser) { Bol::XmlParser.new(fixture('searchproducts-music.xml')) }
  end

  describe 'parsing product listings' do
    let(:parser) { Bol::XmlParser.new(fixture('productlists.xml')) }
  end
end