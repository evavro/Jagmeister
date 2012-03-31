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
  # Initializes the instance variables @month, @day, and @year using the values
  # of parameters.
  #
  # Raises ArgumentError exception when the following is true:
  #     month, day, and year are not Fixnum type, or
  #     values of month, day, and year do not represent a valid date
  #
  def initialize(month, day, year)
    if !(month.kind_of?(Fixnum) and day.kind_of?(Fixnum) and day.kind_of?(Fixnum)) or !(month.validDate? and day.validDate? and year.validDate?)
      raise ArgumentError.new("One or more date parameters are not valid dates")
    end

    @month = month
    @day = day
    @year = year
  end
  
  #
  # yields @month, @day, and @year values one at a time in that order
  #
  def each
    yield @month
    yield @day
    yield @year
  end
  
  # 
  # Defines an ordering between this SimpleDate object and other SimpleDate object.
  # Returns a negative, zero, or postive number depending on whether the receiver
  # is less than, equal to, or greater than the other object. If the other
  # object is not comparable then the <=> operator should return nil.
  #
  def <=>(other)
    # check year, then month, then day
    return nil unless other.instance_of?(SimpleDate)
        self.hashCode <=> other.hashCode
  end
  
  #
  # Returns an integer (must be same as constants SUNDAY, MONDAY, etc.) representing
  # the day of the week for this date.
  #
  def dayOfWeek
    # Earliest possible Gregorian calendar date.
    other = SimpleDate.new(MIN_YEAR, 1, 1)
    
    # Formula to determine day of week as an int.
    dayWeek = (daysFromNow(other) % DAYS_WEEK).next
 
    # Wrap around the day if it's a Sunday
    dayWeek != DAYS_WEEK ? dayWeek : 0
  end
  
  #
  # Returns the number of days in the year of this date
  #
  def daysInYear
    self.daysInYear(@year)
  end
  
  #
  # Returns true if this date is in a leap year, false otherwise
  #
  def leapYear?
  #  if @year % 400 == 0
  #    true
  #  elsif @year % 100 == 0
  #    false
  #  elsif @year % 4 == 0
  #    true

    # Set to true if year is a factor of 4.
  #  isleap = @year % 4 == 0;

  #  if @year % 400 == 0
  #    isleap = true;
  #  elsif @year % 100 == 0
  #    isleap = false;

   # isleap

    self.leapYear(@year)
  end
  
  #
  # Returns the number of days that have elapsed (including this day) since 1 January. (aka dayOfYear)
  #
  def ordinalDate
    daysTotal = @day
    
    # Loop through every month up to date and add their days
    for i in 1..@month do
      daysTotal += daysInMonth(i, @year)
    end
    
    # Add how many days into month to daysTotal and return it
    daysTotal
  end
  
  #
  # Returns a SimpleDate object representing the next date of this date.
  #
  def nextDate    
    # TODO: Change this to use daysFromNow(1)
    #newYear, newMonth, newDay = @year, @month, @day + 1

    if newDay > daysInMonth(@month, @year)
      newDay = 1
      
      if newMonth += 1 > NUM_MONTHS
        newMonth = 1
        year += 1
      end
    end

    SimpleDate.new(newMonth, newDay, newYear)
  end
  
  #
  # Returns a SimpleDate object representing the previous date of this date or nil if
  # previous date is before the MIN_YEAR (i.e.. 1753).
  #
  def prevDate
    # TODO: Change this to use daysAgo(1)
    newYear, newMonth, newDay = @year, @month, @day - 1

    if newDay < 1
      newMonth = newMonth - 1 == 0 ? NUM_MONTHS : newMonth -1
      newDay = daysInMonth(newMonth, @year)
    end

    SimpleDate.new(newMonth, newDay, newYear)
  end
  
  #
  # Returns a new SimpleDate object representing the date n days ago.
  # If n is negative, then return the date n days in the past.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysAgo(n)
    #monthsLost = Integer(n % NUM_MONTHS)
    #yearsLost = Integer(monthsLost % NUM_MONTHS)
    #newDay = ?

    newDate = SimpleDate.new(newMonth, newDay, newYear)

    # this can probably be simplified to a closure somehow
    until n < 0 do
      newDate = newDate.prevDate
    end

    newDate 
  end
  
  #
  # Returns a new SimpleDate object representing the date n days from now.
  # If n is negative, then return the date n days in the future.
  # Raise ArgumentError if the new date is before the minimum allowable date (1/1/1753).
  #
  def daysFromNow(n)
  
    #TODO

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
    @year * daysInYear(@year) + ordinalDate
  end
  
  #
  # Returns true if the given year is a leap year, false otherwise. 
  #
  def self.leapYear?(year)
    @year % 4 == 0 unless (@year % 100 == 0 and @year % 400 != 0)
  end

  #
  # Returns the number of days in the given year.
  #
  def self.daysInYear(year)
    leapYear? year ? DAYS_LEAP_YEAR : DAYS_YEAR
  end
 
  #
  # Class method that returns the number of days in a month for a given year.
  #
  def self.daysInMonth(month, year)
      DAYS_IN_MONTH[month] + (isLeapYear? year and month == 2 ? 1 : 0)
  end
  
  #
  # Class method that determines if values for month, day, and year represent a valid date.
  #
  def self.validDate?(month, day, year)
    year >= MIN_YEAR and month 1..NUM_MONTHS and day 0..daysInYear
  end
  
end   # end of SimpleDate class

