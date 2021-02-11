module DetoursHelper

	def create_pdf_url
		@setting = Setting.find_by_parameter("pdf_url")
		if( @setting.value.blank? || @detour.create_pdf_path.blank?) 
			"&nbsp;"
		else
			%q{ <a href="} + @setting.value + "/" + @detour.create_pdf_path + %q{">PDF</a>}
		end
	end

	def change_pdf_url
		@setting = Setting.find_by_parameter("pdf_url")
		if( @setting.value.blank? || @detour.change_pdf_path.blank?) 
			"&nbsp;"
		else
			%q{ <a href="} + @setting.value + "/" + @detour.change_pdf_path + %q{">PDF</a>}
		end
	end

	def cancel_pdf_url
		@setting = Setting.find_by_parameter("pdf_url")
		if( @setting.value.blank? || @detour.cancel_pdf_path.blank?)  
			"&nbsp;"
		else
			%q{ <a href="} + @setting.value + "/" + @detour.cancel_pdf_path + %q{">PDF</a>}
		end
	end
end
