script -c 'bash --norc' /tmp/linux_output.txt
PS1="\u@\H:\w [\t]\$ "
date
hostname
hostname -I
uname -a
dmidecode -s system-product-name
ls -1 /dev/disk/by-id/
lsb_release --all
uptime
df -Th
mount
for i in /sys/block/*/queue/scheduler; do echo "${i}"; cat ${i}; echo; done
lscpu
cat /proc/cpuinfo
ps axfww -o 'pid,user,rtprio=PR,ni,nlwp,vsz=VIRT,rss=RES,s,%cpu,%mem,time=TIME+,start,label,args' | grep -E 'mysql|ndb'
free -m
cat /proc/sys/vm/dirty_background_bytes
cat /proc/sys/vm/dirty_background_ratio
cat /proc/sys/vm/dirty_bytes
cat /proc/sys/vm/dirty_expire_centisecs
cat /proc/sys/vm/dirty_ratio
cat /proc/sys/vm/dirty_writeback_centisecs
cat /proc/vmstat
cat /proc/sys/vm/zone_reclaim_mode
cat /proc/interrupts
mpstat -P ALL 5 6
cat /proc/meminfo
cat /proc/buddyinfo
cat /proc/slabinfo
numactl -H
numastat -m
numastat -n
numastat mysqld
numactl --hardware
numastat -m
cat /sys/kernel/mm/*transparent_hugepage/enabled
sysctl -e fs.file-max
sysctl -e kernel.threads-max
getenforce
cat /etc/selinux/config
for i in `ls /proc/sys/net/ipv4/`; do  echo $i; cat /proc/sys/net/ipv4/$i; done
echo "ifconfig @ date: $(date +'%s (%a %Y-%m-%d %H:%M:%S %Z/%:z)')"; ifconfig
cat /proc/buddyinfo
cat /proc/slabinfo
mpstat -A 1 4
grep ^Cached /proc/meminfo
grep -A 1 dirty /proc/vmstat
cat /proc/sys/vm/nr_pdflush_threads
iostat -x 1 4
vmstat 1 4
top -b -n 4 -d 1 
echo "ifconfig @ date: $(date +'%s (%a %Y-%m-%d %H:%M:%S %Z/%:z)')"; ifconfig
netstat --statistics
netstat -rn
route -n
cat /proc/buddyinfo
ps axfww -o 'pid,user,rtprio=PR,ni,nlwp,vsz=VIRT,rss=RES,s,%cpu,%mem,time=TIME+,start,args'
# List all swapping processes
printf "%6s %-30s %10s\n" "PID" "Command" "Swap"; for file in /proc/*/status ; do awk 'BEGIN{pid=0; name=""; swap="";}; /^(Pid:|Name:|VmSwap:)/ {if ($1 == "Pid:") pid=$2; else if ($1 == "Name:") name=$2; else if ($1 == "VmSwap:" && $2 > 0) swap=sprintf("%8d %s", $2, $3);}; END{if (swap != "") printf "%5d %-30s %s\n", pid, name, swap}' $file; done | sort -k 3 -n -r
ulimit -a
for pid in $(pidof mysqld) $(pidof ndbd) $(pidof ndbmtd); do echo "Limits for pid = ${pid}"; echo "========================"; echo; cat /proc/${pid}/limits; echo; echo; done
dmesg -T
egrep -i "err|fault|mysql|ndb|denied|battery|blocked" /var/log/*
exit 
