class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)


    if req.path.match(/items/)
      path_array = req.path.split("/items/")
      path_array = path_array.reject { |element| element.empty? }
      item_name = path_array[0]

      found_item = @@items.find { |item| item.name == item_name }

      if found_item.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write found_item.price
      end

    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end
