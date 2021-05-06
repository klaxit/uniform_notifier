# frozen_string_literal: true

class UniformNotifier
  class BugsnagNotifier < Base
    class << self
      def active?
        !!UniformNotifier.bugsnag
      end

      protected

      def _out_of_channel_notify(data)
        opt = {}
        opt = UniformNotifier.bugsnag if UniformNotifier.bugsnag.is_a?(Hash)

        message = data[:title]
        message += data[:body] if data[:body]
        exception = Exception.new(message)
        exception.set_backtrace(data[:backtrace]) if data[:backtrace]
        Bugsnag.notify(exception, opt.merge(grouping_hash: data[:body] || data[:title], notification: data))
      end
    end
  end
end
