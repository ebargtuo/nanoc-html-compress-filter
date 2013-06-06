# encoding: utf-8

class HTMLCompressFilter < Nanoc::Filter
    identifier :html_compress
    type :text
    
    def run(content, params={})
        doc = Nokogiri::HTML(content)
        
        # Optionally output parse errors found.
        if (params[:show_errors])
            errors = []
           
            doc.errors.each do |e|
                # Don't show invalid tag errors (as they flag HTML5 elements
                # "aside", "nav", etc.).
                if (801 != e.code)
                    errors << "#{e.line.to_s}: #{e} [#{e.code}]"
                end
            end
            
            if (!errors.empty?)
                puts @item.path
                errors.each do |e|
                    puts e
                end
            end
        end
        
        # Find comments.
        doc.xpath("//comment()").each do |comment|
            # Check it's not a conditional comment.
            if (comment.content !~ /\A(\[if|\<\!\[endif)/)
                comment.remove()
            end
        end
        
        doc.to_html
    end
end