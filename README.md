#Terraform exercise
===
  

##Prupose
------
Coding with terraform to auto-create instances on AWS.  
Infrastructure as Code.
  

##Structure
------  
|--README.me  
|__Jenkins  
   |__main.tf  
   |__variables.tf  
   |__outputs.tf
   
##Usage
------
source ~/.aws_profile      //load the access key  
cd .../jenkins             //entry folder for tf files  
terraform plan             //Check what will be created, no action on aws  
terraform apply            //!!a real implement of the code

##Output
------
+ aws_instance.jenkins  
    ami:                                       "ami-00xxxx6d"  
    associate_public_ip_address:               "true"  
    availability_zone:                         "<computed>"  
    ebs_block_device.#:                        "<computed>"  
    ephemeral_block_device.#:                  "<computed>"  
    instance_state:                            "<computed>"  
    instance_type:                             "t2.small"  
    key_name:                                  "${aws_key_pair.auth.id}"  
    network_interface_id:                      "<computed>"  
    placement_group:                           "<computed>"  
    private_dns:                               "<computed>"  
    private_ip:                                "<computed>"  
    public_dns:                                "<computed>"  
    public_ip:                                 "<computed>"  
    root_block_device.#:                       "1"  
    root_block_device.0.delete_on_termination: "true"  
    root_block_device.0.iops:                  "<computed>"  
    root_block_device.0.volume_size:           "40"  
    root_block_device.0.volume_type:           "standard"  
    security_groups.#:                         "<computed>"  
    source_dest_check:                         "true"  
    subnet_id:                                 "${aws_subnet.demo-private-subnet.id}"  
    tenancy:                                   "<computed>"  
    vpc_security_group_ids.#:                  "<computed>"
  
+ aws_internet_gateway.demo-gw  
    vpc_id: "${aws_vpc.demo-vpc.id}"  
  
+ aws_key_pair.auth  
    fingerprint: "<computed>"  
    key_name:    "demo"  
    public_key:  "-----BEGIN PUBLIC KEY——\xxxxxxxx….xxxxxx\n——END PUBLIC KEY-----"  
  
+ aws_route.demo_internet_route  
    destination_cidr_block:     "0.0.0.0/0"  
    destination_prefix_list_id: "<computed>"  
    gateway_id:                 "${aws_internet_gateway.demo-gw.id}"  
    instance_id:                "<computed>"  
    instance_owner_id:          "<computed>"  
    nat_gateway_id:             "<computed>"  
    network_interface_id:       "<computed>"  
    origin:                     "<computed>"  
    route_table_id:             "${aws_vpc.demo-vpc.main_route_table_id}"  
    state:                      "<computed>"  
  
+ aws_security_group.demo_sec_group  
    description:                          "Defualt sec group for scf"  
    egress.#:                             "1"  
    egress.482069346.cidr_blocks.#:       "1"  
    egress.482069346.cidr_blocks.0:       "0.0.0.0/0"  
    egress.482069346.from_port:           "0"  
    egress.482069346.prefix_list_ids.#:   "0"  
    egress.482069346.protocol:            "-1"  
    egress.482069346.security_groups.#:   "0"  
    egress.482069346.self:                "false"  
    egress.482069346.to_port:             "0"  
    ingress.#:                            "2"  
    ingress.2165049311.cidr_blocks.#:     "1"  
    ingress.2165049311.cidr_blocks.0:     "10.0.0.0/16"  
    ingress.2165049311.from_port:         "80"  
    ingress.2165049311.protocol:          "tcp"  
    ingress.2165049311.security_groups.#: "0"  
    ingress.2165049311.self:              "false"  
    ingress.2165049311.to_port:           "80"  
    ingress.2541437006.cidr_blocks.#:     "1"  
    ingress.2541437006.cidr_blocks.0:     "0.0.0.0/0"  
    ingress.2541437006.from_port:         "22"  
    ingress.2541437006.protocol:          "tcp"  
    ingress.2541437006.security_groups.#: "0"  
    ingress.2541437006.self:              "false"  
    ingress.2541437006.to_port:           "22"  
    name:                                 "vpc_sec_group"  
    owner_id:                             "<computed>"  
    vpc_id:                               "${aws_vpc.demo-vpc.id}"
  
+ aws_subnet.demo-private-subnet  
    availability_zone:       "<computed>"  
    cidr_block:              "130.95.1.0/24"  
    map_public_ip_on_launch: "true"  
    vpc_id:                  "${aws_vpc.demo-vpc.id}"  
  
+ aws_vpc.demo-vpc  
    cidr_block:                "130.95.0.0/16"  
    default_network_acl_id:    "<computed>"  
    default_route_table_id:    "<computed>"  
    default_security_group_id: "<computed>"  
    dhcp_options_id:           "<computed>"  
    enable_classiclink:        "<computed>"  
    enable_dns_hostnames:      "<computed>"  
    enable_dns_support:        "true"  
    instance_tenancy:          "<computed>"  
    main_route_table_id:       "<computed>"  

  
Plan: 7 to add, 0 to change, 0 to destroy.
