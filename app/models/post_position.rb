class PostPosition < ApplicationRecord
  SUFFIXES = %w[SR JR JR. JRS II III IV ESQ MR MRS MS].freeze

  belongs_to :position

  def first_name
    return nil if name_withheld?

    given_names.first
  end

  def last_name
    return nil if name_withheld?

    officer_name.split(',').first
  end

  def given_names
    return [] if name_withheld?

    if suffix.present?
      non_last_names[0...-1]
    else
      non_last_names
    end
  end

  def middle_names
    return [] if given_names.empty?

    given_names[1..]
  end

  def suffix
    return '' if name_withheld?

    if non_last_names.last.in?(SUFFIXES)
      non_last_names.last
    else
      ''
    end
  end

  def employment_start
    return nil if employment_start_date.blank?

    Date.strptime(employment_start_date, '%m/%d/%Y')
  end

  def employment_end
    return nil if employment_end_date.blank?

    Date.strptime(employment_end_date, '%m/%d/%Y')
  end

  def name_withheld?
    officer_name == 'Name Withheld'
  end

  private

  def non_last_names
    return [] if officer_name.blank?

    second_half = officer_name.split(',').last
    return [] if second_half.blank?

    second_half.split
  end
end