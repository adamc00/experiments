### Docker swarm host update serialisation

As input to the `serial` param for a play we needed an array where each
element indicated the number of hosts to process in parallel. Furthermore
we wanted that to be 1 for each of the docker managers so they were 
processed serially and then 2 (or more) for workers. The final element
becomes the batch size for each subsequent group of hosts so it only
needed to be added once. With 3 managers the array needed to look like
`[1,1,1,2]`.

```bash
ansible-playbook playbook.yml
```
