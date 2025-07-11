variable "subscription_id" {
    type = string
    default = "************"
    description = "myenv subscription id"
  
}
variable "client_id" {
    type = string 
    default = "************"
    description = "my env client id"
  
}
variable "client_secret" {
    type = string 
    default = "************"
    description = "myenv client secret"
  
}
variable "tenant_id" {
    type = string
    default = "************"
  
}
variable "vm_name_pfx" {
    type = string
    default = "dev-vm-"
    description = "vm name prefix"
  
}
variable "vm_count" {
    type = string
    default = "3"
    description = "vm count"

  
}