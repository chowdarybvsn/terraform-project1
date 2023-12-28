variable "project2024_vpc" {
      type = string
      default = "20.0.0.0/16"
}

variable "project2024_pubsub" {
      type = string
      default = "20.0.1.0/24"
}
variable "project2024_privsub" {
      type = string
      default = "20.0.2.0/24"
}

variable "port" {
    type = list(number)
    default = ["22","8080"]
}
