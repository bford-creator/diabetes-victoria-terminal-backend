# Find an existing Stripe Customer by email.
customer = nil

unless email.empty?
  customers = Stripe::Customer.list(
    email: email,
    limit: 1
  )

  customer = customers.data.first
end

if customer
  # Update existing Customer details.
  customer = Stripe::Customer.update(
    customer.id,
    customer_params
  )

  log_info("Existing Stripe Customer updated: #{customer.id}")
else
  # Create a new Customer if none exists.
  customer = Stripe::Customer.create(customer_params)

  log_info("New Stripe Customer created: #{customer.id}")
end
