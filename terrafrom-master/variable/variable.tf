#set defult value of variable
variable "default_call" {
  default = "This is hitesh$$"
}
variable "onestep_call" {
  default = "This is value###"
}


#variables

variable "username" {
  description = "Enter username : "
}

variable "password" {
  description = "Enter password : "
}



#list variables

variable "sever_names" {
  type    = list(string)
  default = ["frontend", "backend", "db"]
}