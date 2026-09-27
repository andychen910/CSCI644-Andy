#!/usr/bin/env bash

set -e

# Project and resource settings
PROJECT_ID="vivid-router-421622"
OWNER="andychen910"
VM1_NAME="csci644-a1-vm1"
VM2_NAME="csci644-a1-vm2"
DISK1_NAME="csci644-a1-disk1"
DISK2_NAME="csci644-a1-disk2"
SNAPSHOT_NAME="csci644-a1-snapshot"
ZONE1="us-west1-a"
ZONE2="us-east1-b"
REGION1="us-west1"
REGION2="us-east1"
MACHINE_TYPE="e2-micro"
IMAGE_FAMILY="debian-12"
IMAGE_PROJECT="debian-cloud"
LABELS="course=csci644,assignment=assignment1,owner=${OWNER}"

gcloud config set project "${PROJECT_ID}"

# Create the first disk and VM
gcloud compute disks create "${DISK1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}" \
  --image-family="${IMAGE_FAMILY}" \
  --image-project="${IMAGE_PROJECT}" \
  --labels="${LABELS}"
gcloud compute instances create "${VM1_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE1}" \
  --machine-type="${MACHINE_TYPE}" \
  --disk="name=${DISK1_NAME},boot=yes,auto-delete=yes" \
  --labels="${LABELS}"
gcloud compute instances describe "${VM1_NAME}" \
  --project="${PROJECT_ID}" --zone="${ZONE1}"

# Create a snapshot of the first VM's boot disk
gcloud compute snapshots create "${SNAPSHOT_NAME}" \
  --project="${PROJECT_ID}" \
  --source-disk="${DISK1_NAME}" \
  --source-disk-zone="${ZONE1}" \
  --labels="${LABELS}"
gcloud compute snapshots describe "${SNAPSHOT_NAME}" \
  --project="${PROJECT_ID}"

# Stop the first VM
gcloud compute instances stop "${VM1_NAME}" \
  --project="${PROJECT_ID}" --zone="${ZONE1}"

# Create a disk from the snapshot in a different region
gcloud compute disks create "${DISK2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}" \
  --source-snapshot="${SNAPSHOT_NAME}" \
  --labels="${LABELS}"
gcloud compute instances create "${VM2_NAME}" \
  --project="${PROJECT_ID}" \
  --zone="${ZONE2}" \
  --machine-type="${MACHINE_TYPE}" \
  --disk="name=${DISK2_NAME},boot=yes,auto-delete=no" \
  --labels="${LABELS}"
gcloud compute instances describe "${VM2_NAME}" \
  --project="${PROJECT_ID}" --zone="${ZONE2}"

# Stop VM 2 and delete VM 1
gcloud compute instances stop "${VM2_NAME}" \
  --project="${PROJECT_ID}" --zone="${ZONE2}"
gcloud compute instances delete "${VM1_NAME}" \
  --project="${PROJECT_ID}" --zone="${ZONE1}" --quiet

# Show the resources left for this assignment
gcloud compute instances list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"
gcloud compute disks list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"
gcloud compute snapshots list \
  --project="${PROJECT_ID}" \
  --filter="labels.assignment=assignment1"
