#
# SimpleDate class represents a calendar date and contains methods to analyze dates.
#
# Author(s): 
#
class SimpleDate
  
  include Comparable, Enumerable
  
  # define some useful constants
  MIN_YEAR = 1753   # minimum allowable year in a date
  NUM_MONTHS = 12
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
  # Initializes the instance variables @month, @day, and @year using the values
  # of parameters.
  #
  # Raises ArgumentError exception when the following is true:
  #     month, day, and year are not Fixnum type, or
  #     values of month, day, and year do not represent a valid date
  #
  def initialize(month, day, year)

  end
  
  #
  # yields @month, @day, and @year values one at a time in that order
  #
  def each

  end
  
  # 
  # Defines an ordering between this SimpleDate object and other SimpleDate object.
  # Returns a negative, zero, or postive number depending on whether the receiver
  # is less than, equal to, or greater than the other object. If the other
  # object is not comparable then the <=> operator should return nil.
  #
  def <=>(other)

  end
  
  #
  # Returns an integer (must be same as constants SUNDAY, MONDAY, etc.) representing
  # the day of the week for this date.
  #
  def dayOfWeek

  end
  
  #
  # Returns the number of days in the year of this date
  #
  def daysInYear

  end
  
  #
  # Returns true if this date is in a leap year, false otherwise
  #
  def leapYear?

  end
  
  #
  # Returns the number of days that have elapsed (including this day) since 1 January.
  #
  def ordinalDate
    
  end
  
  #
  # Returns a SimpleDate object representing the next date of this date.
  #
  def nextDate    

  end
  
  #
  # Returns a SimpleDate object representing the previous date of this date or nil if
  # previous date is before the MIN_YEAR (i.e.. 1753).
  #
  def prevDate

  end
  
  #
  # Returns a new SimpleDate object representing the date n days ago.
  # If n is negative, then return the date n days in the future.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysAgo(n)

  end
  
  #
  # Returns a new SimpleDate object representing the date n days from now.
  # If n is negative, then return the date n days in the past.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysFromNow(n)

  end
  
  #
  # Returns a string representation of this SimpleDate object.
  #
  def to_s
    "#{@month}/#{@day}/#{@year}"
  end
  
  #
  # Returns true if the given year is a leap year, false otherwise. 
  #
  def self.leapYear?(year)

  end

  #
  # Returns the number of days in the given year.
  #
  def self.daysInYear(year)

  end
 
  #
  # Class method that returns the number of days in a month for a given year.
  #
  def self.daysInMonth(month, year)

  end
  
  #
  # Class method that determines if values for month, day, and year represent a valid date.
  #
  def self.validDate?(month, day, year)

  end
  
end   # end of SimpleDate class

