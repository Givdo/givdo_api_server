module Givdo
  module Exceptions
    class Error < RuntimeError; end

    class GamesQuotaExeeded < Error
      def errors
        [Givdo::Error.new(
          code: Givdo::GAMES_QUOTA_EXCEEDED,
          status: :method_not_allowed,
          title: I18n.t('givdo.exceptions.games_quota_exceeded.title'),
          detail: I18n.t('givdo.exceptions.games_quota_exceeded.detail')
        )]
      end
    end
  end
end
