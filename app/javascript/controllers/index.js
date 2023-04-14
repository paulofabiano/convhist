import { application } from "./application"

import ResetFormController from "./reset_form_controller"
import StatusesController from "./statuses_controller"

application.register("reset_form", ResetFormController)
application.register("statuses", StatusesController)