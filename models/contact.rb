class Contact
  attr_reader :first_name, :last_name, :phone_number

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @phone_number = attributes[:phone_number]
  end

  def name
    [first_name, last_name].join(' ')
  end
end
