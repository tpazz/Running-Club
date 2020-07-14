class Validation
  #complexity for everything is O(N) , should not be an issue
  def self.email_validation (input)
    i = 0
    if not((input[i] >= 'a') && (input[i] <= 'z') or
    ((input[i] >= 'A') && (input[i] <= 'Z')))
      return false  #first character should only be chars
    end
    while i < input.length - 2 #part before @
      i = i + 1
      if input[i] == ';'
        return false
      end
      if input[i] == '@'
        break
      end
    end
    if i == input.length - 1
      return false
    end
    i = i + 1
    if not((input[i] >= 'a') && (input[i] <= 'z') or
    ((input[i] >= 'A') && (input[i] <= 'Z')))
      return false  #first character of second part should not be . - etc
    end
    i = i + 1
    while i < input.length - 1 #part after @
      i = i + 1
      if input[i] == ';'
        return false
      end
      if input[i] == '.' #part after .
        if not((input[i-1] >= 'a') && (input[i-1] <= 'z') or #checking last let.
        ((input[i-1] >= 'A') && (input[i-1] <= 'Z')))
          return false
        end
        if i + 2 < input.length
          for j in i+1 ..input.length-1
            if not((input[j] >= 'a' ) and (input[j]<='z' ) or #.ac.uk , .com etc
            ((input[j] >= 'A' )and (input[j]<='Z')) or
            ((j > i +1) and (input[j] =='.') and j + 2 <= input.length - 1))
                return false
            end
          end
          return true #if everything is according to the rules
        end
        return false #if there are not enough characters after '.'
      end
    end
    return false #if it didint reach the true state in the loop, then its false
  end

  def self.alphanumeric_validation (input)
    #only allows, alphanumeric input ( and spaces )
    if input.blank?
      return false
    end
    return input.match? /\A[a-zA-Z0-9" "]*\z/
  end

  def self.numeric_validation_space (input)
    #only allows, numeric input ( and spaces )
    if input.blank?
      return false
    end
    return input.match? /\A[0-9" "]*\z/
  end

  def self.numeric_validation(input)
    #numeric validation so we can use as integer
    return input.match? /\A[0-9]*\z/
  end

  def self.remove_whitespaces(input)
    #returns the string with whitespace removed
    return input.delete(' ')
  end

  def self.phone_with_whitespace(input)
    #adds a space to make the phone format 078 02709028
    new_phone = input[0,3] + ' ' + input[3,input.length]
    return new_phone
  end

  def self.date_validation (input)
    #only accepts dates of the format , 30-06-2019
    if input.length != 10 #size is wrong
      return false
    end
    if not ( (input[2] == '-' ) and (input[5] == '-') ) # / are missplaced
      return false
    end
    day = (input[0,1].to_i )
    month = (input[3,4].to_i )
    year = (input[6,9].to_i )
    if (day > 31) or ( day < 0 ) # day is wrong
      return false
    end
    if (month > 12) or ( month < 0 ) # month is wrong
      return false
    end
    if (year < 1900) or ( year > 2070) # year is wrong
      return false
    end
    return true
  end

  def self.alphabet(input)
    if !input.blank?
      return input.match? /\A[a-zA-Z" "'-]+\z/
    end
    return false
  end

  def self.password_validation (input)
    #supposing that the password of len (8) contains atleast  1 uppcaser, 1 lowercase and 1 number
    if (input.length < 8 )
      return false
    end
    uppercase = false
    lowercase = false
    numeric   = false
    for i in 0..input.length-1 #checks all the contents of the password
      if input[i] >= 'a' and input[i] <= 'z'
        lowercase = true
      elsif input[i] >= 'A' and input[i] <= 'Z'
        uppercase = true
      elsif input[i] >= '0 ' and input[i] <= '9'
        numeric = true
      end
    end
    if uppercase and lowercase and numeric #if contains all 3 requirements, true
      return true
    end
    return false
  end
end
