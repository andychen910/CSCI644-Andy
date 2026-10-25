#!/usr/bin/env bash

# stop if something fails
set -e

# my gcp project
PROJECT_ID="vivid-router-421622"

# my username for the labels
OWNER="andychen910"

# names for the vms
VM1_NAME="csci644-a1-vm1"
VM2_NAME="csci644-a1-vm2"

# names for the disks
DISK1_NAME="csci644-a1-disk1"
DISK2_NAME="csci644-a1-disk2"

# name for the snapshot
SNAPSHOT_NAME="csci644-a1-snapshot"

# vm1 and vm2 need to be in different regions
ZONE1="us-west1-a"
ZONE2="us-east1-b"
REGION1="us-west1"
REGION2="us-east1"

# small machine type for this assignment
MACHINE_TYPE="e2-micro"

# use a debian 12 image
IMAGE_FAMILY="debian-12"
IMAGE_PROJECT="debian-cloud"

# labels make the resources easier to find
LABELS="course=csci644,assignment=assignment1,owner=${OWNER}"

# set the project for gcloud
gcloud config set project "${PROJECT_ID}"

# make the first boot disk
# zone tells gcp where to put it
# image family and image project choose the os
# labels are required by the assignment
gcloud compute disks create "${DISK1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}" \
  --image-family="${IMAGE_FAMILY}" \
  --image-project="${IMAGE_PROJECT}" \
  --labels="${LABELS}"

# make vm1 and use disk1 as its boot disk
# e2-micro is a small vm
# delete the disk when vm1 is deleted
gcloud compute instances create "${VM1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}" \
  --machine-type="${MACHINE_TYPE}" \
  --disk="name=${DISK1_NAME},boot=yes,auto-delete=yes" \
  --labels="${LABELS}"

# check vm1 status
gcloud compute instances describe "${VM1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}"

# make a copy of disk1
# this snapshot will be used for vm2
gcloud compute snapshots create "${SNAPSHOT_NAME}" \
  --project="${PROJECT_ID}" \
  --source-disk="${DISK1_NAME}" \
  --source-disk-zone="${ZONE1}" \
  --labels="${LABELS}"

# check that the snapshot is ready
gcloud compute snapshots describe "${SNAPSHOT_NAME}" \
  --project="${PROJECT_ID}"

# stop vm1 before making the copy
gcloud compute instances stop "${VM1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}"

# make disk2 from the snapshot
# zone2 is in a different region from zone1
gcloud compute disks create "${DISK2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}" \
  --source-snapshot="${SNAPSHOT_NAME}" \
  --labels="${LABELS}"

# make vm2 using disk2
# keep disk2 if vm2 is deleted
gcloud compute instances create "${VM2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}" \
  --machine-type="${MACHINE_TYPE}" \
  --disk="name=${DISK2_NAME},boot=yes,auto-delete=no" \
  --labels="${LABELS}"

# check vm2 status
gcloud compute instances describe "${VM2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}"

# stop vm2 so no vm is running at the end
gcloud compute instances stop "${VM2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}"

# delete the first vm like the assignment says
# quiet skips the confirmation question
gcloud compute instances delete "${VM1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}" \
  --quiet

# show the assignment vms left
gcloud compute instances list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"

# show the assignment disks left
gcloud compute disks list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"

# show the assignment snapshots left
gcloud compute snapshots list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"
