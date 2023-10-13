module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Hi teacher #{current_user.username}!", course_path(course), class:"text-white"
      elsif course.enrollments.where(user: current_user).any?
        link_to "You are enrolled in this course.", course_path(course), class:"text-white"
      elsif course.price > 0
        link_to number_to_currency(course.price, unit:"₱"), new_enrollment_path(course_id: course.id), class: "button-style px-1 rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
      else
        link_to "Free", new_enrollment_path(course_id: course.id), class: "button-style px-1 rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
      end
    else
      link_to "Check price", course_path(course), class: "button-style rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
    end
  end

  def review_button(course, user)
    if user
      if course.enrollments.where(user: current_user).any?
        enrollment = course.enrollments.find_by(user: user)
    
        if enrollment.present? && enrollment.rating.blank? && enrollment.review.blank?
          link = link_to "Add a Review", edit_enrollment_path(enrollment), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
        else
          rating = enrollment.rating
          review = enrollment.review
    
          content = "".html_safe
          content += "Rating: #{rating} stars<br>".html_safe if rating.present?
          content += "Review: #{review}<br>".html_safe if review.present?
          content += link_to "Edit Review", edit_enrollment_path(enrollment), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    
          link = content
        end
    
        link
      end
    end
    # if current_user
    #   # if course.enrollments.where(user: current_user).any?
    #   #   if course.enrollments.where(!rating.present? || !review.present?)
    #   #     link_to "lmao", root_path
    #   #   end
    #   # end
    #   # if course.enrollments.where(user: current_user).any? && course.enrollments.all? { |enrollment| enrollment.rating.blank? && enrollment.review.blank? }
    #   #   link_to "Add a Review", edit_enrollment_path(course.enrollments.find_by(user: current_user)), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    #   # elsif 
    #   #   course.enrollments.find_by(user: current_user).rating 
    #   #   course.enrollments.find_by(user: current_user).review
    #   #   link_to "Edit Review", edit_enrollment_path(course.enrollments.find_by(user: current_user)), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    #   # end
    #   if course.enrollments.where(user: current_user).any?
    #     if course.enrollments.all? { |enrollment| enrollment.rating.blank? && enrollment.review.blank? }
    #       link_to "Add a Review", edit_enrollment_path(course.enrollments.find_by(user: current_user)), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    #     else
    #       link_to "Edit Review", edit_enrollment_path(course.enrollments.find_by(user: current_user)), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    #     end
    #   # else
    #   #   course.enrollments.find_by(user: current_user).rating 
    #   #   course.enrollments.find_by(user: current_user).review
    #   #   link_to "Edit Review", edit_enrollment_path(course.enrollments.find_by(user: current_user)), class: "button-style mt-2 rounded-lg py-1 px-1 bg-blue-200 inline-block font-medium hover:bg-blue-400"
    #   end
    # end
  end
end
