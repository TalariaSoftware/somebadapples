import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['newOfficerFields', 'newOfficerToggle']

  connect() {
    console.log(this.newOfficerFieldsTarget)
    this.newOfficerFieldsTarget.classList.add('display-none')
  }

  toggleNewOfficer() {
    if(this.newOfficerToggleTarget.checked) {
      this.enableNewOfficer()
    } else {
      this.disableNewOfficer()
    }
  }

  enableNewOfficer() {
    this.newOfficerFieldsTarget.classList.remove('display-none')
  }

  disableNewOfficer() {
    this.newOfficerFieldsTarget.classList.add('display-none')
  }
}
