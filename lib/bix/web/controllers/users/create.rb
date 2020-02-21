module Bix
  module Web
    module Controllers
      module Users
        class Create
          include Hanami::Action
          include Import[create_user: "transactions.users.create"]
          include Dry::Monads[:result]

          def call(params)
            case result = create_user.call(params.to_h)
            when Success
              self.body = result.value!.to_h.to_json
              self.status = 200
            when Failure(Dry::Validation::Result)
              self.body = { errors: result.failure.errors.to_h }.to_json
              self.status = 422
            end
          end

        end
      end
    end
  end
end
