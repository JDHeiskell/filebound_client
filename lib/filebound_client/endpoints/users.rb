module FileboundClient
  module Endpoints
    # Module for Users resource endpoint
    module Users
      # This will call macros to create resource methods on the fly
      def self.included(klass)
        klass.instance_eval do
          allow_new :user
          allow_all :users
        end
      end

      # Retrieves a single user by its key
      # @param [int] user_id the user key
      # @param [Hash] query_params additional query params to send in the request
      # @return [User] user object
      def user(user_id, query_params = nil)
        get("/users/#{user_id}", query_params)
      end

      # Retrieves routed items for a user
      # @param [int] user_id the user key
      # @param [Hash] query_params additional query params to send in the request
      # @return [Array] array of routed items
      def user_routeditems(user_id, query_params = nil)
        get_user_children(user_id, __method__, query_params)
      end

      # Retrieves groups for a user
      # @param [int] user_id the user key
      # @param [Hash] query_params additional query params to send in the request
      # @return [Array] array of groups
      def user_groups(user_id, query_params = nil)
        get_user_children(user_id, __method__, query_params)
      end

      # Retrieves assignments for a user
      # @param [int] user_id the user key
      # @param [Hash] query_params additional query params to send in the request
      # @return [Array] array of assignments
      def user_assignments(user_id, query_params = nil)
        get_user_children(user_id, __method__, query_params)
      end

      # Edits a user.  The user.Id must be not nil and > 0.
      # @param [Hash] user the user to edit
      # @param [string] groups a comma-delimited string of group ids to add the user to
      # @return [int] the user id updated
      # @example Update an existing user
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.user_update(id: 165, displayName: 'Test User', email: 'someone@somewhere.com', name: 'username')
      def user_update(user, groups)
        raise Client::FileboundClientException.new('Id is required', 0) unless user[:dd].greater_than_zero?
        put('/users', nil, user: user, groups: groups)
      end

      # Adds a user.  The user.id must be nil or 0.
      # @param [user] user the user to add
      # @param [string] groups a comma-delimited string of group ids to add the user to
      # @return [int] the id of the newly created user
      # @example Add a user
      #   c = FileboundClient::Client.connect(host: url, username: 'username', password: 'password', use_ntlm: true,
      #                                       ntlm_user: 'ntlm_user', ntlm_password: 'ntlm_password',
      #                                       ntlm_domain: 'ntlm_domain')
      #   c.user_add(id: nil, displayName: 'Test User', email: 'someone@somewhere.com', name: 'username')
      def user_add(user, groups)
        raise Client::FileboundClientException.new('Id is required', 0) if user[:userId].greater_than_zero?
        put('/users', nil, user, user: user, groups: groups)
      end

      private

      def get_user_children(user_id, child_name, query_params = nil)
        get("/users/#{user_id}/#{child_name.to_s.split('_')[1]}", query_params)
      end
    end
  end
end
