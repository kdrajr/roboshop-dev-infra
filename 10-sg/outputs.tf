output "sg_ids" {
  value = flatten(module.sg[*].sg_ids)
}


