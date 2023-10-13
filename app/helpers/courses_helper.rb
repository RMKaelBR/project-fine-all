module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Hi teacher #{current_user.username}!", course_path(course), class:"text-white"
      elsif course.enrollments.where(user: current_user).any?
        link_to "You are enrolled in this course. Keep learning #{current_user.username}!", course_path(course), class:"text-white"
      elsif course.price > 0
        link_to number_to_currency(course.price, unit:"₱"), new_enrollment_path(course_id: course.id), class: "button-style px-1 rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
      else
        link_to "Free", new_enrollment_path(course_id: course.id), class: "button-style px-1 rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
      end

    else
      link_to "Check price", course_path(course), class: "button-style rounded-lg bg-green-200 inline-block font-medium hover:text-blue-700 hover:bg-green-100"
    end
  end
end
