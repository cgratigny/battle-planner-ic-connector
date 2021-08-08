# Date
Date::DATE_FORMATS[:default] = "%b %e, %Y"
# Feb 19, 2021
Date::DATE_FORMATS[:week_number] = "%U"
# 19
Date::DATE_FORMATS[:date_with_day] = "%A, %B %e"
# Friday, February 19
Date::DATE_FORMATS[:full_date_with_day] = "%A, %b %e, %Y"
# Friday, Feb 19, 2021
Date::DATE_FORMATS[:short_date_with_year] = "%a, %b %e, %Y"
# Friday, Feb 19, 2021
Date::DATE_FORMATS[:short_date_with_day] = "%a, %b %e"
# Fri, Feb 19
Date::DATE_FORMATS[:short_date] = "%b %e"
# Feb 19
Date::DATE_FORMATS[:day] = "%A"
# Friday
Date::DATE_FORMATS[:year] = "%Y"
# 2021
Date::DATE_FORMATS[:php_date] = "%Y-%m-%d"

Date::DATE_FORMATS[:db] = "%Y-%m-%d"
# 2021-02-19

Date::DATE_FORMATS[:firestore_date] = "%-d-%-m-%Y"
Date::DATE_FORMATS[:simple] = "%-m_%-d_%Y"


# Time
Time::DATE_FORMATS[:default] = "%b %e, %Y, %l:%M %P"

Time::DATE_FORMATS[:default_with_seconds] = "%b %e, %Y, %l:%M:%S %P"

Time::DATE_FORMATS[:time] = "%l:%M %P"

Time::DATE_FORMATS[:time_24h] = "%H:%M"

Time::DATE_FORMATS[:short_date] = "%b %e"

Time::DATE_FORMATS[:date] = "%b %e, %Y"

Time::DATE_FORMATS[:full_date_with_day] = "%A, %b %e, %Y"

Time::DATE_FORMATS[:php_date] = "%Y-%m-%d"

Time::DATE_FORMATS[:swipe_time] = "%l:%M:%S %P on %b %e"
