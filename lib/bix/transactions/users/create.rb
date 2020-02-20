module Bix
  module Transactions
    module Users
      class Create
        include Dry::Monads[:result]
        include Dry::Monads::Do.for(:call)

        def call(input)
          values = yield validate(input)
          user = yield persist(values)

          Success(user)
        end

        def validate(input)
          create_contract = Contracts::Users::Create.new
          create_contract.call(input).to_monad
        end

        def persist(result)
          user_repo = Bix::Repos::User.new
          Success(user_repo.create(result.values))
        end
      end
    end
  end
end
