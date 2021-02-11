module LocationsHelper

	def fax(loc)
		if loc.fax_default == 1
			loc.fax_number + "&nbsp;&#0171;"
		else
			loc.fax_number
		end
	end

	def phone(loc)
		if loc.phone_default == 1
			loc.phone_number + "&nbsp;&#0171;"
		else
			loc.phone_number
		end
	end

	def email(loc)
		if loc.email_default == 1
			loc.email_address + "&nbsp;&#0171;"
		else
			loc.email_address
		end
	end

	def printer(loc)
		if loc.printer_default == 1
			loc.printer + "&nbsp;&#0171;"
		else
			loc.printer
		end
	end

end
