resource "local_file" "naming-resource-1" {
    filename = "${path.module}/resource-1.txt"
    content  = "Created a new terraform file."
}