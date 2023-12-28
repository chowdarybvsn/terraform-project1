module "VPC_project2024"{
    source = "./modules/VPC_project2024"
    project2024_vpc = "30.0.0.0/16"               
    project2024_pubsub = "30.0.1.0/24"
    project2024_privsub = "30.0.2.0/24"
}

resource "aws_instance" "jenkins" {
    ami = var.ami_image[0]
    instance_type = var.inst_type[0]
    vpc_security_group_ids = [module.VPC_project2024.op-sg]
    key_name = "alticheck"
    subnet_id = module.VPC_project2024.op-subnet    #output block in module
    tags = {
        Name = "jenkins"
    }
}


