class PersonalMailer < ApplicationMailer

	def personal_added record
		@personal = record
		mail(to: 'personal@crimeainfo.com', subject: "Добалены новые данные по договору #{@personal.contract_title}" )
	end

end