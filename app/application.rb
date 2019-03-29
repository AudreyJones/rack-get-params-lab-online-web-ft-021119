class Application

  @@items = ["Apples","Carrots","Pears"]

  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.length == 0
        resp.write "Your cart is empty!"
      else
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
    elsif req.path.match(/add/)
      added_item = req.params["item"]
##IS the item even in our items list?

      # binding.pry
      # if @@items.!include?(added_item)
      #else
        # resp.write "We don't have that item"
      # end


      if @@cart.include?(added_item)
        resp.write "#{added_item} is already in your cart!"
      else @@cart.exclude?(added_item)
        @@cart << added_item
        resp.write "added #{added_item}"
      end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
