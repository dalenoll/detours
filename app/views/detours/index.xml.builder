xml.div(:class => "detourlist" ) do
  xml.timestamp(Time.now)
  @detours.each do |detour|
    xml.detour do
      xml.route(detour.route)
      xml.startdate(detour.start_date_formated)
      xml.enddate(detour.end_date_formated)
      xml.detourtype(detour.detour_type_str)
      xml.direction(detour.direction_str)
      xml.description(detour.description)
    end
  end
end
