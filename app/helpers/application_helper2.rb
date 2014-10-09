module ApplicationHelper
    def replacement_empty(page_title)
      if page_title.nil?
        'test'
      else
        page_title
      end
    end

    def transcript_of_the_messages(message)
      case message
        when '1'
          'tes1'
        when '2'
          'test2'
        when '3'
          'test3'
        when '4'
          'test4'
        when '5'
          'test5'
        when '6'
          'test6'
        else
          'test7'
      end
    end

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
    end

end
