desc "send monthly summary report"
task monthly_summary: :environment do
  AdminMailer.monthly_summary.deliver!
end
