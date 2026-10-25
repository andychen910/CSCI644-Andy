# Assignment 1

## Goals

- Use `gcloud` commands to manage GCP compute resources
- Create a VM
- Inspect the VM status
- Create a snapshot of the VM boot disk
- Stop the original VM
- Create a second VM from the snapshot in a different region
- Inspect the second VM status
- Stop the second VM
- Delete the original VM
- Submit a repeatable shell script that performs the requested operations

## Requirements

All resource operations must be done with `gcloud` commands. Do not use the GCP web console to create, stop, snapshot, clone, or delete resources.

Create a shell script named `assignment1.sh` in the root of your course repo. The script should contain the commands in the order they should be executed.

Your script must:

- Set variables near the top for values such as project id, VM names, zones, regions, machine type, snapshot name, and disk name.
- Create the first VM.
- Show the status of the first VM using a `gcloud` command.
- Create a snapshot from the first VM's boot disk.
- Show the status of the snapshot using a `gcloud` command.
- Stop the first VM.
- Create the second VM from the snapshot in a different region than the first VM. A different zone in the same region is not enough.
- Show the status of the second VM using a `gcloud` command.
- Stop the second VM.
- Delete the first VM.
- List the remaining resources created for this assignment.

Use labels on resources you create so they are easy to find and clean up later:

    --labels=course=csci644,assignment=assignment1,owner=YOUR_NAME

Replace `YOUR_NAME` with your name or Chico State username.

At the end of the script, no VMs should be running. The second VM may remain stopped so I can inspect it if needed, but the first VM should be deleted.

## Video Recording

In addition to submitting your code to the course repo, submit a short screen recording to Canvas. Do not commit the video file to Git.

In the recording, walk through your submission and explain what each major part does. Show your `assignment1.sh` script, explain the variables and `gcloud` commands, and describe how the script creates, snapshots, clones, stops, and cleans up the VM resources.

The goal is not video production quality. The goal is to show that you understand the work you submitted and can explain the choices in your own words.

## Submission

Submit `assignment1.sh` to a branch named exactly `assignment1`.
