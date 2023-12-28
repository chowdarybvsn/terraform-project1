
output "op-vpc" {
    value = aws_vpc.project2024.id
}

output "op-subnet" {
  value = aws_subnet.project2024_pubsub.id
}

output "op-sg" {
  value = aws_security_group.mysg.id
}