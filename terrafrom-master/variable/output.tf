output "printname" {
  value = {
    default_call   = var.default_call
    onestep_call   = var.onestep_call
    password       = "${var.password}"
    username       = "${var.username}"
    sever_names    = var.sever_names[0]
    sever_names_db = var.sever_names[2]
  }
}
 