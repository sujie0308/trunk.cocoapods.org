module Pod
  module TrunkApp
    class APIController
      module AuthenticationHeaders
        # Returns the Authorization header if the value of the header
        # starts with ‘Token’.
        def authorization_header
          authorization = env['HTTP_AUTHORIZATION'].to_s.strip
          unless authorization == ''
            if authorization.start_with?('Token')
              authorization
            end
          end
        end

        # Returns the token value from the Authorization header if the header
        # starts with ‘Token’.
        def token_from_authorization_header
          if authorization = authorization_header
            authorization.split(' ', 2)[-1]
          end
        end

        # Returns the authentication token from any possible location.
        #
        # Currently supported is the Authorization header.
        #
        #   Authorization: Token 34jk45df98
        def authentication_token
          if token = token_from_authorization_header
            logger.debug("Got authentication token: #{token}")
            token
          end
        end
      end

      helpers AuthenticationHeaders
    end
  end
end