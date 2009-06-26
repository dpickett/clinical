#thanks Rails Core!
module Clinical
  module Extensions
    module Array
      def extract_options!
        last.is_a?(::Hash) ? pop : {}
      end
      
    end

    module String
      def underscore(camel_cased_word)
        camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
      end
    end
  end
end

unless String.instance_methods.include?("underscore")
  String.send(:include, Clinical::Extensions::String)
end
unless Array.instance_methods.include?("extract_options!")
  Array.send(:include, Clinical::Extensions::Array) 
end
