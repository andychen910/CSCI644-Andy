# Assignment 1 video script

Hi, my name is Andy Chen. This is my CSCI 644 Assignment 1.

In this assignment, I used gcloud commands to create a VM, make a snapshot, create another VM in a different region, and clean up the resources.

I will first show my script and then explain each part.

## Variables — assignment1.sh lines 1 to 20

In assignment1.sh lines 5 to 20, I set the project and resource variables.

Lines 8 to 12 set the names for the two VMs, the two disks, and the snapshot.

Lines 13 and 14 set the zones. I use `us-west1-a` for the first VM and `us-east1-b` for the second VM.

Lines 15 and 16 show the two regions. These zones are in different regions, which is required by the assignment.

Line 17 sets the `e2-micro` machine type. It is a small VM and is enough for this assignment.

Line 20 creates the `LABELS` variable. It adds the course, assignment, and owner labels to the resources.

## Set the project — assignment1.sh line 22

Line 22 sets the GCP project that gcloud will use:

`gcloud config set project`

The project ID is passed through the `PROJECT_ID` variable.

## Create the first VM — assignment1.sh lines 24 to 38

In lines 25 to 30, I create the first boot disk with `gcloud compute disks create`.

The disk uses a Debian 12 image and is created in `us-west1-a`.

The `--labels` option adds the required labels.

In lines 31 to 36, I create the first VM with `gcloud compute instances create`.

The `--zone` option chooses where the VM is created.

The `--machine-type` option chooses the size of the VM.

The `--disk` option attaches the disk as the boot disk.

In lines 37 and 38, I use `gcloud compute instances describe` to show the first VM details and status.

## Create and check the snapshot — assignment1.sh lines 40 to 47

In lines 41 to 45, I use `gcloud compute snapshots create` to make a snapshot of the first VM boot disk.

A snapshot is a saved copy of a disk. I can use it to create another disk later.

The `--source-disk` option tells gcloud which disk to copy.

In lines 46 and 47, I use `gcloud compute snapshots describe` to check the snapshot.

The snapshot should have a status of `READY`.

## Stop the first VM — assignment1.sh lines 49 to 51

In lines 50 and 51, I stop the first VM with `gcloud compute instances stop`.

The VM is stopped before I continue, so it is not using compute resources while I work on the next steps.

## Create the second VM — assignment1.sh lines 53 to 66

In lines 54 to 58, I create a second disk from the snapshot with `gcloud compute disks create`.

This disk is created in `us-east1-b`, which is a different region from the first VM.

In lines 59 to 64, I create VM 2 and attach the new disk as its boot disk.

In lines 65 and 66, I use `gcloud compute instances describe` again to show the status of VM 2.

This proves that the second VM was created from the snapshot in the other region.

## Stop and delete resources — assignment1.sh lines 68 to 72

After checking VM 2, lines 69 and 70 stop it with `gcloud compute instances stop`.

Lines 71 and 72 delete VM 1 with `gcloud compute instances delete`.

The `--quiet` option skips the confirmation question.

The assignment requires the first VM to be deleted. The second VM can stay stopped so it can be checked later.

## List the remaining resources — assignment1.sh lines 74 to 83

At the end, lines 75 to 77 use `gcloud compute instances list` to list the remaining VMs.

Lines 78 to 80 use `gcloud compute disks list`, and lines 81 to 83 use `gcloud compute snapshots list`.

The final result is that VM 1 is deleted, VM 2 is stopped, and no VM is running.

That completes my Assignment 1.
