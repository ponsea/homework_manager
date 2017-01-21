module TasksHelper
  def importance_to_class_name(importance)
    case importance
    when 1, 2
      'importance_1_2'
    when 3, 4
      'importance_3_4'
    when 5, 6
      'importance_5_6'
    when 7, 8
      'importance_7_8'
    else
      'importance_9_X'
    end
  end
end
