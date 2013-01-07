Creepin::On.new 'amazon_product' do
  
  collection do

    base_url 'http://www.amazon.com/s'
    selector '#main .rslt'
    resource_class 'Product'
    
    #note the explicit return of resource at end of block, neccessary right now but not sure why
    resource_load_strategy do |attributes_hash, resource_klass|
      resource = resource_klass.where(:external_id => attributes_hash[:external_id]).first
      if resource.present?
        attributes_hash.each_pair{|k,v| resource.send("#{k}=", v) }
      else
        resource = resource_klass.new(attributes_hash)
      end
      resource
    end
    
    resource_save_strategy do |attributes_hash, resource|
      if resource.new_record?
        resource.save
      else
        resource
      end
      resource
    end

    next_page_selector do |doc|
      doc.at_css('#pagnNextLink')[:href] if doc.at_css('#pagnNextLink').present?
    end

    define_element_mapping :title do |ele|
      ele.at_css('h3.newaps a span').text
    end

    define_element_mapping :external_id do |ele|
      ele.at_css('h3.newaps a')[:href].split('/dp/').pop.split('/').shift
    end
    
    define_element_mapping :external_url do |ele|
      ele.at_css('h3.newaps a')[:href]
    end
    
    define_element_mapping :brand do |ele|
      ele.at_css('h3.newaps span.med').text.gsub('by ', '') if ele.at_css('h3.newaps span.med').present?
    end
    
    define_element_mapping :external_provider do |ele|
      'amazon'
    end

    after :crawl_finished do |creeper|
      puts "CRAWL WAS FINISHED"
      puts creeper.total_records.inspect
    end
    
    after :collection_loaded do |creeper|
      puts "FINISHED LOADING COLLECTION, LETS UPDATE SOME SPECIFICS"
      creeper.loaded_collection.each do |resource|
        puts resource.inspect
        resource_creeper = AmazonProductResourceCreeper.new(resource)
        resource_creeper.crawl
      end
    end
    
  end
  
  resource do
    
    selector '#divsinglecolumnminwidth'
    url_attribute :external_url
    
    define_element_mapping :price do |ele|
      ele.at_css('#actualPriceValue b').text if ele.at_css('#actualPriceValue b').present?
    end
    
    define_element_mapping :description do |ele|
      ele.at_css('#productDescription .productDescriptionWrapper').text if ele.at_css('#productDescription .productDescriptionWrapper').present?
    end
    
    #clearly this is not idea for large parsing, will in future add different way of mapping for scenarios such as this
    define_element_mapping :model_number do |ele|
      if ele.at_css("#techSpecSoftlines").present?
        ele.at_css("#techSpecSoftlines").search("td").each do |node|
          node.next_element.text.strip if node.text == 'Part Number'
        end
      end
    end
    
  end
  
end

