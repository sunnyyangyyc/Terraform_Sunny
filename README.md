# ZeroLogix_Sunny

1.Technical Test

1.1 QA wants to quickly launch a staging environment with a certain repo code version for testing, how to implement it?
Answer:
My understanding of this quearion is ambiguous.In my previous work, if EKS wanted to define different environments, DevOps engineer would create an EKS cluster and set two namespaces, UAT and PROD. But if this problem requires us to use the same code to create an infrasturcture, then DevOps engineer can be achieved by changing the variable name or changing the tag.


1.2  Terraform remote state management, how to implement it？
Answer: 
We could use remote state management via S3 and dynamoDB. and the relative tf file is 0-provider-artifact-repo.tf and 0-provider-backend.tf in my repo.


1.3  How to control Pod-level IAM policies for security control?
Answer: 
We could use IAM Roles for Service Accounts (IRSA) to control Pod-level IAM policies for security control. IRSA allows us to make use of IAM roles at the pod level by combining an OpenID Connect (OIDC) identity provider and Kubernetes service account annotations.
There are 3 steps required to enable IRSA on EKS cluster. 
Step 1: 
Create an IAM OIDC identity provider for the cluster -> make sure the version of eksctl version.

Step 2: 
Create a Kubernetes service account and setup IAM role 
The command as follows:
eksctl create iamserviceaccount \
               --name list-iam-groups \
               --namespace blogpost-demo \
               --cluster eu-test \
               --attach-policy-arn arn:aws:iam::aws:policy/IAMReadOnlyAccess \
               --approve 
               
Step 3: Setup pods -> we should edit pods-irsa.yaml file and apply.
           

1.4  How to implement deployment strategy for version rollback
Answer: 
Normally, we could use load back pipeline to do the version rollback. but k8s provides a rollout undo functionality, it is more easy to roll back the existing deployment to any previous version. 
The command as follows:
$ kubectl rollout undo deployment/nginx-deployment

Meanwhile, we could use the below command to go ahead and check the deployment status
$ kubectl rollout status deployment/test-deploy
$ kubectl get deployment test-deploy

if we want to roll back to a specific revision tag we can use the following command
$ kubectl rollout undo deployment/test-deploy --to-revision=3

1.5  How to use Helm for deployment/service/pod templating？
Answer: 
During deployment, Helm renders templates into real Kubernetes resource files through the template engine and deploys them to nodes.
The specific steps are as follows
Step 1： 
Install Helm (Helm 3.0+)
A Kubernetes cluster

Step 2：use the folowing command to creat a chart
$ helm create pkslow-nginx

Step 3:
The quick way to deploy it is create ConfigMap template file and use the below command to deploy the template

$ helm install clunky-serval ./mychart

The result as follows:
NAME: clunky-serval
LAST DEPLOYED: Tue Nov  1 17:45:37 2016
NAMESPACE: default
STATUS: DEPLOYED
REVISION: 1
TEST SUITE: None

we could also use the command $ helm get manifest clunky-serval to check deployed yaml.file.


1.6	 How to define Pod and worker node auto-scaling？
Answer: 
Once we have Amazon EKS cluster and IAM OIDC provider for my cluster. I can use eksctl to create the node groups, these tags are automatically applied.
If I don't use eksctl, I should manually tag the Auto Scaling groups with the following tags.


2.Technical Questions
A few more DevOps engineers have joined the team. You're finding it difficult to execute terraform plan and terraform apply commands concurrently without affecting each other. 
How might you resolve this?
Answer: 
We could use the remote state file to resolve this. Once someone makes changes to the tf file, no one else can make changes.


One of the services now require a PostgreSQL database, messaging queues, and a Redis cache. 
How would you provision those resources and deploy said service without causing downtime?
Answer: 
Downtime is minimized if we enable Multi-AZ. The role of the master node will automatically fail over to one of the read replicas without the need to create and configure a new master node. For example, for RDS, we can do one master write, others read replica.
If we introduce the message queue, we can build an ActiveMQ cluster based on zookeeper and LevelDB, and the cluster can provide a high-availability cluster function in the active-standby mode to avoid single point of failure and ensure high availability.


Secrets are loaded into pods through environment variables. Clearly, this is a bad idea. Anyone with access to EKS can now inspect and immediately view them. How might you resolve this? 
Answer: 
We could put environment variables in s3 to encrypt, and take it out when we needed.
