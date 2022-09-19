# ZeroLogix_Sunny

1.Technical Test

1.1 QA wants to quickly launch a staging environment with a certain repo code version for testing, how to implement it?

Answer
My understanding of this quearion is ambiguous.In my previous work, if EKS wanted to define different environments, DevOps engineer would create an EKS cluster and set two namespaces, UAT and PROD. But if this problem requires us to use the same code to create an infrasturcture, then DevOps engineer can be achieved by changing the variable name or changing the tag.

1.2  Terraform remote state management, how to implement it？
Answer: We could use remote state management via S3 and dynamoDB. and the relative tf file is 0-provider-artifact-repo.tf and 0-provider-backend.tf.


1.3  How to control Pod-level IAM policies for security control?

1.4  How to implement deployment strategy for version rollback
load back pipeline

1.5  How to use Helm for deployment/service/pod templating

1.6	 How to define Pod and worker node auto-scaling

2.Technical Questions
A few more DevOps engineers have joined the team. You're finding it difficult to execute terraform plan and terraform apply commands concurrently without affecting each other. 
How might you resolve this?

remote state file



One of the services now require a PostgreSQL database, messaging queues, and a Redis cache. 
How would you provision those resources and deploy said service without causing downtime?




Secrets are loaded into pods through environment variables. Clearly, this is a bad idea. Anyone with access to EKS can now inspect and immediately view them. How might you resolve this? 

Put it in s3 to encrypt, take it out when needed
