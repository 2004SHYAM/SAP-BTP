const cds = require('@sap/cds')

module.exports = class Employeeservice extends cds.ApplicationService {

  init() {

    const LOG = cds.log('employee-service')

    const {
      Departments,
      Employees,
      CompanyLaptops,
      EmployeeSkillAssignments,
      Skills
    } = this.entities

    this.before('CREATE', Employees, (req) => {
      this.validateEmployeeData(req,LOG)
    })

    return super.init()
  }

  validateEmployeeData(req) {

    const {
      name,
      email,
      designation,
      salary
    } = req.data

    if (!name) {
      return req.reject(400, 'Employee name is required')
    }

    if (!email) {
      return req.reject(400, 'Employee email is required')
    }

    if (!email.endsWith('@company.com')) {
      return req.reject(400, 'Employee email must be a valid company email address')
    }

    if (
      designation &&
      designation.toLowerCase() === 'developer' &&
      salary < 25000
    ) {
      return req.reject(400, 'Developer salary must not be below 25000')
    }

  }

}