require 'file_size_validator'
class Report < ActiveRecord::Base
	mount_uploader :photo, GenericUploader
	validates :photo, :file_size => { :maximum => 1.megabytes.to_i } 
	belongs_to :listing
	belongs_to :user


	class << self
		def solved_reports_data
			query = %{
				SELECT
					date(updated_at) as date,
					COUNT(*) as count
				FROM
					reports
				WHERE
					status = 'Resuelto'
				GROUP BY
					MONTH(updated_at)
				ORDER BY date ASC
			}

			find_by_sql(query)
	  	end
	end
end
