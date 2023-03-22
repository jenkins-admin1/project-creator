variable "data_dir" {
  type        = string
  description = "Directory relative to the target where .yaml files for projects are stored."
  default     = "projects/"
}

variable "defaults_file" {
  description = ".yaml file that stores default values for projects in target category."
  type        = string
}