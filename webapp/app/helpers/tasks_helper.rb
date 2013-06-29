module TasksHelper

  def task_in_calendar_view( task, year=nil, month=nil, &block )
    year ||= DateTime.now.year
    month ||= DateTime.now.month
    calendar_for year, month,
      :next_month => "&raquo;",
      :previous_month => "&laquo;",
      :yield_surrounding_days => true do |d|
      review = task.daily_review_on(d)
      if review.done?
        [ content_tag( :i, '', :class => 'icon-ok' ), :class => 'done' ]
      elsif review.need_to_be_done?
        [ 
          <<-HTML.html_safe , :class => 'undone' ]
          <div class="btn-group">
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
              <i class="icon-question-sign"></i>
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <!-- dropdown menu links -->
              <li>
                #{
                  link_to get_done_task_daily_review_path( task, review ), method: 'PUT', remote: true do 
                    '<i class="icon-ok"></i>done</a>'.html_safe
                  end
                }
              </li>
            </ul>
          </div>
          HTML
      else
        d.day
      end
    end
  end
end
