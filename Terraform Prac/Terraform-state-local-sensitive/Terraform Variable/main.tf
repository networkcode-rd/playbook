resource "local_file" "variable-resource-1" {
    filename = "${path.module}/${var.filename-1}.txt"
    content  = "Created a new terraform file. Now updating the file."
    count = var.count_num
}

resource "local_file" "variable-resource-2" {
    filename = "${path.module}/${var.filename-2}.md"
    content  = "Created a new terraform file. Now updating the file."
    count = var.count_num
}

resource "local_file" "variable-resource-3" {
    filename = "${path.module}/${var.filename-3}.txt"
    content  = "Created a new terraform file. Now updating the file."
    count = var.count_num
}

resource "local_file" "variable-resource-4" {
    filename = "${local.base_path}/localfile-4.txt"
    content  = "Created a new terraform file. Now updating the file."
}

locals {
  environment = "development"
  upper_case = upper(local.environment)
  base_path= "${path.module}/configs/${local.upper_case}"
}

resource "local_file" "server_file-1" {
    filename = "${local.base_path}/server.sh"
    content  = "creating a new local file with upper field.${local.environment}"
}

resource "local_file" "server_file-2" {
    filename = "${local.base_path}/server2.sh"
    content  = "New file.${local.environment}"
}

output "filename_this" {
  value = local_file.server_file-1.filename
}