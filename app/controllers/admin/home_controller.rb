class Admin::HomeController < Admin::BaseController
  def index
  	authorize(self)
    @listings = Listing.all
    @best = Listing.find_with_reputation(:votes, :all, order: "votes desc").first(10)
    @worst = Listing.find_with_reputation(:votes, :all, order: "votes asc").first(10)
    @open_questions = Question.where(:status=> false).select("created_at").group_by{|r| r.created_at.month}
    @closed_questions = Question.where(:status=> true).select("created_at").group_by{|r| r.created_at.month}

    @data_adopted = Listing.find_by_sql("SELECT date(created_at) as date, COUNT(*) as count FROM listings WHERE listing_type_id = 3 GROUP BY EXTRACT(MONTH FROM created_at), created_at ORDER BY date ASC")

    @data_free = Listing.find_by_sql("SELECT date(created_at) as date, COUNT(*) as count FROM listings WHERE listing_type_id = 1 GROUP BY EXTRACT(MONTH FROM created_at), created_at ORDER BY date ASC")

    @data_inprocess = Listing.find_by_sql("SELECT date(created_at) as date, COUNT(*) as count FROM listings WHERE listing_type_id = 2 GROUP BY EXTRACT(MONTH FROM created_at), created_at ORDER BY date ASC")

    @money = Money.all.group_by{|r| r.created_at.month}

    @money_js =  Money.find_by_sql("SELECT date(spent_date) as date, sum(amount) as total FROM money GROUP BY EXTRACT(MONTH FROM spent_date), spent_date ORDER BY date ASC")

    @events_js = Event.find_by_sql("SELECT date(start_date) as date, COUNT(*) as count FROM events GROUP BY EXTRACT(MONTH FROM start_date), start_date ORDER BY date ASC")

    @questions_js = Question.find_by_sql("SELECT date(updated_at) as date, COUNT(*) as count FROM questions WHERE status = '1' GROUP BY EXTRACT(MONTH FROM updated_at), updated_at ORDER BY date ASC")

    @solved_reports = Report.solved_reports_data

  end
end
