using {com.company.hr.employeemanagement as db} from '../db/schema';

@path: '/employee'
service Employeeservice {
    entity Departments              as projection on db.Departments;

    entity CompanyLaptops           as projection on db.CompanyLaptops;

    entity Employees     as projection on db.Employees {
            *,
            virtual salaryCategory : String
        };


    entity Skills                   as projection on db.Skills;

    entity EmployeeSkillAssignments as projection on db.EmployeeSkillAssignments;

    function getActiveEmployeeCount()                 returns Integer; //reading data from Backend Sources

    action   getemployeesummary(employeeId: UUID)     returns {
        employeecode : String;
        name         : String;
        email        : String;
        department    : String;
        skillcount    : String;
        laptopstatus  : String;

    };

    

    action   blockemployee(employeeId: UUID)          returns String;

    function   getextrnalemployeeinfo(employeeId: UUID) returns String;

    action onboardEmployee(
    name : String,
    email : String,
    designation : String,
    salary : Decimal(12,2),
    departmentId : UUID
) returns Employees; 
    
}
//https://<server>:<port>/employee/
//function:only read process, no side effects, can be called from a GET request
//action: has side effects, can be called from a POST request