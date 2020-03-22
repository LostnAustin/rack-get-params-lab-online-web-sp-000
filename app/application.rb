require 'pry'
class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
binding.pry
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
    end
      elsif req.path.match(/search/)
        search_term = req.params["q"]
        resp.write handle_search(search_term)

      elsif req.path.match(/cart/)
          if @@cart.count == 0
              resp.write "Your cart is empty"
          elsif @@cart.count != 0
            @@cart.each do |i|
            resp.write "#{i}\n"
          end


      elsif req.path.match(/add/)

          item = req.params["item"]
        if @@items.include?(item)
          @@cart << item
          resp.write "added #{item}"
        else nil || !@@items.include?(item)
          resp.write "Error"
        end
      else
          resp.write "We don't have that item"
      end
        resp.finish
    end
end
# resp.write("#{item}")
# @@cart << search_term



  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
