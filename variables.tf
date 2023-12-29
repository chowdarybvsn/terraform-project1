variable "project2024_vpc" {
  type    = string
  default = ""
}

variable "project2024_pubsub" {
  type    = string
  default = ""
}
variable "project2024_privsub" {
  type    = string
  default = ""
}

variable "port" {
  type    = list(number)
  default = ["10", "20"]
}

variable "ami_image" {
  type    = list(string)
  default = ["ami1", "ami2"]
}
variable "inst_type" {
  type    = list(string)
  default = ["s1.small", "s3.small"]
}