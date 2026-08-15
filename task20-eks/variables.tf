variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = "vpc-0a1834b31ba62847b"
}

variable "internet_gateway_id" {
  description = "Existing Internet Gateway ID"
  type        = string
  default     = "igw-0f39a2385b382ac4d"
}

variable "nat_gateway_id" {
  description = "Existing NAT Gateway ID"
  type        = string
  default     = "nat-0ab095cdf630692a7"
}
