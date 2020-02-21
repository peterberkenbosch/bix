require_relative "config/application"

Bix::Application.finalize!

# include Dry::Monads[:result]

input = {
  first_name: "Ryan",
  last_name: "Bigg",
  age: 32
}

create_user = Bix::Transactions::Users::Create.new
case result = create_user.call(input)
when Success
  puts "User created successfully!"
when Failure(Dry::Validation::Result)
  puts "User creation failed:"
  puts result.failure.errors.to_h
end
