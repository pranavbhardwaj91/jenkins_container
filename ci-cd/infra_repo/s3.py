import boto
import boto.s3
import sys
from boto.s3.key import Key
import os

build_number=sys.argv[1]
AWS_ACCESS_KEY_ID=sys.argv[2]
AWS_SECRET_ACCESS_KEY=sys.argv[3]
JOB_NAME=sys.argv[4]
def upload_cb(complete, total):
        sys.stdout.write('.')
        sys.stdout.flush

project_dir = '/srv/jenkins/workspace/%s/war/target' % JOB_NAME

conn = boto.connect_s3(AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY)
bucket = conn.get_bucket("cicdtraining")

deploy_file = os.path.join(project_dir,"jenkins.war")
#print 'Uploading %s to Amazon S3 bucket %s' %(deploy_file, "cicdtraining")

key_name = 'jenkins.war'
path = 'pranavb/'+ build_number
full_key_name = os.path.join(path, key_name)
k= bucket.new_key(full_key_name)
print 'Uploading %s to Amazon S3 bucket %s %s' %(deploy_file, "cicdtraining/", path )
k.set_contents_from_filename(deploy_file, cb=upload_cb, num_cb=10)
k.set_acl('public-read')
