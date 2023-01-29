resource "aws_instance" "pritunl" {
	ami = var.AMIS
	count = var.ec2_count
	instance_type = var.instance_type
	associate_public_ip_address = "true"
	vpc_security_group_ids = ["${var.ec2_sg}"]
	subnet_id = var.ec2_subnet
	key_name = var.key
	tags = {
	Name = "pritunl_webserver"
	}
    provisioner "file" {
    source = "/home/cipher/Music/smallcase_terraform/production_terraform_script/modules/ec2/pritunl_installation_script.sh"
    destination = "/tmp/pritunl_installation_script.sh"
 }
    provisioner "remote-exec" {
        inline = [
         "chmod +x /tmp/pritunl_installation_script.sh",
         "sudo bash /tmp/pritunl_installation_script.sh"
    ]   
 }
   connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("pritunl.pem")
    host = self.public_ip 
 }
 
}


