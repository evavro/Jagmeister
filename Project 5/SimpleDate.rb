#
# SimpleDate class represents a calendar date and contains methods to analyze dates.
#
# Author(s): Erik Vavro & Jim Hanley
#
class SimpleDate
  
  include Comparable, Enumerable
  
  # define some useful constants
  MIN_YEAR = 1753   # minimum allowable year in a date
  NUM_MONTHS = 12
  DAYS_WEEK = 7
  DAYS_YEAR = 365
  DAYS_LEAP_YEAR = 366
  DAYS_IN_MONTH = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  DAYS_THUS_FAR = [0, 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
  
  # define few more useful constants representing day of week
  SUNDAY = 0
  MONDAY = 1
  TUESDAY = 2
  WEDNESDAY = 3
  THURSDAY = 4
  FRIDAY = 5
  SATURDAY = 6
  
  # generates getter methods for @month, @day, and @year instance variables
  attr_reader :month, :day, :year
  
  #
  # yields @month, @day, and @year values one at a time in that order
  #
  def each
    yield @month
    yield @day
    yield @year
  end

  #
  # Initializes the instance variables @month, @day, and @year using the values
  # of parameters.
  #
  # Raises ArgumentError exception when the following is true:
  #     month, day, and year are not Fixnum type, or
  #     values of month, day, and year do not represent a valid date
  #
  def initialize(month = 1, day = 1, year = 2012)
    # Ensure that the date is valid
    raise ArgumentError.new("Invalid date") unless SimpleDate.validDate?(month, day, year)

    @month = month
    @day = day
    @year = year
  end
  
  # 
  # Defines an ordering between this SimpleDate object and other SimpleDate object.
  # Returns a negative, zero, or postive number depending on whether the receiver
  # is less than, equal to, or greater than the other object. If the other
  # object is not comparable then the <=> operator should return nil.
  #
  def <=>(other)
    return nil unless other.instance_of?(SimpleDate)
        self.hashCode <=> other.hashCode
  end
  
  #
  # Returns an integer (must be same as constants SUNDAY, MONDAY, etc.) representing
  # the day of the week for this date.
  #
  def dayOfWeek
    # Implemented using Zeller's congruence algorithm

    zellerMonth = if @month <= 2 then @month + 12 else @month end
    yearOfCentury = @year % 100
    century = @year / 100
    dayWeek = (@day - 1 + ((13 * (zellerMonth + 1)) / 5) + yearOfCentury + (yearOfCentury / 4) + (century / 4) + 5 * century) % 7
    
    # Return ISO date
    ((dayWeek + 5) % 7) + 1
  end
  
  #
  # Returns the number of days in the year of this date
  #
  def daysInYear
    SimpleDate.daysInYear(@year)
  end
  
  #
  # Returns true if this date is in a leap year, false otherwise
  #
  def leapYear?
    SimpleDate.leapYear?(@year)
  end
  
  #
  # Returns the number of days that have elapsed (including this day) since 1 January. (aka dayOfYear)
  #
  def ordinalDate
    daysTotal = 0
    
    # Loop through every month up to date and add their days
    for i in 1...@month do
      daysTotal += SimpleDate.daysInMonth(i, @year)
    end
    
    # Add how many days into month to daysTotal and return it
    return daysTotal += @day # depending on this context, this might be @day - 1
  end
  
  #
  # Returns a SimpleDate object representing the next date of this date.
  #
  def nextDate    
    newYear, newMonth, newDay = @year, @month, @day + 1

    if newDay > SimpleDate.daysInMonth(@month, @year)
      newDay, newMonth = 1, newMonth + 1
      
      if newMonth > NUM_MONTHS
        newMonth, newYear = 1, newYear + 1
      end
    end

    SimpleDate.new(newMonth, newDay, newYear)
  end
  
  #
  # Returns a SimpleDate object representing the previous date of this date or nil if
  # previous date is before the MIN_YEAR (i.e.. 1753).
  #
  def prevDate
    newYear, newMonth, newDay = @year, @month, @day - 1

    if newDay < 1
      newMonth = newMonth - 1 == 0 ? NUM_MONTHS : newMonth - 1
      newDay = SimpleDate.daysInMonth(newMonth, @year)

      if newMonth == NUM_MONTHS then newYear -= 1 end
    end

    SimpleDate.new(newMonth, newDay, newYear)
  end
  
  #
  # Returns a new SimpleDate object representing the date n days ago.
  # If n is negative, then return the date n days in the past.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysAgo(n)
    newDate = self

    return daysFromNow(n * -1) unless n > 0

    # this can probably be simplified to a closure somehow
    until n < 1 do
      newDate = newDate.prevDate
      n -= 1
    end

    newDate 
  end
  
  #
  # Returns a new SimpleDate object representing the date n days from now.
  # If n is negative, then return the date n days in the future.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysFromNow(n)
    newDate = self

    return daysAgo(n * -1) unless n > 0

    until n < 1 do
      newDate = newDate.nextDate
      n -= 1
    end

    newDate
  end 

  #
  # Returns a string representation of this SimpleDate object.
  #
  def to_s
    "#{@month}/#{@day}/#{@year}"
  end

  #
  # Returns a relatively unique hash representing a comparable date. This probably won't be used and/or should be changed
  #
  def hashCode
    @year * daysInYear + ordinalDate
  end
  
  #
  # Returns true if the given year is a leap year, false otherwise. 
  #
  def self.leapYear?(year)
    year % 4 == 0 unless (year % 100 == 0 and year % 400 != 0)
  end

  #
  # Returns the number of days in the given year.
  #
  def self.daysInYear(year)
    leapYear?(year) ? DAYS_LEAP_YEAR : DAYS_YEAR
  end
 
  #
  # Class method that returns the number of days in a month for a given year.
  #
  def self.daysInMonth(month, year)
    DAYS_IN_MONTH[month] + ((leapYear?(year) and month == 2) ? 1 : 0)
  end
  
  #
  # Class method that determines if values for month, day, and year represent a valid date.
  #
  def self.validDate?(month, day, year)
    [month, day, year].each do |p|
       raise ArgumentError.new("#{p} is not a valid date value") unless p.kind_of?(Fixnum)
    end

    # ArgumentError.new("Invalid date") and return false unless
    return false unless
        year >= MIN_YEAR and
        (1..NUM_MONTHS).include?(month) and 
        (1..self.daysInYear(year)).include?(day) and 
        (1..daysInMonth(month, year)).include?(day)
    true
  end

end   # end of SimpleDate class