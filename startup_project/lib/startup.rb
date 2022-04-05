require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding 
        @salaries = salaries     
        @employees = [] 
    end

    def valid_title?(title)
        @salaries.each_key.any? { |key| key == title }
    end

    def >(another_startup)
        self.funding > another_startup.funding
    end

    def hire(employee_name, title)
        if self.valid_title?(title)==false
            raise "invalid title"
        end
        @employees << Employee.new(employee_name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(employee_instance)
        employee_payment = @salaries[employee_instance.title]
        if funding > employee_payment
            employee_instance.pay(employee_payment)
            @funding -= employee_payment
        else
            raise "not enough money"
        end
    end

    def payday
        @employees.each { |employee| self.pay_employee(employee) }
    end

    def average_salary
        sum_of_salaries = 0
        employees = 0
        @employees.each do |employee|
            sum_of_salaries += @salaries[employee.title]
            employees += 1
        end
        sum_of_salaries / employees
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(another_startup)
        @funding += another_startup.funding
        another_startup.salaries.each do |key, value|
            if !@salaries.has_key?(key)
                @salaries[key] = value
            end
        end
        another_startup.employees.each { |employee| @employees << employee}
        another_startup.close
    end
end
