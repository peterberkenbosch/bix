module Bix
  module Transactions
    module Users
      class Create
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include Import["contracts.users.create"]
        include Import["repos.user"]

        def call(input)
          values = yield validate(input)
          user = yield persist(values)

          Success(user)
        end

        def validate(input)
          create.call(input).to_monad
        end

        def persist(result)
          Success(user.create(result.values))
        end
      end
    end
  end
end
