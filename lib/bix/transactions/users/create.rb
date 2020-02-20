module Bix
  module Transactions
    module Users
      class Create
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        include Import[create_user: "contracts.users.create"]
        include Import[user_repo: "repos.user"]

        def call(input)
          values = yield validate(input)
          user = yield persist(values)

          Success(user)
        end

        def validate(input)
          create_user.call(input).to_monad
        end

        def persist(result)
          Success(user_repo.create(result.values))
        end
      end
    end
  end
end
