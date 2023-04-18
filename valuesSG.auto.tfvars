#----------------------Security-Group--------------------------#

#-------------------------------------BASTION--------------------------------#
ingress_bastion_rule = [
    {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    },
    {
        from_port = "8080"
        to_port = "8080"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
]

#-------------------------------------MASTER--------------------------------#
ingress_master_rule_1 = [
    {
        from_port = "6443"
        to_port   = "6443"
        protocol  = "tcp"
    },

    {
        from_port = "2379"
        to_port   = "2380"
        protocol  = "tcp" 
    },

    {
        from_port = "10250"
        to_port   = "10250"
        protocol  = "tcp" 
    },

    {
        from_port = "10257"
        to_port   = "10257"
        protocol  = "tcp"
    },

    {
        from_port = "10259"
        to_port   = "10259"
        protocol  = "tcp"
    },

    {
        from_port = "6781"
        to_port   = "6784"
        protocol  = "tcp"
    },

    {
        from_port = "6781"
        to_port   = "6784"
        protocol  = "udp"
    },
]

ingress_master_rule_2 = [
    {
        from_port = "22"
        to_port   = "22"
        protocol  = "tcp"
    },
    {
        from_port = "8080"
        to_port   = "8080"
        protocol  = "tcp"
    },
]


ingress_node_rule = [
    {
        from_port = "30000"
        to_port   = "32767"
        protocol  = "tcp"
        cidr      = ["0.0.0.0/0"]
    },
    {
        from_port = "3000"
        to_port   = "3000"
        protocol  = "tcp"
        cidr      = ["0.0.0.0/0"]
    },
    {
        from_port = "443"
        to_port   = "443"
        protocol  = "tcp"
        cidr      = ["0.0.0.0/0"]
    },
    {
        from_port = "22"
        to_port   = "22"
        protocol  = "tcp"
        cidr      = ["0.0.0.0/0"]
    },
    
    {
        from_port = "6443"
        to_port   = "6443"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "2379"
        to_port   = "2380"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "10250"
        to_port   = "10250"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "10257"
        to_port   = "10257"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "10259"
        to_port   = "10259"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "6781"
        to_port   = "6784"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "6781"
        to_port   = "6784"
        protocol  = "udp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "53"
        to_port   = "53"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    },
    {
        from_port = "9153"
        to_port   = "9153"
        protocol  = "tcp"
        cidr      = ["10.0.0.64/26"]
    }
]