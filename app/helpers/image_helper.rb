module ImageHelper
  def hitchhiking_with_text(number)
    unless number.nil?
      case number
      when 0
        t('helper.trip.alone')
      when 1
        t('helper.trip.with_1')
      when 2
        t('helper.trip.with_2')
      when 3
        t('helper.trip.with_3')
      when 4
        t('helper.trip.with_4')
      when 5
        t('helper.trip.with_more_than_4')
      else
        more_than_three_people_image
      end
    end
  end

  def hitchhiking_with_image(number)
    unless number.nil?
      case number
      when 0
        alone_image
      when 1
        two_people_image
      when 2
        three_people_image
      else
        more_than_three_people_image
      end
    end
  end

  def alone_image
    image_tag("icons/alone.png", :class => 'tip', title: t('helper.one_person_hitchhike'))
  end

  def two_people_image
    image_tag("icons/two_people.png", :class => 'tip', :title => t('helper.two_people_hitchhike'))
  end

  def three_people_image
    image_tag("icons/three_people.png", :class => 'tip', :title => t('helper.three_people_hitchhike'))
  end

  def more_than_three_people_image  
    image_tag("icons/more_than_three_people.png", :class => 'tip', :title => t('helper.more_than_three_people_hitchhike'))
  end
end
