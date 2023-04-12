# Hillock kernel for Alpine Linux in Qubes OS

## Abstract
Lightweightness is a fundamental property and goal to achieve in many virtualisation environments, especially considering multi-level secure desktop OSs (like [Qubes OS](https://www.qubes-os.org/)), serverless computing or embedded virtualisation. Focusing on multi-level secure systems application, operating systems achieve better isolation through compartmentalising processes in different virtual machines, which implies long wait times and inefficiencies. The project aims to achieve “lightweightness” (better boot up times, reduced memory and disk footprint) and reduce the high demand for resources required to run an entire OS system. We present Hillock – a highly optimised x86 monolithic kernel tailored for the [Qubes OS](https://www.qubes-os.org/) secure desktop environment, running on top of the Xen hypervisor.

Hillock has been developed through an iterative process, where non-required configuration, modules, and drivers were removed. Afterwards, the kernel was tested against the most common alternatives in the [Qubes OS](https://www.qubes-os.org/) environment, including the [Qubes OS](https://www.qubes-os.org/) PVH templates, Debian minimal (PVH) or [Alpine Linux](https://www.alpinelinux.org/) (HVM). More than 650 boot ups of different configurations were recorded to check Hillock’s improvement. Finally, our kernel was proven to be 1.29 times faster than the fastest alternative (Debian Minimal PVH) and 1.80 times lighter than the lightest alternative ([Alpine Linux](https://www.alpinelinux.org/)), becoming a starting point for further research.

## Repository structure 
### Hillock Kernel
Contains the final configuration file to install the Kernel (.config_Hillock) and the script to install Hillock in an automated way. Inside Hillock config file folder, there is guidance to manually install the system.

### Dissertation
Contains a pdf version of the paper which covers the development process.

### Results and Measurements
Contains all the benchmarking results data (highlight TestData.xlsx file) and all the graphs developed for the project.

![Comparing Hillock](https://github.com/SergioMiguez/Hillock/blob/main/Results%20and%20Measurements/Results%20-%20Graphs/total_time_boot_up_compare_xen_reduced.png)

### Custom Kernel Development
Contains all the kernel iterations developed in the process and the scripts developed to do the benchmarking.

### Qubes OS - VM managing scripts 
Contains the scripts used to automate the creation, cloning and deletion of VMs

----
update_repo.sh is a develop script to update and export the github repository from dom0 (with no internet) to anothoer qube with connection.  

