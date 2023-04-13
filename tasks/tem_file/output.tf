output "inventory_file" {
  value = data.template_file.inventory.rendered

}