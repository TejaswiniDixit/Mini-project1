import subprocess
import sys

def allow_ip(ip):
    subprocess.run(["iptables", "-A", "INPUT", "-s", ip, "-j", "ACCEPT"])

def block_ip(ip):
    subprocess.run(["iptables", "-A", "INPUT", "-s", ip, "-j", "DROP"])

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 rule_manager.py allow|block IP")
        exit(1)

    action = sys.argv[1]
    ip = sys.argv[2]

    if action == "allow":
        allow_ip(ip)
    elif action == "block":
        block_ip(ip)
