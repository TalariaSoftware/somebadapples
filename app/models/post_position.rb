class PostPosition < ApplicationRecord
  SUFFIXES = %w[SR JR JR. JRS II III IV ESQ MR MRS MS]

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
    return "" if name_withheld?

    if non_last_names.last.in?(SUFFIXES)
      non_last_names.last
    else
      ""
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
    officer_name == "Name Withheld"
  end

  def ensure_agency
    Agency.find_or_create_by(name: agency)
  end

  def ensure_officer
    raise self.inspect if middle_names.nil?

    Officer.find_or_create_by(post_id: post_id) do |officer|
      officer.first_name = given_names.first
      officer.middle_name = middle_names.join(' ')
      officer.last_name = last_name
      officer.suffix = suffix
    end
  end

  def ensure_position
    Position.find_or_create_by(
      agency: ensure_agency,
      officer: ensure_officer,
      employment_start: employment_start,
      employment_end: employment_end,
      rank: rank,
    )
  end

  def position_params
    {
      agency: ensure_agency,
      officer: ensure_officer,
      employment_start: employment_start,
      employment_end: employment_end,
      rank: rank,
    }
  end

  private

  def non_last_names
    second_half = officer_name.split(',').last
    return [] if second_half.nil?

    second_half.split(' ')
  end
end
