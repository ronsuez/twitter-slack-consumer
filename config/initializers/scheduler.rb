require 'rufus-scheduler'

# # Let's use the rufus-scheduler singleton
# #
s = Rufus::Scheduler.singleton


# # Enviar correos para confirmar cita diariamente desde 3 
# # dias antes de las cita hasta el dia anterior o hasta que confirme
# #
s.every '1.s' do
puts "rufus hello"
end
s.every '10m' do
  Rails.logger.info "Sending reminders, it's #{Time.now}"
  system 'bundle exec rake slack:post_to_channel'
  #Resque.enqueue(PostToSlack) 
end

# # Cancelar citas Vencidas
# #
# #
# # s.every '1d'
# # s.every '1m' do
# # 	  user = Usuario.find_by(correo_electronico: "rsuez93@gmail.com")
# # 	  puts user.correo_electronico
# # 	  ReminderMailer.sample_email(user).deliver
