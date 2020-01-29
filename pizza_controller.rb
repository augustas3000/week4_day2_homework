require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative('models/pizza_order.rb')
also_reload('./models/*')

# How this helps?
# By following this pattern, you don’t have to reinvent the wheel every time you build a new CRUD app. The routes and method names have already been decided, so you can just focus on the app itself.
# Since all CRUD apps are capable of doing the same four basic actions, these routes can be used for all your projects.

# Route - index, url - /pizza_orders, HTTP Verb - GET
# Displays a list of all pizza_orders
get '/pizza-orders' do
  @orders = PizzaOrder.all
  erb(:index)
end
# this has to go before the '/pizza-orders/:id', otherwise app broken: this route should return html page that has a form to create new pizza orders.


# Route - New, url - /pizza_orders/new, HTTP Verb - GET
# Shows form to make new pizza order
get '/pizza-orders/new' do
  # providing a form
  erb(:new)
end

# Route - Create, url - /pizza_orders, HTTP Verb - POST
# Adds new pizza order to database then redirects:
post '/pizza-orders' do
  @new_order = PizzaOrder.new(params)
  @new_order.save
  erb(:create)
end

# Route - Show, url - /pizza_orders/:id, HTTP Verb - GET
# Shows info about one of the orders, based on id
get '/pizza-orders/:id' do
  id = params[:id]
  @order = PizzaOrder.find(id)
  erb(:show)
end

# Route - Edit, url - /pizza_orders/:id/edit, HTTP VERB GET
# Shows edit form for one of the pizza_orders
get '/pizza-orders/:id/edit' do
  id = params[:id]
  @order_obj = PizzaOrder.find(id)
  erb( :edit )
end

# Route - Update, url - /pizza-orders/:id, HTTP Verb - PUT
# Update a particular pizza_order
post '/pizza-orders/:id' do
  @order_obj = PizzaOrder.new(params)
  @order_obj.update
  redirect to( "/pizza-orders/#{params[:id]}" )
end


#delete a pizza by id
post '/pizza-orders/:id/delete' do
  id = params[:id]
  @order_obj = PizzaOrder.find(id)
  @order_obj.delete

  redirect to('/pizza-orders')
end



# this route should accept post requests on pizza orders.
# then take the post parameters and then create a new pizza order
# we then save it to database:
# So now that our form is sending data back to our server, we have to define the route to accept it:


# route related to route = get '/pizza-orders/new'
# the form input as a hash, name var as keys of returned hash.
# post '/pizza-orders' do
#   # params is a hash thats given to as us part of post payload.
#   @order = PizzaOrder.new(params)
#   @order.save
#
#   erb(:create)
# end

# --------------------------------------------------------------------
# deleting





#
# post '/pizza-orders/:id/delete' do
#   # get the id of order
#   id = params[:id]
#   # find the order object using .find class method.
#   @order = PizzaOrder.find(id)
#   # delete an order object using .delete method
#   @order.delete
#   # redirect to pizza orders
#   redirect '/pizza-orders'
# end

# ---------------------------------------------------------------------
# HTTP verbs can request resources from a server
# or make changes
# editing an order:
# get '/pizza-orders/:id/edit' do
#   # get obj by id
#   # save to a global
#   id = params[:id]
#
#   @order_obj = PizzaOrder.find(id)
#   erb(:edit)
# end
#
#
# post '/pizza-orders/:id' do
#
#   puts params
#   # redirect to( "/pizzas/#{params[:id]}" )
# end
