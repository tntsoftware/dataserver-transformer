# https://www.tntware.com/donorhub/groups/developers/wiki/how-can-my-fundraising-app-use-the-donorhub-api.aspx
# DESIGNATIONS QUERY

require_dependency "api/v1_controller"

module Api
  module V1
    class DesignationAccountsController < V1Controller
      def create
        load_designation_accounts
        send_data @designation_accounts.as_csv
      end

      protected

      def load_designation_accounts
        @designation_accounts = designation_account_scope.all
      end

      def designation_account_scope
        if current_designation_profile
          DesignationAccount.where(id: current_designation_profile.designation_account.id)
        else
          current_member.designation_accounts.distinct
        end
      end
    end
  end
end
