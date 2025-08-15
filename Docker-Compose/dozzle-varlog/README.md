# Dozzle varlog Agent

This is a simple Alphin-based image for [Dozzle](https://github.com/amir20/dozzle) that reads all files from the `/var/log` directory on host system using `tail` and passes the file name at the beginning of the message.

### Example output

```bash
[auth.log] 2025-08-14T15:53:41.471751+03:00 hv-us-101 systemd-logind[959]: Session 539 logged out. Waiting for processes to exit.
[auth.log] 2025-08-14T15:53:41.472998+03:00 hv-us-101 systemd-logind[959]: Removed session 539.
[auth.log] 2025-08-14T15:55:01.974784+03:00 hv-us-101 CRON[3384820]: pam_unix(cron:session): session opened for user root(uid=0) by root(uid=0)
[syslog] 2025-08-14T15:57:06.731363+03:00 hv-us-101 kernel: br-cb521bee8826: port 1(vethbc4600f) entered blocking state
[syslog] 2025-08-14T15:57:06.731373+03:00 hv-us-101 kernel: br-cb521bee8826: port 1(vethbc4600f) entered forwarding state
[syslog] 2025-08-14T15:57:06.731554+03:00 hv-us-101 systemd-networkd[731]: vethbc4600f: Gained carrier
```

### Launch

```yaml
services:
  dozzle-varlog:
    image: lifailon/dozzle-varlog:latest
    container_name: dozzle-varlog
    restart: unless-stopped
    volumes:
      - /var/log:/logs
```