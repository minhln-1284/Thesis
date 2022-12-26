desc "send monthly summary report"
task monthly_summary: :environment do
  AdminMailer.monthly_summary.deliver!
end

desc "Auto find association rules"
task find_association_rules: :environment do
  Recommended.test_data(2)
end
