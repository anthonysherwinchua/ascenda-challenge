# frozen_string_literal: true

namespace :after_party do
  desc 'Deployment task: generate_suppliers'
  task generate_suppliers: :environment do
    puts "Running deploy task 'generate_suppliers'"

    Supplier.create(
      [
        { name: 'acme', url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/acme' },
        { name: 'patagonia', url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/patagonia' },
        { name: 'paperflies', url: 'https://5f2be0b4ffc88500167b85a0.mockapi.io/suppliers/paperflies' }
      ]
    )

    # Update task as completed.  If you remove the line below, the task will
    # run with every deploy (or every time you call after_party:run).
    AfterParty::TaskRecord
      .create version: AfterParty::TaskRecorder.new(__FILE__).timestamp
  end
end
