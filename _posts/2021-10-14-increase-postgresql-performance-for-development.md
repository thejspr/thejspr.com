---
layout: post
title: Increase postgresql performance for development
---

If you develop using postgres, an easy way to gain some speed when running tests
etc. is to tweak it's settings to use more system resources.

A great tool for this is
[https://pgtune.leopard.in.ua/](https://pgtune.leopard.in.ua/).

Input your system info and you get list ot settings back. Put those into your
config and restart the server (`sudo systemctl restart postgresql`).

To locate your postgres.conf file:

`psql -U postgres -c 'SHOW config_file'`.

To see how may CPU's you have:

`lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'`

With 16 CPU's and 26GB memory, my config looks like this:

```
# DB Version: 11
# OS Type: linux
# DB Type: web
# Total Memory (RAM): 26 GB
# CPUs num: 16
# Data Storage: ssd

max_connections = 200
shared_buffers = 6656MB
effective_cache_size = 19968MB
maintenance_work_mem = 1664MB
checkpoint_completion_target = 0.9
wal_buffers = 16MB
default_statistics_target = 100
random_page_cost = 1.1
effective_io_concurrency = 200
work_mem = 8519kB
min_wal_size = 1GB
max_wal_size = 4GB
max_worker_processes = 16
max_parallel_workers_per_gather = 4
max_parallel_workers = 16
max_parallel_maintenance_workers = 4
```
