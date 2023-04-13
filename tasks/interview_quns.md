* Where is Terraform Used in DevOps?
   * Terraform is a open source tool which is used to building,changing and versioning of an infrastructure safely and efficiently.It managing multi cloud provider services.
* What is IAC
   * Infrastructure as code which is used to create resources by infra provisioning through code instead of creating manual and with IAC configuration files are created which stores the data of your infrastructure so which it makes easier to edit and distribute configurations.
* What is module in terraform
   * Terraform module is set of terraform configururation files in a single directory when we want to run module from single directory is known as root module.
* What steps should be followed for making an object of one module to be available for the other module at a high level?
    * 


* What is State File Locking?
   * Terraform state file locking means which locks the state file so that it can prevents operations on a state file being performed by multiusers so once lock relesed from one user than any other user has taken lock that user perform operation and to get staate file from backend is called backend operation.It prevents state file corruption.
* What is a Remote Backend in Terraform?
   * Remote backend is used to store terraform's state remote backend so which run operations on terraform cloud by using multiple commands like `terraform init,plan,validate,apply,destroy,version,show,state..etc`.
* What is a Tainted Resource?
   * Tainted resource is used to destroy/terminate resource and recreate with modifications when we run `terraform apply`.
* Does Terraform support multi-provider deployments?
   * Yes, terraform is supports for multi-provider deployements because it is not tied and also it manages large scale insfrastructure with same configurations on mutli cloud provider service.
* Define Resource Graph in Terraform.
    * Terraform creates dependency graph by using `terraform graph` command which gives details of terraform configuration files in graphical representation. 
* How can you define dependencies in Terraform?
    * Dependencies in terraform  we can use by depends_on statement by explicity dependency so which helps to create resources based on dependency statement one after one.
* What happens when multiple engineers start deploying infrastructure using the same state file?
 * It is not possible to use state file for multiple users because terraform has `state file lock`feature so it can prevents operations from state file corruption.
* Which command can be used to preview the terraform execution plan?
    * The `terraform plan` command is used to creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.
* What is the benefit of Terraform State? What is the benefit of using modules in terraform?
* Terraform state it keeps tracks everything build in cloud which is created by infra provisioning as IAC `infrastructure as code`
so terraform state stores bindings between remote systems and resources instances specified in your configuration.









    A log file is a computer-generated data file that contains information about usage patterns, activities, and operations within an operating system, application, server or another device.