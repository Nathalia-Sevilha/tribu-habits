import { Application } from "@hotwired/stimulus"
// import PhotoUploadController from "./photo_upload_controller"


const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
// Stimulus.register("photo-upload", PhotoUploadController);

export { application }
