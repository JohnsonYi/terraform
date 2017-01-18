# Terraform exercise
====

## Requirement
------
Restruct the first version, create module for reusable codes, and make codes manageable.
Instructure as code!

##Structure
------
|__README.md  
|__modules  
|  |__network  
|  |  |__network.tf  
|  |  |__vpc  
|  |  |  |__vpc.tf  
|  |  |__public_subnet  
|  |  |  |__public_subnet.tf  
|  |  |__private_subnet  
|  |     |__private_subnet.tf  
|  |__compute  
|     |__jenkins  
|        |__jenkins.tf 
|  
|__providers  
   |__cq_demo.tf  
   |__jenkins.tf
   |__terraform.tfvars

##Usage
------
cd ..../providers
terraform get
terraform plan
terraform apply
  

##Output
------
+ aws_key_pair.site_key
    fingerprint: "<computed>"
    key_name:    "cq-demo"
    public_key:  "-----BEGIN PUBLIC KEY-----\nxxxxxxxxxx\n-----END PUBLIC KEY-----"

+ module.jenkins.aws_instance.jenkins
    ami:                                       "ami-00xx0e8d"
    associate_public_ip_address:               "true"
    availability_zone:                         "<computed>"
    ebs_block_device.#:                        "<computed>"
    ephemeral_block_device.#:                  "<computed>"
    instance_state:                            "<computed>"
    instance_type:                             "t2.small"
    key_name:                                  "cq-demo"
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
    subnet_id:                                 "cq-demo-private-subnet.cn-north-1"
    tenancy:                                   "<computed>"
    vpc_security_group_ids.#:                  "1"
    vpc_security_group_ids.1200593658:         "cq-demo"

+ module.network.aws_security_group.scf_sec_group
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
    name:                                 "scf-demo_sec_group"
    owner_id:                             "<computed>"
    vpc_id:                               "${module.vpc.vpc_id}"

+ module.network.private_subnet.aws_route_table.private
    route.#:                                    "1"
    route.2975030837.cidr_block:                "0.0.0.0/0"
    route.2975030837.gateway_id:                ""
    route.2975030837.instance_id:               ""
    route.2975030837.nat_gateway_id:            ""
    route.2975030837.network_interface_id:      ""
    route.2975030837.vpc_peering_connection_id: ""
    tags.%:                                     "1"
    tags.Name:                                  "scf-demo-private-subnet.cn-north-1"
    vpc_id:                                     "${var.vpc_id}"

+ module.network.private_subnet.aws_route_table_association.private
    route_table_id: "${element(aws_route_table.private.*.id, count.index)}"
    subnet_id:      "${element(aws_subnet.private.*.id, count.index)}"

+ module.network.private_subnet.aws_subnet.private
    availability_zone:       "cn-north-1"
    cidr_block:              "130.95.1.0/24"
    map_public_ip_on_launch: "false"
    tags.%:                  "1"
    tags.Name:               "scf-demo-private-subnet.cn-north-1"
    vpc_id:                  "${var.vpc_id}"

+ module.network.public_subnet.aws_internet_gateway.public
    tags.%:    "1"
    tags.Name: "scf-demo-public-subnet"
    vpc_id:    "${var.vpc_id}"

+ module.network.public_subnet.aws_route_table.public
    route.#:                                    "1"
    route.~479445203.cidr_block:                "0.0.0.0/0"
    route.~479445203.gateway_id:                "${aws_internet_gateway.public.id}"
    route.~479445203.instance_id:               ""
    route.~479445203.nat_gateway_id:            ""
    route.~479445203.network_interface_id:      ""
    route.~479445203.vpc_peering_connection_id: ""
    tags.%:                                     "1"
    tags.Name:                                  "scf-demo-public-subnet.cn-north-1"
    vpc_id:                                     "${var.vpc_id}"

+ module.network.public_subnet.aws_route_table_association.public
    route_table_id: "${aws_route_table.public.id}"
    subnet_id:      "${element(aws_subnet.public.*.id, count.index)}"

+ module.network.public_subnet.aws_subnet.public
    availability_zone:       "cn-north-1"
    cidr_block:              "130.95.11.0/24"
    map_public_ip_on_launch: "true"
    tags.%:                  "1"
    tags.Name:               "scf-demo-public-subnet.cn-north-1"
    vpc_id:                  "${var.vpc_id}"

+ module.network.vpc.aws_vpc.vpc
    cidr_block:                "130.95.0.0/16"
    default_network_acl_id:    "<computed>"
    default_route_table_id:    "<computed>"
    default_security_group_id: "<computed>"
    dhcp_options_id:           "<computed>"
    enable_classiclink:        "<computed>"
    enable_dns_hostnames:      "true"
    enable_dns_support:        "true"
    instance_tenancy:          "<computed>"
    main_route_table_id:       "<computed>"
    tags.%:                    "1"
    tags.Name:                 "scf-demo-vpc"


Plan: 11 to add, 0 to change, 0 to destroy.