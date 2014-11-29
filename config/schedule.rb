every 1.day, :at => '9:00 pm' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every 1.minute do
	command "echo 'hello im cron mazafaka'"
end