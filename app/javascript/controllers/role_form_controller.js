import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['newOfficerFields', 'officerSelect']

  selectOfficer() {
    if(this.officerSelectTarget.value == 'new_officer') {
      this.showNewOfficerFields()
    } else {
      this.hideNewOfficerFields()
    }
  }

  showNewOfficerFields() {
    this.newOfficerFieldsTarget.classList.remove('display-none')
  }

  hideNewOfficerFields() {
    this.newOfficerFieldsTarget.classList.add('display-none')
  }
}
