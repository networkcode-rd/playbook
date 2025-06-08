resource "local_file" "naming-resource-1" {
    filename = "${path.module}/resource-1.txt"
    content  = "Created a new terraform file. Now updating the file."
}

resource "local_file" "naming-resource-2" {
    filename = "${path.module}/resource-2.txt"
    content  = "Creating another file of same type."
}


resource "local_sensitive_file" "naming-resource-2" {
  content  = "this is sensitive data"
  filename = "${path.module}/sensitive.txt"
}

resource "local_file" "naming-resource-3" {
    filename = "${path.module}/resource-3.txt"
    content  = "Creating another file of same type."
    count = 3
}

resource "local_file" "naming-resource-a" {
    filename = "${path.module}/resource-a-${count.index}.txt"
    content  = "Creating another file of same type."
    count = 3
}