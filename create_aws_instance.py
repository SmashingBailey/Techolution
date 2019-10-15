import os
import boto3
import json
import time

# using boto3 resources from boto3 docs
ec2 = boto3.resource('ec2')
ec2_client = boto3.client('ec2')

create_instances = ec2.create_instances(
     ImageId='ami-0b69ea66ff7391e80',
     MinCount=1,
     MaxCount=2,
     InstanceType='t2.micro',
     KeyName="MyEC2"
)

time.sleep(60)

describe_instances = ec2_client.describe_instances()
ip_addresses = []
#ip_dict = {'ip_addresses': ip_addresses}
for reservation in describe_instances['Reservations']:
     for instance in reservation['Instances']:
          ip_addresses.append((instance['PublicIpAddress']))
          print(instance['PublicIpAddress'])
print(ip_addresses)

#with open("ip_addresses.json", "w") as outfile:
#     json.dump(ip_dict, outfile)

os.environ['node_ip_address'] = ip_addresses[0]
proxy_pass = "http://{" + ip_addresses[1] + "}:8080"

sysmon_conf = """
server {
    listen 80;
    server_name {};

    location / {
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_pass         {};
    }
}
""".format(ip_addresses[1], proxy_pass)

if os.path.exists('./nginx/sysmon.conf'):
     os.remove("./nginx/sysmon.conf")



# Was planning on creating the instances, grabbing the IP addresses
# and passing the IPs to the configuration files for node and nginx
# docker containers. After the new docker images were built, I'd 
# run remote commands on the instances to get the continers up and 
# running on each server. I would have liked to build a bash.sh file
# that could've invoked the python script create_aws_instance.py,
# built the containers, pushed the containers to my registry, and 
# then run a final python script that would've run remote commands
# on the two instances to pull the newly built images from my repo
# and deploy them. Thank you for this opportunity. I didn't have 
# much node or nginx experience, so I learned a lot going through
# this process. I've also have some terraform, ansible, and kubernetes
# code in this repo 