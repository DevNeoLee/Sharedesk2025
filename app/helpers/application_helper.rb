module ApplicationHelper
    include Pagy::Frontend
   
    def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
        type = 'success' if type == 'notice'
        type = 'error' if type == 'alert'
        text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
        flash_messages << text.html_safe if message
    end.join("\n").html_safe
    end

    def format_rating(rating)
        rating = rating || 0
        rating.to_f == rating.to_i ? rating.to_i : rating
    end
end
