variable "region" {
    type = string
    default = "us-east-1"
    description = "Creation of the region"
  
}
variable "myvpc-info" {
    type = object({
        
        vpc-cidr = string,
        subnet-names = list(string),
        availability-zones = list(string),
        public-subnet = list(string),
        private-subnet = list(string),
    
    })
    default = {
      availability-zones = ["a","b","c","d","e","f"]
      subnet-names = ["APP1","APP2","WEB1","WEB2","DB1","DB2"]
      
      vpc-cidr = "192.168.0.0/16"
      public-subnet = ["WEB1","WEB2"]
      private-subnet = ["APP1","APP2","DB1","DB2"]
    }
}
